Return-Path: <linux-kselftest+bounces-36677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D090AFAED2
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 10:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30CF77A395B
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 08:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BF6944F;
	Mon,  7 Jul 2025 08:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qe8SYpIS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CBD2264C8
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Jul 2025 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751877811; cv=none; b=ftfenjRnq1Ejl+VyjEc8etcB85mOR4Hq8uH0/ffjLkYe0lKCaCfDQfQRUdJ1vnSuT9/hMTzCk3X1Y6EEoKrH/vmDZZhmofTwgaH/N6IWm9SuhOklNx4W3kuMGKOHN7Owoftrf23BajYgOpRhCbEaNpRx2JsfRb5BNG7EpCEI71A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751877811; c=relaxed/simple;
	bh=kQHEDU+QSHvdBHKt5+PAg7nOWxj219yOY2ZaoTu5u68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrsdYpmzA6ilSflWggtkoFjwdPFqTQtuuVJQ0r55IJWgVHe+HLbFSX6ldIlV7bjTpv6suHs7OW0LolvJ223CmzJph+FXPpyPMP3Hr3kIyyHsO7U79TT4lB3Y0zmLz+ym2DoRYi/UU6G1Wv199Czl27z39IEmXD70MgiQQ2m5YbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qe8SYpIS; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b350704f506so1992111a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Jul 2025 01:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751877809; x=1752482609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LklowgplYENw1i7IrjdnHI57VuSnPOYFZ+BKhHkshBI=;
        b=Qe8SYpISzN8dgNO/ZvVD7EBnY0S/ExAAXCsQazdSdkvdaOTsg5F4pKQthiL+uv2jjR
         d/lkKidZF9mYbWuLOHPQjX3lexhAdc/2gaAoJwcmZRnTToh1URrwm824p/NMYZKPd1lX
         Cj5N5NlFwia2cGKiDVVEuxvJmKsDJxkVFgaNksXqVcawzDG1KKejNiqPdGAz5X0jr1z/
         5tg6DIpQCdByfUSMF58CP1O7nP4zcyIpgKdynOtf7jqHaz9pXZCw2qPZO6bssEjGRJw1
         Hlf7iin3mCTa99L/Q0mjKJ8uyGCfsyGr95RqqDTDvkIoVOJgTDcXQiNkRk/qgh+dyuzg
         qv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751877809; x=1752482609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LklowgplYENw1i7IrjdnHI57VuSnPOYFZ+BKhHkshBI=;
        b=jUXb7VXyF6wHnXSVoOTWOTrKwl3evk8NwVtqie8AlchAGSbV0cry+btH0PnhLm0G1a
         mRM3qHH8DzEwh1+GD3FaY3qjq3w+RqvEIP07MG96NvML/1ZG/Kx2fJZRguw5ruWKciZq
         ICYqA3froMyZcbSN9qhnjN5yYNL+x+SgfnRZV44rkqSW5M0zamrFWvRqWNWTLBXwtXvS
         h5yh6mAZQ6o7Y0g1ZDqUfR5tO3Lq1gmZ6zDf3f4/0mon2Ki4ftOyhM66ky33Klysemxm
         xTFwWW2naMlyMZsgfFO+n/+IaGWz9S7gTHIK8TbUuE+hJhp6JdCedh4PrCYT1NRs2SPh
         JJ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU72nMN0AdCOg1YNPAxedc8xWuFAn8rNpglHabpk3l6GQCbFCyf+LFWaRhgvexw+PhT8i0h7UJd7G7do5iBPIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyDdlnE439sg3JtHVMbJRXSxdDcgDpujQkPsKSfVjdnhcc1Htw
	yKIDTO4u6hITP5pb8IDGGIAZVrU5FxVt/r7pvIpK0sRDS2Uqhbo4I928XlQ6oIf2ygMBkmvP9bP
	QOl/Iq20IwIb+rLO+rUV8q1YbIAlv6ZqlltoxgiDZfg==
X-Gm-Gg: ASbGncuPaK91TxhnnKla+iimv+iSk6h48cM9pczX/E+CTzLYXyABqRSj0/Yeri+ofuK
	xQL6LvTvfqDZZ3bsgqnXUZgmSN72DbnIIVmRt8aGWAJClnv+rCge8PQ7ZBtxm+rX1bYvDc8Ixqq
	N/wbN+eKp+whcem+eFKeQRfr30Jc1S73VvL3lJDliSwKkyWMwJ6Cn56i9UavzFOYLBPssrcHbEP
	M9T
X-Google-Smtp-Source: AGHT+IHukxRqvzepVhYBRpt+PLlMQ3SlnLL5W6s2lImeMWjf2sMY2i4Bu4SdjhsaHOmFNGgSz7dhys43qu/uU2e4sN8=
X-Received: by 2002:a17:90b:33d1:b0:30e:3737:7c87 with SMTP id
 98e67ed59e1d1-31aab854dadmr18730822a91.5.1751877808741; Mon, 07 Jul 2025
 01:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvD1A12WE36NjELe5cD-LbPsmwJnH5aUAcufBZ7ndt2Hw@mail.gmail.com>
 <c9ba86f6-dea8-47bd-88e1-edf49e4bf9fd@app.fastmail.com>
In-Reply-To: <c9ba86f6-dea8-47bd-88e1-edf49e4bf9fd@app.fastmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 7 Jul 2025 14:13:17 +0530
X-Gm-Features: Ac12FXw-G_lNwP97raxqWFOZUtf2EluymJriGyENT10NUGjfSc__f9FGW09O5J8
Message-ID: <CA+G9fYtuh0FwKfjadb7c+jr=ZZ-wXjmkbcPA4sp8OqzARBV1Dg@mail.gmail.com>
Subject: Re: LTP syscalls mseal02 and shmctl03 fails on compat mode 64-bit
 kernel on 32-bit rootfs
To: Arnd Bergmann <arnd@arndb.de>
Cc: LTP List <ltp@lists.linux.it>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, chrubis <chrubis@suse.cz>, Li Wang <liwang@redhat.com>, 
	Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Jul 2025 at 19:47, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jul 3, 2025, at 15:47, Naresh Kamboju wrote:
> > The LTP syscalls mseal02 and shmctl03 failed only with compat mode testing
> > with 64-bit kernel with 32-bit rootfs combination.
> >
> > Would it be possible to detect compat mode test environment and handle the test
> > expectation in LTP test development ?
>
> I think we should either make the kernel behave the same way in
> both environments, or accept either behavior as correct in LTP.
> NVAL (22)
> > mseal02.c:45: TPASS: mseal(0xf7a8e001, 4096, 0) : EINVAL (22)
> > mseal02.c:45: TFAIL: mseal(0xf7a8e000, 4294963201, 0) expected EINVAL:
> > ENOMEM (12)
>
> This is "length=ULONG_MAX-page_size+2", which overflows on 32-bit
> but not on 64-bit.
>
> How about this?
>
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -234,6 +234,9 @@ int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
>         if (end < start)
>                 return -EINVAL;
>
> +       if (end > TASK_SIZE)
> +               return -EINVAL;
> +
>         if (end == start)
>                 return 0;
>
> Since TASK_SIZE is smaller for 32-bit tasks, it would detect
> the overflow in the same way.
>
> > tst_test.c:1774: TINFO: Overall timeout per run is 0h 21m 36s
> > shmctl03.c:31: TPASS: shmmin = 1
> > shmctl03.c:33: TFAIL: /proc/sys/kernel/shmmax != 2147483647 got 4294967295
>
> I see this is being intentionally truncated to INT_MAX:
>
> static int copy_compat_shminfo_to_user(void __user *buf, struct shminfo64 *in,
>                                         int version)
> {
>         if (in->shmmax > INT_MAX)
>                 in->shmmax = INT_MAX;
>         ...
> }
>
> > shmctl03.c:35: TFAIL: /proc/sys/kernel/shmall != 4278190079 got 4294967295
>
> Here the value from /proc is defined in the kernel as
> "#define SHMALL (ULONG_MAX - (1UL << 24))"
>
> On a 64-bit machine this is 0xfffffffffeffffff.
>
> However the 32-bit ltp tst_assert_ulong() truncates it
> to 0xfeffffff, which happens to be the exact same value
> that it would see on a 32-bit kernel.
>
> The second one is 0xffffffff, and I don't know how that gets
> computed, as it is derived from the same number in
> info.shmall = in->shmall;
>
> Are you running this inside of a container that its own ipc
> namespace?

No.
Running on the real x86_64 machine.

- Naresh

>
>      Arnd

