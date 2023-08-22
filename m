Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638317837A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Aug 2023 03:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjHVBzX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 21:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjHVBzW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 21:55:22 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992C3113
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 18:55:20 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7922ca5cdbfso40006639f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 18:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692669320; x=1693274120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kduaF6NEmqtdigQR12l4zIQ9Z7Qe4cQI7f7goF2YonA=;
        b=dI1NF1M+qizhBIuBYOb+MBxjF0sUdkyIROhUTZohfN3aqISp/JA4m5jbZcgSPWZegi
         aasvoXFYkhoA2/ZBaoZysBBdmhpS90nBfblwsKbPPUpeQ+QbB5AEEj3GcTFRzke0Zst7
         Q+A31Fzlxgud3p4yedSBCBhWkDA9+KHXqyQWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692669320; x=1693274120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kduaF6NEmqtdigQR12l4zIQ9Z7Qe4cQI7f7goF2YonA=;
        b=ajJIweAJ7PgS0ISp/6akMTBuZbYAQl+DO40QQVsCxxrbZVdoxD9vpmHDkqEAx+EYSe
         c19ghVByJZzclyPLYV6NBQ9xhVh4SC55YKVPweyFk6q0M4Jq4CJ48Qfzzhp3AI1xBUor
         pjalwNwySXeMLJKYzJMM/GsunzOLNd5qUVrOBJMtGd218tUYLbPeQjMaT2NJXlQFUPj+
         Xb8Z2HYT1EhXKeczhplil1GqtdvznwJudtKwdUNJfEcU+ijerqinVH0wQrTVMD9LpheW
         hyAG+dmmaorV3udOvnVz7asSc7ciEIlbc3qkbWh52dJtpwMww+EhUttk/DvMfOqXIEgN
         DpWg==
X-Gm-Message-State: AOJu0YzesdbovnOji33DLReiH1KR/oebivB7wK9O4+grh9Wxcbxyim7L
        GMTX6lnw/9PCuXIMn0qSCFJUgci/g0JbSk/G1vw=
X-Google-Smtp-Source: AGHT+IFmsUAfJcyPXse8Hdp3SRmHFbe0cau7P07MO9wJsFGPEkow2OKRUv5tZ1eDPB6D8C1Kxe3K9Q==
X-Received: by 2002:a05:6e02:1523:b0:349:345b:6595 with SMTP id i3-20020a056e02152300b00349345b6595mr8918842ilu.11.1692669319980;
        Mon, 21 Aug 2023 18:55:19 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id q11-20020a92d40b000000b0034886587bdcsm2907390ilm.18.2023.08.21.18.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 18:55:19 -0700 (PDT)
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
Subject: [PATCH v5 0/7] Optimize mremap during mutual alignment within PMD
Date:   Tue, 22 Aug 2023 01:54:53 +0000
Message-ID: <20230822015501.791637-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
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

Hello!

Here is v5 of the mremap start address optimization / fix for exec warning.

Description of patches
======================
These patches optimizes the start addresses in move_page_tables() and tests the
changes. It addresses a warning [1] that occurs due to a downward, overlapping
move on a mutually-aligned offset within a PMD during exec. By initiating the
copy process at the PMD level when such alignment is present, we can prevent
this warning and speed up the copying process at the same time. Linus Torvalds
suggested this idea.

Please check the individual patches for more details.

[1] https://lore.kernel.org/all/ZB2GTBD%2FLWTrkOiO@dhcp22.suse.cz/

Link to v4:
https://lore.kernel.org/all/20230531220807.2048037-1-joel@joelfernandes.org/

History of patches:
v4->v5:
1. Rebased on mainline.
2. Several improvement suggestions from Lorenzo.

v3->v4:
1. Care to be taken to move purely within a VMA, in other words this check
   in call_align_down():
    if (vma->vm_start != addr_masked)
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

Joel Fernandes (1):
selftests: mm: Add a test for moving from an offset from start of
mapping

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
mm/mremap.c                              |  69 +++++-
tools/testing/selftests/mm/mremap_test.c | 301 +++++++++++++++++++----
4 files changed, 325 insertions(+), 49 deletions(-)

--
2.42.0.rc1.204.g551eb34607-goog

