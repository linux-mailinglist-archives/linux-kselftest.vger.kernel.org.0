Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1117759192
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 11:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjGSJ2o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 05:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjGSJ2n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 05:28:43 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01781BE4
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 02:28:42 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-317009c0f9aso3206078f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 02:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689758921; x=1692350921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7yIrbZZR4lCf9GkhcpzxSxXCXtiiG2twcc9m1HrepQM=;
        b=YEixGh5HQBFgZR9iRMGxVQCaew6ZN4cNCvdwaCgkfJ4NWRHyaXymSonkXqsxYBpeHw
         eFC+YxzSSrCN7HiNvb14OxUMDE8BJyipOGvbCz2c4iFNE1kVuNRKPGkbtOojEi5nU9O1
         10SWJi8kIW2w4bJ9Zm88mldz64l1zZLyPWdqqAtXxawhrlOGm4TgPy9mGIs0JMn/vVqZ
         0XaPgHMVc8OlKMG/t1sPKUe0I4eLQbEwCfsL9bBWJziaxlG+QoRVZn2oHrw6UBqHkzYB
         vqLIcP+F3xKVCbHQd0NfLVf32dNlWI91inCPekKmzovxRwFbW7Y6IVI9/P+MkBPN7cTF
         VVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689758921; x=1692350921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yIrbZZR4lCf9GkhcpzxSxXCXtiiG2twcc9m1HrepQM=;
        b=hz5tAluMu3Fe3EGX4FCwKeCxGrNRVeKEwidd/Z5Al7TopOxW5jumUDixpQrcTHZbBy
         eseQ1/bmE5zlfTeQVh5heHn8fJwlfeMIGeccs9zNz0ou/N+mtVpqmPfO7gJ28zM2HQEF
         ttj5ivXsRSrguQ0xWXBgQBndkl5xCKDbmvPhxXG+ibp1xPrZJy3aMbkkjh4Gy+eMlzmi
         tpuhvNqZqxb0wKt+spqfI9LRzd5i0E7YmGjmgyW0gsbjdH4CcX5U9SqWm7jg5uVOINGG
         YTGQgsHzx4i8RQ+MpQ0qx1ViKcShrxb1LcFrOWbz8RxI5WPvxoD6pM3UyDHAP/vu0urz
         ACwA==
X-Gm-Message-State: ABy/qLaAfDgJ4Ji2yYOofErzhMK/BWjuDddcXMYVXZ8SDiAwS+xCiQoC
        yD9CmKAc50LjrkqmFSJ0yjRJmg==
X-Google-Smtp-Source: APBJJlGdrZyXQBJRRhdPij5Uln/4bYjkXgebmKRLaYptoKxPns58oPRvii6FI4Dg7/Guu6ObcLZAbQ==
X-Received: by 2002:a5d:4292:0:b0:314:f88:4fea with SMTP id k18-20020a5d4292000000b003140f884feamr15008563wrq.8.1689758921130;
        Wed, 19 Jul 2023 02:28:41 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id r18-20020adff112000000b0031435c2600esm4857213wro.79.2023.07.19.02.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 02:28:40 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 1/4] bpf: consider types listed in reg2btf_ids as trusted
Date:   Wed, 19 Jul 2023 09:29:49 +0000
Message-Id: <20230719092952.41202-2-aspsk@isovalent.com>
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

The reg2btf_ids array contains a list of types for which we can (and need)
to find a corresponding static BTF id. All the types in the list can be
considered as trusted for purposes of kfuncs.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 kernel/bpf/verifier.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0b9da95331d7..05123feab378 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5413,12 +5413,24 @@ static bool is_flow_key_reg(struct bpf_verifier_env *env, int regno)
 	return reg->type == PTR_TO_FLOW_KEYS;
 }
 
+static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
+#ifdef CONFIG_NET
+	[PTR_TO_SOCKET] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
+	[PTR_TO_SOCK_COMMON] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
+	[PTR_TO_TCP_SOCK] = &btf_sock_ids[BTF_SOCK_TYPE_TCP],
+#endif
+};
+
 static bool is_trusted_reg(const struct bpf_reg_state *reg)
 {
 	/* A referenced register is always trusted. */
 	if (reg->ref_obj_id)
 		return true;
 
+	/* Types listed in the reg2btf_ids are always trusted */
+	if (reg2btf_ids[base_type(reg->type)])
+		return true;
+
 	/* If a register is not referenced, it is trusted if it has the
 	 * MEM_ALLOC or PTR_TRUSTED type modifiers, and no others. Some of the
 	 * other type modifiers may be safe, but we elect to take an opt-in
@@ -10052,15 +10064,6 @@ static bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env,
 	return true;
 }
 
-
-static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
-#ifdef CONFIG_NET
-	[PTR_TO_SOCKET] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
-	[PTR_TO_SOCK_COMMON] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
-	[PTR_TO_TCP_SOCK] = &btf_sock_ids[BTF_SOCK_TYPE_TCP],
-#endif
-};
-
 enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_CTX,
 	KF_ARG_PTR_TO_ALLOC_BTF_ID,    /* Allocated object */
-- 
2.34.1

