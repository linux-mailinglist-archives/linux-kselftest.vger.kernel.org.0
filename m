Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1837D6106CE
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Oct 2022 02:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiJ1A2u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Oct 2022 20:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiJ1A2t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Oct 2022 20:28:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD87A2332;
        Thu, 27 Oct 2022 17:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666916928; x=1698452928;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cLR1KG+Ou2LQDJ/ROrlk412K74arvA0PceC9Uu9ii08=;
  b=ifWDujvrjxQ8zjYxX9tp89OGknl7rck49gojJ7iha+pEkugDpQIas7hp
   efxmSvC308+SLgJ8JEM6lilE/1Djfg/MBRb7/Gl6IoDoJ7HqYdTfJC7gC
   iop7DIJ1SrW0rmyfStDFqZwzsZSwyfc31bVVsjHZbpIuYddG5aE0CYuQF
   7DBQXbsd2qjSKjaT85uGDrjXzlPMoFqfZDARaK/lprk+1EGhoOz2pQusx
   psLbw9zKOd8YyTV5Yajwfx1go+NdgbBB91Jd36ZCEoB4FWCrYZzidPOGr
   FTFcPV6N+MtyUwhkTteXhK1wszO+u+300vUCyd9nV7++tuBWa2Z1iAUn3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="288091256"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="288091256"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 17:28:48 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="627356153"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="627356153"
Received: from ortizseb-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.212.153.115])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 17:28:47 -0700
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
Subject: [PATCH v16 0/3] Add TDX Guest Attestation support
Date:   Thu, 27 Oct 2022 17:28:17 -0700
Message-Id: <20221028002820.3303030-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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

Current overall status of this series is, it has no pending issues
and can be considered for the upcoming merge cycle.

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
 drivers/virt/coco/tdx-guest/tdx-guest.c      | 121 +++++++++++++
 include/uapi/linux/tdx-guest.h               |  55 ++++++
 tools/testing/selftests/Makefile             |   1 +
 tools/testing/selftests/tdx/Makefile         |   7 +
 tools/testing/selftests/tdx/config           |   1 +
 tools/testing/selftests/tdx/tdx_guest_test.c | 175 +++++++++++++++++++
 15 files changed, 494 insertions(+)
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

