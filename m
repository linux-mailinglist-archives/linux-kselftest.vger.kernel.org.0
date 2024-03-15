Return-Path: <linux-kselftest+bounces-6351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEBD87CEE6
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 15:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36D04284354
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 14:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0033B783;
	Fri, 15 Mar 2024 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaqiYl6Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4803F9EA;
	Fri, 15 Mar 2024 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512998; cv=none; b=SMQ35RTyEoskgVd6Ru38JTYk/bIuztT7KMZDRLYGAJ5GtaqZaBls+tP7RBGZSb2s0H7TJ+eayG6DUf1CXce+WT2LotKIZWOkxY61Dife9u8XYnF2pai23DLyCl1EmzsWdssYhLaUy4dRnnySqSH/yXB0aT8VHBRSv3oryi+nOaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512998; c=relaxed/simple;
	bh=2fcfnf6IWojwAjkJVFYBpNts+ogJLinSFTftkDm2+Ew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SSkB9bIUHu9GiDn1qxa3XgU1O7XGLXB4hBlK6zTgtFGV+X7YnEWfmbrbW0mF6xJ1P44lnB+fp1pCzkXlWzv+ljgNALJwITP+GZvVx6MYQ0gcQty2pBt/MhZnwSB42rTsPYTcIle7Ln/WX5nxspKKdgEigzOaLlOC52WTbPlO48Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaqiYl6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAF3C433B1;
	Fri, 15 Mar 2024 14:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710512997;
	bh=2fcfnf6IWojwAjkJVFYBpNts+ogJLinSFTftkDm2+Ew=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WaqiYl6Yqq7REg+mKKkoYi/+rpaQWm5Po0vqvzJpOU+vTan2XArvvK+yDDjS82Pf9
	 pICo9wJHpTSVtJAEfxr4GBWEc2Gs+Qh6FKP+egbF1QHzrTe7eKHi15KzWPZRQ4j61N
	 r2kvXQeKTfQGgQMF9MedgnbLZIfmhI9Yzu8BRrsc6cvZkxy4UbG0HNzv1by71oTrJ2
	 s6hU7PK9SBxMeposPK3Be+nJ05DY2C4OHd6TvHzq+SghFF7NHSgdtLxOoPve2iEPjf
	 qGxUrwAhnZ9Q0nErYn5YnhjFElFjnrgYAWp8Hsz8SM2uhrT8GlqeVu95VdnC1b37pL
	 eeKWiWO40ADsA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 15 Mar 2024 15:29:29 +0100
Subject: [PATCH bpf-next v4 5/6] tools: sync include/uapi/linux/bpf.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-hid-bpf-sleepable-v4-5-5658f2540564@kernel.org>
References: <20240315-hid-bpf-sleepable-v4-0-5658f2540564@kernel.org>
In-Reply-To: <20240315-hid-bpf-sleepable-v4-0-5658f2540564@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710512973; l=1033;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=2fcfnf6IWojwAjkJVFYBpNts+ogJLinSFTftkDm2+Ew=;
 b=p7+eATGcycPy4c3F3tCschh/kT0RC5Se8rKv4lTXppzZubEWWRz0eQVIWswgZgtW6byCj123X
 WlCOau3vZOSBoY6sUU3REFN4QCmjCEHZ3ruyD9e5HI4YyWM9NI7VE6N
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

cp include/uapi/linux/bpf.h tools/include/uapi/linux/bpf.h

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

new in v4
---
 tools/include/uapi/linux/bpf.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 3c42b9f1bada..b90def29d796 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7461,10 +7461,14 @@ struct bpf_core_relo {
  *     - BPF_F_TIMER_ABS: Timeout passed is absolute time, by default it is
  *       relative to current time.
  *     - BPF_F_TIMER_CPU_PIN: Timer will be pinned to the CPU of the caller.
+ *     - BPF_F_TIMER_SLEEPABLE: Timer will run in a sleepable context, with
+ *       no guarantees of ordering nor timing (consider this as being just
+ *       offloaded immediately).
  */
 enum {
 	BPF_F_TIMER_ABS = (1ULL << 0),
 	BPF_F_TIMER_CPU_PIN = (1ULL << 1),
+	BPF_F_TIMER_SLEEPABLE = (1ULL << 2),
 };
 
 /* BPF numbers iterator state */

-- 
2.44.0


