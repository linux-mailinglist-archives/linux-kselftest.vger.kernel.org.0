Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1114563C155
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 14:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbiK2Nmq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 08:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbiK2Nmm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 08:42:42 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE56CD9;
        Tue, 29 Nov 2022 05:42:41 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 21so582006pfw.4;
        Tue, 29 Nov 2022 05:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWgzPCN8Q8JJvLGyk+AfDc4+Pr2IKHYLQIGU3p2/Eyc=;
        b=BtUdQ/YrfKkfQWaSDfBvaODunvTWCMHK8yeZbWrXkeF1l7A2dA8C89gFYEIOhDco+w
         5SIgxYcXLU2lAQ3fMbdozLQDSLYfJpoXeJ1psqvAUnPjBKhp8F7ait4O63BDO7W//21C
         T/RxWAWNN8+sNh6tugIKmZcMAFavWxesn65Uy8SY0epvCn5B3Ke3B/grzEFssIcX/ICs
         +wxovN0tlde7dirjW2vAN7tqeGIi29dAGPX59rsxZbee4CJ6sJdlk1oXq/ZVHtpBZcIw
         HgyrWazLv/5EBkJaPkXDJ+2PrpDiJb8fI8PfF8SJeP5KXd71Axm49P6/GBJLAI4pMpDx
         8JOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWgzPCN8Q8JJvLGyk+AfDc4+Pr2IKHYLQIGU3p2/Eyc=;
        b=EJP8B3hQsOGzWMTG0OIDlDRsgvosp5dewY20uWWn/6l2Pft0nMLRlYyFAgrNYG5WPU
         8Pe3yXchLWVvStypzS8K4OIOwiJt22nmTFDOtkW4FBraYerZ2nIi/VpHwsyB7RdJvHKv
         UUmyP79TZRgPFuKflpU04qtFixYQgQBNA1oBAn8IVad4OS/0FkL5JJX/0Q0FSvCn0xE7
         geqcTfOsAzRjtYQnr5jC27oH74Zev9gLNijfUQpe9Jw7s/wGeJ4/J5UsAJssWUB+agX4
         2u3qNQDkIo1MQ1xr4Qv+XqSswXoH0Yg6E0s8q0iKlu/l/c74tdNHN67oKiCg9rv/s2Hy
         qwdg==
X-Gm-Message-State: ANoB5pnfoEIeebv7XWC1iGZXfvGtf6qXd6S3Gd8cD6WV+xBrgOXhL3Hb
        UTE3SWy2GuAL6h91hT3dUOjQIgZC6VJ7Ax+1
X-Google-Smtp-Source: AA0mqf5luj3p6rEW5gGWKIlJAniQkXeu8Yx16U5z/f587SkgktvBjIX4Ann7mlJl/OJp+H4XLIJMwQ==
X-Received: by 2002:a63:1601:0:b0:46f:9193:467d with SMTP id w1-20020a631601000000b0046f9193467dmr42215366pgl.479.1669729360674;
        Tue, 29 Nov 2022 05:42:40 -0800 (PST)
Received: from WRT-WX9.. ([103.135.102.183])
        by smtp.gmail.com with ESMTPSA id z5-20020aa79f85000000b005636326fdbfsm9977154pfr.78.2022.11.29.05.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 05:42:40 -0800 (PST)
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
Subject: [PATCH v2 1/2] libbpf: show error info about missing ".BTF" section
Date:   Tue, 29 Nov 2022 21:42:16 +0800
Message-Id: <20221129134217.52767-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221129134217.52767-1-changbin.du@gmail.com>
References: <20221129134217.52767-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Show the real problem instead of just saying "No such file or directory".

Now will print below info:
libbpf: can not find '.BTF' section
Error: failed to load BTF from /home/changbin/work/linux/vmlinux: No such file or directory

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/lib/bpf/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index d88647da2c7f..1adc0f6019a0 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -990,6 +990,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 	err = 0;
 
 	if (!btf_data) {
+		pr_warn("can not find '%s' section\n", BTF_ELF_SEC);
 		err = -ENOENT;
 		goto done;
 	}
-- 
2.37.2

