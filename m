Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D772624A99B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Aug 2020 00:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgHSWlt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Aug 2020 18:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbgHSWky (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Aug 2020 18:40:54 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B73C061357
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Aug 2020 15:40:48 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id f7so216826plj.16
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Aug 2020 15:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=NLjzglEfUx/tYjZ6bE489vKKomGgM6zRTKGgnxbmNyw=;
        b=oyjRIqCqy9fSSlUqNZozmrxpfmDEkCPtM3Cbc/Cnz1QCDqFxh3i6SpKu6iDmReppja
         dtK/A8mDKHu06jn23AvBgZCKx+ZRrUwIpzpfBg67FF20329ReDCclK/KenPGjzDVbi98
         M/i6GSj6NgfhscpB31fcZDq2zOuBc8qGR9VzGqpidj4qwhW9LalXAE+AUV0PoPFcUY9B
         yZ6wFH/k8ZWaUpOO5ECXxkMp0iL2iw8lOmzQ+Orr4ailvkpDzMw7hclCPDS5ZBHPhWPo
         Dq+URx2udIlMrRS4wtzgbHWS3ZgzuF6n4c6ZSwSGsPPm61DvhzDOWej2iH6nWltjmrNv
         vP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NLjzglEfUx/tYjZ6bE489vKKomGgM6zRTKGgnxbmNyw=;
        b=WDDWGqv1TDkPbCBoSbBs8DaqSBF+F0rmU9P3Yt/7eIFqRUlOmSeLuUvCW03IjSMUbm
         K6TOzLcJVK+zbcHDoLY3hiTyjOTnQWrkEscDQRbUX29LaGHJ3pMYdI/LQCHlDO2eJpwm
         IEwnuP8XWcZVsLzfAj7Ns+u54VVQGZ1YKA/eaEw+rgHc9LG9zTTt4L8MHSlCotyJI6q6
         Q3llY240G1vByDs6APIq2vDX7GVDUfcoModjzUe8ZFLaABnsqaDC0cLGYKaUw8kj4v/C
         S9niu+arWmY4lyzOHKAu4QnZWyQDnw6WoTDbdnw0mNkJgTrl9qiYhshq/8NkfVTt2a6Z
         2xdw==
X-Gm-Message-State: AOAM532rwzNYIDdU8BuS0A/zkqqmXaxeUhU0VrIsilbBFGUfkG72g2np
        4pXRTL5WsSaMTIeDhmAlVKK83I2L1Ao=
X-Google-Smtp-Source: ABdhPJx1hKQ8+B9EP1bBAT5p24RynlXXCuRT/DErWwZMGYM0QNfK2w7ueHo92OOANb7IeKdC4KJnmB+h4jw=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:f693:9fff:fef4:e444])
 (user=haoluo job=sendgmr) by 2002:a17:90a:7485:: with SMTP id
 p5mr92595pjk.130.1597876848380; Wed, 19 Aug 2020 15:40:48 -0700 (PDT)
Date:   Wed, 19 Aug 2020 15:40:29 -0700
In-Reply-To: <20200819224030.1615203-1-haoluo@google.com>
Message-Id: <20200819224030.1615203-8-haoluo@google.com>
Mime-Version: 1.0
References: <20200819224030.1615203-1-haoluo@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH bpf-next v1 7/8] bpf: Propagate bpf_per_cpu_ptr() to /tools
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

Sync tools/include/linux/uapi/bpf.h with include/linux/uapi/bpf.h

Signed-off-by: Hao Luo <haoluo@google.com>
---
 tools/include/uapi/linux/bpf.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 468376f2910b..7e3dfb2bbb86 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3415,6 +3415,20 @@ union bpf_attr {
  *		A non-negative value equal to or less than *size* on success,
  *		or a negative error in case of failure.
  *
+ * void *bpf_per_cpu_ptr(const void *ptr, u32 cpu)
+ *	Description
+ *		Take the address of a percpu ksym and return a pointer pointing
+ *		to the variable on *cpu*. A ksym is an extern variable decorated
+ *		with '__ksym'. A ksym is percpu if there is a global percpu var
+ *		(either static or global) defined of the same name in the kernel.
+ *
+ *		bpf_per_cpu_ptr() has the same semantic as per_cpu_ptr() in the
+ *		kernel, except that bpf_per_cpu_ptr() may return NULL. This
+ *		happens if *cpu* is larger than nr_cpu_ids. The caller of
+ *		bpf_per_cpu_ptr() must check the returned value.
+ *	Return
+ *		A generic pointer pointing to the variable on *cpu*.
+ *
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3559,6 +3573,7 @@ union bpf_attr {
 	FN(skc_to_tcp_request_sock),	\
 	FN(skc_to_udp6_sock),		\
 	FN(get_task_stack),		\
+	FN(bpf_per_cpu_ptr),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.28.0.220.ged08abb693-goog

