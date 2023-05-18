Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813DE7077F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 04:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjERCTB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 22:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjERCSr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 22:18:47 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1492137
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 19:18:46 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f3882a5f8aso3757771cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 19:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1684376326; x=1686968326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjDDJEmMByrSrRAzAnrYD81CTFNgsqIfOqapJ9IGu5M=;
        b=mQQrGh4h/KNWIK2PoMB6Pztwf3cVCXmBMz0qqgOhBsvYUoYmvpqwqduJIzlAMMC7YK
         ZrUS/hiBuG72PkbcadbIrnygdqpWVUoSGwOt1fIX6LFaYv2ZtLweuzoryGI5e/lbAEvj
         QAZwZXY/iYOPxIXmup+iJ05KpzCFPd+H+MV7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684376326; x=1686968326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjDDJEmMByrSrRAzAnrYD81CTFNgsqIfOqapJ9IGu5M=;
        b=cy4c4a51tBfGhGLUYm0N8FSIF3To+ro4pxNkrqywy+I4elIY3H9z2fDQSfjsDL5WDV
         9Z+zRWzOfbJWVTUNfZOW2Rz3f/dcj4qBF3l1x0MwwyUMJk938yaFheFEZ/xBd5yxLWoY
         5vjfkTnum/0FwNnuKJoDktq6MZ1LvEYh5FTsACrHhtVxDG8BjKj5ulV9ixUC5uwaadgP
         FJiDPGxrUUhmNo9W5YXjKhmIgjzGez0ws90h7wUvPWmbQIKgcE8TvPv/lWkmLPPLvrN8
         BMT+rnxvPYJ/HH84+cqFEmeUO94GO6UsUxPAQF+b5I9QIrFQwXnuSFSaV2U75OfRvN2W
         Grog==
X-Gm-Message-State: AC+VfDyCb0AdC688ATaB1BaRx90+dP14Oxh8fevHe5ZFLm1uMv2v+Oqf
        KX7SkqsEwAFV3kubvwppO96U5g==
X-Google-Smtp-Source: ACHHUZ7onnyA0YRXFWFSrDrQsTcQvuLRzQPOgD7sBT31Y/nwpybDDjLCC9uzwGCwdRjZeUxjOoHbXw==
X-Received: by 2002:ac8:588f:0:b0:3f5:2fa4:43bd with SMTP id t15-20020ac8588f000000b003f52fa443bdmr3399132qta.3.1684376325860;
        Wed, 17 May 2023 19:18:45 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id j13-20020a05620a000d00b007577ccf566asm85082qki.93.2023.05.17.19.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 19:18:45 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 2/4] selftests: mm: Fix failure case when new remap region was not found
Date:   Thu, 18 May 2023 02:18:23 +0000
Message-ID: <20230518021825.712742-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230518021825.712742-1-joel@joelfernandes.org>
References: <20230518021825.712742-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When a valid remap region could not be found, the source mapping is not
cleaned up. Fix the goto statement such that the clean up happens.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/mm/mremap_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index 5c3773de9f0f..6822d657f589 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -316,7 +316,7 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 		if (addr + c.dest_alignment < addr) {
 			ksft_print_msg("Couldn't find a valid region to remap to\n");
 			ret = -1;
-			goto out;
+			goto clean_up_src;
 		}
 		addr += c.dest_alignment;
 	}
-- 
2.40.1.606.ga4b1b128d6-goog

