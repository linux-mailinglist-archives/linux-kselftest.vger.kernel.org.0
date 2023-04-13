Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201036E0559
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 05:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjDMDmC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 23:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDMDmB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 23:42:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E32B26B3;
        Wed, 12 Apr 2023 20:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681357320; x=1712893320;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v/a9FAkLxI4hYYSzhU8V3YxbRn7xvE3VC+PavoH5gao=;
  b=E+0lEtf/R5cH+sJZznIR0r30Kz/LXApelmBEg+y/LKBkkJ9M7wTBdkYU
   NQCoZNLiwnCT724bJwCYNqHnVAozeQZkwZxjfHo7rIJWEeGNFGdyLLdpi
   8PkvtoW0UUoAdSLd5GnC0EbGqJRUjsZmWCcJz+A5IrnlZ6FyUhghAUd9+
   xc66NEPCyVIh5vkm6dAZM3ePhJ79HP040hitVOxIVxIs53t5CPcFX3I+h
   FYnttntD82Yk4i1oUU1B6BOiPpJiNlhpsgzZSnPuQ5SIJf/q7fDLRnPLa
   zsNRegEDGqyLGX/USYdugKP56piZZRO7Nv1Wv9k9ExaPRZ0u04tybfHRC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323699351"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="323699351"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 20:41:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="813222552"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="813222552"
Received: from dayerton-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.209.52.214])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 20:41:59 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Chong Cai <chongc@google.com>, Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v2 0/3] TDX Guest Quote generation support
Date:   Wed, 12 Apr 2023 20:41:05 -0700
Message-Id: <20230413034108.1902712-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi All,

In TDX guest, the attestation process is used to verify the TDX guest
trustworthiness to other entities before provisioning secrets to the
guest.

The TDX guest attestation process consists of two steps:

1. TDREPORT generation
2. Quote generation.

The First step (TDREPORT generation) involves getting the TDX guest
measurement data in the format of TDREPORT which is further used to
validate the authenticity of the TDX guest. The second step involves
sending the TDREPORT to a Quoting Enclave (QE) server to generate a
remotely verifiable Quote. TDREPORT by design can only be verified on
the local platform. To support remote verification of the TDREPORT,
TDX leverages Intel SGX Quoting Enclave to verify the TDREPORT
locally and convert it to a remotely verifiable Quote. Although
attestation software can use communication methods like TCP/IP or
vsock to send the TDREPORT to QE, not all platforms support these
communication models. So TDX GHCI specification [1] defines a method
for Quote generation via hypercalls. Please check the discussion from
Google [2] and Alibaba [3] which clarifies the need for hypercall based
Quote generation support. This patch set adds this support.

Support for TDREPORT generation already exists in the TDX guest driver. 
This patchset extends the same driver to add the Quote generation
support.

Following are the details of the patch set:

Patch 1/3 -> Adds event notification IRQ support.
Patch 2/3 -> Adds Quote generation support.
Patch 3/3 -> Adds selftest support for Quote generation feature.

[1] https://cdrdv2.intel.com/v1/dl/getContent/726790, section titled "TDG.VP.VMCALL<GetQuote>".
[2] https://lore.kernel.org/lkml/CAAYXXYxxs2zy_978GJDwKfX5Hud503gPc8=1kQ-+JwG_kA79mg@mail.gmail.com/
[3] https://lore.kernel.org/lkml/a69faebb-11e8-b386-d591-dbd08330b008@linux.alibaba.com/

Kuppuswamy Sathyanarayanan (3):
  x86/tdx: Add TDX Guest event notify interrupt support
  virt: tdx-guest: Add Quote generation support
  selftests/tdx: Test GetQuote TDX attestation feature

 Documentation/virt/coco/tdx-guest.rst        |  11 ++
 arch/x86/coco/tdx/tdx.c                      | 196 +++++++++++++++++++
 arch/x86/include/asm/tdx.h                   |   8 +
 drivers/virt/coco/tdx-guest/tdx-guest.c      | 168 +++++++++++++++-
 include/uapi/linux/tdx-guest.h               |  43 ++++
 tools/testing/selftests/tdx/tdx_guest_test.c |  68 ++++++-
 6 files changed, 487 insertions(+), 7 deletions(-)

-- 
2.34.1

