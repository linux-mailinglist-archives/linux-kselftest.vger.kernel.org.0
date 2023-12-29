Return-Path: <linux-kselftest+bounces-2517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F0381FE13
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Dec 2023 09:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0784E1C215FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Dec 2023 08:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA14747E;
	Fri, 29 Dec 2023 08:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuXoRHEC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F70FBE5B;
	Fri, 29 Dec 2023 08:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-594ce2083easo1307806eaf.2;
        Fri, 29 Dec 2023 00:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703837749; x=1704442549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fx/xRh2yZAN/dIzMMw22oJlt78oBSy7m29BewV0UdHQ=;
        b=PuXoRHECrLv92KWM/Kv0zRTwM2Q6ctli2nIghelBRf0Sabj3s1TE1aFBUZni23x4Nc
         ioP8Pp9q9lTE9ydTtvUMK9Nq6qg1R/oj/+HmHtHs2y6iaIgZelMrJcFVqGF5Fe9wEu0H
         TSuwSwZxGhvnNT1a75MN5p1tohVaVsMT2yrQT+UyYE4AKTdcCufTBd22rjuao12D11eK
         Srvbs7/2gzfJzLNn61UDZ5uAVypSNwK634OuXKO05o+LT4W9FnCf8urxyU3Fn0s1gay2
         OAW+tUk2AOwXnMBKsnmx7KHOfJjyVJpYBI81IFx4HfbtIABWvEUduSrcpVDcD0OuU/bD
         CDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703837749; x=1704442549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fx/xRh2yZAN/dIzMMw22oJlt78oBSy7m29BewV0UdHQ=;
        b=wZ7HeoWn+T8iBY3VSp7iwzqte1+i1iJlRpLQtqnlVECWZxtEepi+23IeBEM5708Oox
         N25+e+BPvg1FpDA/midK2ChMLx56oNtf+cY22yrvjm3JiI4F4D2borkxIbNUPhzgihu2
         8vChe7HYpZmrbFI96qIW1DF0fB9R07eay7Opwj7Bu/0wxYiCRVzo9rCLytY59u+MV/zY
         En2JPS9zYLupy6I6VFW5+nfDjZFcYotCu6tS9fkJtU9aAYAGuG+hdVcoEsC7jlDfih1Y
         oYQr/MD77RHk8SAgDIyO1FitdZGmdJOEDYtaLQ+f4RkbKX8sUjz9SzrioqqrjzvNWkRJ
         3lfw==
X-Gm-Message-State: AOJu0YwxsXywhEhDmxHQyDp6LMBKrVm/Xp8SxeVVP1gtfULflQLK/puA
	RN/i2d9Fp0CGXQBxMVz88bg=
X-Google-Smtp-Source: AGHT+IEaI0UTS3540VkWNO0TEtKeRpMCD87S+x+b1mqv3mDtYLHwt99KlbZOc1fUEARf1CkUL6RLNg==
X-Received: by 2002:a05:6358:6f0a:b0:170:547a:306f with SMTP id r10-20020a0563586f0a00b00170547a306fmr13403432rwn.49.1703837749403;
        Fri, 29 Dec 2023 00:15:49 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id h12-20020a63df4c000000b005bd2b3a03eesm14339412pgj.6.2023.12.29.00.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 00:15:49 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org,
	horms@kernel.org,
	dhowells@redhat.com,
	linyunsheng@huawei.com,
	aleksander.lobakin@intel.com,
	joannelkoong@gmail.com,
	laoar.shao@gmail.com,
	kuifeng@meta.com,
	menglong8.dong@gmail.com,
	bjorn@rivosinc.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 2/2] testcases/bpf: add testcases for skb->csum to ctx_skb.c
Date: Fri, 29 Dec 2023 16:14:09 +0800
Message-Id: <20231229081409.1276386-3-menglong8.dong@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231229081409.1276386-1-menglong8.dong@gmail.com>
References: <20231229081409.1276386-1-menglong8.dong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The testcases for read/write access of skb->csum is added to ctx_skb.c.
And the read access testing for skb->ip_summed is also added.

Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
---
 .../testing/selftests/bpf/verifier/ctx_skb.c  | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/ctx_skb.c b/tools/testing/selftests/bpf/verifier/ctx_skb.c
index 0b394a7f7a2d..f15301686843 100644
--- a/tools/testing/selftests/bpf/verifier/ctx_skb.c
+++ b/tools/testing/selftests/bpf/verifier/ctx_skb.c
@@ -1193,3 +1193,46 @@
        .prog_type = BPF_PROG_TYPE_SK_SKB,
        .flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
+{
+	"valid access __sk_buff csum",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
+		    offsetof(struct __sk_buff, csum)),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+},
+{
+	"valid access __sk_buff ip_summed",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
+		    offsetof(struct __sk_buff, ip_summed)),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+},
+{
+	"check skb->csum is writeable by CLS/ACT",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+		    offsetof(struct __sk_buff, csum)),
+	BPF_EXIT_INSN(),
+	},
+	.result =  ACCEPT,
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.errstr = "invalid bpf_context access",
+},
+{
+	"check skb->ip_summed is not writeable",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+		    offsetof(struct __sk_buff, csum)),
+	BPF_EXIT_INSN(),
+	},
+	.result =  REJECT,
+	.errstr = "invalid bpf_context access",
+},
-- 
2.39.2


