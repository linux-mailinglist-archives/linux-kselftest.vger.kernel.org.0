Return-Path: <linux-kselftest+bounces-47579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFAACBD092
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Dec 2025 09:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D4A630206BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Dec 2025 08:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88F93328F3;
	Mon, 15 Dec 2025 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8PmiV8n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFB13321D4
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Dec 2025 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765788635; cv=none; b=X0aPIeKZuwAQmscGoEBfbkJIqGR3dkSN8qhKgSn8KVH2+klo+63uMdFqR0vAdCAuGHpSB7BkLyEpO1MnUTx7BJ3QLHFxCJewQK8ALpOhkrEYe/KTYc+0blUn0aBRWVPQ6ScnzBn7GDhKgJmJiowAVZ0V+9hgCaPHYEO+WNkvux4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765788635; c=relaxed/simple;
	bh=UNJhjhBfdgMb0hckhX2MFxw95f5+0F9VDFTwddpYTEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R7LA1Xzv66e4ea8NUPLTRc/AwOuDMCvf4LtsdwF9kpt0/9bm/z7pC1A0MBcZIzXkOFLKJu8w0434p+J9SvLO2ECtHZ8Kv0iDqHVESb/e2n41/9gafMOmwa4x/G5por+Vu89DgvxLuu+J9xC6GJj8MRUMwJkNNs5nrVOgDI5T7Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8PmiV8n; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so2495452b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Dec 2025 00:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765788631; x=1766393431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4cLICT+Xfx3iSAb03bNjdxgJ5nQ9eDd3fe2nx7UuqzU=;
        b=F8PmiV8n/GRwHprSfCViasNwFUV8VTbwNZ2Va7kQe9QOA3n9d/SnsuxG9rzJ3O7v56
         2Y6WpgeBBFOZByZPd7ErRDo+aPgvEp+dcoS8qvKpbC6IUM+9NMzyTTQsN6fDv11gtHZR
         nV9lFG+aGTPwc1zAfOhJqcNHwoL9f8TRIMqK1TPZLuwZBWHqskKNlSpRLXg1ytamv2rA
         AlbF7FpilkAgZu085S2YlOb54Up6FvluLQHVE5J4Lbmowf1Ajy1l92cOw+Zqyz/i0a0Y
         5N4PtxAVu5ke+5qbF9eZC+JRrvdt+mO6YdAq1t76i2W5j8EQ3U3hAZB3wPXOR2H6amon
         fzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765788631; x=1766393431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cLICT+Xfx3iSAb03bNjdxgJ5nQ9eDd3fe2nx7UuqzU=;
        b=iSu4mRV0aPNrMv8cB8/9KnxNcMtnQXAzsllr1k14+4x14i+s3fqIbqwnA/+8pJ3MGf
         D0I+FTmW+Sa8ZinT6uhzcEsivq4k2x8MlGp86knNlA+tpci2R+FZu+9Ifb7qGGuQBqWK
         mO52C+dobdsZAZDjeVtpRXxCKSfaTiRCo9ZXF5bNLeUuAfvYwu6WD3WUC8fEa5Jl+WlS
         N0H65vUtgHZjgWdJ4VQmTnZ5DB3XZlZPM1gSzSRIqHJCx2PfMEwF2Cb4/538oy0GIVkb
         5U1moX0QBK7bP8ZVyTZdmBcDs7BwEjJKf8qNWSzjUakxsS+Rk5kMumGz6k8T35POhly+
         8zaA==
X-Gm-Message-State: AOJu0YzAi2OKizVnKgankt3zkjia1rPG+ctV0M1ckIdMi7Wr/C8LuJC+
	D4sc55OlDf4bJIeB4GqpsX80sgM2kqWmAmcUHLj70Cot4NyyqpIPNP0p
X-Gm-Gg: AY/fxX7moeoTKyvCLj48J+M7p9pDA2cwP5KlraLa+cHGPskYJzIlLyTX6/Ms8GSJVlj
	uGYh1CZx32dtZw3YHG1suCKoqP9l/P237l/A9IFaXBCvcMph0FpW+OP6HOICHMalyUV40T/roS/
	2E8y6HDhHYDbfBlq38i2UEYQ0ZuEtKzcFeWlQj+gJkU6xMzV962vs9vQxT9dD63osICxXMeTGFq
	X7CjIVk/RGuvGALO5gX0npMIIVH8T7C2EJi/VEt239TX1FPEWUrZHxZHwaiKyOxyjgNKBiCgU70
	ekON+dRL7SCAJPG57vHU4i1YtBf+n+EpKJe5RbQamCdEF87CGrSftj5ZdR1s5w8hTJTJEuHuBxf
	Fhjk1VWhNX5v2s7GG1RXjQH6Noa/aiMDaK1+rYKw3TUAjvGIJZXAespXL5x9Pj3S5h09d0zNJTz
	iATTbqW1WEfgOe/Tr956qiOIpRBJ3O0FYixTo=
X-Google-Smtp-Source: AGHT+IHkiONbozf9pjfNVTzEsjplZ/PllBupKMp54qcU+ah02z/Rx4CDnQ/3DyFEalYJchKrsKO91w==
X-Received: by 2002:a05:6a00:4510:b0:7e8:43f5:bd44 with SMTP id d2e1a72fcca58-7f6696a3da1mr9612737b3a.48.1765788631390;
        Mon, 15 Dec 2025 00:50:31 -0800 (PST)
Received: from clint-ThinkPad-L14-Gen-2.. ([110.226.180.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c4e9d9e3sm11976334b3a.45.2025.12.15.00.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 00:50:30 -0800 (PST)
From: Clint George <clintbgeorge@gmail.com>
To: ming.lei@redhat.com,
	skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	khalid@kernel.org,
	Clint George <clintbgeorge@gmail.com>
Subject: [PATCH] kselftest/kublk: include message in _Static_assert for C11 compatibility
Date: Mon, 15 Dec 2025 14:20:22 +0530
Message-ID: <20251215085022.7642-1-clintbgeorge@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add descriptive message in the _Static_assert to comply with the C11
standard requirement to prevent compiler from throwing out error. The
compiler throws an error when _Static_assert is used without a message as
that is a C23 extension.

Signed-off-by: Clint George <clintbgeorge@gmail.com>
---

[] Testing:
The diff between before and after of running the kselftest test of the
module shows no regression on system with x86 architecture

Let me know if any more testing is needed to be done


[] Error log:
~/Desktop/kernel-dev/linux-v1/tools/testing/selftests/ublk$ make LLVM=1 W=1
  CC       kublk
In file included from kublk.c:6:
./kublk.h:220:43: error: '_Static_assert' with no message is a C23 extension [-Werror,-Wc23-extensions]
  220 |         _Static_assert(UBLK_MAX_QUEUES_SHIFT <= 7);
      |                                                  ^
      |                                                  , ""
1 error generated.
In file included from null.c:3:
./kublk.h:220:43: error: '_Static_assert' with no message is a C23 extension [-Werror,-Wc23-extensions]
  220 |         _Static_assert(UBLK_MAX_QUEUES_SHIFT <= 7);
      |                                                  ^
      |                                                  , ""
1 error generated.
In file included from file_backed.c:3:
./kublk.h:220:43: error: '_Static_assert' with no message is a C23 extension [-Werror,-Wc23-extensions]
  220 |         _Static_assert(UBLK_MAX_QUEUES_SHIFT <= 7);
      |                                                  ^
      |                                                  , ""
1 error generated.
In file included from common.c:3:
./kublk.h:220:43: error: '_Static_assert' with no message is a C23 extension [-Werror,-Wc23-extensions]
  220 |         _Static_assert(UBLK_MAX_QUEUES_SHIFT <= 7);
      |                                                  ^
      |                                                  , ""
1 error generated.
In file included from stripe.c:3:
./kublk.h:220:43: error: '_Static_assert' with no message is a C23 extension [-Werror,-Wc23-extensions]
  220 |         _Static_assert(UBLK_MAX_QUEUES_SHIFT <= 7);
      |                                                  ^
      |                                                  , ""
1 error generated.
In file included from fault_inject.c:11:
./kublk.h:220:43: error: '_Static_assert' with no message is a C23 extension [-Werror,-Wc23-extensions]
  220 |         _Static_assert(UBLK_MAX_QUEUES_SHIFT <= 7);
      |                                                  ^
      |                                                  , ""
1 error generated.
make: *** [../lib.mk:225: /home/clint/Desktop/kernel-dev/linux-v1/tools/testing/selftests/ublk/kublk] Error 1




 tools/testing/selftests/ublk/kublk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index fe42705c6..e5eb5f762 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -217,7 +217,7 @@ static inline __u64 build_user_data(unsigned tag, unsigned op,
 		unsigned tgt_data, unsigned q_id, unsigned is_target_io)
 {
 	/* we only have 7 bits to encode q_id */
-	_Static_assert(UBLK_MAX_QUEUES_SHIFT <= 7);
+	_Static_assert(UBLK_MAX_QUEUES_SHIFT <= 7, "UBLK_MAX_QUEUES_SHIFT must be <= 7");
 	assert(!(tag >> 16) && !(op >> 8) && !(tgt_data >> 16) && !(q_id >> 7));
 
 	return tag | (op << 16) | (tgt_data << 24) |
-- 
2.43.0


