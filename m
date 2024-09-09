Return-Path: <linux-kselftest+bounces-17544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82FB972215
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 20:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208191C238F4
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 18:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC569189916;
	Mon,  9 Sep 2024 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nU1/hJML"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B6014B06C;
	Mon,  9 Sep 2024 18:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725907816; cv=none; b=WCiZbrxDHLLQRc1zj9dPR+ZDe6nWWYH2jMB4+qcQCtJb3WWq92fVQVwXRkAp1xLbs+wWoR5XaMk/dL8SQUGV/uuZlPmLdG+/LnXjmQ9N9od1gnAGMsEorHSDRin1GyAPcDusx1hOB9r+oPC4lGATYPuSHtNkyMzfkCggGU7SM0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725907816; c=relaxed/simple;
	bh=E9QvcpCK/AczsQKiUIKx4WlGhSu8jNlkE7CliIwoHyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBkK2BfP7M77Pzkpt0jydDLjlmXfBCKay5JOZX5C1a97UHaV8aLCPyr+pWJOGWLshsysikAGmliUr14ih/SDOAg0+6uEl5FFFSF6y5PGCocl2xsOe0GwgPfu54XkVVUesA09fmOgARcWL3t8/q2owGoFdXpW5s26BaySjfS/+3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nU1/hJML; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a8d404c7634so220609566b.3;
        Mon, 09 Sep 2024 11:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725907813; x=1726512613; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E9QvcpCK/AczsQKiUIKx4WlGhSu8jNlkE7CliIwoHyo=;
        b=nU1/hJMLYU0w70lsmFb2diXhLoQEweyKDhKTqOpFjNyTULKJWk5//61lu2xh7j+ljg
         YTVHowtfAPXeI+8Yn7VFLMyFtGfJFYNWi65Z+E7vE1gRFPKHSpD3uJXM9iMEPkaeQCOD
         HCkwicfXK3CxSTx4KBqjqw7M0EykCg4GcEsXqK7XajH29EyWP3m0oynyPMeP5mzWHmsn
         kV169e8bJqaZ3PlyLGjoobj7U9hIgTZRojOhBWTl9yS2ayOMoQKNHP7bd1AiIFsRTPhO
         eWxu+Hy1dDuxoUEerwKKao6MaNb5EeqboB2cVP5EvEejGCY6jQEniV/ZbPjs4NEoRprJ
         kMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725907813; x=1726512613;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E9QvcpCK/AczsQKiUIKx4WlGhSu8jNlkE7CliIwoHyo=;
        b=ariCAzaKG/ZNGv3lsmS0fo0XLjp/77i9NvJzakDwwPZ96c5qHak/v9AvcOEDqzhJ3S
         KOdSfwm8dJ6D8YF9bP84MNp3knf6jjj0oF31/dcXlyEDwcV/98k0cGQm6PZoZxEIl8ZM
         Lypzm3JHckxD9Dg8hTiuWtMDMUPRzovwGTrvD/g8k83Q8dTw8wvoiTmUDDe9Zalb/y7R
         y82XVE16DVpmA+wEHWkwKVZRViDEZrc8pfS6mHHmDS9Bqz5UIfdVX4KyvNXC02yKSJWr
         bOFNaQYYSY7KdqgFri8zAbmPM01/TYCRHfQ/jNbPRqaEByTkxn8T4YnFZ8c9yzfivEo+
         tq7g==
X-Forwarded-Encrypted: i=1; AJvYcCU4CZW2T7Nm+EYdfpcrjHXggPP/OewGmnDJLbgULDA7Ck4fwhRgau+q9rXlxYQYUBVnPGSt5KTMGtsWM1l3xp1X@vger.kernel.org, AJvYcCV5n3Wef2pT+buLoxB7HKlG3GtHVSUJNOjgCdmEb0QYvVtr4d7s4t5m0PyPrO9fMx6Ilss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0uMaNpqbbpFPXlQNaqnLxS5DbOnxVspdNd6hT0RJ8GVtNQSPc
	JWlWXMHG88mDE/6HPFZd2naMXrWp7FfG7uOXA1Szz77gnr1rBhxiVBXedCDHgXCxTJBQWxuv53l
	cWh7OiY6ztfOaDGdchGKtYLm6hgU=
X-Google-Smtp-Source: AGHT+IGRvYurTlg+hKN2TFEclUHFiO8OC7Fk/k9mCgZqjE12/fkQkXGXcKWfVAJqMHHRl9GdYyP9cw0Ckd/gi2bok9Q=
X-Received: by 2002:a17:906:c156:b0:a8d:4631:83b0 with SMTP id
 a640c23a62f3a-a8d46318711mr474421266b.5.1725907813142; Mon, 09 Sep 2024
 11:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909133909.1315460-1-maxim@isovalent.com>
In-Reply-To: <20240909133909.1315460-1-maxim@isovalent.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 9 Sep 2024 20:49:36 +0200
Message-ID: <CAP01T75fUTwyM_0c6c6CD9mcMqgnMqvbfjrKRFEvrVs+pdHm1w@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix error message on kfunc arg type mismatch
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Maxim Mikityanskiy <maxim@isovalent.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Andrei Matei <andreimatei1@gmail.com>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Sept 2024 at 15:39, Maxim Mikityanskiy <maxtram95@gmail.com> wrote:
>
> When "arg#%d expected pointer to ctx, but got %s" error is printed, both
> template parts actually point to the type of the argument, therefore, it
> will also say "but got PTR", regardless of what was the actual register
> type.
>
> Fix the message to print the register type in the second part of the
> template, change the existing test to adapt to the new format, and add a
> new test to test the case when arg is a pointer to context, but reg is a
> scalar.
>
> Fixes: 00b85860feb8 ("bpf: Rewrite kfunc argument handling")
> Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

