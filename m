Return-Path: <linux-kselftest+bounces-48329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 092C4CF9BA9
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 18:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9DF96302982B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 17:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A680346763;
	Tue,  6 Jan 2026 17:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sP3loB8b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C443469FA
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 17:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720107; cv=none; b=WmNbqRpMvDpkSIa+qf9qY4uMwuZ0FPxValOYfWDLGzDOxLFFf+pvPFHaT/sw7u8Xuu2AKfc2Rg3gboaDriq38WUEx9y07HoeImRErQEFQIREusYj6A4kLcQ6z/3EfckfEpv7X+GsMKJJMkV+6bv8iDa5XR78pdGpawHjgwf7RIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720107; c=relaxed/simple;
	bh=574nViD3Ekg7B8qaFiH5i9ESrWlBcUwH8a7+I+wJd0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rad7ez8hmKuEG7C3bRZPfzOlWTW97gL14r0BpZACeiHznebeWG8rDxbfP6DWQ7soF1dj6zh9/VbVOK0mpva108Ped3vd4mzcoTiJJzJHq7UHTPlR9h7yF4BRpt34nr36VGEPspfMUoJgKpPjgzqAP5BdE5fQ1jwvh6paEHz3XUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sP3loB8b; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767720103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oH5uvc/HIHJHvUDH1FHA2g822OEsdqyIpxTdGkj+aPM=;
	b=sP3loB8byZBmR1LqrU23UR+FYC4Bf9UVEJ+RmM5goMOD5zk9VH84b1iMRuqdkqv6FjgwJ3
	jTH71FXVn2/x1ceZcPUq6eVUtzkkpv0BJb2h1B4NehHtfqn8EMhft/BNSTFp8RqmIV/Gc+
	yKyC8WxozOJGoCDx01HYSm+/dm4CfH0=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Seth Forshee <sforshee@kernel.org>,
	Yuichiro Tsuji <yuichtsu@amazon.com>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Rong Tao <rongtao@cestc.cn>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [RESEND PATCH bpf-next v4 6/9] bpf: Add common attr support for btf_load
Date: Wed,  7 Jan 2026 01:20:15 +0800
Message-ID: <20260106172018.57757-7-leon.hwang@linux.dev>
In-Reply-To: <20260106172018.57757-1-leon.hwang@linux.dev>
References: <20260106172018.57757-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The log buffer of common attributes would be confusing with the one in
'union bpf_attr' for BPF_BTF_LOAD.

In order to clarify the usage of these two log buffers, they both can be
used for logging if:

* They are same, including 'log_buf', 'log_level' and 'log_size'.
* One of them is missing, then another one will be used for logging.

If they both have 'log_buf' but they are not same totally, return -EUSERS.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/syscall.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ce349a059d5d..14fc5738f2b9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6211,14 +6211,35 @@ static int copy_prog_load_log_true_size(union bpf_attr *attr, bpfptr_t uattr, un
 					      &attr->log_true_size);
 }
 
-static int copy_btf_load_log_true_size(union bpf_attr *attr, bpfptr_t uattr, unsigned int size)
+static int check_btf_load_log_attrs(union bpf_attr *attr, struct bpf_common_attr *common_attrs)
+{
+	int err;
+
+	err = check_log_attrs(attr->btf_log_buf, attr->btf_log_size, attr->btf_log_level,
+			      common_attrs);
+	if (err)
+		return err;
+
+	if (!attr->btf_log_buf && common_attrs->log_buf) {
+		attr->btf_log_buf = common_attrs->log_buf;
+		attr->btf_log_size = common_attrs->log_size;
+		attr->btf_log_level = common_attrs->log_level;
+	}
+
+	return 0;
+}
+
+static int copy_btf_load_log_true_size(union bpf_attr *attr, bpfptr_t uattr, unsigned int size,
+				       struct bpf_common_attr *common_attrs, bpfptr_t uattr_common,
+				       unsigned int size_common)
 {
 	if (size >= offsetofend(union bpf_attr, btf_log_true_size) &&
 	    copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, btf_log_true_size),
 				  &attr->btf_log_true_size, sizeof(attr->btf_log_true_size)))
 		return -EFAULT;
 
-	return 0;
+	return copy_common_attr_log_true_size(uattr_common, size_common,
+					      &attr->btf_log_true_size);
 }
 
 static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
@@ -6328,9 +6349,13 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = bpf_raw_tracepoint_open(&attr);
 		break;
 	case BPF_BTF_LOAD:
+		err = check_btf_load_log_attrs(&attr, &common_attrs);
+		if (err)
+			break;
 		attr.btf_log_true_size = 0;
 		err = bpf_btf_load(&attr, uattr);
-		ret = copy_btf_load_log_true_size(&attr, uattr, size);
+		ret = copy_btf_load_log_true_size(&attr, uattr, size, &common_attrs, uattr_common,
+						  size_common);
 		err = ret ? ret : err;
 		break;
 	case BPF_BTF_GET_FD_BY_ID:
-- 
2.52.0


