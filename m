Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD3A7773C5
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 11:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbjHJJKL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 05:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjHJJKK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 05:10:10 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A092103;
        Thu, 10 Aug 2023 02:10:08 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 98e67ed59e1d1-267fcd6985cso460890a91.2;
        Thu, 10 Aug 2023 02:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691658608; x=1692263408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UWSTTF0t3sjG9vObIBOdAveTAVD8mKJIqcoJ5daziA=;
        b=bBWZ3k3LvxqFNCvuXrXWNymGyhzEQZm+pshphOBL6ASXMc8kO8xop/9Mbp1He5ufBv
         3zFWrqYK/Wyj2qEu/usQUg1tyYaor+0ryXaQneuE4yxxpPCwXIixe43JhD1FT3XEqEQJ
         5Y7YLG0RVwkJ70CnUzL01om+jGyGhGMoFqLHqdgz9s2/DLEX1rgTrZMQpIUN+U9DhLfC
         0xt4AzsYxoX44r+MjKAECYRXopeieQg1ED2BirfcYtrzRavSsm8zUiVCWq0yu33w7MQn
         +EkexVreRotkSliBMub0ScirgGec75EnH1kgDYIRiev17EBbKlUQPUd98NdprJFnzfHm
         sUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691658608; x=1692263408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UWSTTF0t3sjG9vObIBOdAveTAVD8mKJIqcoJ5daziA=;
        b=g6HU9ER68kKrjZowbe8ZZ/yQ0BpJTteU4U3TYzLDi1dPy2YGo2psluH7oBlr9Vo9FK
         qwbLZgnBWE2I7nhN//hTP2uzHuyYyJ+haIErr4nOP1OoaPvwa2Nn4Qq0bBfA37+Y2qv6
         i2rooRom30iUeKh7/zGWMf7n+UMJdHl5CcOunRjAAsuZC7CqImXvpSb/ND7tolldhq2j
         qENPuT993zHNHze9R4A4rwV9iFNVYMX3xol2oK/Hh6ZRUtjLuWtXBkbCAT6hKL5bwoIC
         dLrD80lMAxUz7tL39C0SMpFIjwxcbIHwBkB8CHUS4Pj7hZnBG3pU7t/cv7zVmQbi286F
         TBPA==
X-Gm-Message-State: AOJu0YxRjV8iGZkUqQdyYozTFAOhm9y6Pd1JZK6BI09QEzQ/GqGRXz/3
        NYoRgsPGhbMXKay3dMhNpQs=
X-Google-Smtp-Source: AGHT+IHruBOiRgXAXIhOGv3HEhG0TXfntjZC3EZX7hm8XsOve5jeSF6mQkJABnCE8Po3yB5rkc0b/A==
X-Received: by 2002:a17:90a:d356:b0:268:14a0:f8a with SMTP id i22-20020a17090ad35600b0026814a00f8amr1481466pjx.39.1691658607856;
        Thu, 10 Aug 2023 02:10:07 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id pc16-20020a17090b3b9000b00263154aab24sm970704pjb.57.2023.08.10.02.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:10:07 -0700 (PDT)
From:   Jinrong Liang <ljr.kernel@gmail.com>
X-Google-Original-From: Jinrong Liang <cloudliang@tencent.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/6] KVM: selftests: Drop the return of remove_event()
Date:   Thu, 10 Aug 2023 17:09:41 +0800
Message-Id: <20230810090945.16053-3-cloudliang@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230810090945.16053-1-cloudliang@tencent.com>
References: <20230810090945.16053-1-cloudliang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jinrong Liang <cloudliang@tencent.com>

None of the callers consume remove_event(), and it incorrectly implies
that the incoming filter isn't modified. Drop the return.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index 40507ed9fe8a..5ac05e64bec9 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -265,8 +265,7 @@ static struct kvm_pmu_event_filter *event_filter(uint32_t action)
  * Remove the first occurrence of 'event' (if any) from the filter's
  * event list.
  */
-static struct kvm_pmu_event_filter *remove_event(struct kvm_pmu_event_filter *f,
-						 uint64_t event)
+static void remove_event(struct kvm_pmu_event_filter *f, uint64_t event)
 {
 	bool found = false;
 	int i;
@@ -279,7 +278,6 @@ static struct kvm_pmu_event_filter *remove_event(struct kvm_pmu_event_filter *f,
 	}
 	if (found)
 		f->nevents--;
-	return f;
 }
 
 #define ASSERT_PMC_COUNTING_INSTRUCTIONS()						\
-- 
2.39.3

