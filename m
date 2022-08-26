Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62AE5A2A52
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 17:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240331AbiHZPGy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 11:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbiHZPGw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 11:06:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DAFC2752;
        Fri, 26 Aug 2022 08:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661526411; x=1693062411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=INGF51T/yQRsWlGJI8AAwxkVAWj1/XyBWfVntWZFiNc=;
  b=lWERTVUnrRhvvOc19kIuP7lzrh59YXKqGTFvL05tmX2SOxHOu9n4ekcV
   7aPz2PCm8lwBoe1qJj7fgX6q22r6lgCVkP7NEKnSbXHf6HTWyLIQ9HJlm
   WISSLr6TRsn1xlTb23eZF70GFK1i5ybqpTFZCAyx0w1VsAFfpBo3fchiV
   kXx0p5YlImSBxSnzAkPLhD6lcbuf4beu5PDRokJJ/ic5X2NNeQBhFPIIp
   yyLiVxviMERO5E/q4jqxjRGGUPSiVNC6nTVtIhqnSTK1/Kl76ClL4WUGX
   lejA9aKisAsj1hkwfwR0lYcAt3zYd5m1Pn2w73iTDdcSFgVdl5G33NAer
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="277537974"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="277537974"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 08:06:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="678889600"
Received: from kimdavid-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.252.129.184])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 08:06:48 -0700
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
Subject: [PATCH v11 3/3] Documentation/x86: Document TDX attestation process
Date:   Fri, 26 Aug 2022 08:06:38 -0700
Message-Id: <20220826150638.2397576-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826150638.2397576-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220826150638.2397576-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Document details about TDX attestation process and related user API
support.

Attestation details can be found in Guest-Host-Communication Interface
(GHCI) for Intel Trust Domain Extensions (TDX), section titled "TD
attestation".

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 Documentation/x86/tdx.rst | 75 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/Documentation/x86/tdx.rst b/Documentation/x86/tdx.rst
index b8fa4329e1a5..45db1201b624 100644
--- a/Documentation/x86/tdx.rst
+++ b/Documentation/x86/tdx.rst
@@ -210,6 +210,81 @@ converted to shared on boot.
 For coherent DMA allocation, the DMA buffer gets converted on the
 allocation. Check force_dma_unencrypted() for details.
 
+Attestation
+===========
+
+Attestation is used to verify the TDX guest trustworthiness to other
+entities before provisioning secrets to the guest. For example, a key
+server may request for attestation before releasing the encryption keys
+to mount the encrypted rootfs or secondary drive.
+
+TDX module records the state of the TDX guest in various stages of guest
+boot process using build time measurement register (MRTD) and runtime
+measurement registers (RTMR). Measurements related to guest initial
+configuration and firmware image is recorded in the MRTD register.
+Measurements related to initial state, kernel image, firmware image,
+command line options, initrd, ACPI tables, etc are recorded in RTMR
+registers. For more details, please refer to TDX Virtual Firmware design
+specification, sec titled "TD Measurement".
+
+At TDX guest runtime, the Intel TDX module reuses the Intel SGX attestation
+infrastructure to provide support for attesting to these measurements as
+described below.
+
+The attestation process consists of two steps: TDREPORT generation and
+Quote generation.
+
+TDX guest uses TDCALL[TDG.MR.REPORT] to get the TDREPORT (TDREPORT_STRUCT)
+from the TDX module. TDREPORT is a fixed-size data structure generated by
+the TDX module which contains guest-specific information (such as build
+and boot measurements), platform security version, and the MAC to protect
+the integrity of the TDREPORT.
+
+After getting the TDREPORT, the second step of the attestation process
+is to send it to the QE to generate the Quote. TDREPORT by design can only
+be verified on local platform as the MAC key is bound to the platform. To
+support remote verification of the TDREPORT, TDX leverages Intel SGX Quote
+Enclave (QE) to verify the TDREPORT locally and convert it to a remote
+verifiable Quote. Method of sending TDREPORT to QE is implemenentation
+specific. Attestation software can choose whatever communication channel
+available (i.e. vsock or hypercall) to send the TDREPORT to QE and receive
+the Quote.
+
+To allow userspace attestation agent get the TDREPORT, TDX guest driver
+exposes an IOCTL (TDX_CMD_GET_REPORT) interface via /dev/tdx-guest misc
+device.
+
+TDX Guest driver
+================
+
+The TDX guest driver exposes IOCTL interfaces via /dev/tdx-guest misc
+device to allow user space to get certain TDX guest specific details
+(like attestation report, attestation quote or storage keys, etc).
+
+In this section, for each supported IOCTL, following information is
+provided along with generic description.
+
+Input parameters: Parameters passed to the IOCTL and related details.
+Output          : Details about output data and return value (with details
+                  about the non common error values).
+
+TDX_CMD_GET_REPORT
+------------------
+
+:Input parameters: struct tdx_report_req
+:Output          : Upon successful execution, TDREPORT data is copied to
+                   tdx_report_req.tdreport and returns 0 or returns
+                   -EIO on TDCALL failure and standard error number on
+                   other common failures.
+
+The TDX_CMD_GET_REPORT IOCTL can be used by the attestation software to
+get the TDX guest measurements data (with few other info) in the format
+of TDREPORT_STRUCT. It uses TDCALL[TDG.MR.REPORT] to get the TDREPORT
+from the TDX Module.
+
+Format of TDREPORT_STRUCT can be found in TDX 1.0 Module specification,
+sec titled "TDREPORT_STRUCT".
+
 References
 ==========
 
-- 
2.25.1

