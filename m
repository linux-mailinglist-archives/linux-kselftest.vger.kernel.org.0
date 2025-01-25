Return-Path: <linux-kselftest+bounces-25156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF190A1C21B
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 09:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E721885F1C
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 08:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7D9207DEA;
	Sat, 25 Jan 2025 08:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dy9yDzJZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38941547F3;
	Sat, 25 Jan 2025 08:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737793456; cv=none; b=jQqh9qN3LTEsypUSymJic1pdKYTiFzboa9b8xliOwHDqAUnBWRKuMdnXMt2FrkopY90W/TPqj6MTF3CSYZ2H9YCb2bFjb5pjYuE2GW5MESMJ6nSHfQJxx/vX+ZO+eqsm2wcG7V/n3S3v5rwrkxJ9ohrWhbfU2uDMH9v6POx4Rpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737793456; c=relaxed/simple;
	bh=5C36o9IdjmfPRwlDKtDMgiQdJZRcjCq90w+nxcWONik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pjzAxf3EG+YRoaCqcoZjtd2LHgHyKj3BZu7FJ3GjfQjkJMiKiwL/LfiVfqGS/5w4u/xMCs+pX2ayNPLIqMuXd9uON5cK80eqbfvgy/v1LLicZ2ni6pym9htQSj+A92TXHibck57LzNTId+HE+Kuq82Wk13e9bElqqqR1bIakkx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dy9yDzJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B48BC4CEDF;
	Sat, 25 Jan 2025 08:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737793456;
	bh=5C36o9IdjmfPRwlDKtDMgiQdJZRcjCq90w+nxcWONik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dy9yDzJZXU7DfvY8sccBgWVjfeKWfivW5VjwnzHYKejJ70VTz4Epfb7mC6TajVs4O
	 Hr36ho9F+l7ZWlNjKE0hYmLtJaV3e/rfwEQwlgCilaSXRsObx7VH+khg6Yp5zhuQ6g
	 IiVPTW8ihgF9otUuqoiWGQ+4rmEUGlT2aNrDFq+e7/TzccYT3/zfU163REMOyONbvE
	 1+rqN89IEBSM9rBTu28LccRg9FyvUsU5nmbIbKuhGtB/+pXl8UvXG+0akl1GVZX9dV
	 3ZeOIn6eCVF7X5wfu70151p2+6zStnkD4ITw/SkHBHCZ443qXa/gPMTnAX3sF/SE60
	 TUq4CAez1CwCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D842C02182;
	Sat, 25 Jan 2025 08:24:16 +0000 (UTC)
From: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>
Date: Sat, 25 Jan 2025 16:23:39 +0800
Subject: [PATCH 4/7] tools headers UAPI: Update tools's copy of bpf.h
 header
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250125-bpf_dynptr_probe-v1-4-c3cb121f6951@outlook.com>
References: <20250125-bpf_dynptr_probe-v1-0-c3cb121f6951@outlook.com>
In-Reply-To: <20250125-bpf_dynptr_probe-v1-0-c3cb121f6951@outlook.com>
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
 b=owEBbQKS/ZANAwAIAW87mNQvxsnYAcsmYgBnlJ+pt84ftWXqGsr8H/DDtIoskSL657S5IFGsH
 f7LrFYF11uJAjMEAAEIAB0WIQQolnD5HDY18KF0JEVvO5jUL8bJ2AUCZ5SfqQAKCRBvO5jUL8bJ
 2HNpD/4ozXHMM0GIrwTf7brucDokPOjFaB9Pvdpcq7luOTsYKeD+RHOPEd791JyOK/KpYG9wsDd
 L6fb8JZE0IPAJFiZZxFHsvT6S2g4H1cCucjLYXv0n3C0UcH7Li2T7Y4K6sp0BxoEtA0wn+u6Hzl
 mnm/oW7Gc3ePJQMpLRszoOfqqnC5tdtV7kJ0dPMdcZlYWcEZoFr1GaP+bsAROfLOuUVNTVypqSP
 w2k7Gg9vp00cuGATWIlsgsTPGl9r0Ee+NpgDLsamj4g7Q9LZnxusrtF0eiIbojkCC8o8v4uzGRE
 QZ1O2Vpq7em8NuphLz0U7WjUBbpYsOlGhjgFRaGA6sMYqnFDF8p9e4JgC+AHPTFIVhK4S5GBCVb
 ZpumZebd9Tc0bcBIiimK5clq1oNqLkbXYW9mBsEgniSidsKalDJwU1jz/FLyRI8JKXUntzgloax
 x3TCh9zkY4L7U07lCV/4pJOF1ZgKV8MsrseKPce7XO2Itml69/nf4ySOULrUmKeZsur7Ze/fWtX
 HOoENncXcpE4h7h9O350fcd/qpY1e8+4uUvUy1C0jjDMEQ5S+7ViPJjfIhNPTtwpopkeIe7fS0L
 GDauKg0F3o4L0hW7wjR7RaARcNmoUFJwZa89biOmXyxI/QVnpY91Gx/UeWPVJUd9/DXBmKCqh9D
 1oL9dwDqP8DkVJQ==
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



