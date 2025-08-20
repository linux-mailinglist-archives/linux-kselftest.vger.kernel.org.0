Return-Path: <linux-kselftest+bounces-39413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638A1B2E867
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 01:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C911A28313
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 23:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2792327A3;
	Wed, 20 Aug 2025 23:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8tAijK0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FA9B663;
	Wed, 20 Aug 2025 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755730853; cv=none; b=i/eE6FVM67UnE1rTmp6fh/5+Lt75N/4op9fX/85kamu+1PjllhFkUvrXlQFRSCX2sqI2iv6TvPWcShGbbz9NeJH4KWJVgBeidxoG6GEZbEhpGtY4e/OQDy85vB+mx7EsK6E1pwBxeyh13muIsz+SdG23ecR64QZUt+H5wqv5I9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755730853; c=relaxed/simple;
	bh=bMfyf9iVf/cf+1o6utDBJC5HItQLR/IqvY5qn8OOD0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSsE7G4+rvOKznErNm30X0kGirpI1WrVv3NIMLcoCiMKTj4UbWGCBPEO4AMkYxtLcq5WY1lxA6zwC5SFDmMUE26b0cpcLBMoHAV+lA/Yo+dQWYAjMefQCDesG05OzUsVGJrfDzEq8Z/aMpsI8zQUgXG6hL03IOMbtnoRPwvho3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8tAijK0; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32326e20aadso524617a91.2;
        Wed, 20 Aug 2025 16:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755730851; x=1756335651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yy3TEEW6DyAgwAJ9w2TLPrA9qanabyqXypgQkM1LVG8=;
        b=N8tAijK0sdNbCve1hPW8vzFbeZSm/bAJIAAgxgxd+HP0+9VdGgs2Wnp8xFXYyi8SLD
         i3kQ5yUTkNbQmbxMb2RPQKhcJwSQJO7vDEJttwv0qsXFXQJM7Tw+kOL0gkhcTeRn9atq
         h8Mb5eYKFsCZrhGpOKIZg04ZhqsJ80N1KsLlwrSBSYs8MYyQ4nLMK2vMqDnLyla4asvw
         0pEod4ab0dJxwgksc1pbpLDRMdGKUnKD3TN+gtCOPJFhfle8xJGIM5MFAok0F7nPLUn1
         J0vvpS0/fMqfmlnNghFghUakG7VsIxOfm9KLbtm41iCuCeoNFCRUVLq2dB48xtoHomQX
         CudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755730851; x=1756335651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yy3TEEW6DyAgwAJ9w2TLPrA9qanabyqXypgQkM1LVG8=;
        b=EkSEtsw5KOC2WPinZ5rdwaQBD3V+fwyvSyjjmrCIqz8y952X6SQ1cm76NYcDmGjLC9
         OGrqATIOgknEET7CAxBSX32Jql9HasRxfP4LOWsrsrhi+LeTOBOLpgRhFXcxiL52PaSD
         ZDzKfDNOl4vLSteNAe2jjMmc7kx+hFLgFpsWSr0uHI8a/kPLVz53CfJjzqyQNUKh41Db
         61XberD0qoMwwGoUQJOEE0YgtEEErEJP9xrCN11Y9/UwzQZdyBarU1yRTTQSTL+HnCz0
         w7im0svwg2zXMmicAOozw5IIb7nq2mub4w4HPuvVROSCo5JF3gTSEF5MaI9mTDEuvojW
         mW8w==
X-Forwarded-Encrypted: i=1; AJvYcCU3kghWQqYYImtw26cHXH10mxnzdLT37FODI/366r+e30YWfaOytXMbs2RJZkDFl1HSkMg=@vger.kernel.org, AJvYcCXH6C8SPuLM6jw17Ha5vBP0Z0VkUsiIv97H8SgDL4R21sMgl+bDF1WVCcwzOyzIceaAylOyT+wZpshGylV1@vger.kernel.org, AJvYcCXlQDGWssLCZZVjyy3ZRwd1fHL1SGWqLcEpoRbkrQzu/fEm4C51agWD8HMPiiIba2WSu7QZhaVEU9XpAQekdajJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxxwBjMslQml+a4gfeHbg1NAbnq+z37Sx2k93bOXzI82bnmzZaN
	fPW5sBQ00mitWXEMq8HtjiP0CKBQInsYKwHJqUG6aM1J7ZGuyoTaBz/PIkDL7qF0N4IF6nsNa3Y
	XBWQAPTKOd4dD4hq8ctBygyZBPoTZgro=
X-Gm-Gg: ASbGncvc7ehmT6A1ClumGQGlmOq80mDdqDBLAgw0QPCeiRkbGS7MVFAAPPGpLWa7Rmv
	rdWJKYN/wxmu2qI/QYCuhKPzuzoC4qVr6K0LhDgDNh3tLZONsZPuBCIme7yUIv+dWuYe8sqVuAj
	qS9BHJKukqDw0/vsTphjmZKbCTT5uVklkaJD7MCImbRm9DwYkJqfXbc/YmY+y7q86kCZCWAoO1P
	BazSmU3UtCIe0oHtjqF/SA2JseVINiYcA==
X-Google-Smtp-Source: AGHT+IGzxLNjy0xPzf8DTHy1HiLkiKCaSnhujZsN9KWtZwpW8eiuq/zIzw6FfF2QvgpAlwGfy1pRHWxJ+Pu5W6pqz24=
X-Received: by 2002:a17:90b:48d2:b0:31f:20d4:9966 with SMTP id
 98e67ed59e1d1-324ed12f411mr748453a91.17.1755730851512; Wed, 20 Aug 2025
 16:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806092458.111972-1-phoenix500526@163.com>
 <20250806092458.111972-3-phoenix500526@163.com> <f5d8d886-1de3-4521-917a-e98b645b987e@linux.dev>
 <30d8fcac.2669.19882763de2.Coremail.phoenix500526@163.com>
 <e7ba3f7f-38b8-4c06-8aff-ef1fb8d04d86@linux.dev> <310495cd.19eb.19893314d03.Coremail.phoenix500526@163.com>
 <0f6d16c1-0e85-4709-9846-3a993a9f041b@linux.dev> <65e51538.57aa.1989d162bb8.Coremail.phoenix500526@163.com>
 <2559a8cd-b439-43fc-96e4-d5f2941ca4d8@linux.dev> <3fbb9319.20c8.198a1410186.Coremail.phoenix500526@163.com>
 <6c444d7d-524d-4bc8-bda6-0440af621ebe@linux.dev> <46f4c341.1dea.198b845a4b0.Coremail.phoenix500526@163.com>
 <7495eeb9-777b-4b9e-8312-c6654268d6ec@linux.dev>
In-Reply-To: <7495eeb9-777b-4b9e-8312-c6654268d6ec@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Aug 2025 16:00:35 -0700
X-Gm-Features: Ac12FXwHBBpnEOB-6GW2sDAuquK0ygspyIoOWqSdoaWGhvsu8UGlxD4KfsvRK0c
Message-ID: <CAEf4Bzbpu9PM6GHV6ewE_hJJ7=94Rn1ZYq5QWVnpoH6_LRQDCw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] selftests/bpf: Force -O2 for USDT selftests to
 cover SIB handling logic
To: Yonghong Song <yonghong.song@linux.dev>
Cc: =?UTF-8?B?6LW15L2z54Kc?= <phoenix500526@163.com>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 10:35=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>
>
> On 8/17/25 6:43 AM, =E8=B5=B5=E4=BD=B3=E7=82=9C wrote:
> >
> >
> >
> >
> >
> >
> > Hi, Yonghong. I've already filed an issue[1] in GCC  community.
> >
> >
> > Accroding to the discussion, it's not a gcc bug but may be a systemtap =
bug.
> > I don't know how to report this bug to systemtap, but I found that the
> > libbpf/usdt have the same problem. I've filed an issue in libbpf/usdt r=
epo[2].
> >
> > I also have some ideas about it. I wrote it down in the issue[2] commen=
t.
> > May be we can discuss there.
> >
> > [1]. https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D121569
> > [2]. https://github.com/libbpf/usdt/issues/13
>
> Thanks for filing an issue on gcc and getting some feedback/suggestions
> from gcc community.
>
> Currently, libbpf/usdt does not suport format like '-1@ti(%rip)'. If we d=
o

Exactly, it doesn't. I haven't yet ran into a case where real-world
applications would use such an argument format, so there was no
incentive in trying to support it.

Was this issue discovered as part of testing on some real world
application, or it's mostly through testing on synthetic cases?

> intend to implement this. libbpf/usdt can reject that if 'ti' is a
> static variable. libbpf can provide some hints about how to make it
> work (see above [1] and [2]). Then, it would be user's reponsibility to
> change code so libbpf can support it.
>
> >
> >
> >

[...]

