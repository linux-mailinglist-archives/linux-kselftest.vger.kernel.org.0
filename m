Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5416015D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Oct 2022 19:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJQR6d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Oct 2022 13:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJQR6c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Oct 2022 13:58:32 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E5161D96;
        Mon, 17 Oct 2022 10:58:31 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id bh13so11124682pgb.4;
        Mon, 17 Oct 2022 10:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XeKUR+Ic7TUkYH6vGnV3fuwa2YAfRUGUap65mjX2bIY=;
        b=dHb/yAW8qCnmR3JHQz9IMnHr3ZXBJzqzORUlGlIhSix9QXQV7XUf+Jhjgi0HecrIkp
         wcJ6RXOEGEoWSe+puoBC77GS8PekmjpB64vannhPqzpG9WEXd0D+q0NVxBHHUFdZsyvP
         eSuEh9CEXPxNl8721pWgrNJs84B1OLAfN1U7MVguuieZO6W/nB/FHw/B0mJeXA8euOfC
         KeXah39qz+ZaPV3gqIq6PL9NYUP3Hvn0JfllXC77RFMDMoJNi0aNUr4rQevAykWqDV4a
         k2+yZ5vlwk6zEWIr2rxHrG8Tf667SW/4h6zjfGUjSJea8iJbihAJwZE1MODCEBe5yk4P
         lr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XeKUR+Ic7TUkYH6vGnV3fuwa2YAfRUGUap65mjX2bIY=;
        b=mp7Sjf8Ih23IDx/Fjd0WzTz4+esZQ2/nCh1ZnYNxrbo8AjaVAT1aHs68c1pj6AxaL9
         1miusGW8OccXzvJDGH0Ya3Wbv0DYli0aaDg4BK3Eccq/dUguen5CUWUr+m8nl2YMgVZN
         4g/qnUpGspjcvgDw9rP3XcYRpleSWFAokaHqEwWlNGwdhOG79aSEwuFxvVNG3FpOY9Av
         pRIcXgeQ/lP5BsrDC4M3Ve0cQLilxU5wWWRdDW2vwVtx8HWqgfBLpMA/Fm1pKifQ4s90
         K/j14qlW6YXIPXOOqFoerHNJ9CgU15ePthawdqFTJDcqEesYmz4XX/yyuUyhdnrFYUOA
         LqCQ==
X-Gm-Message-State: ACrzQf1C+7pcUfJI/tEnm2ZEpW6AijGiUilFtcOf2E9V6swsfbtJey5r
        UBanAh8G15fG3ugsFVqoZpo=
X-Google-Smtp-Source: AMsMyM6O/eHDc2cFH8FuN5f5YwYBetwCaCLwv0bTljbF9TCOzsgl9UCIjpasZmTuPdc6ayIdV/45/w==
X-Received: by 2002:a63:8bc9:0:b0:45f:afa8:e686 with SMTP id j192-20020a638bc9000000b0045fafa8e686mr11677365pge.219.1666029510647;
        Mon, 17 Oct 2022 10:58:30 -0700 (PDT)
Received: from biggie.. ([103.230.148.187])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902cec500b00178a8f4d4f2sm6886480plg.74.2022.10.17.10.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 10:58:29 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     pbonzini@redhat.com, shuah@kernel.org, seanjc@google.com,
        gautammenghani201@gmail.com, guang.zeng@intel.com
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/kvm: Avoid for loop initialization using vcpu->id in xapic_state_test
Date:   Mon, 17 Oct 2022 23:28:19 +0530
Message-Id: <20221017175819.12672-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In the test_icr() function in xapic_state_test, one of the for loops is
initialized with vcpu->id. Fix this assumption that vcpu->id is 0 so
that IPIs are correctly sent to non-existent vCPUs [1].

[1] https://lore.kernel.org/kvm/YyoZr9rXSSMEtdh5@google.com/

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
changes in v2:
1. move the lore link above signed off tag

 tools/testing/selftests/kvm/x86_64/xapic_state_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
index 6f7a5ef66718..d7d37dae3eeb 100644
--- a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
@@ -114,7 +114,9 @@ static void test_icr(struct xapic_vcpu *x)
 	 * vCPUs, not vcpu.id + 1.  Arbitrarily use vector 0xff.
 	 */
 	icr = APIC_INT_ASSERT | 0xff;
-	for (i = vcpu->id + 1; i < 0xff; i++) {
+	for (i = 0; i < 0xff; i++) {
+		if (i == vcpu->id)
+			continue;
 		for (j = 0; j < 8; j++)
 			__test_icr(x, i << (32 + 24) | icr | (j << 8));
 	}
-- 
2.34.1

