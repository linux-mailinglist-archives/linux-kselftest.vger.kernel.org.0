Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0837F6EFF53
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Apr 2023 04:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242915AbjD0CbC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Apr 2023 22:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242892AbjD0Ca7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Apr 2023 22:30:59 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA34E30FB
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Apr 2023 19:30:32 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-24736790966so6627138a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Apr 2023 19:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682562632; x=1685154632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/xaj+Q2T9Te+PgOenHvOLtflXb3HKv6gZnvibqK8ANs=;
        b=SJFbcuN2wIAnq9cFYM4ycwFLqtOyL4HPtbDXgL5MYgp8D1ouBKdJb20SkaoZn6eXm8
         UuOcG8cjQ5FUis75xpMbQrZAPH9aFG45V7YRBtVW0a2yCbNrZ71Y2Lf0iermD559TZp7
         w28k/9cuJkkY6yZNF+u97oW/5qa5qJAugvgGDX3ygRv5KghEQzlQecaLF2D0LF058VN8
         dKfHkl4O617HBEnpA4fwCT3ds8zVbysa4Pbpk+w6Micj10kFaOldBpxntHcZUvaWSemP
         3NNShXAMv+6ok1cyeDg5hR6xnC18LRNxDK9LPVdLgpqxVyU6/maKlhAifIs4IRDTYqex
         uo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682562632; x=1685154632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xaj+Q2T9Te+PgOenHvOLtflXb3HKv6gZnvibqK8ANs=;
        b=aVWzvs+wOTIKXjCvTGwscRC4ZgEgFNyXKwgOmRzcOTHgfJcgyIEd8tuHPI4OSoI+Oz
         Tl+EcLFp5gbO+NTOYlWLqqEab0EsQsg19ZSbn4nmdtQhL832GECDYH8MVvjo7TQfqpQO
         55Th4+Vn80FAhl97AoG5P02luH0xERMUEk64mAijNyBJHcogYhfmzt5UyxO/KV98QTLC
         +Iies8hwGW4bVIqpRrWAlpLMDxQpG/VSF9K0EdHrelq77WqF7vXwLSho/fzv0vl9HLBZ
         RwFgSDPHtObejmM50SVTfvCKziPkaawsJeUmRYhT7quycO+ckGjx3b/Son1kW05YDf6n
         VkPQ==
X-Gm-Message-State: AC+VfDzqJSiPtSF8RWIq6sOQkUPgfihqRMPxfn3/sO8ttS1nag5XmTvO
        uiO9OvdnH1flXlklzILgUXI69g==
X-Google-Smtp-Source: ACHHUZ6cWGdmirE46oQJz7Wde94gds8DMkTlinHiZyFzEmWRWby+bBK44FUgnNEZpn4sXjVdv0I5Dw==
X-Received: by 2002:a17:90b:17cc:b0:247:6a31:d59d with SMTP id me12-20020a17090b17cc00b002476a31d59dmr360691pjb.1.1682562632340;
        Wed, 26 Apr 2023 19:30:32 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m8-20020a654388000000b0051303d3e3c5sm10291852pgp.42.2023.04.26.19.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 19:30:31 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mykolal@fb.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
        zhoufeng.zf@bytedance.com
Subject: [PATCH bpf-next v3 0/2] Introduce a new kfunc of bpf_task_under_cgroup
Date:   Thu, 27 Apr 2023 10:30:17 +0800
Message-Id: <20230427023019.73576-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

Trace sched related functions, such as enqueue_task_fair, it is necessary to
specify a task instead of the current task which within a given cgroup.

Feng Zhou (2):
  bpf: Add bpf_task_under_cgroup() kfunc
  selftests/bpf: Add testcase for bpf_task_under_cgroup

Changelog:
v2->v3: Addressed comments from Alexei Starovoitov
- Modify the comment information of the function.
- Narrow down the testcase's hook point
Details in here:
https://lore.kernel.org/all/20230421090403.15515-1-zhoufeng.zf@bytedance.com/

v1->v2: Addressed comments from Alexei Starovoitov
- Add kfunc instead.
Details in here:
https://lore.kernel.org/all/20230420072657.80324-1-zhoufeng.zf@bytedance.com/

 kernel/bpf/helpers.c                          | 20 ++++++++
 tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
 .../bpf/prog_tests/task_under_cgroup.c        | 47 +++++++++++++++++++
 .../selftests/bpf/progs/cgrp_kfunc_common.h   |  1 +
 .../bpf/progs/test_task_under_cgroup.c        | 37 +++++++++++++++
 5 files changed, 106 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_under_cgroup.c

-- 
2.20.1

