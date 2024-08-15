Return-Path: <linux-kselftest+bounces-15400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2F2952D20
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 13:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C24C1C235E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 11:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEFE1AC8AD;
	Thu, 15 Aug 2024 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtawL3H6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE641AC89A;
	Thu, 15 Aug 2024 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723719600; cv=none; b=jnLlyAJhlwjuoATYc/IE0onB7N/nZSKymet4HuUlvkfWorTwUMfDwb/vKcE/QU0L/W8cgE92j2fmiJdNtozJw926TpmKSw1vYan1iNnkihEbxY4XN/2tIJywh1OSiujs1AJoXVjDsTW5JFudpKZ/huIMYoIbCsFaoxT5jJzoQ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723719600; c=relaxed/simple;
	bh=/WcUu2p5Lk7hWXywCIwNFHFP+xdINS3kR+wr3vCrjIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KgfJS1sItYK+u+SURBDeVl4QKJMOjHUuRFDXX53A04dAw4X/zaziYm3xd69wQJ4UykHaw7A84lNioaGzr9z7xDcemkdgu1e/urhCGEeNhtRrPedChyITKk2jBixzLDv/ec2gxdiCUpObaOSb5F4c6D/M5vXWa7hg0kG8sDRS8rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtawL3H6; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-710ffaf921fso498501b3a.1;
        Thu, 15 Aug 2024 03:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723719597; x=1724324397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R491SSux1DQSWKVz1maSbeuZHf+MaOkhtq9L4FMhxUY=;
        b=XtawL3H6ZEDF+9Z8lz1YbuhfLeFbQnPO+U1jiEeeAwt6c2p1A4DNu3Um4G3AEwnUrL
         RwQsqb9cg00iVnyVk8WKi9kwtJAI+sa4n4pLBrto9Xp7Uxz2omlpcAUFIXlyB+K90ayv
         JjlHoQu48IxFfK3g+rsK5puAXYowbo8JsSNZbmWtaupCP8eTaM736dj4zItWiMTI7XFf
         g1bnfY0tYeobYD4q3pLUlNVPGPNBe9rCtoN849t4JLtW6GE00UOKIUSfUnADalXA92EA
         vfdopZ55sAeGDdw05KNfm7wwmPo+wHC9i88vQ9pRPDvwSq7AWX519cHabxLwK5JnXfKF
         1vmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723719597; x=1724324397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R491SSux1DQSWKVz1maSbeuZHf+MaOkhtq9L4FMhxUY=;
        b=PQrzMrLMvxhs0jJ17E8DH3rEqmRRokyeF3cBTYby2NC8UXkxJ+U9LkAvlr7mLUv54J
         1WitNBDYX4107LUrl2VX0s0O3NB2Ahln2bxe6svnyVHSWR9nACaHmvJFR6x8PjSn5jr8
         OjfLcRaDq7flnHXvgczdvrMjp24YttPoqGwZdNW0xSmFHtnxiNvPAik9o0ZdGyvUtrP0
         6SvoqZZmMNAKkdRvgwFcJHwre8WcQeqyplsiImfyjAnumckqZFdwOBQIpm1yD6qR4LiQ
         YsLVOr/mrabbilejjYgBqW14NWV+FunReiGQoY0riVEe9jX62R2udyjUZjUb56enb2xS
         yv7w==
X-Forwarded-Encrypted: i=1; AJvYcCUO7Q21Yg2d7oTbWmif+Flt2MGGC9FPH/vmQqyP8+hg6sWXq5Z0PccYw9ya6tLaQEl0daoGz0fjLNrCVUNuKOammoIBsl7G8oaVEJYAp/OcqoAXwl/T2NsLdQJlG2R+OxkD+dt35lu0rznyJNksb6HiiDNs8gYeteUkBClbFYDbXQpNwNuz
X-Gm-Message-State: AOJu0Yz0tEeiVWWthnh9RF7HlvaoCMCUMHRS2hzgYwejUvD64H/IJMzM
	KP7ARzMZCd2DzhFpMv07ZXf09irOqotT73hHozawzLz4BURTxZc2
X-Google-Smtp-Source: AGHT+IETL78m7ZeFry37MvMQPHrFPUt9B9nhglzozLw6jieNURmmJlYaUSBLeFyUmEfLsTy9tRJC9w==
X-Received: by 2002:a05:6a20:dd92:b0:1c6:b0cc:c510 with SMTP id adf61e73a8af0-1c8f859e84fmr4263287637.9.1723719596662;
        Thu, 15 Aug 2024 03:59:56 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:30b3:f070:7306:329d:c8ca])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae6c76fsm829915b3a.94.2024.08.15.03.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 03:59:56 -0700 (PDT)
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
	Abhinav Jain <jain.abhinav177@gmail.com>
Subject: [PATCH v7 net-next 3/3] selftests: net: Use XFAIL for operations not supported by the driver
Date: Thu, 15 Aug 2024 16:29:24 +0530
Message-Id: <20240815105924.1389290-4-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815105924.1389290-1-jain.abhinav177@gmail.com>
References: <20240815105924.1389290-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check if veth pair was created and if yes, xfail on setting IP address.
Use XFAIL instead of SKIP for unsupported ethtool APIs.

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 tools/testing/selftests/net/netdevice.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/netdevice.sh b/tools/testing/selftests/net/netdevice.sh
index 50f7b9d1163d..15d702adb0ea 100755
--- a/tools/testing/selftests/net/netdevice.sh
+++ b/tools/testing/selftests/net/netdevice.sh
@@ -68,7 +68,11 @@ kci_net_setup()
 	fi
 
 	# TODO what ipaddr to set ? DHCP ?
-	echo "SKIP: $netdev: set IP address"
+	if [ "$veth_created" ]; then
+		echo "XFAIL: $netdev: set IP address"
+	else
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


