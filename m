Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161A46F8D90
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 May 2023 03:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjEFBbx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 May 2023 21:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjEFBbs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 May 2023 21:31:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F8E3C27
        for <linux-kselftest@vger.kernel.org>; Fri,  5 May 2023 18:31:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a8023ccf1so4523367276.2
        for <linux-kselftest@vger.kernel.org>; Fri, 05 May 2023 18:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683336706; x=1685928706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R3tTNtfHOhWvElfdge4+T7awt+4BFTOV0To4APlP4VI=;
        b=7uw3sMiHaRo71h8mPrgXfL1Zc559Ocw6g7SE4eck4f3ZNQAarAfVzn9doI001uk/w7
         aRsEZW71tZJ8pqDUw5rKukPyRa/h9LZCd7YlL3yPVt64BDTY5Kp+5vTt8b6WHqjeDkMf
         wRAhmPjtcREiV3q4ig4Phzn7ay9XHjmfLftjlr7uTmNbnH7igSmMvrmBL+9xGZ79UtLM
         Y2Q+SUQXre5JdReUY2TEIeW6xxHmLIEYBBdUQnhaoVkXE7+Yr3zYKKKLBdq+XdxVdkAj
         HE+m2ALtPr0ES/v+PIVZ60cZilBie6wI4OWEk0DDHgp4LtaXFBld0+DCHu731r1x2zqa
         raIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683336706; x=1685928706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3tTNtfHOhWvElfdge4+T7awt+4BFTOV0To4APlP4VI=;
        b=bY6S45zYad+bMBmTVlRkmx+OKeY+MuoxeL4gCW7skpPHkPQWZ67W4DCiIigs51tUMc
         ib/kgLRaxzbjS0RWZ4WSfkSrIBktFc3oVWBzEyFnVFVY5lFAal5pnatAzLL0eg98Bw92
         2Rw0VnxrKkSoPSKquclbG6fMTDb1Yw0b7rnQwhNMrHjkUTAdAVVxIgWpHEk43Zfm9rH3
         SWEXaS4AFhqzDBIDpKkz6EGdoDVq7gTqkw0B+jDJhpFB8a8Ui+htlF0NsmqbIMERWcNm
         JTKYmMdZxKodL4xrmKjVqk/hKbG1bJ+BPooU24na08D0URi+uCeXDIKRtw/lgWBiP3UY
         kKNg==
X-Gm-Message-State: AC+VfDwGIVDzaApNz02BjlM7PtjtAnXIfCcdAB0QhUoHtZ0eKFzjE108
        K+rqfKcdwYfH3E+kXsKzxoGNQrp9NtI=
X-Google-Smtp-Source: ACHHUZ5sEHQEXSZOMI2fZpHGP8PwNi2cmHJ4+0FJdfCW76FEKiitkn7SABL6ne8pqSXss8RDFZ9X+dcg3eM=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:6826:a1a:a426:bb4a])
 (user=drosen job=sendgmr) by 2002:a25:500f:0:b0:b9e:930b:1b62 with SMTP id
 e15-20020a25500f000000b00b9e930b1b62mr2104563ybb.12.1683336706774; Fri, 05
 May 2023 18:31:46 -0700 (PDT)
Date:   Fri,  5 May 2023 18:31:31 -0700
In-Reply-To: <20230506013134.2492210-1-drosen@google.com>
Mime-Version: 1.0
References: <20230506013134.2492210-1-drosen@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230506013134.2492210-3-drosen@google.com>
Subject: [PATCH bpf-next v3 2/5] selftests/bpf: Test allowing NULL buffer in
 dynptr slice
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

bpf_dynptr_slice(_rw) no longer requires a buffer for verification. If the
buffer is needed, but not present, the function will return NULL.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 tools/testing/selftests/bpf/prog_tests/dynptr.c |  1 +
 .../selftests/bpf/progs/dynptr_success.c        | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index 0478916aff37..13d4b9ab16e7 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -26,6 +26,7 @@ static struct {
 	{"test_dynptr_is_null", SETUP_SYSCALL_SLEEP},
 	{"test_dynptr_is_rdonly", SETUP_SKB_PROG},
 	{"test_dynptr_clone", SETUP_SKB_PROG},
+	{"test_dynptr_skb_no_buff", SETUP_SKB_PROG},
 };
 
 static void verify_success(const char *prog_name, enum test_setup_type setup_type)
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index be7de62de045..d299ef3b4d1f 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -505,3 +505,20 @@ int test_dynptr_clone(struct __sk_buff *skb)
 
 	return 0;
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
2.40.1.521.gf1e218fcd8-goog

