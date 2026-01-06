Return-Path: <linux-kselftest+bounces-48327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B322CF9E57
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 18:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E89A31C37AD
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 17:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ACA34EF1F;
	Tue,  6 Jan 2026 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N0nWB/2u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B4334EF09
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 17:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720088; cv=none; b=UptwSTjfQIsEMluVcldlo57AchMPk9IMtCHLqUnU7J3qSMwUPCGUvx8lnoibLlO/Lzsx8etWPyqh/d8utn67CIJY4WBswWcbWi3+l0UF4HQXeTJGXFMH3UvBh8kTbC8FB1aChFZtqQOSspyFDpPvjOYSm140CvfRuacM+aUOdfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720088; c=relaxed/simple;
	bh=hc5NWGN0r9aDg0436s6gyQhJpYTeqZRW/K8Um66wE6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuL0LwRVqkI2AwDcGHYTN5gfAvBITTlO6xHDHe/jEovkG248KPuO5ovH3go208GW1U9pPjtkzwY7a76Dh7zs7AXUvD9MDjEsu9m/rjJLxxSBE1ktXdW3Suf4X057PXjBTUM2SyjWyRSJ1FvtjnWpUh5x+XnGAsCmqhgemYRoTrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N0nWB/2u; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767720083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRP7dSPyiBjJ0689O8KZb3Eqq91g9ONGcIKtAwQLB2U=;
	b=N0nWB/2u94N4Fx/mQWxeBSMJm9HIK1iuKVEcpgjPCGkOsQUgPvg10dzX3fiRo1lVTxKE4X
	MnYc5YFyEdnTUVBJOXCn7NlrGOiVk/RRZkIg0lS3gopoFdHZEjTA/PSzPpNRmkRSyXazFf
	pkYWARmxfVOED6vMhxP8t4FOSS65Zwc=
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
Subject: [RESEND PATCH bpf-next v4 4/9] bpf: Add common attr support for prog_load
Date: Wed,  7 Jan 2026 01:20:13 +0800
Message-ID: <20260106172018.57757-5-leon.hwang@linux.dev>
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
'union bpf_attr' for BPF_PROG_LOAD.

In order to clarify the usage of these two log buffers, they both can be
used for logging if:

* They are same, including 'log_buf', 'log_level' and 'log_size'.
* One of them is missing, then another one will be used for logging.

If they both have 'log_buf' but they are not same totally, return -EUSERS.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/syscall.c | 51 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 1739601fb7bd..ad565f569a4f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6160,14 +6160,55 @@ static int prog_assoc_struct_ops(union bpf_attr *attr)
 	return ret;
 }
 
-static int copy_prog_load_log_true_size(union bpf_attr *attr, bpfptr_t uattr, unsigned int size)
+static int check_log_attrs(u64 log_buf, u32 log_size, u32 log_level,
+			   struct bpf_common_attr *common_attrs)
+{
+	if (log_buf && common_attrs->log_buf && (log_buf != common_attrs->log_buf ||
+						 log_size != common_attrs->log_size ||
+						 log_level != common_attrs->log_level))
+		return -EUSERS;
+
+	return 0;
+}
+
+static int check_prog_load_log_attrs(union bpf_attr *attr, struct bpf_common_attr *common_attrs)
+{
+	int err;
+
+	err = check_log_attrs(attr->log_buf, attr->log_size, attr->log_level, common_attrs);
+	if (err)
+		return err;
+
+	if (!attr->log_buf && common_attrs->log_buf) {
+		attr->log_buf = common_attrs->log_buf;
+		attr->log_size = common_attrs->log_size;
+		attr->log_level = common_attrs->log_level;
+	}
+
+	return 0;
+}
+
+static int copy_common_attr_log_true_size(bpfptr_t uattr, unsigned int size, u32 *log_true_size)
+{
+	if (size >= offsetofend(struct bpf_common_attr, log_true_size) &&
+	    copy_to_bpfptr_offset(uattr, offsetof(struct bpf_common_attr, log_true_size),
+				  log_true_size, sizeof(*log_true_size)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int copy_prog_load_log_true_size(union bpf_attr *attr, bpfptr_t uattr, unsigned int size,
+					struct bpf_common_attr *common_attrs, bpfptr_t uattr_common,
+					unsigned int size_common)
 {
 	if (size >= offsetofend(union bpf_attr, log_true_size) &&
 	    copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, log_true_size),
 				  &attr->log_true_size, sizeof(attr->log_true_size)))
 		return -EFAULT;
 
-	return 0;
+	return copy_common_attr_log_true_size(uattr_common, size_common,
+					      &attr->log_true_size);
 }
 
 static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
@@ -6225,9 +6266,13 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = map_freeze(&attr);
 		break;
 	case BPF_PROG_LOAD:
+		err = check_prog_load_log_attrs(&attr, &common_attrs);
+		if (err)
+			break;
 		attr.log_true_size = 0;
 		err = bpf_prog_load(&attr, uattr);
-		ret = copy_prog_load_log_true_size(&attr, uattr, size);
+		ret = copy_prog_load_log_true_size(&attr, uattr, size, &common_attrs, uattr_common,
+						   size_common);
 		err = ret ? ret : err;
 		break;
 	case BPF_OBJ_PIN:
-- 
2.52.0


