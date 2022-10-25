Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEEC60CC46
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 14:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiJYMot (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 08:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbiJYMoE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 08:44:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D26190E75
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 05:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666701795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IkrTzU5rG8TBDhJXggqu3Ho3+X8GGbZwRVqLpyPTTs0=;
        b=f5lYkph5utLGCpnM/Z9LEzGIxFGUhMa5GfxQ8iBP8MnwhzYXP54KpVsnTzZwgk4sIowzO2
        lL7L71YLBHuUKojIOWEKSeoS7vU++8Jh8oM6CmCqvnZZuhmgrWVdK5eg8ijH3EQCt86ktZ
        sEOmnvO+zgcg/go06fV+5XPcSVICZec=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-PM1bvPmSOxWnXe8PjSY2UQ-1; Tue, 25 Oct 2022 08:43:12 -0400
X-MC-Unique: PM1bvPmSOxWnXe8PjSY2UQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD5723833289;
        Tue, 25 Oct 2022 12:43:11 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59AA320290A2;
        Tue, 25 Oct 2022 12:43:08 +0000 (UTC)
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
Subject: [PATCH v4 12/23] KVM: x86: emulator: update the emulation mode after rsm
Date:   Tue, 25 Oct 2022 15:42:12 +0300
Message-Id: <20221025124223.227577-13-mlevitsk@redhat.com>
In-Reply-To: <20221025124223.227577-1-mlevitsk@redhat.com>
References: <20221025124223.227577-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Update the emulation mode after RSM so that RIP will be correctly
written back, because the RSM instruction can switch the CPU mode from
32 bit (or less) to 64 bit.

This fixes a guest crash in case the #SMI is received while the guest
runs a code from an address > 32 bit.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/emulate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c65f57b6da9bf1..2c56d08b426065 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2315,7 +2315,7 @@ static int em_rsm(struct x86_emulate_ctxt *ctxt)
 	if (ctxt->ops->leave_smm(ctxt))
 		ctxt->ops->triple_fault(ctxt);
 
-	return X86EMUL_CONTINUE;
+	return emulator_recalc_and_set_mode(ctxt);
 }
 
 static void
-- 
2.34.3

