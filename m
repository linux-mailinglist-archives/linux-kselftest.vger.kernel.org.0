Return-Path: <linux-kselftest+bounces-7381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5861A89B9DD
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 10:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1276C2825B6
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 08:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EFF4AEF1;
	Mon,  8 Apr 2024 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcmzYzSC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA524AEC4;
	Mon,  8 Apr 2024 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563810; cv=none; b=D2GUs9qhYj+ZOpE0j6CAfD6XbnYSysb4QlRf1g0m9+1hWiBnN3C2gGux9zkFrTm1cC7rv38IHHpB13OTxbchnAMbJZJs9ZCSCsO1HGfm8W+IW7h6xG9PhwNi1WZJ1RsTgue1ILJqJunt4ALKRpvLEJuwJGL6OEFpVFnfSrMTNaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563810; c=relaxed/simple;
	bh=635XJV7/rS2AZSR2TOFYFdxkBgPz6B2TWBzQ/ySmu9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KMTaaaou7wTuv84Gt4ICP75aDRXPCyWyN6lbn1FocfcX+tOPwgUEohOc5zCdbrDdnx6kd4lxW+93E0uGbJzn8HiiWuyu9JUeeI6Rkw1TVPDsNYeiZTmu28rD2f6bmuztmgtCcoqFdbBWo0kbOHFywJzVh78RHtSbv/t4XsdM0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcmzYzSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080A2C43399;
	Mon,  8 Apr 2024 08:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712563810;
	bh=635XJV7/rS2AZSR2TOFYFdxkBgPz6B2TWBzQ/ySmu9M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rcmzYzSCS2UQ2yznV+tN4pM6lfJYvCiY03U13zRxlWbiIotEWFvWdSs/qgVhMI1yd
	 rNTsHKNniThyXgmiB+e4VlzhPaZ7b8T4KfJfINbTfnBj8JVTMhcMURbifUt4tzQZNL
	 mzbt8W+LRY18yOXl580XOf6PByqx8Pz4uTY/dcdHFX3iXBA5xmKEkvzKedKX3Firl1
	 mLH5KPeB3HwIsqCZwoRdO1K/cvKCHvV5KjgLnElda611Oh9ONye5pDAwWV4VaLMJZN
	 JTjEicFtMXx/Bt3JdGpYzyPfRiuEWWuqKVFwkRvVt3z4OjSoFPZoBq9RLkiBzjP4tF
	 0PbWKFnIQcuwA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Mon, 08 Apr 2024 10:09:30 +0200
Subject: [PATCH RFC bpf-next v6 5/6] tools: sync include/uapi/linux/bpf.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-hid-bpf-sleepable-v6-5-0499ddd91b94@kernel.org>
References: <20240408-hid-bpf-sleepable-v6-0-0499ddd91b94@kernel.org>
In-Reply-To: <20240408-hid-bpf-sleepable-v6-0-0499ddd91b94@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712563787; l=1530;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=635XJV7/rS2AZSR2TOFYFdxkBgPz6B2TWBzQ/ySmu9M=;
 b=3a7SZ7xD0328vUxDQYvfQWMfPdppH06CJBZk9RnsI5LibRtnAfsK7nV4ruTCSR80t86Vx78ab
 Yp4jph6hShYCpu03ot6opzyxC/9gplP3l9T/T0NKywzNn+3k3Ew5yFH
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

cp include/uapi/linux/bpf.h tools/include/uapi/linux/bpf.h

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

updated in v6

no changes in v5

new in v4
---
 tools/include/uapi/linux/bpf.h | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index bf80b614c4db..f1890eed213a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1662,9 +1662,10 @@ union bpf_attr {
 	} query;
 
 	struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN command */
-		__u64 name;
-		__u32 prog_fd;
-		__aligned_u64 cookie;
+		__u64		name;
+		__u32		prog_fd;
+		__u32		:32;
+		__aligned_u64	cookie;
 	} raw_tracepoint;
 
 	struct { /* anonymous struct for BPF_BTF_LOAD */
@@ -7468,6 +7469,19 @@ enum {
 	BPF_F_TIMER_CPU_PIN = (1ULL << 1),
 };
 
+/* Extra flags to control bpf_timer_init() behaviour, in addition to CLOCK_*.
+ *     - BPF_F_TIMER_SLEEPABLE: Timer will run in a workqueue in a sleepable
+ *       context, with no guarantees of ordering nor timing (consider this as
+ *       being just offloaded immediately).
+ */
+enum {
+	/* CLOCK_* are using bits 0 to 3 */
+	BPF_F_TIMER_SLEEPABLE = (1ULL << 4),
+	__MAX_BPF_F_TIMER_INIT,
+};
+
+#define MAX_BPF_F_TIMER_INIT __MAX_BPF_F_TIMER_INIT
+
 /* BPF numbers iterator state */
 struct bpf_iter_num {
 	/* opaque iterator state; having __u64 here allows to preserve correct

-- 
2.44.0


