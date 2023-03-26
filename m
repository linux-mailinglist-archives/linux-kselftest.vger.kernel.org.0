Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B876C92BD
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Mar 2023 08:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjCZGUz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Mar 2023 02:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCZGUw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Mar 2023 02:20:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2A340FD;
        Sat, 25 Mar 2023 23:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679811650; x=1711347650;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SyfK9Omb+5LaXVWXFJR8Lfqtv+Cz1gSgt2M7uXUhVTU=;
  b=ClIrJmaPqnX12vp81flHsSHXe3wNCvLm1I2ahsv9NkUID7H7LK2BLKPj
   gldNMmEvT59wSHRA7CVSrW9vD3RmOfJOINX3Gfu7IPmnhJrH6KNruWKRa
   6v8YFrnBeVd4Hz8spp/XyPyJnjplS4wnXCcQw9Wi1W0ppGWSjAZHF1/Cv
   1OiEmebFomAm7xK/zSraxFMWCdCVziMJlaa32iRD/bDEnBxx+cOibJbuN
   6qBGcU/2o0JLVLZahnCgTIi9iswKhwWxzAskG3oZHxWnr81Nr+7st46MB
   TrXqnpfGJ4b828pASsbCgE+tOWEnmx2raodeV1M7/6gG5nQKGudWrc7fU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10660"; a="341628530"
X-IronPort-AV: E=Sophos;i="5.98,292,1673942400"; 
   d="scan'208";a="341628530"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 23:20:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10660"; a="660510701"
X-IronPort-AV: E=Sophos;i="5.98,292,1673942400"; 
   d="scan'208";a="660510701"
Received: from srivats1-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.209.108.178])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 23:20:49 -0700
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
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v1 0/3] TDX Guest Quote generation support
Date:   Sat, 25 Mar 2023 23:20:36 -0700
Message-Id: <20230326062039.341479-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

 Documentation/virt/coco/tdx-guest.rst        |  11 +
 arch/x86/coco/tdx/tdx.c                      | 203 +++++++++++++++
 arch/x86/include/asm/tdx.h                   |   8 +
 drivers/virt/coco/tdx-guest/tdx-guest.c      | 249 ++++++++++++++++++-
 include/uapi/linux/tdx-guest.h               |  44 ++++
 tools/testing/selftests/tdx/tdx_guest_test.c |  68 ++++-
 6 files changed, 575 insertions(+), 8 deletions(-)

-- 
2.34.1

