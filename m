Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8855A1E23
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 03:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244340AbiHZB0o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Aug 2022 21:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244329AbiHZB0n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Aug 2022 21:26:43 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249C826AD0;
        Thu, 25 Aug 2022 18:26:42 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w196so309107oiw.10;
        Thu, 25 Aug 2022 18:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Q9c5ppcQB9W//6zImGUwfyIWbq0TZVw85bOZv6AgO/c=;
        b=EYQ19EqEQEKT3No0Fvv9DGZWx9DwmEmN9uigubTSCRtMMR6pJiDlxuHZFSlRvOKWwf
         +MXTWSP4dI7k1i39JxMkLvMoWGlL4xX4KeZgyqi62tDTqcpS30FYDofgxVEdeidKcGIw
         T5fx5byWwsblG8BHqXoDJsAJrSDPDo8KozfdmSUGE4b4hAgdK/qP5RbAftzSMI1kAx3r
         YtjuQyY85BRkvRcqEVOFJU7AMo8yIYkfJKzqxUQAzAhCKERWMfM3zsy9xTZdccDrEOYK
         LRk9rN7dsQ+64rcWIYuF01YjAvZJ/F2UmkTk79W/gSaTGUTvthIDx/1GHAHa7vTJr6Kx
         BqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Q9c5ppcQB9W//6zImGUwfyIWbq0TZVw85bOZv6AgO/c=;
        b=XRZg3rVhSUAa3Qbi983kby3HYzRiaNSv7yx/EqO/k7htjBzV+TeKEgurWSiHcM5RG5
         yFz0f/uB5b3DdNPLpwHHfh2xrpGqZyVnMY8py6hnz5J7xmnH8eX6K31Rk//nwwKSC7yR
         w7qO9XdPdeqM7s6wC0AdCFt3P3lx3OGQDjvrlZ1KNYGdh5j+OrM219dtPs+A0oW+njd0
         hOy5BouiDf5c5pXQ8MrwfL7CxIFNaZjvr/k7kSiPjFyjYhww3sHUEKOlkfT784w0Vyfw
         cKO1mkVy6jbeCe1a8ghZnmY08nvnnQRmvpouR6YD+gMohTkJS7m32Y6ZIIbM9xEjZyi0
         mM0A==
X-Gm-Message-State: ACgBeo1BhtL8QsHMtIepDj/s6chrFRM60orfC6ncqWQTvwwVM02aEX/R
        nJPRQRKo56T9t0aiTOlSWnwTIm/mqmhJqQ==
X-Google-Smtp-Source: AA6agR4CcEcf2TcG7NX5MDndjJIUloqhSjEP+837n5q915EDbBYiP8cBy0m/Cl/xusq8ot6BrF3koQ==
X-Received: by 2002:a05:6808:1c06:b0:33a:9b3b:b3ce with SMTP id ch6-20020a0568081c0600b0033a9b3bb3cemr660676oib.53.1661477200803;
        Thu, 25 Aug 2022 18:26:40 -0700 (PDT)
Received: from james-x399.localdomain (71-33-138-207.hlrn.qwest.net. [71.33.138.207])
        by smtp.gmail.com with ESMTPSA id t38-20020a05687063a600b0011bde9f5745sm484465oap.23.2022.08.25.18.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 18:26:40 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     bpf@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: Fix conflicts with built-in functions in bpf_iter_ksym
Date:   Thu, 25 Aug 2022 19:26:11 -0600
Message-Id: <20220826012614.552860-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Both tolower and toupper are built in c functions, we should not
redefine them as this can result in a build error.

Fixes the following errors:
progs/bpf_iter_ksym.c:10:20: error: conflicting types for built-in function 'tolower'; expected 'int(int)' [-Werror=builtin-declaration-mismatch]
   10 | static inline char tolower(char c)
      |                    ^~~~~~~
progs/bpf_iter_ksym.c:5:1: note: 'tolower' is declared in header '<ctype.h>'
    4 | #include <bpf/bpf_helpers.h>
  +++ |+#include <ctype.h>
    5 |
progs/bpf_iter_ksym.c:17:20: error: conflicting types for built-in function 'toupper'; expected 'int(int)' [-Werror=builtin-declaration-mismatch]
   17 | static inline char toupper(char c)
      |                    ^~~~~~~
progs/bpf_iter_ksym.c:17:20: note: 'toupper' is declared in header '<ctype.h>'

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_iter_ksym.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
index 285c008cbf9c..9ba14c37bbcc 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
@@ -7,14 +7,14 @@ char _license[] SEC("license") = "GPL";
 
 unsigned long last_sym_value = 0;
 
-static inline char tolower(char c)
+static inline char to_lower(char c)
 {
 	if (c >= 'A' && c <= 'Z')
 		c += ('a' - 'A');
 	return c;
 }
 
-static inline char toupper(char c)
+static inline char to_upper(char c)
 {
 	if (c >= 'a' && c <= 'z')
 		c -= ('a' - 'A');
@@ -54,7 +54,7 @@ int dump_ksym(struct bpf_iter__ksym *ctx)
 	type = iter->type;
 
 	if (iter->module_name[0]) {
-		type = iter->exported ? toupper(type) : tolower(type);
+		type = iter->exported ? to_upper(type) : to_lower(type);
 		BPF_SEQ_PRINTF(seq, "0x%llx %c %s [ %s ] ",
 			       value, type, iter->name, iter->module_name);
 	} else {
-- 
2.34.1

