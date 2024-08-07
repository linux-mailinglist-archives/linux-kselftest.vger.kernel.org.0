Return-Path: <linux-kselftest+bounces-14940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CDA94AF46
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 19:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95D91F232E4
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 17:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AF013EFEE;
	Wed,  7 Aug 2024 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfQpXxZY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE6E13E41F;
	Wed,  7 Aug 2024 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723053471; cv=none; b=YPYErrhhN944vn/AXjvqNR5LCRVntxZMjuTosSDvU32aC3SsHWrMetogBoDVqiFRN/mrD5Wg5rWwn7TURmTMUyLDVWkL4Qtg7+CRftltv6yIFmG8CboxEEaBjzSxNmCotmHzyVoOKus6lwswH48vCxyryDtNThHQKtg3JaNZ42c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723053471; c=relaxed/simple;
	bh=EJaNkWx/y6M/BndspDA0u/hBD5TnejbZPqX+oXi3PFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qX78u7WmVtZT/Nhp15Ss9GKyDfZ6TfYB83QWaoIFxeg+U/QapBL/atCTJ74IyryhJOXy5ajj2KMCCK9c8a29PZ4F7WBQVyt6OQeAF8oxF/8wmcT3WJMGj6X7G8Btzzg+OTd48gLF5P/KAQi7k5I+Zu2cWSbPTSV21m/HmQZkHZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfQpXxZY; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5d5af743b8fso81350eaf.3;
        Wed, 07 Aug 2024 10:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723053469; x=1723658269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIYZPj0XxrcTT0DiLPDJV5xAwl/g4Iu8eyMqfnptQAM=;
        b=JfQpXxZYpM3KM9KIgCg4VQViugOl6NQwa0wMLxKm2KS0eDMM2boHjpajSXm8beWU1K
         ubiXPT4t6WjBvGodll+dZBcSpNDLax1ppVM0VdmXcMLq2N+rrx1o859jHLBPQOp3KvLn
         uG1K8/nSFmjshilKPvdTPgqd9Vo/THsJjl+hNUPWUHj5sCd0lz9EZx95h9oAbdZ1OyeL
         8MkM6f8swRVX7j5QKwUjoYgZngm79uFmepReH4u1jpu6wpfRQPeccii+NRrsTgGcTaqv
         jJV19+19UC2LMMh1i11KRPtxqCY4FLLi0TsJsO4vgSvUdgrCFyf7mi5XPL1CIOmZAqUF
         zF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723053469; x=1723658269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIYZPj0XxrcTT0DiLPDJV5xAwl/g4Iu8eyMqfnptQAM=;
        b=coao2iHR0lki/EDEQ32UjDp6bz9dSuJaFAtbPCI6ooeWpi19mPjt1S7XC7ORv1XAfm
         C2qp75g89E7Js7fDZAhnoYO5X9vlY6V0g86kwNR5fwvUQRU6jgWyleKkxqAzPf/lC0dP
         dPS9xxRbA7tZopzpfMNZiuAXrXLeHPbAbhtLner6UcwWKVvw3gxeZrTzmhYOsMzX04/B
         G8JSQ9P496eO9/pkRUThFVZSMaXI9XTDeeJvODQfti4LI9qsWil619B8BtFO2IfKhtcn
         vldFxtxLPVjXjfOFqXRzrJNhOeUX5se93t5J37TvIylzTBrmniV0jPV5+Hdn9uQfTHgK
         QX3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAkG7eTnfOxWDVqQ9YyYvejugMvBfuYjrN8LkLrQhUaAZTynFWsD/mMtTLHnW1rI2MYkHauJ1tPZ9P5EaqZvbagLQ+zR8oWTfcn5gZkqlUZBi2bacfFJAmw424NWt+zbWXUKVJ95PVcgCCaWgrDRNF6dGfSPvwWpW0JpxH9tiacfogE9M5
X-Gm-Message-State: AOJu0Yy17RwdbLok+Ii2sO5NUmWCdJGmQ1m6Vl/1rNYhlxt0f+Lh8BFu
	sDSQngyQQmC7vBfkF+cVj77DEb7w6cWzYHXRAelsqxrz0BbIv0Yt
X-Google-Smtp-Source: AGHT+IH97XDaol1t2S2FYFv+WYC75ETsVyeFNRfItRFLlIPkRstLsyqQlWf9Oz8ZC2b+2yulKgvC0A==
X-Received: by 2002:a05:6358:6481:b0:1ac:f722:4c1 with SMTP id e5c5f4694b2df-1af3bac737emr1583733055d.24.1723053468467;
        Wed, 07 Aug 2024 10:57:48 -0700 (PDT)
Received: from dev0.. ([49.43.168.245])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c211cf0726sm204429a12.16.2024.08.07.10.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 10:57:48 -0700 (PDT)
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
Subject: [PATCH v4 2/2] selftests: net: Add on/off checks for non-fixed features of interface
Date: Wed,  7 Aug 2024 17:57:17 +0000
Message-Id: <20240807175717.7775-3-jain.abhinav177@gmail.com>
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

Implement on/off testing for all non-fixed features via while loop.
Save the initial state so that it can be restored after on/off checks.

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 tools/testing/selftests/net/netdevice.sh | 37 +++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netdevice.sh b/tools/testing/selftests/net/netdevice.sh
index 279c44271047..c47fb984616d 100755
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


