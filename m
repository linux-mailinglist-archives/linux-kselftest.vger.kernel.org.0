Return-Path: <linux-kselftest+bounces-5517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96F286A9CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 09:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2301C235A9
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 08:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7522C6BD;
	Wed, 28 Feb 2024 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUe5t3SE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764F12D042;
	Wed, 28 Feb 2024 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709108676; cv=none; b=upfvdaX4cqAFbOT4snQZlNxDTDgKSdCAiQ+ltGCN0biJlpJYARooOOMtiB38TmCItPoMvaVVC8yjPQMilunaygW1I9PXLdI+yr1qgQrHHXc6FnZ0fPWsti+xAUGBMhlns24QEDd7CRZLm32qX7NflZTv91ynlXX7d5Ag6DThudI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709108676; c=relaxed/simple;
	bh=rcSNTBiRF+f+3t3RzyuU+qKQ8ru2QZn9y+YmrmBALig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bk88vVe381w7e/ce02bDOs6d0bPKfAubjauojNA8t5j7sxhFPApcy5l7Q1GIv/7pcjk4sh62x4s0GpyMcSXUA2bTZr4MyYm6WsVoZi8Wiicmayllw4hZp41H7GGRUMCHJeUga5VLqW5Foj/b2nh/M9EhgcPnteHQjIpYvZ3+S24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUe5t3SE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dcc7f4717fso5899925ad.0;
        Wed, 28 Feb 2024 00:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709108675; x=1709713475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ANLYUYqTJ5NOkYuF+uWmj+L6Rv2c3OMTBVV8U8yPtxY=;
        b=UUe5t3SE9LR6qSHuXJperYMrG3H1rnruT7kpCj2j+orpX0XqN0lHFvM6Ng6NSJnk2T
         4BsXDBB2ToTL7acSWjzqh4bpJAhIrzJdHqLiNTKMGbIX78ZMCWK3BL1nOhbZIi+43RY+
         cEYFSauEvU9/8JBD3/sy+69x+pOuPJDehQVOelfHq+C17BRfS8465xD1D9IzCOwSWCWq
         nqXBHNAwSPd5+ZWZdLYbZQSmWFz+wVwPUl7sAkt9uBrXlzcCE2rEcF6wf9nFj4GBetnV
         AMTkUlb8YXFczp9r5B0FvQyao5tVVVNBT57RDK1dOHvxlVRb9spYqStblH5MXETbrNbn
         5XNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709108675; x=1709713475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANLYUYqTJ5NOkYuF+uWmj+L6Rv2c3OMTBVV8U8yPtxY=;
        b=gYl8Dfyh2RmT5gFUd2QxhCST9ia+fgcThcrF2v9v2JULG/FZt4LEVA7YILJFwDafeS
         g4CnOuMCQTqUmH8CT9R0yu2o8ubwOBPxA74L2+d3QpLwc0RKEB6qwO4UqVG2UAxHQfzF
         kb22CYTPop0HywMQ3VONvN5qxHWv/wlT/SWAdZjaVSI9VIhh6Rzq0pvUKskcAEEsmDab
         CuwGnd/wPZdvvYY1u1g+YYKAjBRrGT6NLRm2Q2xuUkQO8SxUiKQwVgTHeWYE/Pg72FGW
         N5VZVYdb9q4kFT2gCSwbSl40DUvjunDcR+t3cnHYzXsm1iAmiyiURHbhfranV8wtf82u
         TP5g==
X-Forwarded-Encrypted: i=1; AJvYcCUExjF0J2VmOe7XHwuFs0w5pw4OHvuHPQXJmzxRmEvL2HBhJXEe7EgQzKJKcSKAgSFVnj1WrFHPrkV3ZMsg1oWqg5IaC5IswYuKnQmBmiVHS7bGKWGLg5HHJBhmWvWle96JDW57fIh66LbQ2Xth
X-Gm-Message-State: AOJu0Yxo4ZS9WW6dKSwyqviRldCp8RuYQAsMQpiSUundnOAEOJMJfwPX
	CMIiFt02z7lv40l1yIicnGJCRhDdw9QaxnIr24CiAHjtTUHY4SGyMgOmcmYz
X-Google-Smtp-Source: AGHT+IHFSxHEnMcZZRP0fuCcTyC3jlFxQF+jQbHOTPo5GbmFmpa3QE0nYX6/CayEeXRL3zjjGsLfRw==
X-Received: by 2002:a17:902:f54f:b0:1dc:78b6:bbcf with SMTP id h15-20020a170902f54f00b001dc78b6bbcfmr15420655plf.63.1709108674644;
        Wed, 28 Feb 2024 00:24:34 -0800 (PST)
Received: from localhost.localdomain ([115.99.206.243])
        by smtp.gmail.com with ESMTPSA id je20-20020a170903265400b001db608107ecsm2752890plb.167.2024.02.28.00.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 00:24:34 -0800 (PST)
From: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
To: shuah@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	petrm@nvidia.com,
	idosch@nvidia.com,
	Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
Subject: [PATCH net-next] selftests: net: Correct couple of spelling mistakes
Date: Wed, 28 Feb 2024 13:54:16 +0530
Message-Id: <20240228082416.416882-1-pvkumar5749404@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes :
	- "excercise" is corrected to "exercise" in drivers/net/mlxsw/spectrum-2/tc_flower.sh
	- "mutliple" is corrected to "multiple" in drivers/net/netdevsim/ethtool-fec.sh

Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
---
 .../testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh | 2 +-
 tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
index 616d3581419c..31252bc8775e 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
@@ -869,7 +869,7 @@ bloom_simple_test()
 bloom_complex_test()
 {
 	# Bloom filter index computation is affected from region ID, eRP
-	# ID and from the region key size. In order to excercise those parts
+	# ID and from the region key size. In order to exercise those parts
 	# of the Bloom filter code, use a series of regions, each with a
 	# different key size and send packet that should hit all of them.
 	local index
diff --git a/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh b/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh
index 7d7829f57550..6c52ce1b0450 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh
@@ -49,7 +49,7 @@ for o in llrs rs; do
 Active FEC encoding: ${o^^}"
 done
 
-# Test mutliple bits
+# Test multiple bits
 $ETHTOOL --set-fec $NSIM_NETDEV encoding rs llrs
 check $?
 s=$($ETHTOOL --show-fec $NSIM_NETDEV | tail -2)
-- 
2.34.1


