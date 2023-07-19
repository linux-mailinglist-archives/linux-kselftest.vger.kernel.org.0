Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27757759199
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 11:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjGSJ27 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 05:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGSJ2t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 05:28:49 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2B31FCC
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 02:28:46 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fbbfaacfc1so11026413e87.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 02:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689758924; x=1692350924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TL4iPDnWm7LI7dooTGYVCYljPJYJzbf9kW0UMI/E3E8=;
        b=RmR0tn2XLxoJOQVfhj6Z1y0iP4vl4SctrEUwL1kVlHU/vpEljcorwTzzRgX4ay8x6J
         ZxCler5k1qYfD6FdRhctRHWJrBIPj38PG89ytDH1l+GK/juPRE8kbFKAaIJvYhEnX+81
         30HIyfPQhmb4VSWcnrPkYKDmvk69GBJc5iD2tQCEvBqIpJOSQdaWDlwlQGrmkiLNazPC
         2Bd5pSUZiJkEroDFWFD7oNPe2iJXfklJtZZAxJi52al2Sf6Kt+wJ4C53pbYDuTYFHwb6
         ENKVUA0rzunIqRYXUKNUzwvzz8u/Zxja1M6bOI/9MJ46+Hm2LNiCV5O8vSnBxs2Ub3fI
         jbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689758924; x=1692350924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TL4iPDnWm7LI7dooTGYVCYljPJYJzbf9kW0UMI/E3E8=;
        b=GKFigHJepy//KJ8ZFqrmtBYYpz+Y/9hD06gLZ14v7wZHKCra2o1IW7E3KgIjWUILPd
         ErQ0FxhqiHFR+9vpb9HANtv0SEceu2T1BtZrP+SbZAG2c1M1GX5mP0Hu/0XQJIr4wVwu
         HUKc8wUxoq41Z52qqiuGm3gUacZO9ql+zon4uzSFx6kY5ZDmMAq4mSwB3wtQ3kQxyWDQ
         wPF1OU7Jz69Okn3AWU8s6kJHK0pzupC3x0rY69wRks6ldl/az7jSlYq0ZhzXvo5ueEB2
         QwJBNv6qEuURkfNAEgs/1y5cIwxsivumomujoFprnnXuMZ09bxEtK9uPZKPD4K0Ku/rl
         uEdA==
X-Gm-Message-State: ABy/qLbgPNpobWCJLQ5EeCttqfKYfqprCnwprLIn/C0eYuuu3YV8RndJ
        WLd17IqVF2iuzbdqXHC/svoa1g==
X-Google-Smtp-Source: APBJJlEvJxlIlo047VV+7wzcGwDG8LI2FzpITTuAkDeRT6GN74ABqTYEyn20L8ozGDwoQvHV0y9XxA==
X-Received: by 2002:a05:6512:3d1b:b0:4fb:8a92:4fba with SMTP id d27-20020a0565123d1b00b004fb8a924fbamr15073243lfv.25.1689758924233;
        Wed, 19 Jul 2023 02:28:44 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id r18-20020adff112000000b0031435c2600esm4857213wro.79.2023.07.19.02.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 02:28:43 -0700 (PDT)
From:   Anton Protopopov <aspsk@isovalent.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Hou Tao <houtao1@huawei.com>, Joe Stringer <joe@isovalent.com>,
        Anton Protopopov <aspsk@isovalent.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 bpf-next 4/4] bpf: allow any program to use the bpf_map_sum_elem_count kfunc
Date:   Wed, 19 Jul 2023 09:29:52 +0000
Message-Id: <20230719092952.41202-5-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230719092952.41202-1-aspsk@isovalent.com>
References: <20230719092952.41202-1-aspsk@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Register the bpf_map_sum_elem_count func for all programs, and update the
map_ptr subtest of the test_progs test to test the new functionality.

The usage is allowed as long as the pointer to the map is trusted (when
using tracing programs) or is a const pointer to map, as in the following
example:

    struct {
            __uint(type, BPF_MAP_TYPE_HASH);
            ...
    } hash SEC(".maps");

    ...

    static inline int some_bpf_prog(void)
    {
            struct bpf_map *map = (struct bpf_map *)&hash;
            __s64 count;

            count = bpf_map_sum_elem_count(map);

            ...
    }

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 kernel/bpf/map_iter.c                            | 2 +-
 tools/testing/selftests/bpf/progs/map_ptr_kern.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index 011adb41858e..6fc9dae9edc8 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -226,6 +226,6 @@ static const struct btf_kfunc_id_set bpf_map_iter_kfunc_set = {
 
 static int init_subsystem(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_map_iter_kfunc_set);
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &bpf_map_iter_kfunc_set);
 }
 late_initcall(init_subsystem);
diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
index db388f593d0a..3325da17ec81 100644
--- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
+++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
@@ -103,6 +103,8 @@ struct {
 	__type(value, __u32);
 } m_hash SEC(".maps");
 
+__s64 bpf_map_sum_elem_count(struct bpf_map *map) __ksym;
+
 static inline int check_hash(void)
 {
 	struct bpf_htab *hash = (struct bpf_htab *)&m_hash;
@@ -115,6 +117,8 @@ static inline int check_hash(void)
 	VERIFY(hash->elem_size == 64);
 
 	VERIFY(hash->count.counter == 0);
+	VERIFY(bpf_map_sum_elem_count(map) == 0);
+
 	for (i = 0; i < HALF_ENTRIES; ++i) {
 		const __u32 key = i;
 		const __u32 val = 1;
@@ -123,6 +127,7 @@ static inline int check_hash(void)
 			return 0;
 	}
 	VERIFY(hash->count.counter == HALF_ENTRIES);
+	VERIFY(bpf_map_sum_elem_count(map) == HALF_ENTRIES);
 
 	return 1;
 }
-- 
2.34.1

