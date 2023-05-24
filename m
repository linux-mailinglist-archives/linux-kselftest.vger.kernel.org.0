Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBC370FA23
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 17:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbjEXPc5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 11:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbjEXPc4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 11:32:56 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4A499
        for <linux-kselftest@vger.kernel.org>; Wed, 24 May 2023 08:32:52 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-75affe977abso157098785a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 May 2023 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1684942371; x=1687534371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nQdM6MRoHyYb9DC9yBJL0H8qT9Rd4+LN5oK5C3g/OFE=;
        b=MPLMVQxRe96+SScpLaw8sLhMl9jpbVWZCvBa0rCNYDN96vZxeF0ygWtHPUZfTLVFll
         LZYL98Fz8Ha5Mdlj1XTzG476kwQTbO/JagVHybCAAoCisF44cGs38w6xWO8O/rFwfCUV
         gRs7TDeLJxTyJdgA0zA6rgObFAv+d7YRK6me0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684942371; x=1687534371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQdM6MRoHyYb9DC9yBJL0H8qT9Rd4+LN5oK5C3g/OFE=;
        b=Lgubg+rhSUBxDjAM3YziNprbf28zTMOgxOQDNtj1KMnKKKaihewGyCzd6Zh19YdWKW
         EFQMpKCc3Njw4FYe2FpRGX7rxZ+y9pH0jHAnnmArOlML5FOq6SW0hkXNs9+/1pI017cZ
         y9nRGGd31oyk1gLxhTJdEM0ue43wztLWRNczypdBjnlsGAdjZUm/Hj6XOML630NgwUNe
         uKaO1f39yRV7szbdrlVW0W6JbDUrDGh1Sq8QxfXvFT1rx3U228Kg0rNdki8Ogu15CgvS
         jVAjKDJ8rgiPMZHIpyENv6myjgVEkhZB9D2ePzHMgICsCugtWnKBw4Z8Zmn91KCelSuJ
         c+Ng==
X-Gm-Message-State: AC+VfDzgwLbQWDfyv0G7PCEeMJejaCiy5fhbbFLuSQbwoFJSRMxpzM6M
        rgyhRCCwM/oEsXnc8iK1lXMwog==
X-Google-Smtp-Source: ACHHUZ6SizGJwGcv9Tz+/DPOYdhE0AkVtVTHOSlxAS8WGojoltL4coJB+lXtG6Wg8raxf+U9m8k6dg==
X-Received: by 2002:a05:620a:1d4b:b0:75b:23a1:361d with SMTP id dm11-20020a05620a1d4b00b0075b23a1361dmr8178488qkb.46.1684942371650;
        Wed, 24 May 2023 08:32:51 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id v18-20020a05620a123200b007590aa4b115sm3296906qkj.87.2023.05.24.08.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 08:32:51 -0700 (PDT)
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
Subject: [PATCH v3 0/6] Optimize mremap during mutual alignment within PMD
Date:   Wed, 24 May 2023 15:32:33 +0000
Message-ID: <20230524153239.3036507-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
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

Hello!

Here is v3 of the mremap start address optimization / fix for exec warning.

The main changes are:
1. Care to be taken to move purely within a VMA, in other words this check
   in call_align_down():
    if (vma->vm_start <= addr_masked)
            return false;

    As an example of why this is needed:
    Consider the following range which is 2MB aligned and is
    a part of a larger 10MB range which is not shown. Each
    character is 256KB below making the source and destination
    2MB each. The lower case letters are moved (s to d) and the
    upper case letters are not moved.

    |DDDDddddSSSSssss|

    If we align down 'ssss' to start from the 'SSSS', we will end up destroying
    SSSS. The above if statement prevents that and I verified it.

    I also added a test for this in the last patch.

2. Handle the stack case separately. We do not care about #1 for stack movement
   because the 'SSSS' does not matter during this move. Further we need to do this
   to prevent the stack move warning.

    if (!for_stack && vma->vm_start <= addr_masked)
            return false;

History of patches
==================
v2->v3:
1. Masked address was stored in int, fixed it to unsigned long to avoid truncation.
2. We now handle moves happening purely within a VMA, a new test is added to handle this.
3. More code comments.

v1->v2:
1. Trigger the optimization for mremaps smaller than a PMD. I tested by tracing
that it works correctly.

2. Fix issue with bogus return value found by Linus if we broke out of the
above loop for the first PMD itself.

v1: Initial RFC.

Description of patches
======================
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

Joel Fernandes (Google) (6):
mm/mremap: Optimize the start addresses in move_page_tables()
mm/mremap: Allow moves within the same VMA
selftests: mm: Fix failure case when new remap region was not found
selftests: mm: Add a test for mutually aligned moves > PMD size
selftests: mm: Add a test for remapping to area immediately after
existing mapping
selftests: mm: Add a test for remapping within a range

fs/exec.c                                |   2 +-
include/linux/mm.h                       |   2 +-
mm/mremap.c                              |  69 ++++++++++-
tools/testing/selftests/mm/mremap_test.c | 148 +++++++++++++++++++++--
4 files changed, 209 insertions(+), 12 deletions(-)

--
2.40.1.698.g37aff9b760-goog

