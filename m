Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD574618EE5
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Nov 2022 04:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiKDD0O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 23:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiKDDZl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 23:25:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0899B55A2;
        Thu,  3 Nov 2022 20:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667532241; x=1699068241;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+K0KHiANdHtRLNlLpBoLS86KP7cKwh6NE3ig6cqeZeI=;
  b=KBeaFCmzlZHshVG8nCoZASiSHX6FK3+x3P5YP7irRM+j8iAwGrGxdgmt
   MnMn+xoD8DhZrcBKen5YldMHsPv49wkeLOcGkv58PWtZGn2hLx6AVsoo9
   ZFRmcseiD5BH3sm+MfFmjBOvgekWpQyVFX4wQzeD+Kvqc9kxDbOY2Z071
   wGojqke8YeN/NGRr3mXS1RbOpmkOfq9z0zDVgtWU3A+EK149vR0BZItjf
   YldfY0tL+y5po2JUDluJDixMnKW4pM9+NTq0fc6+XGY1rwox0d3pgNi0Z
   hlw/9d3vRCehV/8QJlX1lcfThuPrX5+OeD5JGtmHxXXqsSOhxvcnqrOlK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="307491936"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="307491936"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 20:24:00 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="703932012"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="703932012"
Received: from fswhite-mobl3.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.212.196.122])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 20:23:59 -0700
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
Subject: [PATCH v17 0/3] Add TDX Guest Attestation support
Date:   Thu,  3 Nov 2022 20:23:52 -0700
Message-Id: <20221104032355.227814-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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
 arch/x86/coco/tdx/tdx.c                      |  38 +++++
 arch/x86/include/asm/tdx.h                   |   2 +
 drivers/virt/Kconfig                         |   2 +
 drivers/virt/Makefile                        |   1 +
 drivers/virt/coco/tdx-guest/Kconfig          |  10 ++
 drivers/virt/coco/tdx-guest/Makefile         |   2 +
 drivers/virt/coco/tdx-guest/tdx-guest.c      | 102 ++++++++++++
 include/uapi/linux/tdx-guest.h               |  41 +++++
 tools/testing/selftests/Makefile             |   1 +
 tools/testing/selftests/tdx/Makefile         |   7 +
 tools/testing/selftests/tdx/config           |   1 +
 tools/testing/selftests/tdx/tdx_guest_test.c | 163 +++++++++++++++++++
 15 files changed, 456 insertions(+)
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

