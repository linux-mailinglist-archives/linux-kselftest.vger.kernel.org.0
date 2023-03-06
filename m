Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CFE6AB105
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Mar 2023 15:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCEObo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Mar 2023 09:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCEObn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Mar 2023 09:31:43 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF9212BE5;
        Sun,  5 Mar 2023 06:31:34 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PV4000sHrz4f3jLk;
        Sun,  5 Mar 2023 22:31:28 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP4 (Coremail) with SMTP id gCh0CgBnF6vApwRkTwIvEw--.13658S2;
        Sun, 05 Mar 2023 22:31:29 +0800 (CST)
From:   Xu Kuohai <xukuohai@huaweicloud.com>
To:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Subject: [PATCH bpf-next 0/2] bpf: add bound tracking for BPF_MOD
Date:   Sun,  5 Mar 2023 22:31:17 -0500
Message-Id: <20230306033119.2634976-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnF6vApwRkTwIvEw--.13658S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFyfKr1UXF1kWrW7Cw47CFg_yoW3WrcEya
        92vas0vFsxtFn3Za9a9F17XFWUCw4UKry5JFsFgFW7XFykAryY9Fn5CrnYqa4DWayrJ39r
        JrnxtaykArnI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbskYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_Grv_XF1l8c
        AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq
        3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gc
        CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
        r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87
        Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIE
        c7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
        IFyTuYvjxUcgyCDUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Xu Kuohai <xukuohai@huawei.com>

dst_reg is marked as unknown when BPF_MOD instruction is verified, causing
the following bpf prog to be incorrectly rejected.

0: r0 = 0
1: r0 %= 10   // r0 is marked as unknown
2: r1 = 0
3: r1 += 1
4: if r1 < r0 goto pc-2 // verifier concludes the loop is unbounded
5: exit

To teach verifier to accept the above prog, this series adds bound tracking
for BPF_MOD.

Xu Kuohai (2):
  bpf: add bound tracking for BPF_MOD
  selftests/bpf: check if verifier tracks dst_reg bound for BPF_MOD

 kernel/bpf/verifier.c                      |  98 +++++++-
 tools/testing/selftests/bpf/verifier/mod.c | 247 +++++++++++++++++++++
 2 files changed, 340 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/mod.c

-- 
2.30.2

