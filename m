Return-Path: <linux-kselftest+bounces-14939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE27B94AF43
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 19:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFDAF1C20E78
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 17:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2126613DDDF;
	Wed,  7 Aug 2024 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEI/pmf/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE6D12C530;
	Wed,  7 Aug 2024 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723053465; cv=none; b=FLb7jXcs6OQiM8FDmmb05d5OotXd12XtHyBSc6wWrfTOOok8leADH/tRLyNogRUPM8NbbBaIc0nV4qhvTPWVHOzrjMnZPUGZRunrwU/QGfbciZ2nzSo1LH/XCHlCiozkMv5WYAARoDi/SJbVUUeSX6LzddkEKMRiNh2rmB1k3S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723053465; c=relaxed/simple;
	bh=BKdo2BgTuVSD0No4W5JM5DVP++KzIAvQpzbCz7u5oKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MX3MApXF4iiaD/DaSkc+VKUPiDO6FeRUwNv65t3ITDzzszf73qTOrJmSZElG9NneP/mtw6maNTLEiY+kqxlqb9mWUsxXBDHHc6QwONzHBL28NAgzcAY8pkgcDk5zpN1MVk0aW8rQ/Z3yRIAGj2HAxxUJMjILUsxPyrI6+NBlW5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEI/pmf/; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7a130ae7126so89778a12.0;
        Wed, 07 Aug 2024 10:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723053463; x=1723658263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOxt/D/q6+cleEdMW1v8K3M2vJvSoJHG3OTmD+P1Dlg=;
        b=cEI/pmf/ETuHBqedIL/QOXdKupr/tRKBvTwsC2UMSIzky8eIjz2xT5o7eX/TnbeaBV
         uECV8SsSgt8mW2FS1unQXFuJM/uGvy7r1ZeQz8y8+msdgTdVmqvF/VPp9GYSARFz5Uqb
         wx7aQcrx9o8O6bHfEwi8iGeMrcn+c0WdjsbtdY89hmyXMh0yCpRVxcZWj7Y8ZoSSK1R4
         QFTA9sRstNaPTw/8uiuaNKVoy7/kfN0SM4iCoTS3XG5ZQchyYM10Da8s3MBr2ZRRfjCB
         sUZgix9oeDgyIhlvuKyIWpRN0ZJ8Mo67K9ME5lu6QSs4VGywi7FrGHONHVP7z6ZPp3H2
         5bkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723053463; x=1723658263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOxt/D/q6+cleEdMW1v8K3M2vJvSoJHG3OTmD+P1Dlg=;
        b=B5H2TjVNMfu/o1NOG+UEPP0sNZ7AyqyTcXPft+9gFKmo+5zhil5JeEQOrDSCQ4+g/4
         lNMxBitaEcvA8c6zYaZdoQC5dGShHoA5MDV2MsUYSynDigM3UZ8Dem8b6T8KfiVZdzwS
         UfhR6bD7wlVkc58XiILikXoeGfWNj7wsqPN1LREljyuJNyEcrpDwPv78oss3YNnOD8fK
         25RyTjTmZ7opwjCUpQo8d5/itt5iunT2nwQWx78Zl13H/3rqqQTGyVxFtf0Rf5ryghlp
         JEkEJCRjgiulmQPtobdQ9mJNCXL0hEPPaQBWWlVY0vFeUq5kHZwsNbqiGLqWxrDjYMDn
         XJ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBSJRjhX7HxybzkkuHYBUyzpXXC2SpwIakM7BFUtld2KaFtFxRdSODDTcpHEK9+UZxOGeBR7/416Lwu98=@vger.kernel.org, AJvYcCUN75LfhBNBOI20822UbBPAinNGJetVNr+LV948kl64OkWPBG6TT5mxcJCOtgmKq7qyvSNy/fNKK/W7LL3c2rYm@vger.kernel.org, AJvYcCUze5T8KRYY8xoqhJUvIQdS5uvE0TUoemkXNluT3IrJkUlsRYqmLbsPlkK1zVdkFImrbZ9p1UT/@vger.kernel.org
X-Gm-Message-State: AOJu0YyYXWlPomeQ2rCks5N4VIFUQiiURjbfkKnI/hZW+V5A0R+2b6Ab
	ZsPlwT2EoAmftpUj8yt1AHVSfyr2m9NrPiEE0F1sRkLXVZFyu7XG
X-Google-Smtp-Source: AGHT+IEtWk+es4YSPYTT1ALAEcu6iMxsRWwf2Ejj/dNCPEsP3XRXTkH4RwvPnPAUYnY2TC7trklFEQ==
X-Received: by 2002:a05:6a21:10a:b0:1c4:b8a1:6d54 with SMTP id adf61e73a8af0-1c6996284bemr22357114637.36.1723053462802;
        Wed, 07 Aug 2024 10:57:42 -0700 (PDT)
Received: from dev0.. ([49.43.168.245])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c211cf0726sm204429a12.16.2024.08.07.10.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 10:57:42 -0700 (PDT)
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
Subject: [PATCH v4 1/2] selftests: net: Create veth pair for testing in networkless kernel
Date: Wed,  7 Aug 2024 17:57:16 +0000
Message-Id: <20240807175717.7775-2-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807175717.7775-1-jain.abhinav177@gmail.com>
References: <20240807175717.7775-1-jain.abhinav177@gmail.com>
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
 tools/testing/selftests/net/netdevice.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/net/netdevice.sh b/tools/testing/selftests/net/netdevice.sh
index e3afcb424710..279c44271047 100755
--- a/tools/testing/selftests/net/netdevice.sh
+++ b/tools/testing/selftests/net/netdevice.sh
@@ -129,6 +129,7 @@ kci_netdev_ethtool()
 
 	kci_netdev_ethtool_test 74 'dump' "ethtool -d $netdev"
 	kci_netdev_ethtool_test 94 'stats' "ethtool -S $netdev"
+
 	return 0
 }
 
@@ -196,10 +197,27 @@ if [ ! -e "$TMP_LIST_NETDEV" ];then
 fi
 
 ip link show |grep '^[0-9]' | grep -oE '[[:space:]].*eth[0-9]*:|[[:space:]].*enp[0-9]s[0-9]:' | cut -d\  -f2 | cut -d: -f1> "$TMP_LIST_NETDEV"
+
+veth_created=0
+
+if [ ! -s "$TMP_LIST_NETDEV" ]; then
+	echo "No valid network device found, creating veth pair"
+	ip link add veth0 type peer name veth1
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
+if [ "veth_created" ]; then
+	ip link delete veth0
+	echo "Removed veth pair"
+fi
+
 rm "$TMP_LIST_NETDEV"
 exit 0
-- 
2.34.1


