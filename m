Return-Path: <linux-kselftest+bounces-558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6AC7F7814
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 16:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4791C2108B
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 15:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB7B33075;
	Fri, 24 Nov 2023 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="EvJvufEG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672DA1BC3
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Nov 2023 07:44:04 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cfa71b6029so4085105ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Nov 2023 07:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700840644; x=1701445444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxH4h/fUgyjGMKXsAUdrvTbwQh/c4Jyei7tUpRPE518=;
        b=EvJvufEGOk2ljoM/xXOhxSCw9Ssx7QlYUP4qjwlIzigo8y3MO6y/ipzVHg6zfDd8Wj
         WtIe8+0NEeczc/8T9VzzpHZSRibjuvgLoYxONFJzloZWWeap0dp9Q/8g3HhczLPjIqIE
         VF51yzwv9MhRBOc0IZcCOY8rACxuctZqnLUmXeUp2aHKZ3NmInpCLFM4qgUkmQUN+lLk
         crcSR5GiIfv+1TX4u1tZ9f/aN9MkznY8g/pHbjvB9vBIiiooJPxGYMHPb/Vg1SJ/MSMT
         ltZdz18AJlF41sI0qEYZrtNgcGalP8LUu0VoRuSqtOb5RPiyaipSu+mDzgRh1z8x8QWJ
         W/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700840644; x=1701445444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxH4h/fUgyjGMKXsAUdrvTbwQh/c4Jyei7tUpRPE518=;
        b=LCPI9DRQVEafMyvIV9ELpYGPj61TcZl6jPUlAC8mAhMUAuP4zI39XA0FH+FJVUcuMC
         dTe+cDzR5sMswa15DsPw1z6bJtaQu2dd/u9CAvt3eVummmEaBKfpmNW7A3uaQiHBTY98
         RrCOFm5vf/zQqUfsQx3g2NaLNYfiOPrcjSTnNQcdL06424EqUIoQDI/rxukHAdAo9dNc
         5khptiVZp0qBKfj+U3dTVvu/qrKzKDQTzPyia1eAnkTbKD6G3ck5PmO8Nbpf10oS5Kj/
         1V4tLeo0jjcXZqG4ggyBPKPP6rGQK0D307PtONMbP+2iCxVsqbfLr0yM4OZ+smk3qIp8
         EnjQ==
X-Gm-Message-State: AOJu0YyLmPvV38ifPtKxNTNFXvd4BsPi01trPJLMwulBzGJCK0S058Hs
	0cAVZZZJh0hAzkcjogC4up1iDw==
X-Google-Smtp-Source: AGHT+IESTfwIV1Y4e9dxiuOb6Fx6zh8dfzPm+t7NgGLnsuKfIve4gS4FKHwaEbYY0Jg2cMPODWHT/A==
X-Received: by 2002:a17:902:7d8a:b0:1c9:ca02:645c with SMTP id a10-20020a1709027d8a00b001c9ca02645cmr2977675plm.36.1700840643802;
        Fri, 24 Nov 2023 07:44:03 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902740600b001cf9eac2d3asm1919743pll.118.2023.11.24.07.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 07:44:03 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 5/5] selftests: tc-testing: remove unused import
Date: Fri, 24 Nov 2023 12:42:48 -0300
Message-Id: <20231124154248.315470-6-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124154248.315470-1-pctammela@mojatatu.com>
References: <20231124154248.315470-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove this leftover from the times we pre-allocated everything

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
index 77b1106b8388..bb19b8b76d3b 100644
--- a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
+++ b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
@@ -23,8 +23,6 @@ class SubPlugin(TdcPlugin):
         super().__init__()
 
     def pre_suite(self, testcount, testlist):
-        from itertools import cycle
-
         super().pre_suite(testcount, testlist)
 
     def prepare_test(self, test):
-- 
2.40.1


