Return-Path: <linux-kselftest+bounces-15399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C25952D1E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 13:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5219281EAB
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 11:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF9E7DA89;
	Thu, 15 Aug 2024 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4D7asOH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42411AC89A;
	Thu, 15 Aug 2024 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723719590; cv=none; b=PWf/4/iV13v7mWzphfv0ltzPkmkSyKIRwB+zI29WmHW7quSZBykNDIetHrr8MbDNo6r284KBqpRSdg5ufTWKULWHGmjXVlx61mvP/ywMcwpV1+20sLr3TGrc3RM6aMlY8nSPi//00y4xPL9EFTlYgqGUu0o4OrXq0PWcz1tSdjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723719590; c=relaxed/simple;
	bh=jtalaf4i0vBrVvnWmgxU3qfha27p3Pcpv6SHl8PIUGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XwADcKJEZDBv3aWLM/l2GMPxlW5TYGvTTcf4yCkA+oNSTqKeIdPyYpzhUkGF6NmNHFK1BKLDaGP6Yr8XcbrVixs0jUC9NzVK6nMw8G/iiWbNI9Q9+OmKVpPHAXRIwVsWUOsZtGnDQxXZt9iAJVOXZie0fuemAEoxIEHOykMLAVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4D7asOH; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3db23a60850so489392b6e.0;
        Thu, 15 Aug 2024 03:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723719588; x=1724324388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEXn+6uaDaibQ3LCSAfL1ofGJtzehJXz9fPnsXVCy5U=;
        b=A4D7asOHupG09QwqOxU1ZeHs1qZIRXhpRkuX9h6kc9tEnULQP8Q/BrX8XkHIQdsh+4
         DwyaAnaUCefoRFseOW1YimszjfSZUc5FtjAuaKQhoLWr/dwvTfKX/5tVeDW6y7fEV2di
         PVEuFIBGzT0vbYN51ein09qqww99SYz1IoT4tDujBLgSATy4UwdN9+89MYyYmAlr7TV4
         sQG7X7MD04y1Hjok36NbmHg6HtSphQmD6HURMeLMDB092GB6vYlp2zFEMXevsz5mmbRd
         5pqg2X5/cIKmI71MJcINbIS3jEg4jST8wVhoD607w9u+w6pW9r57ZqFnifsqWWb8Ib3W
         LMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723719588; x=1724324388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEXn+6uaDaibQ3LCSAfL1ofGJtzehJXz9fPnsXVCy5U=;
        b=g88TYH6nPCoTkYXlXGSdaM/DpGRLw7//Tuxbi188fBMjIqsqsRimRdF3feF2Uce9q3
         ki9Nn4Tfr8DcizBr2TrUnJZUzoF76BSrqRV9HLmHJxkqjmA7W/FGgRUDdlbXPOm8h2JS
         boUONRjJjHOkKbVaXuq8Cmt5ARIbkiaoCsHg2tktBMqrOqMzedLEOHEWz1m5WBURcgQO
         GwRfZafLakoGkuOIF7cstuxm1s4bBIUAiLag4CpHvy7sgMh2E1wf91A9RTeDgd3S6j+i
         0eSt1Nrlmj7KpUwgquBGMUtmkholnxEkPnnVgkRInEVwqxpbPnou9W8hUfNtskb9k3ax
         rZnw==
X-Forwarded-Encrypted: i=1; AJvYcCVlpH3IiBo8ZxLr/4imI7Y02qhE0nRlK68+YRQij1shig2CpRMORvUuJibEY/V7jx7FSTlls0+PYGiFXhHOuque55R/BSH4w4qPLGLO0CJJ2eeA48PBz2bF3DNClJvvRjjne58Ri+Fs3IgUF6bfW2j5D9oLqK4KqWjHGY8BsPMMp/Kwt+3W
X-Gm-Message-State: AOJu0YzkuebxA68C0kC+cQC85RviUUWBMeBycBrYGxJI3dL9vxu1V80y
	U7W1IBe1cE7JXtvxURFD4qKpc5Rg8ybBndPeNxIBcGb9MhLNSvbj
X-Google-Smtp-Source: AGHT+IHsRd4NalhaB6IlCGdqhEueKN+5uOe1kSJDF/52TbNUgbDCpKuWdsm1SucgNabrpAQXIY1HoQ==
X-Received: by 2002:a05:6870:b6a0:b0:25e:14f0:62b1 with SMTP id 586e51a60fabf-26fe5a63926mr7083078fac.13.1723719587691;
        Thu, 15 Aug 2024 03:59:47 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:30b3:f070:7306:329d:c8ca])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae6c76fsm829915b3a.94.2024.08.15.03.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 03:59:47 -0700 (PDT)
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
Subject: [PATCH v7 net-next 2/3] selftests: net: Add on/off checks for non-fixed features of interface
Date: Thu, 15 Aug 2024 16:29:23 +0530
Message-Id: <20240815105924.1389290-3-jain.abhinav177@gmail.com>
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

Implement on/off testing for all non-fixed features via while loop.
Save the initial state so that it can be restored after on/off checks.

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 tools/testing/selftests/net/netdevice.sh | 37 +++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netdevice.sh b/tools/testing/selftests/net/netdevice.sh
index 0c32950fdd17..50f7b9d1163d 100755
--- a/tools/testing/selftests/net/netdevice.sh
+++ b/tools/testing/selftests/net/netdevice.sh
@@ -124,7 +124,42 @@ kci_netdev_ethtool()
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
+		initial_state=$(ethtool -k "$netdev" | grep "$feature:" \
+			| awk '{print $2}')
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
+		ethtool --offload "$netdev" "$feature" "$initial_state"
+		if [ $? -eq 0 ]; then
+			echo "PASS: $netdev: Restore feature $feature" \
+				"to initial state $initial_state"
+		else
+			echo "FAIL: $netdev: Failed to restore feature" \
+				"$feature to default $initial_state"
+		fi
+
+	done < "$TMP_ETHTOOL_FEATURES"
+
 	rm "$TMP_ETHTOOL_FEATURES"
 
 	kci_netdev_ethtool_test 74 'dump' "ethtool -d $netdev"
-- 
2.34.1


