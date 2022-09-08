Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4405B110B
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Sep 2022 02:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiIHA1s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Sep 2022 20:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiIHA1q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Sep 2022 20:27:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716C6D0218;
        Wed,  7 Sep 2022 17:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662596865; x=1694132865;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ftDogJIQCWUTb5UK7VS3661UIixUHel8n3Dm/IbgrRI=;
  b=DBnk36FIrAdWUy5j4VCUPEwVrYj+QDdvTz9Gz4xfq5/WlsVZEZFmN8qK
   nkDAjg+D630kMdbnec2ZYdli5QMQJHOfvcJxtvGt+s9e3XuSbx2LGTnz+
   dQsF/TI9IejX1uTsdoEimS4fMkLrWTmBX5BoqzUPNi+XjzNp98r28Nw9D
   SHZDu2JskWe5VhUMaaYTqoikAvrIIhWEH+DzMi8DFK/HqEMjL7vuJzEtx
   w44vzKxQYISGEYaTjC37R2FylHdC0fYFqAUQYx6hjFfOV3RNO0AhrNoyJ
   5BgRczdE+e6mGEgqSIAEiOjEAhvtRC3bXrcI5ptB7fqT33o3yJtEV7kyS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="360993115"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="360993115"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 17:27:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="676440336"
Received: from pbarrios-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.252.133.9])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 17:27:43 -0700
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
Subject: [PATCH v12 0/3] Add TDX Guest Attestation support
Date:   Wed,  7 Sep 2022 17:27:19 -0700
Message-Id: <20220908002723.923241-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
 arch/x86/coco/tdx/tdx.c                       | 112 +++++++++++++
 arch/x86/include/uapi/asm/tdx.h               |  54 ++++++
 tools/arch/x86/include/uapi/asm/tdx.h         |  54 ++++++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/tdx/Makefile          |  11 ++
 tools/testing/selftests/tdx/config            |   1 +
 tools/testing/selftests/tdx/tdx_attest_test.c | 155 ++++++++++++++++++
 8 files changed, 463 insertions(+)
 create mode 100644 arch/x86/include/uapi/asm/tdx.h
 create mode 100644 tools/arch/x86/include/uapi/asm/tdx.h
 create mode 100644 tools/testing/selftests/tdx/Makefile
 create mode 100644 tools/testing/selftests/tdx/config
 create mode 100644 tools/testing/selftests/tdx/tdx_attest_test.c

-- 
2.34.1

