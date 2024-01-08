Return-Path: <linux-kselftest+bounces-2734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3515F8279A0
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 21:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F0C1F24044
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 20:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC7F56458;
	Mon,  8 Jan 2024 20:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOrlTbdq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0856355776;
	Mon,  8 Jan 2024 20:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a28fb463a28so225042866b.3;
        Mon, 08 Jan 2024 12:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704747200; x=1705352000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHtIR9EAB6yZ4OYaEE1Ew9mP0VH0SKAUUWk1oh8IBPI=;
        b=WOrlTbdqmnn6BIVElRBMLnuRDE04eT81re+o+ob55RxcIKolX0ItHxBTqi2UNr7y1l
         9fzqqjBZeCsMZJMD6NJHqo0TiTBAsO41zh1wF3ygvaWaXAhL6oGcx/HrgNO4vgW9YvJ/
         t83Pnw1jWmRlisi8mcZIK1cCNbYnh9EA0gls/WtQgS41HUImD2tHHxKrAt1M50EzyRQK
         M7NakBY7izXXK1R7OfmJkqnkFVOvf80yoXMCLxFWvwVtGJZoPnlWXTr3OEJo4w6BRaaJ
         GXTOFqXck/u39jhvbAcoE/W6UDgSSynVF8JL9sx4G6C0AvwCTsZCy15LP8QKgxa9Qk1J
         LvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704747200; x=1705352000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHtIR9EAB6yZ4OYaEE1Ew9mP0VH0SKAUUWk1oh8IBPI=;
        b=CACDRE96ralVqRr+2HZqGb6dTM7aEKcDBFK6d/RBXlxk5sqBZwn/dFux8hcdSuHcwb
         F5miszT3uKbrssy50M8D0ZpSKRI7EiZhegMv+nBazBSMDoMvGikl5RP3OuDaDL4ctI2P
         +4CajVHoDH+ijd9JCo+VoRb2mMy7q019V650b7pWLfueRKns88NpacXSu4x5QeP/RiiD
         ieEJrmDMJjQW2N6VUg5hL52wcJ2/eUfGZeZTcB06Kk7eWd2axhUoiGgK02o6dSnLHiTF
         UWwz8cOe3oR3xLcEFu/u2XPsIq7vHBATrfTXERoSSdLrFo0aF0RRbjuxLp1As9LLCaKP
         qCHQ==
X-Gm-Message-State: AOJu0YyguXWxQniqxJiImV5J5Tj8WB0cuyXdOILXCFZfTd7GydhTTnHz
	kDnc+t2vikjNPDYb8YYGV0o=
X-Google-Smtp-Source: AGHT+IGJoMCX9W+pG0MMsn3NOMoijN9+KI8+bd7cS8LWg2qUPDRn3c1WMcmewJWaAgqVMwChqzwHVA==
X-Received: by 2002:a17:907:7615:b0:a27:e0ae:99a8 with SMTP id jx21-20020a170907761500b00a27e0ae99a8mr10292ejc.145.1704747200306;
        Mon, 08 Jan 2024 12:53:20 -0800 (PST)
Received: from localhost ([185.220.101.80])
        by smtp.gmail.com with ESMTPSA id p11-20020a170906140b00b00a26b3f29f3dsm248401ejc.43.2024.01.08.12.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 12:53:20 -0800 (PST)
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
Subject: [PATCH bpf-next v2 11/15] selftests/bpf: Test tracking spilled unbounded scalars
Date: Mon,  8 Jan 2024 22:52:05 +0200
Message-ID: <20240108205209.838365-12-maxtram95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108205209.838365-1-maxtram95@gmail.com>
References: <20240108205209.838365-1-maxtram95@gmail.com>
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
index 57eb70e100a3..cc6c5a3b464b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -899,4 +899,31 @@ l0_%=:	r0 = 0;						\
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


