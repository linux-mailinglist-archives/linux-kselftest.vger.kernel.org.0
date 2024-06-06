Return-Path: <linux-kselftest+bounces-11317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D06F68FF6DF
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 23:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E416F1C24B70
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 21:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9055919A292;
	Thu,  6 Jun 2024 21:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqN+RtDV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB2C7173C;
	Thu,  6 Jun 2024 21:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709271; cv=none; b=QkhcJfgZOifRG7eXqpqrC3d0S5qrI8HY+JgC5mCbgOMYPcWybUJo0tDSIB+SsYpHfc8GVGdY6ZNOrLUkbGCv7r/6as4KG51EvQ60RyBOZrqkzLUIAdVue6pdgDE9870tL5gCWmZ6JHfYFPHkS+QoXePA5r5isyw6sbxuWYD3Khk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709271; c=relaxed/simple;
	bh=n1iT1QmXS98BBng5bKxBVrEJubKuUwB9yIop4gSG/ss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f5T0UXQowg1DQaqzFUSThOUo0e+IcPC4mnyU11cZi2z0qVvLu1RrGIeoCQ3Uu31BQg56jpaVnqRIiBWRn2sVo5Qxb8iVh8Ei8Uq6Xlr8/FwM7Im8men0SnEg27HPUGMQfiHePbkRNE9HSEzFwC0BqcZglXVIASaeIg4mJL7xGRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqN+RtDV; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7024d571d8eso1239007b3a.0;
        Thu, 06 Jun 2024 14:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717709269; x=1718314069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ANsPCcVU2AeDXu/+ajzXrVrzYIB9B0ViOyF0duLjfOA=;
        b=bqN+RtDVWefrhmD/TFPhnpHPbQDLdZSlPIvZBmfjRnuDqYBQd1m89gEw7VxuvlUBRu
         7GZphS4jAuJHkoEEvjKVUg03wMxrvzOauAQCsZ3APCFdjzTOrofSlYnLy2d2nPkT+4zj
         kbh6qoeCuUhUbESIJTcfrAkHwf+YUSiunmeSESXikyV6Wzj6OpWND3d6bWEyYsO78U2c
         WBMFkN7HdctcxHDJC1jVbv9JuoJf0k36xDTJHJ3ZB1CySj28ex4YjYSxoA3rGONwhwZ/
         kcHubdGZF1QZ3C9q2x0pY7Ujhg8egzvhyl8lzUjoB750jUwnMmqQ5YKqtSlFvDwhQ13Z
         VGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709269; x=1718314069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANsPCcVU2AeDXu/+ajzXrVrzYIB9B0ViOyF0duLjfOA=;
        b=wRVzXsfCERUMMbYBEBEsh9CEsN1YVMpTQaSPJFWQBdgrNTdPEXkhEtpEw2Qko3sjNC
         qu0nnRq5gac5e0+QGkQfzdwNpBtSCa7/gr8abH+gDqcJ06XD0WxFbP0r5wrZ7rHT9s7N
         QxkR4+myylqEV0JxxRO2LpO2ubgPPlyY3TMhUPMZH/NAUVkuUL2oACRt3bPEd++/y5AL
         Xtt89fuVrP/IU2lP1qZp9iccpPpm6j0HkayhsOQ9q/lG4Jg1CG5xXfzs/T0n94ZGZmMo
         adXvVpBeaonl7Ozljj5UqN46Q4SL5sWIGE0aUMscdx0f2fwVs2NbU3diG8atxskSGy4L
         axQw==
X-Forwarded-Encrypted: i=1; AJvYcCXFcZV43m04U8twfTIKKoy1M9bLZJiSNZRE/ZQHKuEOc98M8IPAC4c6lFyrnGJxDIZDXn/4En3GdJdNKchDUO9T/36HfYlN0yyD45B9yZh4WZq6YdtjO93zhVFs7zC0bLfv+6QVoxBSbgpadkniaYqVuzodj53bzBHbp2HsF6M0BCDjDt+N
X-Gm-Message-State: AOJu0YwrX0BdKWBgFVaKmcB+TJn0KvuE5+lD40sYFtYJyi7EhQiTlOpE
	HW2/4ayV1PIHmNxY4+Q+7kYS2eZq/BDBqNO4J7N0ucc0B9K0GlFk
X-Google-Smtp-Source: AGHT+IEWzhMHSsSkOX5ExY3drCNflpol0m4VgOUBRqhRsNR5fDcm0meTaOxe+kzwd67N166ag2R7Xg==
X-Received: by 2002:a05:6a20:2452:b0:1af:f514:6d96 with SMTP id adf61e73a8af0-1b2f97d71fbmr903737637.16.1717709269331;
        Thu, 06 Jun 2024 14:27:49 -0700 (PDT)
Received: from dev0.. ([49.43.162.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd3b2d17sm1506964b3a.84.2024.06.06.14.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:27:48 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	jain.abhinav177@gmail.com
Subject: [PATCH] selftests: net: Add on/off checks for network interface non fixed features
Date: Thu,  6 Jun 2024 21:27:14 +0000
Message-Id: <20240606212714.27472-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses the present TODO in the file.
I have tested it manually on my system and added relevant filtering to
ensure that the correct feature list is being checked.

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 tools/testing/selftests/net/netdevice.sh | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/netdevice.sh b/tools/testing/selftests/net/netdevice.sh
index e3afcb424710..cbe2573c3827 100755
--- a/tools/testing/selftests/net/netdevice.sh
+++ b/tools/testing/selftests/net/netdevice.sh
@@ -117,14 +117,31 @@ kci_netdev_ethtool()
 		return 1
 	fi
 
-	ethtool -k "$netdev" > "$TMP_ETHTOOL_FEATURES"
+	ethtool -k "$netdev" | tail -n +2 > "$TMP_ETHTOOL_FEATURES"
 	if [ $? -ne 0 ];then
 		echo "FAIL: $netdev: ethtool list features"
 		rm "$TMP_ETHTOOL_FEATURES"
 		return 1
 	fi
 	echo "PASS: $netdev: ethtool list features"
-	#TODO for each non fixed features, try to turn them on/off
+
+	for feature in $(grep -v fixed "$TMP_ETHTOOL_FEATURES" | \
+		awk '{print $1}' | sed 's/://'); do
+		ethtool --offload "$netdev" "$feature" off
+		if [ $? -eq 0 ]; then
+			echo "PASS: $netdev: Turned off feature: $feature"
+		else
+			echo "FAIL: $netdev: Failed to turn off feature: $feature"
+		fi
+
+		ethtool --offload "$netdev" "$feature" on
+		if [ $? -eq 0 ]; then
+			echo "PASS: $netdev: Turned on feature: $feature"
+		else
+			echo "FAIL: $netdev: Failed to turn on feature: $feature"
+		fi
+	done
+
 	rm "$TMP_ETHTOOL_FEATURES"
 
 	kci_netdev_ethtool_test 74 'dump' "ethtool -d $netdev"
-- 
2.34.1


