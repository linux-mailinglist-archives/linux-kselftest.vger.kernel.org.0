Return-Path: <linux-kselftest+bounces-44035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6B3C08B8A
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 07:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A6B3AFDA5
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 05:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717D12C326A;
	Sat, 25 Oct 2025 05:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qSdg7qQJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5362BE047
	for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 05:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761370307; cv=none; b=Aze4MOOWY4hA/Lla8YBGuVg+QK23iUIez/VniuggxRGciwZSncZHVZtbmBoIXViZ9ujVvH1oZBsXyhhe7aP5Suwb8UVx1EMcwfQl2g6lqRW3Xg2ydHeJqELeIieMYOs394PbJDqFLZHqgXvyF3/JrSnjVJlQp3u3s6ooOEMA5RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761370307; c=relaxed/simple;
	bh=si6I227a+dKXqtgmof1PAQpny+kaAuDs/AT8KSUWjbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T11FNBNLClvVHWFccyeIEvCZJDnYJYO6R6wBG3xf0BuwjJLZVpzCm1ySG4W8rQ2xXltGdSEHIJtXd0dmG1Hf6wnb7GCCsBhI8qXrWxN7ddQXSN+8NBs7XT4tgkGuHWZZ9Xdxt13o2xLa9+CzREPPC4vgNPgp0IpyW6CvWGEOMqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qSdg7qQJ; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761370301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9z87o7HkXhmUShl8i4AzUY8595FsyoBz1sm9MijMy9c=;
	b=qSdg7qQJ5844vzfpAteonNtJweC3cHIeUAJ69D9BUBBO3Ybc9zMbBSga4XhUI7x0DQz+FL
	J0QZeQiZmjuZJFCHM+l3qBBBK2fyAuTQ8YvuwQH/nqlbH/QPdE+m04F6pGkGvryGloj2iO
	4XwXmG10o0W7QNj81iAOapSoJDwV8hc=
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
	shuah@kernel.org,
	paul.chaignon@gmail.com,
	m.shachnai@gmail.com,
	harishankar.vishwanathan@gmail.com,
	colin.i.king@gmail.com,
	luis.gerhorst@fau.de,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: KaFai Wan <kafai.wan@linux.dev>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add test for BPF_JGT on same register
Date: Sat, 25 Oct 2025 13:30:17 +0800
Message-ID: <20251025053017.2308823-3-kafai.wan@linux.dev>
In-Reply-To: <20251025053017.2308823-1-kafai.wan@linux.dev>
References: <20251025053017.2308823-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a test to verify that conditional jumps using the BPF_JGT opcode on
the same register (e.g., "if r0 > r0") do not trigger verifier BUG
warnings when the register contains a scalar value with range information.

Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 .../selftests/bpf/progs/verifier_bounds.c      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 0a72e0228ea9..1536235c3e87 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1709,4 +1709,22 @@ __naked void jeq_disagreeing_tnums(void *ctx)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("JGT on same register")
+__success __log_level(2)
+__retval(0)
+__naked void jgt_same_register(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	w8 = 0x80000000;		\
+	r0 &= r8;			\
+	if r0 > r0 goto +1;		\
+	r0 = 0;				\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


