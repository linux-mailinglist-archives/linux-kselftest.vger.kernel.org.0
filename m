Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 731E6114DEC
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2019 10:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfLFJBi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Dec 2019 04:01:38 -0500
Received: from mga09.intel.com ([134.134.136.24]:50484 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfLFJBi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Dec 2019 04:01:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2019 01:01:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,283,1571727600"; 
   d="scan'208";a="219395084"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.57])
  by fmsmga001.fm.intel.com with ESMTP; 06 Dec 2019 01:01:36 -0800
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 0/3] Reanme the definitions of INTERRUPT_PENDING, NMI_PENDING and TSC_OFFSETING 
Date:   Fri,  6 Dec 2019 16:45:23 +0800
Message-Id: <20191206084526.131861-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When reading the codes, I find the definitions of interrupt-window exiting and
nmi-window exiting don't match the names in latest intel SDM.

I have no idea whether it's the historical names, rename them to match the
latest SDM to avoid confusion.

CPU_BASED_USE_TSC_OFFSETING mis-spelling in Patch 3 is found by checkpatch.pl. 

Xiaoyao Li (3):
  KVM: VMX: Rename INTERRUPT_PENDING to INTERRUPT_WINDOW
  KVM: VMX: Rename NMI_PENDING to NMI_WINDOW
  KVM: VMX: Fix the spelling of CPU_BASED_USE_TSC_OFFSETTING

 arch/x86/include/asm/vmx.h                    |  6 ++--
 arch/x86/include/uapi/asm/vmx.h               |  4 +--
 arch/x86/kvm/vmx/nested.c                     | 28 +++++++++----------
 arch/x86/kvm/vmx/vmx.c                        | 20 ++++++-------
 tools/arch/x86/include/uapi/asm/vmx.h         |  4 +--
 .../selftests/kvm/include/x86_64/vmx.h        |  8 +++---
 .../kvm/x86_64/vmx_tsc_adjust_test.c          |  2 +-
 7 files changed, 36 insertions(+), 36 deletions(-)

-- 
2.19.1

