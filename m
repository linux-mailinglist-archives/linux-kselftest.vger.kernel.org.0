Return-Path: <linux-kselftest+bounces-23651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0509E9F8ED1
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 10:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7CDE166323
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 09:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0A61A9B42;
	Fri, 20 Dec 2024 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KHyQjz36"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924B71AE877
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734686273; cv=none; b=ecqJct2dFp4a2r2P2OWWvKwW8jcBmhSnvGNEMuJyuVtJWkGBagH0PjtudQsQJw3PSVDFiQTpdBOf+vOGnj0L8ytX5I03D6wwLsqqLEPsqOghPqB0PctOIHrhxtFvccjPF+uvBGc9Y4U/6YKpmDDydWC0G87EJuIgvUNCjTK52FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734686273; c=relaxed/simple;
	bh=sUeurYQEqNzeoWrNXgMt5UGjCCv9v7CMeJeIa7SSRRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LYT4553nR1Ymcg4zvrIt9XnWFj8aiyRKMUE9rlheN//znVZR2MaybLbEN77nKWs5wsm13oZCQKj3IUor/dI86MxoMBSomK4OjM5lcPaskUJkXHl9/+WypfbTxmGaB+hVf5P66LPHcYx5OZIEfGRHOFWhHez2sfdeud22MsJ2Nh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KHyQjz36; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21619108a6bso13898555ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 01:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1734686271; x=1735291071; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a2aSwIvmjb/5T6lJn2rQ/9k8U/HxY8PQ9cPVzeLGfwY=;
        b=KHyQjz36vrABPbiAVDQPMPOdtWkO4JnLi+NfQxtkeL+amP7TTm9yUQXtX1Kq5P6kHM
         +F4ALoyto2FgpCZHhq11df0nm9r/+oTmeyggtx0iLjigbs12TVeKgT47RkCQHDbIaX7I
         Bm+EaxG0AUarQcmvx0u38eq2nmtJchoF7SsY6LZkzst4/Z8gTKE3oi+7jsnC8v8urCMI
         8Fiq9AG+MCHxnFsYeCQTB6hPhQxb3qWLCvCmRywLR2o44S1u0uDObUkSsgsISOMEC7wR
         eLcGmvjQ57BlhnVmFEkhbXzui3arXfQnMFep9vl0PAQwdyg+j/2YhknCuxkAHL+xV7LH
         KibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734686271; x=1735291071;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a2aSwIvmjb/5T6lJn2rQ/9k8U/HxY8PQ9cPVzeLGfwY=;
        b=e3TxwgDs0sCZEQhIVegMSff5/AgqeTH0ev88qxYZZ4rg8YrvPg/qbM3rhm6+IBR6LT
         pVkN6tE6PACkT24zlXXreyvzlkoDsxqnXvoZEZvUjt1jKreoJsvTtXAxjEwZcRmEcgoK
         FGHkx88okZQ6eNl68j3zNWuSVcwmDwGXYQVAP6D+8uHiMGqk4qeGLrDGuAbojhU/XEXc
         1ZA81FTV7tnKMFAPaj0KvfzcQjDhNva4gLkvC8v4L2SlZF1LV3M3lm3TawLHeu8XxYWZ
         nbaLBXh+N6GUOQFe4rjcB1CVj8O5ZyHOZpCg8yW9Vwgkz9Hg+WTQngop4V7j2HQLLZFQ
         dL1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOzFYMgRwFRD59b8koxjVSuXkLD5l2mtA8lKnpp9y5wtuYmoXAXycwQkFkTs6x3WQstOThemSGW9/Wt/ua9Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPsGO6cVHdMylwBQKMYQCAQ+6YOKBEO0NCWc64CdeYV7RqJfTr
	ElITZVPuRFOzmgC55ZLRajVlFYVRlEfdbUf95J5rtCFNYl/aoDy58H5kSli12GA=
X-Gm-Gg: ASbGncvn6ADg624f2FnwActXfq22yUZqi5JniK5/StjylJyKLqnw/jOtDuGBcFyIA+n
	Kq6vqW2pPW5n5Tvau0XSxF8vFTjeEZgY2bkajPoNucNFkR6MySfGBet5JwrfGGk54pM0kujuohv
	WuJfng0K/iehmcz58LS2Gmf/jdXw1jA6KYgrgI8xDPjCFTID+i0YRijEdXjPKjIS4HNazZQR3qZ
	f57Nu6W3C4HQn2ulXNirCVtguABasSIOrb1Lh56b/F6/1pzwqqFXmSgyODAHE+TCu5fmW8gvEKh
	kbBWzUU6UWo=
X-Google-Smtp-Source: AGHT+IFjmcyrQBlqsYi8A3jJx2RgZWdnoNiqiG5tYyi/sN+MGEEnkPUZWugth5TL0+738iD0RCKCCQ==
X-Received: by 2002:a17:90b:6c6:b0:2ee:b8ac:73b4 with SMTP id 98e67ed59e1d1-2f452ee4fb6mr3045312a91.36.1734686270930;
        Fri, 20 Dec 2024 01:17:50 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4478accb3sm2806715a91.51.2024.12.20.01.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 01:17:50 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	andybnac@gmail.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [PATCH 2/2] tools: selftests: riscv: Add test count for vstate_prctl
Date: Fri, 20 Dec 2024 17:17:27 +0800
Message-Id: <20241220091730.28006-3-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241220091730.28006-1-yongxuan.wang@sifive.com>
References: <20241220091730.28006-1-yongxuan.wang@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

Add the test count to drop the warning message.
"Planned tests != run tests (0 != 1)"

Fixes: 7cf6198ce22d ("selftests: Test RISC-V Vector prctl interface")
Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 tools/testing/selftests/riscv/vector/vstate_prctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/riscv/vector/vstate_prctl.c b/tools/testing/selftests/riscv/vector/vstate_prctl.c
index 895177f6bf4c..40b3bffcbb40 100644
--- a/tools/testing/selftests/riscv/vector/vstate_prctl.c
+++ b/tools/testing/selftests/riscv/vector/vstate_prctl.c
@@ -76,6 +76,8 @@ int main(void)
 	long flag, expected;
 	long rc;
 
+	ksft_set_plan(1);
+
 	pair.key = RISCV_HWPROBE_KEY_IMA_EXT_0;
 	rc = riscv_hwprobe(&pair, 1, 0, NULL, 0);
 	if (rc < 0) {
-- 
2.17.1


