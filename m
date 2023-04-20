Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8066E8B6C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 09:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbjDTH2F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 03:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbjDTH2D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 03:28:03 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502F02727
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Apr 2023 00:27:11 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a6bc48aec8so6580895ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Apr 2023 00:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681975630; x=1684567630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hg5G5o39i/mOMMBB9sZHDlNqgHJXvtHyvxUr2dJ6THE=;
        b=BQbIwBXlnSqTma2rpNtp/kmApjVLLv7lEvBdWe5vYYjbZ3+kyORkbYhmhpoaSzdJCO
         k7DQSqxytbrb+wObQpbwjXpm700w5yoNG00kUe0MzgG4kAkD1TzRmtKnwKYQd4qEQtFC
         UXBQ7DhAwluK9Pqs9YwAimpgURIbt49BMWP4E/cBMi8ooSuRSPhcSOvbTgFF1qISPrnc
         JeR0B8E+OvWgBM5ba7ZNLwBBgq4QiUdETHDjQNqJ6PTKG/AzyFngtxmwB0jsu1sL4U7q
         dNJ/j8A8/9lsrVqzWb+hEgF/emtrfEmzNgQFU6PE1lbnItTn/KZRBewxbbX95KDwbmFI
         61lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681975630; x=1684567630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hg5G5o39i/mOMMBB9sZHDlNqgHJXvtHyvxUr2dJ6THE=;
        b=FAhfZ1G/qvdlBLfz+r10ySxc2Fq5wYlWOt3nuY/w4ochIp6PocIU1bfzfKOLhX5psv
         nA2CLXdaN2ftBFBuxXqdV+3h8BO6f2/8jsBLAOdkHjv0rqxVJ+Ctal3bCsY637TvlEaW
         nthduRVWgUH8ZnlFB0Rug0wmzGWP0UCKSty3HQKbhPe+Uc4MWMQbVviqFUMmDBdl0qZI
         Av6nKQ/LpPfYJcAI90hGGHKii/V9UKBS1eR+FU69ROGoS1Mt750yCn+opfdOLqrCaYuM
         xZZIt3Dtjr9K11hTiJXrYQJVBbTJoTw/dqODkClgagiEduZf+nSx9X22xOFmIcbgf/iy
         mQog==
X-Gm-Message-State: AAQBX9dXN+Z+nZ3A52XOULpgDncEKufzzDz7FM7JkJirpL9D4W3tjpqk
        Mg4SfqNOiu/MjP0wLkz9AMPJFQ==
X-Google-Smtp-Source: AKy350ZJIw4S2jRf7AWkGYprd3RLjOgFmimEdu2sssZcSsBy7YV14EYvdTzo91BU7GQ4xQK0LTxMDg==
X-Received: by 2002:a17:903:2444:b0:19e:6cb9:4c8f with SMTP id l4-20020a170903244400b0019e6cb94c8fmr814495pls.41.1681975630719;
        Thu, 20 Apr 2023 00:27:10 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id y18-20020a17090ad71200b0023440af7aafsm612160pju.9.2023.04.20.00.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 00:27:10 -0700 (PDT)
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
Subject: [PATCH bpf-next 0/2] Introduce a new bpf helper of bpf_task_under_cgroup
Date:   Thu, 20 Apr 2023 15:26:55 +0800
Message-Id: <20230420072657.80324-1-zhoufeng.zf@bytedance.com>
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
specify a task instead of the current task which within a given cgroup to a map.

Feng Zhou (2):
  bpf: Add bpf_task_under_cgroup helper
  selftests/bpf: Add testcase for bpf_task_under_cgroup

 include/uapi/linux/bpf.h                      | 13 +++++
 kernel/bpf/verifier.c                         |  4 +-
 kernel/trace/bpf_trace.c                      | 31 ++++++++++++
 tools/include/uapi/linux/bpf.h                | 13 +++++
 .../bpf/prog_tests/task_under_cgroup.c        | 49 +++++++++++++++++++
 .../bpf/progs/test_task_under_cgroup.c        | 31 ++++++++++++
 6 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_under_cgroup.c

-- 
2.20.1

