Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15427701C17
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 May 2023 09:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjENHYB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 14 May 2023 03:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjENHYA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 14 May 2023 03:24:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C0F199E;
        Sun, 14 May 2023 00:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684049039; x=1715585039;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=npeBkINJGxSpUKevbIGygQlsBP2qc6pkrXvu4pgq/P0=;
  b=cxCsUnthsil2N/LWw/zopFTfo0uRrDGlaIxYMecg1zSHGRGENx96OmfR
   yaQ2b+yDwuuL7e3Pvft0IAECx0cLSver+2xoIYFtkduhq6OcKpVFG3yl9
   M884sFg0y47xXX/mO3+AVAWgWZNnhldC9OBcqmyaeBSsa54WfiadVsdcI
   o9bGs4622B99q09T7nHNiviEb9W2gAHXPqVBuhW2RU2zwtueo/2InAtt2
   Tg2HfrKkMXRaYW67nXOiBR4WgmvlXBmczbb13YLrFLfuYJeQ7Tz3PCqn1
   2jbk9GTxeO0N+ai6ewnqub2WNdi1UHHhWuj8FygdVPNMmtiUvwXEHDBZm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="354167273"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="354167273"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 00:23:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="731262936"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="731262936"
Received: from mply-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.212.130.17])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 00:23:57 -0700
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
Subject: [PATCH v3 0/3] TDX Guest Quote generation support
Date:   Sun, 14 May 2023 00:23:43 -0700
Message-Id: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
 arch/x86/coco/tdx/tdx.c                      | 194 +++++++++++++++++++
 arch/x86/include/asm/tdx.h                   |   8 +
 drivers/virt/coco/tdx-guest/tdx-guest.c      | 175 ++++++++++++++++-
 include/uapi/linux/tdx-guest.h               |  44 +++++
 tools/testing/selftests/tdx/tdx_guest_test.c |  65 ++++++-
 6 files changed, 490 insertions(+), 7 deletions(-)

-- 
2.34.1

