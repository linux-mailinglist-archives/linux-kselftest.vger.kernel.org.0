Return-Path: <linux-kselftest+bounces-17586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7469739A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 16:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF401C24755
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 14:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF5719414E;
	Tue, 10 Sep 2024 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P+UFW3TH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5382AEF1
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977733; cv=none; b=slLMCzd6h3iJOSYVjwLP8u45RrB4cJ+XiFEUBpn1wrBFnNus143aegeusrNXTzg1v3YiN5PgtsIsKhhdAmgRr2a0wUmEfDfP/PJIkUrUeax1avj/uVQ4RHht/PRUUm03mJDg4r/AETABeq4XWTpZQ+35dN6wLyi82Br+ppLqjUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977733; c=relaxed/simple;
	bh=3++uvaRtsQXBkrFX19ZoZvgk1HVt/bzPAyG99NtgY98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdVD8CLmGMjik8tC3fTfhRceuxN9xnJdB+GyinaNtWN3DMcIYzuoRjwVs1yCEWX1JNmnkl7gCSiP83ruz1lyDRknbmKpRR0rKrOxhtTTmwNYmgYCIyjUL+/nPSMrBsg55pQC4aNXNGjJpyj21ayNvNTnJn9YINuA1Y+yei8eBFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P+UFW3TH; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2781d214392so202699fac.2
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 07:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725977730; x=1726582530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybYH3pl5I3XVIgOYPoF7qjD9tXRX1IFgRU4+n15LPsA=;
        b=P+UFW3THRLJ4sA5tUvXtGdTqCp7oLeOTxq21aSigAdx9nHBaa92eIIiVDgR969eQ5V
         xjuyLfOdAiYdmM38e1UQdmVhtlR7KM4BTcFagVJFVTIYesYBGTmakaG2Cdx60sjMXSir
         9p/zvKOtBtrSBiI5C5PzvoyN5780KzmU5wVk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725977730; x=1726582530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybYH3pl5I3XVIgOYPoF7qjD9tXRX1IFgRU4+n15LPsA=;
        b=mckOGmbL3F+pjjUGusZgeSEe20pwYaamHA6/7IsqFOrobDHCVrq59TRwYJIvaRMyfa
         66gvc/SuU4VHrsUQKDuYfBSsEGlILI3QBVf8gM4hrUBilx8Xa7RQg2LLVY4K3CzJQaS2
         OkDH3M1AxrvODsgfe8okOHD7kvmTxkCVoeP8DzSnan2Z/2kiaJv1s4l+5VApwzQ1B4uY
         LRtQrofQatx4Ktc+s9kYqHlXnGjVds0B3R1kPsjuDLZevkf7PqURzIbQQOtI0zMcqy5A
         jIJfmlzOMQmeWZOs0fTNaTDsvDGTV4ZK7kQZFf+9K2VNSFJqF1624/V6gwwfT3RDDp73
         Lsiw==
X-Forwarded-Encrypted: i=1; AJvYcCU3Fi+qrnD7zmAmxlH9xKbybfP23BDhy+vOzs09L9i8IeC7XBrIQ/S8d2b8LLwsJaKZrdxXvJEYr2SquvcjzWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS7nwmucyMS8uOl0eOU95Pnxqtn/FGnMiUGuSJTEHwZTALH2ee
	bYU8TRZOFzp/s7i0zVy+iwr+4FjXjzvUxiyDZ5RmRa0E5fyidLpSCdcg4OaP1S6pkLDjR6Yd+wS
	Q0UDcSEvXvjBCX5v+NkRqQDGTrKjGPl7Du1dm
X-Google-Smtp-Source: AGHT+IGrqe/kUELE8mrEjs2DqGDQyaa2RipgO9ceLOCupntW+1CqirpJeFY2eByO3yoZIssqQqSUjK4jmQwbYKjek2k=
X-Received: by 2002:a05:6870:224c:b0:27b:72b3:cd9a with SMTP id
 586e51a60fabf-27b82dba2b5mr5918265fac.2.1725977730540; Tue, 10 Sep 2024
 07:15:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809082511.497266-1-usama.anjum@collabora.com>
 <CABi2SkWgPoWJY_CMxDru7FPjtQBgv61PA2VoCumd3T8Xq3fjbg@mail.gmail.com> <1b36ba43-60a4-441c-981f-9b62f366aa95@collabora.com>
In-Reply-To: <1b36ba43-60a4-441c-981f-9b62f366aa95@collabora.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 10 Sep 2024 07:15:18 -0700
Message-ID: <CABi2SkUih8XrA4aJwngAoByCytg-PthJ8JrkKpzJRFP=f9zyKA@mail.gmail.com>
Subject: Re: [PATCH] selftests: mm: Fix build errors on armhf
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, kernel@collabora.com, 
	stable@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Muhammad

On Mon, Aug 19, 2024 at 3:05=E2=80=AFAM Muhammad Usama Anjum
<Usama.Anjum@collabora.com> wrote:
>
> On 8/14/24 3:29 AM, Jeff Xu wrote:
> > Hi Muhammad
> >
> > On Fri, Aug 9, 2024 at 1:25=E2=80=AFAM Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >>
> >> The __NR_mmap isn't found on armhf. The mmap() is commonly available
> >> system call and its wrapper is presnet on all architectures. So it
> >> should be used directly. It solves problem for armhf and doesn't creat=
e
> >> problem for architectures as well. Remove sys_mmap() functions as they
> >> aren't doing anything else other than calling mmap(). There is no need
> >> to set errno =3D 0 manually as glibc always resets it.
> >>
> > The mseal_test should't have dependency on libc, and mmap() is
> > implemented by glibc, right ?
> >
> > I just fixed a bug to switch mremap() to sys_mremap to address an
> > issue that different glibc version's behavior is slightly different
> > for mremap().
> >
> > What is the reason that __NR_mmap not available in armhf ? (maybe it
> > is another name ?)  there must be a way to call syscall directly on
> > armhf, can we use that instead ?
>
> It seems __NR_mmap syscall is deprecated for arm. Found this comment in
> arch/arm/include/asm/unistd.h:
> /*
>  * The following syscalls are obsolete and no longer available for EABI:
>  *  __NR_time
>  *  __NR_umount
>  *  __NR_stime
>  *  __NR_alarm
>  *  __NR_utime
>  *  __NR_getrlimit
>  *  __NR_select
>  *  __NR_readdir
>  *  __NR_mmap
>  *  __NR_socketcall
>  *  __NR_syscall
>  *  __NR_ipc
>  */
>
> The glibc mmap() calls mmap2() these days by adjusting the parameters
> internally. From man mmap:
> C library/kernel differences:
> This  page  describes the interface provided by the glibc mmap() wrapper
> function.  Originally, this function invoked a system call of the same
> name.  Since Linux 2.4, that system call has been superseded  by
> mmap2(2), and nowadays the glibc mmap() wrapper function invokes
> mmap2(2) with a suitably adjusted value for offset.
>
> I'm not sure if behaviour of glibc mmap() and syscall mmap2() would be
> same, but we should use glibc at most places which accounts for
> different architectures correctly. Maybe the differences were only
> present in case of mremap().
>
We shouldn't use glibc to test mseal, mseal is a security feature, and
an attacker can access syscall directly, so the test needs to test
with as little layer as possible.

I think there are two options:
1> switch everything to use __NR_mmap2
2> switch to __NR_mmap2 only for ARM.

I'm not sure which one is more appropriate though.

Thanks
-Jeff



> --
> BR,
> Muhammad Usama Anjum
>

