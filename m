Return-Path: <linux-kselftest+bounces-17535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D7D972126
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 19:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FDF5B23DEC
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 17:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2637D187FE4;
	Mon,  9 Sep 2024 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFvTgmAx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EA917C9B9;
	Mon,  9 Sep 2024 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903332; cv=none; b=e/nMYyyjKSAAhhDb7dj5+hHAtAEYnVjw+Xgbxx88W1ze2SybozBPnoyDQHyzRY9LYSAJbk2c8SXf+pc8hPVpzqVyjMJhhvpJ/bdlGGf45K7H7be2y5DdFjiVmrxssyZm8YFm51AUhyuxNpc3FvRtrAy53mSiPOZ2XrGvUTU4goM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903332; c=relaxed/simple;
	bh=gvsWziE2jYa8kjg2nfOxDm1DWMv6Qvm8tVYqhtudBH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nb44M3Z0eT3p4P5c4TmxEvVBkf/GmRAuxpS8og6ijnt/nIgOhNuhtARDbVdhIAnHtc9MX2sp4GGUS/ZPhJivdR4MIAFbx2TPTfcNgHHS+70wj14EnuVGZn50Ezcuj8guW8XM07fUtNABxOvQGO6DHIlW+fw5g2CAzy1VuQszID8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFvTgmAx; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-374c1120a32so2690392f8f.1;
        Mon, 09 Sep 2024 10:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725903329; x=1726508129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvsWziE2jYa8kjg2nfOxDm1DWMv6Qvm8tVYqhtudBH0=;
        b=JFvTgmAxPn3KhMPZUSOxPspLIH30VZaBsplq4fRC1zSCQyc+b/aj+BRzA16/yCLAUA
         MhUScQ2GB+ObnasIMJlY9Bn0TJHTaf314VfJC+7Y3c3uMYznoYylBvJC//uvOOcjCpBn
         8pnGaE1qTPrImyKZ9poT4JVaIUO8U3PFxzHjtQZPeb0NR0nu34GHQjDRl0NZkdM7sWvl
         8z6EEwmLm7gLtrWPxLhzfHIDQefznG2gZjSPJLolWWdJcI5UVLMKWqHqVUhk1rDTb4QV
         WqByRNHUMSHfgbHSQ+/XP9g9sZqSO3lJkh8GNoGglPVuUg4BfNdk7UZvKjDFVeMhi2/c
         Z3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725903329; x=1726508129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvsWziE2jYa8kjg2nfOxDm1DWMv6Qvm8tVYqhtudBH0=;
        b=vbpBwHDou1Dvr+Vo5GXkzDMd9xjqZ9QJdI3EgyX4+A8/t/bKCClLqRSLABW2vOGoc2
         spMSvg7daQZLpo6nFAlq/5IcjR4C+bAG8mTw3Q7BnqLME6pit2kovT1JCxC+a0zbAKzY
         Gk6wLHht35M+YhbtxQBiZ7VjR6h6IQMQoGUCKT3HIdVIg1my9jPWCWUxqS2rjgkiZBj/
         K2Q0S5+RRzeFQ3bk2hwQHtCcckZLQY6W0XuuQ3VlYY+Nma2OFCyWmOsZk1Tt2nrj89vi
         Zve5oY6mgaEbTlT4lOuwEDo3VXVdCmDDjIG0RxM5FFTI24pFivE17vYBpHVpW12zS7AB
         jLOA==
X-Forwarded-Encrypted: i=1; AJvYcCUFEadIeUZ9Svl4u9f/w7psTLHwLjjfcJJeGo1dHxpjxDsfTf+ei7Xtg4CtblVLOPN8Tq7hOGucdS2l9F8JzrFZ@vger.kernel.org, AJvYcCWZrPUsGVuSZgOJavoVFQQ0trFB4sFLuXxZkBMbTKz/zHxSKU+4t7EHBNwZh1GvpfgVZ8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNuCtGny+Us43WZb8oBivmv8h0bnPl5i3VDaF+gY2ndBWHqPRd
	UkfB4g1uccI3OR3M1FcirUiOr0k5g1FcZGHD7j87MY0vt+63KpPPWVsaWX1b1YP+hOEin3lg5eh
	qwdjP5K7JVTDzEo1EymSRrdPeHHY=
X-Google-Smtp-Source: AGHT+IGIK9GpPz8CeYtYiNHR6ARSFwIbuLdpdSRteRlvsX0HElhTofwuHcwRp+y6o2T9OPE4gKqH8bxFmBlhVLkfTnU=
X-Received: by 2002:a5d:40d0:0:b0:374:b97b:c69 with SMTP id
 ffacd0b85a97d-378896a4166mr7481419f8f.48.1725903328599; Mon, 09 Sep 2024
 10:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909133909.1315460-1-maxim@isovalent.com>
In-Reply-To: <20240909133909.1315460-1-maxim@isovalent.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Sep 2024 10:35:17 -0700
Message-ID: <CAADnVQL8QQj7SNtC8fBNPpXVNYYVMnEq3P0bs82C=0G1822=dg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix error message on kfunc arg type mismatch
To: Maxim Mikityanskiy <maxtram95@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
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
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 6:39=E2=80=AFAM Maxim Mikityanskiy <maxtram95@gmail.=
com> wrote:
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

Kumar,

please review.

This is bpf-next material. fwiw.

