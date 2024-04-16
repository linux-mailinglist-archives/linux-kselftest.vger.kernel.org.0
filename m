Return-Path: <linux-kselftest+bounces-8144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888528A6D9E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467FA28747C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 14:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05B21332A1;
	Tue, 16 Apr 2024 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C07FtjL1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95878133293;
	Tue, 16 Apr 2024 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276644; cv=none; b=qUcH2c7wYmKoxuiSvHow68QZ3jqtLaG4v2tMmYMw/lAFloSkGSa59v30qLg+nRUSPrswrizIEEYGcPmkpqJT1Yhf+LerOYH5WsuBAClKbuXFPweE1Jiht+jnn1/hr5qjn2YxcgDEzlnE557bZZx/QV6+8fjngoEBc352T3M1F6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276644; c=relaxed/simple;
	bh=Wbo+jTnF7UNG9GPzXTp/Kv/A9HSwxFmESxWeYRoaofM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hXJTF0YmmcyimB4HK4FlOPptVBE4wfpht+OREQH+0r5So0mmUH9m5JYFNM9Z0Dk3Qdn+bU3IbVAiWWa5jU9SEi/bolhCaps+hSM/KkQYNWNwUvsiMUzHQwXLpaZDHdciuzr/hm1SM4cY29xB0/o6cqUMK9rnDg26guzuk6/yLhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C07FtjL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3FDC113CE;
	Tue, 16 Apr 2024 14:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713276644;
	bh=Wbo+jTnF7UNG9GPzXTp/Kv/A9HSwxFmESxWeYRoaofM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C07FtjL1fSZVEO4J7iwoDlEzaAIek9xPBjKZziJf3HOIa6TPM49qRlfrMThuLd4zW
	 jXHXWRKT2hBvt2K0KBtPGW6dUY9MIwZLlfzRQaBI2AW6ggYBT3HVGiEcmL45Jy2OOV
	 sXi/tHbRpE7QYFU5e0OfyQr8M4ajcg7R+FDR7u5/Zjzgi5yJ4Vd6NQc1nf3y7N/JJf
	 WeD4hOiv2EYNEVf5kz1fYqg40QvsY/maNb+6a5V0AGdIIFxK1hXh8GJn86YEDxiHJ3
	 qImAg/4SLHI3a2dIpoDa5125BsEmEqMDBjaTqwSpUiQ1x449Kb40PITm4xzduU/EkA
	 dFzRgfs45tmnQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 16 Apr 2024 16:08:25 +0200
Subject: [PATCH bpf-next 12/18] tools: sync include/uapi/linux/bpf.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-bpf_wq-v1-12-c9e66092f842@kernel.org>
References: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
In-Reply-To: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713276593; l=785;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=Wbo+jTnF7UNG9GPzXTp/Kv/A9HSwxFmESxWeYRoaofM=;
 b=gaHcM6/jsovDNkSeKfzaVGacq0f8WUTta54Xs16cVrsjx6nIVtAtpaJnFrLxWEDDhJi2rpgAQ
 TYiDQSQO70FC0Cs8psJSomQWojnRHwNK5f3epGrf8X8CHZgfZyiq7gL
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

cp include/uapi/linux/bpf.h tools/include/uapi/linux/bpf.h

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/include/uapi/linux/bpf.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e4ae83550fb3..519f6019d158 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7502,4 +7502,13 @@ struct bpf_iter_num {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+/*
+ * Flags to control bpf_wq_init() and bpf_wq_set_callback() behaviour.
+ *     - BPF_F_WQ_SLEEPABLE: the callback needs to run in
+ *       a sleepable context
+ */
+enum {
+	BPF_F_WQ_SLEEPABLE = (1ULL << 0),
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */

-- 
2.44.0


