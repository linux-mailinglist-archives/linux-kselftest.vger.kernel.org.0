Return-Path: <linux-kselftest+bounces-15637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A893B956A8F
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 14:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46E25B20EFD
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 12:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7DA16B3A6;
	Mon, 19 Aug 2024 12:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOVc1Slh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F0B1684A0;
	Mon, 19 Aug 2024 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069585; cv=none; b=ujz0yPZtBRaoOkpW+bifZ62UWlEMaU8aikh4Nyq1ybWrESLeGoEKD4CX4YYA1bNNlLd42A6PHx0Xm8JLyI12aq1xXaQ2YMqNTii9bz7JaDAhmge0XQ8CXK5Jhlpewns6DVt3RA7OjLY6uaspFSuJW8bOD4vSFqZLnxwqm7VSnTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069585; c=relaxed/simple;
	bh=BEOj7P4xJeFSnOj0Ju6Rm9KsxDM/MTPYKwQ7Ti+PJ1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O5S/TlCK5s3cmUhgzy3Kxw46PVF22sI9dw833IZw8xaZVJmiF0eOlywMVpIFtoVZ4154aH0B+5libkfU4FoANDII8qetjzEedpONMjT+ZTAU2sX82yPjn8gPoDe5JJTPGIEO4sd3ZxFmBdPjfi3mDgcwkoyglV0hvH0EM4xqws0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOVc1Slh; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d199fb3dfso3488347b3a.3;
        Mon, 19 Aug 2024 05:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724069583; x=1724674383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2r9/EW3jCvQa7Bv9foKbr5PU4TW2LXHUdYb6h2YrHw=;
        b=fOVc1SlhLtEvtVl89oMvtZ8X3QEj5nuDmj2/XNwzuYkEmbnDSOye/BMo/zNgxzTaI8
         r/rAS8KxCpabKwi1UuWrANYWTZTMUHMWPq56X/weM2DtMVReFCqyGmRY/lLvcxkEvBvg
         nqi7ajnE6nlLvAYZo2TMzCA2Aoe89haY7GCysZF3xRAevqwcp/JEfuuMNPxjIUhdN2jR
         J0MJ3NXugNB2+qJ8cr8E+D7Wd6PMAF2d5Stb7mKgdGBI2ry1cBScM7xKVwPG1/d1KAMK
         +zf4r/7qXK/gQxDq6i8i0tDWBWDWnpgB7sQ3OySNzl72bA15wKneT99BHvtkrPw3fp2h
         BlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724069583; x=1724674383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2r9/EW3jCvQa7Bv9foKbr5PU4TW2LXHUdYb6h2YrHw=;
        b=gc798s5xt3pIefFLg7zax0X7OXBAO4+FXI413t545WiqqEy3iMIxOE5fIU0EyMgRhK
         gnmSXaPTkCkg0UfNUyzNr3sRTd2SI2g32RloazumPOt08GrfhD7ZdOL8cKE3d2yOJWIa
         KBfkTp/DYFYQ+0zt6q0F0qsQAL4m4bPfhPjUwPS5olqHgRHgVc1wwaxP/GDVTwfccY9K
         kw5UH6SEmdO6Ypp+zlujsyyVGp93etp2rHm+FKcBJ6YQjX7jBlGEb3ybz1mxBn35V0tt
         BjThYQEUbJZ46qePaCAG4rfQO1WKHQXtt9Ef3ss6d6qRsnhMLPLb3xvAffNNahd4TXPZ
         LF6g==
X-Forwarded-Encrypted: i=1; AJvYcCVFKNn6XfywmYd/QgQL+QEHWA+2WPZHLpfBbbjI3BnD9ivMjkGOAuIrNGB8us6iuS5kx2m1QZF6OXV6qFke7d69yNYgUTU7//pg9Fj1flM8uDwxFfGXOf02mujtnjv2LKABBqaXtOOtIYODDk8HqpSMiaMUPayXdEdJfF/OsftfiYer9A38
X-Gm-Message-State: AOJu0Yzbvb8HVdgKn/aae5cbXnwbVLGA8MRURNQ/5s0g+A6BjIGuTTMi
	RM9IrSVRCsu62FzlqJgzlVBjZhoA4ywFQZTdH2xkMGM05YdcEjT8
X-Google-Smtp-Source: AGHT+IHpYPA84Go2byJh65QR22zn3QDfITNy6v1TMmNpYN71SCmtfn2Ep0mbIUTY8Tabo4Tz7SOOjQ==
X-Received: by 2002:a05:6a21:328a:b0:1c9:d432:9fbc with SMTP id adf61e73a8af0-1c9d432a426mr12053839637.2.1724069583458;
        Mon, 19 Aug 2024 05:13:03 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:30b3:1f59:cb71:c749:d10f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef4136sm6501798b3a.100.2024.08.19.05.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 05:13:02 -0700 (PDT)
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
Subject: [PATCH v8 net-next 1/3] selftests: net: Create veth pair for testing in networkless kernel
Date: Mon, 19 Aug 2024 17:42:33 +0530
Message-Id: <20240819121235.39514-2-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819121235.39514-1-jain.abhinav177@gmail.com>
References: <20240819121235.39514-1-jain.abhinav177@gmail.com>
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


