Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D365A5AF552
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 22:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiIFUFV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 16:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiIFUE4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 16:04:56 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B18CCB5E79;
        Tue,  6 Sep 2022 13:00:32 -0700 (PDT)
Received: from pwmachine.numericable.fr (85-170-34-72.rev.numericable.fr [85.170.34.72])
        by linux.microsoft.com (Postfix) with ESMTPSA id 36F4E204A062;
        Tue,  6 Sep 2022 12:58:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 36F4E204A062
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1662494339;
        bh=uFGRrOq/51NXIcdfjbdqGyuEN8JjUWMtBLgpVH9tTbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s0ip9PP/e7tNFhTzW5Qi5hmgISsGF5ZqFozbagJLd9QyP2nb8fQwXdiRQ3lp6yhyo
         SYD9DSLv8MQk1PstZ+J+YXCj5NpaCpaBeetft2N5Pr3g5S/kp4+m2LBnYNKboOS+bO
         C7/FC7B8CQ4ZEjDDb3eC26nfWjqax71Es0yYlFR8=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     bpf@vger.kernel.org
Cc:     Francis Laniel <flaniel@linux.microsoft.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Maxim Mikityanskiy <maximmi@nvidia.com>,
        Geliang Tang <geliang.tang@suse.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v2 3/5] docs/bpf: Add documentation for overwritable ring buffer.
Date:   Tue,  6 Sep 2022 21:56:44 +0200
Message-Id: <20220906195656.33021-4-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906195656.33021-1-flaniel@linux.microsoft.com>
References: <20220906195656.33021-1-flaniel@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add documentation to precise behavior of overwritable BPF ring buffer compared
to conventionnal ones.

Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
---
 Documentation/bpf/ringbuf.rst | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/ringbuf.rst b/Documentation/bpf/ringbuf.rst
index 6a615cd62bda..e062381ff604 100644
--- a/Documentation/bpf/ringbuf.rst
+++ b/Documentation/bpf/ringbuf.rst
@@ -124,7 +124,7 @@ buffer.  Currently 4 are supported:
 
 - ``BPF_RB_AVAIL_DATA`` returns amount of unconsumed data in ring buffer;
 - ``BPF_RB_RING_SIZE`` returns the size of ring buffer;
-- ``BPF_RB_CONS_POS``/``BPF_RB_PROD_POS`` returns current logical possition
+- ``BPF_RB_CONS_POS``/``BPF_RB_PROD_POS`` returns current logical position
   of consumer/producer, respectively.
 
 Returned values are momentarily snapshots of ring buffer state and could be
@@ -204,3 +204,19 @@ buffer. For extreme cases, when BPF program wants more manual control of
 notifications, commit/discard/output helpers accept ``BPF_RB_NO_WAKEUP`` and
 ``BPF_RB_FORCE_WAKEUP`` flags, which give full control over notifications of
 data availability, but require extra caution and diligence in using this API.
+
+Specific case of overwritable ring buffer
+-----------------------------------------
+
+Using ``BFP_F_RB_OVERWRITABLE`` when creating the ring buffer will make it
+overwritable.
+As a consequence, the producers will never be stopped from writing data, *i.e.*
+in this mode ``bpf_ringbuf_reserve()`` never blocks and returns NULL, but oldest
+events will be replaced by newest ones.
+
+In terms of implementation, this feature uses the same logic than overwritable
+perf ring buffer.
+The ring buffer is written backward, while it should be read forward from the
+producer position.
+As a consequence, in this mode, the consumer position has no meaning and can be
+used freely by userspace implementation.
-- 
2.25.1

