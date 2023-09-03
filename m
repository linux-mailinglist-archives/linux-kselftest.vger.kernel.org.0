Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30ED790CA7
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Sep 2023 17:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbjICPNk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 3 Sep 2023 11:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjICPNk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 3 Sep 2023 11:13:40 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B9CAF
        for <linux-kselftest@vger.kernel.org>; Sun,  3 Sep 2023 08:13:37 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-76c64da0e46so40824039f.0
        for <linux-kselftest@vger.kernel.org>; Sun, 03 Sep 2023 08:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693754016; x=1694358816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CCvQ9I3iX0QNbfprGz58qw4sI+PzMWVZGPRTGiDllgA=;
        b=L4K6rt5r9HcwPbf9IQ/+LEowMCr/1AjmF/SivHILUUEvX1UtxO0iy990ha3e0tnILX
         /315QAJ860cny6tOiJxMssvi/NSanB0y8vTBJTkDY2u7HLdMsgVDSmKN1e/XQ7XRtZkA
         VlU3uS+qLRGSR9pyTxd5HnOMEYL55/YeMYvO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693754016; x=1694358816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CCvQ9I3iX0QNbfprGz58qw4sI+PzMWVZGPRTGiDllgA=;
        b=MbnMAj8Il6xEFotzdzF7suEL2QYbR4HB7hKQEvkT/BX11V0xz5sErHGNcRtuM2h10x
         isD5F1iTKMkl8xuRkbQ6TCX17cyCoAbcvZN5Y3k8b8q1N05xa0o8A8aI8Mt67GCUDvk6
         FaKiHC+fdwHBFApNquYRyHLZOTrbmZHgJ8QfmMCT1L4r4jos8HmVjaEmXmlhj6IzFC58
         1FONrTMhb+lpF5bcIqduFzeYerT/1gtyrWGGM3pWUAGmZ09qIyuARJOaQA2v45pRdmeO
         7kXQcpvABVAlT+Lk3IYY5wuNIa7GlARGRlhQysR6bCZTrRq+Nrgfa1qjyFU1sR4AtHG8
         R+ig==
X-Gm-Message-State: AOJu0Yy15lNuLQSxqbL/IU3IkP1Cb0UaUZlL5K5wbmZ0n1v94ty+7NyP
        jQGkCzulhZedJJydk9UDagpeVg==
X-Google-Smtp-Source: AGHT+IE/HjnLbiJxM1Lmb727IC4/RfuR7vJbdORXm2i4XVKm0REgtSjEy7C30GQyEeQtcHiz426FWQ==
X-Received: by 2002:a5d:9b0d:0:b0:790:9f0c:3069 with SMTP id y13-20020a5d9b0d000000b007909f0c3069mr8461710ion.9.1693754016455;
        Sun, 03 Sep 2023 08:13:36 -0700 (PDT)
Received: from joelboxx5.corp.google.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id f5-20020a6b5105000000b007835a305f61sm2605897iob.36.2023.09.03.08.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 08:13:35 -0700 (PDT)
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
Subject: [PATCH v6 0/7] Optimize mremap during mutual alignment within PMD
Date:   Sun,  3 Sep 2023 15:13:21 +0000
Message-ID: <20230903151328.2981432-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
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

Hello!

Here is v6 of the mremap start address optimization / fix for exec warning.
Should be hopefully final now and only 2/7 and 6/7 need a tag. Thanks a lot to
Lorenzo and Linus for the detailed reviews.

Description of patches
======================
These patches optimizes the start addresses in move_page_tables() and tests the
changes. It addresses a warning [1] that occurs due to a downward, overlapping
move on a mutually-aligned offset within a PMD during exec. By initiating the
copy process at the PMD level when such alignment is present, we can prevent
this warning and speed up the copying process at the same time. Linus Torvalds
suggested this idea. Check the individual patches for more details.
[1] https://lore.kernel.org/all/ZB2GTBD%2FLWTrkOiO@dhcp22.suse.cz/

History of patches:
v5->v6:
1. Reworking the stack case a bit more and tested it (should be final now).
2. Other small nits.

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
mm/mremap: Allow moves within the same VMA for stack moves
selftests: mm: Fix failure case when new remap region was not found
selftests: mm: Add a test for mutually aligned moves > PMD size
selftests: mm: Add a test for remapping to area immediately after
existing mapping
selftests: mm: Add a test for remapping within a range

fs/exec.c                                |   2 +-
include/linux/mm.h                       |   2 +-
mm/mremap.c                              |  73 +++++-
tools/testing/selftests/mm/mremap_test.c | 301 +++++++++++++++++++----
4 files changed, 329 insertions(+), 49 deletions(-)

--
2.42.0.283.g2d96d420d3-goog

