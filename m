Return-Path: <linux-kselftest+bounces-2280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC68B81A863
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 22:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79653287D80
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 21:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A214C3B6;
	Wed, 20 Dec 2023 21:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWld8Gfh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05764C3A3;
	Wed, 20 Dec 2023 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-553a65b6ad4so179136a12.0;
        Wed, 20 Dec 2023 13:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703108431; x=1703713231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zka4zARObtbMJoYbSx8xKgCuE8KtqgISiEptwV6WR/w=;
        b=GWld8GfhenNWrbBo1cagVvuvnH4R0U9A9bcDfh9+cyBtsl+OF8/qsuPQYGJZhtdSxV
         4VOrjEauwGq3PoWisI4g5xzpdhc+dPli9Hwc78lphXuvS1V16EqQqqEWpPIyp29DGBUl
         qqiok4XeUoeial4BDzCWGW7jXOB/SUPcm15hKdVd8g7lg98afuVfoST/ojYGpIMEwxwk
         oM5kmmyUC5yrMW67iprfaI+7qgvw2rckMrNexVcquSCOYS+r6u/jHD2QUsmb38lH7D2Q
         auZ/dqVHgT57S18JVVMS9SvRc2PUuddgoqGEKc/BzyZeTk3LKzLR6gkVSgWQ40AsXIDe
         OZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703108431; x=1703713231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zka4zARObtbMJoYbSx8xKgCuE8KtqgISiEptwV6WR/w=;
        b=GFanHrY0Bc7Ha4dBBQA135ozYzxVeqocmMuinOu7D8lUt2Ak1WT4FNkzzqE0Xslmd1
         LfXdFHUanDlt3F5u+0HHFkE7UOKQ25Bh8WmXC1ryWqUXGiRZEfq6qqOOID7fTm68DVI0
         e+y4BUPOp38+nqsSY3qb1hAOZl0H3drrEOGksf1rUgEBkSrjVDylQsAOQpU84F4xTpxS
         gVmDJE9mEjPk62tAZWQAPhE+Jcp7HuHZCLiiGBXeZ5Hem2NZWUsmMpWH48/j+n8EnwEH
         lsD1oYcjRrJW9HOaz7o0npQzAk63PhzdLSgIsJbArOJfWpqhBAuaGut/48CZi9lJOxVo
         SrNw==
X-Gm-Message-State: AOJu0YwHskB9rH7X9TK5BqcR2bJ2OaP/1jQfHeH5JFyYn2UdWbujCLDk
	FrcTXs9Z/IVIA+D+NGEaDI8=
X-Google-Smtp-Source: AGHT+IHTNCI3gKBAnzAEiWESctwCI60HiBPLA1DkQbWIXScqb4HJel3vF/IyxT6cQs1KpYQsPQdFiA==
X-Received: by 2002:a50:8718:0:b0:553:c02:60c8 with SMTP id i24-20020a508718000000b005530c0260c8mr4150124edb.41.1703108431197;
        Wed, 20 Dec 2023 13:40:31 -0800 (PST)
Received: from localhost ([185.220.101.166])
        by smtp.gmail.com with ESMTPSA id q11-20020a056402248b00b00553165eb4f7sm296389eda.17.2023.12.20.13.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 13:40:30 -0800 (PST)
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
Subject: [PATCH bpf-next 03/15] selftests/bpf: check if imprecise stack spills confuse infinite loop detection
Date: Wed, 20 Dec 2023 23:40:01 +0200
Message-ID: <20231220214013.3327288-4-maxtram95@gmail.com>
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

Verify that infinite loop detection logic separates states with
identical register states but different imprecise scalars spilled to
stack.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_loops1.c     | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_loops1.c b/tools/testing/selftests/bpf/progs/verifier_loops1.c
index 71735dbf33d4..e07b43b78fd2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loops1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loops1.c
@@ -259,4 +259,28 @@ l0_%=:	r2 += r1;					\
 "	::: __clobber_all);
 }
 
+SEC("xdp")
+__success
+__naked void not_an_inifinite_loop(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	*(u64 *)(r10 - 8) = r0;				\
+	r0 = 0;						\
+loop_%=:						\
+	r0 = *(u64 *)(r10 - 8);				\
+	if r0 > 10 goto exit_%=;			\
+	r0 += 1;					\
+	*(u64 *)(r10 - 8) = r0;				\
+	r0 = 0;						\
+	goto loop_%=;					\
+exit_%=:						\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.42.1


