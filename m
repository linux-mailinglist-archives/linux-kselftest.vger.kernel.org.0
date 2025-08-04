Return-Path: <linux-kselftest+bounces-38250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C73B1A950
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 20:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8EAC18A185F
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 18:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934D725CC6C;
	Mon,  4 Aug 2025 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/kIuVjt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D17F323E
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Aug 2025 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754333791; cv=none; b=RIdD1BBwnWqsDypmcol485EPuULr2tVatQ8BPDwIzP3C76xR8ndaOGpsiw9kL91NhivPqKuOQ4Z+gUD5P8O5YoglKSUWDTqoj+lLJLrXoA2iFAOkvLG2uY6XAzY4AqF2sG208HapsJlLwa2+By7Kf+N8jsacux+68FGS+dFZIB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754333791; c=relaxed/simple;
	bh=0+mjS+YfD9Msr1d+g6z/+MPREkQ0jMmC+4sjMYCRgco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J0sss+jURyBNAYTud3RLAEf7iqpjsCZt+K4VhxBFggEDrrh05j9JNCTZsuh4XLVkjD7TIm3LdNaUDEhOZdtjmz+B8tbsjXM7RMfrMec6dvuJkU/7yulBLO133zF72EA3wmprmamh8O3Jnb8BrOgwAl7RYMBBcm2nCHbPfktA2jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/kIuVjt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23dc5bcf49eso71320875ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Aug 2025 11:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754333789; x=1754938589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J7GdPik8il4PucBQ59L2depa0cWJaTlF0TsvawtsmSE=;
        b=I/kIuVjt/hdJ+i79N1c0Jc3toTKm8/ucDgVybB7lxm+v91PDAKSVwdcpWTopM2rBNL
         cAlhUEWrFuCSvpG6ac6uUhsCpO8O9mvAMwxnAO26UCpSv02HsTqsK9d9ClAm5mDtAdEN
         eVhu5XflgPAGSKFHUSM0540zvAVGE3gao3ovT79Hkq0dvImewTop1w3RVeM2YpVtTXt8
         3QqM/xV/gstTdWED9Y/fqS9fo1YzqoSRF+TsIj/1710z/6EECimYo41wyjRhqKJ+B/M1
         1+Dbmq95MyW4aLu5Mpj5hrV8B3ExF2qp73bnyCHh6v7J242L9WqNxo9mjNKIDZjtF91P
         EsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754333789; x=1754938589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J7GdPik8il4PucBQ59L2depa0cWJaTlF0TsvawtsmSE=;
        b=U6dJinx1jPHEyddaf7qigLhOcKCLWzV4mb07IweqKiE32nVOODSKiRT9UcU/MxNWr1
         FYsQwomz4gk/LyQfKMhe21CYSfFk1uJmE3gfrvKgWIuV72RoDh1wMA/SDQ1na5eTunFg
         5S5Upd9tKjGGXqKRciakSPAi9o0hgavSTE4qTXWyDMwbQQ1f2uHTZpYBq8pCFN4VxAzg
         SKcxhGcwWHhOeye8Fh3VNfPgnYirprYu16E0J6t+P28hWCuMFrW7dWRy1E9nhesZd14A
         0B9Ug9kZzAK1nf8DVb7LzRzFf5E7cMNz9pcNvxBQB0jwbMHHgwFgkKTY7webEvy+XBGB
         gurw==
X-Gm-Message-State: AOJu0Yzaupko4Ni34EA+fNXONATdEoEEOX9Yv5IcyWMljnOb11q+yd04
	+5NWFhmjJnMAKKyRiig4hWVOr+98hF00NXCkii7l946AR2fEhZNZRr74898BdRb/
X-Gm-Gg: ASbGncvDvTfeXizxawv62jBmO5yc0QzFlf5/gOMUTMKRWG1Xt2JlAqOtlWWtq/67bRw
	yiFxx6BipzFfKpTFmUe8udvV4hLOHZZv/HuJBvhp+QTJe/hZKcaAHSxA/5JxyoqYrh2e5Bv5ZHv
	CHyPH3qPxZa6FiKhsD7S2tf52ee2B0Kmj4zsevJBaTUyctIUPzx04pAz5jWYvTRxgKgnDUWgjJU
	LEuqGHXTyCeKeELCzUTUxK/b8wZsvf3axvheVvLCdDgL2hpN5WVmyjCceRgNZ1/4vGAIWwqU7Ih
	4c+ayHG5w1P4bktnyfod9txnAsxgFTwTkm6vWBM/RdPxi03hb7ZUkT0/9eeHLg3xBv6bDOvMlgQ
	FPo4tnkyTW7/F4RsgkROo
X-Google-Smtp-Source: AGHT+IGkpcE2ivqyO2GcHZWWreYfjGuepekmbWRyRdyhdy2C3K37iX+lo4FOzWz7TWwDfCA9O2wcsQ==
X-Received: by 2002:a17:902:e5c6:b0:240:92f9:7b75 with SMTP id d9443c01a7336-24246f30922mr139192545ad.2.1754333789151;
        Mon, 04 Aug 2025 11:56:29 -0700 (PDT)
Received: from fedora ([223.237.171.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6832sm115112695ad.25.2025.08.04.11.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 11:56:28 -0700 (PDT)
From: Noorain Eqbal <nooraineqbal@gmail.com>
To: linux-kselftest@vger.kernel.org
Cc: Noorain Eqbal <nooraineqbal@gmail.com>
Subject: [PATCH] selftests: bpf: crypto: Improved clarity in test output message
Date: Tue,  5 Aug 2025 00:26:00 +0530
Message-ID: <20250804185600.16671-1-nooraineqbal@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    In 'crypto_setup()' the error message for invalid buffer size
    was updated for grammar and clarity

    This change does not affect the test behaviour but improve the
    quality of test output

Signed-off-by: Noorain Eqbal <nooraineqbal@gmail.com>
---
 tools/testing/selftests/bpf/benchs/bench_bpf_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_crypto.c b/tools/testing/selftests/bpf/benchs/bench_bpf_crypto.c
index 2845edaba8db..ac91cb224373 100644
--- a/tools/testing/selftests/bpf/benchs/bench_bpf_crypto.c
+++ b/tools/testing/selftests/bpf/benchs/bench_bpf_crypto.c
@@ -83,7 +83,7 @@ static void crypto_setup(void)
 
 	sz = args.crypto_len;
 	if (!sz || sz > sizeof(ctx.skel->bss->dst)) {
-		fprintf(stderr, "invalid encrypt buffer size (source %zu, target %zu)\n",
+		fprintf(stderr, "invalid encryption buffer size: source %zu, target %zu\n",
 			sz, sizeof(ctx.skel->bss->dst));
 		exit(1);
 	}
-- 
2.50.1


