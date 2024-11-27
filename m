Return-Path: <linux-kselftest+bounces-22562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E76C9DA4CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 10:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33B3162452
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 09:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D226192B71;
	Wed, 27 Nov 2024 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="WxFr0b7U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F0B13A888;
	Wed, 27 Nov 2024 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732699936; cv=none; b=fxWE1mX87/P6uu2ry1JeejwWZ36bhSWHzR2DmawKlKCLR48IyN2LjO7izNkQXwhEDvtZQn7086bs1CPXfehg5Chs5QjthVe9XHE3GYx6ZwOBH6jQ4VBDI72wYgCixYMAxr5iKbNu8Q2pQVPuzKYCKS3QVRpuVpKkOpZEk1hnsPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732699936; c=relaxed/simple;
	bh=wxQJcGsICd3KIeU8jFxiDMX1ngCI1BT0PMSXDV81QGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CADMc5LyGnONYb4+ZywI+JOhOHVwNvIgcFjJqNH8gfSDqPSKWBAvQMmcMoOZ7/o+HgjSbwTDCDFkb85Kf710KR9erdNW+tbEquZESxWerqx2Bry3Jvx72uwbaS425aiV5JrHRlMY36R3choHVlvhjv79YD1UYn+8LkcabPM1e38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=WxFr0b7U; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1732699920; bh=KQLv7DyKBvJY49Hj+E2Xd/1kZZcmGL5Ac23UKNM7GE8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WxFr0b7Ufi+v/ewE1sYAwZeEvR2MPSNyWlUqHHiRkQfyklx0fdHPYhVF9OWkFZvHU
	 ZUGuVNPFYrJvt764HygAqsCIgpvyFacVx24UIApo1mUnr9HDQJNxjeoRHSKwjcID3K
	 LWhm1AqO88wIxshM/ETHampC4MCcXTxMkRAuHLB0=
Received: from [IPV6:2408:8207:18a1:fd2f:65b1:a9d:3208:8f6d] ([2408:8207:18a1:fd2f:65b1:a9d:3208:8f6d])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 5D8B8E2D; Wed, 27 Nov 2024 17:23:24 +0800
X-QQ-mid: xmsmtpt1732699404tfvazdkak
Message-ID: <tencent_0D44A7B1860F54D04B7BC7310AB73B863B05@qq.com>
X-QQ-XMAILINFO: OKKHiI6c9SH3X8+nzulmDBJOKL6PRd/0sZ947R8btcoAQ5A+izGCpWVJpyVavC
	 nhUak2ksW00DyIbOW+lIkAIVh0w7BXpbfZysTNbvmbQj/HF4BHrp+JhC5EndiiUNV60pZh4sYaYe
	 mTi1sJEmwb4F5R7TKmeObzg6ncp5cTLGjO9qQHG6y3WLVYHKCMGlNo2ERFiYuwlhHwphaJAt6pIP
	 W7favRjs+V61qso0o0hD8KIdv9VrvOXYOp1l2j3ceVbaMgMO0vAYNOf6gr9sFv/0je+Eck4zUD6r
	 y+feQ2nZdfbNntOYioRinsWWlmESRhdV7Bf7ug/Lp9P83sUsP8QJHyO64kMHCmfqSY5eXdJHEkp2
	 NJ6GkCQbLfH2D9zH0du2Nd2/1/xfDBLb8S2nCYzxnNuq4TSkoDtzwphdWEDw3Q1SNCaroihIbIua
	 etSr9Ui5evN/YeQw7btI/sux5NC45TLjQzjrUglIs/HYmpA8hzbwracueZlxMNPvatbWBGMe1P4I
	 PXygQlqQCKpwCy4K5gUqXdcUGNPb6Jk93LiYJHg8Eruv8/rDt4PErsYAHqrTWpGE4I4zZjMIYDmX
	 3JjtnxKAk5WPg305DRRebKkqg0aREDn7ksnMonrs+QO0qz2/xmzftV0BHj7T4kGwmzOBm0rtWw2e
	 b4ytMnJ/VrWCFv5kIbsgnzFb3a+HxfqFYUXPd7PCb3uh3m+mVt7+M8cjHz3jmCob3wv/hpE9Fcfj
	 rHqjbk4B1RctF3DLvkSj98GADHONimxpIv0XIEtkh2no4r9ofviAA/5ziUfX9RxBciKVj/BSuKUF
	 cF+X2uAQbVooUrJpy8svE6MA2XPt1Ujf8e+Y+U1sDTK60i1+4lyyZ/BTgqSIxCfMMfQpVyqgApEI
	 X+og5QQhzh50RK8l4UuYkxxOT4jR+xSFPtSsimozLcGq1EMcWfV0omdAcQQ5KKGJG9DDQeT1tcga
	 B340RBaBVFeycZYQ9JnIC60Y3Ikygq0g8B0/IWvSfDL2iK+5ipDQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-OQ-MSGID: <91abdb28-cbd1-4ecd-9d39-67f00703deaa@cyyself.name>
Date: Wed, 27 Nov 2024 17:23:24 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/14] riscv: Add support for xtheadvector
To: Charlie Jenkins <charlie@rivosinc.com>, Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Samuel Holland <samuel.holland@sifive.com>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Guo Ren
 <guoren@kernel.org>, Evan Green <evan@rivosinc.com>,
 Jessica Clarke <jrtc27@jrtc27.com>, Andrew Jones <ajones@ventanamicro.com>,
 Andy Chiu <andybnac@gmail.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>
References: <20241113-xtheadvector-v11-0-236c22791ef9@rivosinc.com>
Content-Language: en-US
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20241113-xtheadvector-v11-0-236c22791ef9@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Tested-by: Yangyu Chen <cyy@cyyself.name>

I applied and tested it on Nezha hardware, and it works fine.

Cheers,
Yangyu Chen

On 11/14/24 10:21, Charlie Jenkins wrote:
> xtheadvector is a custom extension that is based upon riscv vector
> version 0.7.1 [1]. All of the vector routines have been modified to
> support this alternative vector version based upon whether xtheadvector
> was determined to be supported at boot.
> 
> vlenb is not supported on the existing xtheadvector hardware, so a
> devicetree property thead,vlenb is added to provide the vlenb to Linux.
> 
> There is a new hwprobe key RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 that is
> used to request which thead vendor extensions are supported on the
> current platform. This allows future vendors to allocate hwprobe keys
> for their vendor.
> 
> Support for xtheadvector is also added to the vector kselftests.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> 
> [1] https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cca9489361c61d335e03d3134b14133f/xtheadvector.adoc
> 
> ---
> This series is a continuation of a different series that was fragmented
> into two other series in an attempt to get part of it merged in the 6.10
> merge window. The split-off series did not get merged due to a NAK on
> the series that added the generic riscv,vlenb devicetree entry. This
> series has converted riscv,vlenb to thead,vlenb to remedy this issue.
> 
> The original series is titled "riscv: Support vendor extensions and
> xtheadvector" [3].
> 
> I have tested this with an Allwinner Nezha board. I used SkiffOS [1] to
> manage building the image, but upgraded the U-Boot version to Samuel
> Holland's more up-to-date version [2] and changed out the device tree
> used by U-Boot with the device trees that are present in upstream linux
> and this series. Thank you Samuel for all of the work you did to make
> this task possible.
> 
> [1] https://github.com/skiffos/SkiffOS/tree/master/configs/allwinner/nezha
> [2] https://github.com/smaeul/u-boot/commit/2e89b706f5c956a70c989cd31665f1429e9a0b48
> [3] https://lore.kernel.org/all/20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com/
> [4] https://lore.kernel.org/lkml/20240719-support_vendor_extensions-v3-4-0af7587bbec0@rivosinc.com/T/
> 
> ---
> Changes in v11:
> - Fix an issue where the mitigation was not being properly skipped when
>    requested
> - Fix vstate_discard issue
> - Fix issue when -1 was passed into
>    __riscv_isa_vendor_extension_available()
> - Remove some artifacts from being placed in the test directory
> - Link to v10: https://lore.kernel.org/r/20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com
> 
> Changes in v10:
> - In DT probing disable vector with new function to clear vendor
>    extension bits for xtheadvector
> - Add ghostwrite mitigations for c9xx CPUs. This disables xtheadvector
>    unless mitigations=off is set as a kernel boot arg
> - Link to v9: https://lore.kernel.org/r/20240806-xtheadvector-v9-0-62a56d2da5d0@rivosinc.com
> 
> Changes in v9:
> - Rebase onto palmer's for-next
> - Fix sparse error in arch/riscv/kernel/vendor_extensions/thead.c
> - Fix maybe-uninitialized warning in arch/riscv/include/asm/vendor_extensions/vendor_hwprobe.h
> - Wrap some long lines
> - Link to v8: https://lore.kernel.org/r/20240724-xtheadvector-v8-0-cf043168e137@rivosinc.com
> 
> Changes in v8:
> - Rebase onto palmer's for-next
> - Link to v7: https://lore.kernel.org/r/20240724-xtheadvector-v7-0-b741910ada3e@rivosinc.com
> 
> Changes in v7:
> - Add defs for has_xtheadvector_no_alternatives() and has_xtheadvector()
>    when vector disabled. (Palmer)
> - Link to v6: https://lore.kernel.org/r/20240722-xtheadvector-v6-0-c9af0130fa00@rivosinc.com
> 
> Changes in v6:
> - Fix return type of is_vector_supported()/is_xthead_supported() to be bool
> - Link to v5: https://lore.kernel.org/r/20240719-xtheadvector-v5-0-4b485fc7d55f@rivosinc.com
> 
> Changes in v5:
> - Rebase on for-next
> - Link to v4: https://lore.kernel.org/r/20240702-xtheadvector-v4-0-2bad6820db11@rivosinc.com
> 
> Changes in v4:
> - Replace inline asm with C (Samuel)
> - Rename VCSRs to CSRs (Samuel)
> - Replace .insn directives with .4byte directives
> - Link to v3: https://lore.kernel.org/r/20240619-xtheadvector-v3-0-bff39eb9668e@rivosinc.com
> 
> Changes in v3:
> - Add back Heiko's signed-off-by (Conor)
> - Mark RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 as a bitmask
> - Link to v2: https://lore.kernel.org/r/20240610-xtheadvector-v2-0-97a48613ad64@rivosinc.com
> 
> Changes in v2:
> - Removed extraneous references to "riscv,vlenb" (Jess)
> - Moved declaration of "thead,vlenb" into cpus.yaml and added
>    restriction that it's only applicable to thead cores (Conor)
> - Check CONFIG_RISCV_ISA_XTHEADVECTOR instead of CONFIG_RISCV_ISA_V for
>    thead,vlenb (Jess)
> - Fix naming of hwprobe variables (Evan)
> - Link to v1: https://lore.kernel.org/r/20240609-xtheadvector-v1-0-3fe591d7f109@rivosinc.com
> 
> ---
> Charlie Jenkins (13):
>        dt-bindings: riscv: Add xtheadvector ISA extension description
>        dt-bindings: cpus: add a thead vlen register length property
>        riscv: dts: allwinner: Add xtheadvector to the D1/D1s devicetree
>        riscv: Add thead and xtheadvector as a vendor extension
>        riscv: vector: Use vlenb from DT for thead
>        riscv: csr: Add CSR encodings for CSR_VXRM/CSR_VXSAT
>        riscv: Add xtheadvector instruction definitions
>        riscv: vector: Support xtheadvector save/restore
>        riscv: hwprobe: Add thead vendor extension probing
>        riscv: hwprobe: Document thead vendor extensions and xtheadvector extension
>        selftests: riscv: Fix vector tests
>        selftests: riscv: Support xtheadvector in vector tests
>        riscv: Add ghostwrite vulnerability
> 
> Heiko Stuebner (1):
>        RISC-V: define the elements of the VCSR vector CSR
> 
>   Documentation/arch/riscv/hwprobe.rst               |  10 +
>   Documentation/devicetree/bindings/riscv/cpus.yaml  |  19 ++
>   .../devicetree/bindings/riscv/extensions.yaml      |  10 +
>   arch/riscv/Kconfig.errata                          |  11 +
>   arch/riscv/Kconfig.vendor                          |  26 ++
>   arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi      |   3 +-
>   arch/riscv/errata/thead/errata.c                   |  28 ++
>   arch/riscv/include/asm/bugs.h                      |  22 ++
>   arch/riscv/include/asm/cpufeature.h                |   2 +
>   arch/riscv/include/asm/csr.h                       |  15 +
>   arch/riscv/include/asm/errata_list.h               |   3 +-
>   arch/riscv/include/asm/hwprobe.h                   |   3 +-
>   arch/riscv/include/asm/switch_to.h                 |   2 +-
>   arch/riscv/include/asm/vector.h                    | 222 +++++++++++----
>   arch/riscv/include/asm/vendor_extensions/thead.h   |  47 ++++
>   .../include/asm/vendor_extensions/thead_hwprobe.h  |  19 ++
>   .../include/asm/vendor_extensions/vendor_hwprobe.h |  37 +++
>   arch/riscv/include/uapi/asm/hwprobe.h              |   3 +-
>   arch/riscv/include/uapi/asm/vendor/thead.h         |   3 +
>   arch/riscv/kernel/Makefile                         |   2 +
>   arch/riscv/kernel/bugs.c                           |  60 ++++
>   arch/riscv/kernel/cpufeature.c                     |  59 +++-
>   arch/riscv/kernel/kernel_mode_vector.c             |   8 +-
>   arch/riscv/kernel/process.c                        |   4 +-
>   arch/riscv/kernel/signal.c                         |   6 +-
>   arch/riscv/kernel/sys_hwprobe.c                    |   5 +
>   arch/riscv/kernel/vector.c                         |  24 +-
>   arch/riscv/kernel/vendor_extensions.c              |  10 +
>   arch/riscv/kernel/vendor_extensions/Makefile       |   2 +
>   arch/riscv/kernel/vendor_extensions/thead.c        |  29 ++
>   .../riscv/kernel/vendor_extensions/thead_hwprobe.c |  19 ++
>   drivers/base/cpu.c                                 |   3 +
>   include/linux/cpu.h                                |   1 +
>   tools/testing/selftests/riscv/vector/.gitignore    |   3 +-
>   tools/testing/selftests/riscv/vector/Makefile      |  17 +-
>   .../selftests/riscv/vector/v_exec_initval_nolibc.c |  94 +++++++
>   tools/testing/selftests/riscv/vector/v_helpers.c   |  68 +++++
>   tools/testing/selftests/riscv/vector/v_helpers.h   |   8 +
>   tools/testing/selftests/riscv/vector/v_initval.c   |  22 ++
>   .../selftests/riscv/vector/v_initval_nolibc.c      |  68 -----
>   .../selftests/riscv/vector/vstate_exec_nolibc.c    |  20 +-
>   .../testing/selftests/riscv/vector/vstate_prctl.c  | 305 +++++++++++++--------
>   42 files changed, 1051 insertions(+), 271 deletions(-)
> ---
> base-commit: 0eb512779d642b21ced83778287a0f7a3ca8f2a1
> change-id: 20240530-xtheadvector-833d3d17b423


