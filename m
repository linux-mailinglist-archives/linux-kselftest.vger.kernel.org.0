Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1268C790CAA
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Sep 2023 17:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243460AbjICPNp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 3 Sep 2023 11:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243412AbjICPNn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 3 Sep 2023 11:13:43 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17BDAF
        for <linux-kselftest@vger.kernel.org>; Sun,  3 Sep 2023 08:13:39 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79266c8617eso32428839f.3
        for <linux-kselftest@vger.kernel.org>; Sun, 03 Sep 2023 08:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693754019; x=1694358819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgAxpZm73/WsgHgaKL7ACBPFmNc1ioV85z5utVL8UIg=;
        b=F5dCK+GqTQVl1k+uFsaHVeTN5U2FjlKUR1h/NjZBntD0W//PyCHe1JwuE2/i+2mLiU
         +e+So368aqLL+pYA5SrKgZo1d1cYlKgDs4qZYTJJVCI142wEua+giqC6Yw7nxRY3LlI9
         gB+xUnm8jAQySFj8+HFURo6kWaSCPp/T4fe1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693754019; x=1694358819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgAxpZm73/WsgHgaKL7ACBPFmNc1ioV85z5utVL8UIg=;
        b=Hzgq5qiIidCTu7yWUP/ZA+B08Ao1ueFKWyFN/uBNCiE1HluJ9qREcySkMyBf4qEUfh
         A+VA3BO0jM3G1q0+vKAANiZAZh7h7JW/FlQiiBOmW+dTegeX9yPKcbkmOI+g6A3VT9Af
         VMD37u8unB1QkrBjsR6C+1ur2ReyUTr0yJhbIUFU9HeP1ZgxKt3vfjC/LGF7UdIv950C
         X0GTKuMGKv+sT9+ruY9lL+Vvlvix0NpiSyl3Yt6uuSBHUsjmlcNV6bJD3SV8s1wgMx50
         yOaTF+81K0NIW86rC88mA1WckMNzTzmT3VA8a5yZeb2zbJrBB37+6d0eePQnpSb6F+WR
         LdOg==
X-Gm-Message-State: AOJu0Ywq9DhsKE4UxLGBHIT6+eN+doWnVs+DwVjc/1pK57OkSFaeTLCC
        CqJzaJPWtLE0iWfORwBnCAv23g==
X-Google-Smtp-Source: AGHT+IGK6R6X5iL9c9EiJjuyIOAcTh4DFWseDeYLr9pYLtkVVy11PWLKEcH+AWQJ5HZZkLqaClZ+hQ==
X-Received: by 2002:a5d:89d7:0:b0:790:a073:f122 with SMTP id a23-20020a5d89d7000000b00790a073f122mr8739172iot.2.1693754019346;
        Sun, 03 Sep 2023 08:13:39 -0700 (PDT)
Received: from joelboxx5.corp.google.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id f5-20020a6b5105000000b007835a305f61sm2605897iob.36.2023.09.03.08.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 08:13:38 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Subject: [PATCH v6 3/7] selftests: mm: Fix failure case when new remap region was not found
Date:   Sun,  3 Sep 2023 15:13:24 +0000
Message-ID: <20230903151328.2981432-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230903151328.2981432-1-joel@joelfernandes.org>
References: <20230903151328.2981432-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When a valid remap region could not be found, the source mapping is not
cleaned up. Fix the goto statement such that the clean up happens.

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
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
2.42.0.283.g2d96d420d3-goog

