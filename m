Return-Path: <linux-kselftest+bounces-35410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707FEAE155A
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 10:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02CC3AC31C
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 08:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AF11AB6DE;
	Fri, 20 Jun 2025 08:01:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B211730E824;
	Fri, 20 Jun 2025 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750406464; cv=none; b=lfiKXBcUTcN2fd88L5PqQJUqCbeebKP2oj2hQU3GhPFXTFM/fB5HWZrnzVx0o2I/jdZZzVM9MYprwDZezwbM8yT2pDNVf4lU3TnaBd5XNTEOd8l1sdoJqnpHRlJf5fuq9c+j+yRKUPb1I0Kg/UaOYj4659MYJHgLB7au5NgzsNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750406464; c=relaxed/simple;
	bh=AGwI9uUo58D8rhz4PFt/7iXNiYZDkRmoqVfEo+Wsk3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdQVSGzFVWXZi+ARs55sdquwSJJDwNQxx39xOe+w2yLs5Gvv6uYfcTMOSc4AVtV9yiMrHUc6FUE4Mkn7MU3ccEqimrf574zNo5CBw95Za7rsjbJMOvYsH1jWsTySaMsUiv7/xmy0K280MKzLv1J7NB1snHggL1tlrWToe4vFLD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 55K7pQKq022946;
	Fri, 20 Jun 2025 09:51:26 +0200
Date: Fri, 20 Jun 2025 09:51:26 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Yoshinori Sato <ysato@users.osdn.me>, Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Shuah Khan <shuah@kernel.org>, linux-sh@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] selftests/nolibc: use file driver for QEMU serial
Message-ID: <20250620075126.GB22550@1wt.eu>
References: <20250609-nolibc-sh-v1-0-9dcdb1b66bb5@weissschuh.net>
 <20250609-nolibc-sh-v1-2-9dcdb1b66bb5@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609-nolibc-sh-v1-2-9dcdb1b66bb5@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas,

On Mon, Jun 09, 2025 at 11:28:58AM +0200, Thomas Weiﬂschuh wrote:
> For the test implementation of the SuperH architecture a second serial
> serial port needs to be used. Unfortunately the currently used 'stdio'
> driver does not support multiple serial ports at the same time.
> 
> Switch to the 'file' driver which does support multiple ports and is
> sufficient for the nolibc-test usecase.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  tools/testing/selftests/nolibc/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index 22da78a4bfea0274f66abec319d34b3d2a2824ac..238acaa7bb06dcdbcadd9d3190c2de726e1a40b1 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -315,12 +315,12 @@ kernel-standalone: initramfs | defconfig
>  
>  # run the tests after building the kernel
>  run: kernel initramfs.cpio
> -	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(IMAGE)" -initrd initramfs.cpio -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> +	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(IMAGE)" -initrd initramfs.cpio -serial file:/dev/stdout $(QEMU_ARGS) > "$(CURDIR)/run.out"
>  	$(Q)$(REPORT) $(CURDIR)/run.out
>  
>  # re-run the tests from an existing kernel
>  rerun:
> -	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(IMAGE)" -initrd initramfs.cpio -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> +	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(IMAGE)" -initrd initramfs.cpio -serial file:/dev/stdout $(QEMU_ARGS) > "$(CURDIR)/run.out"

I'm cautious every time we touch the -serial output after having faced
issues earlier when trying to use pipes. Here I think it's OK, however,
I'm wondering if "file:$(CURDIR)/run.out" wouldn't be clearer, and also
encourage future changes to stick to a file and avoid piping the output
to a filter command. No strong opinion though.

In any case: Acked-by: Willy Tarreau <w@1wt.eu>

Thanks,
Willy

