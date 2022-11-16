Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B14262CDCE
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 23:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiKPWi3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 17:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiKPWi2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 17:38:28 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBCF14013;
        Wed, 16 Nov 2022 14:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668638307; x=1700174307;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NRMsF2GzNxJbS/1EDuibTDtQAzC/aTBbwrI1jU8kKgM=;
  b=B5YYnnbIgINFCO4tjBcki+ul5eJBOPdf0jkj+Gz5TJuj89POdU4q9yJ+
   I3RjxiMWRe8PDvFV5FuPK+24aLxKfnYxoTUosklk+/2GI9j5p2iTJtcqC
   XRylP/A52U4j3+j1hN/NOwTLKmIr1/rHRE+QbiA3cXY+iSLBpMEV4Mp6G
   VoY+Krk6ZZLSkK2794F9RNRFHrQ8acvmxBzXth/boFO089NnoHC3wuD05
   i2RoIw8JzIYl86iBZlIUj96zDeTm6tgaPgDgqlwgO4DbMMk2MY0+7QLaX
   6K27CZQjmZ7l4w7GGV3P83+ZLkeofmg00lTS9c1UlUOKdzrsqTunSrDjt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="398972921"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="398972921"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 14:38:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="670674999"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="670674999"
Received: from swetasha-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.209.58.91])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 14:38:26 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v18 0/3] Add TDX Guest Attestation support
Date:   Wed, 16 Nov 2022 14:38:17 -0800
Message-Id: <20221116223820.819090-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi All,

Intel's Trust Domain Extensions (TDX) protect guest VMs from malicious
hosts and some physical attacks. VM guest with TDX support is called
as a TDX Guest.

In TDX guest, the attestation process is used to verify the TDX guest
trustworthiness to other entities before provisioning secrets to the
guest. For example, a key server may request for attestation before
releasing the encryption keys to mount the encrypted rootfs or
secondary drive.

This patch set adds attestation support for the TDX guest. Details
about the TDX attestation process and the steps involved are explained
in Documentation/x86/tdx.rst (added by patch 2/3).

Following are the details of the patch set:

Patch 1/3 -> Preparatory patch for adding attestation support.
Patch 2/3 -> Adds user interface driver to support attestation.
Patch 3/3 -> Adds selftest support for TDREPORT feature.

Commit log history is maintained in the individual patches.

Current overall status of this series is, it has no pending issues
and can be considered for the upcoming merge cycle.

Kuppuswamy Sathyanarayanan (3):
  x86/tdx: Add a wrapper to get TDREPORT0 from the TDX Module
  virt: Add TDX guest driver
  selftests: tdx: Test TDX attestation GetReport support

 Documentation/virt/coco/tdx-guest.rst        |  52 ++++++
 Documentation/virt/index.rst                 |   1 +
 Documentation/x86/tdx.rst                    |  43 +++++
 arch/x86/coco/tdx/tdx.c                      |  40 +++++
 arch/x86/include/asm/tdx.h                   |   2 +
 drivers/virt/Kconfig                         |   2 +
 drivers/virt/Makefile                        |   1 +
 drivers/virt/coco/tdx-guest/Kconfig          |  10 ++
 drivers/virt/coco/tdx-guest/Makefile         |   2 +
 drivers/virt/coco/tdx-guest/tdx-guest.c      | 102 ++++++++++++
 include/uapi/linux/tdx-guest.h               |  42 +++++
 tools/testing/selftests/Makefile             |   1 +
 tools/testing/selftests/tdx/Makefile         |   7 +
 tools/testing/selftests/tdx/config           |   1 +
 tools/testing/selftests/tdx/tdx_guest_test.c | 163 +++++++++++++++++++
 15 files changed, 469 insertions(+)
 create mode 100644 Documentation/virt/coco/tdx-guest.rst
 create mode 100644 drivers/virt/coco/tdx-guest/Kconfig
 create mode 100644 drivers/virt/coco/tdx-guest/Makefile
 create mode 100644 drivers/virt/coco/tdx-guest/tdx-guest.c
 create mode 100644 include/uapi/linux/tdx-guest.h
 create mode 100644 tools/testing/selftests/tdx/Makefile
 create mode 100644 tools/testing/selftests/tdx/config
 create mode 100644 tools/testing/selftests/tdx/tdx_guest_test.c

-- 
2.34.1

