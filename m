Return-Path: <linux-kselftest+bounces-14218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B23E593C010
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 12:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53171C2152F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 10:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9D4198E9E;
	Thu, 25 Jul 2024 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iwf0swFr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1790E198E80;
	Thu, 25 Jul 2024 10:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721903963; cv=none; b=CknqxZy0IHBN8RFPba+Lj2uGjTBAgsIaqtOYQ+0kL00LFbTMIVvdv7RI71+tDWjcCa4VPi2G7I5CNUgjtOpemeP+VpABMOUSyew5d4a0FvUKH/LfTyj64kC+MLJ+nYRuZoCbpjSvgpUwT7ppJkPnM5jleqrvSxVbofgbrX5FbU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721903963; c=relaxed/simple;
	bh=b2eopH9P05jws6B3FttawjClEaNYLSZjTY6eEAmx1IY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p/XfDLkNGstZJUWZexlfFZYP+ZzvAIUFM4v4icnjIsYQQQu5zTDEUYTK46IWCEXeBaWorI26RdjRB7cSyKdfAmEND1YxRo0virTiicFvx2BuxJ5RBHIEIgCVgaU2zx//FNrDSDvIbPL0s9Sx6kowLsYxpDWkIxkGoTnHxG7/o5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iwf0swFr; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fd640a6454so7096035ad.3;
        Thu, 25 Jul 2024 03:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721903961; x=1722508761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPj4UrGFYxLYkSohWfAYYA0VUXQB0pTvzNeY+UOm5uo=;
        b=Iwf0swFrInIzC1KLglwfm8fvdeEv553HT4OGyWs/6Lkd48VUiu7sRQKqud8a1UhYXy
         +1KFON+sxKD5VwKpO+TD3FYkxUMjO13/NvQ2YjJIRJ4H56/B4OVv9A6kZsIBzQZ3AtUq
         iX/8ZfruqBDv1ecULtiMGxGRg39ontQvjPE0GRyD7ENHi6tFriwDg/rss1/3odQJ4fqn
         ImOf9GDYnO7PIRnQcmlMy/tzXY+ZRYVvzpfRlBnlgNWy8F48rMebp3o1LqtreKjRbd6N
         4csEuCk2ilJn1uWCaaAHiuTPdHouuzN4V8uTOacU6gUeXewqTpb2WDTxPjri91Jm4lNs
         +aMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721903961; x=1722508761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPj4UrGFYxLYkSohWfAYYA0VUXQB0pTvzNeY+UOm5uo=;
        b=tlaZ5kYbbROmVOqQzQoXYMHd8kI9uc3/AUYT+aHFMUqDlm78HxVPxrzHYELtGOkyEo
         FwDjQrXog/NHAZJRdN3Zkp5osH14PP50kpFwLEqZsQkum6eyHKGUb7+XlBZI/46TQoWj
         SRkxSxWI+CoRzN4Dq4a+3kXW/7WLqJBB0otUjYEuJJ3PewokgX4WVP2R+kdjvUc+qFxT
         K6/+Qq+Ld7Mf7Vg+577VQHvpczFbELPeaQBJx64+hZLk/V7gRYwwQ+eT3FdlFuq7SBKM
         3nQxLjrz7PU6oCpadiSnxzxk3oeDw1AB9qQLhB8B6T9DvhK3gl+7FLt8LIiUNkkNv4YN
         Ib/g==
X-Forwarded-Encrypted: i=1; AJvYcCXeVKOhDjAgXQ21b+LrWhGXLZJQc56BNRD35Y+y7wafVW5J397XfUCOOgXy6+aX4wKwnInnOXAJGGwU6uJ9VEWqDlxunSBKy2Pv2kCRlac9l2i52SHe/Ar60L36MZ0843Q7FIXDVXp7
X-Gm-Message-State: AOJu0YxMCQBP/0rxpX5Zoluj1DIPVif5jbIys7emxZACss1wiUXjYdQD
	Jxx8d979B+NMgRchEx7b5gCuEe1IYawpGvpHhgsLezKxsvIXi98A0ckeMDC2
X-Google-Smtp-Source: AGHT+IFomPSqd48Y8JT/fht4rfbWgYahdQgdWbH5Bbu1k5axGHfLIFiOdBetRUJKvS3XBZ/mJjp6Lg==
X-Received: by 2002:a17:903:41c8:b0:1fc:6a81:c5a1 with SMTP id d9443c01a7336-1fed35360demr29712495ad.12.1721903961235;
        Thu, 25 Jul 2024 03:39:21 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f78491sm10991075ad.244.2024.07.25.03.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 03:39:21 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <itugrok@yahoo.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Yan Zhai <yan@cloudflare.com>
Subject: [PATCH bpf-next v1 3/8] selftests/bpf: Fix error compiling test_lru_map.c
Date: Thu, 25 Jul 2024 03:35:55 -0700
Message-Id: <13890669483d34ef1c89a3c79b726f6dba442bf9.1721903630.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721903630.git.tony.ambardar@gmail.com>
References: <cover.1721903630.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Ambardar <tony.ambardar@gmail.com>

Although the post-increment in macro 'CPU_SET(next++, &cpuset)' seems safe,
the sequencing can raise compile errors, so move the increment outside the
macro. This avoids an error seen using gcc 12.3.0 for mips64el/musl-libc:

  In file included from test_lru_map.c:11:
  test_lru_map.c: In function 'sched_next_online':
  test_lru_map.c:129:29: error: operation on 'next' may be undefined [-Werror=sequence-point]
    129 |                 CPU_SET(next++, &cpuset);
        |                             ^
  cc1: all warnings being treated as errors

Fixes: 3fbfadce6012 ("bpf: Fix test_lru_sanity5() in test_lru_map.c")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/test_lru_map.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_lru_map.c b/tools/testing/selftests/bpf/test_lru_map.c
index 4d0650cfb5cd..fda7589c5023 100644
--- a/tools/testing/selftests/bpf/test_lru_map.c
+++ b/tools/testing/selftests/bpf/test_lru_map.c
@@ -126,7 +126,8 @@ static int sched_next_online(int pid, int *next_to_try)
 
 	while (next < nr_cpus) {
 		CPU_ZERO(&cpuset);
-		CPU_SET(next++, &cpuset);
+		CPU_SET(next, &cpuset);
+		next++;
 		if (!sched_setaffinity(pid, sizeof(cpuset), &cpuset)) {
 			ret = 0;
 			break;
-- 
2.34.1


