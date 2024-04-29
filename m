Return-Path: <linux-kselftest+bounces-9085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E59068B64CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 23:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB652813E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 21:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7647419066B;
	Mon, 29 Apr 2024 21:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="atcpZti/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C3D184121
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 21:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714427142; cv=none; b=bKJuH3W0MXYJi/jiHirdRoSkHRnWbe0HkUmA67CCL9vPPo+6zyOMkVFHQWI+uyEUmsUOLaZn5K6Z7vyAguyPmjetn+erHn2avsg0DJ3E75Rp/k5UiN4owqSe7LFGVQEcCopctrRbmqygpsvGg5LhH4yc6J4dDx2bGdHGwJ070EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714427142; c=relaxed/simple;
	bh=3XpCdIAzD80cSqUzy44G1UUId2dC6jZ7g9eolYeOgHg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZdCcGAuKhnU/Lu/I8Ybt/mC4p56F3KZ1zcKja1k/RQmaoiad5YCZhpWj5a4m6837mmrex4g66wH/+qv4F5u/Zf9XNTNdbcxkC/kB+uUh/rUXr7godsaT/eRcq/I91Drn9OMXDTf5qaPRzcYWZCcA40w7ebJ805+KuG57J1EoY1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=atcpZti/; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7dece812270so146483739f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 14:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714427140; x=1715031940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=po5d4BRZvVuXwVZK5WJYEffm014lvA9qK8+HKXMPmJk=;
        b=atcpZti/6rBUFK4O7PJ9KArMyf9CCM6VkNx6vHMp4zqD9L5c9m6ns7zUuq2hCzPVmX
         eWQAvxJMm6XocxBW3uGBcVS4vyP9yAe2sjiwf60cnaJzte2YXb+B5kuM42EcvAedgK4N
         RqJrrRQzZDOOT3Lycm1LgFzjQek+qZ4FOARWKHYXfJF+rEzo/s60pfD+X4Oi9BFI+j3S
         rpvBUpNFAiImjveVGrRP47dy/tlNJcIcJZkLiayhRj3Wf5TFNQ021mi/g17SFy8kZ4b+
         5vVLTL0hj28xva8cp8C7r7U02n8duGqgI1m9x5b3KCHInNT+1TNlDi34OLk/gnMvcXy8
         WOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714427140; x=1715031940;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=po5d4BRZvVuXwVZK5WJYEffm014lvA9qK8+HKXMPmJk=;
        b=QfCSfjVhYB5emTkgQxhqOgW0RJsDLRrbefRITu4z1DZ9t3r92SW503ugnJKdOOeIos
         rfLds1ytHJJMR/z7K6LYlAY0sBwQshw/9mc7vaFvB6M+qs/sssHGSNzOQeX1QJTD+SRf
         +p17C8fvRj5lqBNIF/VNRVzDhC624ch+k0u65KaJd3KR/ag5TWucraUur/j9W5c9pC1/
         W1pFbXHDOD0/PsEKNJea1ta0IpwPpDuOuAiy5jHbxq6Zc2w/Lvoi6Ap7dPxu5Q2wRdVD
         k4ul2CFhctRlDq4fn69gjBX1NJoiHvuY4IBH4ZznML/yWdeSu4JlpSpkCOLT3P2BZ2sR
         Z/Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUqQyOYzgWj9n/E/jQWrR3Yh35+GuWIYOtINFzf0zbbxdJ+94NTq5GvmApAmckT6/eWOPpAiiUm62FLcfe6hgQITDCk2nUV5uGKAVRdKJIs
X-Gm-Message-State: AOJu0Yz6aPjjR+c07/hfEbp/PwlZ9GvzPocbfZ0yBI8Lkccaetcq+TuR
	6GljMxTqM+6z7rUzX3YMcSbtNJmNxP1xu8/JXgp61NquQ4SiyFwUEWOqUb4CUituzBuQ+P55Bg=
	=
X-Google-Smtp-Source: AGHT+IGiP7g2Vwbx/sLdHKd9CxsA4r/ojIP2tygMYyGsgdFlSxlMZGkrDs0gtBlxzsRC17Ye+q5H8p9Qdg==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6638:868e:b0:485:549f:eed8 with SMTP id
 iv14-20020a056638868e00b00485549feed8mr61664jab.0.1714427140108; Mon, 29 Apr
 2024 14:45:40 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:45:19 -0500
In-Reply-To: <20240429214529.2644801-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240429214529.2644801-1-jrife@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429214529.2644801-3-jrife@google.com>
Subject: [PATCH v3 bpf-next 2/6] selftests/bpf: Implement socket kfuncs for bpf_testmod
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

This patch adds a set of kfuncs to bpf_testmod that can be used to
manipulate a socket from kernel space.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 255 ++++++++++++++++++
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  27 ++
 2 files changed, 282 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index eb2b78552ca29..e93013fc7bf4d 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -10,18 +10,30 @@
 #include <linux/percpu-defs.h>
 #include <linux/sysfs.h>
 #include <linux/tracepoint.h>
+#include <linux/net.h>
+#include <linux/socket.h>
+#include <linux/nsproxy.h>
+#include <linux/inet.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/un.h>
+#include <net/sock.h>
 #include "bpf_testmod.h"
 #include "bpf_testmod_kfunc.h"
 
 #define CREATE_TRACE_POINTS
 #include "bpf_testmod-events.h"
 
+#define CONNECT_TIMEOUT_SEC 1
+
 typedef int (*func_proto_typedef)(long);
 typedef int (*func_proto_typedef_nested1)(func_proto_typedef);
 typedef int (*func_proto_typedef_nested2)(func_proto_typedef_nested1);
 
 DEFINE_PER_CPU(int, bpf_testmod_ksym_percpu) = 123;
 long bpf_testmod_test_struct_arg_result;
+static DEFINE_MUTEX(sock_lock);
+static struct socket *sock;
 
 struct bpf_testmod_struct_arg_1 {
 	int a;
@@ -498,6 +510,237 @@ __bpf_kfunc void bpf_kfunc_call_test_sleepable(void)
 {
 }
 
+__bpf_kfunc int bpf_kfunc_init_sock(struct init_sock_args *args)
+{
+	int proto;
+	int err;
+
+	mutex_lock(&sock_lock);
+
+	if (sock) {
+		pr_err("%s called without releasing old sock", __func__);
+		err = -EPERM;
+		goto out;
+	}
+
+	switch (args->af) {
+	case AF_INET:
+	case AF_INET6:
+		proto = args->type == SOCK_STREAM ? IPPROTO_TCP : IPPROTO_UDP;
+		break;
+	case AF_UNIX:
+		proto = PF_UNIX;
+		break;
+	default:
+		pr_err("invalid address family %d\n", args->af);
+		err = -EINVAL;
+		goto out;
+	}
+
+	err = sock_create_kern(current->nsproxy->net_ns, args->af, args->type,
+			       proto, &sock);
+
+	if (!err)
+		/* Set timeout for call to kernel_connect() to prevent it from hanging,
+		 * and consider the connection attempt failed if it returns
+		 * -EINPROGRESS.
+		 */
+		sock->sk->sk_sndtimeo = CONNECT_TIMEOUT_SEC * HZ;
+out:
+	mutex_unlock(&sock_lock);
+
+	return err;
+}
+
+__bpf_kfunc void bpf_kfunc_close_sock(void)
+{
+	mutex_lock(&sock_lock);
+
+	if (sock) {
+		sock_release(sock);
+		sock = NULL;
+	}
+
+	mutex_unlock(&sock_lock);
+}
+
+__bpf_kfunc int bpf_kfunc_call_kernel_connect(struct addr_args *args)
+{
+	int err;
+
+	if (args->addrlen > sizeof(args->addr))
+		return -EINVAL;
+
+	mutex_lock(&sock_lock);
+
+	if (!sock) {
+		pr_err("%s called without initializing sock", __func__);
+		err = -EPERM;
+		goto out;
+	}
+
+	err = kernel_connect(sock, (struct sockaddr *)&args->addr,
+			     args->addrlen, 0);
+out:
+	mutex_unlock(&sock_lock);
+
+	return err;
+}
+
+__bpf_kfunc int bpf_kfunc_call_kernel_bind(struct addr_args *args)
+{
+	int err;
+
+	if (args->addrlen > sizeof(args->addr))
+		return -EINVAL;
+
+	mutex_lock(&sock_lock);
+
+	if (!sock) {
+		pr_err("%s called without initializing sock", __func__);
+		err = -EPERM;
+		goto out;
+	}
+
+	err = kernel_bind(sock, (struct sockaddr *)&args->addr, args->addrlen);
+out:
+	mutex_unlock(&sock_lock);
+
+	return err;
+}
+
+__bpf_kfunc int bpf_kfunc_call_kernel_listen(void)
+{
+	int err;
+
+	mutex_lock(&sock_lock);
+
+	if (!sock) {
+		pr_err("%s called without initializing sock", __func__);
+		err = -EPERM;
+		goto out;
+	}
+
+	err = kernel_listen(sock, 128);
+out:
+	mutex_unlock(&sock_lock);
+
+	return err;
+}
+
+__bpf_kfunc int bpf_kfunc_call_kernel_sendmsg(struct sendmsg_args *args)
+{
+	struct msghdr msg = {
+		.msg_name	= &args->addr.addr,
+		.msg_namelen	= args->addr.addrlen,
+	};
+	struct kvec iov;
+	int err;
+
+	if (args->addr.addrlen > sizeof(args->addr.addr) ||
+	    args->msglen > sizeof(args->msg))
+		return -EINVAL;
+
+	iov.iov_base = args->msg;
+	iov.iov_len  = args->msglen;
+
+	mutex_lock(&sock_lock);
+
+	if (!sock) {
+		pr_err("%s called without initializing sock", __func__);
+		err = -EPERM;
+		goto out;
+	}
+
+	err = kernel_sendmsg(sock, &msg, &iov, 1, args->msglen);
+	args->addr.addrlen = msg.msg_namelen;
+out:
+	mutex_unlock(&sock_lock);
+
+	return err;
+}
+
+__bpf_kfunc int bpf_kfunc_call_sock_sendmsg(struct sendmsg_args *args)
+{
+	struct msghdr msg = {
+		.msg_name	= &args->addr.addr,
+		.msg_namelen	= args->addr.addrlen,
+	};
+	struct kvec iov;
+	int err;
+
+	if (args->addr.addrlen > sizeof(args->addr.addr) ||
+	    args->msglen > sizeof(args->msg))
+		return -EINVAL;
+
+	iov.iov_base = args->msg;
+	iov.iov_len  = args->msglen;
+
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iov, 1, args->msglen);
+	mutex_lock(&sock_lock);
+
+	if (!sock) {
+		pr_err("%s called without initializing sock", __func__);
+		err = -EPERM;
+		goto out;
+	}
+
+	err = sock_sendmsg(sock, &msg);
+	args->addr.addrlen = msg.msg_namelen;
+out:
+	mutex_unlock(&sock_lock);
+
+	return err;
+}
+
+__bpf_kfunc int bpf_kfunc_call_kernel_getsockname(struct addr_args *args)
+{
+	int err;
+
+	mutex_lock(&sock_lock);
+
+	if (!sock) {
+		pr_err("%s called without initializing sock", __func__);
+		err = -EPERM;
+		goto out;
+	}
+
+	err = kernel_getsockname(sock, (struct sockaddr *)&args->addr);
+	if (err < 0)
+		goto out;
+
+	args->addrlen = err;
+	err = 0;
+out:
+	mutex_unlock(&sock_lock);
+
+	return err;
+}
+
+__bpf_kfunc int bpf_kfunc_call_kernel_getpeername(struct addr_args *args)
+{
+	int err;
+
+	mutex_lock(&sock_lock);
+
+	if (!sock) {
+		pr_err("%s called without initializing sock", __func__);
+		err = -EPERM;
+		goto out;
+	}
+
+	err = kernel_getpeername(sock, (struct sockaddr *)&args->addr);
+	if (err < 0)
+		goto out;
+
+	args->addrlen = err;
+	err = 0;
+out:
+	mutex_unlock(&sock_lock);
+
+	return err;
+}
+
 BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
@@ -525,6 +768,15 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_sleepable, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_kfunc_init_sock, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_kfunc_close_sock, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_connect, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_bind, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_listen, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_sendmsg, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_kfunc_call_sock_sendmsg, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_getsockname, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_getpeername, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
 
 static int bpf_testmod_ops_init(struct btf *btf)
@@ -655,6 +907,8 @@ static int bpf_testmod_init(void)
 		return ret;
 	if (bpf_fentry_test1(0) < 0)
 		return -EINVAL;
+	sock = NULL;
+	mutex_init(&sock_lock);
 	return sysfs_create_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
 }
 
@@ -668,6 +922,7 @@ static void bpf_testmod_exit(void)
 	while (refcount_read(&prog_test_struct.cnt) > 1)
 		msleep(20);
 
+	bpf_kfunc_close_sock();
 	sysfs_remove_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
 }
 
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
index ce5cd763561ca..b0d586a6751fa 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -64,6 +64,22 @@ struct prog_test_fail3 {
 	char arr2[];
 };
 
+struct init_sock_args {
+	int af;
+	int type;
+};
+
+struct addr_args {
+	char addr[sizeof(struct __kernel_sockaddr_storage)];
+	int addrlen;
+};
+
+struct sendmsg_args {
+	struct addr_args addr;
+	char msg[10];
+	int msglen;
+};
+
 struct prog_test_ref_kfunc *
 bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr) __ksym;
 void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
@@ -107,4 +123,15 @@ void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p);
 void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len);
 
 void bpf_kfunc_common_test(void) __ksym;
+
+int bpf_kfunc_init_sock(struct init_sock_args *args) __ksym;
+void bpf_kfunc_close_sock(void) __ksym;
+int bpf_kfunc_call_kernel_connect(struct addr_args *args) __ksym;
+int bpf_kfunc_call_kernel_bind(struct addr_args *args) __ksym;
+int bpf_kfunc_call_kernel_listen(void) __ksym;
+int bpf_kfunc_call_kernel_sendmsg(struct sendmsg_args *args) __ksym;
+int bpf_kfunc_call_sock_sendmsg(struct sendmsg_args *args) __ksym;
+int bpf_kfunc_call_kernel_getsockname(struct addr_args *args) __ksym;
+int bpf_kfunc_call_kernel_getpeername(struct addr_args *args) __ksym;
+
 #endif /* _BPF_TESTMOD_KFUNC_H */
-- 
2.44.0.769.g3c40516874-goog


