Return-Path: <linux-kselftest+bounces-15885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B81A95A3BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 19:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D45B238D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 17:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE501B2EC7;
	Wed, 21 Aug 2024 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0OJIMuo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B731D1B2EC0;
	Wed, 21 Aug 2024 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260774; cv=none; b=N6fxzKgAHmOb5wdjTSmDWtHHCdeOY6TgsepHZfSefJgsbXYiQjNHS2drAZsRYVggC7L+vIn7L7cue12B7EeFX3F5zO99z8MLz+ZVqC/ggvdKg0lUFcZy3LcoRh4PafHgorLl6NvVHleIYNmSAoSd8icp4rRDD7pWr3UMFWTiwiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260774; c=relaxed/simple;
	bh=QXu/tbKVrbuG4cIuDk960PgY7sfJk8lvD33GkEYc3Gg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ak8eIsEDS6UQz9VrT4Gl6QpvEuF7su90Dal/aw+8slHtyJyTghxj7zx+33L6dvUyz7bLq6cAtVXIaKitYCtuVON03GHrIuBBDEo+5jFJ+fXIbM1O+VyVPKdx0BSOtnaKLV4Zyx6pPXNbrzk5UgCfKTfYGshi4WL5xqtUFosRYmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0OJIMuo; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2702ed1054fso2410201fac.3;
        Wed, 21 Aug 2024 10:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724260772; x=1724865572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkNSkfheqMxmKkuKF+Kr77qV3Kh/thT0g/DDVM2Il4M=;
        b=g0OJIMuoXiwkIwmAllJvxu9iBusEn9z2e9nCZ1/697pOSaClNAkFmkuv54y32pTOcI
         lQYLS6iqNh+W6Ux92LOWIAgXRL2Ja9HFDp5YXICt/vnLYe1LTdtdlrJBV3OM0tZsNOaf
         H/dBpqtjFNcBR4p5wxrOMvXZrqGjcFitZlb3pbr2uJN8kfWc+SrubiZu6mNeuLEf6ylx
         llmIin3QheWDceNmFohlZcKKe8yaShElma+dL9aLqp4kfZa1rD+BiTtltmBwMiOoCDa0
         eEfBOr/4KCr66BsUIx1jDvx8p6yUcq7ejAlYaFGfQ2KpTnRJzOrsc9MsowgmN/0GPj2l
         pk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724260772; x=1724865572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkNSkfheqMxmKkuKF+Kr77qV3Kh/thT0g/DDVM2Il4M=;
        b=pnT8mwF5h0PDKoSwAXhKol1Df5z5My4oCXhSvHqCNBd3+/vCYRTxf9VJwUSMFiTLm+
         Yo2jf+KasG3fiFaZ3L7iBT8Zjx4IzwvGmtFBvI2tCVmtL2ggYt7o6yguRNHSbJWmMQEz
         emWZ7Yvnq5oCRoIASH1Hn6w9/5kv+EjUyDuN2jL2uHcYJ00b2LvX7euA+0hRN9eLxyzX
         Px9AGJTbU6iMZB4FRpxATAAIMGyzZwdaM67VQbEZFOJrST8XIhcCPnrS897cvng5MPcr
         oMEubpbFRAKdU3Ia+zYlAwy21NMk5Fw/rpLyqZunZoOHYzi8rkXAkeKCeeySV9cyezwu
         j4ow==
X-Forwarded-Encrypted: i=1; AJvYcCUWg3QIzmoFq1wA7fGLzufPX7EKoyLUqc7VuqyJBP54Vf6L0VpSfzlRZCNP3j7TwsBwKhmCSXYHHSgnhgXI1QBq@vger.kernel.org, AJvYcCWKXxJNGF1Tx6PVrAc0fCmkk8ankVfSzEfKyi7st/OYbwCZLD5Y9vBYXu3VuyNQac+MpjwtFQZoBgJOfnk=@vger.kernel.org, AJvYcCWbAspOWIOLlakcEq2KwLcjlBNPEVBLeR2PAdbaXRurD7BqD0inuZ0Dh+fp2LfwXAhsh7Q87yVy@vger.kernel.org
X-Gm-Message-State: AOJu0YxeNOLR7gx1JySPYcUaBQXH7fZkUyplj+hnmogF3bYwIrMOJDMc
	jEyhjjLA2lV/hcojHlLLaIOoGfRHsOegA7sP2TBMAgzojTETFQgx
X-Google-Smtp-Source: AGHT+IGPMfOJ4oS0EtqhdB290w3Y27mgJOIGB8j1pc2ZqzOym2mUx+cKV6+7TqWw8WExgWnr8nCJxw==
X-Received: by 2002:a05:6871:51e8:b0:25e:19fe:f240 with SMTP id 586e51a60fabf-2737eebcbebmr3103121fac.9.1724260771761;
        Wed, 21 Aug 2024 10:19:31 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:30b3:2256:a75d:4176:9e6a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6356929sm11454913a12.73.2024.08.21.10.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 10:19:31 -0700 (PDT)
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
	Abhinav Jain <jain.abhinav177@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v9 net-next 2/3] selftests: net: Add on/off checks for non-fixed features of interface
Date: Wed, 21 Aug 2024 22:49:02 +0530
Message-Id: <20240821171903.118324-3-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821171903.118324-1-jain.abhinav177@gmail.com>
References: <20240821171903.118324-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement on/off testing for all non-fixed features via while loop.

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 tools/testing/selftests/net/netdevice.sh | 35 +++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netdevice.sh b/tools/testing/selftests/net/netdevice.sh
index 999d72b6670c..f7752e1ebe22 100755
--- a/tools/testing/selftests/net/netdevice.sh
+++ b/tools/testing/selftests/net/netdevice.sh
@@ -124,7 +124,40 @@ kci_netdev_ethtool()
 		return 1
 	fi
 	echo "PASS: $netdev: ethtool list features"
-	#TODO for each non fixed features, try to turn them on/off
+
+	while read -r FEATURE VALUE FIXED; do
+		[ "$FEATURE" != "Features" ] || continue # Skip "Features"
+		[ "$FIXED" != "[fixed]" ] || continue # Skip fixed features
+		feature="${FEATURE%:*}"
+
+		ethtool --offload "$netdev" "$feature" off
+		if [ $? -eq 0 ]; then
+			echo "PASS: $netdev: Turned off feature: $feature"
+		else
+			echo "FAIL: $netdev: Failed to turn off feature:" \
+				"$feature"
+		fi
+
+		ethtool --offload "$netdev" "$feature" on
+		if [ $? -eq 0 ]; then
+			echo "PASS: $netdev: Turned on feature: $feature"
+		else
+			echo "FAIL: $netdev: Failed to turn on feature:" \
+				"$feature"
+		fi
+
+		#restore the feature to its initial state
+		ethtool --offload "$netdev" "$feature" "$VALUE"
+		if [ $? -eq 0 ]; then
+			echo "PASS: $netdev: Restore feature $feature" \
+				"to initial state $VALUE"
+		else
+			echo "FAIL: $netdev: Failed to restore feature" \
+				"$feature to initial state $VALUE"
+		fi
+
+	done < "$TMP_ETHTOOL_FEATURES"
+
 	rm "$TMP_ETHTOOL_FEATURES"
 
 	kci_netdev_ethtool_test 74 'dump' "ethtool -d $netdev"
-- 
2.34.1


