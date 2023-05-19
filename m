Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9A9709FB9
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 21:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjESTKZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 15:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjESTKI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 15:10:08 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D1610D1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 12:09:47 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-783f88ce557so2057872241.3
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 12:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1684523386; x=1687115386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zW+8AiWcujfmL+jEJZ+aHhi3EhheqVULu3C4IZ9BiOM=;
        b=C1fuRRmrWbyGZwMqQvna7XbmrtvL2KYjvRhmvGsD4O4JPuaECH2RhccW5P4CDrMaYr
         v18fbTaNPmBDQR8daJY6vhvbxXPSVdfF96ex6TMhXOa7HWd0JSA6KnnZzVQpdIS23psB
         xC95at14mHATimnKov/41qZD3FJdIAOCHQAOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684523386; x=1687115386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zW+8AiWcujfmL+jEJZ+aHhi3EhheqVULu3C4IZ9BiOM=;
        b=SQti9rU6+zmU0Ll0WzUrsUOraE11b2QDCU2b4rNOFqbbrd7blWnKhEy+PLZYmcU57+
         lIUO3gNxh+P/HvBMJAPWqPrUDb+Dbktuyar/6IfBouiNMyzgmZ1xgXhKz9P4TUWRKrqN
         jCyqYY0oz/nYpZn2JszUh1ri6qUoLOUNW1r1rWCSg9gRr/ddLTzNCJOyT8A69k/15xfq
         v67e39lWZRJP/9LVK7taxBy1Of/Zk9B2Bxg3coh6YpSE5qJtnbGyz046gl7QJvsj1QL+
         Ut7VJ2vs/Pr1v4rnrhFAR1V34XRoZ7uoZ60Ymh6nJ0qa0wr5dvc0+3tfHtkYppSFGziQ
         JXEA==
X-Gm-Message-State: AC+VfDwlAbw6iKNb8Xokr6RcMB4DvfEmySADyGcy7/S+ftGS/5el6mVg
        R2b6S2CXCcoCadLwQe8wHvbwEg==
X-Google-Smtp-Source: ACHHUZ7pAT9I65XMxsEeLpcE0v+SquvwqAtExCL+uZMbkArAXICN2sJRDdFx5Z1+XQLZnjw0rxB7rw==
X-Received: by 2002:a05:6102:419:b0:42f:78d5:d987 with SMTP id d25-20020a056102041900b0042f78d5d987mr246785vsq.1.1684523386054;
        Fri, 19 May 2023 12:09:46 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id q20-20020ae9e414000000b0074e1ee30478sm1317611qkc.37.2023.05.19.12.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 12:09:45 -0700 (PDT)
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
Subject: [PATCH v2 0/4] Optimize mremap during mutual alignment within PMD
Date:   Fri, 19 May 2023 19:09:30 +0000
Message-ID: <20230519190934.339332-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
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

Hello,

Here is v2 of the mremap start address optimization / fix for exec warning.

v1->v2:
1. Trigger the optimization for mremaps smaller than a PMD. I tested by tracing
that it works correctly.

2. Fix issue with bogus return value found by Linus if we broke out of the
above loop for the first PMD itself.

Description of patches:
These patches optimizes the start addresses in move_page_tables() and tests the
changes. It addresses a warning [1] that occurs due to a downward, overlapping
move on a mutually-aligned offset within a PMD during exec. By initiating the
copy process at the PMD level when such alignment is present, we can prevent
this warning and speed up the copying process at the same time. Linus Torvalds
suggested this idea.

Please check the individual patches for more details.

thanks,

 - Joel

[1] https://lore.kernel.org/all/ZB2GTBD%2FLWTrkOiO@dhcp22.suse.cz/

Joel Fernandes (Google) (4):
mm/mremap: Optimize the start addresses in move_page_tables()
selftests: mm: Fix failure case when new remap region was not found
selftests: mm: Add a test for mutually aligned moves > PMD size
selftests: mm: Add a test for remapping to area immediately after
existing mapping

mm/mremap.c                              | 56 +++++++++++++++++++
tools/testing/selftests/mm/mremap_test.c | 69 +++++++++++++++++++++---
2 files changed, 119 insertions(+), 6 deletions(-)

--
2.40.1.698.g37aff9b760-goog

