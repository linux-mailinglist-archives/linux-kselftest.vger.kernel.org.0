Return-Path: <linux-kselftest+bounces-25168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B62F4A1C237
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 09:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 081487A1025
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 08:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B849B207E1C;
	Sat, 25 Jan 2025 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlWm/2Dm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8159620766B;
	Sat, 25 Jan 2025 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737793828; cv=none; b=bu6v94yN9/cNtaB0BzjUC32xakHY6mXZzBlh04jl7+qlY16+WQkrQqzXtmfFXH35VMwqHGCgBXUCohndsQTl4XhAWb0qQ6uydAaBTEcMnbi9Mcjv+Ljme1HDdOqbj1TLH9XDoBwqpBGHpk1BvmdcYkBB1xrMAtDDQrQ6HKgVULo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737793828; c=relaxed/simple;
	bh=5C36o9IdjmfPRwlDKtDMgiQdJZRcjCq90w+nxcWONik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VgZofcNMYQCR7GgJbSaKy5GUPnSHvkaEffByPrGFhQdsj5qiLvu1b4OK7fOCOLQ2Bv8LMA5TqO2e1yYHhVfXfU77ASocLrNygaUr1aaboGpZxVlErZ9WTYpzeA/SpNd/GEtjHguh4AenisL7FYFV7nV5o50ABwXeSoUyA4OhbOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlWm/2Dm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E924C4CEF2;
	Sat, 25 Jan 2025 08:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737793828;
	bh=5C36o9IdjmfPRwlDKtDMgiQdJZRcjCq90w+nxcWONik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NlWm/2DmuVWdQ18rbIY9mDs4OPM1lo5PWMac5ReTNP7qOEvk7JVSGZGjBQQbeXnfQ
	 y4lGZxk2iiMceVoKW3IozWbJul6dGjCqb9wF9PGSLJg3FNLIFGHPe8eYgCf7e3Gi17
	 lRyBUFspfj5LG2zzKJ7WjXUlrEDD9FrerQWuHX+ZzdM7rn3R27kidKlo8Vnvpea3v9
	 HQcuce4wbMXvhSCFLTBeZCnXY3Z/yJoy514JOdAnpRCY0Aal+B6NN8FQVWYgrsKU2B
	 oNA60CxX93XEdftedf76XM9FF1Fzr9RThVNKLLTNDvxrFMO1XIiHyCzQpb1V2mwJWH
	 gX8mIBhjULTCw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D93C0218C;
	Sat, 25 Jan 2025 08:30:28 +0000 (UTC)
From: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>
Date: Sat, 25 Jan 2025 16:29:51 +0800
Subject: [PATCH bpf-next v2 4/7] tools headers UAPI: Update tools's copy of
 bpf.h header
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250125-bpf_dynptr_probe-v2-4-c42c87f97afe@outlook.com>
References: <20250125-bpf_dynptr_probe-v2-0-c42c87f97afe@outlook.com>
In-Reply-To: <20250125-bpf_dynptr_probe-v2-0-c42c87f97afe@outlook.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
 Levi Zim <rsworktech@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3015;
 i=rsworktech@outlook.com; h=from:subject:message-id;
 bh=3gnnXYcyukxFoJ6/k3O/B5KiBqxGbCIQ+tpkC1HU5hk=;
 b=owEBbQKS/ZANAwAIAW87mNQvxsnYAcsmYgBnlKEdTLRZndyUKLBQC5UPoctezuIHnutTGt7GT
 utgw8pM5luJAjMEAAEIAB0WIQQolnD5HDY18KF0JEVvO5jUL8bJ2AUCZ5ShHQAKCRBvO5jUL8bJ
 2A+6EADZl1H4gh/cvrYU14Wbd78OgiD/6umqDHAIrJus+g9gUOiP66bWd91DB27W9DPbhbWlObX
 hg7aLBoel6BQcWIGWHBpK3urFTFQFtFF7xA0l086PvtYiImRkCx8EYOwp71HP4O/Ggnslbn+V8H
 84ba7oDLd8DxMX/+sNS+WFfrxKUMtAwQ+kRfeNMSSRuvzLfSIwgi5Q9sGE7mJJq9Es/ZyyhFI5x
 NGBsqBGJoNPlz8yTxYtbROq5MqiLaJoEWW0R+mMZMA+XBmg/pg9nvZLa0BgH00BkLQ1DDMs1GL7
 VJ6GyH76ToFTez/Z51UYx1wbjMR4hj3lJ98pVfQ17b9VdmIYR1LrnIrZsuvSQyeOW0t1KB/pGex
 imb/79lOC1bGBY+agLt7eOp6rO08WcQEohNukAx+bRVbmnj4heTfpUEzEXNT3EEYSHJpc8y0shf
 +Cf7IE9sNI8Mg/xKwEdsxJMSUrUqwIgQ7/XauuSK8CZHKTn5LtrX7o7gRDybF6nmUSl99zKoZYk
 dmZJzazxCdTCB6no1uAEZw+RxIPv197cchbv0/y3qdkThDS9unoHySIJTYOCretYZnc6ejxdAvn
 LgJQ7+OZHbk8B6VdntqoRL/ED6CcWIJuIhv4cJXq2FwlSA/tiefZziggN4sYq1qtey0CUnmGmML
 I/djjzhF7VE5ZQg==
X-Developer-Key: i=rsworktech@outlook.com; a=openpgp;
 fpr=17AADD6726DDC58B8EE5881757670CCFA42CCF0A
X-Endpoint-Received: by B4 Relay for rsworktech@outlook.com/default with
 auth_id=219
X-Original-From: Levi Zim <rsworktech@outlook.com>
Reply-To: rsworktech@outlook.com

From: Levi Zim <rsworktech@outlook.com>

This update brings the new bpf_probe_read_{kernel,user} helpers

Signed-off-by: Levi Zim <rsworktech@outlook.com>
---
 tools/include/uapi/linux/bpf.h | 49 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 2acf9b33637174bd16b1d12ccc6410c5f55a7ea9..f92cf809b50bc393d54eb0e8de2e1ce2a39e95d0 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5805,6 +5805,52 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_probe_read_kernel_dynptr(const struct bpf_dynptr *dst, u32 offset, u32 size, const void *unsafe_ptr, u64 flags)
+ *	Description
+ *		Safely attempt to read *size* bytes from kernel space address
+ *		*unsafe_ptr* and store the data in *dst* starting from *offset*.
+ *		*flags* is currently unused.
+ *	Return
+ *		0 on success.
+ *
+ *		**-E2BIG** if *offset* + *len* exceeds the length of *src*'s data
+ *
+ *		**-EINVAL** if *src* is an invalid dynptr or doesn't support this
+ *		support this helper, or if *flags* is not 0.
+ *
+ *		Or other negative errors on failure reading kernel memory.
+ *
+ * long bpf_probe_read_user_dynptr(const struct bpf_dynptr *dst, u32 offset, u32 size, const void *unsafe_ptr, u64 flags)
+ *	Description
+ *		Safely attempt to read *size* bytes from user space address
+ *		*unsafe_ptr* and store the data in *dst* starting from *offset*.
+ *		*flags* is currently unused.
+ *	Return
+ *		0 on success.
+ *
+ *		**-E2BIG** if *offset* + *len* exceeds the length of *src*'s data
+ *
+ *		**-EINVAL** if *src* is an invalid dynptr or doesn't support this
+ *		support this helper, or if *flags* is not 0.
+ *
+ *		Or other negative errors on failure reading user space memory.
+ *
+ * long bpf_copy_from_user_dynptr(const struct bpf_dynptr *dst, u32 offset, u32 size, const void *user_ptr, u64 flags)
+ *	Description
+ *		Read *size* bytes from user space address *user_ptr* and store
+ *		the data in *dst* starting from *offset*.
+ *		This is a wrapper of **copy_from_user**\ ().
+ *		*flags* is currently unused.
+ *	Return
+ *		0 on success.
+ *
+ *		**-E2BIG** if *offset* + *len* exceeds the length of *src*'s data
+ *
+ *		**-EINVAL** if *src* is an invalid dynptr or doesn't support this
+ *		support this helper, or if *flags* is not 0.
+ *
+ *		Or other negative errors on failure reading user space memory.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -6019,6 +6065,9 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(probe_read_kernel_dynptr, 212, ##ctx)		\
+	FN(probe_read_user_dynptr, 213, ##ctx)		\
+	FN(copy_from_user_dynptr, 214, ##ctx)		\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't

-- 
2.48.1



