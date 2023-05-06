Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945626F8D92
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 May 2023 03:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjEFBb6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 May 2023 21:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjEFBbv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 May 2023 21:31:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAEC49CF
        for <linux-kselftest@vger.kernel.org>; Fri,  5 May 2023 18:31:50 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-55d9a998c5aso20543517b3.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 May 2023 18:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683336709; x=1685928709;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QbTxYJIrfalCYzXyCjhhSUmz67kNheh66aN+akhEHWk=;
        b=WWOk88G3muNiSEyLCZtTBwJIQa2OocJuIlljADwsm82KPk2youo8Bi6hAN/nXReTz0
         7r1uI7jxcjSqbZ92pFC1GjUhvhjNVjuK8o7y0Z//QAswGFhvfniUWRhLj4P18q9LvU8V
         XyQOfhD7n7W/99oHPcNTQokqvOCzPLrYlR7puhjDO/d1m6Mk6UKEtSpSmNeHA/O3TCd2
         oKUZs5gi7Nzjto/r3S5LSTSvgNBNHBCd2hRT0VWn12Qcjs8M0lHnqbGFxux3WL3ApZCM
         1KStVH5+p8h02nzto4SrF74lR+4I0PyarTp6k5Ri8qKg9/8/1guA+bDNz4G0PytGNsQK
         SlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683336709; x=1685928709;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbTxYJIrfalCYzXyCjhhSUmz67kNheh66aN+akhEHWk=;
        b=BkSfKPlJXUUSe59WLstHsJtR8rD6HkQ6eXAH7lXMHSbhlBZAlKgqvquHaukI+u1uD3
         /54DO1/AklmaQ4cie3vrekcANII3FctqmVo8mAKB4+VmUX1DstKva2QZfSmBxvblpkhM
         SpqhI64naNPG+xm+KWR+5Xt7YZb4m0i1JyvpErIuiZ4W6KcLsFaDdqSwSguDzeFnjx/k
         F0niXKMQNjYB8aZEPexXxCXfWbqB3TZ4jzgNQ80St2/Sl/KlhA1uGIyjJhu3kDJYja3R
         bQPkvuKOBE1iYVorFiiLQ6B6pvS5AZtGtwe9YAbTyVudqVHRmjQt4GTq/u7pPLgh7f7C
         OhGQ==
X-Gm-Message-State: AC+VfDyelQCkoxC1RoGehYQQE4TYCRRTpkgUX3f3aoOGlkkEIJh71Hc1
        I1dAm64A/JVoWNQpVoWYfM5OuDj0dkU=
X-Google-Smtp-Source: ACHHUZ6+bMT2qUE8qYexYzBwG/ZiwbW6htxo82gL8HL5nwFwc0TUdqnY1SZ54LMlE1W2qQdKF+FLUEIx5KU=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:6826:a1a:a426:bb4a])
 (user=drosen job=sendgmr) by 2002:a81:4045:0:b0:55a:613d:429f with SMTP id
 m5-20020a814045000000b0055a613d429fmr1922195ywn.2.1683336709283; Fri, 05 May
 2023 18:31:49 -0700 (PDT)
Date:   Fri,  5 May 2023 18:31:32 -0700
In-Reply-To: <20230506013134.2492210-1-drosen@google.com>
Mime-Version: 1.0
References: <20230506013134.2492210-1-drosen@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230506013134.2492210-4-drosen@google.com>
Subject: [PATCH bpf-next v3 3/5] selftests/bpf: Check overflow in optional buffer
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

This ensures we still reject invalid memory accesses in buffers that are
marked optional.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index efe4ce72d00e..c2f0e18af951 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1665,3 +1665,23 @@ int clone_xdp_packet_data(struct xdp_md *xdp)
 
 	return 0;
 }
+
+/* Buffers that are provided must be sufficiently long */
+SEC("?cgroup_skb/egress")
+__failure __msg("memory, len pair leads to invalid memory access")
+int test_dynptr_skb_small_buff(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	char buffer[8] = {};
+	__u64 *data;
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr)) {
+		err = 1;
+		return 1;
+	}
+
+	/* This may return NULL. SKB may require a buffer */
+	data = bpf_dynptr_slice(&ptr, 0, buffer, 9);
+
+	return !!data;
+}
-- 
2.40.1.521.gf1e218fcd8-goog

