Return-Path: <linux-kselftest+bounces-21455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EC79BCCD9
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 13:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E681C22229
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 12:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257171D516A;
	Tue,  5 Nov 2024 12:36:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB141E485;
	Tue,  5 Nov 2024 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730810217; cv=none; b=cB+Ie1PmL5R2HQgup4v90nqIja0o4P+A5DHgSct2fTMsSSn9Uf5rUGaaBSEPs1kyA+eDRIIRv/BOh5UCPjOM91/xFhOKsNaH1kDekUHQ0DpqCynHdzxCyUAuR2qsa18eSZmApY2o7fJsdYi/NocltmmZ/2GNYGLtm6siYcp6G44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730810217; c=relaxed/simple;
	bh=JI6MB//wtf97/j8tW58PlJtqH71bKmL9KGU9T8eS3/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WvSo6ZbikzxgE5106WU0Qfzz1iVZeZfuFMUZaWB6lkejFAUSjrG51VSFRg9YN9kPrCoLiTUb7jDnF2fvKi2+xaCnV/J9KhQzBO6S9HWjEp5OpZ/2QnSZELFpoQi/+hvp2pMeOZ6Xq44A5vJvyAACKEy3pCiEezkz9a6WLG8j/Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D52CFEC;
	Tue,  5 Nov 2024 04:37:22 -0800 (PST)
Received: from [10.57.24.229] (unknown [10.57.24.229])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E04A3F6A8;
	Tue,  5 Nov 2024 04:36:50 -0800 (PST)
Message-ID: <4e57a6e6-f10c-4a35-88e7-ab4749f7e329@arm.com>
Date: Tue, 5 Nov 2024 12:36:40 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] kunit: enable hardware acceleration when available
To: Tamir Duberstein <tamird@gmail.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <thomas@t-8ch.de>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org
References: <20241102-kunit-qemu-accel-macos-v2-0-9d4579fddd20@gmail.com>
 <20241102-kunit-qemu-accel-macos-v2-2-9d4579fddd20@gmail.com>
Content-Language: en-US
From: Kristina Martsenko <kristina.martsenko@arm.com>
In-Reply-To: <20241102-kunit-qemu-accel-macos-v2-2-9d4579fddd20@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/11/2024 12:09, Tamir Duberstein wrote:
> Use KVM or HVF if supported by the QEMU binary and available on the
> system.
> 
> This produces a nice improvement on my Apple M3 Pro running macOS 14.7:
> 
> Before:
> ./tools/testing/kunit/kunit.py exec --arch arm64
> [HH:MM:SS] Elapsed time: 10.145s
> 
> After:
> ./tools/testing/kunit/kunit.py exec --arch arm64
> [HH:MM:SS] Elapsed time: 1.773s
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  tools/testing/kunit/kunit_kernel.py       | 3 +++
>  tools/testing/kunit/qemu_configs/arm64.py | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 61931c4926fd6645f2c62dd13f9842a432ec4167..3146acb884ecf0bcff94d5938535aabd4486fe82 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -123,6 +123,9 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
>  				'-append', ' '.join(params + [self._kernel_command_line]),
>  				'-no-reboot',
>  				'-nographic',
> +				'-accel', 'kvm',
> +				'-accel', 'hvf',
> +				'-accel', 'tcg',
>  				'-serial', self._serial] + self._extra_qemu_params
>  		# Note: shlex.join() does what we want, but requires python 3.8+.
>  		print('Running tests with:\n$', ' '.join(shlex.quote(arg) for arg in qemu_command))
> diff --git a/tools/testing/kunit/qemu_configs/arm64.py b/tools/testing/kunit/qemu_configs/arm64.py
> index d3ff27024755411441f910799be30399295c9541..5c44d3a87e6dd2cd6b086138186a277a1473585b 100644
> --- a/tools/testing/kunit/qemu_configs/arm64.py
> +++ b/tools/testing/kunit/qemu_configs/arm64.py
> @@ -9,4 +9,4 @@ CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
>  			   qemu_arch='aarch64',
>  			   kernel_path='arch/arm64/boot/Image.gz',
>  			   kernel_command_line='console=ttyAMA0',
> -			   extra_qemu_params=['-machine', 'virt', '-cpu', 'max,pauth-impdef=on'])
> +			   extra_qemu_params=['-machine', 'virt', '-cpu', 'max'])

Would it be possible to keep 'pauth-impdef=on' for TCG emulation? Otherwise
performance regresses by about 20%.

Before this patch:
./tools/testing/kunit/kunit.py exec --arch=arm64 --cross_compile=aarch64-linux-
[11:03:38] Elapsed time: 15.494s

After this patch:
./tools/testing/kunit/kunit.py exec --arch=arm64 --cross_compile=aarch64-linux-
[11:10:47] Elapsed time: 19.099s

Thanks,
Kristina


