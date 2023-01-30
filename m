Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAE8681953
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jan 2023 19:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238083AbjA3SgJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 13:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238010AbjA3SgI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 13:36:08 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60A34C33;
        Mon, 30 Jan 2023 10:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1675103755;
        bh=MvodwzQDiD9u4tU1mzZzSTt7WoVE7au7QH14YGe8X4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X2eDQDq1Br5CuoXxwGvcKHghIEOZa5ltoXKyrlJYa+ijydZX0c3MdwiMxAAuRau3A
         0Ehm/wz8wFuiLL4EjcbgMT1P9Dp0IS3tLnnJjv8Thrm2LObJ6c4PoVOZ3PK4UVD06d
         wvjV3lhfsQoE945Rvi06IkBM3kVpdyDIJ9natyRFLj9YxONZJl/zJ2iUfkoPm9PcXQ
         QBbvzhbJyullgCGI7PrDLifV+XjvV3pQzJiVIbry4dShhTSwMzJMv505Q/CikIyodd
         46kJWz3qHi+fr/bt8ZvrS/2XwU3Tk+TkRzANBYy0zGLnn8w7uaCugmGwL+5qWVLOgT
         bra/PP4VDYkLg==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4P5H1l264mzhmY;
        Mon, 30 Jan 2023 13:35:55 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <skhan@linuxfoundation.org>, bpf@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>
Subject: [PATCH bpf-next 2/2] selftests: bpf docs: Use installed kernel headers search path
Date:   Mon, 30 Jan 2023 13:35:49 -0500
Message-Id: <20230130183549.85471-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230130183549.85471-1-mathieu.desnoyers@efficios.com>
References: <20230130183549.85471-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use $(KHDR_INCLUDES) as lookup path for installed kernel headers rather
than using kernel headers in include/uapi from the source kernel tree
kernel headers.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Cc: <bpf@vger.kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mykola Lysenko <mykolal@fb.com>
---
 tools/testing/selftests/bpf/Makefile.docs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile.docs b/tools/testing/selftests/bpf/Makefile.docs
index eb6a4fea8c79..0a538d873def 100644
--- a/tools/testing/selftests/bpf/Makefile.docs
+++ b/tools/testing/selftests/bpf/Makefile.docs
@@ -44,7 +44,7 @@ RST2MAN_DEP := $(shell command -v rst2man 2>/dev/null)
 # $1 - target for scripts/bpf_doc.py
 # $2 - man page section to generate the troff file
 define DOCS_RULES =
-$(OUTPUT)bpf-$1.rst: ../../../../include/uapi/linux/bpf.h
+$(OUTPUT)bpf-$1.rst: $(KHDR_INCLUDES)/linux/bpf.h
 	$$(QUIET_GEN)../../../../scripts/bpf_doc.py $1 \
 		--filename $$< > $$@
 
-- 
2.25.1

