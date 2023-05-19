Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E635D709FBB
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 21:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjESTK2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 15:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjESTKW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 15:10:22 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D371718
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 12:09:49 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-437e533af40so628002137.3
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 12:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1684523388; x=1687115388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t64UzVHVroabp76Xd4g1LLeTmZtqX+n8nvVYbfjxh90=;
        b=o7UU9iUhAbrwB44BtKTmc5RQ8dUPaFjHnnyhvbFZd+1u585u1S76A7OrnTd4nASMLC
         ZkUXlYY0ZOkyICYNTcwic2MeSK8V8ncKEVmdi5sB8vbXKubDEMtEYecQ/rgSsn59s9aX
         4//vGzJMsIiFGeko/yn1WZd6ewTT2Ke489JRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684523388; x=1687115388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t64UzVHVroabp76Xd4g1LLeTmZtqX+n8nvVYbfjxh90=;
        b=Y9bqN5SKMnLAQOyO+nlwqKqe1w1Vvuw6auRlAkNnob64pEGNL0zkstxo3tXX8v8gQI
         C9OhA/gPRNtND0dx5o0v52zhD1Muk0dnj4xL9Lha/n66+b+lSdGWFYK6PhFCMvFb90xm
         1QahF9G6bx0f80BVsoa557smpgkxgf2Erv2M4QJrefYvorfiJDzYScUum7wFzjPRkpTC
         QjMPtYEW7Cgfiuwfc0Efcmkq/sMt73SV8491uN73vRU4M1DGplyQSCqZxh0MZtNKLX1W
         X1uUj7XPaYSFVXxxyE4MwLwlcRljv8o1R6ok8ZLCT5sfAPAC9RvlXOYMFtqQfFOazSL+
         IQYQ==
X-Gm-Message-State: AC+VfDxrEgFD2l0E4mWUo5JBJcOuhfq0AGVde0949I2an53aAW38Svsw
        szxKCh/fwFOLScPeoWTpmOjsLA==
X-Google-Smtp-Source: ACHHUZ4jFcbT1ve1tL/ufSb7el3GoyODcR910N727rMH2QSU4iGxgxnP0MXarC1z3MztdTo718x5vw==
X-Received: by 2002:a67:f050:0:b0:435:f378:8ee8 with SMTP id q16-20020a67f050000000b00435f3788ee8mr163030vsm.26.1684523388002;
        Fri, 19 May 2023 12:09:48 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id q20-20020ae9e414000000b0074e1ee30478sm1317611qkc.37.2023.05.19.12.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 12:09:47 -0700 (PDT)
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
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v2 2/4] selftests: mm: Fix failure case when new remap region was not found
Date:   Fri, 19 May 2023 19:09:32 +0000
Message-ID: <20230519190934.339332-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230519190934.339332-1-joel@joelfernandes.org>
References: <20230519190934.339332-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

