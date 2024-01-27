Return-Path: <linux-kselftest+bounces-3665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5D183EF3A
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 18:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092AD282523
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 17:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613922E413;
	Sat, 27 Jan 2024 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mANLIUib"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BA32D600;
	Sat, 27 Jan 2024 17:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706377982; cv=none; b=Bi+rd2yghQkjEuYJY31TxeT8HffgjQadArYKbnX3csU5qZglW+P7TCCmLy+6xDpDaT/u+w1spxqBGoH/awm3WoM8r+5k1lkyROOPtk/rL2gove4wAbliyoWaOlAe0tZi4IGJpT7AKfyZWBjT9M9ex5fKdrafznCUzIeFWmj1nPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706377982; c=relaxed/simple;
	bh=JGo/mjFx+TLftCJ2ezCKct2I+QubavYYCAKzoptDZiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pw0Fkpox1w9kLpI9vBGMpZzVTrEcC3IRQeSxRO75wiBG0G692+tKfs6VKYcTOwmLd96YipxjvehsNGrnAZypvEy61FKWSCMvu4hZ2Foadf1aKWsjShQi3bcrRw2d3cQsg8aZ1Omn9g+QK8Ow8E3dQb0dKjaDglycEKIH+3nQXp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mANLIUib; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a35385da5bbso81903866b.3;
        Sat, 27 Jan 2024 09:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706377979; x=1706982779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MI9xHIKdb/2hEcLbW3yAAuFkUxSisIY5fJfgmqAUs4=;
        b=mANLIUibW7i1jBMS73iEtbXa5zicER8a/+RQYk+vQ3Sq0fuDZ4K9WF+fm1sSfJlXPL
         y+MM4Tp8BgAsSU8u6p82Tiq1gLFF6IySaaOWsk5hQiXHC3eFT7sRV3vLktbBA0+P0gpr
         HGCoGTEmDUA8qT/l5q6pPwtWIubBdXD9FkVyeod+Jcj/1g19feOOm3/EouNrS6yompOj
         XyceVD4p3asQ3oWSsMdXoNN+AKzaQ5uaBzmU8qeYGrGg3cTKwVz8rTaAH01n0ZQZ7PVO
         I968NumTR/JD+OCH4CdY9cv+BdsnBgHoQ3jz5YcDcUwCf7zKrqvrivIlSeWBufHoCozz
         tsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706377979; x=1706982779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MI9xHIKdb/2hEcLbW3yAAuFkUxSisIY5fJfgmqAUs4=;
        b=B9EvDm+hmekf7GileRaUdwdwOt2zx1X4rnxwkdMJO6pzpOslbjWw+h5gm6iMZw1kvQ
         oQUEBRMQJWFIicyHbNByFVF7OnKHJvSPNVn285KVq9ookVYsbFgeBl8cZFke6uRvV9xg
         Gy4aj+ySDUHc18hHUDrIqXEGMyyCwpnUOwPHoGZGkF1tOljuBenZbW2DcbgZEQl6oiuF
         TMlLJ8kpwvSKbCcTKZ6Ogo1aS4XwXBvbXs7jSWDGcXaNYE8Q5Y/rHBGoppRe33Q4K5E/
         9Zy5nnkFlLknbljNnmBbC46wkKjpGvbdRdf+NpklG45wa+HsMuT6KUiOT/VXJE2DC7DF
         8MTA==
X-Gm-Message-State: AOJu0Yx5Y/AEvRNFwXs/lHqzRrcZ11uSQP52XWdxXTbKRDVL/629qvTi
	4ZRKvazKHIvXPJDqWTThcyXPRfAVkLrZIBI5iaGt4Y8C4Qgu6iAB
X-Google-Smtp-Source: AGHT+IGyVthHiGfPiNW/2LIzp6rHrBafev1u7RUi5gVhSs3gwx+oZRs2/tflkGDfEU/1Xnd/LTseqQ==
X-Received: by 2002:a17:906:451:b0:a27:c4d2:c649 with SMTP id e17-20020a170906045100b00a27c4d2c649mr1355554eja.59.1706377978529;
        Sat, 27 Jan 2024 09:52:58 -0800 (PST)
Received: from localhost ([185.220.101.170])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090699cc00b00a2cd74b743csm1960325ejn.3.2024.01.27.09.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 09:52:58 -0800 (PST)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH bpf-next v3 2/6] selftests/bpf: Test tracking spilled unbounded scalars
Date: Sat, 27 Jan 2024 19:52:33 +0200
Message-ID: <20240127175237.526726-3-maxtram95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127175237.526726-1-maxtram95@gmail.com>
References: <20240127175237.526726-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

The previous commit added tracking for unbounded scalars on spill. Add
the test case to check the new functionality.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_spill_fill.c | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 317806451762..f9803005e1c0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -940,4 +940,31 @@ l0_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+SEC("xdp")
+__description("spill unbounded reg, then range check src")
+__success __retval(0)
+__naked void spill_unbounded(void)
+{
+	asm volatile ("					\
+	/* Produce an unbounded scalar. */		\
+	call %[bpf_get_prandom_u32];			\
+	/* Spill r0 to stack. */			\
+	*(u64*)(r10 - 8) = r0;				\
+	/* Boundary check on r0. */			\
+	if r0 > 16 goto l0_%=;				\
+	/* Fill r0 from stack. */			\
+	r0 = *(u64*)(r10 - 8);				\
+	/* Boundary check on r0 with predetermined result. */\
+	if r0 <= 16 goto l0_%=;				\
+	/* Dead branch: the verifier should prune it. Do an invalid memory\
+	 * access if the verifier follows it.		\
+	 */						\
+	r0 = *(u64*)(r9 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


