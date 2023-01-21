Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F50676249
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 01:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjAUAUS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 19:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjAUAUN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 19:20:13 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3AFBF89B
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:19:48 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id h136-20020a25d08e000000b007e1b1a30d5dso7414473ybg.15
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OSbqzQIHhtOUZi+XNLRvr0hBcTc63rTSHvkLvHdhRjs=;
        b=j+nuqFxlj28fkfuax2AYTnMDYPRfm95o2qjUDWXSKBksDH8jYemCh9w0e7ftn6QOsw
         vpC45E1/+deGYoDby3+FGoPiHS/LxF8nPJlBFrNMv7dO3xcEw9B5XVWgl0O5VgU3jgOn
         erfriF1fdySfCtOnV7cj/oaFKAgRrxKVOEzhHDO25dAOE3ttKTo9UtZOYVLCEg0QEyXW
         wA+NvIShIINGq/JGFEvnFz+GRzfD3HO9/HUL0rGzM1JR3hW/+R0Skr5OAs3FZLV6eI/I
         +q4fhfZYPwBOyIYJbBA4rPW7OYqyLr9hI0S+wNSVgcM3BAOP0WApHvrLpY4CzghElk6I
         t/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSbqzQIHhtOUZi+XNLRvr0hBcTc63rTSHvkLvHdhRjs=;
        b=7LMhK27TcG2BesCcHueqIsTgiB/otIrzT4MCkVKpEQFzc63/yzxA9URnSf4ihKhGWs
         G7bgE9K0UCMPo1GNOF6+KQYVb8IPpoPj0picY0wIB9kUeJ+26HVhaN+eDCmOGRuYPyVq
         XcFg+oYBRx8SXUN5XqreRnyATKCnHvhWN81+7rnQxHn9ZHhpoTqNIvUaTRcd/oyS120o
         iixe8IMR3TLlYS2zt0n3pshc289b4JU/q2nS4xX7gGhHW543h/e/D5/5dlRl+9tRXwVv
         3YDLeo397MDHMI4RsOHPfuZVhA8qjvnd9mYksCpsUdnNhLApM65c9eZuhAucjvVg06tq
         RsuA==
X-Gm-Message-State: AFqh2kpjFiks6vwP+5HFEXYfAHUcEt1RCxnVTzs8OA8s/vbHaSQEL2wM
        5CeURrHRxW5V7A7TfylrAhVsTugXWaAFGgeQv/6S41pX07RxFA9lwduTmRLDFD96UdIuODb1CJ4
        Fbp6YMGc/Jp7Ilchpnwp7qqOCrG9DM08vW5CyNiAvOjSvwGMuUaN25tk3rlej4lGUw0rNyhikEF
        5xFlQYvYtW/us=
X-Google-Smtp-Source: AMrXdXu1DCnVzLJkLaux9FqMEFGGeDFnVXCqWlSa4HMsaQ9DZUE7PtkSZ+oUJjuui87VSyvC9iSnO+Q32CJrzh9ORQ==
X-Received: from ackerleytng-cloudtop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:b30])
 (user=ackerleytng job=sendgmr) by 2002:a0d:eb93:0:b0:4fb:2084:1f62 with SMTP
 id u141-20020a0deb93000000b004fb20841f62mr956118ywe.513.1674260294752; Fri,
 20 Jan 2023 16:18:14 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:15:39 +0000
In-Reply-To: <20230121001542.2472357-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230121001542.2472357-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230121001542.2472357-29-ackerleytng@google.com>
Subject: [RFC PATCH v3 28/31] KVM: selftests: TDX: Add support for TDG.MEM.PAGE.ACCEPT
From:   Ackerley Tng <ackerleytng@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, marcorr@google.com,
        eesposit@redhat.com, borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h | 2 ++
 tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c     | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index 857a297e51ac6..c8e4b9ce795ea 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -5,6 +5,7 @@
 #include <stdint.h>
 
 #define TDG_VP_INFO 1
+#define TDG_MEM_PAGE_ACCEPT 6
 
 #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
 #define TDG_VP_VMCALL_MAP_GPA 0x10001
@@ -38,5 +39,6 @@ uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
 		uint64_t *r8, uint64_t *r9,
 		uint64_t *r10, uint64_t *r11);
 uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, uint64_t *data_out);
+uint64_t tdg_mem_page_accept(uint64_t gpa, uint8_t level);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
index e0a39f29a0662..2ebc47e268779 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -205,3 +205,8 @@ uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, uint64_t *data_o
 		*data_out = args.r11;
 	return ret;
 }
+
+uint64_t tdg_mem_page_accept(uint64_t gpa, uint8_t level)
+{
+	return __tdx_module_call(TDG_MEM_PAGE_ACCEPT, gpa | level, 0, 0, 0, NULL);
+}
-- 
2.39.0.246.g2a6d74b583-goog

