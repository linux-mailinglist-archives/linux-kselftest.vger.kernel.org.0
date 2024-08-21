Return-Path: <linux-kselftest+bounces-15886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C2C95A3BE
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 19:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F1D284963
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 17:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD3D1B2EE0;
	Wed, 21 Aug 2024 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2yFJJNb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD0416A95A;
	Wed, 21 Aug 2024 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260782; cv=none; b=ICSi3i8q9m4QTNcCnWg4qn5NQRCY5Yv+iILPpDwItjcefajy3nTkDmo59TsjW1LYe4BDntnV0uO3UBkGYQWWJ/4BW1AFAY0YcJIFH7Z0JWUMn6l6B+olFieYu62Y7DMs/4LK7pn73krW8UsOblpYR63FMLs3aLZRnucKLF9BW4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260782; c=relaxed/simple;
	bh=AHrl03hYSk0JN3ewZWY8XYVCvjqHXQ4YdK8KD/wfZ9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HfTGpABdVJqKyZwls15tGYknUCkIS+6uup7yjxVM8tkJDdgwfXmtVRTuvlVzvGAi6damQQt9cI7cm7FtO8iKlx4ZAc7if+x/NeLuBC8DmlbN++Vpab9gHf2tToaw6BThGfvdNSelHux9sAGYWPVrikROK8hqzRl8K9/MBQ85tdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2yFJJNb; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39d380d4ffcso14805775ab.0;
        Wed, 21 Aug 2024 10:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724260780; x=1724865580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KPrmJT20XR6gJIgd8GzdC0o88NELmv9DY4n9MTax20=;
        b=M2yFJJNbEc0iLZ6VvvaoLOjlU8fraR6IxNxvRN9nx+YKAZiTBBbzDCItqGoyWBx3m7
         +uKqIcdYkGF5gBIs1g1qEE+t/OOew0DN0ZE3xE6L2jWeVHywhHnHDgnApcqnUXs4OACP
         0XEJCSgH0LRZ0XE/2P6QjqbuAN7Sx+ICm+HK/hA+DqvRa3IVxK8vCgge4loKIobUGe3H
         ne303eUFg35mWiBNiX5ctNCRySTF9T7qSZyGkjt+RsKLQO7zxm+jGbfmfHZ+Guj9wy0N
         UL04hkoJofVvNZLQ8JGSFYXt8Y9DetbXFxTQxIdYKMO7xBCjdcB/ltqp7QDEdfSx+Uv2
         nCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724260780; x=1724865580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KPrmJT20XR6gJIgd8GzdC0o88NELmv9DY4n9MTax20=;
        b=cRrHlhP8vxtQ9DizxfcIgXh/B6aFWEnKFa5+8rzn92YMwsjBCnX1Tz2R+lHFO2k8sP
         zHOBjM7Xe+3Rfv3X4pXNMcvqCDEj8DBmtnnraXskfMmKgccuGDjN6QP1in/8/AfW8fse
         QL3QfkkvTtnf3eG6FXOmJvpLqTea3bmvqsChx2a/3ySc+Ci/QuFL6FDff+RXUA/mqxxA
         P4NxJCKYvXUrcyt8H7KKNJVOlu9bd+a1l3i11mGA0ectQ39GQGlhjJHdSZj5gaeABVS3
         kVEK8QykfaoOQJBJhWtEamORoyQmQPuz3x9acYXQ05R1d8isBCeLzc/ne3h/T1Jlf56v
         OFqw==
X-Forwarded-Encrypted: i=1; AJvYcCU3+IOZ4L4ca0eDkiSdxPDzoMrzxhrYmxdG31mjGUPnghdtBI6ktY3CE2LDNJEBcbU61wOEyzLt@vger.kernel.org, AJvYcCWy0gkF00NYD1MTVObqhrpTsnI4EUvftg+wIwirpeQuYDsNMmVMvBurMbClNn2Q2xDBXfoHUjS6tGDS1io=@vger.kernel.org, AJvYcCX/d2Omtkxums6ebOeMVWgsGtNtWko8a5xXa//PzW6x2nIDMwf/xhd1Hv3nseeT6n1BoeYOX3WdnFX4SHIFN/t/@vger.kernel.org
X-Gm-Message-State: AOJu0YxVEVfIZCLPqocJOaPGHDk8upzyWgV9N5mdj57swHxsjfPrWUai
	2R3SP+lyUVU30wjaeu2HPvMOtWr9Sgibjts4Gm2hzuCn27SgSZ4F
X-Google-Smtp-Source: AGHT+IGf/RnGs2WPj6nmsw5daPpF9fWh7c3GdekFAbAcHyCr7tDkb5rAMJnus4gLqUxa2dMraVTsFg==
X-Received: by 2002:a05:6e02:1c82:b0:381:e4a3:2 with SMTP id e9e14a558f8ab-39d6c3b95abmr28516955ab.21.1724260779944;
        Wed, 21 Aug 2024 10:19:39 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:30b3:2256:a75d:4176:9e6a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6356929sm11454913a12.73.2024.08.21.10.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 10:19:39 -0700 (PDT)
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
Subject: [PATCH v9 net-next 3/3] selftests: net: Use XFAIL for operations not supported by the driver
Date: Wed, 21 Aug 2024 22:49:03 +0530
Message-Id: <20240821171903.118324-4-jain.abhinav177@gmail.com>
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

Check if veth pair was created and if yes, xfail on setting IP address
logging an informational message.
Use XFAIL instead of SKIP for unsupported ethtool APIs.

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 tools/testing/selftests/net/netdevice.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/netdevice.sh b/tools/testing/selftests/net/netdevice.sh
index f7752e1ebe22..438f7b2acc5f 100755
--- a/tools/testing/selftests/net/netdevice.sh
+++ b/tools/testing/selftests/net/netdevice.sh
@@ -67,8 +67,12 @@ kci_net_setup()
 		return $ksft_skip
 	fi
 
-	# TODO what ipaddr to set ? DHCP ?
-	echo "SKIP: $netdev: set IP address"
+	if [ "$veth_created" ]; then
+		echo "XFAIL: $netdev: set IP address unsupported for veth*"
+	else
+		# TODO what ipaddr to set ? DHCP ?
+		echo "SKIP: $netdev: set IP address"
+	fi
 	return $ksft_skip
 }
 
@@ -86,7 +90,7 @@ kci_netdev_ethtool_test()
 	ret=$?
 	if [ $ret -ne 0 ];then
 		if [ $ret -eq "$1" ];then
-			echo "SKIP: $netdev: ethtool $2 not supported"
+			echo "XFAIL: $netdev: ethtool $2 not supported"
 			return $ksft_skip
 		else
 			echo "FAIL: $netdev: ethtool $2"
-- 
2.34.1


