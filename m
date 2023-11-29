Return-Path: <linux-kselftest+bounces-846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E212F7FE323
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 23:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EFEE1C20CCC
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 22:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C923B1B2;
	Wed, 29 Nov 2023 22:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="HTTWBMfc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08FB1721
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Nov 2023 14:24:52 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cfc2d03b3aso2896065ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Nov 2023 14:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701296692; x=1701901492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNtH+1gH2lQm382ulpsqNWzj+X2PY2b5el3VSQomhZc=;
        b=HTTWBMfc/OUinqxGqWkjD6Se5fRaj4PP6fdUBm7V75lmhsaikMpNUsmBBGku7h+b6R
         p6Jt1j1ubn7Gitu/7V0eXn0q9yXQlFOTZMsm5zlzt7NTgW7E2Mt6YdMkLCcooZtP2T19
         G73JTqZswUiT0bn+Zt8lQncc39U9hVUnvHvt9q8nn3qSrPUQTuSvhCfCQpQQHm85y18L
         PzCIbRUOF76eQEL3d5ZYBbvPa9Jj8Uxx1uYtfZCIy7LYkHoBTxil0L+0IJdItcmSYab7
         EH2RdNoj9Lp4geu7aHpo8a2kbupxV9X9H8y1qoK7xgJvTxGURXAzLm7/BV1HEOAyQwTT
         CwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701296692; x=1701901492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNtH+1gH2lQm382ulpsqNWzj+X2PY2b5el3VSQomhZc=;
        b=d2lmcVcyuVkUONp7URO7Qp07B25R83MfUxbwPeiYSCYeNQyASTAmEn5GpFbTGnu1K8
         EFfv8kbwZWKUMVF8micNSgoSjVzeMtlPej7zSNiKXj6/yAhEHhil+nBCQUfcANfw2/xx
         PxFv2fc51jsn+Dca6AfscZHxUcd/NnuKFWfArmG/BqpCH5/gcbfuX45zXoeybMpn9g9W
         OYRD8RKAByzX3MC5mlpA+duQ5rdBP8OxS3IaaRHRSDwg+8ADQGFHEjq0LKPEJHxUOLfj
         msW8uYBwbsOU0Lph/z/NnV1aVDDwCEBQ5OcpvfNjPq6nzK8M82Rrf0A9D77bEMllBDXV
         07eg==
X-Gm-Message-State: AOJu0Yyax3C552TWJ8QlbRZMV44wTL/ZJ63GhGKcDbHXyj9+2TkGm7GN
	imc+zh9uE+qJEsbxWrHIxXJdX8InbsWD4KsA1Vc=
X-Google-Smtp-Source: AGHT+IGNDlKoqxcERG5pvxOUvytNKG9IcyHtmVrHI/OJz23zoAESqtSMxMD2v3XzETpmZeTUNhas3w==
X-Received: by 2002:a17:902:f68e:b0:1cf:9bd1:aaea with SMTP id l14-20020a170902f68e00b001cf9bd1aaeamr24256867plg.11.1701296692249;
        Wed, 29 Nov 2023 14:24:52 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001cfb971edf2sm8663697plg.13.2023.11.29.14.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 14:24:51 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	linux-kselftest@vger.kernel.org,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 2/4] selftests: tc-testing: remove spurious './' from Makefile
Date: Wed, 29 Nov 2023 19:24:22 -0300
Message-Id: <20231129222424.910148-3-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129222424.910148-1-pctammela@mojatatu.com>
References: <20231129222424.910148-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patchwork CI didn't like the extra './', so remove it.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 tools/testing/selftests/tc-testing/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tc-testing/Makefile b/tools/testing/selftests/tc-testing/Makefile
index e8b3dde4fa16..9153e3428a77 100644
--- a/tools/testing/selftests/tc-testing/Makefile
+++ b/tools/testing/selftests/tc-testing/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-TEST_PROGS += ./tdc.sh
+TEST_PROGS += tdc.sh
 TEST_FILES := action-ebpf tdc*.py Tdc*.py plugins plugin-lib tc-tests scripts
 
 include ../lib.mk
-- 
2.40.1


