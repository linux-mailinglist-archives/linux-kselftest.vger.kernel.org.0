Return-Path: <linux-kselftest+bounces-2252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB18F819907
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 08:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05721F261F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 07:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A086113ACD;
	Wed, 20 Dec 2023 07:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IYs1YENx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC151428B;
	Wed, 20 Dec 2023 07:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703056076; x=1734592076;
  h=date:from:to:cc:subject:message-id;
  bh=sMwgXfNrrc0biCj/DRmlmkCXkuRZH+S+rr52/tbWGtw=;
  b=IYs1YENx89rMYLXWbSLcpLxv9x5eW//wwqjTkfCGjZ66CN07TSA9zw+K
   9kN74Yb7YKtMm2F6WEv0WWzmo30Fv6lz2q3gKK1OwzOnp71ZyQCjPP3qK
   IMBzph5lYqus6Vh+vB1oyySH9LLuJqymmL+PPhwN1xAA/lgLKBDSwbDYC
   Sy93RZ70NfvWAS0ylI7nFt5uKWxCcN8mbIN80wJoaqeGFB+/8NVJoMcvL
   23u+IB4Ubr8bCkB1bz3KdiVL0JraS4EtBq3N6zSIoaczKarwJRkibkmWb
   O59Gxwwe0Cwk7j9oLowwB/j9iWi+N2sVRwrMCQ2DSP9rvaqg4s1DqlvI/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="460114509"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="460114509"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 23:07:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="1023386823"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="1023386823"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 19 Dec 2023 23:07:48 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFqgD-0006Xz-3C;
	Wed, 20 Dec 2023 07:07:46 +0000
Date: Wed, 20 Dec 2023 15:07:03 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx@lists.freedesktop.org, chrome-platform@lists.linux.dev,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 intel-wired-lan@lists.osuosl.org, kunit-dev@googlegroups.com,
 linux-afs@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net, linux-bcachefs@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-wireless@vger.kernel.org,
 mpi3mr-linuxdrv.pdl@broadcom.com, netdev@vger.kernel.org,
 sparclinux@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 aa4db8324c4d0e67aa4670356df4e9fae14b4d37
Message-ID: <202312201550.YPNnIB0H-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: aa4db8324c4d0e67aa4670356df4e9fae14b4d37  Add linux-next specific files for 20231219

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202312191829.ZkroAQDV-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202312192256.lJelQEoZ-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202312200537.HoNqPL5L-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202312201256.iET7CoM9-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202312201409.y5nmYEx3-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/infiniband/hw/bnxt_re/qplib_fp.c:1620:44: sparse:    left side has type restricted __le64
drivers/infiniband/hw/bnxt_re/qplib_fp.c:1620:44: sparse:    right side has type unsigned long long
drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:909:27: sparse:    left side has type restricted __le16
drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:909:27: sparse:    right side has type unsigned long
fs/bcachefs/btree_update_interior.c:158: warning: Function parameter or struct member 'nr' not described in 'bch2_btree_node_format_fits'
ld.lld: error: undefined symbol: spi_setup
lib/aolib.h:366:16: error: variable 'key2' has initializer but incomplete type
lib/aolib.h:366:34: error: storage size of 'key2' isn't known
lib/aolib.h:369:46: error: invalid use of undefined type 'struct tcp_ao_add'
lib/aolib.h:382:16: error: variable 'tmp' has initializer but incomplete type
lib/aolib.h:382:27: error: storage size of 'tmp' isn't known
lib/aolib.h:390:43: error: 'TCP_AO_ADD_KEY' undeclared (first use in this function)
lib/aolib.h:406:16: error: variable 'ao2' has initializer but incomplete type
lib/aolib.h:406:32: error: storage size of 'ao2' isn't known
lib/aolib.h:418:16: error: variable 'ao' has initializer but incomplete type
lib/aolib.h:418:32: error: storage size of 'ao' isn't known
lib/kconfig.c:47:16: error: variable 'tmp' has initializer but incomplete type
lib/kconfig.c:47:27: error: storage size of 'tmp' isn't known
lib/kconfig.c:64:41: error: 'TCP_AO_ADD_KEY' undeclared (first use in this function)
lib/repair.c:115:6: error: conflicting types for 'test_ao_checkpoint'; have 'void(int,  struct tcp_ao_repair *)'
lib/repair.c:117:31: error: invalid application of 'sizeof' to incomplete type 'struct tcp_ao_repair'
lib/repair.c:122:39: error: 'TCP_AO_REPAIR' undeclared (first use in this function); did you mean 'TCP_REPAIR'?
lib/repair.c:222:6: error: conflicting types for 'test_ao_restore'; have 'void(int,  struct tcp_ao_repair *)'
lib/sock.c:136:5: error: conflicting types for 'test_prepare_key_sockaddr'; have 'int(struct tcp_ao_add *, const char *, void *, size_t,  _Bool,  _Bool,  uint8_t,  uint8_t,  uint8_t,  uint8_t,  uint8_t,  uint8_t,  uint8_t,  const char *)' {aka 'int(struct tcp_ao_add *, const char *, void *, long unsigned int,  _Bool,  _Bool,  unsigned char,  unsigned char,  unsigned char,  unsigned char,  unsigned char,  unsigned char,  unsigned char,  const char *)'}
lib/sock.c:142:30: error: invalid application of 'sizeof' to incomplete type 'struct tcp_ao_add'
lib/sock.c:144:11: error: invalid use of undefined type 'struct tcp_ao_add'
lib/sock.c:161:26: error: 'TCP_AO_MAXKEYLEN' undeclared (first use in this function); did you mean 'TCP_MD5SIG_MAXKEYLEN'?
lib/sock.c:167:16: error: variable 'tmp' has initializer but incomplete type
lib/sock.c:167:34: error: storage size of 'tmp' isn't known
lib/sock.c:174:43: error: 'TCP_AO_GET_KEYS' undeclared (first use in this function)
lib/sock.c:180:5: error: conflicting types for 'test_get_one_ao'; have 'int(int,  struct tcp_ao_getsockopt *, void *, size_t,  uint8_t,  uint8_t,  uint8_t)' {aka 'int(int,  struct tcp_ao_getsockopt *, void *, long unsigned int,  unsigned char,  unsigned char,  unsigned char)'}
lib/sock.c:199:14: error: invalid use of undefined type 'struct tcp_ao_getsockopt'
lib/sock.c:203:5: error: conflicting types for 'test_get_ao_info'; have 'int(int,  struct tcp_ao_info_opt *)'
lib/sock.c:205:30: error: invalid application of 'sizeof' to incomplete type 'struct tcp_ao_info_opt'
lib/sock.c:207:12: error: invalid use of undefined type 'struct tcp_ao_info_opt'
lib/sock.c:209:41: error: 'TCP_AO_INFO' undeclared (first use in this function); did you mean 'TCP_CC_INFO'?
lib/sock.c:216:5: error: conflicting types for 'test_set_ao_info'; have 'int(int,  struct tcp_ao_info_opt *)'
lib/sock.c:227:5: error: conflicting types for 'test_cmp_getsockopt_setsockopt'; have 'int(const struct tcp_ao_add *, const struct tcp_ao_getsockopt *)'
lib/sock.c:233:38: error: invalid use of undefined type 'const struct tcp_ao_add'
lib/sock.c:240:14: error: invalid use of undefined type 'const struct tcp_ao_getsockopt'
lib/sock.c:299:5: error: conflicting types for 'test_cmp_getsockopt_setsockopt_ao'; have 'int(const struct tcp_ao_info_opt *, const struct tcp_ao_info_opt *)'
lib/sock.c:303:14: error: invalid use of undefined type 'const struct tcp_ao_info_opt'
lib/sock.c:337:39: error: invalid application of 'sizeof' to incomplete type 'struct tcp_ao_getsockopt'
lib/sock.c:338:16: error: variable 'info' has initializer but incomplete type
lib/sock.c:338:32: error: storage size of 'info' isn't known
scripts/kernel-doc: fs/bcachefs/btree_update_interior.c:158: warning: Function parameter or struct member 'nr' not described in 'bch2_btree_node_format_fits'

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/net/wireless/marvell/mwifiex/sdio.c:799 mwifiex_check_fw_status() error: uninitialized symbol 'firmware_stat'.
lib/kunit/device.c:138 kunit_device_register_with_driver() warn: passing zero to 'ERR_CAST'
{standard input}:20117: Warning: overflow in branch to .L1642; converted into longer instruction sequence
{standard input}:20316: Warning: overflow in branch to .L4551; converted into longer instruction sequence
{standard input}:21207: Warning: overflow in branch to .L4396; converted into longer instruction sequence
{standard input}:21361: Warning: overflow in branch to .L4925; converted into longer instruction sequence
{standard input}:25534: Warning: overflow in branch to .L4819; converted into longer instruction sequence
{standard input}:49699: Warning: overflow in branch to .L4558; converted into longer instruction sequence
{standard input}:6750: Warning: overflow in branch to .L1600; converted into longer instruction sequence
{standard input}:6752: Warning: overflow in branch to .L1609; converted into longer instruction sequence
{standard input}:6858: Warning: overflow in branch to .L1640; converted into longer instruction sequence

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arc-allmodconfig
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arc-randconfig-001-20231219
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arc-randconfig-001-20231220
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arc-randconfig-002-20231219
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arc-randconfig-002-20231220
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arc-randconfig-r112-20231219
|   |-- fs-bcachefs-btree_iter.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- fs-bcachefs-btree_iter.c:sparse:struct-btree_path
|   |-- fs-bcachefs-btree_iter.c:sparse:struct-btree_path-noderef-__rcu
|   |-- fs-bcachefs-btree_locking.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- fs-bcachefs-btree_locking.c:sparse:struct-btree_path
|   |-- fs-bcachefs-btree_locking.c:sparse:struct-btree_path-noderef-__rcu
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- arm-allmodconfig
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arm-allyesconfig
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arm-randconfig-002-20231220
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arm-randconfig-003-20231220
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arm-randconfig-004-20231220
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arm64-defconfig
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l0_free_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l0_prealloc_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l1_free_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l1_prealloc_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-pvr_dev-description-in-pvr_mmu_backing_page
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-sgt-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-sgt_offset-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   `-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|-- arm64-randconfig-001-20231220
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arm64-randconfig-002-20231220
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arm64-randconfig-003-20231220
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   `-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|-- arm64-randconfig-004-20231220
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l0_free_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l0_prealloc_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l1_free_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-l1_prealloc_tables-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-pvr_dev-description-in-pvr_mmu_backing_page
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-sgt-description-in-pvr_mmu_op_context
|   |-- drivers-gpu-drm-imagination-pvr_mmu.c:warning:Excess-struct-member-sgt_offset-description-in-pvr_mmu_op_context
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   `-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|-- csky-allmodconfig
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- csky-allyesconfig
|   |-- (.text):undefined-reference-to-__generic_xchg_called_with_bad_pointer
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- csky-randconfig-001-20231219
|   `-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|-- csky-randconfig-001-20231220
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- csky-randconfig-002-20231219
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- csky-randconfig-002-20231220
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   `-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|-- csky-randconfig-r063-20231219
|   |-- csky-linux-ld:rotate.c:(.text):undefined-reference-to-__generic_xchg_called_with_bad_pointer
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   `-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|-- i386-randconfig-011-20231219
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   `-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|-- i386-randconfig-012-20231219
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-randconfig-013-20231219
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-randconfig-014-20231219
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-randconfig-015-20231219
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-randconfig-016-20231219
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-randconfig-r132-20231219
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- loongarch-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- loongarch-defconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|-- loongarch-randconfig-001-20231219
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- loongarch-randconfig-001-20231220
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|-- loongarch-randconfig-002-20231219
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   `-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|-- loongarch-randconfig-002-20231220
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- m68k-randconfig-r111-20231219
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- m68k-randconfig-r113-20231219
|   |-- fs-bcachefs-btree_iter.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- fs-bcachefs-btree_iter.c:sparse:struct-btree_path
|   |-- fs-bcachefs-btree_iter.c:sparse:struct-btree_path-noderef-__rcu
|   |-- fs-bcachefs-btree_locking.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- fs-bcachefs-btree_locking.c:sparse:struct-btree_path
|   |-- fs-bcachefs-btree_locking.c:sparse:struct-btree_path-noderef-__rcu
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- microblaze-allmodconfig
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- microblaze-allyesconfig
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- microblaze-randconfig-r053-20231219
|   |-- (.text):undefined-reference-to-__generic_xchg_called_with_bad_pointer
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- mips-allyesconfig
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- mips-ip27_defconfig
|   `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
|-- nios2-allmodconfig
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- nios2-allyesconfig
|   |-- callback.c:(.text):relocation-truncated-to-fit:R_NIOS2_CALL26-against-__generic_xchg_called_with_bad_pointer
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|   `-- rotate.c:(.text):relocation-truncated-to-fit:R_NIOS2_CALL26-against-__generic_xchg_called_with_bad_pointer
|-- nios2-randconfig-001-20231219
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- nios2-randconfig-001-20231220
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- nios2-randconfig-002-20231219
|   `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
|-- nios2-randconfig-002-20231220
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- openrisc-allyesconfig
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- parisc-allmodconfig
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- parisc-allyesconfig
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- parisc-randconfig-001-20231219
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- parisc-randconfig-001-20231220
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- parisc-randconfig-002-20231219
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- parisc-randconfig-002-20231220
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- powerpc-randconfig-001-20231220
|   |-- include-linux-compiler_types.h:error:call-to-__compiletime_assert_NNN-declared-with-attribute-error:Unsupported-size-for-__xchg_relaxed
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- powerpc-randconfig-003-20231220
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- powerpc64-randconfig-001-20231220
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   `-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|-- powerpc64-randconfig-002-20231220
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- powerpc64-randconfig-003-20231220
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- riscv-allmodconfig
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- riscv-allyesconfig
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- riscv-randconfig-001-20231220
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- riscv-randconfig-002-20231220
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- riscv-randconfig-r133-20231219
|   |-- drivers-hwmon-max31827.c:sparse:sparse:dubious:x-y
|   |-- fs-bcachefs-btree_iter.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- fs-bcachefs-btree_iter.c:sparse:struct-btree_path
|   |-- fs-bcachefs-btree_iter.c:sparse:struct-btree_path-noderef-__rcu
|   |-- fs-bcachefs-btree_locking.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- fs-bcachefs-btree_locking.c:sparse:struct-btree_path
|   |-- fs-bcachefs-btree_locking.c:sparse:struct-btree_path-noderef-__rcu
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- s390-allmodconfig
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-drivers-s390-block-dasd_diag_mod.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-drivers-s390-block-dasd_eckd_mod.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-drivers-s390-block-dasd_fba_mod.o
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- s390-allyesconfig
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- s390-defconfig
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- sh-allmodconfig
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|   `-- scripts-kernel-doc:fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|-- sh-allnoconfig
|   `-- standard-input:Warning:overflow-in-branch-to-.L1609-converted-into-longer-instruction-sequence
|-- sh-allyesconfig
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- sh-j2_defconfig
|   `-- standard-input:Warning:overflow-in-branch-to-.L4551-converted-into-longer-instruction-sequence
|-- sh-randconfig-001-20231220
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- sh-randconfig-002-20231220
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|   `-- standard-input:Warning:overflow-in-branch-to-.L4819-converted-into-longer-instruction-sequence
|-- sh-randconfig-r011-20220728
|   `-- standard-input:Warning:overflow-in-branch-to-.L4558-converted-into-longer-instruction-sequence
|-- sh-randconfig-r016-20211022
|   `-- standard-input:Warning:overflow-in-branch-to-.L4396-converted-into-longer-instruction-sequence
|-- sh-rsk7201_defconfig
|   `-- standard-input:Warning:overflow-in-branch-to-.L1600-converted-into-longer-instruction-sequence
|-- sh-rsk7203_defconfig
|   `-- standard-input:Warning:overflow-in-branch-to-.L1642-converted-into-longer-instruction-sequence
|-- sh-se7206_defconfig
|   `-- standard-input:Warning:overflow-in-branch-to-.L4925-converted-into-longer-instruction-sequence
|-- sh-se7619_defconfig
|   `-- standard-input:Warning:overflow-in-branch-to-.L1640-converted-into-longer-instruction-sequence
|-- sparc-allmodconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   |-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- sparc-allnoconfig
|   |-- arch-sparc-mm-leon_mm.c:warning:variable-paddrbase-set-but-not-used
|   `-- arch-sparc-mm-srmmu.c:warning:variable-clear-set-but-not-used
|-- sparc-defconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   |-- arch-sparc-mm-leon_mm.c:warning:variable-paddrbase-set-but-not-used
|   `-- arch-sparc-mm-srmmu.c:warning:variable-clear-set-but-not-used
|-- sparc-randconfig-001-20231220
|   |-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   |-- arch-sparc-mm-leon_mm.c:warning:variable-paddrbase-set-but-not-used
|   |-- arch-sparc-mm-srmmu.c:warning:variable-clear-set-but-not-used
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|   |-- parport_pc.c:(.text):undefined-reference-to-ebus_dma_enable
|   |-- parport_pc.c:(.text):undefined-reference-to-ebus_dma_irq_enable
|   |-- parport_pc.c:(.text):undefined-reference-to-ebus_dma_register
|   |-- sparc-linux-ld:parport_pc.c:(.text):undefined-reference-to-ebus_dma_enable
|   |-- sparc-linux-ld:parport_pc.c:(.text):undefined-reference-to-ebus_dma_irq_enable
|   |-- sparc-linux-ld:parport_pc.c:(.text):undefined-reference-to-ebus_dma_prepare
|   |-- sparc-linux-ld:parport_pc.c:(.text):undefined-reference-to-ebus_dma_request
|   |-- sparc-linux-ld:parport_pc.c:(.text):undefined-reference-to-ebus_dma_residue
|   |-- sparc-linux-ld:parport_pc.c:(.text):undefined-reference-to-ebus_dma_unregister
|   `-- sparc-linux-ld:parport_pc.c:(.text):undefined-reference-to-ns87303_lock
|-- sparc-randconfig-002-20231220
|   |-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- sparc-randconfig-r123-20231219
|   |-- arch-sparc-mm-init_64.c:warning:variable-pagecv_flag-set-but-not-used
|   |-- drivers-hwmon-max31827.c:sparse:sparse:dubious:x-y
|   |-- fs-bcachefs-btree_iter.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- fs-bcachefs-btree_iter.c:sparse:struct-btree_path
|   |-- fs-bcachefs-btree_iter.c:sparse:struct-btree_path-noderef-__rcu
|   |-- fs-bcachefs-btree_locking.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- fs-bcachefs-btree_locking.c:sparse:struct-btree_path
|   |-- fs-bcachefs-btree_locking.c:sparse:struct-btree_path-noderef-__rcu
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- sparc64-allmodconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   |-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- sparc64-allyesconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   |-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- sparc64-defconfig
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   `-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|-- sparc64-randconfig-001-20231220
|   |-- arch-sparc-mm-init_64.c:warning:variable-pagecv_flag-set-but-not-used
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   `-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|-- sparc64-randconfig-002-20231220
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   |-- arch-sparc-mm-init_64.c:warning:variable-hv_pgsz_idx-set-but-not-used
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- sparc64-randconfig-r062-20231219
|   `-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|-- sparc64-randconfig-r122-20231219
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
|   |-- arch-sparc-kernel-module.c:warning:variable-strtab-set-but-not-used
|   |-- arch-sparc-mm-init_64.c:warning:variable-pagecv_flag-set-but-not-used
|   |-- fs-bcachefs-btree_iter.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- fs-bcachefs-btree_iter.c:sparse:struct-btree_path
|   |-- fs-bcachefs-btree_iter.c:sparse:struct-btree_path-noderef-__rcu
|   |-- fs-bcachefs-btree_locking.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- fs-bcachefs-btree_locking.c:sparse:struct-btree_path
|   |-- fs-bcachefs-btree_locking.c:sparse:struct-btree_path-noderef-__rcu
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- um-randconfig-001-20231220
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   `-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|-- um-randconfig-002-20231220
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-001-20231219
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-002-20231219
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-003-20231219
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-006-20231219
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-121-20231219
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- x86_64-randconfig-122-20231219
|   |-- drivers-hwmon-max31827.c:sparse:sparse:dubious:x-y
|   |-- fs-bcachefs-btree_iter.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- fs-bcachefs-btree_iter.c:sparse:struct-btree_path
|   |-- fs-bcachefs-btree_iter.c:sparse:struct-btree_path-noderef-__rcu
|   |-- fs-bcachefs-btree_locking.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- fs-bcachefs-btree_locking.c:sparse:struct-btree_path
|   |-- fs-bcachefs-btree_locking.c:sparse:struct-btree_path-noderef-__rcu
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- x86_64-randconfig-123-20231219
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- x86_64-randconfig-161-20231220
|   `-- drivers-scsi-fcoe-fcoe_sysfs.c-store_ctlr_mode()-warn:unsigned-ctlr-mode-is-never-less-than-zero.
`-- x86_64-rhel-8.3-bpf
    |-- lib-aolib.h:error:TCP_AO_ADD_KEY-undeclared-(first-use-in-this-function)
    |-- lib-aolib.h:error:invalid-use-of-undefined-type-struct-tcp_ao_add
    |-- lib-aolib.h:error:storage-size-of-ao-isn-t-known
    |-- lib-aolib.h:error:storage-size-of-ao2-isn-t-known
    |-- lib-aolib.h:error:storage-size-of-key2-isn-t-known
    |-- lib-aolib.h:error:storage-size-of-tmp-isn-t-known
    |-- lib-aolib.h:error:variable-ao-has-initializer-but-incomplete-type
    |-- lib-aolib.h:error:variable-ao2-has-initializer-but-incomplete-type
    |-- lib-aolib.h:error:variable-key2-has-initializer-but-incomplete-type
    |-- lib-aolib.h:error:variable-tmp-has-initializer-but-incomplete-type
    |-- lib-kconfig.c:error:TCP_AO_ADD_KEY-undeclared-(first-use-in-this-function)
    |-- lib-kconfig.c:error:storage-size-of-tmp-isn-t-known
    |-- lib-kconfig.c:error:variable-tmp-has-initializer-but-incomplete-type
    |-- lib-repair.c:error:TCP_AO_REPAIR-undeclared-(first-use-in-this-function)
    |-- lib-repair.c:error:conflicting-types-for-test_ao_checkpoint-have-void(int-struct-tcp_ao_repair-)
    |-- lib-repair.c:error:conflicting-types-for-test_ao_restore-have-void(int-struct-tcp_ao_repair-)
    |-- lib-repair.c:error:invalid-application-of-sizeof-to-incomplete-type-struct-tcp_ao_repair
    |-- lib-sock.c:error:TCP_AO_GET_KEYS-undeclared-(first-use-in-this-function)
    |-- lib-sock.c:error:TCP_AO_INFO-undeclared-(first-use-in-this-function)
    |-- lib-sock.c:error:TCP_AO_MAXKEYLEN-undeclared-(first-use-in-this-function)
    |-- lib-sock.c:error:conflicting-types-for-test_cmp_getsockopt_setsockopt-have-int(const-struct-tcp_ao_add-const-struct-tcp_ao_getsockopt-)
    |-- lib-sock.c:error:conflicting-types-for-test_cmp_getsockopt_setsockopt_ao-have-int(const-struct-tcp_ao_info_opt-const-struct-tcp_ao_info_opt-)
    |-- lib-sock.c:error:conflicting-types-for-test_get_ao_info-have-int(int-struct-tcp_ao_info_opt-)
    |-- lib-sock.c:error:conflicting-types-for-test_get_one_ao-have-int(int-struct-tcp_ao_getsockopt-void-size_t-uint8_t-uint8_t-uint8_t)-aka-int(int-struct-tcp_ao_getsockopt-void-long-unsigned-int-unsigned-c
    |-- lib-sock.c:error:conflicting-types-for-test_prepare_key_sockaddr-have-int(struct-tcp_ao_add-const-char-void-size_t-_Bool-_Bool-uint8_t-uint8_t-uint8_t-uint8_t-uint8_t-uint8_t-uint8_t-const-char-)-aka-
    |-- lib-sock.c:error:conflicting-types-for-test_set_ao_info-have-int(int-struct-tcp_ao_info_opt-)
    |-- lib-sock.c:error:invalid-application-of-sizeof-to-incomplete-type-struct-tcp_ao_add
    |-- lib-sock.c:error:invalid-application-of-sizeof-to-incomplete-type-struct-tcp_ao_getsockopt
    |-- lib-sock.c:error:invalid-application-of-sizeof-to-incomplete-type-struct-tcp_ao_info_opt
    |-- lib-sock.c:error:invalid-use-of-undefined-type-const-struct-tcp_ao_add
    |-- lib-sock.c:error:invalid-use-of-undefined-type-const-struct-tcp_ao_getsockopt
    |-- lib-sock.c:error:invalid-use-of-undefined-type-const-struct-tcp_ao_info_opt
    |-- lib-sock.c:error:invalid-use-of-undefined-type-struct-tcp_ao_add
    |-- lib-sock.c:error:invalid-use-of-undefined-type-struct-tcp_ao_getsockopt
    |-- lib-sock.c:error:invalid-use-of-undefined-type-struct-tcp_ao_info_opt
    |-- lib-sock.c:error:storage-size-of-info-isn-t-known
    |-- lib-sock.c:error:storage-size-of-tmp-isn-t-known
    |-- lib-sock.c:error:variable-info-has-initializer-but-incomplete-type
    `-- lib-sock.c:error:variable-tmp-has-initializer-but-incomplete-type
clang_recent_errors
|-- arm-defconfig
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:at91_poweroff_probe-(section:.text)-at91_wakeup_status-(section:.init.text)
|   |-- WARNING:modpost:vmlinux:section-mismatch-in-reference:at91_shdwc_probe-(section:.text)-at91_wakeup_status-(section:.init.text)
|   `-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|-- arm-multi_v5_defconfig
|   `-- WARNING:modpost:vmlinux:section-mismatch-in-reference:at91_poweroff_probe-(section:.text)-at91_wakeup_status-(section:.init.text)
|-- arm-randconfig-001-20231219
|   `-- drivers-net-ethernet-intel-ice-ice_base.c:error:variable-has-incomplete-type-struct-xsk_cb_desc
|-- arm-randconfig-002-20231219
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arm-randconfig-003-20231219
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arm-randconfig-004-20231219
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arm64-randconfig-001-20231219
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-fs-exportfs-exportfs.o
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arm64-randconfig-002-20231219
|   |-- ld.lld:error:undefined-symbol:spi_setup
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arm64-randconfig-003-20231219
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- arm64-randconfig-r054-20231219
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- hexagon-allmodconfig
|   |-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- hexagon-allyesconfig
|   |-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- hexagon-randconfig-001-20231219
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- hexagon-randconfig-001-20231220
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- hexagon-randconfig-002-20231219
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- hexagon-randconfig-r052-20231219
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-lib-zlib_inflate-zlib_inflate.o
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-allmodconfig
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-allyesconfig
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-buildonly-randconfig-002-20231219
|   `-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|-- i386-buildonly-randconfig-004-20231219
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-buildonly-randconfig-005-20231219
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-buildonly-randconfig-006-20231219
|   `-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|-- i386-randconfig-001-20231219
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   `-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|-- i386-randconfig-002-20231219
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-randconfig-003-20231219
|   `-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|-- i386-randconfig-004-20231219
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-randconfig-005-20231219
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-randconfig-006-20231219
|   `-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|-- i386-randconfig-051-20231219
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-randconfig-052-20231219
|   `-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|-- i386-randconfig-053-20231219
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- i386-randconfig-054-20231219
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   `-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|-- i386-randconfig-061-20231219
|   |-- drivers-hwmon-max31827.c:sparse:sparse:dubious:x-y
|   |-- fs-bcachefs-btree_iter.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- fs-bcachefs-btree_iter.c:sparse:struct-btree_path
|   |-- fs-bcachefs-btree_iter.c:sparse:struct-btree_path-noderef-__rcu
|   |-- fs-bcachefs-btree_locking.c:sparse:sparse:incompatible-types-in-comparison-expression-(different-address-spaces):
|   |-- fs-bcachefs-btree_locking.c:sparse:struct-btree_path
|   |-- fs-bcachefs-btree_locking.c:sparse:struct-btree_path-noderef-__rcu
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- i386-randconfig-062-20231219
|   |-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|   |-- fs-afs-main.c:sparse:sparse:cast-removes-address-space-__rcu-of-expression
|   |-- fs-afs-main.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-callback_head-head-got-struct-callback_head-noderef-__rcu
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- i386-randconfig-063-20231219
|   |-- drivers-hwmon-max31827.c:sparse:sparse:dubious:x-y
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- i386-randconfig-141-20231219
|   |-- lib-zstd-common-bits.h-ZSTD_countLeadingZeros32()-warn:inconsistent-indenting
|   |-- lib-zstd-common-bits.h-ZSTD_countTrailingZeros32()-warn:inconsistent-indenting
|   |-- lib-zstd-compress-..-common-bits.h-ZSTD_countLeadingZeros32()-warn:inconsistent-indenting
|   |-- lib-zstd-compress-..-common-bits.h-ZSTD_countLeadingZeros64()-warn:inconsistent-indenting
|   |-- lib-zstd-compress-..-common-bits.h-ZSTD_countTrailingZeros32()-warn:inconsistent-indenting
|   |-- lib-zstd-compress-..-common-bits.h-ZSTD_countTrailingZeros64()-warn:inconsistent-indenting
|   |-- lib-zstd-decompress-..-common-bits.h-ZSTD_countLeadingZeros32()-warn:inconsistent-indenting
|   |-- lib-zstd-decompress-..-common-bits.h-ZSTD_countTrailingZeros32()-warn:inconsistent-indenting
|   |-- lib-zstd-decompress-..-common-bits.h-ZSTD_countTrailingZeros64()-warn:inconsistent-indenting
|   `-- mm-slub.c-__put_partials()-error:calling-spin_unlock_irqrestore()-with-bogus-flags
|-- powerpc-randconfig-002-20231219
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- powerpc-randconfig-003-20231219
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- powerpc-randconfig-r121-20231219
|   |-- drivers-hwmon-max31827.c:sparse:sparse:dubious:x-y
|   |-- lib-raid6-altivec4.c:sparse:incomplete-type-static-toplevel-unative_t
|   |-- lib-raid6-altivec4.c:sparse:int-static-signed-toplevel-disable_kernel_altivec(-...-)
|   |-- lib-raid6-altivec4.c:sparse:int-static-toplevel-unative_t
|   |-- lib-raid6-altivec8.c:sparse:incomplete-type-static-toplevel-unative_t
|   |-- lib-raid6-altivec8.c:sparse:int-static-signed-toplevel-disable_kernel_altivec(-...-)
|   |-- lib-raid6-altivec8.c:sparse:int-static-toplevel-unative_t
|   `-- lib-zstd-compress-zstd_fast.c:sparse:sparse:Using-plain-integer-as-NULL-pointer
|-- powerpc64-randconfig-002-20231219
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- powerpc64-randconfig-003-20231219
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- riscv-randconfig-001-20231219
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- riscv-randconfig-002-20231219
|   |-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-allmodconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- drivers-gpu-drm-msm-disp-dpu1-dpu_encoder.c:warning:Excess-struct-member-debugfs_root-description-in-dpu_encoder_virt
|   |-- drivers-leds-leds-max5970.c:warning:variable-num_leds-set-but-not-used
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-nr-not-described-in-bch2_btree_node_format_fits
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-buildonly-randconfig-002-20231219
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-buildonly-randconfig-003-20231219
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-buildonly-randconfig-005-20231219
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-buildonly-randconfig-006-20231219
|   `-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|-- x86_64-randconfig-011-20231219
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-012-20231219
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-013-20231219
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-hwss-dcn35-dcn35_hwseq.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-014-20231219
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-015-20231219
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-016-20231219
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-071-20231219
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-074-20231219
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-075-20231219
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-076-20231219
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-101-20231219
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-102-20231219
|   |-- fs-bcachefs-btree_update_interior.c:warning:Function-parameter-or-struct-member-path_idx-not-described-in-bch2_btree_insert_node
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-103-20231219
|   |-- drivers-pwm-pwm-cros-ec.c:warning:Excess-struct-member-dev-description-in-cros_ec_pwm_device
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-104-20231219
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|-- x86_64-randconfig-121-20231220
|   |-- drivers-infiniband-hw-bnxt_re-qplib_fp.c:sparse:left-side-has-type-restricted-__le64
|   |-- drivers-infiniband-hw-bnxt_re-qplib_fp.c:sparse:right-side-has-type-unsigned-long-long
|   |-- drivers-infiniband-hw-bnxt_re-qplib_fp.c:sparse:sparse:invalid-assignment:
|   |-- drivers-infiniband-hw-bnxt_re-qplib_rcfw.c:sparse:left-side-has-type-restricted-__le16
|   |-- drivers-infiniband-hw-bnxt_re-qplib_rcfw.c:sparse:right-side-has-type-unsigned-long
|   `-- drivers-infiniband-hw-bnxt_re-qplib_rcfw.c:sparse:sparse:invalid-assignment:
|-- x86_64-randconfig-161-20231219
|   |-- drivers-atm-idt77252.c-idt77252_rx_raw()-warn:possible-spectre-second-half.-vc
|   |-- drivers-atm-idt77252.c-idt77252_rx_raw()-warn:potential-spectre-issue-card-vcs-r
|   |-- drivers-net-wireless-marvell-mwifiex-sdio.c-mwifiex_check_fw_status()-error:uninitialized-symbol-firmware_stat-.
|   |-- drivers-scsi-mpi3mr-mpi3mr_app.c-mpi3mr_bsg_build_sgl()-warn:missing-unwind-goto
|   |-- drivers-scsi-mpi3mr-mpi3mr_app.c-mpi3mr_map_data_buffer_dma()-warn:returning-instead-of-ENOMEM-is-sloppy
|   |-- lib-kunit-device.c-kunit_device_register_with_driver()-warn:passing-zero-to-ERR_CAST
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
|   |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create
|   |-- lib-zstd-common-bits.h-ZSTD_countLeadingZeros32()-warn:inconsistent-indenting
|   |-- lib-zstd-common-bits.h-ZSTD_countTrailingZeros32()-warn:inconsistent-indenting
|   |-- lib-zstd-compress-..-common-bits.h-ZSTD_countLeadingZeros32()-warn:inconsistent-indenting
|   |-- lib-zstd-compress-..-common-bits.h-ZSTD_countLeadingZeros64()-warn:inconsistent-indenting
|   |-- lib-zstd-compress-..-common-bits.h-ZSTD_countTrailingZeros32()-warn:inconsistent-indenting
|   |-- lib-zstd-compress-..-common-bits.h-ZSTD_countTrailingZeros64()-warn:inconsistent-indenting
|   |-- lib-zstd-decompress-..-common-bits.h-ZSTD_countLeadingZeros32()-warn:inconsistent-indenting
|   |-- lib-zstd-decompress-..-common-bits.h-ZSTD_countTrailingZeros64()-warn:inconsistent-indenting
|   `-- mm-slub.c-__put_partials()-error:calling-spin_unlock_irqrestore()-with-bogus-flags
`-- x86_64-rhel-8.3-rust
    |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-drv-not-described-in-kunit_device_register_with_driver
    |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register
    |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_device_register_with_driver
    |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-name-not-described-in-kunit_driver_create
    |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register
    |-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_device_register_with_driver
    `-- lib-kunit-device.c:warning:Function-parameter-or-struct-member-test-not-described-in-kunit_driver_create

elapsed time: 1500m

configs tested: 200
configs skipped: 5

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231219   gcc  
arc                   randconfig-001-20231220   gcc  
arc                   randconfig-002-20231219   gcc  
arc                   randconfig-002-20231220   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        multi_v5_defconfig   clang
arm                   randconfig-001-20231219   clang
arm                   randconfig-001-20231220   gcc  
arm                   randconfig-002-20231219   clang
arm                   randconfig-002-20231220   gcc  
arm                   randconfig-003-20231219   clang
arm                   randconfig-003-20231220   gcc  
arm                   randconfig-004-20231219   clang
arm                   randconfig-004-20231220   gcc  
arm                         s3c6400_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231219   clang
arm64                 randconfig-001-20231220   gcc  
arm64                 randconfig-002-20231219   clang
arm64                 randconfig-002-20231220   gcc  
arm64                 randconfig-003-20231219   clang
arm64                 randconfig-003-20231220   gcc  
arm64                 randconfig-004-20231220   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231219   gcc  
csky                  randconfig-001-20231220   gcc  
csky                  randconfig-002-20231219   gcc  
csky                  randconfig-002-20231220   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231219   clang
hexagon               randconfig-001-20231220   clang
hexagon               randconfig-002-20231219   clang
hexagon               randconfig-002-20231220   clang
i386                             alldefconfig   gcc  
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231219   clang
i386         buildonly-randconfig-002-20231219   clang
i386         buildonly-randconfig-003-20231219   clang
i386         buildonly-randconfig-004-20231219   clang
i386         buildonly-randconfig-005-20231219   clang
i386         buildonly-randconfig-006-20231219   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231219   clang
i386                  randconfig-002-20231219   clang
i386                  randconfig-003-20231219   clang
i386                  randconfig-004-20231219   clang
i386                  randconfig-005-20231219   clang
i386                  randconfig-006-20231219   clang
i386                  randconfig-011-20231219   gcc  
i386                  randconfig-012-20231219   gcc  
i386                  randconfig-013-20231219   gcc  
i386                  randconfig-014-20231219   gcc  
i386                  randconfig-015-20231219   gcc  
i386                  randconfig-016-20231219   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231219   gcc  
loongarch             randconfig-001-20231220   gcc  
loongarch             randconfig-002-20231219   gcc  
loongarch             randconfig-002-20231220   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          multi_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                       lemote2f_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231219   gcc  
nios2                 randconfig-001-20231220   gcc  
nios2                 randconfig-002-20231219   gcc  
nios2                 randconfig-002-20231220   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20231219   gcc  
parisc                randconfig-001-20231220   gcc  
parisc                randconfig-002-20231219   gcc  
parisc                randconfig-002-20231220   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          g5_defconfig   clang
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                  mpc866_ads_defconfig   clang
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20231220   gcc  
powerpc               randconfig-002-20231219   clang
powerpc               randconfig-002-20231220   gcc  
powerpc               randconfig-003-20231219   clang
powerpc               randconfig-003-20231220   gcc  
powerpc                     redwood_defconfig   gcc  
powerpc64             randconfig-001-20231220   gcc  
powerpc64             randconfig-002-20231219   clang
powerpc64             randconfig-002-20231220   gcc  
powerpc64             randconfig-003-20231219   clang
powerpc64             randconfig-003-20231220   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231219   clang
riscv                 randconfig-001-20231220   gcc  
riscv                 randconfig-002-20231219   clang
riscv                 randconfig-002-20231220   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231220   clang
s390                  randconfig-002-20231220   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                    randconfig-001-20231220   gcc  
sh                    randconfig-002-20231220   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231220   gcc  
sparc64               randconfig-002-20231220   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231220   gcc  
um                    randconfig-002-20231220   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231219   clang
x86_64       buildonly-randconfig-002-20231219   clang
x86_64       buildonly-randconfig-003-20231219   clang
x86_64       buildonly-randconfig-004-20231219   clang
x86_64       buildonly-randconfig-005-20231219   clang
x86_64       buildonly-randconfig-006-20231219   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231219   gcc  
x86_64                randconfig-002-20231219   gcc  
x86_64                randconfig-003-20231219   gcc  
x86_64                randconfig-004-20231219   gcc  
x86_64                randconfig-005-20231219   gcc  
x86_64                randconfig-006-20231219   gcc  
x86_64                randconfig-011-20231219   clang
x86_64                randconfig-012-20231219   clang
x86_64                randconfig-013-20231219   clang
x86_64                randconfig-014-20231219   clang
x86_64                randconfig-015-20231219   clang
x86_64                randconfig-016-20231219   clang
x86_64                randconfig-071-20231219   clang
x86_64                randconfig-072-20231219   clang
x86_64                randconfig-073-20231219   clang
x86_64                randconfig-074-20231219   clang
x86_64                randconfig-075-20231219   clang
x86_64                randconfig-076-20231219   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20231220   gcc  
xtensa                randconfig-002-20231220   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

