Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811AD70FA24
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 17:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbjEXPc6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 11:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbjEXPc5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 11:32:57 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BFF139
        for <linux-kselftest@vger.kernel.org>; Wed, 24 May 2023 08:32:55 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-757942bd912so87571185a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 24 May 2023 08:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1684942374; x=1687534374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t64UzVHVroabp76Xd4g1LLeTmZtqX+n8nvVYbfjxh90=;
        b=fkkfqnJ52t84oMcKxKF0Qg5EIe+H/e5iNykQYFnHWz3Bf1EAvgahlIVxTsm8Z0hi4V
         OFp1GA5hnGMxdsdMdpwgJqewYy3Q6MuKpYhOgU1MBi6rBu/XAAnTNc41obMlD1z1fxX9
         KRxzh5JbqUbMmqvEK2VKJEfhsUNZsUg4KU2WI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684942374; x=1687534374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t64UzVHVroabp76Xd4g1LLeTmZtqX+n8nvVYbfjxh90=;
        b=Q59sQSNBn0KetHL8ivOyKb5677rgBQ2IQic85vlvlTLqFRO3d699akWHIPLuy7h0Nt
         ufZhDCRZwClq4/qzvYtkZp+QO84XA68+sLTLtlc0k3V5PeNRVPi9mIl810lEX2TQLs/X
         V+Cbmc2QgT5aNQ13AcaL/kqZLoR7OLOuQlhIOI+mLgl1l0E+rB595HU+3rXepxxo23XU
         YM0uJa8omB7SLs3rldqVZn8LaWzAEuroElKGd3GTV0ISSkga2s7gSeHH9u9WSuN2agyf
         p7c8uFLQqQa3w4iKbvZsGbG3WchUGY9iSO/VPgIfj1X0tG1JqO65dbSeuWUM1932ud/s
         QGpw==
X-Gm-Message-State: AC+VfDwdF8GN8lSSjkM4g9qF1KytWEUh2YSLz+qMZv0KtSZo64FRpZIJ
        Edth6FAgi4cyCwbN4qSbo7p1Cg==
X-Google-Smtp-Source: ACHHUZ6ZgaDuURo3rp7ZvQW0Zz7zS3AwUT/I5tC0ZTN1H3Ry0XxZjW7459XHwomEnb2GkqkgzGnC9A==
X-Received: by 2002:a05:620a:3d14:b0:75b:23a1:8306 with SMTP id tq20-20020a05620a3d1400b0075b23a18306mr7101918qkn.1.1684942374473;
        Wed, 24 May 2023 08:32:54 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id v18-20020a05620a123200b007590aa4b115sm3296906qkj.87.2023.05.24.08.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 08:32:53 -0700 (PDT)
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
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Subject: [PATCH v3 3/6] selftests: mm: Fix failure case when new remap region was not found
Date:   Wed, 24 May 2023 15:32:36 +0000
Message-ID: <20230524153239.3036507-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230524153239.3036507-1-joel@joelfernandes.org>
References: <20230524153239.3036507-1-joel@joelfernandes.org>
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
2.40.1.698.g37aff9b760-goog

