Return-Path: <linux-kselftest+bounces-37844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE2FB0E09C
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 17:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF2E3BF71F
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 15:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFB227932D;
	Tue, 22 Jul 2025 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HmEaddyg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5960327876A
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Jul 2025 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198530; cv=none; b=Z3/IB0mOXBDYr2ZgyN6b1sg8BEnawOTXNCwVjVUHBmK77BLfx5sh0hV5a09M2RFcH3lhbs2iHcRDLXsOTTOdEUhazCTzgnWYBTJTRD1IpNIu7v86gAgdx2y/mX3vq0Var9sgBLvGCakDQ3dKu8Otym6VXoYqVwR1MfbnDEOPKwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198530; c=relaxed/simple;
	bh=6PKQRM+trCUIVCmPY+p17BM5pPiI9HJPMZ/vwSb+rV4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9OWpX+aWiZM3CWuAFKLmlL00cwyQxzXSyCYFhjH/2JPRb2e908I/tohgPpICR365QqsX0ZElkU5ZHrBmWYzQYnPTZQvR3HB8UcEn1Cnw7AUNeZLgTu0R0DMmMkO8IW98NzxSlK0gbsn6av2FN34FVO6shojZWCh2jSZuczLKkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HmEaddyg; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753198526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cp6iNzapmusfmxQ0x7rEWLTmm+LPm3BtU19zWn32g3g=;
	b=HmEaddygsJTd5Ds29vSdfVE1XU8zywgGJa61/WMN15ptIJMjmT9B6ibW5p4CPjikJI0OnZ
	c1iy+l4C3G6HzGmxHFynmtM6G9cM5zISOIPzCStq9yd/jlheyUUdMrr+9ZsbyFdLLtkrYF
	zALa/gaoEbnwLeAvHdbmbdUdc15KHm8=
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
Subject: [PATCH bpf-next v3 1/4] bpf: Show precise rejected function when attaching fexit/fmod_ret to __noreturn functions
Date: Tue, 22 Jul 2025 23:34:31 +0800
Message-ID: <20250722153434.20571-2-kafai.wan@linux.dev>
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

With this change, we know the precise rejected function name when
attaching fexit/fmod_ret to __noreturn functions from log.

$ ./fexit
libbpf: prog 'fexit': BPF program load failed: -EINVAL
libbpf: prog 'fexit': -- BEGIN PROG LOAD LOG --
Attaching fexit/fmod_ret to __noreturn function 'do_exit' is rejected.

Suggested-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 kernel/bpf/verifier.c                               | 3 ++-
 tools/testing/selftests/bpf/progs/fexit_noreturns.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e2fcea860755..00d287814f12 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23946,7 +23946,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	} else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
 		   prog->expected_attach_type == BPF_MODIFY_RETURN) &&
 		   btf_id_set_contains(&noreturn_deny, btf_id)) {
-		verbose(env, "Attaching fexit/fmod_ret to __noreturn functions is rejected.\n");
+		verbose(env, "Attaching fexit/fmod_ret to __noreturn function '%s' is rejected.\n",
+			tgt_info.tgt_name);
 		return -EINVAL;
 	}
 
diff --git a/tools/testing/selftests/bpf/progs/fexit_noreturns.c b/tools/testing/selftests/bpf/progs/fexit_noreturns.c
index 54654539f550..b1c33d958ae2 100644
--- a/tools/testing/selftests/bpf/progs/fexit_noreturns.c
+++ b/tools/testing/selftests/bpf/progs/fexit_noreturns.c
@@ -8,7 +8,7 @@
 char _license[] SEC("license") = "GPL";
 
 SEC("fexit/do_exit")
-__failure __msg("Attaching fexit/fmod_ret to __noreturn functions is rejected.")
+__failure __msg("Attaching fexit/fmod_ret to __noreturn function 'do_exit' is rejected.")
 int BPF_PROG(noreturns)
 {
 	return 0;
-- 
2.43.0


