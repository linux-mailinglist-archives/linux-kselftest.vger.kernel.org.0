Return-Path: <linux-kselftest+bounces-5528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A590586AEBF
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 13:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E23728A50C
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 12:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85BC73533;
	Wed, 28 Feb 2024 12:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt213mjL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEDA7350A;
	Wed, 28 Feb 2024 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709122086; cv=none; b=Qv1bO9fgHnCxAfzRq+YckNfn92Lu2kiXCJpADV6OVwLQvTBiYOGPKCgjbx/vf0ylZOmp4ECMQjyZAMhKbfFgnU5iUmiMt7CKDkYBhQfu8zj98kediy91JHv+TqhCivplM1wS+FTg6MY5URtATlQGXySVHB6Hb9kRHs367I95iVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709122086; c=relaxed/simple;
	bh=rcSNTBiRF+f+3t3RzyuU+qKQ8ru2QZn9y+YmrmBALig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kd66qe3EczjkLHo7uUQhuZT3OzMgGdB3XGW2hPmm/IcsJe56QktY/vYKFbgEI5/M/2Ka4QvQYkl62ZEY0xLcg6pwt2DKlNeLkQq7HFIOPREpnStrTWdUPZ50T3h9UuiXoNQJw7gLH486eputnOZGHoWVMZEYRyJJ89n4xbeyHWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gt213mjL; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dc49b00bdbso47891925ad.3;
        Wed, 28 Feb 2024 04:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709122084; x=1709726884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ANLYUYqTJ5NOkYuF+uWmj+L6Rv2c3OMTBVV8U8yPtxY=;
        b=gt213mjL+CQMFoUhYDypcjhusyE1hoH3DWWJ6DO44XBkEhx+dQ+wUcdZ2UEutNbq6p
         0H4erylD+jmNDFvkTLPwepOkpigwa6AMtlh9VSOo4xxMiPih5yt9T227NBeKNJGy+zye
         UwUFO+6IpsqqYvag/O071mYn6//DGVW2BwF3VLtgOmYM+4IFngWVnqOXXUsuiZd/nrbx
         zbe+ZvKdpS2a//h6DzgI/myvelR1kwXxbRlqlh76tvOSg86RvjgRd0zBsCoWttaISVtQ
         K1dQTD+w6tL0t3X8YotQ4PF35csEX2qVsm5Y4u0k1gRBGD04zLie8agIO4cjjdW5uWCU
         xKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709122084; x=1709726884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANLYUYqTJ5NOkYuF+uWmj+L6Rv2c3OMTBVV8U8yPtxY=;
        b=EtJJlF8SPQRq/lIUN8/YaYvpn8akArxN+KbqRi6t1Wr8bmHwgeOccNpEeRW5qy1yAl
         Q0LVeJgkMIHy0EGD8J8Uy0SIdqbSqPWOGMFY1LSWlVO7bueaiUqZc/Km51t08CfAjChv
         lR5VPxJsyBzcrOYsMnM/cV+iHULLCzv1s/l7upUDUWCjbr9ypQiHrLBd84hAnvu+8H8J
         UTNMHLoHO64IhnjblNQrpD5MasPJsrqwC5EBz5es9DpSJMdtkq+XaHhSJJ6eR63zijoS
         e2CyWQlFANodZ+vILvkX3r08I+P4enL5BLDIRhgbv1qQZv3Vuy+YGfXczQ1xkfLwi9MT
         /rcw==
X-Forwarded-Encrypted: i=1; AJvYcCWwKsbjs71fISf7pNB5IKQWN3GtInuH/Fb+IWVundW0O2CwmYS5C10nfCOECBtLjnS9NZlTCmXaeZgqTl1X5sAaj6lkGmKFcidlnDktBrQN8tSWGCITImF1vDmmgYxnjypMAbMmox5A8hdiiJzS
X-Gm-Message-State: AOJu0YywzRiPOj3vcj0d8wPj594/XdLbkLyR/JDuQAhOGEUaUAngmU3p
	MRuCOmnpii9t5cRp9XvMelhPn8nHwLgONh1veH5/Yim463sUHw8R
X-Google-Smtp-Source: AGHT+IGP42kjWB8saR6KLXiU1B9P0carRihw2Cx8tj11SQU6hGJ5c12DXyzjOvoSTq7B+P50pTbgug==
X-Received: by 2002:a17:903:41cb:b0:1db:fad5:26b0 with SMTP id u11-20020a17090341cb00b001dbfad526b0mr13295243ple.55.1709122084392;
        Wed, 28 Feb 2024 04:08:04 -0800 (PST)
Received: from localhost.localdomain ([115.99.206.243])
        by smtp.gmail.com with ESMTPSA id km8-20020a17090327c800b001d8f81ecebesm3166594plb.192.2024.02.28.04.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 04:08:03 -0800 (PST)
From: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
To: shuah@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	petrm@nvidia.com,
	idosch@nvidia.com,
	Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
Subject: [PATCH net-next] selftests: net: Correct couple of spelling mistakes
Date: Wed, 28 Feb 2024 17:37:01 +0530
Message-Id: <20240228120701.422264-1-pvkumar5749404@gmail.com>
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


