Return-Path: <linux-kselftest+bounces-4907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9016858D1E
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 05:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDEA281EC1
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 04:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1AB1BDF8;
	Sat, 17 Feb 2024 04:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bATRdNwj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9CD1B81C;
	Sat, 17 Feb 2024 04:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708142956; cv=none; b=RsN2IrAieE9Z5kmTyNCjAWsx4MdekWAMJqLcSqR5QoScWW6YW9wJYC1CURs2e2LMiYrlIm1hmMmDgzuL4jsX3R4BUknR7+SUcC5eJ+DyLUQz3dBymtI/vrFbIzsziXd/Qt/arsxP8HqPpg9Rd+iWCIUKD+X6H1buZZVcsaJJiFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708142956; c=relaxed/simple;
	bh=d00k38nDkdtCufCKXt4fUVGH0niOVU7PdSjJlZjnWNM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=h/3xVcNXWqoiVLHNUss6rrlKQESK44J29/KoABxmSol/gCo3S5YvWXnbhf/Py+cAcyTEMbivwsPvO1WEyfOIg6g4lxsKeRhZiG+/HfC7AEe0i96e0Sqb/QYGfifNDEleSLAuJDGJV5TTLIGegN6+xsMHb6jPo0C4qYGkIIARPCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bATRdNwj; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708142954; x=1739678954;
  h=date:from:to:cc:subject:message-id;
  bh=d00k38nDkdtCufCKXt4fUVGH0niOVU7PdSjJlZjnWNM=;
  b=bATRdNwjSXR9Ej3edu5NKKDAGpKdZ5SVwXuPqqTll2DpDyPUlh7emzEV
   UbjPZollTD6PM93kPrqFoFJZUlUSjO/nnuqOX+tjIvNn5HxzFLziG1Mdy
   O0HfixWH3gmf3BK/VK75/UoxxdxWFczwdPRjAbTccABdCLqhtSfKK3Tbq
   ygAZ5CNXQ3ROdVyDkF1h7ijkKdSU8KWgV5HLOucsPGsM4JCB4PUjramtR
   ZwkKDUBtpA1zieYA7/kGuSoZ2gHuiju7WuJg8e74laInQxpMO1ysrC8wW
   8vdRverigbSldGEInILZs6qPaB3O0Wan2cJpUYs+PDQo6gARjmr1Ev6z4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="13679078"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="13679078"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 20:09:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="8604153"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 16 Feb 2024 20:09:08 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbC0g-0001p6-1U;
	Sat, 17 Feb 2024 04:09:06 +0000
Date: Sat, 17 Feb 2024 12:08:51 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, coreteam@netfilter.org,
 dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
 linux-btrfs@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netfilter-devel@vger.kernel.org, nouveau@lists.freedesktop.org,
 ntfs3@lists.linux.dev
Subject: [linux-next:master] BUILD REGRESSION
 d37e1e4c52bc60578969f391fb81f947c3e83118
Message-ID: <202402171244.qZnVzq6W-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: d37e1e4c52bc60578969f391fb81f947c3e83118  Add linux-next specific files for 20240216

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202402161359.FurKTCOZ-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202402161410.IG9I4odj-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202402162252.FpEa3ZUY-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

aarch64-linux-ld: ktd2801-backlight.c:(.text+0x118): undefined reference to `expresswire_power_off'
aarch64-linux-ld: ktd2801-backlight.c:(.text+0x16c): undefined reference to `expresswire_enable'
drivers/gpu/drm/tests/drm_buddy_test.c:(.text.drm_test_buddy_alloc_contiguous+0xb0): undefined reference to `__umoddi3'
drivers/gpu/drm/tests/drm_buddy_test.c:48:(.text+0xfc): undefined reference to `__umoddi3'
ktd2801-backlight.c:(.text+0x118): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `expresswire_power_off'
ktd2801-backlight.c:(.text+0x16c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `expresswire_enable'
ktd2801-backlight.c:(.text+0xe4): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `expresswire_write_u8'
ktd2801-backlight.c:(.text+0xe4): undefined reference to `expresswire_write_u8'
xtensa-linux-ld: arch/xtensa/boot/lib/inftrees.c:220:(.text+0x4d3): undefined reference to `__ubsan_handle_shift_out_of_bounds'
xtensa-linux-ld: arch/xtensa/boot/lib/inftrees.c:96:(.text+0x152): undefined reference to `__ubsan_handle_out_of_bounds'

Unverified Error/Warning (likely false positive, please contact us if interested):

fs/btrfs/space-info.c:2012:13: warning: 'ret' may be used uninitialized [-Wmaybe-uninitialized]
include/linux/netfilter/x_tables.h:372: undefined reference to `xt_recseq'
include/linux/seqlock.h:72: undefined reference to `xt_recseq'
ld: include/linux/netfilter/x_tables.h:379: undefined reference to `xt_recseq'
ld: include/linux/seqlock.h:73: undefined reference to `xt_recseq'
ld: net/ipv4/netfilter/arp_tables.c:1014: undefined reference to `xt_find_table_lock'
ld: net/ipv4/netfilter/arp_tables.c:1469: undefined reference to `xt_find_revision'
ld: net/ipv4/netfilter/arp_tables.c:1497: undefined reference to `xt_free_table_info'
ld: net/ipv4/netfilter/arp_tables.c:1526: undefined reference to `xt_register_table'
ld: net/ipv4/netfilter/arp_tables.c:1648: undefined reference to `xt_unregister_targets'
ld: net/ipv4/netfilter/arp_tables.c:417: undefined reference to `xt_request_find_target'
ld: net/ipv4/netfilter/arp_tables.c:432: undefined reference to `xt_percpu_counter_free'
ld: net/ipv4/netfilter/arp_tables.c:900: undefined reference to `xt_request_find_table_lock'
ld: net/ipv4/netfilter/arp_tables.c:912: undefined reference to `xt_replace_table'
ld: net/ipv4/netfilter/arp_tables.c:944: undefined reference to `xt_table_unlock'
ld: net/ipv4/netfilter/arptable_filter.c:67: undefined reference to `xt_hook_ops_alloc'
ld: net/ipv4/netfilter/arptable_filter.c:75: undefined reference to `xt_unregister_template'
net/ipv4/netfilter/arp_tables.c:1010: undefined reference to `xt_copy_counters'
net/ipv4/netfilter/arp_tables.c:1040: undefined reference to `xt_table_unlock'
net/ipv4/netfilter/arp_tables.c:1469: undefined reference to `xt_find_revision'
net/ipv4/netfilter/arp_tables.c:1489: undefined reference to `xt_unregister_table'
net/ipv4/netfilter/arp_tables.c:1513: undefined reference to `xt_alloc_table_info'
net/ipv4/netfilter/arp_tables.c:1575: undefined reference to `xt_find_table'
net/ipv4/netfilter/arp_tables.c:1614: undefined reference to `xt_proto_init'
net/ipv4/netfilter/arp_tables.c:1619: undefined reference to `xt_proto_fini'
net/ipv4/netfilter/arp_tables.c:1636: undefined reference to `xt_register_targets'
net/ipv4/netfilter/arp_tables.c:1658: undefined reference to `xt_unregister_targets'
net/ipv4/netfilter/arp_tables.c:369: undefined reference to `xt_find_jump_offset'
net/ipv4/netfilter/arp_tables.c:401: undefined reference to `xt_check_target'
net/ipv4/netfilter/arp_tables.c:413: undefined reference to `xt_percpu_counter_alloc'
net/ipv4/netfilter/arp_tables.c:475: undefined reference to `xt_check_entry_offsets'
net/ipv4/netfilter/arp_tables.c:513: undefined reference to `xt_percpu_counter_free'
net/ipv4/netfilter/arp_tables.c:539: undefined reference to `xt_alloc_entry_offsets'
net/ipv4/netfilter/arp_tables.c:565: undefined reference to `xt_check_table_hooks'
net/ipv4/netfilter/arp_tables.c:611: undefined reference to `xt_recseq'
net/ipv4/netfilter/arp_tables.c:706: undefined reference to `xt_target_to_user'
net/ipv4/netfilter/arp_tables.c:808: undefined reference to `xt_request_find_table_lock'
net/ipv4/netfilter/arp_tables.c:862: undefined reference to `xt_find_table_lock'
net/ipv4/netfilter/arp_tables.c:894: undefined reference to `xt_counters_alloc'
net/ipv4/netfilter/arptable_filter.c:61: undefined reference to `xt_register_template'
net/ipv4/netfilter/arptable_filter.c:86: undefined reference to `xt_unregister_template'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- arc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- arc-randconfig-002-20240216
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   |-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- arc-randconfig-r051-20240216
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- arm-randconfig-003-20240216
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- arm64-defconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- arm64-randconfig-004-20240216
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- arm64-randconfig-r133-20240214
|   |-- aarch64-linux-ld:ktd2801-backlight.c:(.text):undefined-reference-to-expresswire_enable
|   |-- aarch64-linux-ld:ktd2801-backlight.c:(.text):undefined-reference-to-expresswire_power_off
|   |-- ktd2801-backlight.c:(.text):relocation-truncated-to-fit:R_AARCH64_CALL26-against-undefined-symbol-expresswire_enable
|   |-- ktd2801-backlight.c:(.text):relocation-truncated-to-fit:R_AARCH64_CALL26-against-undefined-symbol-expresswire_power_off
|   |-- ktd2801-backlight.c:(.text):relocation-truncated-to-fit:R_AARCH64_CALL26-against-undefined-symbol-expresswire_write_u8
|   `-- ktd2801-backlight.c:(.text):undefined-reference-to-expresswire_write_u8
|-- csky-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- csky-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- csky-randconfig-001-20240216
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- i386-buildonly-randconfig-005-20240216
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- i386-randconfig-003-20240216
|   |-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|   `-- include-kunit-test.h:warning:s-directive-argument-is-null
|-- i386-randconfig-005-20240216
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- loongarch-defconfig
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   `-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|-- loongarch-randconfig-001-20240216
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   |-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- loongarch-randconfig-002-20240216
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- microblaze-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- microblaze-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- mips-randconfig-r001-20221018
|   `-- drivers-gpu-drm-tests-drm_buddy_test.c:(.text.drm_test_buddy_alloc_contiguous):undefined-reference-to-__umoddi3
|-- openrisc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- parisc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- parisc-defconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- parisc-generic-32bit_defconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- parisc64-defconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- powerpc-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- powerpc-buildonly-randconfig-r006-20220721
|   `-- drivers-gpu-drm-tests-drm_buddy_test.c:(.text):undefined-reference-to-__umoddi3
|-- powerpc64-randconfig-003-20240216
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- riscv-randconfig-001-20240216
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- s390-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- s390-randconfig-001-20240216
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- s390-randconfig-002-20240216
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- sh-randconfig-002-20240216
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- sparc-allmodconfig
|   |-- Error:vdso-image-contains-dynamic-relocations
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   |-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|   |-- sparc64-linux-ld:vclock_gettime.c:(.text):undefined-reference-to-__ubsan_handle_shift_out_of_bounds
|   |-- sparc64-linux-objcopy:arch-sparc-vdso-vdso64.so.dbg:No-such-file
|   `-- vclock_gettime.c:(.text):undefined-reference-to-__ubsan_handle_shift_out_of_bounds
|-- sparc-randconfig-002-20240216
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- sparc-randconfig-r062-20240216
|   |-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- sparc64-allmodconfig
|   |-- Error:vdso-image-contains-dynamic-relocations
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   |-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|   |-- sparc64-linux-ld:vclock_gettime.c:(.text):undefined-reference-to-__ubsan_handle_shift_out_of_bounds
|   |-- sparc64-linux-objcopy:arch-sparc-vdso-vdso64.so.dbg:No-such-file
|   `-- vclock_gettime.c:(.text):undefined-reference-to-__ubsan_handle_shift_out_of_bounds
|-- sparc64-allyesconfig
|   |-- Error:vdso-image-contains-dynamic-relocations
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   |-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|   |-- sparc64-linux-ld:vclock_gettime.c:(.text):undefined-reference-to-__ubsan_handle_shift_out_of_bounds
|   |-- sparc64-linux-objcopy:arch-sparc-vdso-vdso64.so.dbg:No-such-file
|   `-- vclock_gettime.c:(.text):undefined-reference-to-__ubsan_handle_shift_out_of_bounds
|-- sparc64-randconfig-001-20240216
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- sparc64-randconfig-002-20240216
|   |-- Error:vdso-image-contains-dynamic-relocations
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   |-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|   |-- sparc64-linux-ld:vclock_gettime.c:(.text):undefined-reference-to-__ubsan_handle_shift_out_of_bounds
|   |-- sparc64-linux-objcopy:arch-sparc-vdso-vdso64.so.dbg:No-such-file
|   `-- vclock_gettime.c:(.text):undefined-reference-to-__ubsan_handle_shift_out_of_bounds
|-- sparc64-randconfig-r061-20240216
|   |-- Error:vdso-image-contains-dynamic-relocations
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   |-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|   |-- sparc64-linux-ld:vclock_gettime.c:(.text):undefined-reference-to-__ubsan_handle_shift_out_of_bounds
|   |-- sparc64-linux-objcopy:arch-sparc-vdso-vdso64.so.dbg:No-such-file
|   `-- vclock_gettime.c:(.text):undefined-reference-to-__ubsan_handle_shift_out_of_bounds
|-- um-allyesconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- um-randconfig-002-20240216
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- um-randconfig-r012-20230713
|   `-- fs-btrfs-space-info.c:warning:ret-may-be-used-uninitialized
|-- x86_64-randconfig-004-20240216
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   `-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|-- x86_64-randconfig-014-20240216
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-123-20240216
|   |-- include-linux-netfilter-x_tables.h:undefined-reference-to-xt_recseq
|   |-- include-linux-seqlock.h:undefined-reference-to-xt_recseq
|   |-- ld:include-linux-netfilter-x_tables.h:undefined-reference-to-xt_recseq
|   |-- ld:include-linux-seqlock.h:undefined-reference-to-xt_recseq
|   |-- ld:net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_find_revision
|   |-- ld:net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_find_table_lock
|   |-- ld:net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_free_table_info
|   |-- ld:net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_percpu_counter_free
|   |-- ld:net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_register_table
|   |-- ld:net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_replace_table
|   |-- ld:net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_request_find_table_lock
|   |-- ld:net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_request_find_target
|   |-- ld:net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_table_unlock
|   |-- ld:net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_unregister_targets
|   |-- ld:net-ipv4-netfilter-arptable_filter.c:undefined-reference-to-xt_hook_ops_alloc
|   |-- ld:net-ipv4-netfilter-arptable_filter.c:undefined-reference-to-xt_unregister_template
|   |-- net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_alloc_entry_offsets
|   |-- net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_alloc_table_info
|   |-- net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_check_entry_offsets
|   |-- net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_check_table_hooks
|   |-- net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_check_target
|   |-- net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_copy_counters
|   |-- net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_counters_alloc
|   |-- net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_find_jump_offset
|   |-- net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_find_revision
|   |-- net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_find_table
|   |-- net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_find_table_lock
|   |-- net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_percpu_counter_alloc
|   |-- net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_percpu_counter_free
|   |-- net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_proto_fini
|   |-- net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_proto_init
|   |-- net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_recseq
|   |-- net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_register_targets
|   |-- net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_request_find_table_lock
|   |-- net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_table_unlock
|   |-- net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_target_to_user
|   |-- net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_unregister_table
|   |-- net-ipv4-netfilter-arp_tables.c:undefined-reference-to-xt_unregister_targets
|   |-- net-ipv4-netfilter-arptable_filter.c:undefined-reference-to-xt_register_template
|   `-- net-ipv4-netfilter-arptable_filter.c:undefined-reference-to-xt_unregister_template
|-- x86_64-randconfig-161-20240215
|   `-- mm-page_owner.c-stack_print()-warn:unsigned-nr_entries-is-never-less-than-zero.
|-- xtensa-randconfig-002-20240216
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   `-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|-- xtensa-randconfig-c004-20220612
|   |-- xtensa-linux-ld:arch-xtensa-boot-lib-inftrees.c:(.text):undefined-reference-to-__ubsan_handle_out_of_bounds
|   `-- xtensa-linux-ld:arch-xtensa-boot-lib-inftrees.c:(.text):undefined-reference-to-__ubsan_handle_shift_out_of_bounds
`-- xtensa-randconfig-r054-20240216
    `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
clang_recent_errors
|-- arm-defconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- arm-randconfig-001-20240216
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- arm64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- arm64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- i386-randconfig-002-20240216
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- i386-randconfig-014-20240216
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- powerpc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- powerpc-randconfig-001-20240216
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- powerpc-randconfig-002-20240216
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   |-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- riscv-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- riscv-defconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- s390-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- x86_64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- x86_64-buildonly-randconfig-002-20240216
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- x86_64-buildonly-randconfig-003-20240216
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- x86_64-buildonly-randconfig-004-20240216
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-buildonly-randconfig-006-20240216
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-002-20240216
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-006-20240216
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- x86_64-randconfig-016-20240216
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- x86_64-randconfig-075-20240216
|   |-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-103-20240216
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
|   |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
`-- x86_64-randconfig-161-20240216
    |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_get_wptr
    |-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_irq_rearm
    `-- drivers-gpu-drm-amd-amdgpu-ih_v7_0.c:warning:Function-parameter-or-struct-member-ih-not-described-in-ih_v7_0_set_rptr

elapsed time: 1468m

configs tested: 176
configs skipped: 6

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240216   gcc  
arc                   randconfig-002-20240216   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240216   clang
arm                   randconfig-002-20240216   clang
arm                   randconfig-003-20240216   gcc  
arm                   randconfig-004-20240216   gcc  
arm                         s5pv210_defconfig   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240216   clang
arm64                 randconfig-002-20240216   gcc  
arm64                 randconfig-003-20240216   clang
arm64                 randconfig-004-20240216   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240216   gcc  
csky                  randconfig-002-20240216   gcc  
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240216   clang
hexagon               randconfig-002-20240216   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240216   gcc  
i386         buildonly-randconfig-002-20240216   clang
i386         buildonly-randconfig-003-20240216   clang
i386         buildonly-randconfig-004-20240216   gcc  
i386         buildonly-randconfig-005-20240216   gcc  
i386         buildonly-randconfig-006-20240216   clang
i386                                defconfig   clang
i386                  randconfig-001-20240216   clang
i386                  randconfig-002-20240216   clang
i386                  randconfig-003-20240216   gcc  
i386                  randconfig-004-20240216   clang
i386                  randconfig-005-20240216   gcc  
i386                  randconfig-006-20240216   clang
i386                  randconfig-011-20240216   gcc  
i386                  randconfig-012-20240216   gcc  
i386                  randconfig-013-20240216   gcc  
i386                  randconfig-014-20240216   clang
i386                  randconfig-015-20240216   gcc  
i386                  randconfig-016-20240216   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240216   gcc  
loongarch             randconfig-002-20240216   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip22_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240216   gcc  
nios2                 randconfig-002-20240216   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240216   gcc  
parisc                randconfig-002-20240216   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    gamecube_defconfig   clang
powerpc                   lite5200b_defconfig   clang
powerpc                      makalu_defconfig   clang
powerpc                      pasemi_defconfig   clang
powerpc               randconfig-001-20240216   clang
powerpc               randconfig-002-20240216   clang
powerpc               randconfig-003-20240216   clang
powerpc                    socrates_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20240216   clang
powerpc64             randconfig-002-20240216   clang
powerpc64             randconfig-003-20240216   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240216   gcc  
riscv                 randconfig-002-20240216   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240216   gcc  
s390                  randconfig-002-20240216   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240216   gcc  
sh                    randconfig-002-20240216   gcc  
sh                          rsk7264_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240216   gcc  
sparc64               randconfig-002-20240216   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240216   gcc  
um                    randconfig-002-20240216   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240216   clang
x86_64       buildonly-randconfig-002-20240216   clang
x86_64       buildonly-randconfig-003-20240216   clang
x86_64       buildonly-randconfig-004-20240216   clang
x86_64       buildonly-randconfig-005-20240216   gcc  
x86_64       buildonly-randconfig-006-20240216   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240216   gcc  
x86_64                randconfig-002-20240216   clang
x86_64                randconfig-003-20240216   gcc  
x86_64                randconfig-004-20240216   gcc  
x86_64                randconfig-005-20240216   gcc  
x86_64                randconfig-006-20240216   clang
x86_64                randconfig-011-20240216   gcc  
x86_64                randconfig-012-20240216   gcc  
x86_64                randconfig-013-20240216   clang
x86_64                randconfig-014-20240216   gcc  
x86_64                randconfig-015-20240216   clang
x86_64                randconfig-016-20240216   clang
x86_64                randconfig-071-20240216   clang
x86_64                randconfig-072-20240216   clang
x86_64                randconfig-073-20240216   gcc  
x86_64                randconfig-074-20240216   gcc  
x86_64                randconfig-075-20240216   clang
x86_64                randconfig-076-20240216   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240216   gcc  
xtensa                randconfig-002-20240216   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

