Return-Path: <linux-kselftest+bounces-5495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17976869E65
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 18:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7D61F23A57
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 17:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DCD14534F;
	Tue, 27 Feb 2024 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoYxCOjw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD520145329;
	Tue, 27 Feb 2024 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056524; cv=none; b=Absbj04aB8JP5VbR/ZO2UFBCN+S8d4HgWT3Nv+dNMfR4r0ivMt+/vp0QJXq/C+cQ4gJaE+aHvzpy+2oIq2AC8uW+erFrbFHCXJdsTRD6v3hmLeBSRF4NoTFq7gSNynnLaizko9xlxSo8nuVQW5wBoAh3m5113OOwsek5QLF2URQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056524; c=relaxed/simple;
	bh=rcSNTBiRF+f+3t3RzyuU+qKQ8ru2QZn9y+YmrmBALig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UVBRyS4GWVy0HYZW/NSzlz7dTXB4/IpL/UMxXYwTyn2eYawTHko6HGlkeO5R28k7hOw+99mJIZhz+7ljK5nRXAX14nln0vW8EJjl4ddtMuJDmLv2rxd//X9dXFCVZutZJhmH3S9IJZRANIN4Zbr6PawCNHVS9oUubSA3FWw3gKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoYxCOjw; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e2e5824687so1799225a34.0;
        Tue, 27 Feb 2024 09:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709056522; x=1709661322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ANLYUYqTJ5NOkYuF+uWmj+L6Rv2c3OMTBVV8U8yPtxY=;
        b=GoYxCOjwLJjkeIJWjHNoASQzcJMF77vqPmZ8KaFfCoXld5+2dDkpP4Xsmqk/HTl8Mr
         oPneIMpAN1s9SL8DvpEjFrBB+QTyTqXwIhjErGcCzJlYi6G65UOnD9fjDDGRe84fp3HL
         +lxZHfNI1PAxxV2ykWjS/FnbVhxAVEs5oBDCV/d85Z/8rEfw8/0XJdZuwoMLGD9XryRq
         wSOs3o4Z3kFANAvUvtVHfKsaeWxBmQ4msJiCp1fNf+ON7/8vi+WtBqF7fSSBJbD6cR5l
         F6tuUxGfW3mzPXqV6Wbz3HsrHXbY0phxptNK1k1zdTd3fas1pTuDL2xc095Rnxlxx3rY
         IwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709056522; x=1709661322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANLYUYqTJ5NOkYuF+uWmj+L6Rv2c3OMTBVV8U8yPtxY=;
        b=FI8sXDZq+PRlCIbEJ1PhPEWWjZHy3AHSEYR/Ai/sg6QBMEsNYgTcoknDLZ44zG2q/x
         JQYzxFeg03W49Efzm9UwgCyh7P1AT+h0tmzy7/1GybFT03P24zWACKiv3CiEqHPnIxCg
         5CuTzAiwe1XXcUDGJx0LRG92ER7u27Q7ur8CX7g67zmok44kmtk8cNvbdaA28lZJswPa
         8cW+VvIJYV6HHBEvxyboBh7IOnn4Ps6pMJoF82a1tpIgAOiU3RJ4Lf9H6RtypzWfkOeZ
         J91t9g7uZ4rfRBKPXDV3vVe1yL98oBNa9dU7IyyNOksQQfXZcGxBLlNtAFkrac/ubnkL
         yvhw==
X-Forwarded-Encrypted: i=1; AJvYcCWR698cf7mYp3yIFy5+SXU76oD5P2rDkKgyHIMverJEOCXM4bDU8rwePwQh2ioij935eJV6MifmiHqv9NwIkmyl/eYvmDTbuQnli9q1wALABnRPN4M3d03XvxdKFZoZB099VmXMfJ92kUZZ8ncO
X-Gm-Message-State: AOJu0Yw3mY7GgcXwhCgKYgeZmT0+ZHr4xDiY5abet9cJGX5/TR7kZz2q
	FdtMyt/GcSXEAgAoPdrHRph2Lr7pdVarFZ7ymEExxnRMRTP6mdy/
X-Google-Smtp-Source: AGHT+IE6JFdG7k0accrSz4P2KsVhwxVvNUMaQSXw4KELPM47++xyU5rn5gvhx1vE1dALDpN+XKjrvA==
X-Received: by 2002:a05:6830:128b:b0:6e4:885e:850f with SMTP id z11-20020a056830128b00b006e4885e850fmr10649722otp.8.1709056521676;
        Tue, 27 Feb 2024 09:55:21 -0800 (PST)
Received: from localhost.localdomain ([115.99.206.243])
        by smtp.gmail.com with ESMTPSA id f8-20020a056a001ac800b006e50cedb59bsm4781320pfv.16.2024.02.27.09.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 09:55:21 -0800 (PST)
From: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
To: shuah@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	petrm@nvidia.com,
	idosch@nvidia.com,
	Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
Subject: [PATCH] Correcting the spelling mistake in selftests drivers/net testing
Date: Tue, 27 Feb 2024 23:25:13 +0530
Message-Id: <20240227175513.8703-1-pvkumar5749404@gmail.com>
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


