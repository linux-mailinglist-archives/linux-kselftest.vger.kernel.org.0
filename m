Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97ED76D8C0C
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 02:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbjDFAkw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Apr 2023 20:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbjDFAkt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Apr 2023 20:40:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CAE7A94
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Apr 2023 17:40:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 192-20020a250dc9000000b00b8bf38f0643so1047508ybn.11
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Apr 2023 17:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680741640;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=McDcXFBeTpRROxQUqMA2pgjkFzg3DM0Jer8s1DpCFu0=;
        b=k6n8mW0A9t/ctuMHEzGCgb/5wxgpyQ5jaCdkYx8TZ1jyPWjcmMfd4/5a7xdPJ7enxv
         i6p2+isHp8Qg0KGWx3DnJa0nLQYm67mK4V+T+/O2O8Jw4X04X0osjYtQZhCU08gXjXCk
         rNfSEiCcH5hxmP3Okc/9TNGb7EbYdpnTgsgC8rOB5fsWJe86pmDimQ4/JHFfmt2JWfIT
         4+w0KwFg97MC7sTzOC2YFeE/SaejQBNBB5gDhyf0sIpuKngXGnqbp3Vms59AB6YDcSz7
         +bbmEnegVj8U592jfJ8TMuMw1MuZwJaGllugkf5y692Kw8YYrTXZJuDKUmdg9D9nBWcd
         0WnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680741640;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=McDcXFBeTpRROxQUqMA2pgjkFzg3DM0Jer8s1DpCFu0=;
        b=YDlYdxF/erjSqOKDWaLjSYpgp7E+OUSYvZa9Wol/f0VDYrBwovgJAJZRQwXpXuF6HE
         AkxplscSBiWPdDVv2JjQXVFkoQsIt7epc+vcokxoY/SEqBRq9NXNAbGsnyrKFNz0c8FP
         D4Y1OMXv65Prd8HTBST6RvUwRgCPtlHLE3evQ4iseVM1KYMCYyuIUjhqfWp7H7C50Drn
         U69Pz29SALOEBP9fbSc9+hO5Wh99xeqBLVHTGovylBHLnFv1LkSjTQh5FLBroaRb7lME
         gtOB66k4rXO8SAOVMzxB7Tl+NTky7diDMHg4eExTordLVeDREgcOzcdQs2ziDxFGOUWl
         xfuw==
X-Gm-Message-State: AAQBX9c4+XJetNYbo2SdxoTXZkYJPgA0Zqb4dhy56S3v/yWsap6PQ1o/
        c40LTZJMNj6PyRpGJypJMbHizZyO0wc=
X-Google-Smtp-Source: AKy350bPNIOIE//zV7JizIt83+G0W/fEKuaqLntA2Yk+VZnnixxP6m5jp+KnUzV7Yr3N1wuiNhnbMicZVAs=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:694f:f21b:c6de:aead])
 (user=drosen job=sendgmr) by 2002:a81:b609:0:b0:541:8995:5334 with SMTP id
 u9-20020a81b609000000b0054189955334mr4835018ywh.3.1680741640430; Wed, 05 Apr
 2023 17:40:40 -0700 (PDT)
Date:   Wed,  5 Apr 2023 17:40:16 -0700
In-Reply-To: <20230406004018.1439952-1-drosen@google.com>
Mime-Version: 1.0
References: <20230406004018.1439952-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230406004018.1439952-2-drosen@google.com>
Subject: [PATCH 1/3] bpf: verifier: Accept dynptr mem as mem in helpers
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
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This allows using memory retrieved from dynptrs with helper functions
that accept ARG_PTR_TO_MEM. For instance, results from bpf_dynptr_data
can be passed along to bpf_strncmp.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 56f569811f70..20beab52812a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7164,12 +7164,16 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	 * ARG_PTR_TO_MEM + MAYBE_NULL is compatible with PTR_TO_MEM and PTR_TO_MEM + MAYBE_NULL,
 	 * but ARG_PTR_TO_MEM is compatible only with PTR_TO_MEM but NOT with PTR_TO_MEM + MAYBE_NULL
 	 *
+	 * ARG_PTR_TO_MEM is compatible with PTR_TO_MEM that is tagged with a dynptr type.
+	 *
 	 * Therefore we fold these flags depending on the arg_type before comparison.
 	 */
 	if (arg_type & MEM_RDONLY)
 		type &= ~MEM_RDONLY;
 	if (arg_type & PTR_MAYBE_NULL)
 		type &= ~PTR_MAYBE_NULL;
+	if (base_type(arg_type) == ARG_PTR_TO_MEM)
+		type &= ~DYNPTR_TYPE_FLAG_MASK;
 
 	if (meta->func_id == BPF_FUNC_kptr_xchg && type & MEM_ALLOC)
 		type &= ~MEM_ALLOC;
-- 
2.40.0.577.gac1e443424-goog

