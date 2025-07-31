Return-Path: <linux-kselftest+bounces-38134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1BAB1782A
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 23:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297C2189237C
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 21:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FBD264615;
	Thu, 31 Jul 2025 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ik2cyJWK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277B823ABB1;
	Thu, 31 Jul 2025 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753997241; cv=none; b=GaJ3IROfqDtgT7KZfjBgGPpeZFZHRq3e7dcSWHFUZZG+ttZ7qqCdqypI/EIobEj+HGzQXOtci91z8voSTsvjzwG1rOeK4zMgzTgdlA2iGoDGBa0y1766ZU64IFvVyK2+EDCCKCtzuMNLUSpo0CyQdfS5/+ciEH4P0TqHnjc8CBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753997241; c=relaxed/simple;
	bh=wjDa7WOGxyHO7D5dQF8LxTZo+LlEelFi+YPWHmw+YgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoPYuCQlaaC5A5IHwm6pk3Iz80Wn1BYrvNazDf2VLHlLAlI8Y1a98TCEQT8RX6or7gIHABUhsVPLysYOoM0ATLyIC0b0DAnUmIDwPBetQVittF1+1FRkuSlj2/Ug7re//B2Jinny+n1F8xshx43WGgiAgr2vFaXeoEynFvGnv5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ik2cyJWK; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1753997227;
	bh=wjDa7WOGxyHO7D5dQF8LxTZo+LlEelFi+YPWHmw+YgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ik2cyJWK4ofmcUVOZKooHAK3Hx+C25v+XJtLc51IX7lfPrqYTCULgZpCSxZOCRZ+Z
	 4qpZXXY221LjjYd8Myeu0O6KZq89Sy5J8mJcddZ60oIFZyThxRsOTaWB/kJtr07dah
	 s0kPO0xeFpx9zl9QEHujyrWH709KZOouJ95i10lc=
Date: Thu, 31 Jul 2025 23:27:07 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Graf <graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] kho: add test for kexec handover
Message-ID: <c54e6f3f-64b9-408e-9668-e96664f52f27@t-8ch.de>
References: <20250727083733.2590139-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250727083733.2590139-1-rppt@kernel.org>

Hi Mike,

On 2025-07-27 11:37:33+0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Testing kexec handover requires a kernel driver that will generate some
> data and preserve it with KHO on the first boot and then restore that
> data and verify it was preserved properly after kexec.
> 
> To facilitate such test, along with the kernel driver responsible for
> data generation, preservation and restoration add a script that runs a
> kernel in a VM with a minimal /init. The /init enables KHO, loads a
> kernel image for kexec and runs kexec reboot. After the boot of the
> kexeced kernel, the driver verifies that the data was properly
> preserved.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

(...)

> --- /dev/null
> +++ b/tools/testing/selftests/kho/init.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#ifndef NOLIBC

This is not necessary anymore, nolibc now provides these headers.
You can keep it if you want, though.

> +#include <errno.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <syscall.h>

This should be <sys/syscall.h>.

> +#include <sys/mount.h>
> +#include <sys/reboot.h>
> +#endif
> +

(...)

> --- /dev/null
> +++ b/tools/testing/selftests/kho/vmtest.sh
> @@ -0,0 +1,183 @@

(...)

> +
> +function mkinitrd() {
> +	local kernel=$1
> +
> +	mkdir -p "$initrd_dir"/{dev,debugfs,proc}
> +	sudo mknod "$initrd_dir/dev/console" c 5 1

You could generate the initrd with usr/gen_init_cpio or
usr/gen_initramfs.sh which would remove the need to use sudo.
Especially as I think the mknod should fail if $TMP is mounted 'nodev'.

> +
> +	"$CROSS_COMPILE"gcc -s -static -Os -nostdinc -I"$headers_dir/include" \
> +			-fno-asynchronous-unwind-tables -fno-ident -nostdlib \
> +			-include "$test_dir/../../../include/nolibc/nolibc.h" \

If you drop the #ifdef NOLIBC, use '-I "$test_dir/../../../include/nolibc/'
here instead. Or better, $kernel_dir/tools/include/nolibc/.

> +			-o "$initrd_dir/init" "$test_dir/init.c" \
> +
> +	cp "$kernel" "$initrd_dir/kernel"
> +
> +	pushd "$initrd_dir" &>/dev/null
> +	find . | cpio -H newc --create > "$initrd" 2>/dev/null
> +	popd &>/dev/null
> +}

(...)


Thomas

