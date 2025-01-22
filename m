Return-Path: <linux-kselftest+bounces-24918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DCEA18E41
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 10:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 891E57A230C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 09:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8705720FAA8;
	Wed, 22 Jan 2025 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Ly1CiR8s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761F620FA9D
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Jan 2025 09:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737538002; cv=none; b=KRNRbfOTc6HgonrNtpoDIApbVj/G3V9wYz1ryob+aMtWv08TyXh5h7VqTjNI4S1Yk6rHcrETO1HAgFtMHsiQrVuBXlsiM9KTTFwhG9szDhhIPr5sQoLLbFTOk982BihKj4E5tz44B56Uq6+plvKhk6FqGFwZ8vIUcFIG5iYZPgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737538002; c=relaxed/simple;
	bh=+yRmJU0tPBnL7fsox/jPmAihqETGreRvtvmgF6ietdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNMCOSgYPX+2PXHBz1muVziOQP3EviNIdWwgn1MhTX79cfBd7j61kAj1ZkrqKPr/nnNKr4Ypj4zx536xRHpqMD+XsxGA8zeCLhVYHA9hA8slultcdJWYtq9JfKVzFyQCV4FZAErgWTbfcp0t8//bWfZ3FPOv6XcuH5L/5X0PiMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Ly1CiR8s; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5401bd6ccadso6688180e87.2
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Jan 2025 01:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1737537998; x=1738142798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEO3Tux6Xm3WHQWZpA+yQBz/dO+Iyn0H+PnYP5Efrh4=;
        b=Ly1CiR8s/AuCq6XcwbJpf7UWxdzNeT96Xvj2Zl8gbPDgQvHxZT7PjzfT3HoS7uVjhP
         POtiJxwv2G7J/0ne3WOqm84FfmkY7JSL5dJDDnKvWEUBmUi5XPfZFYoic1I8NyQUuhlW
         O31LRPWba+0L3g3voowEnHgFiugyS6GNXVztDPFR0Lgd21evZQIxvbf7jKeWkUfnAy4S
         oFVcvglSemahpHBFVX+ygHW0e1/mZeLlXkRdhv272trBh3xAqA92pECMV9C1Sk6OeTo9
         E/+4YjaAAd22eWSh0EvWcdR3PCk3c9qX4EivwFx+6b8ROwyuSxJGrbz6Q42y/QBOaCQr
         tohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737537998; x=1738142798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEO3Tux6Xm3WHQWZpA+yQBz/dO+Iyn0H+PnYP5Efrh4=;
        b=ikn5mQNaGA552ANCHNphgImPoOulpx4yW3eqGt6/mOc0OL6L6/Q5pVONh47MZ3kD0k
         HpEHrDEwaaM+P5D5/dDfKTbqGTlV06eVQCdgrmgfXMnaHINsY1/ZLp0FQHp90yHNwm5V
         xUyawvc3kehODB/bnjV1A4eeMzNsx80Vhn//kFlVw0GMB9BKZgrEv7wcQ1Z7+2ncmp3t
         4H/EuPByJGlMnTlH3Tn1F9XFuVjUhWi/sg98ug+/s0o/mgoJQHAyPuvv44IUF1jbeZcm
         IeOknZdPkEgLyFXqK/9bqNJOqUy9KOtH//nWTckjG1csMyyVdm/e4aAdxED5Six4h+ea
         rsYg==
X-Gm-Message-State: AOJu0YyQY+cJRUQolSu4scpMV+b7zh29n9c/2pKJ9Zs5h40FT+uzBbyL
	G4aa3LjuiPduNiC1cxmZRkbutCzXnrKUR4d6ADrMsDGZ9AiugkuPnZYBs2xbTv+FXVNh1+JG0VC
	Dk2EgF/OQsOH2WvSDhM/61FmCVEOdah89DHPSFw==
X-Gm-Gg: ASbGncsdZaQg0r9AFbZ1JB123RCpiBb4Be95oMF+hgmw8RavXS3+QyDaoEnJ8S2dKzw
	jsDKyq7l10vIe0GWALw61VW57dUuDN8FqM/ejgCFab4fmjRRQ58pi/vSsuVvwm7Mtpc+Bx6qwZN
	ykfcfmqQ==
X-Google-Smtp-Source: AGHT+IHpN59Szas9VY3xt/KDpuEei7HsRYdu5hNY3s3eOV0chb7HdgJTXWKPDiFB9aWKqolSSdYDkzo1tqc34Qm7Hgg=
X-Received: by 2002:a05:6512:3e03:b0:53d:e5c0:b9bc with SMTP id
 2adb3069b0e04-5439c28743bmr7508525e87.50.1737537998318; Wed, 22 Jan 2025
 01:26:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122043309.304621-1-koichiro.den@canonical.com>
In-Reply-To: <20250122043309.304621-1-koichiro.den@canonical.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Jan 2025 10:26:27 +0100
X-Gm-Features: AbW1kvZS-W6bXsh5MNdDL1bESL9lLMrOeq8iPer-n7LZoqBn2tS0MIDSYBla4pQ
Message-ID: <CAMRc=MfRm02TRJ52CU3iLhsvwd95CBhxmkbebCJ=riiXxsCkyg@mail.gmail.com>
Subject: Re: [PATCH] selftests: gpio: gpio-sim: Fix missing chip disablements
To: Koichiro Den <koichiro.den@canonical.com>
Cc: linux-kselftest@vger.kernel.org, linux-gpio@vger.kernel.org, 
	bamv2005@gmail.com, shuah@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 5:33=E2=80=AFAM Koichiro Den <koichiro.den@canonica=
l.com> wrote:
>
> Since upstream commit 8bd76b3d3f3a ("gpio: sim: lock up configfs that an
> instantiated device depends on"), rmdir for an active virtual devices
> been prohibited.
>
> Update gpio-sim selftest to align with the change.
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202501221006.a1ca5dfa-lkp@intel.co=
m
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> ---
>  tools/testing/selftests/gpio/gpio-sim.sh | 31 +++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/gpio/gpio-sim.sh b/tools/testing/sel=
ftests/gpio/gpio-sim.sh
> index 6fb66a687f17..bbc29ed9c60a 100755
> --- a/tools/testing/selftests/gpio/gpio-sim.sh
> +++ b/tools/testing/selftests/gpio/gpio-sim.sh
> @@ -46,12 +46,6 @@ remove_chip() {
>         rmdir $CONFIGFS_DIR/$CHIP || fail "Unable to remove the chip"
>  }
>
> -configfs_cleanup() {
> -       for CHIP in `ls $CONFIGFS_DIR/`; do
> -               remove_chip $CHIP
> -       done
> -}
> -
>  create_chip() {
>         local CHIP=3D$1
>
> @@ -105,6 +99,13 @@ disable_chip() {
>         echo 0 > $CONFIGFS_DIR/$CHIP/live || fail "Unable to disable the =
chip"
>  }
>
> +configfs_cleanup() {
> +       for CHIP in `ls $CONFIGFS_DIR/`; do
> +               disable_chip $CHIP
> +               remove_chip $CHIP
> +       done
> +}
> +
>  configfs_chip_name() {
>         local CHIP=3D$1
>         local BANK=3D$2
> @@ -181,6 +182,7 @@ create_chip chip
>  create_bank chip bank
>  enable_chip chip
>  test -n `cat $CONFIGFS_DIR/chip/bank/chip_name` || fail "chip_name doesn=
't work"
> +disable_chip chip
>  remove_chip chip
>

Hi! Thanks for addressing it.

Is there any place in this file where we'd call remove_chip() without
calling disable_chip() first? Maybe we can fold disable_chip() into
remove_chip() and make the patch much smaller?

Bart

