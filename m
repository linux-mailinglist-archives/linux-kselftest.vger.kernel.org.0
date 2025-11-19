Return-Path: <linux-kselftest+bounces-46028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B487C71678
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 23:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8DE434ED4C
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 22:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FCC3203B6;
	Wed, 19 Nov 2025 22:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="at85dKXL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E28730504D
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 22:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763593129; cv=none; b=V4/y+gzYhYnrMWIeEAD7iB0uVzIH/QaJ8jDj3va1pCUn06U9F3xnCJ4eX7KGsz8Xk1IwklGWnm8OQ2bcFMzJyXoukWX3pCzVqklN+wAkoYGhpD+hty0PGhP3CJxv88teucsUu37ZGYp5yGx04M7U/lPzs7Wcv/I2BsdiPXe5Aeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763593129; c=relaxed/simple;
	bh=f2l5MkKNSF6v8HTpthCW9c0REcYxtwaiNPwhFd/gKsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUEgsOyLY7uaNxqdBSBL+Og+jqg7tEIoTNxURVhfaOqdYT8FmT+3emgI+RN9Oo8vPCmdnn0T5g6/4mpqMQE6hZzI2Spn7HWTYn1oHRW74lI7c0n7KBIYDehd0hJN//64VAUoj+JgDPLc7KZhe0THn0vxRLfmlTDEpU8QE0+2ilw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=at85dKXL; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-640d43265c3so39256d50.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 14:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763593125; x=1764197925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2l5MkKNSF6v8HTpthCW9c0REcYxtwaiNPwhFd/gKsY=;
        b=at85dKXLFmwm0KYJmh7+JqEt1Y9DRGf2x2iFegbBk7ak4T3eQ6QWZeGkMurNjkGlpM
         jLw7XfjyjClDMv74r9dTYztEeSBnDkKj9Qgd29Zl7hatVH0/yyjrReKBbW6JoS2rUZdQ
         PIUAEMgxTdxEMT1lO0R2fBtFNnS1bDvx5iso6zZYpGjf+cs4uj5K5yrF4xWqOLWVOJLs
         7WO1HEcsxQH3shGT3b7/WtiE65K9NNl8C6Rbsyq7h8UK0Jv+pRVnplBIJS0qwP8/b7ok
         9fyeOlMfbCFvk0vADUqSzm+y8w3OvuN6cCTLfEn/5EVGlrFcOeH02yuv+HSJbsiV9bKD
         Kpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763593125; x=1764197925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f2l5MkKNSF6v8HTpthCW9c0REcYxtwaiNPwhFd/gKsY=;
        b=kz13eIXnDb416SvPkrKlJA2HD23hR6i/o5PzFOVJKNCMAwB07rzZCCA/UmNf/iBd7S
         IQfY4oQ7E4TWapeHLXSXlGcWMnezD8oLwEi4ikj68qqAlScKgXpEqIQNdDJgN5ZW5pyu
         yOp5ls2hhXkjVwSXi3Pdpr3GzhdDbcVp7VffX+BGg2MDeVhn3nh8f8uijideev4WXKt+
         NeVf7cEjNJkY6egiDZfjWafPv1TBABZjwxr7tA5oJygXWTmEirC8PBYidiIwO9VJ5/TN
         UQc3ODymqLp1z0XbT/RgtrDWCqhT6DmpXUv1/ST3k9bvSTV3BrkaOrcjA8H74kWsxCGF
         A9tw==
X-Forwarded-Encrypted: i=1; AJvYcCVFnU76wZ3qv4hCZLpm3Ol/Y2dSqKmcB6DM8sD3SkgJJ2ZlC5hWEY3/02lBhRLscIK6DU2V7ikDv5bNpaSfxrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdDuxA2LunJNkkWoHRqqBIjvIDf8UgneHqowfNd2t+kVr+UU/L
	IW3sjbcvrBNMeb0eNaHe2VSLLz5K+DGHMLTNT4AtvjSEzS7ueK3noKNYwlEWFz6yUIDH7xMhZxR
	gNdb+5UpcPUjoL4SPAooiM2p+G66++gU=
X-Gm-Gg: ASbGncutiSfVok2DlUTjkiKsSinrmNJl2UdOQO3luUqK5iLu489OaSFUzOiZwZhekOp
	LAaajxYVk5dpq9hdHjrkKkaW3L4BK2eY935LMh0NX7X9zLkeK8xbuahv/DUDI3vJ5KMHYgccKJ/
	N1eBs3rOX83RmhdsWKJIvqpfnvz3v3EXDUZtLn088VWSn3OgM/mWkbOrcP06j6GGIPpUKaW9fTy
	T8MpAwC8yT1pQ9dF/te0Yf/kQNdU//uGMOsdE/Hvn8SiVAoozhKpM6pq04vbXAI1zy2mRu/wrC3
	AE+lxIWZYa8qN0kk+jsQymoGHPQ5NJA=
X-Google-Smtp-Source: AGHT+IFIbdlD0slMDf0ec9/PDny5wf8Cs5EBojHNy7+PN47moxCbujYhgeKqvmUnVr7j4rMEgn4Rfe7CinYPHNqGi6g=
X-Received: by 2002:a05:690c:d:b0:787:deea:1b85 with SMTP id
 00721157ae682-78a796139f6mr7902247b3.7.1763593125345; Wed, 19 Nov 2025
 14:58:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-netconsole_dynamic_extradata-v2-0-18cf7fed1026@meta.com>
 <20251113-netconsole_dynamic_extradata-v2-4-18cf7fed1026@meta.com> <v4xuuka7oovpcmcw4ualj5mdhw6jlgtcdheybbwtuy7qhd6nyd@3kav6dwkkdac>
In-Reply-To: <v4xuuka7oovpcmcw4ualj5mdhw6jlgtcdheybbwtuy7qhd6nyd@3kav6dwkkdac>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 19 Nov 2025 22:58:34 +0000
X-Gm-Features: AWmQ_bkblqT4UnsE6iXRexrupNu4V6Dl9BSuZjWsv7DfjnR_A5WtYtp478fk8Kc
Message-ID: <CAGSyskU2awfHd4JCFysCJ=Gf8z2tj_oZRZ4TD3_=K2KRuM=U1g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/4] netconsole: Increase MAX_USERDATA_ITEMS
To: Breno Leitao <leitao@debian.org>
Cc: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 1:07=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Thu, Nov 13, 2025 at 08:42:21AM -0800, Gustavo Luiz Duarte wrote:
> > Increase MAX_USERDATA_ITEMS from 16 to 256 entries now that the userdat=
a
> > buffer is allocated dynamically.
> >
> > The previous limit of 16 was necessary because the buffer was staticall=
y
> > allocated for all targets. With dynamic allocation, we can support more
> > entries without wasting memory on targets that don't use userdata.
> >
> > This allows users to attach more metadata to their netconsole messages,
> > which is useful for complex debugging and logging scenarios.
> >
> > Also update the testcase accordingly.
> >
> > Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
>
> Reviewed-by: Breno Leitao <leitao@debian.org>
>
> Please expand netcons_fragmented_msg.sh selftest to have ~100 userdata,
> so, we can exercise this code in NIPA.

I had a quick look and netcons_fragmented_msg.sh needs some
refactoring to be more reliable before I can do this. I will send this
as a separate patch set.

