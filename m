Return-Path: <linux-kselftest+bounces-2278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C401F81A85D
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 22:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D5D1C22F5A
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 21:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F0C4BA9F;
	Wed, 20 Dec 2023 21:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/40Nbgg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43AF48CF4;
	Wed, 20 Dec 2023 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a22f59c6ae6so12339166b.1;
        Wed, 20 Dec 2023 13:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703108427; x=1703713227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLk8SAJ8ZFWGDqxLKtNRR7m+7/3ll3qzy9xQyT4uoH8=;
        b=f/40NbggRbKolqHe/NP9ZbVkSlmMLdxq1Xi9fXoZztwFP4JGcpPNxN7PFffIF933ZL
         IOIM8+7EZpsNWa9vJQaaBv6q2SjOt87QtCwoEQTjsJD89HYdYu/K5lYhXcdbsN4jJ3SR
         5sh9KbwlP/16D4FIvdw2Oe0UFb6asMyRH5bmnwW3fdwSXxk/PBX+XufjGmSM/wz2a52N
         UEq4P71UWvWGX6b5JojWcSubdbu6Gmj0LiDIi4xGW8t5huk2E5xNFco8Xto2qpQGxAKx
         U08Kb90CGHYIZN0IIvD1Q1jlJ1GaQwQt3xvitWkh+9MLFYfdx4mHz9lHhxPrsGtU/Id5
         Docg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703108427; x=1703713227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLk8SAJ8ZFWGDqxLKtNRR7m+7/3ll3qzy9xQyT4uoH8=;
        b=saZQCNgjNjCsOW5T4mRiIHiXWFG1kG6HJ5V6ACREzD9+/1Qs4pCYADqdU0thxxvfY2
         EeEvOxwlDjSkE6EYEqNylcoBm9mdDqu8LqRaOqAeVQvuvpx4DV00OSc/j5/YvqTw/sSG
         NBSiQckIoH7xrNTmT68IIdpUUtzupgP2y9GNvezkxpn585t+qBowxDqSMMGXgdxTaetk
         Imqsh1S8mRvl56QQdLV6FbQn/zRNa3bajq4yV2SV+2AvudDhZVFpo8B+tFGHtwxuw8PU
         na/2E2QoV4g2vibkPpPG1yK8N6tlYveAI5gq9+J8g4urlAlBV564MzC9I37HKkNcj3UI
         58bQ==
X-Gm-Message-State: AOJu0YwRtZa88H1R+ZYnC1BCp5YWHnl3L6YdhjKoU9m9KnWXplXgKcPv
	ctl1VO2V97wyLm7m5xgd9zM=
X-Google-Smtp-Source: AGHT+IHdNw8vTwvCHrE42VS8buZlxIEHPQZSyoUKFDv0SqeNRMQfq8lFyJWXenuAK6QaoJqdmeLveQ==
X-Received: by 2002:a17:906:101b:b0:a23:713d:57c0 with SMTP id 27-20020a170906101b00b00a23713d57c0mr888187ejm.234.1703108426941;
        Wed, 20 Dec 2023 13:40:26 -0800 (PST)
Received: from localhost ([185.220.101.166])
        by smtp.gmail.com with ESMTPSA id jo23-20020a170906f6d700b00a268e4757b2sm240393ejb.143.2023.12.20.13.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 13:40:26 -0800 (PST)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
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
Subject: [PATCH bpf-next 01/15] selftests/bpf: Fix the u64_offset_to_skb_data test
Date: Wed, 20 Dec 2023 23:39:59 +0200
Message-ID: <20231220214013.3327288-2-maxtram95@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231220214013.3327288-1-maxtram95@gmail.com>
References: <20231220214013.3327288-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

The u64_offset_to_skb_data test is supposed to make a 64-bit fill, but
instead makes a 16-bit one. Fix the test according to its intention. The
16-bit fill is covered by u16_offset_to_skb_data.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 tools/testing/selftests/bpf/progs/verifier_spill_fill.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 39fe3372e0e0..84eccab36582 100644
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
@@ -253,7 +253,7 @@ __naked void u64_offset_to_skb_data(void)
 	w7 = 20;					\
 	*(u32*)(r10 - 4) = r6;				\
 	*(u32*)(r10 - 8) = r7;				\
-	r4 = *(u16*)(r10 - 8);				\
+	r4 = *(u64*)(r10 - 8);				\
 	r0 = r2;					\
 	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */\
 	r0 += r4;					\
-- 
2.42.1


