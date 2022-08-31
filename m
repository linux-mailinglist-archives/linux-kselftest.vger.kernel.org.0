Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830DC5A803D
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 16:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiHaOcB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 10:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiHaOb7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 10:31:59 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EF39F76D;
        Wed, 31 Aug 2022 07:31:56 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso21245209pjk.0;
        Wed, 31 Aug 2022 07:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=p8kd5sCAmunxOHCaIzw+oVEEpbHVTP/hANU4lAH8jho=;
        b=Wus1ickR71qdQxC8Jg25Ioj5BRWvFhBUYwaO9AO489DC9ccnHGvmVmGh3NQKFoRGtq
         kwJ08r2DV7tei3U3HODe3Bq3GxkcilBLwlkWHASMT/tvOnS+akksFZd5Jb1Rye6qRyN0
         xFsHxWqckXv4GhrHX+UM3AQWl/CnGUw6houicpB59ei3RWqh4wXR1zxZnb0OD81sKzdE
         KGcXH70RmC1wEMoeHuX96kHTr0Rp7Fo2AP15jKo6CYvcdk33DqrpRZSj1PWMgYYCddI0
         iQYPrwdwvlxYCLhJZvO9wzIyxF9ZRU95qbDl4L0YT1VHyH+Oo6zq6aC5Bo/WTf/8kW8L
         FxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=p8kd5sCAmunxOHCaIzw+oVEEpbHVTP/hANU4lAH8jho=;
        b=Tp/+q8w7ySKqgC+dLnuPTOkJJC7xPSouFG0ztYugrs1GbwkEyQnSjPTpFZ1ozZMNMa
         neZWgE8K89i9VX6F1itZTlC41XEk9SoVfgm9IDAGUBv6Jd6U9uv4d40YvZ1zBmHyQ2bg
         RYJVLy4YPePQZr2AUWm+8ipaTagJeNYab5X0F5reNt3lR6rnYOIEFMfFprDAWZmiVOo/
         6E7rEDfT3LoCeIAQx5ArFVvF1Pk1i1q99F/+fUn+LKTDI1yPMoON4FhwR+s9BN0Q4N1m
         uqoLoDn0fle+9IixBdXO7lEN36aeU21PPLlsToaT71AUpTmtkk9gb/Gcu02/tPetQrnG
         Yceg==
X-Gm-Message-State: ACgBeo1OMRSlrsjcSlZ2KRmsNbwmYgKaVGbsrfqoiNGPK86oV/lGqWyJ
        32wPuP7AILrjed/fCRaqxpU=
X-Google-Smtp-Source: AA6agR7hg7Mx3xmKXrZqaJbyQBAsZrJhysOANkcnkQhkHU33ETi6Vo8K6P/qNVHflmLIT9P23OfmHA==
X-Received: by 2002:a17:90b:4c8d:b0:1f5:29ef:4a36 with SMTP id my13-20020a17090b4c8d00b001f529ef4a36mr3672301pjb.127.1661956316214;
        Wed, 31 Aug 2022 07:31:56 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b0016c50179b1esm5088778plh.152.2022.08.31.07.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 07:31:55 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: cui.jinpeng2@zte.com.cn
To:     pbonzini@redhat.com, shuah@kernel.org, seanjc@google.com
Cc:     dmatlack@google.com, jmattson@google.com, peterx@redhat.com,
        oupton@google.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] KVM: selftests: remove redundant variable tsc_val
Date:   Wed, 31 Aug 2022 14:31:50 +0000
Message-Id: <20220831143150.304406-1-cui.jinpeng2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

Return value directly from expression instead of
getting value from redundant variable tsc_val.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
---
 tools/testing/selftests/kvm/include/x86_64/processor.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 0cbc71b7af50..75920678f34d 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -237,7 +237,6 @@ static inline uint64_t get_desc64_base(const struct desc64 *desc)
 static inline uint64_t rdtsc(void)
 {
 	uint32_t eax, edx;
-	uint64_t tsc_val;
 	/*
 	 * The lfence is to wait (on Intel CPUs) until all previous
 	 * instructions have been executed. If software requires RDTSC to be
@@ -245,8 +244,8 @@ static inline uint64_t rdtsc(void)
 	 * execute LFENCE immediately after RDTSC
 	 */
 	__asm__ __volatile__("lfence; rdtsc; lfence" : "=a"(eax), "=d"(edx));
-	tsc_val = ((uint64_t)edx) << 32 | eax;
-	return tsc_val;
+
+	return ((uint64_t)edx) << 32 | eax;
 }
 
 static inline uint64_t rdtscp(uint32_t *aux)
-- 
2.25.1

