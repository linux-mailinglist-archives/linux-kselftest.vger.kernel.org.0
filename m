Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C874B6C6CC6
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 16:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjCWP7f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 11:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjCWP7e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 11:59:34 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A841026A;
        Thu, 23 Mar 2023 08:59:33 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pj95D4BBmz4f3jqM;
        Thu, 23 Mar 2023 23:59:28 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP4 (Coremail) with SMTP id gCh0CgC3aq5fdxxktQW3Fw--.25283S2;
        Thu, 23 Mar 2023 23:59:29 +0800 (CST)
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
Subject: [PATCH bpf-next v2 0/2] bpf: add bound tracking for BPF_MOD
Date:   Fri, 24 Mar 2023 00:58:40 -0400
Message-Id: <20230324045842.729719-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC3aq5fdxxktQW3Fw--.25283S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFyfKr1UXF1kWrW7Cw47CFg_yoWDtFcEya
        93tasYvFnxJFnYqFZakF17WrWqkw4UKFyrJF42qrW7XFn7Jr1FgFs5Gry5Ja4DKFWrXrZ7
        JF9xtayvvrnIkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbs8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_Grv_XF1l8c
        AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWD
        JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oV
        Cq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG
        8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2js
        IE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY
        1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
        vEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
        ZEXa7IU8L2-5UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=2.5 required=5.0 tests=DATE_IN_FUTURE_12_24,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
1: r0 %= 1   // r0 is marked as unknown
2: r1 = 0
3: r1 += 1
4: if r1 < r0 goto pc-2 // verifier concludes the loop is unbounded
5: exit

To teach verifier to accept the above prog, this series adds bound tracking
for BPF_MOD.

v2:
- fix build warning reported by kernel test robot <lkp@intel.com> [0]
- add two more cases and update commit message

[0] https://lore.kernel.org/oe-kbuild-all/202303060036.zK05OC5M-lkp@intel.com

v1: https://lore.kernel.org/bpf/20230306033119.2634976-1-xukuohai@huaweicloud.com

Xu Kuohai (2):
  bpf: add bound tracking for BPF_MOD
  selftests/bpf: check if verifier tracks dst_reg bound for BPF_MOD

 kernel/bpf/verifier.c                      |  98 ++++++-
 tools/testing/selftests/bpf/verifier/mod.c | 320 +++++++++++++++++++++
 2 files changed, 413 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/mod.c

-- 
2.30.2

