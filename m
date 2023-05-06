Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21236F8D97
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 May 2023 03:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjEFBcK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 May 2023 21:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjEFBb5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 May 2023 21:31:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE437A83
        for <linux-kselftest@vger.kernel.org>; Fri,  5 May 2023 18:31:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a6eeea78cso21611198276.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 May 2023 18:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683336714; x=1685928714;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HpBXaqycDpeF1iiIRkKkU5q/FIeyp/QkzxqhW0Xulus=;
        b=EjAImXESIDfPwZ9hTfrYy5t7T/PaXqRElM81DJgaDdmyku00koV3RJuwLs0CjXuMrH
         QqxKeSjl2DRpviPJdfQpgpuUsjdK2dRS7YzYVp3Q6kjC7b122kwMli7b1PpS2xIWnG3Q
         rSmea63nSwQhq/99fsm8Qu80HuHARS9brKGSc2t503R704eAKxAD/8zpSXAKI2e5luGD
         dr7o6tyeENUuU3k8Fjq/x2rsYdMCccizaFRzIdNIjxamWCQEzd9UCHG9+5x+nLpgQFKd
         R1LtLS36OG44zs6if6mN0eloUv/VbbsSCd28EmizmI3nMHsop4hqGEEoaeptveFR4ra1
         uhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683336714; x=1685928714;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpBXaqycDpeF1iiIRkKkU5q/FIeyp/QkzxqhW0Xulus=;
        b=fkqE+XEc84u7gC0n52qN6Yb2sNS1/c4vKKodyd/UVMS5dTZE2yZQH0Xi36sKH7XwUc
         e1HjQZY9cZDMkF1eH1r42Dbqpm6iiU8ChqmoDKSt+XooO1ohErOQ2p8XJc4ka+GfssCn
         dpJ44DmamhNEPGl+Wp0w7MEMt7F5zH8M5rJc/ChahgjsxeP1NWdbAOUsTYTmQfuJWGcx
         JhXWanVkjtqdzS2wJI1h78EWIHQASC/MLBWI2t8eStZOQxKCPtOiK4JBfv6yqgiUWPKC
         ZNNpuxtMwFlWB8H0eRV61LDEuauLMOxwk4d8qYyAUBj90RNky9QQabheuzsrN/XvnjF2
         Zdjw==
X-Gm-Message-State: AC+VfDx9zzNHi9o48ZnafBaDUjXqVKCISrqVx8xzIFkv9fnY4zsi2RF6
        07k8hRjGkd1Im61UwWP7ya2KuPQoXrQ=
X-Google-Smtp-Source: ACHHUZ4A5/VQrgjM9CXLg0QZKufSjQAvXOBL5nKnEMH0jE2qlKOK/DEFBdZCQRuZx7hUTDgFmV9viNuQhQ4=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:6826:a1a:a426:bb4a])
 (user=drosen job=sendgmr) by 2002:a25:6583:0:b0:b8e:efd8:f2c with SMTP id
 z125-20020a256583000000b00b8eefd80f2cmr1995609ybb.1.1683336713910; Fri, 05
 May 2023 18:31:53 -0700 (PDT)
Date:   Fri,  5 May 2023 18:31:34 -0700
In-Reply-To: <20230506013134.2492210-1-drosen@google.com>
Mime-Version: 1.0
References: <20230506013134.2492210-1-drosen@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230506013134.2492210-6-drosen@google.com>
Subject: [PATCH bpf-next v3 5/5] selftests/bpf: Accept mem from dynptr in
 helper funcs
From:   Daniel Rosenberg <drosen@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This ensures that buffers retrieved from dynptr_data are allowed to be
passed in to helpers that take mem, like bpf_strncmp

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c |  1 +
 .../selftests/bpf/progs/dynptr_success.c      | 21 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index 13d4b9ab16e7..7cfac53c0d58 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -27,6 +27,7 @@ static struct {
 	{"test_dynptr_is_rdonly", SETUP_SKB_PROG},
 	{"test_dynptr_clone", SETUP_SKB_PROG},
 	{"test_dynptr_skb_no_buff", SETUP_SKB_PROG},
+	{"test_dynptr_skb_strcmp", SETUP_SKB_PROG},
 };
 
 static void verify_success(const char *prog_name, enum test_setup_type setup_type)
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index d299ef3b4d1f..0c053976f8f9 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -522,3 +522,24 @@ int test_dynptr_skb_no_buff(struct __sk_buff *skb)
 
 	return !!data;
 }
+
+SEC("?cgroup_skb/egress")
+int test_dynptr_skb_strcmp(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	char *data;
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr)) {
+		err = 1;
+		return 1;
+	}
+
+	/* This may return NULL. SKB may require a buffer */
+	data = bpf_dynptr_slice(&ptr, 0, NULL, 10);
+	if (data) {
+		bpf_strncmp(data, 10, "foo");
+		return 1;
+	}
+
+	return 1;
+}
-- 
2.40.1.521.gf1e218fcd8-goog

