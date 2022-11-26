Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E276395A6
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Nov 2022 12:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiKZLOH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 26 Nov 2022 06:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKZLNh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 26 Nov 2022 06:13:37 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F281B7A2;
        Sat, 26 Nov 2022 03:13:35 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id io19so6042804plb.8;
        Sat, 26 Nov 2022 03:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9w1lPUfY/wiQo03hcSs2vhx8gqp1sMdSqvVAhkIK+mo=;
        b=R+/9KRHijwhpVJ3TK9Mhzp1avdAR4N6nBhWJmUbbdMX8pU9GAZGyZkfOY0xqA2JsSP
         v1+qtcKBiliuFh7+TX0L9LgUdYAeLw1fBIIrRcyUgfciwXbnPOC8inUIB/bT94s7CRlE
         XvnGuJd7IQFce9DIvEsC5bWwNE2wxX8f1swU1WxtUJKdAv/qJPlXSRm6Ch3Yew7qqj/d
         OwYl8CrNB3h0lTBmqGoJDHmkG4jNs9OJ8GXjUBe1wQy8yZkvcf8VFaD8UKMl9ql0P+KG
         yAwxR4pPhsOHt+rMKjKAMb4QqDhf03/Inmnbry1YihaAB/FFdIdmfcYzIL6hDLrkE8gY
         fW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9w1lPUfY/wiQo03hcSs2vhx8gqp1sMdSqvVAhkIK+mo=;
        b=lwfE/lZFad8eb9LontiOgwjIIfNW4bJKJux0QRcOc7QRVGMVnGVI1z0zTIBKIo6Oeh
         qEAiEq6yKzeQa3iLY+oB/o/wU83oS8PphKCOgT+30nQZd1m7LVPYNGYW3wfrXF1H4Ibj
         nbUS7OMM9zgDTTvgVbMkq8eZKWovZOASZ27UiLaVHMvgHvdOGWx/d7mF4D2aCh1hKvoZ
         0r5SqhViddmVYWgT230QiWplprwnXiJqS6zehkQYTukEjpuyNF8xbXVxYmWOOChzKWYB
         E/NWDyUa/Aho2uzDC3JcobZRbXvXopcFCyyt65sHhnahoC1QAgkKFiIkSNScfhmNzQil
         2maA==
X-Gm-Message-State: ANoB5plFfvIB/5oKvQT1ePmrj4Dj0DdyO032GbQQNmLXf6SLKBle9cOm
        bXl2SA5OOKiPUDmEoX67zNk=
X-Google-Smtp-Source: AA0mqf6jUU7sfY2okUnC7R+t+mkvGRoqfmwxzGo9YTshb9ohc3bSJEU0nantTMsHf/7CVewnAiL6Iw==
X-Received: by 2002:a17:90a:8d13:b0:213:c15:6f08 with SMTP id c19-20020a17090a8d1300b002130c156f08mr44241036pjo.134.1669461214986;
        Sat, 26 Nov 2022 03:13:34 -0800 (PST)
Received: from WRT-WX9.. ([103.135.102.183])
        by smtp.gmail.com with ESMTPSA id c194-20020a621ccb000000b0056a93838606sm4555639pfc.58.2022.11.26.03.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 03:13:34 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 1/2] libbpf: show more info about missing ".BTF" section
Date:   Sat, 26 Nov 2022 19:11:46 +0800
Message-Id: <20221126111147.199366-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221126111147.199366-1-changbin.du@gmail.com>
References: <20221126111147.199366-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Show more information about why failed instead of just saying "No such file or
directory".

Now will print below info:
libbpf: can not find '.BTF' section
libbpf: is CONFIG_DEBUG_INFO_BTF enabled for kernel?
Error: failed to load BTF from /home/changbin/work/linux/vmlinux: No such file or directory

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/lib/bpf/btf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index d88647da2c7f..3f661d991808 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -906,6 +906,15 @@ struct btf *btf__new(const void *data, __u32 size)
 	return libbpf_ptr(btf_new(data, size, NULL));
 }
 
+static bool is_vmlinux(const char *path)
+{
+	size_t path_len = strlen(path);
+	size_t suffix_len = strlen("vmlinux");
+
+	return (path_len >= suffix_len) &&
+	       (!memcmp(path + path_len - suffix_len, "vmlinux", suffix_len));
+}
+
 static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 				 struct btf_ext **btf_ext)
 {
@@ -990,6 +999,9 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 	err = 0;
 
 	if (!btf_data) {
+		pr_warn("can not find '%s' section\n", BTF_ELF_SEC);
+		if (is_vmlinux(path))
+			pr_warn("is CONFIG_DEBUG_INFO_BTF enabled for kernel?\n");
 		err = -ENOENT;
 		goto done;
 	}
-- 
2.37.2

