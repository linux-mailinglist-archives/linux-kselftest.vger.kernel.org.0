Return-Path: <linux-kselftest+bounces-2725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B4A827985
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 21:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D78284C95
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 20:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E8A55E4E;
	Mon,  8 Jan 2024 20:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Haj2S4Sn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B2D5467C;
	Mon,  8 Jan 2024 20:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d5b89e2bfso24654625e9.0;
        Mon, 08 Jan 2024 12:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704747150; x=1705351950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcpIKqYveGeGHn6cD90ywmKwn6I2uEhHJBOWNqtefkQ=;
        b=Haj2S4Snz+sHGm6pYZcjXTJCyUTvVAzGIVeO2NfH3EViNMu+9MICyTtC0S80fNDyx/
         J574KDHlBiqaqQI6up/PWIH+L/NR+/ZkktxyyPhS3lRGssIsYvQSwoHWq6Tb5/42U6qm
         cXFQnYcex1kHh/Kc45W5xL1kZiqKLc6QiRKGl0hylJgN0TZZt3oF1cdDxp7CUqrJodDY
         yOMp+xDtj08I9yphoC13InRATin9UIzdxPWnGr+HuyjpJRAFDa44pbTYvoYZh04orUcj
         D5pR4psxfahOByXaxdSbbHhnTouSpzQKqqJk0kXdEqL7t9rdoperkSuuLORggXOhALMj
         0T5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704747150; x=1705351950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcpIKqYveGeGHn6cD90ywmKwn6I2uEhHJBOWNqtefkQ=;
        b=g2t+u+QNsgJZGQZY4pHyhhjvzzTKkiZ5oWnO65tOVedx68IvFbe0Xg2M6z/ou/Kffu
         qRIqAArm73Z01MG75A007zfeJEoLiwUIeB9RY61rdg9+Xrj60f52u2s4mRqxbyJebGKY
         DfPXt0iId6UXPrIhRQdk7LuqEXnGbKGDRYKVtOQyYivx9GNNtHLchuhnGvJtJytJ0uuo
         UA1czxGe6dVdqThRwMBafAvBsKx3nTOnHO1+DxQdO/sSBrzpYLhxoHq4tmaoVwGZaRgV
         J0NaC2CwXwhnQrj2w88YBBlWV38F5EiTcH0An58GbNR07spxq7cNVH2fBmT2pBzoCDym
         BwOQ==
X-Gm-Message-State: AOJu0YyLpARZKEa52IF/IdFO6OdtwYlz4N1Fli5ltAs/EgR4AwwJPe0e
	FbMuxSzauEwtM4PGjMFQ9IY=
X-Google-Smtp-Source: AGHT+IEwiEM59ky77aX66tOtT8D/NJ24ZEhLf4rRdES0knq3lbbfMz2kx3eDDI7of9nogarVR1xBcw==
X-Received: by 2002:a05:600c:1c24:b0:40e:46f5:e600 with SMTP id j36-20020a05600c1c2400b0040e46f5e600mr1281899wms.172.1704747149553;
        Mon, 08 Jan 2024 12:52:29 -0800 (PST)
Received: from localhost (tor-exit-1.zbau.f3netze.de. [185.220.100.252])
        by smtp.gmail.com with ESMTPSA id g21-20020a1709061e1500b00a26d20a48dasm239783ejj.125.2024.01.08.12.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 12:52:29 -0800 (PST)
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
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 02/15] bpf: make infinite loop detection in is_state_visited() exact
Date: Mon,  8 Jan 2024 22:51:56 +0200
Message-ID: <20240108205209.838365-3-maxtram95@gmail.com>
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
index adbf330d364b..bc565f445410 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17023,7 +17023,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			}
 			/* attempt to detect infinite loop to avoid unnecessary doomed work */
 			if (states_maybe_looping(&sl->state, cur) &&
-			    states_equal(env, &sl->state, cur, false) &&
+			    states_equal(env, &sl->state, cur, true) &&
 			    !iter_active_depths_differ(&sl->state, cur) &&
 			    sl->state.callback_unroll_depth == cur->callback_unroll_depth) {
 				verbose_linfo(env, insn_idx, "; ");
-- 
2.43.0


