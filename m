Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AB7529B01
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 May 2022 09:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241566AbiEQHgv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 May 2022 03:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238189AbiEQHgl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 May 2022 03:36:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E87F2612D
        for <linux-kselftest@vger.kernel.org>; Tue, 17 May 2022 00:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652772999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z8TJGc65VPq8LFCB93HW2zYbRoFkSWlAyqA2j8NAtgg=;
        b=bgGu/xdnAQOnfYwJv2ytg1RndSXOQOe8Cjx+kJg+KBaCW2anRWnUT1q8PJl9fNghNo/RVl
        pBlhR7YeU4iYIbSqYafN7m6bOcEcLTNbIlnreX6lbntCHAbQ0JP9FpLLwGGzdlOj5zvRI+
        Pls4HcRhBV6nIpFT9IKTQPleR2wzU/I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-kAUXOHQZNo-BaEpEg3KrOg-1; Tue, 17 May 2022 03:36:33 -0400
X-MC-Unique: kAUXOHQZNo-BaEpEg3KrOg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C5131857F08;
        Tue, 17 May 2022 07:36:32 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F15061568BA9;
        Tue, 17 May 2022 07:36:28 +0000 (UTC)
Date:   Tue, 17 May 2022 09:36:26 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 2/4] bpf_trace: support 32-bit kernels in
 bpf_kprobe_multi_link_attach
Message-ID: <525b99881dc144b986e381eb23b12617a311f243.1652772731.git.esyr@redhat.com>
References: <cover.1652772731.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1652772731.git.esyr@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It seems that there is no reason not to support 32-bit architectures;
doing so requires a bit of rework with respect to cookies handling,
however, as the current code implicitly assumes
that sizeof(long) == sizeof(u64).

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 kernel/trace/bpf_trace.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 9c041be..a93a54f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2435,16 +2435,12 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	struct bpf_link_primer link_primer;
 	void __user *ucookies;
 	unsigned long *addrs;
-	u32 flags, cnt, size;
+	u32 flags, cnt, size, cookies_size;
 	void __user *uaddrs;
 	u64 *cookies = NULL;
 	void __user *usyms;
 	int err;
 
-	/* no support for 32bit archs yet */
-	if (sizeof(u64) != sizeof(void *))
-		return -EOPNOTSUPP;
-
 	if (prog->expected_attach_type != BPF_TRACE_KPROBE_MULTI)
 		return -EINVAL;
 
@@ -2454,6 +2450,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 
 	uaddrs = u64_to_user_ptr(attr->link_create.kprobe_multi.addrs);
 	usyms = u64_to_user_ptr(attr->link_create.kprobe_multi.syms);
+	ucookies = u64_to_user_ptr(attr->link_create.kprobe_multi.cookies);
 	if (!!uaddrs == !!usyms)
 		return -EINVAL;
 
@@ -2461,8 +2458,11 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (!cnt)
 		return -EINVAL;
 
-	if (check_mul_overflow(cnt, (u32)sizeof(*addrs), &size))
+	if (check_mul_overflow(cnt, (u32)sizeof(*addrs), &size) ||
+	    (ucookies &&
+	     check_mul_overflow(cnt, (u32)sizeof(*cookies), &cookies_size))) {
 		return -EOVERFLOW;
+	}
 	addrs = kvmalloc(size, GFP_KERNEL);
 	if (!addrs)
 		return -ENOMEM;
@@ -2486,14 +2486,13 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 			goto error;
 	}
 
-	ucookies = u64_to_user_ptr(attr->link_create.kprobe_multi.cookies);
 	if (ucookies) {
-		cookies = kvmalloc(size, GFP_KERNEL);
+		cookies = kvmalloc(cookies_size, GFP_KERNEL);
 		if (!cookies) {
 			err = -ENOMEM;
 			goto error;
 		}
-		if (copy_from_user(cookies, ucookies, size)) {
+		if (copy_from_user(cookies, ucookies, cookies_size)) {
 			err = -EFAULT;
 			goto error;
 		}
-- 
2.1.4

