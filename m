Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E766ABE0C
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 12:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjCFLVv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 06:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjCFLVt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 06:21:49 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8690E2448A
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Mar 2023 03:21:47 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h11so8412033wrm.5
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Mar 2023 03:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1678101706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFoPMccumpB7Jg6MG/+Y9XEhQvfr9CtFnuJx3l1V4DE=;
        b=d8mXmXI3nA2pSmxPOcpNa0FlSQv089G1qG8NhyBEUzH7S6WGN7qoymBEwZFuPSe6b+
         2x2/EwY+qEWka9m1n7nfmP/FNT3edecUvZnVWcEcHXCyJa3r6RX/lybe6q3lZC0eWLyY
         awsfaHqKxSUwmGhYEM840o56zqy6r11AmjU1759Ax849jgoCSXJn+9FNzQaCGDp5P6SZ
         sZytn+bo3cwrKmLZDo1CAYSuzhuoZQBPbDydT7zLK1KA4zapzlKfoFu6PCwd9/HZZlIW
         QVl+vfpLVJ0z+aWko6MBsTeluzPvma1unkilApssCEN+jWPhoVzQalLL40z1dVusXSgd
         aD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678101706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFoPMccumpB7Jg6MG/+Y9XEhQvfr9CtFnuJx3l1V4DE=;
        b=Bx+6j9a5jM4kSg9Fxw/5baGYUj/3ru0s8Jejrsw1V+6KjsB2Nd6+x1zd+yxB2z+R1z
         kPiMxUefOdHVjyXZnqYAHN9oI5ugxYG3+Zk/greHaaePkfe8CM4Xxp5+bSnZ7a1cew6Q
         FJy9iBxJF82ySqlWHdDeZ9megXXSMT2vyfWFIz2Daf5i8MwsoPTvfAXMITYiTZpkN8dt
         Pyzwx49GsRNWljjXGQYT99RA30JTq8twJ+6pSXqFgjIFJq3lKCVXJZxeEQyn0zzUmlE4
         sJ4WZMylHCDktaP5mkmnRiVbCSswpCUhEFiq7tl6i4BkhcEXSahRio66T/tdPvUIWVZ0
         W8DQ==
X-Gm-Message-State: AO0yUKXyV3fGMo5sbTYGcaZVZUP1n9xVR9XF+w4KraMjtkO/G1FPLrW6
        T0MwoLifATWRVB3ux07Q3nN7Xw==
X-Google-Smtp-Source: AK7set+Zu3b69i/KACJqyI3EmGDipLz+Du2Ldc2ipOzZBaSMCZeO6VIhMXQkvi9mRGC2wHk5+jm3nQ==
X-Received: by 2002:a05:6000:1109:b0:2c9:9147:a710 with SMTP id z9-20020a056000110900b002c99147a710mr6968458wrw.43.1678101706049;
        Mon, 06 Mar 2023 03:21:46 -0800 (PST)
Received: from tpx1.lan (f.c.7.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::7cf])
        by smtp.gmail.com with ESMTPSA id j4-20020adfff84000000b002cda9aa1dc1sm9604854wrr.111.2023.03.06.03.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 03:21:45 -0800 (PST)
From:   Lorenz Bauer <lorenz.bauer@isovalent.com>
X-Google-Original-From: Lorenz Bauer <lmb@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc:     Lorenz Bauer <lmb@isovalent.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2 2/2] selftests/bpf: check that modifier resolves after pointer
Date:   Mon,  6 Mar 2023 11:21:38 +0000
Message-Id: <20230306112138.155352-3-lmb@isovalent.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306112138.155352-1-lmb@isovalent.com>
References: <20230306112138.155352-1-lmb@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a regression test that ensures that a VAR pointing at a
modifier which follows a PTR (or STRUCT or ARRAY) is resolved
correctly by the datasec validator.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 28 ++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index cbb600be943d..210d643fda6c 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -879,6 +879,34 @@ static struct btf_raw_test raw_tests[] = {
 	.btf_load_err = true,
 	.err_str = "Invalid elem",
 },
+{
+	.descr = "var after datasec, ptr followed by modifier",
+	.raw_types = {
+		/* .bss section */				/* [1] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 2),
+			sizeof(void*)+4),
+		BTF_VAR_SECINFO_ENC(4, 0, sizeof(void*)),
+		BTF_VAR_SECINFO_ENC(6, sizeof(void*), 4),
+		/* int */					/* [2] */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),
+		/* int* */					/* [3] */
+		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_PTR, 0, 0), 2),
+		BTF_VAR_ENC(NAME_TBD, 3, 0),			/* [4] */
+		/* const int */					/* [5] */
+		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_CONST, 0, 0), 2),
+		BTF_VAR_ENC(NAME_TBD, 5, 0),			/* [6] */
+		BTF_END_RAW,
+	},
+	.str_sec = "\0a\0b\0c\0",
+	.str_sec_size = sizeof("\0a\0b\0c\0"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = ".bss",
+	.key_size = sizeof(int),
+	.value_size = sizeof(void*)+4,
+	.key_type_id = 0,
+	.value_type_id = 1,
+	.max_entries = 1,
+},
 /* Test member exceeds the size of struct.
  *
  * struct A {
-- 
2.39.2

