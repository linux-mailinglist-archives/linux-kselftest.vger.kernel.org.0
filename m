Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C64B6F7CC5
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 May 2023 08:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjEEGI5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 May 2023 02:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjEEGI4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 May 2023 02:08:56 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7A414906
        for <linux-kselftest@vger.kernel.org>; Thu,  4 May 2023 23:08:30 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b60366047so1023117b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 04 May 2023 23:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683266910; x=1685858910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pSta0d8rMPRbh+U2QgJPeyvHfLc6ifzE+V/ts4215w4=;
        b=juItMXpkR4RnyffRyLs1wh8s/8701jzDW2VtsmFSD2zvi2i7VHcKO3u0TXhkFzZhdu
         AX5b8VtEtnjrLlrb/dR1Tlz5d0txNH6h7XZC3JF/CXtQkGJWQyZsE/FGdwtP/FoNa6T7
         roAR5j0Xn8H7OsV+7w48JglbFpS56Ofbib9v6Q5/c+Dcsiytbl61PAnkgWsk6UK4sFig
         B6VIPv1N7PgVC0i5en+/ygo2siYo5wr1eIFjTzUAPsH1O3ljQoMxAJRpSmKX66IxEeSK
         oCID+pd0GLqxfA4tTXmz7lJE5QU2SGJqsSqe6K7JfzrP9gat/3U3IFHLrWDz66Op5/gj
         gJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683266910; x=1685858910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSta0d8rMPRbh+U2QgJPeyvHfLc6ifzE+V/ts4215w4=;
        b=MBQpx9YGuJDWFJIujfS9CxhTb4iOnxuHFB4iELLC0bz1s+hIePpBLSLLZ2xr5/kSAv
         9UQt49jYnN2mVyPDYnhOQ8z3r72rjhOvL+5m1z986OiBTa9Zr2HizS5OxTy5xocu0kav
         KnVdq5pvzlC6bH4nzwH4vNnB3rO4Mls0A67v9hNKYzVdVupC2kC91tWe3HX7f+t02SK9
         hh4DRFVZFXnQcaqv1kVP0yWQgOWMlhXkUvqJ8qQRCbVdu+S7LHIK6Ww4jMvjJCh8vybb
         DqLNHNLo37uTOtlX1eMiom3NGENAHxHWy0ylKjpX9J4YzooZPMCHu370BruN5XI1Xcxp
         +9LA==
X-Gm-Message-State: AC+VfDzrAQiQxlHXeoHittwDoyhaRACevUzGlprm9XyrjgYThCk9z8HQ
        C0EiuV1n6pxAdc7HdAEcU/qUYQ==
X-Google-Smtp-Source: ACHHUZ5Xrm8F82be2bnl9ESPtXrPj37oeZwDiAyWWRpUiCKlDm0Qa/z5/SRQTHsveMLnYKuVj1wsLw==
X-Received: by 2002:a05:6a20:12c5:b0:f5:b4a5:73b4 with SMTP id v5-20020a056a2012c500b000f5b4a573b4mr523167pzg.27.1683266910194;
        Thu, 04 May 2023 23:08:30 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id a15-20020aa780cf000000b0063799398eb9sm762160pfn.58.2023.05.04.23.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 23:08:29 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 0/2] Introduce a new kfunc of bpf_task_under_cgroup
Date:   Fri,  5 May 2023 14:08:16 +0800
Message-Id: <20230505060818.60037-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
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

From: Feng Zhou <zhoufeng.zf@bytedance.com>

Trace sched related functions, such as enqueue_task_fair, it is necessary to
specify a task instead of the current task which within a given cgroup.

Feng Zhou (2):
  bpf: Add bpf_task_under_cgroup() kfunc
  selftests/bpf: Add testcase for bpf_task_under_cgroup

Changelog:
v5->v6: Addressed comments from Yonghong Song
- Some code format modifications.
- Add ack-by
Details in here:
https://lore.kernel.org/all/20230504031513.13749-1-zhoufeng.zf@bytedance.com/

v4->v5: Addressed comments from Yonghong Song
- Some code format modifications.
Details in here:
https://lore.kernel.org/all/20230428071737.43849-1-zhoufeng.zf@bytedance.com/

v3->v4: Addressed comments from Yonghong Song
- Modify test cases and test other tasks, not the current task.
Details in here:
https://lore.kernel.org/all/20230427023019.73576-1-zhoufeng.zf@bytedance.com/

v2->v3: Addressed comments from Alexei Starovoitov
- Modify the comment information of the function.
- Narrow down the testcase's hook point
Details in here:
https://lore.kernel.org/all/20230421090403.15515-1-zhoufeng.zf@bytedance.com/

v1->v2: Addressed comments from Alexei Starovoitov
- Add kfunc instead.
Details in here:
https://lore.kernel.org/all/20230420072657.80324-1-zhoufeng.zf@bytedance.com/

 kernel/bpf/helpers.c                          | 20 +++++++
 tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
 .../bpf/prog_tests/task_under_cgroup.c        | 53 +++++++++++++++++++
 .../bpf/progs/test_task_under_cgroup.c        | 51 ++++++++++++++++++
 4 files changed, 125 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_under_cgroup.c

-- 
2.20.1

