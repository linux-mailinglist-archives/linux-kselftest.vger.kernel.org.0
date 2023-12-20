Return-Path: <linux-kselftest+bounces-2279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A5181A860
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 22:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA81F1F241A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 21:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD6F4BAB7;
	Wed, 20 Dec 2023 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiZD02o9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F044E4BAAE;
	Wed, 20 Dec 2023 21:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2343c31c4bso12215366b.1;
        Wed, 20 Dec 2023 13:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703108429; x=1703713229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PXHJ62Jn+WSXkqHLjoo0Vmkp5AYsgfUhivyvdOpnBc=;
        b=RiZD02o9tXGegRY9/uZ5wKiHWKCs/zHd4oEKWxX9lGZ6kSFKsLaJ+/vpYm5mvkO8Ou
         aC28VZva0QBbZIeE8w8blE2KUvpD2+aGNtBqczhR7gfJIrERF9cYueiozUuYs4RF7VRc
         D8zUdBCWcFo61hRMY6IGBPO9GXus0CXW5cfGBK8kFJytJXmF3lijgMnurp0OV+g6Utt7
         6bMgDWHieT/qUCpMn7+WxfwCvd6QBrvyHDvm2FrP8h79cczP/RbJO6HuZ0KB0mkafCnI
         z+dDbgAgWu+Z7XmQNihsmKNTojIokhopEAuwOh7GqXBboYFHUF5dCA7dyHlpNuYB8XN4
         PQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703108429; x=1703713229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PXHJ62Jn+WSXkqHLjoo0Vmkp5AYsgfUhivyvdOpnBc=;
        b=OGNzWtb9V/i91IunyQR11ElU+6Ap7AWKc9A0KnwUkqbCdjvqQxk1P+3YhFV4fXQvUY
         8UzrrU8SQFwnOdlA13WvEErV5ZRjpRKQ7o9pgfYC0XRyvC7qLay+oYwLxmsYlxpTNpSh
         4p2+iYJTP14voHaI0L8wxFeJKNjvrbE8hHhIUzdXQZ8BHeQbkIXxYsLz9jY65YZsyR9w
         ATO2R4FJE3te3gys5ncDqfQlQQmfFWEhZ02V2ENpwm1EzFWYbgrgFz4c99WakLt8mhbq
         FxnFoFAKcbF+mA0M0lYLaoPdKyy2jQs5TZG4PwcwBSBiW9OLn+hgggtYNSho5hMsIqMQ
         eNYA==
X-Gm-Message-State: AOJu0YzY8b+RFiCqOxFUAH+uDLzfM7/W/jWtcn8tH3/MgiLGazQVxOua
	JdGzyXbaQ4boHubYxFGAdIA=
X-Google-Smtp-Source: AGHT+IGsKrXHxXuPNTkqzxBxD9e4xxM/iXB1VsudclaXB4re8Jkj5EnbajTSWYjFpuKNT94uTUkD4g==
X-Received: by 2002:a17:906:20d4:b0:a23:3571:6c8b with SMTP id c20-20020a17090620d400b00a2335716c8bmr2440063ejc.123.1703108429091;
        Wed, 20 Dec 2023 13:40:29 -0800 (PST)
Received: from localhost ([185.220.101.166])
        by smtp.gmail.com with ESMTPSA id w10-20020a170906d20a00b00a1d9c81418esm238509ejz.170.2023.12.20.13.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 13:40:28 -0800 (PST)
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
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 02/15] bpf: make infinite loop detection in is_state_visited() exact
Date: Wed, 20 Dec 2023 23:40:00 +0200
Message-ID: <20231220214013.3327288-3-maxtram95@gmail.com>
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

From: Eduard Zingerman <eddyz87@gmail.com>

Current infinite loops detection mechanism is speculative:
- first, states_maybe_looping() check is done which simply does memcmp
  for R1-R10 in current frame;
- second, states_equal(..., exact=false) is called. With exact=false
  states_equal() would compare scalars for equality only if in old
  state scalar has precision mark.

Such logic might be problematic if compiler makes some unlucky stack
spill/fill decisions. An artificial example of a false positive looks
as follows:

        r0 = ... unknown scalar ...
        r0 &= 0xff;
        *(u64 *)(r10 - 8) = r0;
        r0 = 0;
    loop:
        r0 = *(u64 *)(r10 - 8);
        if r0 > 10 goto exit_;
        r0 += 1;
        *(u64 *)(r10 - 8) = r0;
        r0 = 0;
        goto loop;

This commit updates call to states_equal to use exact=true, forcing
all scalar comparisons to be exact.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f13008d27f35..89f8c527ed3c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17008,7 +17008,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			}
 			/* attempt to detect infinite loop to avoid unnecessary doomed work */
 			if (states_maybe_looping(&sl->state, cur) &&
-			    states_equal(env, &sl->state, cur, false) &&
+			    states_equal(env, &sl->state, cur, true) &&
 			    !iter_active_depths_differ(&sl->state, cur) &&
 			    sl->state.callback_unroll_depth == cur->callback_unroll_depth) {
 				verbose_linfo(env, insn_idx, "; ");
-- 
2.42.1


