Return-Path: <linux-kselftest+bounces-16882-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EBC966E6C
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 03:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677D11C21B53
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 01:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC43210F8;
	Sat, 31 Aug 2024 01:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eT311lAr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803483FC2;
	Sat, 31 Aug 2024 01:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725067577; cv=none; b=D2X8Wqwvb0dhmva64E0pfX+vAkcJYl07akqVZxQniVfU/zEGgINxjdsGef8KydKjzDnawk3c0ybn2UsoIXVf923BP6/9de4QPuIrmMcifNCbgYn3C0vERxW9oKOfjc8W3UQlyh06unBjsEuPzQbf7z5GoSw3trHCheNDKlrmzSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725067577; c=relaxed/simple;
	bh=gxPdNZGQEFMPNKWeKlJD9uAC8slxEZ3cQIYJD90Mt4Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KoY1r5xOw3xeP+L+3FEpSvGVb/yxc3OtxDB/7jIS+w8SkV9N7HHG/NLff+v329BwVoUgiSdUOfIu5Ymg1Gm+2SC8f58VZfAIOkl4C5cJVbaD1/lSMABVQaNwgS4fipJ0HffVfKyrACFywb7PoXwBubiarkhzjHQbOMgHmyxJCmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eT311lAr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20227ba378eso21337775ad.0;
        Fri, 30 Aug 2024 18:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725067576; x=1725672376; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JMq8LeiKLC4aaQqQtyI/62ZqnY23+Wt9p5UO3ew0Jxk=;
        b=eT311lArhQbj3gNxIFRlEbiJY9s3JjeuNi3N6NTyj1dOaLSSvRWg6uI9i8vf2hd/7v
         mQ63G1gNbZVy4QOvHsJxoUxL5+gVZwCLCju3q3EUAZxmUI2X74WIm4ed541aftHiO2Jh
         M2rhh6pzadcFlowMN69HYEoZGuoS5lAltcvzM5HL6C5NwDsm0g/tFvCDVeJZhnh2qwX7
         +Y/v7V/FItJuLzHmgjARCDtoqq6QukAfTmvrUQj0pz8mR2Fp4eoIIecbLgkdez/YJ8Ri
         YHV/wsF19jKuHzFNqEst/HkTjhom2KBkYwIM5Q3Vwa1wURMXflW6iKJR48M+/c+OtvkV
         niyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725067576; x=1725672376;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JMq8LeiKLC4aaQqQtyI/62ZqnY23+Wt9p5UO3ew0Jxk=;
        b=H+sjSfIpAfAS5VzjNnBwQvCMMA0rPR11ongXsj3wUJh02xi5gDMef7FHX2OpMMqMjk
         y4oRfBbAanrYSZUzzJKSsobIMDIwIB/r6fn1Mi9uyNO464EMkllLGryeY9yKq3RKId9e
         mnwUMLZ2lM0UOn3Vt+iY59VrR8U/XlFjy39pAoIWQ/l7cchNtkbhOyBMI2StpnrCPsqF
         9d/xFC3MiqbucDycl/+Ng9EqFxyPDMv0L3kgPLRwU6rvouOPCG0xx9V2Y3Ql2bxRWNpG
         AkS8msPfFyCSgJZax3oik59fMxPUJJLGAdOn4VjfyN1xrE6T8pQh0UKybEnNpiX0qjvC
         lW1A==
X-Forwarded-Encrypted: i=1; AJvYcCVbosIQ0179JTm9pnePrKi2Q7ZMDERpC4Y258+BYa5VbystNVAPO37ELxe+JsjkIV54HGL9Q5r5vfYNNf62YNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW3cDB1lQ/ifk4dwoHRT3ma6aGpVVRCCRXpfFP3lQIsstBbYcf
	vnB0VnZN632MESvfNSaDfPJhGbgLknF9DuBjG7fup8sUlkebr2bV
X-Google-Smtp-Source: AGHT+IH5Tebb6zzTj9RNR7gBHKEIfrDl789p9NF+kRhOFrGC9LvdaPxMqEh9DoapBZLJwaqiiGoPqA==
X-Received: by 2002:a17:903:3543:b0:201:f052:d3e with SMTP id d9443c01a7336-2050c23dceemr89217115ad.24.1725067575855;
        Fri, 30 Aug 2024 18:26:15 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20538532e86sm11100305ad.5.2024.08.30.18.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 18:26:15 -0700 (PDT)
Message-ID: <f52f1489bd0936595ff0e492bcdfad8307bab364.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 5/8] libbpf: Support opening bpf objects of
 either endianness
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Tony Ambardar
	 <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, Andrii Nakryiko
 <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>, Quentin Monnet
 <qmo@kernel.org>
Date: Fri, 30 Aug 2024 18:26:10 -0700
In-Reply-To: <CAEf4BzbXD0M0Zfgih-7Rght_zSkTsZY3AmOpYxX5iaYimROaRg@mail.gmail.com>
References: <cover.1724976539.git.tony.ambardar@gmail.com>
	 <a12e83308e11b15501aa3b9e927bc94139418ce3.1724976539.git.tony.ambardar@gmail.com>
	 <CAEf4BzbXD0M0Zfgih-7Rght_zSkTsZY3AmOpYxX5iaYimROaRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-30 at 14:25 -0700, Andrii Nakryiko wrote:

[...]

> >         err =3D bpf_object__elf_init(obj);
> > -       err =3D err ? : bpf_object__check_endianness(obj);
> >         err =3D err ? : bpf_object__elf_collect(obj);
> >         err =3D err ? : bpf_object__collect_externs(obj);
> >         err =3D err ? : bpf_object_fixup_btf(obj);
> > @@ -8500,6 +8529,10 @@ static int bpf_object_load(struct bpf_object *ob=
j, int extra_log_level, const ch
> >=20
> >         if (obj->gen_loader)
> >                 bpf_gen__init(obj->gen_loader, extra_log_level, obj->nr=
_programs, obj->nr_maps);
>=20
> nit: add {} around if, both sides should either have or not have {}
>=20
> > +       else if (!is_native_endianness(obj)) {
> > +               pr_warn("object '%s' is not native endianness\n", obj->=
name);
>=20
> "object '%s': load is not supported in non-native endianness\n"
>=20
>=20
> > +               return libbpf_err(-LIBBPF_ERRNO__ENDIAN);
> > +       }

Silly question:
  why load is allowed to proceed for non-native endianness when obj->gen_lo=
ader is set?


