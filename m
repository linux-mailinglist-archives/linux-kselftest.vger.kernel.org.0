Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A000753D12
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 16:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbjGNOUP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 10:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbjGNOUM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 10:20:12 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A8435A4
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jul 2023 07:20:00 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-98e39784a85so673805966b.1
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jul 2023 07:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689344399; x=1691936399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TL4iPDnWm7LI7dooTGYVCYljPJYJzbf9kW0UMI/E3E8=;
        b=fET5mheW2k8XUXyCZgr27r2S9eemW47Zml2RjJmVZyJa6RxgKX38TLREi0uUyQ65yK
         jSGBL1/GR3mB13uvWizvy6Tx1Co8Sv9uFVxkTHU1HA6DT+PaSInTystxarYkKtyDTgd8
         KrL6NGvz/vVSNmANyBpD4E7mcuQSp8VB3UIRBXInlWxCmPxprdUcZ5Q5cRifRqP5FMCY
         cDoOhltg0/cfN5w2vBvmO3IK4d4YIOVBppyzkcEEMPbbC+uNzVR3BCB+ojAZuDLIGRIV
         ScLMdhan5tSU1Yww7m2rFz5bIwIdG1kTi5rSEIxRDYLHiHYoTDS0Z48DW7PKBs2QrhRH
         lLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689344399; x=1691936399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TL4iPDnWm7LI7dooTGYVCYljPJYJzbf9kW0UMI/E3E8=;
        b=QzegyK7J2c41cBMV+1MijKj9ANhQi0yMb6fg0qb3v7Cgw+t+QpqcghqqrpPxz0bBhn
         scAnPC2AVgwecLcEqx2JFSL2loF2f9LJzDOfEEkRhr0c5yT6cxNmhlg/edDV07wDRvt0
         oxgBFyfl1DN1nPMERgBh0vqmF5BzrRTbOfZ08vPmwoQzfH8xX6q8OhjhqxCACHNcNraW
         kV8Vx6Up0ikDscv8XY8LoytK6h5CVLf3OMy65LQtgVunMVRYtK0mSzfkARHvGsHPb67V
         sfrqYP8kk2l8x6Cr2vnVYrLlcev3ewaWbvi0XgTF4HWGg3izwBLhTPU9tj2BT2UthS7/
         l87Q==
X-Gm-Message-State: ABy/qLYtE2s0ueVxwM2SMRbbtuKnc+1NKeim0O9+cuY/C73gTiKWKwwr
        E0JgXnlg2TwohNBwJbFf4pKafg==
X-Google-Smtp-Source: APBJJlEQIvA3n/Prr51crDxtReiG/q/Se2PDT6dKD9tdWOl1w72csMERG1dYfF3M+wYIMbNXDH9elQ==
X-Received: by 2002:a17:907:6d19:b0:98d:abd4:4000 with SMTP id sa25-20020a1709076d1900b0098dabd44000mr3312257ejc.35.1689344399312;
        Fri, 14 Jul 2023 07:19:59 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id n11-20020a1709061d0b00b00982cfe1fe5dsm5469294ejh.65.2023.07.14.07.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 07:19:58 -0700 (PDT)
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
Subject: [PATCH bpf-next 3/3] bpf: allow any program to use the bpf_map_sum_elem_count kfunc
Date:   Fri, 14 Jul 2023 14:21:00 +0000
Message-Id: <20230714142100.42265-4-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714142100.42265-1-aspsk@isovalent.com>
References: <20230714141747.41560-1-aspsk@isovalent.com>
 <20230714142100.42265-1-aspsk@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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

