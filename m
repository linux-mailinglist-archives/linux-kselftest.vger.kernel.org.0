Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352475EAD2C
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Sep 2022 18:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiIZQv4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Sep 2022 12:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiIZQvf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Sep 2022 12:51:35 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540DE4D15E;
        Mon, 26 Sep 2022 08:45:07 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Mbn405qctz9xs6S;
        Mon, 26 Sep 2022 23:39:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwB3pF7lyDFjZ4d6AA--.42219S2;
        Mon, 26 Sep 2022 16:44:47 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        shuah@kernel.org, oss@lmb.io
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, fengc@google.com, davem@davemloft.net
Subject: [RFC][PATCH 0/3] bpf: Enforce map fd modes in verifier
Date:   Mon, 26 Sep 2022 17:44:27 +0200
Message-Id: <20220926154430.1552800-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwB3pF7lyDFjZ4d6AA--.42219S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1fCrWxGF17WFW7GF1kGrg_yoW8CF4kpa
        s5KF45tr1fK34xCas7Aa1IvryY9r4xAr45KFn3Jw15Zr98Jr9YqrW8K3W3Wr98KFWrGryr
        Zr4a9F98C3yDArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvSb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
        rVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
        IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x02
        62kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
        vEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
        ZEXa7IU0bAw3UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj4N4EAABsZ
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

===
All credits of this patch set go to Lorenz Bauer <oss@lmb.io>, as he
identified this issue and proposed a number of solutions.
===

Lorenz presented at the Linux Plumbers EU 2022 a talk with title 'Closing
the BPF map permission loophole', where he reported that read-only fds can
be used for map update operations, if they were provided to eBPF programs.

This work initially started as PoC to reproduce the reported bug, and
became the test for validating an idea on how to fix the bug.

Patch 1 adds a dependency necessary for the tests.

The actual fix, in patch 2, is relatively simple. It is based on an already
existing enforcement mechanism in the eBPF verifier for map flags. As
Lorenz mentioned, a problem would be backporting this fix to stable kernels
which don't have that enforcement mechanism. However, backporting just the
enforcement mechanism itself (without introducing the new map flags and
allowing user space to use them) could meet the stable kernel criteria.

Alternatively, a completely different fix can be developed for older stable
kernels, like what Lorenz suggested, to refuse fds which are not
read/write.

Finally, patch 3 introduces the tests.

Roberto Sassu (3):
  libbpf: Define bpf_get_fd_opts and introduce
    bpf_map_get_fd_by_id_opts()
  bpf: Enforce granted permissions in a map fd at verifier level
  selftests/bpf: Test enforcement of map fd permissions at verifier
    level

 include/linux/bpf.h                           |  13 +
 include/linux/bpf_verifier.h                  |   1 +
 kernel/bpf/verifier.c                         |  26 +-
 tools/lib/bpf/bpf.c                           |  12 +-
 tools/lib/bpf/bpf.h                           |  10 +
 tools/lib/bpf/libbpf.map                      |   3 +-
 .../selftests/bpf/prog_tests/map_fd_perm.c    | 227 ++++++++++++++++++
 7 files changed, 288 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_fd_perm.c

-- 
2.25.1

