Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619E25FD902
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Oct 2022 14:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJMMOF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Oct 2022 08:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJMMN6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Oct 2022 08:13:58 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C7BFF20D
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 05:13:53 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id k19-20020a056a00135300b0054096343fc6so1129862pfu.10
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 05:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H9SaswMeDVA0PXtGn+/RgF2ttyuiFbIBcmIgImTCEOc=;
        b=Ii25z3y8bR8LKI7fL+IKrahfLIIcV3i2dTRT7mx45kXaZTqxy+AlAEJavNtwpa3Anw
         FzlrCvqcIVsgqY5N/4i6RpGtHtnXrv/KT6iO8pgRcqZeKk0f08HQPZeixvrS75+Ucw5L
         VV0Kp9LASJiH661+y+0zqS+0bi4Ge2wi5JIRdmc3Simtu4fnznbSA2LJuCQfxGGBNgOd
         km5BGclc4f2DTtfQwUTKXBVv+e3Mc14iEnNDliLXhGJtJJ+t/Xt3wBj9OliaFx99xuMS
         sLj0INBleT8YXIcOCau1ft0h9gLiAptL/Q5xHngJ5C8CySJVqOXuEHFcRnQWu/xLRthx
         +jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H9SaswMeDVA0PXtGn+/RgF2ttyuiFbIBcmIgImTCEOc=;
        b=wGQtxgNualdgE0K0gYNW4zoikzVq6DBDVXQ0g21KIMFeE+LZysaFZo1TWLqJzD30Tx
         PgdhNXW+zHeYzQ46Ed9uZj/p0EuD89nDZpS2tFsrQ58OF6XWFcUql8zntJLRazHsjlI4
         ts+eV1Tqt1Es5o56m/0O9araGLXZrt6OmPyyzrKDHNoR4/iCkCDpW+q6KQIBnF+V/Yru
         QVrFfb7epIlf/JDoWhV8tb+QkmmW6DLUl2gJIq7d6ngsJxBiR1erBf8eS2J2VJLbKe6b
         GbQsZg402dkI5euDvbl2zK1rfricK5j/q0cY+wHrUXFwtGHzA+DJjfumhd6uvi+uAzIU
         2HVw==
X-Gm-Message-State: ACrzQf1dpfF/ov+Kxji6bWyjrm4Fhn5Dwc3mtQY8nEjrjCGIY9KmcJN5
        3mCWYujvX0Fbdhj3MUKCaPzyKAi4gbMnB139
X-Google-Smtp-Source: AMsMyM4D8UD/snB7p//EsveGwAXY3dAujc5wCqE1XPJTo18Kkxmke1rbuc5ZoadCWIyta62qcE9Z4Z4GaauE7Vv5
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90a:8c8e:b0:202:883b:2644 with SMTP
 id b14-20020a17090a8c8e00b00202883b2644mr10744181pjo.89.1665663233436; Thu,
 13 Oct 2022 05:13:53 -0700 (PDT)
Date:   Thu, 13 Oct 2022 12:13:19 +0000
In-Reply-To: <20221013121319.994170-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221013121319.994170-1-vannapurve@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221013121319.994170-5-vannapurve@google.com>
Subject: [V3 PATCH 4/4] KVM: selftests: x86: Precompute the cpu type
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, shuah@kernel.org, bgardon@google.com,
        seanjc@google.com, oupton@google.com, peterx@redhat.com,
        vkuznets@redhat.com, dmatlack@google.com,
        Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Cache the vendor CPU type in a global variable so that multiple calls
to is_amd/intel_cpu() do not need to re-execute CPUID.

Sync the global variable is_cpu_amd into the guest so the guest can also
avoid executing CPUID instruction.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index fa65e8142c16..f508e58346e9 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -19,6 +19,7 @@
 #define MAX_NR_CPUID_ENTRIES 100
 
 vm_vaddr_t exception_handlers;
+static bool is_cpu_amd;
 
 static void regs_dump(FILE *stream, struct kvm_regs *regs, uint8_t indent)
 {
@@ -1046,7 +1047,7 @@ static bool cpu_vendor_string_is(const char *vendor)
 
 bool is_intel_cpu(void)
 {
-	return cpu_vendor_string_is("GenuineIntel");
+	return !is_cpu_amd;
 }
 
 /*
@@ -1054,7 +1055,7 @@ bool is_intel_cpu(void)
  */
 bool is_amd_cpu(void)
 {
-	return cpu_vendor_string_is("AuthenticAMD");
+	return is_cpu_amd;
 }
 
 void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
@@ -1328,8 +1329,13 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm)
 	return get_kvm_intel_param_bool("unrestricted_guest");
 }
 
+void kvm_selftest_arch_init(void)
+{
+	is_cpu_amd = cpu_vendor_string_is("AuthenticAMD");
+}
 
 void kvm_arch_vm_post_create(struct kvm_vm *vm)
 {
 	vm_create_irqchip(vm);
+	sync_global_to_guest(vm, is_cpu_amd);
 }
-- 
2.38.0.rc1.362.ged0d419d3c-goog

