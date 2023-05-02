Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242946F3B7F
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 May 2023 02:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjEBAwb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 May 2023 20:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEBAw3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 May 2023 20:52:29 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FEB3584
        for <linux-kselftest@vger.kernel.org>; Mon,  1 May 2023 17:52:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-559df49dbf3so62194917b3.3
        for <linux-kselftest@vger.kernel.org>; Mon, 01 May 2023 17:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682988747; x=1685580747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jcg+ObY0uKE7Plv6+Kj2nIBfbZ7utIjukDPBrr4BYWc=;
        b=rYQSqPKozvop6FQA27tCKPMMocl2dT4bgtQrMsrykc/YWbzOREznkvJfsptxQWgLxw
         oO82Zx1edFTqiTXXK/v5aDAXURCmJ09vOhY+vO5I8xtNxt5WFfCp4m5EUphT4ZHKU3Ft
         VupyzUAvpbAYLoLeLRDy5Y2ZGrbi2CofICiADgLD0ZZ2tipa6AdBZVKxCySj9R6/+Uf+
         8M3XGSk9xQkov8XEL0PlXN3zdY6R2i+mz4kElqdnEh26AjfBdSb4khtwrKSf2QgJWFSa
         fs7UWy1gT0U988Ct3W6zTiWBgoi0XDTR/tJcLEWFxiVuuK8bqE/F4nznvKj0C9Zotm+B
         P5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682988747; x=1685580747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jcg+ObY0uKE7Plv6+Kj2nIBfbZ7utIjukDPBrr4BYWc=;
        b=eDG910pF5RiDjuQr7dyFiZ6jiJEBaT6MJdmpq4fn/hll7mHX5N2MG8Y5ea5jz/DLg5
         K3m1q9tiTFhfuLKpps3jUhhJOY+XY/iatcU/h90HPnSUWcla96ClyqlX8emuIGRVjG/o
         zDPUT9QpOHt20mzvRbgg8JN4jM2hif6HQ2kei/MLyfM+zju5WVLLO3qYQEr7hiZ/EOcT
         eQ8k6dqF7WtVLXO8QwRIzk1nucdLWlAbw0TWVIzMNYrHG/9ljz6a2hQMGyXIyNfKFdGX
         5AtqHBz3TBJheCGQDE6DDPuLjCL/OGkWe4MvP/IyuGS9lPkCpZ7Ik5CEUZWuDiqM7P1X
         L7nA==
X-Gm-Message-State: AC+VfDxTXFb+V0vwmU972AVgvILnzQNpnb+kqm/+tXdcCU5skJ/a+L4V
        xVvyYsmKZ8N0OHkcLI9yS3D37lcSPpQ=
X-Google-Smtp-Source: ACHHUZ60Cpj1S0W+yNjZ+/1Bv5rIXv4w+qbwVSj8aJJ1+U1DafFfffYkJPJ9kC3zAgNVLJaeYWBqlX/tWOk=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:908a:598a:7b5a:d40b])
 (user=drosen job=sendgmr) by 2002:a05:690c:725:b0:54f:bb71:c7b3 with SMTP id
 bt5-20020a05690c072500b0054fbb71c7b3mr9297919ywb.9.1682988747604; Mon, 01 May
 2023 17:52:27 -0700 (PDT)
Date:   Mon,  1 May 2023 17:52:17 -0700
In-Reply-To: <20230502005218.3627530-1-drosen@google.com>
Mime-Version: 1.0
References: <20230502005218.3627530-1-drosen@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230502005218.3627530-2-drosen@google.com>
Subject: [PATCH v2 2/3] selftests/bpf: Test allowing NULL buffer in dynptr slice
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

bpf_dynptr_slice(_rw) no longer requires a buffer for verification. If the
buffer is needed, but not present, the function will return NULL.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 tools/testing/selftests/bpf/prog_tests/dynptr.c |  1 +
 .../selftests/bpf/progs/dynptr_success.c        | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index d176c34a7d2e..ac1fcaddcddf 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -20,6 +20,7 @@ static struct {
 	{"test_ringbuf", SETUP_SYSCALL_SLEEP},
 	{"test_skb_readonly", SETUP_SKB_PROG},
 	{"test_dynptr_skb_data", SETUP_SKB_PROG},
+	{"test_dynptr_skb_no_buff", SETUP_SKB_PROG},
 };
 
 static void verify_success(const char *prog_name, enum test_setup_type setup_type)
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index b2fa6c47ecc0..16636a29242a 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -207,3 +207,20 @@ int test_dynptr_skb_data(struct __sk_buff *skb)
 
 	return 1;
 }
+
+SEC("?cgroup_skb/egress")
+int test_dynptr_skb_no_buff(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	__u64 *data;
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr)) {
+		err = 1;
+		return 1;
+	}
+
+	/* This may return NULL. SKB may require a buffer */
+	data = bpf_dynptr_slice(&ptr, 0, NULL, 1);
+
+	return !!data;
+}
-- 
2.40.1.495.gc816e09b53d-goog

