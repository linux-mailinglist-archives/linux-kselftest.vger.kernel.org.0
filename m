Return-Path: <linux-kselftest+bounces-2653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C1E824EB1
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 07:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56D86B23B04
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 06:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5FC4C60;
	Fri,  5 Jan 2024 06:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aT7BG2g6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FE11DDF5;
	Fri,  5 Jan 2024 06:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704436655; x=1735972655;
  h=date:from:to:cc:subject:message-id;
  bh=/FwGh9VzdvxxanZLtY85IWwQ09MZTOud16YV911n9TY=;
  b=aT7BG2g671soJSJsO1uLN1+vCDNUi+b1HNOENoCMw/b+c89kWk6ke1aq
   TRs9ys6IeT4jVVvj7RQhMkjvHXhZlYghCiYB/zoIE/Oujy/ez60dXTSiF
   YY1NmgPqAFaNE1wh7Q1u87Et4Irp3dGtgDfTn56V0X5b6gXBqBxkCDbCK
   /GBk6DqiZ/fLnCY6nDnyD3rU4O1wbfWWhmYWsnLkC+32sJuMq49lScQtK
   01IPZAXXu6ECi3tk0MaCbp8kOLPu3lAsfaCFUQ4ZNXhQyOlm4Dy6uOyf3
   dmZGWz7YjWz3UgcWms6KcuUikVKI08wvK97CNQYxy1IVCWaz0HD4L8MhD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="4215419"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="4215419"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 22:37:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="780676124"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="780676124"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 04 Jan 2024 22:37:29 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLdpe-0000sv-2q;
	Fri, 05 Jan 2024 06:37:26 +0000
Date: Fri, 05 Jan 2024 14:36:48 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, dmaengine@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 kasan-dev@googlegroups.com, kunit-dev@googlegroups.com,
 linux-arm-msm@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 d0b3c8aa5e37775cd7c3ac07b256218df0fd6678
Message-ID: <202401051437.ylHQ71JT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: d0b3c8aa5e37775cd7c3ac07b256218df0fd6678  Add linux-next specific files for 20240104

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202401041942.qrB1amZM-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

tools/testing/selftests/net/tcp_ao/bench-lookups.c:202: undefined reference to `sqrt'

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9280 amdgpu_dm_atomic_commit_tail() error: we previously assumed 'acrtc' could be null (see line 9277)
drivers/media/i2c/st-mipid02.c:396:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_s64 instead.
drivers/net/ethernet/broadcom/bnxt/bnxt.c:5333:6-25: WARNING: atomic_dec_and_test variation before object free at line 5336.
drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c:32:16-17: WARNING opportunity for min()
drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c:575:9-32: duplicated argument to & or |
{standard input}:18305: Warning: overflow in branch to .L4391; converted into longer instruction sequence
{standard input}:20816: Warning: overflow in branch to .L4982; converted into longer instruction sequence
{standard input}:21171: Warning: overflow in branch to .L4853; converted into longer instruction sequence
{standard input}:27179: Warning: overflow in branch to .L4887; converted into longer instruction sequence

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- arc-allmodconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- arc-allyesconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- arc-randconfig-002-20240104
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- arc-randconfig-r133-20240104
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- fs-bcachefs-btree_iter.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   `-- fs-bcachefs-btree_locking.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|-- arm-allmodconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- arm-allyesconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- arm-randconfig-001-20240104
|   `-- :Error:selected-processor-does-not-support-requested-special-purpose-register-mrs-r1-cpsr
|-- arm-randconfig-003-20240104
|   `-- :Error:selected-processor-does-not-support-requested-special-purpose-register-mrs-r1-cpsr
|-- arm-randconfig-r131-20240104
|   |-- drivers-hwmon-max31827.c:sparse:sparse:dubious:x-y
|   `-- mm-kasan-common.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-gfp_t-usertype-flags-got-unsigned-int-usertype-size
|-- arm64-defconfig
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l0_free_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l0_prealloc_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l1_free_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l1_prealloc_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-pvr_dev-description-in-pvr_mmu_backing_page
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-sgt-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-sgt_offset-description-in-pvr_mmu_op_context
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- arm64-randconfig-r053-20240104
|   |-- drivers-net-ethernet-broadcom-bnxt-bnxt.c:Unneeded-variable:rc-Return-on-line
|   |-- drivers-net-ethernet-broadcom-bnxt-bnxt.c:WARNING:atomic_dec_and_test-variation-before-object-free-at-line-.
|   |-- drivers-net-ethernet-marvell-octeon_ep-octep_pfvf_mbox.c:WARNING-opportunity-for-min()
|   `-- drivers-net-ethernet-marvell-octeontx2-af-rvu_npc_fs.c:duplicated-argument-to-or
|-- csky-allmodconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- csky-allyesconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- i386-buildonly-randconfig-004-20240104
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- i386-buildonly-randconfig-006-20240104
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- i386-randconfig-001-20240104
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- i386-randconfig-002-20240104
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- i386-randconfig-003-20240104
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- i386-randconfig-051-20240104
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- i386-randconfig-062-20240104
|   `-- drivers-hwmon-max31827.c:sparse:sparse:dubious:x-y
|-- i386-randconfig-141-20240104
|   `-- lib-kunit-device.c-kunit_device_register_with_driver()-warn:passing-zero-to-ERR_CAST
|-- loongarch-allmodconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- m68k-allmodconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- m68k-allyesconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- microblaze-allmodconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- microblaze-allyesconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- mips-allyesconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- nios2-allmodconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- nios2-allyesconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- openrisc-allyesconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- openrisc-randconfig-r062-20240104
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- parisc-allmodconfig
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-drivers-tty-serial-8250_parisc.o
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- parisc-allyesconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- powerpc-randconfig-001-20240104
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- powerpc-randconfig-002-20240104
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-fs-exportfs-exportfs.o
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- powerpc64-randconfig-001-20240104
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- powerpc64-randconfig-002-20240104
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- powerpc64-randconfig-003-20240104
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- riscv-allmodconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- riscv-allyesconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- riscv-randconfig-001-20240104
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- riscv-randconfig-002-20240104
|   `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
|-- riscv-randconfig-r121-20240104
|   |-- drivers-hwmon-max31827.c:sparse:sparse:dubious:x-y
|   |-- fs-bcachefs-btree_iter.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- fs-bcachefs-btree_locking.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   `-- mm-kasan-common.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-gfp_t-usertype-flags-got-unsigned-long-usertype-size
|-- s390-allmodconfig
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-drivers-s390-block-dasd_diag_mod.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-drivers-s390-block-dasd_eckd_mod.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-drivers-s390-block-dasd_fba_mod.o
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- s390-allyesconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- sh-allmodconfig
|   |-- include-linux-syscalls.h:internal-compiler-error:in-change_address_1-at-emit-rtl.cc
|   `-- standard-input:Error:pcrel-too-far
|-- sh-allnoconfig
|   |-- standard-input:Error:pcrel-too-far
|   `-- standard-input:Warning:overflow-in-branch-to-.L1609-converted-into-longer-instruction-sequence
|-- sh-allyesconfig
|   |-- include-linux-syscalls.h:internal-compiler-error:in-change_address_1-at-emit-rtl.cc
|   `-- standard-input:Error:pcrel-too-far
|-- sh-buildonly-randconfig-r004-20220313
|   `-- standard-input:Warning:overflow-in-branch-to-.L4391-converted-into-longer-instruction-sequence
|-- sh-buildonly-randconfig-r005-20211027
|   `-- standard-input:Warning:overflow-in-branch-to-.L4982-converted-into-longer-instruction-sequence
|-- sh-buildonly-randconfig-r006-20220111
|   `-- standard-input:Warning:overflow-in-branch-to-.L4887-converted-into-longer-instruction-sequence
|-- sh-randconfig-001-20240104
|   `-- standard-input:Error:pcrel-too-far
|-- sh-randconfig-002-20240104
|   |-- include-linux-syscalls.h:internal-compiler-error:in-change_address_1-at-emit-rtl.cc
|   `-- standard-input:Error:pcrel-too-far
|-- sh-randconfig-002-20240105
|   `-- standard-input:Warning:overflow-in-branch-to-.L4853-converted-into-longer-instruction-sequence
|-- sh-rsk7203_defconfig
|   |-- standard-input:Error:pcrel-too-far
|   `-- standard-input:Warning:overflow-in-branch-to-.L1642-converted-into-longer-instruction-sequence
|-- sparc-allmodconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- sparc-randconfig-001-20240104
|   `-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|-- sparc-randconfig-002-20240104
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- sparc64-allmodconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- sparc64-allyesconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- sparc64-randconfig-r123-20240104
|   |-- drivers-hwmon-max31827.c:sparse:sparse:dubious:x-y
|   |-- fs-bcachefs-btree_iter.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   `-- fs-bcachefs-btree_locking.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|-- um-randconfig-002-20240104
|   `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
|-- x86_64-buildonly-randconfig-001-20240104
|   `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
|-- x86_64-buildonly-randconfig-002-20240104
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- x86_64-buildonly-randconfig-003-20240104
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- x86_64-buildonly-randconfig-004-20240104
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- x86_64-randconfig-011-20240104
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- x86_64-randconfig-014-20240104
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- x86_64-randconfig-072-20240104
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- x86_64-randconfig-102-20240104
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- x86_64-randconfig-103-20240104
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- x86_64-randconfig-104-20240104
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|-- x86_64-randconfig-161-20231228
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-amdgpu_dm-amdgpu_dm.c-amdgpu_dm_atomic_commit_tail()-error:we-previously-assumed-acrtc-could-be-null-(see-line-)
|-- x86_64-randconfig-161-20240104
|   |-- lib-kunit-device.c-kunit_device_register_with_driver()-warn:passing-zero-to-ERR_CAST
|   |-- mm-kasan-kasan_test.c-mempool_double_free_helper()-error:double-free-of-elem
|   `-- mm-kasan-kasan_test.c-mempool_uaf_helper()-warn:passing-freed-memory-elem
|-- x86_64-rhel-8.3-bpf
|   `-- tools-testing-selftests-net-tcp_ao-bench-lookups.c:undefined-reference-to-sqrt
|-- xtensa-allyesconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- xtensa-randconfig-001-20240104
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   `-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
`-- xtensa-randconfig-r111-20240104
    `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
clang_recent_errors
|-- arm-defconfig
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- arm-randconfig-r113-20240104
|   |-- drivers-hwmon-max31827.c:sparse:sparse:dubious:x-y
|   `-- mm-kasan-common.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-gfp_t-usertype-flags-got-unsigned-int-usertype-size
|-- arm64-allmodconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:operator:has-lower-precedence-than-will-be-evaluated-first
|   |-- drivers-dma-xilinx-xdma.c:warning:variable-desc-is-uninitialized-when-used-here
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l0_free_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l0_prealloc_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l1_free_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l1_prealloc_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-pvr_dev-description-in-pvr_mmu_backing_page
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-sgt-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-sgt_offset-description-in-pvr_mmu_op_context
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- arm64-allyesconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:operator:has-lower-precedence-than-will-be-evaluated-first
|   |-- drivers-dma-xilinx-xdma.c:warning:variable-desc-is-uninitialized-when-used-here
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l0_free_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l0_prealloc_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l1_free_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l1_prealloc_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-pvr_dev-description-in-pvr_mmu_backing_page
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-sgt-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-sgt_offset-description-in-pvr_mmu_op_context
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- hexagon-allmodconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:operator:has-lower-precedence-than-will-be-evaluated-first
|   `-- drivers-dma-xilinx-xdma.c:warning:variable-desc-is-uninitialized-when-used-here
|-- hexagon-allyesconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:operator:has-lower-precedence-than-will-be-evaluated-first
|   `-- drivers-dma-xilinx-xdma.c:warning:variable-desc-is-uninitialized-when-used-here
|-- hexagon-randconfig-r052-20231228
|   `-- drivers-media-i2c-st-mipid02.c:WARNING:do_div()-does-a-by-division-please-consider-using-div64_s64-instead.
|-- i386-allmodconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:operator:has-lower-precedence-than-will-be-evaluated-first
|   |-- drivers-dma-xilinx-xdma.c:warning:variable-desc-is-uninitialized-when-used-here
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- i386-allyesconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:operator:has-lower-precedence-than-will-be-evaluated-first
|   |-- drivers-dma-xilinx-xdma.c:warning:variable-desc-is-uninitialized-when-used-here
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- i386-randconfig-012-20240104
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:operator:has-lower-precedence-than-will-be-evaluated-first
|   `-- drivers-dma-xilinx-xdma.c:warning:variable-desc-is-uninitialized-when-used-here
|-- i386-randconfig-016-20240104
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:operator:has-lower-precedence-than-will-be-evaluated-first
|   `-- drivers-dma-xilinx-xdma.c:warning:variable-desc-is-uninitialized-when-used-here
|-- powerpc-allmodconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:operator:has-lower-precedence-than-will-be-evaluated-first
|   |-- drivers-dma-xilinx-xdma.c:warning:variable-desc-is-uninitialized-when-used-here
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- powerpc-allyesconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:operator:has-lower-precedence-than-will-be-evaluated-first
|   |-- drivers-dma-xilinx-xdma.c:warning:variable-desc-is-uninitialized-when-used-here
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- s390-randconfig-001-20240104
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-drivers-s390-block-dasd_diag_mod.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-drivers-s390-block-dasd_eckd_mod.o
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:operator:has-lower-precedence-than-will-be-evaluated-first
|   `-- drivers-dma-xilinx-xdma.c:warning:variable-desc-is-uninitialized-when-used-here
|-- x86_64-allmodconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:operator:has-lower-precedence-than-will-be-evaluated-first
|   |-- drivers-dma-xilinx-xdma.c:warning:variable-desc-is-uninitialized-when-used-here
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- x86_64-allyesconfig
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:operator:has-lower-precedence-than-will-be-evaluated-first
|   |-- drivers-dma-xilinx-xdma.c:warning:variable-desc-is-uninitialized-when-used-here
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- x86_64-randconfig-002-20240104
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-dst_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-filled_descs_num-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-size-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-src_addr-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:Function-parameter-or-struct-member-sw_desc-not-described-in-xdma_fill_descs
|   |-- drivers-dma-xilinx-xdma.c:warning:operator:has-lower-precedence-than-will-be-evaluated-first
|   `-- drivers-dma-xilinx-xdma.c:warning:variable-desc-is-uninitialized-when-used-here
|-- x86_64-randconfig-121-20240104
|   `-- mm-kasan-common.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-gfp_t-usertype-flags-got-unsigned-long-usertype-size
|-- x86_64-randconfig-122-20240104
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|   `-- mm-kasan-common.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-gfp_t-usertype-flags-got-unsigned-long-usertype-size
`-- x86_64-randconfig-123-20240104
    |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_state.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
    `-- mm-kasan-common.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-restricted-gfp_t-usertype-flags-got-unsigned-long-usertype-size

elapsed time: 1461m

configs tested: 178
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240104   gcc  
arc                   randconfig-002-20240104   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        mvebu_v7_defconfig   gcc  
arm                   randconfig-001-20240104   gcc  
arm                   randconfig-002-20240104   gcc  
arm                   randconfig-003-20240104   gcc  
arm                   randconfig-004-20240104   gcc  
arm                           sama5_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240104   gcc  
arm64                 randconfig-002-20240104   gcc  
arm64                 randconfig-003-20240104   gcc  
arm64                 randconfig-004-20240104   gcc  
csky                             alldefconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240104   gcc  
csky                  randconfig-002-20240104   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240104   clang
hexagon               randconfig-002-20240104   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240104   gcc  
i386         buildonly-randconfig-002-20240104   gcc  
i386         buildonly-randconfig-003-20240104   gcc  
i386         buildonly-randconfig-004-20240104   gcc  
i386         buildonly-randconfig-005-20240104   gcc  
i386         buildonly-randconfig-006-20240104   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240104   gcc  
i386                  randconfig-002-20240104   gcc  
i386                  randconfig-003-20240104   gcc  
i386                  randconfig-004-20240104   gcc  
i386                  randconfig-005-20240104   gcc  
i386                  randconfig-006-20240104   gcc  
i386                  randconfig-011-20240104   clang
i386                  randconfig-012-20240104   clang
i386                  randconfig-013-20240104   clang
i386                  randconfig-014-20240104   clang
i386                  randconfig-015-20240104   clang
i386                  randconfig-016-20240104   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240104   gcc  
loongarch             randconfig-002-20240104   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                           mtx1_defconfig   clang
mips                   sb1250_swarm_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240104   gcc  
nios2                 randconfig-002-20240104   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240104   gcc  
parisc                randconfig-002-20240104   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    gamecube_defconfig   clang
powerpc                   microwatt_defconfig   clang
powerpc                      ppc64e_defconfig   clang
powerpc               randconfig-001-20240104   gcc  
powerpc               randconfig-002-20240104   gcc  
powerpc               randconfig-003-20240104   gcc  
powerpc64             randconfig-001-20240104   gcc  
powerpc64             randconfig-002-20240104   gcc  
powerpc64             randconfig-003-20240104   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240104   gcc  
riscv                 randconfig-002-20240104   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240104   clang
s390                  randconfig-002-20240104   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240104   gcc  
sh                    randconfig-002-20240104   gcc  
sh                          rsk7203_defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240104   gcc  
sparc64               randconfig-002-20240104   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240104   gcc  
um                    randconfig-002-20240104   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240104   gcc  
x86_64       buildonly-randconfig-002-20240104   gcc  
x86_64       buildonly-randconfig-003-20240104   gcc  
x86_64       buildonly-randconfig-004-20240104   gcc  
x86_64       buildonly-randconfig-005-20240104   gcc  
x86_64       buildonly-randconfig-006-20240104   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240104   clang
x86_64                randconfig-002-20240104   clang
x86_64                randconfig-003-20240104   clang
x86_64                randconfig-004-20240104   clang
x86_64                randconfig-005-20240104   clang
x86_64                randconfig-006-20240104   clang
x86_64                randconfig-011-20240104   gcc  
x86_64                randconfig-012-20240104   gcc  
x86_64                randconfig-013-20240104   gcc  
x86_64                randconfig-014-20240104   gcc  
x86_64                randconfig-015-20240104   gcc  
x86_64                randconfig-016-20240104   gcc  
x86_64                randconfig-071-20240104   gcc  
x86_64                randconfig-072-20240104   gcc  
x86_64                randconfig-073-20240104   gcc  
x86_64                randconfig-074-20240104   gcc  
x86_64                randconfig-075-20240104   gcc  
x86_64                randconfig-076-20240104   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240104   gcc  
xtensa                randconfig-002-20240104   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

