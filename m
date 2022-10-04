Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188025F4241
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Oct 2022 13:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJDLtW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Oct 2022 07:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJDLtV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Oct 2022 07:49:21 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1A34D818;
        Tue,  4 Oct 2022 04:49:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4MhbS30z51z9v7H2;
        Tue,  4 Oct 2022 19:43:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDXU16kHTxjYVKaAA--.62750S2;
        Tue, 04 Oct 2022 12:49:00 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 0/6] Add _opts variant for bpf_*_get_fd_by_id()
Date:   Tue,  4 Oct 2022 13:48:33 +0200
Message-Id: <20221004114839.2302206-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDXU16kHTxjYVKaAA--.62750S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF45Ar4ktFy5Xr17AF48tFb_yoW8Wr1Up3
        9xGryFkr1FgFyxu3sxJayFyrn5Ga4xWw1UC3Z7Jr15Zr9YqF4DZry8WF45WF9xu395Ganx
        Zr4Yyr1DGw1UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x
        0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
        F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
        kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7Cj
        xVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa
        73UjIFyTuYvjxUxo7KDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAPBF1jj4POugAAsM
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

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
 .../bpf/prog_tests/libbpf_get_fd_opts.c       | 88 +++++++++++++++++++
 .../bpf/progs/test_libbpf_get_fd_opts.c       | 36 ++++++++
 5 files changed, 188 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_opts.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_libbpf_get_fd_opts.c

-- 
2.25.1

