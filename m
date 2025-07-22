Return-Path: <linux-kselftest+bounces-37845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D92B0E0A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 17:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6EBAA58AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 15:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CFF2797B1;
	Tue, 22 Jul 2025 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SupDX+iV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CFE278E5A
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Jul 2025 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198536; cv=none; b=DZXElo9H4dZgn19ilE9v+mg686m2VR7+/DNkru8fqatJgIoBpHg0+x446Gs2R2RdTv80feYflVWwOItyB50J/q6bib0+4KgpVXrychDc//eI94P96iJDWwwn74pAJ6UGdDnLpWkwb9K8Di5EKVGKJgWSBfLBjEBCFCsvNWl20dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198536; c=relaxed/simple;
	bh=/YWJAaEMKsQpB79XKIShJIz579wQYx3BFktuZTqQQfI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ifk5hgEEribBUlWZEA6YOK5lLTwjfB1WKnrkk5Yc3BararDP+PaMvI0KziYe4iup88l55n1AmsEVv4cyaDC8Sjbr/Fy/X4plaHVCo9mGlBrXO25da9UAowS5fTSF/f5ggKpmW3OLpSWaLOwh6HhWYtvDPCZaZ262o2J1z2UKPgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SupDX+iV; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753198532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dvldxwGncKCm2/+TEH6ACEmFzgbPQOhXnryfMQbqEB4=;
	b=SupDX+iVwPylwkv3MKyyf0LYltqXcPQpnYGCATUZXnuRZtl00RXVELyprfMsqLyb8f4+Cx
	qcXLSSYW/zfTAxJn8a7e3mIQ17UlJJix28Afh1rsAsLaObkj9WNBljHY6727PsHVBBzh1R
	O3yn0ZqYKWIxiMFVUqvRFb35YlM2+So=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	kafai.wan@linux.dev,
	laoar.shao@gmail.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon.hwang@linux.dev
Subject: [PATCH bpf-next v3 2/4] bpf: Add log for attaching tracing programs to functions in deny list
Date: Tue, 22 Jul 2025 23:34:32 +0800
Message-ID: <20250722153434.20571-3-kafai.wan@linux.dev>
In-Reply-To: <20250722153434.20571-1-kafai.wan@linux.dev>
References: <20250722153434.20571-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Show the rejected function name when attaching tracing programs to
functions in deny list.

With this change, we know why tracing programs can't attach to functions
like migrate_disable() from log.

$ ./fentry
libbpf: prog 'migrate_disable': BPF program load failed: -EINVAL
libbpf: prog 'migrate_disable': -- BEGIN PROG LOAD LOG --
Attaching tracing programs to function 'migrate_disable' is rejected.

Suggested-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 00d287814f12..c24c0d57e595 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23942,6 +23942,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 			return ret;
 	} else if (prog->type == BPF_PROG_TYPE_TRACING &&
 		   btf_id_set_contains(&btf_id_deny, btf_id)) {
+		verbose(env, "Attaching tracing programs to function '%s' is rejected.\n",
+			tgt_info.tgt_name);
 		return -EINVAL;
 	} else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
 		   prog->expected_attach_type == BPF_MODIFY_RETURN) &&
-- 
2.43.0


