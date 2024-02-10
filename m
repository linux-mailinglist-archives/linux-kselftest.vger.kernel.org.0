Return-Path: <linux-kselftest+bounces-4488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3D38502CC
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Feb 2024 07:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A3F282D23
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Feb 2024 06:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748EC18030;
	Sat, 10 Feb 2024 06:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXdk3bfM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A604A63B3;
	Sat, 10 Feb 2024 06:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707547813; cv=none; b=tWjumIcL5crF9zT98FfpzZhFbkCHxYFLWW9/IWahmJ5PU/+Vmzw1NQXTwQlkXXKJf/tgOmLTjbwkTfW++ShtL7e+Z8VaIWJgbDiAe/4q6l+D+n6iyf0IH8xc2qYE5JQWFqsj7jX2xgpn8CUGP2AC42Vkb1VDKIy/NlBjZQUFOPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707547813; c=relaxed/simple;
	bh=Dkk/Bm/1xnljdqqsUyITGRzaYpO/Mw3lpaWdV+bI4Kg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mm2HNmUixSyWtGDXvpMWs4mneiZP24BqQ9dfTH6E6r4yCFq1H6t2iTeSOyd7WUUaLtEe4aAC850LCd6zSNOhY9jg7sIsGn/hBM1EkVerzGnzz3daMAGeubu32xfwO0NWlAzUJSevPMhhpw/6dGGJQG369UQEtSes6TBGzveXtQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXdk3bfM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707547810; x=1739083810;
  h=date:from:to:cc:subject:message-id;
  bh=Dkk/Bm/1xnljdqqsUyITGRzaYpO/Mw3lpaWdV+bI4Kg=;
  b=YXdk3bfMIR01/I3ItIfA9NhzKBCxKfMT0nUpXs2xKWKmwjj2mMqW4Whf
   1wlzTUerXTa7ChwkGEg0zwhizB5yrV1DujKD3qzi7jXlJze01O+FDrv/2
   9S/foR4nOKrOCa6Eh4E7dGKQx252/BvWv51OR9PM5XqZJ8QkibUnyb26F
   cAI21C2w56jYuxUiLJ+0t5mz5wsjurcaBhwTG7ioRNsXtcTlk80CWvhih
   0vqdDVzXZm52AVdx8rayjeNLOvWjABl6/KZGW2kI2MQY4L4fZBhaRZOL6
   WxJloOLqE8gZvuEdcoFzNX/UMRhOcA6CDcRiCdMqZjJrSX6jAi1ryo9uV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="12631920"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="12631920"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 22:50:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="2335400"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 09 Feb 2024 22:50:06 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYhBb-0005Pi-1t;
	Sat, 10 Feb 2024 06:50:03 +0000
Date: Sat, 10 Feb 2024 14:49:41 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 ceph-devel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kunit-dev@googlegroups.com, linux-bcachefs@vger.kernel.org,
 linux-kselftest@vger.kernel.org, nouveau@lists.freedesktop.org,
 ntfs3@lists.linux.dev, rcu@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 445a555e0623387fa9b94e68e61681717e70200a
Message-ID: <202402101433.KivJLhsc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 445a555e0623387fa9b94e68e61681717e70200a  Add linux-next specific files for 20240209

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202402091752.dGmPjA49-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202402091848.rFySykYW-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202402092153.bTekesmI-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202402100625.M0RkJhMh-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/sh/boot/compressed/../../../../lib/zlib_inflate/inflate.c:503:(.text+0x11d0): undefined reference to `__ubsan_handle_out_of_bounds'
arch/sh/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:229:(.text+0x490): undefined reference to `__ubsan_handle_out_of_bounds'
arch/xtensa/boot/lib/inffast.c:113:(.text+0x9b): undefined reference to `__ubsan_handle_shift_out_of_bounds'
arch/xtensa/boot/lib/inftrees.c:219:(.text+0x3e7): undefined reference to `__ubsan_handle_shift_out_of_bounds'
arch/xtensa/boot/lib/inftrees.c:94:(.text+0xcf): undefined reference to `__ubsan_handle_out_of_bounds'
kernel/locking/irqflag-debug.c:8:1: warning: 'no_sanitize' attribute directive ignored [-Wattributes]
kernel/locking/lockdep.c:883:1: warning: 'no_sanitize' attribute directive ignored [-Wattributes]
kernel/rcu/update.c:319:1: warning: 'no_sanitize' attribute directive ignored [-Wattributes]
kernel/sched/idle.c:53:1: warning: 'no_sanitize' attribute directive ignored [-Wattributes]
kernel/time/timekeeping.c:1045:1: warning: 'no_sanitize' attribute directive ignored [-Wattributes]
kismet: WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE when selected by BACKLIGHT_KTD2801
kismet: WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE when selected by LEDS_KTD2692
make[2]: *** kselftest/livepatch/test_modules: No such file or directory.  Stop.
s390-linux-ld: iptable_nat.c:(.text+0x14c): undefined reference to `ipt_register_table'
s390-linux-ld: iptable_nat.c:(.text+0x330): undefined reference to `ipt_unregister_table_exit'
s390-linux-ld: net/ipv4/netfilter/iptable_nat.o:(.data.rel.ro+0x0): undefined reference to `ipt_do_table'
sh4-linux-ld: arch/sh/boot/compressed/../../../../lib/zlib_inflate/inflate.c:547:(.text+0x1388): undefined reference to `__ubsan_handle_out_of_bounds'
sh4-linux-ld: arch/sh/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:315:(.text+0x69c): undefined reference to `__ubsan_handle_out_of_bounds'
xtensa-linux-ld: arch/xtensa/boot/lib/inffast.o:(.text+0x24): undefined reference to `__ubsan_handle_shift_out_of_bounds'
xtensa-linux-ld: arch/xtensa/boot/lib/inftrees.o:(.text+0x84): undefined reference to `__ubsan_handle_shift_out_of_bounds'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allnoconfig
|   |-- kismet:WARNING:unmet-direct-dependencies-detected-for-LEDS_EXPRESSWIRE-when-selected-by-BACKLIGHT_KTD2801
|   `-- kismet:WARNING:unmet-direct-dependencies-detected-for-LEDS_EXPRESSWIRE-when-selected-by-LEDS_KTD2692
|-- alpha-allyesconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- arc-allmodconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- arc-allyesconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- arc-randconfig-001-20240209
|   |-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- arc-randconfig-002-20240209
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- arm-allmodconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- arm-allyesconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- arm-randconfig-002-20240209
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- arm-randconfig-003-20240209
|   |-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- arm-randconfig-r111-20240209
|   `-- drivers-video-backlight-ktd2801-backlight.c:sparse:sparse:symbol-ktd2801_timing-was-not-declared.-Should-it-be-static
|-- arm64-defconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- csky-allmodconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- csky-allyesconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- i386-allmodconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- i386-allyesconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- i386-buildonly-randconfig-003-20240209
|   |-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- i386-buildonly-randconfig-006-20240209
|   `-- fs-ceph-locks.c:warning:unused-variable-lock
|-- i386-randconfig-002-20240209
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- i386-randconfig-006-20240209
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- i386-randconfig-012-20240209
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- i386-randconfig-014-20240209
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- i386-randconfig-051-20240209
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- i386-randconfig-052-20240209
|   `-- include-kunit-test.h:warning:s-directive-argument-is-null
|-- i386-randconfig-141-20240209
|   |-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|   |-- fs-bcachefs-btree_locking.c-bch2_trans_relock()-warn:passing-zero-to-PTR_ERR
|   `-- fs-bcachefs-buckets.c-bch2_trans_account_disk_usage_change()-error:we-previously-assumed-trans-disk_res-could-be-null-(see-line-)
|-- loongarch-allmodconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- loongarch-randconfig-001-20240209
|   |-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- loongarch-randconfig-002-20240209
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- microblaze-allmodconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- microblaze-allyesconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- mips-allyesconfig
|   |-- (.ref.text):relocation-truncated-to-fit:R_MIPS_26-against-start_secondary
|   |-- (.text):relocation-truncated-to-fit:R_MIPS_26-against-kernel_entry
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- nios2-randconfig-001-20240209
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- openrisc-allyesconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- parisc-allmodconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- parisc-allyesconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- parisc-defconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- parisc64-defconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- powerpc-allmodconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- powerpc-randconfig-003-20240209
|   |-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- s390-allyesconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- s390-randconfig-r011-20220213
|   |-- s390-linux-ld:iptable_nat.c:(.text):undefined-reference-to-ipt_register_table
|   |-- s390-linux-ld:iptable_nat.c:(.text):undefined-reference-to-ipt_unregister_table_exit
|   `-- s390-linux-ld:net-ipv4-netfilter-iptable_nat.o:(.data.rel.ro):undefined-reference-to-ipt_do_table
|-- sh-randconfig-r022-20221111
|   |-- arch-sh-boot-compressed-..-..-..-..-lib-zlib_inflate-inflate.c:(.text):undefined-reference-to-__ubsan_handle_out_of_bounds
|   |-- arch-sh-boot-compressed-..-..-..-..-lib-zlib_inflate-inftrees.c:(.text):undefined-reference-to-__ubsan_handle_out_of_bounds
|   |-- sh4-linux-ld:arch-sh-boot-compressed-..-..-..-..-lib-zlib_inflate-inflate.c:(.text):undefined-reference-to-__ubsan_handle_out_of_bounds
|   `-- sh4-linux-ld:arch-sh-boot-compressed-..-..-..-..-lib-zlib_inflate-inftrees.c:(.text):undefined-reference-to-__ubsan_handle_out_of_bounds
|-- sparc-allmodconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- sparc-randconfig-002-20240209
|   `-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|-- sparc64-allmodconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- sparc64-allyesconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- sparc64-randconfig-001-20240209
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- sparc64-randconfig-002-20240209
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- um-allyesconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- um-randconfig-001-20240209
|   |-- kernel-locking-irqflag-debug.c:warning:no_sanitize-attribute-directive-ignored
|   |-- kernel-locking-lockdep.c:warning:no_sanitize-attribute-directive-ignored
|   |-- kernel-rcu-update.c:warning:no_sanitize-attribute-directive-ignored
|   |-- kernel-sched-idle.c:warning:no_sanitize-attribute-directive-ignored
|   `-- kernel-time-timekeeping.c:warning:no_sanitize-attribute-directive-ignored
|-- x86_64-buildonly-randconfig-001-20240209
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-buildonly-randconfig-004-20240209
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-002-20240209
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-005-20240209
|   |-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-075-20240209
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- x86_64-randconfig-161-20240209
|   |-- fs-bcachefs-btree_locking.c-bch2_trans_relock()-warn:passing-zero-to-PTR_ERR
|   |-- fs-bcachefs-buckets.c-bch2_trans_account_disk_usage_change()-error:we-previously-assumed-trans-disk_res-could-be-null-(see-line-)
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-rhel-8.3-bpf
|   `-- make:kselftest-livepatch-test_modules:No-such-file-or-directory.-Stop.
|-- xtensa-randconfig-001-20240209
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- xtensa-randconfig-002-20240209
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
`-- xtensa-randconfig-r013-20220209
    |-- arch-xtensa-boot-lib-inffast.c:(.text):undefined-reference-to-__ubsan_handle_shift_out_of_bounds
    |-- arch-xtensa-boot-lib-inftrees.c:(.text):undefined-reference-to-__ubsan_handle_out_of_bounds
    |-- arch-xtensa-boot-lib-inftrees.c:(.text):undefined-reference-to-__ubsan_handle_shift_out_of_bounds
    |-- xtensa-linux-ld:arch-xtensa-boot-lib-inffast.o:(.text):undefined-reference-to-__ubsan_handle_shift_out_of_bounds
    `-- xtensa-linux-ld:arch-xtensa-boot-lib-inftrees.o:(.text):undefined-reference-to-__ubsan_handle_shift_out_of_bounds
clang_recent_errors
|-- arm-defconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- arm64-allmodconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- arm64-allyesconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- hexagon-randconfig-001-20240209
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- i386-buildonly-randconfig-004-20240209
|   `-- fs-ceph-locks.c:warning:unused-variable-lock
|-- i386-randconfig-005-20240209
|   |-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- i386-randconfig-054-20240209
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- powerpc-allyesconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- powerpc-randconfig-001-20240209
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- powerpc64-randconfig-002-20240209
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- riscv-allmodconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- riscv-allyesconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- riscv-defconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- riscv-randconfig-001-20240209
|   `-- fs-ceph-locks.c:warning:unused-variable-lock
|-- s390-allmodconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- x86_64-allmodconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- x86_64-allyesconfig
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- x86_64-buildonly-randconfig-005-20240209
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-011-20240209
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-012-20240209
|   `-- drivers-gpu-drm-nouveau-nvkm-subdev-gsp-r535.c:warning:Function-parameter-or-struct-member-gsp-not-described-in-nvkm_gsp_radix3_sg
|-- x86_64-randconfig-073-20240209
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
|-- x86_64-randconfig-101-20240209
|   `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size
`-- x86_64-randconfig-102-20240209
    `-- fs-ntfs3-frecord.c:warning:unused-variable-i_size

elapsed time: 1459m

configs tested: 179
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240209   gcc  
arc                   randconfig-002-20240209   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   gcc  
arm                                 defconfig   clang
arm                             mxs_defconfig   clang
arm                   randconfig-001-20240209   clang
arm                   randconfig-002-20240209   gcc  
arm                   randconfig-003-20240209   gcc  
arm                   randconfig-004-20240209   gcc  
arm                        realview_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240209   clang
arm64                 randconfig-002-20240209   clang
arm64                 randconfig-003-20240209   clang
arm64                 randconfig-004-20240209   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240209   gcc  
csky                  randconfig-002-20240209   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240209   clang
hexagon               randconfig-002-20240209   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240209   clang
i386         buildonly-randconfig-002-20240209   clang
i386         buildonly-randconfig-003-20240209   gcc  
i386         buildonly-randconfig-004-20240209   clang
i386         buildonly-randconfig-005-20240209   clang
i386         buildonly-randconfig-006-20240209   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240209   clang
i386                  randconfig-002-20240209   gcc  
i386                  randconfig-003-20240209   clang
i386                  randconfig-004-20240209   clang
i386                  randconfig-005-20240209   clang
i386                  randconfig-006-20240209   gcc  
i386                  randconfig-011-20240209   gcc  
i386                  randconfig-012-20240209   gcc  
i386                  randconfig-013-20240209   clang
i386                  randconfig-014-20240209   gcc  
i386                  randconfig-015-20240209   gcc  
i386                  randconfig-016-20240209   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240209   gcc  
loongarch             randconfig-002-20240209   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                      bmips_stb_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240209   gcc  
nios2                 randconfig-002-20240209   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240209   gcc  
parisc                randconfig-002-20240209   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                          g5_defconfig   gcc  
powerpc                      makalu_defconfig   clang
powerpc                    mvme5100_defconfig   gcc  
powerpc                      pasemi_defconfig   clang
powerpc                     powernv_defconfig   gcc  
powerpc                      ppc40x_defconfig   clang
powerpc                       ppc64_defconfig   clang
powerpc               randconfig-001-20240209   clang
powerpc               randconfig-002-20240209   clang
powerpc               randconfig-003-20240209   gcc  
powerpc                     skiroot_defconfig   clang
powerpc                     tqm8548_defconfig   clang
powerpc                      tqm8xx_defconfig   clang
powerpc64             randconfig-001-20240209   clang
powerpc64             randconfig-002-20240209   clang
powerpc64             randconfig-003-20240209   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240209   clang
riscv                 randconfig-002-20240209   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240209   gcc  
s390                  randconfig-002-20240209   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240209   gcc  
sh                    randconfig-002-20240209   gcc  
sh                           se7724_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240209   gcc  
sparc64               randconfig-002-20240209   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240209   gcc  
um                    randconfig-002-20240209   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240209   gcc  
x86_64       buildonly-randconfig-002-20240209   gcc  
x86_64       buildonly-randconfig-003-20240209   clang
x86_64       buildonly-randconfig-004-20240209   gcc  
x86_64       buildonly-randconfig-005-20240209   clang
x86_64       buildonly-randconfig-006-20240209   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240209   clang
x86_64                randconfig-002-20240209   gcc  
x86_64                randconfig-003-20240209   gcc  
x86_64                randconfig-004-20240209   clang
x86_64                randconfig-005-20240209   gcc  
x86_64                randconfig-006-20240209   gcc  
x86_64                randconfig-011-20240209   clang
x86_64                randconfig-012-20240209   clang
x86_64                randconfig-013-20240209   gcc  
x86_64                randconfig-014-20240209   clang
x86_64                randconfig-015-20240209   gcc  
x86_64                randconfig-016-20240209   clang
x86_64                randconfig-071-20240209   gcc  
x86_64                randconfig-072-20240209   clang
x86_64                randconfig-073-20240209   clang
x86_64                randconfig-074-20240209   gcc  
x86_64                randconfig-075-20240209   gcc  
x86_64                randconfig-076-20240209   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240209   gcc  
xtensa                randconfig-002-20240209   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

