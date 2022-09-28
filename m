Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0796F5EE8BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Sep 2022 23:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbiI1V4R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Sep 2022 17:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiI1V4Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Sep 2022 17:56:16 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE444CE13;
        Wed, 28 Sep 2022 14:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664402176; x=1695938176;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Mt51ZtHrZsJ0S2Nwi2p7REGTZebPRfuMMt9Z+Psz7TE=;
  b=dzfV/xTcrKHjRgbHZF4qDi8nExj9LjklpEF+axxXDeTNIsy0/2uyiyCp
   a6HWTFe6YEH7G0C1sjKk3z363CsuMgrQ9a2kdBL1Kv42iRvli3pCIUTSq
   UhoromVt1i+gwBZ6NRpUZUP4GWgMi8wLSWsUDeDg4a2tlaMU15mnwqO3e
   Tq3+aR2rIwmdJp9nmoTz4NTiIX1IRrGI0WIxnbS+VxKN3mWGQUFLiSbYd
   5uJnB3ASLNvjg8vPI/drLZSw/9hfh5okkgchpzxXscsKkfucGrXwplaoC
   xa0+7mIY2bQ6fwlzPzYPSTWck/IpobU2DORwvCfh5UWW4+gtaQi4bIMNP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="363566930"
X-IronPort-AV: E=Sophos;i="5.93,353,1654585200"; 
   d="scan'208";a="363566930"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 14:56:15 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="652848685"
X-IronPort-AV: E=Sophos;i="5.93,353,1654585200"; 
   d="scan'208";a="652848685"
Received: from mjpaul-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.209.66.23])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 14:56:15 -0700
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
Subject: [PATCH v14 0/3] Add TDX Guest Attestation support
Date:   Wed, 28 Sep 2022 14:55:32 -0700
Message-Id: <20220928215535.26527-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

In TDX guest, attestation process is used to verify the TDX guest
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

Kuppuswamy Sathyanarayanan (3):
  x86/tdx: Make __tdx_module_call() usable in driver module
  virt: Add TDX guest driver
  selftests: tdx: Test TDX attestation GetReport support

 Documentation/virt/coco/tdx-guest.rst        |  42 +++++
 Documentation/virt/index.rst                 |   1 +
 Documentation/x86/tdx.rst                    |  43 +++++
 arch/x86/coco/tdx/tdcall.S                   |   2 +
 arch/x86/coco/tdx/tdx.c                      |   5 -
 arch/x86/include/asm/tdx.h                   |   6 +
 drivers/virt/Kconfig                         |   2 +
 drivers/virt/Makefile                        |   1 +
 drivers/virt/coco/tdx-guest/Kconfig          |  10 ++
 drivers/virt/coco/tdx-guest/Makefile         |   2 +
 drivers/virt/coco/tdx-guest/tdx-guest.c      | 131 ++++++++++++++
 include/uapi/linux/tdx-guest.h               |  53 ++++++
 tools/testing/selftests/Makefile             |   1 +
 tools/testing/selftests/tdx/Makefile         |   7 +
 tools/testing/selftests/tdx/config           |   1 +
 tools/testing/selftests/tdx/tdx_guest_test.c | 175 +++++++++++++++++++
 16 files changed, 477 insertions(+), 5 deletions(-)
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

