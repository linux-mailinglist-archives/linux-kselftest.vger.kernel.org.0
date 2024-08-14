Return-Path: <linux-kselftest+bounces-15347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 144F7952289
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 21:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C487128215B
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 19:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34701BE845;
	Wed, 14 Aug 2024 19:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzLeQsGu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811651BD508;
	Wed, 14 Aug 2024 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723662939; cv=none; b=c4IThReCr9/nv5a6R/2/mn0yq4pXfJfdOD1MoxdAG9CmYgbmzDj30FduqRzjorf/nHQtKKfLVZVR92KpFWu68m3WKZDW3s+O8TOuK2i64sDjtYWRXKGCsLh+EYjVd8UIVz8qexp8TsfRPo7CGis0TMBsC0WCDrbl3GT0bQR35c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723662939; c=relaxed/simple;
	bh=BEOj7P4xJeFSnOj0Ju6Rm9KsxDM/MTPYKwQ7Ti+PJ1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h/nQce/sVXzgERyRkUi+/PscdCCxMDClJl2CNwkYk6/+sG9lKzBoHsO5kpoWmgBt2EyKWr6dFeAACMSUcO2P+2hTBcAj0ZOa8AXGo0Vgq5KxmaeF/mETQMwIJ2+QFztZVJL7Y6zU3BsAZnrRRy+xY9X/yYharOI/Pph5PoY1OBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzLeQsGu; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d3c05ec278so114921a91.0;
        Wed, 14 Aug 2024 12:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723662938; x=1724267738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2r9/EW3jCvQa7Bv9foKbr5PU4TW2LXHUdYb6h2YrHw=;
        b=bzLeQsGunZxPbkpUuGdRPcLC6lwRMKhVRJp5Rg/UVMhQbfclvVWRJh4KGqFS6y9QQg
         vh/tcE7Fi0aeiHv9KZ5WX2CrAr/Q8/sbmxpB96gFHIoGsTFVbMCUYCwPtJ4Irvyk43rd
         68NC/5hEaWmKDayUwI4dKku7mTu5ui1TvwFfY2yi33LgiZJV32f7lEf7bBpbDzDID4bB
         cYTfnc6NalFC6YdeGETEyN6xIUSI9vHa88w9gGmXuXH5UZYdiRSPBX0TddJX8kWShSyQ
         66N8oHnGXQJiYra3vml/nsGRnKaupj+EdoRnlgyH0y3aM+J/FWH6GVboSqqYB5IyyqI4
         s1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723662938; x=1724267738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2r9/EW3jCvQa7Bv9foKbr5PU4TW2LXHUdYb6h2YrHw=;
        b=AotBffj5r2j5rsBrpvHAK56kznbb00PIQjUh+e7XmmaP43BfCwta7/zEZa3VjekTQz
         1RJ118Qxq0IX2InRtqI14a0nbtIr6VvD8JX+a3JFNXn4wzuVyUZ4eAKzfj7/Fau9EvV5
         wekYB3ld6VfGxohXTJ2SlSSAZtNgWopa/wa0vNz4Q4zGSfG4SvxY1Q4cCU5H1WARBw0D
         e7kK5O/btJSqIWcO4fS6UOoipLETDHSYYmrs4fd8cLSUsT5VEE9VYl8LXJ93PB8zZ/Fn
         34KhjBksDwUtroa8sQzt+vWasv5LAWfhzogwzORmHrg+BRUd1dJnWxVUpn96i7PkSwqa
         9aUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT6/36XOU+MGosLikO3gsDX9cf5h872uZwCAHmQXFQPxIOvT3lUOurqPcdAAapt1aEm4IpMCvEK15e+jQQUYUnJ8vPbksZqljUf8MTevjUrJ94D21FCy3PA/fcrTNFqxZg4yeJ7RQRpPcAoX+kw6r5MiGT0H54w9ptzfmbMejxxy8enriR
X-Gm-Message-State: AOJu0YwOv/CoNc9cqxjhxF4hy7L17foSQqyt3V5338+APve3iSNtcqAW
	rgz1FFeD22x4I4cNsUsYmHp5pCsCYNqJ+pl34sXuOYx211tsol5I
X-Google-Smtp-Source: AGHT+IGTqdlipCui6z9yrJAXOe8iyPROKvQ4HQ3FCF9a7Y6/8BJFvq1/R+ZM6VW4b64Poa7InVwylA==
X-Received: by 2002:a17:90a:9c9:b0:2c3:2557:3de8 with SMTP id 98e67ed59e1d1-2d3aab48f8dmr4080373a91.33.1723662937557;
        Wed, 14 Aug 2024 12:15:37 -0700 (PDT)
Received: from dev0.. ([49.43.168.58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac844e54sm2134282a91.44.2024.08.14.12.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 12:15:37 -0700 (PDT)
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
Subject: [PATCH net v6 1/2] selftests: net: Create veth pair for testing in networkless kernel
Date: Wed, 14 Aug 2024 19:15:16 +0000
Message-Id: <20240814191517.50466-2-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814191517.50466-1-jain.abhinav177@gmail.com>
References: <20240814191517.50466-1-jain.abhinav177@gmail.com>
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


