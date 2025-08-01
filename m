Return-Path: <linux-kselftest+bounces-38176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75A3B18088
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 13:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6DD2546D1C
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 11:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EF2242D60;
	Fri,  1 Aug 2025 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="h5XcAc7o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4471123ED76;
	Fri,  1 Aug 2025 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754046007; cv=none; b=j4Sc3r9ent5IMqAefpfT3DpVmGXNk29sqDn3zagC1vzFx/zIaDzAJT/9rUk5Xy5Cr1fUdRNY7Zerw5MogA94kMFDCbN6oXvo6mGishxRWQdjHMe1VgQyvDQuZzZo+RBTAAhqDIBM5dMd4S+oMVpxaGdxTWVKcct9FdH1AutagQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754046007; c=relaxed/simple;
	bh=SrU/DgzHeB8T3HhnNHwe7Wv/zYSsrNNui/GdxVK0W4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfWrc4MSuV+dq/Qrr5ddL98fs8wzi26H7x+W76MmTijspMsITHEv3076feBGIE26DWjQHSmY6Mte8/9laIzeUts3wGYNFBpvAkF2Rgt3gzRMRmWc2kllK33Sfcht5dasXoYJXTJi1G8jfJ6NFPFE7sBm/dnnIQlrdqRK5jG4tYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=h5XcAc7o; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1754046003;
	bh=SrU/DgzHeB8T3HhnNHwe7Wv/zYSsrNNui/GdxVK0W4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h5XcAc7orQ0efweZPqsyH2aaYb5dB1Cm4NdBXX4yXTCC1YJcN0it9EzLj5fUOjdl7
	 1xJ43F93jc3ed/QfN/z3CSPwtFqMIqL5SuLReiJH9l4Ch+Hg2+hdLkAcv8TJTkBdDh
	 WvSMwyX2w3I5uBA8hz//tzkBvBSQ2qqOri7p2I6k=
Date: Fri, 1 Aug 2025 13:00:03 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Graf <graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] kho: add test for kexec handover
Message-ID: <fae1936d-3f45-44d4-a9b0-43b29115d5ac@t-8ch.de>
References: <20250801100630.3473918-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250801100630.3473918-1-rppt@kernel.org>

On 2025-08-01 13:06:30+0300, Mike Rapoport wrote:
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

Looking at it while awake brought up some more nitpicks.
In any case:
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net> # for the nolibc usage

> diff --git a/tools/testing/selftests/kho/init.c b/tools/testing/selftests/kho/init.c
> new file mode 100644
> index 000000000000..8044ca56fff5
> --- /dev/null
> +++ b/tools/testing/selftests/kho/init.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <errno.h>

Not actually used.

> +#include <stdio.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <sys/syscall.h>
> +#include <sys/mount.h>
> +#include <sys/reboot.h>
> +
> +/* from arch/x86/include/asm/setup.h */
> +#define COMMAND_LINE_SIZE	2048
> +
> +/* from include/linux/kexex.h */

"kexec.h"

> +#define KEXEC_FILE_NO_INITRAMFS	0x00000004

This is actually part of the UAPI headers, why not use it from there?

> +
> +#define KHO_FINILIZE "/debugfs/kho/out/finalize"

KHO_FINALIZE

> +#define KERNEL_IMAGE "/kernel"
> +
> +static int mount_filesystems(void)
> +{
> +	if (mount("debugfs", "/debugfs", "debugfs", 0, NULL) < 0)
> +		return -1;
> +
> +	return mount("proc", "/proc", "proc", 0, NULL);
> +}
> +
> +static int kho_enable(void)
> +{
> +	const char enable[] = "1";
> +	int fd;
> +
> +	fd = open(KHO_FINILIZE, O_RDWR);
> +	if (fd < 0)
> +		return -1;
> +
> +	if (write(fd, enable, sizeof(enable)) != sizeof(enable))
> +		return 1;
> +
> +	close(fd);
> +	return 0;
> +}
> +
> +static long kexec_file_load(int kernel_fd, int initrd_fd,
> +			    unsigned long cmdline_len, const char *cmdline,
> +			    unsigned long flags)
> +{
> +	return syscall(__NR_kexec_file_load, kernel_fd, initrd_fd, cmdline_len,
> +		       cmdline, flags);
> +}
> +
> +static int kexec_load(void)
> +{
> +	char cmdline[COMMAND_LINE_SIZE];
> +	ssize_t len;
> +	int fd, err;
> +
> +	fd = open("/proc/cmdline", O_RDONLY);
> +	if (fd < 0)
> +		return -1;
> +
> +	len = read(fd, cmdline, sizeof(cmdline));
> +	close(fd);
> +	if (len < 0)
> +		return -1;
> +
> +	/* replace \n with \0 */
> +	cmdline[len - 1] = 0;
> +	fd = open(KERNEL_IMAGE, O_RDONLY);
> +	if (fd < 0)
> +		return -1;
> +
> +	err = kexec_file_load(fd, -1, len, cmdline, KEXEC_FILE_NO_INITRAMFS);
> +	close(fd);
> +
> +	return err ? : 0;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	if (mount_filesystems())
> +		goto err_reboot;
> +
> +	if (kho_enable())
> +		goto err_reboot;
> +
> +	if (kexec_load())
> +		goto err_reboot;
> +
> +	if (reboot(RB_KEXEC))
> +		goto err_reboot;
> +
> +	return 0;
> +
> +err_reboot:
> +	reboot(RB_AUTOBOOT);
> +	return -1;
> +}
> diff --git a/tools/testing/selftests/kho/vmtest.sh b/tools/testing/selftests/kho/vmtest.sh
> new file mode 100755
> index 000000000000..3f6c17166846
> --- /dev/null
> +++ b/tools/testing/selftests/kho/vmtest.sh

(...)

> +function mkinitrd() {
> +	local kernel=$1
> +
> +	"$CROSS_COMPILE"gcc -s -static -Os -nostdinc -nostdlib \
> +			-fno-asynchronous-unwind-tables -fno-ident \
> +			-I "$headers_dir/include" \
> +			-I "$kernel_dir/tools/include/nolibc" \
> +			-o "$tmp_dir/init" "$test_dir/init.c"

You could build this as a userprog as part of kbuild.
Then it will also work automatically with clang.

> +
> +	cat > "$tmp_dir/cpio_list" <<EOF
> +dir /dev 0755 0 0
> +dir /proc 0755 0 0
> +dir /debugfs 0755 0 0
> +nod /dev/console 0600 0 0 c 5 1
> +file /init $tmp_dir/init 0755 0 0
> +file /kernel $kernel 0644 0 0
> +EOF
> +
> +	"$build_dir/usr/gen_init_cpio" "$tmp_dir/cpio_list" > "$initrd"

This could also be hooked up to kbuild.

> +}

(...)

