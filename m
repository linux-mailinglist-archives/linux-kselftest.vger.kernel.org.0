Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0EC5F1B3B
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Oct 2022 11:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiJAJZF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Oct 2022 05:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJAJYy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Oct 2022 05:24:54 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322F6C5B;
        Sat,  1 Oct 2022 02:24:52 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x6so591703pll.11;
        Sat, 01 Oct 2022 02:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=4pMkj1nmm6sCFc4pb6nbeZlQt9Owx3Z0HxGibxF/VdA=;
        b=OzPRAqIycVW7pcKi0Yai1n8cU4pUpvD8gm/ANzgwXs6f5dJi9gZcXSKgw1uV0eH7ep
         948XJWXGztrKwhwGEg+6BFoWdqXRf19PVRH63r5IdT8hzy30ynP1drcjEdhv79jJLA2O
         kyFUN5Es4k6d1EPJmBKkFz9zql085KvskprbMxIzVK53jj2/4jeIX55NzdzhbGLh0VqC
         vM+9Y4SWLsb3Cop8jMqhx5LxhWIlmg+X18EzBA5OBPPMnvhpXKwS+SVkF6ltWlofv1Ra
         eeTP2AYjwVb7zxOr3Lp7efC7Pr/WxS2skN0SREGphEJBDgd7FREPNUmaNyOxvsw1TGEX
         YY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=4pMkj1nmm6sCFc4pb6nbeZlQt9Owx3Z0HxGibxF/VdA=;
        b=g5x8oiel4/pcaYNW3xNJowpa89DGDhfMS8MGw78wGBpBRUEeA+cLjyO9boDMQWoSr4
         tBeZ/4cnp3I8KbR8GeSKVJH2lgE3z8rMEIIjE2Vj5kzfV1FAzjyjW8V2Vhr0nRkoAmu+
         2I63+/qIVtM6i+NZO2xgndFQwYhlAqq9vPK1l6f5kwvHEY0tItWGurOvlLyFEaK4VTOs
         HsF6LA+yOKHA3uQ+zf3qeUeVxH9gkQeXqBxEKcmKnqxmbrT3vL7OgypIdE4qNfgpkEUN
         eLnE3ftBPrHFZXNqwfrE4Dpq3jaMN5naWjN65rtpe4MlruWKikRUoxHawKlavYvG0du5
         7AYA==
X-Gm-Message-State: ACrzQf08vvjyRFiyEWzl3cNdj6uq9VKIOFBmjSXY/LbhJmOSAyX2kDpR
        QllReE4+WwlSLFoFBTzGFnU=
X-Google-Smtp-Source: AMsMyM6AkuqOERqrBFtgSJ9Dc4mETx/h/FHoxCuy95eIwXR7D6DXaP/0/W/ug8XGzPBgtjwmaawLxw==
X-Received: by 2002:a17:902:ac88:b0:17b:f859:46f9 with SMTP id h8-20020a170902ac8800b0017bf85946f9mr9297455plr.84.1664616291418;
        Sat, 01 Oct 2022 02:24:51 -0700 (PDT)
Received: from biggie.. ([103.230.148.185])
        by smtp.gmail.com with ESMTPSA id c145-20020a621c97000000b0055ff55f3b18sm612280pfc.188.2022.10.01.02.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 02:24:51 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     pbonzini@redhat.com, shuah@kernel.org
Cc:     Gautam Menghani <gautammenghani201@gmail.com>, seanjc@google.com,
        guang.zeng@intel.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/kvm: Avoid for loop initialization using vcpu->id in xapic_state_test
Date:   Sat,  1 Oct 2022 14:54:43 +0530
Message-Id: <20221001092443.18927-1-gautammenghani201@gmail.com>
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

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
[1] https://lore.kernel.org/kvm/YyoZr9rXSSMEtdh5@google.com/

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

