Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABB264FC9B
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Dec 2022 23:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiLQWgO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 17 Dec 2022 17:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQWgN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Dec 2022 17:36:13 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF41BE14;
        Sat, 17 Dec 2022 14:36:12 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id g10so5621187plo.11;
        Sat, 17 Dec 2022 14:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csOYqUeHxLTPATSvh1AYSJ+5CbE6leQVeEwGWs1d3Xo=;
        b=He++fKLMtJ04Vk25015fW8A0NJ8KRu99gIF1BTTRykv8EzUagWxTXz3MEeBgkLXxwD
         s+9B/nxa03WYn8pRGvfAO8zzYUXyjfV+97bQ/mCKRqI8MEnNmbd9CGlULvwskidKW5qb
         NQlQkvWqh41Q+CedAtmO+tchfXb6ODRQyw4VjJvOqmjzMrOe3yHRh9n0xhmgDSKSzbYf
         LNVExJuH4Rs8Oc83LDOVgnXE3my1czOzwBgyHm1FXye2NIDHgRWMjSN9bj82lzRsHgO+
         NN6X1Ofy8S0w7oGfpsY+ZrGouBKhhYj6N3ofygeAHvoSv93+0CCl+LwV87olFCWcm9br
         F6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csOYqUeHxLTPATSvh1AYSJ+5CbE6leQVeEwGWs1d3Xo=;
        b=LAxNbKdCXPuV0FBvdQjHnYhuOHUW1OvvuUwUBiFeecoLNdVEnKfg4fNslA98NLJPbO
         7vs5ViqQvgSAr7DmrKWgCkVpnIsHcFljtk71TNNrx0EtlZxhlwIK1d2zpiabEvNuVhwE
         FJbDVOlGGFi8y6AY0DrnsNAAmuI3KU3e7sPnfmh7+w5KidH+ow+odXmZtKHjJlG15Pr3
         831XdGQJ2EQmksRO/BDN9uwxJCIAOb29e4tSwo1Xycp62B4cQlGa9PGysekkp9gRxszg
         tBX8xBc+tggUwBSKn2mK+x0Sf9BziR1cW1Uj9KI5NUHZJcZrJbFQjK5s8vH3dVoDWtTu
         M9mw==
X-Gm-Message-State: AFqh2koYk409PHIMFDT3TKYBkT3mU6Y4oOF8ftcVzUsgJSCNFm3uTGbU
        ZgEXxtp/kb0wRiNDTg2a++I=
X-Google-Smtp-Source: AMrXdXu/qWZVQq6iNS+YiLhbTIdOPTzdfgk7QS2/w500GDjL4ns+7wij9Fmik24v7qWavcALSpX5xg==
X-Received: by 2002:a17:902:f607:b0:186:8d78:740c with SMTP id n7-20020a170902f60700b001868d78740cmr4895147plg.6.1671316571561;
        Sat, 17 Dec 2022 14:36:11 -0800 (PST)
Received: from WRT-WX9.. ([103.135.102.144])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b001801aec1f6bsm4031660ple.141.2022.12.17.14.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 14:36:10 -0800 (PST)
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
Subject: [PATCH v3 1/2] libbpf: show error info about missing ".BTF" section
Date:   Sun, 18 Dec 2022 06:35:08 +0800
Message-Id: <20221217223509.88254-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221217223509.88254-1-changbin.du@gmail.com>
References: <20221217223509.88254-1-changbin.du@gmail.com>
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

Show the real problem instead of just saying "No such file or directory".

Now will print below info:
libbpf: failed to find '.BTF' ELF section in /home/changbin/work/linux/vmlinux
Error: failed to load BTF from /home/changbin/work/linux/vmlinux: No such file or directory

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/lib/bpf/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 71e165b09ed5..dd2badf1a54e 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -990,6 +990,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 	err = 0;
 
 	if (!btf_data) {
+		pr_warn("failed to find '%s' ELF section in %s\n", BTF_ELF_SEC, path);
 		err = -ENOENT;
 		goto done;
 	}
-- 
2.37.2

