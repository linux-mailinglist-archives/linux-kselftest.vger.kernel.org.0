Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AA424A999
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Aug 2020 00:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgHSWl2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Aug 2020 18:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgHSWk5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Aug 2020 18:40:57 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7BAC061342
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Aug 2020 15:40:51 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id b16so12215814pft.18
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Aug 2020 15:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=DU+DeOt4r+Fv0uxk+6Q5tVdQKnGcEbfoUocacOxwgMU=;
        b=Jk23KIiA7W88ZhegNRM2yFYJA2nirIUkscEgy3RSxO65DBKHFteJW8rfJvsuIIMNYC
         JtSJALfn/NCRxOG5lOZKqD9fbP+hoHU03zqswpWd3wv/rZRI7SaFg2PIc+bHzXDkQGDc
         z/rfsKXh3vSr1jYoSm3tbO/kxyOJlYtmn/AP3rJoReDr7JVP2OfoJFUVPLt46PqeWCD3
         +UGaXlRuokYAEYkJqiw6jFIF0mcmD6zFSicEmY0SqNrFYttXI3E6XGP5ipylrDE8poOp
         M0u2GSMFQWJWrNYJchrUXS1zvckkPOZZLROZSv57idk0dZob7fsWwjs9eHPZCk+eUVFC
         wXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DU+DeOt4r+Fv0uxk+6Q5tVdQKnGcEbfoUocacOxwgMU=;
        b=JZsukcWjinwfkKpPNw/9xaG/m/ZNwxy1iUZjNVDMDMa7SgwZjPb8nklPEA16ovd97B
         7xLdVYPP055Px864R1uWPYRnmA1XiNDesKbnzln4vOqfUR4FIxpA/XKitIN9IQyftApz
         Xb0RR4JZxeE8zeeiDZ+s0TShBbiWPM0xTs6aZZG/Qtoln9WRuPmSdKDdW6Qxybm0IGKR
         Hp3yriOEVB3JgtoNAgkSgp3wzsvvHC3VeALdAraMK8mSXK8voqHj7V3eQQFoQLB1nurD
         VOgEXxCV0RkWu+psLHf7NwwZvjrvpnH9DMP5QL6RWgszOI8v5Ky5cSmTpyyxobXXSiPi
         8YPA==
X-Gm-Message-State: AOAM530vW/nSNjr91pCXC2DI4gIuhwAyncseprW+xJDDClwn5rA0UX3t
        RGiVwj3vzxresEeqk6zi2xERIoqsQqo=
X-Google-Smtp-Source: ABdhPJwbVXCs5G7r9UtdEIL5EAxGaM9Kalf4iGsFal/f5OTBIlAgdKRFO2oDzF3oxIHTTNIrcbUPT9YIo4M=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:f693:9fff:fef4:e444])
 (user=haoluo job=sendgmr) by 2002:a63:2482:: with SMTP id k124mr422506pgk.251.1597876850514;
 Wed, 19 Aug 2020 15:40:50 -0700 (PDT)
Date:   Wed, 19 Aug 2020 15:40:30 -0700
In-Reply-To: <20200819224030.1615203-1-haoluo@google.com>
Message-Id: <20200819224030.1615203-9-haoluo@google.com>
Mime-Version: 1.0
References: <20200819224030.1615203-1-haoluo@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH bpf-next v1 8/8] bpf/selftests: Test for bpf_per_cpu_ptr()
From:   Hao Luo <haoluo@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Hao Luo <haoluo@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Andrey Ignatov <rdna@fb.com>,
        Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test bpf_per_cpu_ptr(). Test two paths in the kernel. If the base
pointer points to a struct, the returned reg is of type PTR_TO_BTF_ID.
Direct pointer dereference can be applied on the returned variable.
If the base pointer isn't a struct, the returned reg is of type
PTR_TO_MEM, which also supports direct pointer dereference.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 .../testing/selftests/bpf/prog_tests/ksyms_btf.c  |  4 ++++
 .../testing/selftests/bpf/progs/test_ksyms_btf.c  | 15 ++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c b/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
index 1dad61ba7e99..bdedd4a76b42 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
@@ -71,6 +71,10 @@ void test_ksyms_btf(void)
 	      "got %llu, exp %llu\n", data->out__runqueues, runqueues_addr);
 	CHECK(data->out__bpf_prog_active != bpf_prog_active_addr, "bpf_prog_active",
 	      "got %llu, exp %llu\n", data->out__bpf_prog_active, bpf_prog_active_addr);
+	CHECK(data->out__rq_cpu != 1, "rq_cpu",
+	      "got %u, exp %u\n", data->out__rq_cpu, 1);
+	CHECK(data->out__process_counts == -1, "process_counts",
+	      "got %lu, exp != -1", data->out__process_counts);
 
 cleanup:
 	test_ksyms_btf__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/test_ksyms_btf.c b/tools/testing/selftests/bpf/progs/test_ksyms_btf.c
index e04e31117f84..78cf1ebb753d 100644
--- a/tools/testing/selftests/bpf/progs/test_ksyms_btf.c
+++ b/tools/testing/selftests/bpf/progs/test_ksyms_btf.c
@@ -7,16 +7,29 @@
 
 __u64 out__runqueues = -1;
 __u64 out__bpf_prog_active = -1;
+__u32 out__rq_cpu = -1;
+unsigned long out__process_counts = -1;
 
-extern const struct rq runqueues __ksym; /* struct type global var. */
+extern const struct rq runqueues __ksym; /* struct type percpu var. */
 extern const int bpf_prog_active __ksym; /* int type global var. */
+extern const unsigned long process_counts __ksym; /* int type percpu var. */
 
 SEC("raw_tp/sys_enter")
 int handler(const void *ctx)
 {
+	struct rq *rq;
+	unsigned long *count;
+
 	out__runqueues = (__u64)&runqueues;
 	out__bpf_prog_active = (__u64)&bpf_prog_active;
 
+	rq = (struct rq *)bpf_per_cpu_ptr(&runqueues, 1);
+	if (rq)
+		out__rq_cpu = rq->cpu;
+	count = (unsigned long *)bpf_per_cpu_ptr(&process_counts, 1);
+	if (count)
+		out__process_counts = *count;
+
 	return 0;
 }
 
-- 
2.28.0.220.ged08abb693-goog

