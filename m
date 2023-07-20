Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289FE75AD55
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 13:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjGTLsI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 07:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjGTLrp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 07:47:45 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF21426B1;
        Thu, 20 Jul 2023 04:47:40 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-1b8a8154f9cso5194335ad.1;
        Thu, 20 Jul 2023 04:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689853660; x=1690458460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsZNEzswzG8LGSiGtSvGiHDvtnXPesXlahtUeg2sYj0=;
        b=mTmee0o3B7ZyMTS4gt6pCHyLazCNqmiTaCdGL/Iag7wqw7agKdIFYjd0QT1ahfEqMa
         4LyIhZM7o13kGeJ4m5Ayy5cMXqcKra/QWwnY1r7ZMDhr6gYNBCsrmCGihnSs1l/d4/Un
         mn8faT1cozcZuKaLt5dm8BQPfffComvSzFmZ1DxWoxWpBwuQ6YL4JUvV8cOzOJdHzcRq
         3sM/OHWXV+vMYFFGaUiwf77nRoVGsLHampn+qY0kfD8eTHcsUpukNXocTRq0OR7chBB8
         pDhSSS407cLON2dbwS+sbIjVLjnnymuqpSriZLbkc8MVXGy6V8p/nQyRB7ttWkcM4jYw
         l3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689853660; x=1690458460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsZNEzswzG8LGSiGtSvGiHDvtnXPesXlahtUeg2sYj0=;
        b=fdmRJ6NQ3GSFlGK8CnbsVxHxAu8Eu0fQmPnn7K7jE6W7drw5mecxVHueOm3WfxUuGn
         WJJqrSdNr/tXrcC3Z3QnnHMekyMpGMiE160NjCtZd8OMuImgbDo5IknHj4zDWwbAeKH5
         thFsM6dJCSAH/iRx38yt4T6fly1CzdxOJ2b4IYtsG7dKupKElCS/cqKQqOoXRZ/SBIaY
         IDjIyPiNQvDDXAQI5BYEPrQzVyykUAlh4zZ2Xza2ykssYoKDpoy9l8PkBf+bzLIebYbK
         yxr6eWElu4zIOaxzs8ekk7kcVbF0670uht/x0cCcgO276CKvvDzVu7Hjyynso9QBxkMx
         RWMg==
X-Gm-Message-State: ABy/qLbvGx/QztJx/YSECixsD4uQCvL6wCoVSBrZWGWaWxLPiPQBlxA4
        tjcPW8yXoibXlDPH+V1KMCs=
X-Google-Smtp-Source: APBJJlE5jvZauSRdBA5WjRqe88ogqgtwva+kvzTjOuK4V61Rro/7tnyjvvUZ5uyDwgv01kQ+ZmwGVQ==
X-Received: by 2002:a17:903:294b:b0:1b6:b703:36f8 with SMTP id li11-20020a170903294b00b001b6b70336f8mr6147948plb.25.1689853659965;
        Thu, 20 Jul 2023 04:47:39 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id u22-20020a170902a61600b001b2069072ccsm1164007plq.18.2023.07.20.04.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 04:47:39 -0700 (PDT)
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
Subject: [PATCH v5 2/6] KVM: selftests: Drop the return of remove_event()
Date:   Thu, 20 Jul 2023 19:47:10 +0800
Message-Id: <20230720114714.34079-3-cloudliang@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230720114714.34079-1-cloudliang@tencent.com>
References: <20230720114714.34079-1-cloudliang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jinrong Liang <cloudliang@tencent.com>

None of the callers consume remove_event(), and it incorrectly implies
that the incoming filter isn't modified. Drop the return.

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

