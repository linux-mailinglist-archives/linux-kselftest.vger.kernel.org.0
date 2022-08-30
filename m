Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8775A70F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbiH3Wn3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiH3WnT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:43:19 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AAC73324
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:43:17 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id n1-20020a170902d2c100b0017520dd4a0eso1749658plc.8
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=2fODE+rP/n4IhsKmyo9TrmeTKfUIF5nKP0v2EkUrneo=;
        b=gbNNPUBOKBKap2s5shHHjkVzc/iNv8XHjMpvm09nylSEQ3SOdpxMf259plptLgOyhm
         qtBnC5ARhX9mqeSUEQxwbwuiVXzeMEEAIsNqGvXWYo4cqOY+Vq10bLL0/E/u117bHK1I
         BppB22ajOfm+RKivJWNiOP4n6ezKLNCsf/eBjzeNYmUBoiTwWRYoGrABmFQhHfdANFR8
         xc1V/n47Al7DVl2uTC7HoRXD3hwb0eWA8BBGtjplkqwmjVe1rbwtJJdWIr9ER/UOLK8x
         BsStvO82puuasYylYs10rEkZa8kjaQb1W/tseZoyMgSIsRHmFNCCa5zWJT5GNmRtA45f
         3i6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=2fODE+rP/n4IhsKmyo9TrmeTKfUIF5nKP0v2EkUrneo=;
        b=hYgZf8F1WyEZbL7txGjZAl/hN/N/JHACbiiLKxKDRvXN+dStyUFuwONeTNyNPxfUds
         2+RTUssnT+SkRJcLBywCyUHt82OcGUNc/kVuF+WAcPwGH8ZemJUd2vWmAzZAn5YYo+XP
         4T8Ewg9WIdMYoInsletenhlos99/JpMVbLJl0cNDHOv6Fg+L0JnWQj/WTb2zICv4iTtl
         u42/wlcn7OrWq8ZGRxG2T23uK2wGG7lx+LFcaoKFYQs/9dfAcxwDfewrfhjBMAIctpTw
         DtbJozyTpmZDrFentPisHMFGhGnds52KW8+9MqDbSiEdctKhPggnWiE/hlT0WMgnaxnU
         B2GA==
X-Gm-Message-State: ACgBeo0fdiRT9j91y8IWyV7a9R65kJmiX7GgzdvNTv4v/ZAYcy1TfJw2
        W6nb7dEkJx0tYa1hRfhhmK5Di5W7ofIT0LKG
X-Google-Smtp-Source: AA6agR6s8cwIw86sUzfNeW1dAbiwVvALjW5Jj3PJi8QbYI7h65XJwdYYtjA2IhmoCKLUNMKH83DOkyjt1ks1NcY1
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:902:e883:b0:175:22e8:f30a with SMTP
 id w3-20020a170902e88300b0017522e8f30amr4205183plg.127.1661899397359; Tue, 30
 Aug 2022 15:43:17 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:42:53 +0000
In-Reply-To: <20220830224259.412342-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20220830224259.412342-1-vannapurve@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830224259.412342-3-vannapurve@google.com>
Subject: [RFC V2 PATCH 2/8] kvm: Add HVA range operator
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, yang.zhong@intel.com,
        drjones@redhat.com, ricarkol@google.com, aaronlewis@google.com,
        wei.w.wang@intel.com, kirill.shutemov@linux.intel.com,
        corbet@lwn.net, hughd@google.com, jlayton@kernel.org,
        bfields@fieldses.org, akpm@linux-foundation.org,
        chao.p.peng@linux.intel.com, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, nikunj@amd.com, seanjc@google.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com,
        Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce HVA range operator so that other KVM subsystems
can operate on HVA range.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 include/linux/kvm_host.h |  6 +++++
 virt/kvm/kvm_main.c      | 48 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4508fa0e8fb6..c860e6d6408d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1398,6 +1398,12 @@ void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
 void kvm_mmu_updating_begin(struct kvm *kvm, gfn_t start, gfn_t end);
 void kvm_mmu_updating_end(struct kvm *kvm, gfn_t start, gfn_t end);
 
+typedef int (*kvm_hva_range_op_t)(struct kvm *kvm,
+				struct kvm_gfn_range *range, void *data);
+
+int kvm_vm_do_hva_range_op(struct kvm *kvm, unsigned long hva_start,
+		unsigned long hva_end, kvm_hva_range_op_t handler, void *data);
+
 long kvm_arch_dev_ioctl(struct file *filp,
 			unsigned int ioctl, unsigned long arg);
 long kvm_arch_vcpu_ioctl(struct file *filp,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 7597949fe031..16cb9ab59143 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -647,6 +647,54 @@ static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
 	return (int)ret;
 }
 
+int kvm_vm_do_hva_range_op(struct kvm *kvm, unsigned long hva_start,
+		unsigned long hva_end, kvm_hva_range_op_t handler, void *data)
+{
+	int ret = 0;
+	struct kvm_gfn_range gfn_range;
+	struct kvm_memory_slot *slot;
+	struct kvm_memslots *slots;
+	int i, idx;
+
+	if (WARN_ON_ONCE(hva_end <= hva_start))
+		return -EINVAL;
+
+	idx = srcu_read_lock(&kvm->srcu);
+
+	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
+		struct interval_tree_node *node;
+
+		slots = __kvm_memslots(kvm, i);
+		kvm_for_each_memslot_in_hva_range(node, slots,
+					  hva_start, hva_end - 1) {
+			unsigned long start, end;
+
+			slot = container_of(node, struct kvm_memory_slot,
+				hva_node[slots->node_idx]);
+			start = max(hva_start, slot->userspace_addr);
+			end = min(hva_end, slot->userspace_addr +
+						  (slot->npages << PAGE_SHIFT));
+
+			/*
+			 * {gfn(page) | page intersects with [hva_start, hva_end)} =
+			 * {gfn_start, gfn_start+1, ..., gfn_end-1}.
+			 */
+			gfn_range.start = hva_to_gfn_memslot(start, slot);
+			gfn_range.end = hva_to_gfn_memslot(end + PAGE_SIZE - 1, slot);
+			gfn_range.slot = slot;
+
+			ret = handler(kvm, &gfn_range, data);
+			if (ret)
+				goto e_ret;
+		}
+	}
+
+e_ret:
+	srcu_read_unlock(&kvm->srcu, idx);
+
+	return ret;
+}
+
 static __always_inline int kvm_handle_hva_range(struct mmu_notifier *mn,
 						unsigned long start,
 						unsigned long end,
-- 
2.37.2.672.g94769d06f0-goog

