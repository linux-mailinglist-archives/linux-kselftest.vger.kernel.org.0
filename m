Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D345B3F94
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 21:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiIIT2S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 15:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiIIT15 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 15:27:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B0F1475E2;
        Fri,  9 Sep 2022 12:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662751644; x=1694287644;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iwB2hkLJP9zrS3AcgJ8V1zqeo56l503OAtkrSLh+mTw=;
  b=cBfhQ323V+vvgkfWkk3HpDwc/+fXmnlAE9h9bUCwheYT+MmsHS0oQgjr
   6pbtc48Trbt1aiHXhBqCZBIRGj/x3VtOxDb10EjeFL+C6E4Zy5DjvzvNF
   FSKhS/hAQVOhg2kzV+dvpi4xhhZs1bpRrk7cp4R+Ks48UU6jj+uU9ULro
   JA87Wu3MQOr8RF0mRwp+CyndnlI6B3eSzaTfFpF2kHPF9O6GbB23QjXZ+
   Fx3hG1HSEY3+n2qj0CAUdv8YdoL/j5y6rICl5hrVNq9PjU/5ihiQm7md4
   5mlgfteXN2xjBzAj+ikPl4hGRL5kt8fCKs7sEPAog0IQZ5S+U0LHBLWro
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="277945413"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="277945413"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 12:27:15 -0700
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="677287739"
Received: from hmadupal-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.6.204])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 12:27:15 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v13 0/3] Add TDX Guest Attestation support
Date:   Fri,  9 Sep 2022 12:27:05 -0700
Message-Id: <20220909192708.1113126-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
in the commit log of Patch 1/3 or in Documentation/x86/tdx.rst (added
by patch 3/3).

Following are the details of the patch set:

Patch 1/3 -> Adds TDREPORT support.
Patch 2/3 -> Adds selftest support for TDREPORT feature.
Patch 3/3 -> Add attestation related documentation.

Commit log history is maintained in the individual patches.

Kuppuswamy Sathyanarayanan (3):
  x86/tdx: Add TDX Guest attestation interface driver
  selftests: tdx: Test TDX attestation GetReport support
  Documentation/x86: Document TDX attestation process

 Documentation/x86/tdx.rst                     |  75 +++++++++
 arch/x86/coco/tdx/tdx.c                       | 115 +++++++++++++
 arch/x86/include/uapi/asm/tdx.h               |  56 +++++++
 tools/arch/x86/include/uapi/asm/tdx.h         |  56 +++++++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/tdx/Makefile          |  11 ++
 tools/testing/selftests/tdx/config            |   1 +
 tools/testing/selftests/tdx/tdx_attest_test.c | 157 ++++++++++++++++++
 8 files changed, 472 insertions(+)
 create mode 100644 arch/x86/include/uapi/asm/tdx.h
 create mode 100644 tools/arch/x86/include/uapi/asm/tdx.h
 create mode 100644 tools/testing/selftests/tdx/Makefile
 create mode 100644 tools/testing/selftests/tdx/config
 create mode 100644 tools/testing/selftests/tdx/tdx_attest_test.c

-- 
2.34.1

