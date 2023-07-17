Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE78755B7F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 08:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjGQGYX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 02:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjGQGYN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 02:24:13 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2BDE6B;
        Sun, 16 Jul 2023 23:24:07 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-66f5faba829so2889549b3a.3;
        Sun, 16 Jul 2023 23:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689575046; x=1692167046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsZNEzswzG8LGSiGtSvGiHDvtnXPesXlahtUeg2sYj0=;
        b=RLHJbAEMHsXFfwx8RKOvdw4kmXMlCXv1ik9B7gcMFReM28bdeOfiRT/VsWMbmGogrw
         4uAZn72MV/VeLpR4XkbSM4F0SW3DYEZWzol23sy9QjAa2S1gDFDsjsthbbu6Yi/ZD/pm
         3PiRkqUykhnO39LR1QDtqt42EHThWRt995mrxtZ2LUleWtWNnkmIj+42/GovNvoYAiVW
         haZrPLVO+JT1tFb5lKHlpMaSuCNlvp1h9P/ZFhSO6zZM+FpgnuR7J62tGNYc+cbZeW41
         d+evkDmvbCa2+g8Zd21IBCP7LDO3+6jUnNk6/qOIfEIvHQsy+Cpef5e4jkRLj52aYfvI
         TltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689575046; x=1692167046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsZNEzswzG8LGSiGtSvGiHDvtnXPesXlahtUeg2sYj0=;
        b=ffJUlVL9aw/k7eBwDiT+WjYQaAUrOJzmlQDAr2gdNuUGXr44ArWLf1h3WIVv0LakCg
         SbuFv3irPuxhO2t3/lbbktU+ouq4H8FowxmMaD3vbFge3hEs+Q+VsLlAyv2zkQX20yop
         Wv+3uNXxuVytWZqBkJzOZAUWA4r/VVmFjW/YMoGss53EhhhX7FkDoSr/XW6DNIdPQry2
         zSH85sys2ktddHBl97w7ZkLpOXqsQbf2ATO7KoSSWwEwlCLc1v3qqByMMVC9j02WorCZ
         zQ97iTPOkb/TZIKZJKTc1mei7J4lMZ5srFlVBlWreRxU5kyzar2WNzcZ5JksGKlmQhoF
         vEKA==
X-Gm-Message-State: ABy/qLaXTI55f3WhmAAK9ZEQhyhd3I792sPvvL5hPKcBZc4GRahxrN4r
        +ldhP/0uckeShWyuHzmYs2g=
X-Google-Smtp-Source: APBJJlHiBgaoZ6rgQRi4sRa9kVcZoeU0ORIv5M5V8fJ+R3FTqPa+PedF50srSZ45i7XseBVTwgzXkg==
X-Received: by 2002:a05:6a20:748c:b0:130:d5a:e413 with SMTP id p12-20020a056a20748c00b001300d5ae413mr11700881pzd.6.1689575046495;
        Sun, 16 Jul 2023 23:24:06 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902744400b001b9ff5aa2e7sm9555716plt.239.2023.07.16.23.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 23:24:06 -0700 (PDT)
From:   Jinrong Liang <ljr.kernel@gmail.com>
X-Google-Original-From: Jinrong Liang <cloudliang@tencent.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
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
Subject: [PATCH v4 2/6] KVM: selftests: Drop the return of remove_event()
Date:   Mon, 17 Jul 2023 14:23:39 +0800
Message-Id: <20230717062343.3743-3-cloudliang@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717062343.3743-1-cloudliang@tencent.com>
References: <20230717062343.3743-1-cloudliang@tencent.com>
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

