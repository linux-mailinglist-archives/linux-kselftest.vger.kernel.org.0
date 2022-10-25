Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FDB60CC4D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 14:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiJYMp5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 08:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiJYMpk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 08:45:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D78190E65
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 05:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666701827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QrufkFAvyi6r9X0w4L0+uH1Qm3sKkNM96SGOrjFRcCQ=;
        b=HhnlbUi43Eg5mE/XYyLueRkXylEX42eZlNVQRcVR+VygxglAnxoQr1kD9zNEA18sy8+UTB
        fDmSnGytZdatyxRsR3IgCwyeXKtAURDdBhpeaMX3PAZdN5GvKDhRQdBiZsYEJa68GBY9xf
        //9CR2sB0Co3nE8ElI99tW0tU/R+VGE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-z4NTdB_4Mz2gjleY8VIkVQ-1; Tue, 25 Oct 2022 08:43:44 -0400
X-MC-Unique: z4NTdB_4Mz2gjleY8VIkVQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 649F03C0F45D;
        Tue, 25 Oct 2022 12:43:39 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FA86200BA63;
        Tue, 25 Oct 2022 12:43:20 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Yang Zhong <yang.zhong@intel.com>,
        linux-kselftest@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        Guang Zeng <guang.zeng@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Wei Wang <wei.w.wang@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH v4 14/23] KVM: x86: smm: number of GPRs in the SMRAM image depends on the image format
Date:   Tue, 25 Oct 2022 15:42:14 +0300
Message-Id: <20221025124223.227577-15-mlevitsk@redhat.com>
In-Reply-To: <20221025124223.227577-1-mlevitsk@redhat.com>
References: <20221025124223.227577-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 64 bit host, if the guest doesn't have X86_FEATURE_LM, KVM will
access 16 gprs to 32-bit smram image, causing out-ouf-bound ram
access.

On 32 bit host, the rsm_load_state_64/enter_smm_save_state_64
is compiled out, thus access overflow can't happen.

Fixes: b443183a25ab61 ("KVM: x86: Reduce the number of emulator GPRs to '8' for 32-bit KVM")

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c | 1 +
 arch/x86/kvm/smm.c     | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 5cc3efa0e21c17..ac6fac25ba25d8 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2307,6 +2307,7 @@ static int em_lseg(struct x86_emulate_ctxt *ctxt)
 	return rc;
 }
 
+
 static int em_rsm(struct x86_emulate_ctxt *ctxt)
 {
 	if ((ctxt->ops->get_hflags(ctxt) & X86EMUL_SMM_MASK) == 0)
diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
index 41ca128478fcd4..b290ad14070f72 100644
--- a/arch/x86/kvm/smm.c
+++ b/arch/x86/kvm/smm.c
@@ -382,7 +382,7 @@ static int rsm_load_state_32(struct x86_emulate_ctxt *ctxt,
 	ctxt->eflags =             GET_SMSTATE(u32, smstate, 0x7ff4) | X86_EFLAGS_FIXED;
 	ctxt->_eip =               GET_SMSTATE(u32, smstate, 0x7ff0);
 
-	for (i = 0; i < NR_EMULATOR_GPRS; i++)
+	for (i = 0; i < 8; i++)
 		*reg_write(ctxt, i) = GET_SMSTATE(u32, smstate, 0x7fd0 + i * 4);
 
 	val = GET_SMSTATE(u32, smstate, 0x7fcc);
@@ -438,7 +438,7 @@ static int rsm_load_state_64(struct x86_emulate_ctxt *ctxt,
 	u64 val, cr0, cr3, cr4;
 	int i, r;
 
-	for (i = 0; i < NR_EMULATOR_GPRS; i++)
+	for (i = 0; i < 16; i++)
 		*reg_write(ctxt, i) = GET_SMSTATE(u64, smstate, 0x7ff8 - i * 8);
 
 	ctxt->_eip   = GET_SMSTATE(u64, smstate, 0x7f78);
-- 
2.34.3

