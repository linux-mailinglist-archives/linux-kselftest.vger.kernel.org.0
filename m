Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340F97837A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Aug 2023 03:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjHVBz0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 21:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjHVBzZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 21:55:25 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D219A180
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 18:55:23 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34ca07ea55dso8942815ab.2
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 18:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692669323; x=1693274123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MVDg4AiFSlG/+H1Z+4rrwZ5TuiaCol/qVRe1MkiyJ4=;
        b=dfaWwvA9oBL1IZ1Ld8nmBYZfchopf8juXDP2xXzgSG1+4P+Y22COL076a6tOgVMiwz
         QILZngUNHyArlcv/oP21Fea28QqZgLAOBnLUlGNmpK8m4daK64fIorApmoM/BsiyrFBx
         m5xcXJdKn0E99mRIBpuKTVuUQA71ez3oXSMYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692669323; x=1693274123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MVDg4AiFSlG/+H1Z+4rrwZ5TuiaCol/qVRe1MkiyJ4=;
        b=HzDBWyAE+gJZaHDErVjYWgZz9MLc7uCraSpXRd/nxedFXA//p8WTv5Q/xYQlNbs7IN
         v8EgCh+a5FRm43LkDfjfys3wJMc2JBtBaZ8viem3GqRyoZp6plcIywDjpLXTRoJewNEP
         7a2G11DSNAMCRnT21Vf9EAmoMB9M3Y6KRYtgHMUN+swzfSJjoWMat3ZFJ/9HguoXrbfr
         U2HdGGHASCKreZtYkFMssUpnX84nuqzOAIbuAoSeTH89mJyD4yGkq2jE9vTS/+bZueQw
         tf7+G1kP+blLEOHgXMb5WPpr+1QFKsWiCoGUXnz5j5aKD0PhRdYuolaRfcSrGEbLdQy0
         tNWw==
X-Gm-Message-State: AOJu0YyLK1ANPiwKc9fo6vGhuGnPxquJH3DAEnonacgu4o9n8/DsRB2C
        YAkryrW9IB+1zlE1UrM6q5kanQ==
X-Google-Smtp-Source: AGHT+IHvqVdYTC6n4DObVG1/cE1N4x7Ela2mYdMwjClLo2WnnHgsjk7IpjhEewtQDpWgbd40PsHlhw==
X-Received: by 2002:a05:6e02:1906:b0:345:b923:971b with SMTP id w6-20020a056e02190600b00345b923971bmr12162039ilu.3.1692669323174;
        Mon, 21 Aug 2023 18:55:23 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id q11-20020a92d40b000000b0034886587bdcsm2907390ilm.18.2023.08.21.18.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 18:55:22 -0700 (PDT)
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
Subject: [PATCH v5 3/7] selftests: mm: Fix failure case when new remap region was not found
Date:   Tue, 22 Aug 2023 01:54:56 +0000
Message-ID: <20230822015501.791637-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822015501.791637-1-joel@joelfernandes.org>
References: <20230822015501.791637-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
2.42.0.rc1.204.g551eb34607-goog

