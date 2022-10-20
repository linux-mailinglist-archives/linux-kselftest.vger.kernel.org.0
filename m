Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B3960568A
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Oct 2022 06:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJTE7i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Oct 2022 00:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJTE7h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Oct 2022 00:59:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D462D186C0;
        Wed, 19 Oct 2022 21:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666241976; x=1697777976;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZeManeh8urWZwWabFCHDLXg+rU167WQjv7MnROaoT+c=;
  b=iZKnrB6Mzh4kRxAmhhdNmiO4mrkgsfbBHx3M2gxMvuErDEoWgkuNc9PB
   Y5HMaS7+aWNv2biveH5WB2PCnavgiSYkAXX5i7/g46KMF3ZHbLHEe0tib
   mNLYVzQXL4ewrXj17NiPzPdL0+lx5mWbASnlSOCSUGL69rIEJtFk2G0Bg
   Z2/NvyEu7z7VJgP9Kl7m1U7t+95eQwRLdNonunwvGe7+XmH5j2/nydEpC
   zT5VfFQk3HzPs6tIqHMzB6JA3Lcp2VvqLQuIqFs7bprXqy3wifFS4YAjy
   tqNVBBcNFTPcZA6zf58j3hKaIJDSYAQOCGmOrXuE2Bq4nKr64P3FKUUEM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="293997446"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="293997446"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 21:59:31 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="660690252"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="660690252"
Received: from srnaisha-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.209.25.189])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 21:59:30 -0700
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
Subject: [PATCH v15 0/3]] Add TDX Guest Attestation support
Date:   Wed, 19 Oct 2022 21:58:25 -0700
Message-Id: <20221020045828.2354731-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
  x86/tdx: Add a wrapper to get TDREPORT from the TDX Module
  virt: Add TDX guest driver
  selftests: tdx: Test TDX attestation GetReport support

 Documentation/virt/coco/tdx-guest.rst        |  42 +++++
 Documentation/virt/index.rst                 |   1 +
 Documentation/x86/tdx.rst                    |  43 +++++
 arch/x86/coco/tdx/tdx.c                      |  31 ++++
 arch/x86/include/asm/tdx.h                   |   2 +
 drivers/virt/Kconfig                         |   2 +
 drivers/virt/Makefile                        |   1 +
 drivers/virt/coco/tdx-guest/Kconfig          |  10 ++
 drivers/virt/coco/tdx-guest/Makefile         |   2 +
 drivers/virt/coco/tdx-guest/tdx-guest.c      | 131 ++++++++++++++
 include/uapi/linux/tdx-guest.h               |  51 ++++++
 tools/testing/selftests/Makefile             |   1 +
 tools/testing/selftests/tdx/Makefile         |   7 +
 tools/testing/selftests/tdx/config           |   1 +
 tools/testing/selftests/tdx/tdx_guest_test.c | 175 +++++++++++++++++++
 15 files changed, 500 insertions(+)
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

