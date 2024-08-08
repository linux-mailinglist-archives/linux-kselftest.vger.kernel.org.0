Return-Path: <linux-kselftest+bounces-15026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8403B94BD59
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 14:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1985A1F236A3
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 12:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E6518C910;
	Thu,  8 Aug 2024 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZrBj44n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0B963D;
	Thu,  8 Aug 2024 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119923; cv=none; b=KwE+RZ7mxIxpc2DlGkoBtqDSJhjBK/TpnvFldTWxaBquiW1BYWbDMHDVJ1j+U6UfJwifScaDQxndskZ8sZQT9XiYuJwnsL1mhCPNRoKmQau/pB6kDajWDWUtrhD+VWuQ3gaPli86+gp3axX+pygz7wwP+h9hGQ/r3YHphQC7p6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119923; c=relaxed/simple;
	bh=BEOj7P4xJeFSnOj0Ju6Rm9KsxDM/MTPYKwQ7Ti+PJ1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PGeV6mXqjJ9+yks6nKCZ9eDyzxtOxDqwPRagpnw2TOr51xz/Y97Qa27+NHQJMxqWNWgpK7J+XzCGTe/LYaF0UBdw5P5Um9KseVra9iV7/p1dB8iSQEQ0Jr3nLsqam0HLaDxIGC2+aUP/LHlVbVMrdmdkNDvOxvwhVbJb6D+UeGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZrBj44n; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3992195d08aso4352945ab.0;
        Thu, 08 Aug 2024 05:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723119921; x=1723724721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2r9/EW3jCvQa7Bv9foKbr5PU4TW2LXHUdYb6h2YrHw=;
        b=cZrBj44nvDO8xYt9r3ZhMaKRI+xL+eLSYMgVmvdM3P22ESX5BvK2qbsu4aHO1E6u2A
         Jjf7bZ/RpmJQQ+i6m0FpYWtOIOzocjEbokU1aM8e9rTsyItZDXRqWTV0ETj/io2ktxbo
         hj5EZFS/BWU1hBmMXu+lJClvJ35HCO1rR0xpmaFJE7Hy/1P74qYleOwmIXLDqp+slP78
         fiDBJXAExFtOf4LnhBhfYCjai7jdmYehVDfKiYtIAyMPmzkM6M/FYfpOkunDECMNa/aH
         1fgmHBJxSJTGdckIwxGG50A4CkXusBpIwAsoUQJCuUTnSHYaNkVtSRjXJGsEUvkHyA7u
         +4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723119921; x=1723724721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2r9/EW3jCvQa7Bv9foKbr5PU4TW2LXHUdYb6h2YrHw=;
        b=ZDpaVQd9vAmTn2uqHI2bsbJSZS1dhb5XD5LNJiPq3pdeG0wO8lcdweJsWJRFt3v0Ac
         cJ6/IINeEIBgxJqNH2QCHSObRAOGoyS/v0tY07THhwBYrdynNv3CnehIlKPmgdTznS+6
         1vLGqnY6A3/K4o26Zl0zUXbukACjF8q4UDqoOKAGf/Nc+UBE0Rd83v5BhLXkaE1lcTgF
         xTvkurhqcic/yjkk0Y4btw5fT28yKRPeayMZdHYXFjdG8EKiJDJN6WIMRo2gC+RjjDEI
         JtUAjlHxIfQlyp3g09TvPB9KDSx2IC6ScR+efSpaYPMZGlSrVhpghuiYimBsVElW+H2C
         gNCw==
X-Forwarded-Encrypted: i=1; AJvYcCWLuCyz8jpX1Xi3kkOsQADE+/uSh5cWb6MaX4oncYFm+Css62BA2zEL0IYMtCxJ0/XYxNaoDebHSvzkXKxHTnkhVBNO5hOBlvvfuL3AvxyZFnHZuihIkgYn6gBXYqOb9cZ6FQ02+Xcu5SeT6eAtzdv4I2pPxYJ8r/qojegcanlBJ99BkC9B
X-Gm-Message-State: AOJu0YxIffisqsQGY+xxKxvIBKFs7nBr32vBAmYD649r5nfpH7n6n+Yz
	DITu5cGkWTYq2r7wF9uQKd8hRYQh+tbcL/UehObHg7LFuJk0LiJR
X-Google-Smtp-Source: AGHT+IFij7QgIminx3zQ326DgNnXLdzGL0ae9IGkEvZoVLWHWcnsgdUGF2Es7GGgesyb77tvAxq8eA==
X-Received: by 2002:a05:6e02:1c22:b0:399:4535:b66e with SMTP id e9e14a558f8ab-39b5ec74835mr22452425ab.9.1723119921397;
        Thu, 08 Aug 2024 05:25:21 -0700 (PDT)
Received: from dev0.. ([49.43.168.245])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7bb819e782csm5530478a12.48.2024.08.08.05.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 05:25:21 -0700 (PDT)
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
Subject: [PATCH v5 1/2] selftests: net: Create veth pair for testing in networkless kernel
Date: Thu,  8 Aug 2024 12:24:51 +0000
Message-Id: <20240808122452.25683-2-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808122452.25683-1-jain.abhinav177@gmail.com>
References: <20240808122452.25683-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check if the netdev list is empty and create veth pair to be used for
feature on/off testing.
Remove the veth pair after testing is complete.

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 tools/testing/selftests/net/netdevice.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/net/netdevice.sh b/tools/testing/selftests/net/netdevice.sh
index e3afcb424710..0c32950fdd17 100755
--- a/tools/testing/selftests/net/netdevice.sh
+++ b/tools/testing/selftests/net/netdevice.sh
@@ -129,6 +129,7 @@ kci_netdev_ethtool()
 
 	kci_netdev_ethtool_test 74 'dump' "ethtool -d $netdev"
 	kci_netdev_ethtool_test 94 'stats' "ethtool -S $netdev"
+
 	return 0
 }
 
@@ -196,10 +197,25 @@ if [ ! -e "$TMP_LIST_NETDEV" ];then
 fi
 
 ip link show |grep '^[0-9]' | grep -oE '[[:space:]].*eth[0-9]*:|[[:space:]].*enp[0-9]s[0-9]:' | cut -d\  -f2 | cut -d: -f1> "$TMP_LIST_NETDEV"
+
+if [ ! -s "$TMP_LIST_NETDEV" ]; then
+	echo "No valid network device found, creating veth pair"
+	ip link add veth0 type veth peer name veth1
+	echo "veth0" > "$TMP_LIST_NETDEV"
+	echo "veth1" >> "$TMP_LIST_NETDEV"
+	veth_created=1
+fi
+
 while read netdev
 do
 	kci_test_netdev "$netdev"
 done < "$TMP_LIST_NETDEV"
 
+#clean up veth interface pair if it was created
+if [ "$veth_created" ]; then
+	ip link delete veth0
+	echo "Removed veth pair"
+fi
+
 rm "$TMP_LIST_NETDEV"
 exit 0
-- 
2.34.1


