Return-Path: <linux-kselftest+bounces-2724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E98C6827983
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 21:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871241F23EFA
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 20:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDE155E46;
	Mon,  8 Jan 2024 20:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jk0yMxdG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6593555C22;
	Mon,  8 Jan 2024 20:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a28b0207c1dso171177966b.3;
        Mon, 08 Jan 2024 12:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704747146; x=1705351946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaxOHT3a3aj7XU+MlOSUS+lYj9x+w+wZqme7TuQY4L8=;
        b=Jk0yMxdGoDV6mnpOo3Oe1BrZ7Ca6h4SFSowTyN2XER0ss5nj/TC4egALXl7to5cBrO
         C6sRZxf2tX+jQk7Ss3rkbcjCE1T7sf2EzBD/DNEq1crSmkMxj5B/btE8H85ECUtXoGhX
         d4hMiN62PvQCVkD2/54K12rChog2WzJvxT4PKawmm0MupyL6KPYwtZ9OQDD2PfIQ1uZj
         btikTwNghvwD/24lW69r0LLfSoqg5glOpZokKMaD9KYIRJiXdOOipN9JGeMcDVxxwzi9
         oeSRvT5PNeYPuDY2vyoU2wns5zL8ro6IvYMaXmYITqqLzyzOZYX/QUlnA8lBGpeI8+kO
         2ZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704747146; x=1705351946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KaxOHT3a3aj7XU+MlOSUS+lYj9x+w+wZqme7TuQY4L8=;
        b=ZpSB7QDSlv+p+yZmOPwrbMlJt+fk38MNtxcZ7rtvcXnRorb9cE0krYxLnMhmZ65E0J
         FKs9UJTzl+8FEvESyvwxKQmxkmNGO4MbGnrWTgUB/2XuanR2Db/reAvUp6/7v6Whkbgk
         rR05+5D6rNqcHWnJ9ckZRboEHrhhQvxTt0xWRoSdwYCzF7xBcnIeFyfMSz3OkB/Q4gVB
         mombCnBhlEMwdhLjctrVYzxEkoVmsO2pSjvTd/AJtMaxBxFYK2AO9ctOFMpRlkorlCB0
         UUn8OpUxiOTdREaM1Cjt89y7rMIDMD4nf5zmBeNpm0demYD/b4qIQVLAoBpXj1yLUkbf
         DFqA==
X-Gm-Message-State: AOJu0YzceD5YwRoV77+0XhGoJAftyD7yN0h8xFzsQ8DLrYrXk5jQ+TkW
	kFmKEwsCXS7kE0ZHIYnWIoE=
X-Google-Smtp-Source: AGHT+IEZ5/zhC7YksxwtEfQclyBATbEzAa8gfneSehB0Lnw+m8uZNEFETukkqmJFXPjvPzE0uzxLyg==
X-Received: by 2002:a17:906:5610:b0:a18:4b1b:9522 with SMTP id f16-20020a170906561000b00a184b1b9522mr11099ejq.41.1704747145526;
        Mon, 08 Jan 2024 12:52:25 -0800 (PST)
Received: from localhost (tor-exit-1.zbau.f3netze.de. [185.220.100.252])
        by smtp.gmail.com with ESMTPSA id l19-20020a1709062a9300b00a26a5632d8fsm250209eje.13.2024.01.08.12.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 12:52:25 -0800 (PST)
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
Subject: [PATCH bpf-next v2 01/15] selftests/bpf: Fix the u64_offset_to_skb_data test
Date: Mon,  8 Jan 2024 22:51:55 +0200
Message-ID: <20240108205209.838365-2-maxtram95@gmail.com>
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

The u64_offset_to_skb_data test is supposed to make a 64-bit fill, but
instead makes a 16-bit one. Fix the test according to its intention and
update the comments accordingly (umax is no longer 0xffff). The 16-bit
fill is covered by u16_offset_to_skb_data.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_spill_fill.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 39fe3372e0e0..848f2930f599 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -243,7 +243,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("tc")
 __description("Spill u32 const scalars.  Refill as u64.  Offset to skb->data")
-__failure __msg("invalid access to packet")
+__failure __msg("math between pkt pointer and register with unbounded min value is not allowed")
 __naked void u64_offset_to_skb_data(void)
 {
 	asm volatile ("					\
@@ -253,13 +253,11 @@ __naked void u64_offset_to_skb_data(void)
 	w7 = 20;					\
 	*(u32*)(r10 - 4) = r6;				\
 	*(u32*)(r10 - 8) = r7;				\
-	r4 = *(u16*)(r10 - 8);				\
+	r4 = *(u64*)(r10 - 8);				\
 	r0 = r2;					\
-	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */\
+	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4= */	\
 	r0 += r4;					\
-	/* if (r0 > r3) R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=umax=65535 */\
 	if r0 > r3 goto l0_%=;				\
-	/* r0 = *(u32 *)r2 R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=20 */\
 	r0 = *(u32*)(r2 + 0);				\
 l0_%=:	r0 = 0;						\
 	exit;						\
-- 
2.43.0


