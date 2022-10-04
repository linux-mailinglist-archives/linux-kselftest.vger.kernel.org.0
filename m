Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FE25F440C
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Oct 2022 15:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiJDNSc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Oct 2022 09:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJDNSb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Oct 2022 09:18:31 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615BACE1C;
        Tue,  4 Oct 2022 06:18:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4MhdSF2NpZz9v7Gg;
        Tue,  4 Oct 2022 21:13:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwA3ZV+JMjxj8ZGaAA--.6154S2;
        Tue, 04 Oct 2022 14:18:10 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RESEND][PATCH 0/6] Add _opts variant for bpf_*_get_fd_by_id()
Date:   Tue,  4 Oct 2022 15:17:44 +0200
Message-Id: <20221004131750.2306251-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwA3ZV+JMjxj8ZGaAA--.6154S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4rWFyrtFWrWF4kKFykXwb_yoW8Ar1kp3
        93G34FkrnYgFyxu3sxJa9Yqw1rKFWxWw1UC3Z7Jr15Z3s5XFWDZry8WF45Wr9xu395Gwsx
        Zr4Ykr1DGw17AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E
        87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU13rcDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBF1jj3-RDQABsa
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

NOTE: resending with libbpf_get_fd_opts test added to deny list for s390x.

Add the _opts variant for bpf_*_get_fd_by_id() functions, to be able to
pass to the kernel more options, when requesting a fd of an eBPF object to
the kernel.

Pass the options through a newly introduced structure, bpf_get_fd_opts,
which currently contains open_flags (the other two members are for
compatibility and for padding).

open_flags allows the caller to request specific permissions to access a
map (e.g. read-only). This is useful for example in the situation where a
map is write-protected.

Besides patches 2-6, which introduce the new variants and the data
structure, patch 1 fixes the LIBBPF_1.0.0 declaration in libbpf.map.

Roberto Sassu (6):
  libbpf: Fix LIBBPF_1.0.0 declaration in libbpf.map
  libbpf: Define bpf_get_fd_opts and introduce
    bpf_map_get_fd_by_id_opts()
  libbpf: Introduce bpf_prog_get_fd_by_id_opts()
  libbpf: Introduce bpf_btf_get_fd_by_id_opts()
  libbpf: Introduce bpf_link_get_fd_by_id_opts()
  selftests/bpf: Add tests for _opts variants of bpf_*_get_fd_by_id()

 tools/lib/bpf/bpf.c                           | 47 +++++++++-
 tools/lib/bpf/bpf.h                           | 16 ++++
 tools/lib/bpf/libbpf.map                      |  6 +-
 tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
 .../bpf/prog_tests/libbpf_get_fd_opts.c       | 88 +++++++++++++++++++
 .../bpf/progs/test_libbpf_get_fd_opts.c       | 36 ++++++++
 6 files changed, 189 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_opts.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_libbpf_get_fd_opts.c

-- 
2.25.1

