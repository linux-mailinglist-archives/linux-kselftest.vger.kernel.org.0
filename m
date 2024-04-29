Return-Path: <linux-kselftest+bounces-9086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 318808B64D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 23:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635DB1C21CA6
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 21:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1008D19068B;
	Mon, 29 Apr 2024 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LOEwglY+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA530190670
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 21:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714427144; cv=none; b=LbBOD03OPfzPC3VhuOXDutMqsaFWfsUtbOsdbG6MV4BaNW4BoQj6zGNpyfW+6+AJt5v7uF2eFsRc8H/u6dvVuv9P5tZgyAVdrouDtbir12sAGDU01VaMYug/8csZJcjjs3KLgyqktuySLbPbnauFYL3kX1iAV9OrJ/OuFBUpCpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714427144; c=relaxed/simple;
	bh=8ypncdYcfhHsdlMrqbyapwo4Pvkh7l2XnqBx6SFPA5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XQdu99cKNKE357mO5igEWnQY/mPfNEw96oaS2HyY2RTA5sKOj7zF8hZKUaHug7Gxct4mr9laIfpT9+MomFwVwOAcwwvoBKGImIlhwOx/cgn1HRQkVpV2kxh+SLdacQfV+9xuZ6z48PTi/NJe9Qe6wmauP+hJ3LDxR6bMWWXnnKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LOEwglY+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be4601434so12494487b3.3
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 14:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714427142; x=1715031942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TRW3v1PsNRuBnsLckz6xpTxguyKGBJkvg2o2SpGBrTI=;
        b=LOEwglY+7sStM2kajtM1MZ0nndP6GhBSFGOjMMXbrf1pr4s68HxJQJF4FSrnASwv5D
         9uW2+G3jgfOJ/tk7hhw03kcu9ppbCMw/Ir9v6WyhjToCW8KrYiTVYGPC7Y5Dt34us/2K
         ZkTR+BEybP/eQZQcDz+YbRhhXJf/U7Op1AU0OhBqA1vW6nrJKxknFn7Boq8bVFLU5qYn
         L+F8I+XinInt08fTHlOUcDbQLUjRG81+SWIr2RkHsEVTe3zFq1/KVv8Yu98jJeG2zvZb
         zkKo8nbedBYgNdn7EdQptYCf7M9AdHKeaSLqtpGU3wEFb07hpyS/nWyun1BEI6PFqMys
         mg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714427142; x=1715031942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TRW3v1PsNRuBnsLckz6xpTxguyKGBJkvg2o2SpGBrTI=;
        b=lhQPQgzpWjkaRVIXUG9rUpXv+9SebxWRX66dgcbAzJILDQ9R2tTYth4lRrJPYxDl8K
         FVnESf65tiYCUcm8Nhf0ibfjAsGzHUW0samw2E+ziPqFBL48CQoNuLibczoU9kRWJEzC
         8xBxTlY6d54vZiyrnQFAcBq12sly1R/H4jxaLKKlqktb3yiOCLxifKzthMraKuo5XCGg
         3pyEp1xEVKkRUwE91W59KQsmV3qFWHtQUZIvE9GV+qQUpubwEF8eDDMaK7MIBWb5Qv+S
         /9RmYqlcr2CDAjNM5NALVt6mFXVBrCZ1G3X+/p/+JjXFWSo0oPzBUNpBjBQHysaoULpw
         DoAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2XbkpxK0AIIiVduQD+TAaGQjlafd04CbokaDr3ZJWIr6w7yDEE6/DxtJ7Ohc+1YYnkA4Gi1AENOHSlwhvHxYA5nePzxkUnWypbykp9fRm
X-Gm-Message-State: AOJu0YzOzN1iMB7SB8XkEi7OrTQ4y6i8luuJyHNcrfp0CTmU4KMcAF6+
	hT5CyrbAxHgxJl2lV/I1+aZixsjx1uHGJdwohqj4GiF00df1npAFfubrAby7dc/5hGOkH0P/Pg=
	=
X-Google-Smtp-Source: AGHT+IECbatiFUlb2eIbvH1htrCqD5HxfKjjrK7ixQ6M4nuq9O5N3VH6Uk7qA01ceWsXbMhKDagouQXkRw==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:690c:8:b0:614:f416:9415 with SMTP id
 bc8-20020a05690c000800b00614f4169415mr3659690ywb.7.1714427141914; Mon, 29 Apr
 2024 14:45:41 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:45:20 -0500
In-Reply-To: <20240429214529.2644801-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240429214529.2644801-1-jrife@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429214529.2644801-4-jrife@google.com>
Subject: [PATCH v3 bpf-next 3/6] selftests/bpf: Implement BPF programs for
 kernel socket operations
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Artem Savkov <asavkov@redhat.com>, 
	Dave Marchevsky <davemarchevsky@fb.com>, Menglong Dong <imagedong@tencent.com>, Daniel Xu <dxu@dxuuu.xyz>, 
	David Vernet <void@manifault.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Benjamin Tissoires <bentiss@kernel.org>, Hou Tao <houtao1@huawei.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

This patch lays out a set of SYSCALL programs that can be used to invoke
the socket operation kfuncs in bpf_testmod, allowing a test program to
manipulate kernel socket operations from userspace.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/progs/sock_addr_kern.c      | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/sock_addr_kern.c

diff --git a/tools/testing/selftests/bpf/progs/sock_addr_kern.c b/tools/testing/selftests/bpf/progs/sock_addr_kern.c
new file mode 100644
index 0000000000000..8386bb15ccdc1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sock_addr_kern.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
+
+SEC("syscall")
+int init_sock(struct init_sock_args *args)
+{
+	bpf_kfunc_init_sock(args);
+
+	return 0;
+}
+
+SEC("syscall")
+int close_sock(void *ctx)
+{
+	bpf_kfunc_close_sock();
+
+	return 0;
+}
+
+SEC("syscall")
+int kernel_connect(struct addr_args *args)
+{
+	return bpf_kfunc_call_kernel_connect(args);
+}
+
+SEC("syscall")
+int kernel_bind(struct addr_args *args)
+{
+	return bpf_kfunc_call_kernel_bind(args);
+}
+
+SEC("syscall")
+int kernel_listen(struct addr_args *args)
+{
+	return bpf_kfunc_call_kernel_listen();
+}
+
+SEC("syscall")
+int kernel_sendmsg(struct sendmsg_args *args)
+{
+	return bpf_kfunc_call_kernel_sendmsg(args);
+}
+
+SEC("syscall")
+int sock_sendmsg(struct sendmsg_args *args)
+{
+	return bpf_kfunc_call_sock_sendmsg(args);
+}
+
+SEC("syscall")
+int kernel_getsockname(struct addr_args *args)
+{
+	return bpf_kfunc_call_kernel_getsockname(args);
+}
+
+SEC("syscall")
+int kernel_getpeername(struct addr_args *args)
+{
+	return bpf_kfunc_call_kernel_getpeername(args);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.44.0.769.g3c40516874-goog


