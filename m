Return-Path: <linux-kselftest+bounces-15027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E3E94BD5F
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 14:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B711F239B5
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 12:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9210218DF6F;
	Thu,  8 Aug 2024 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5ApKnDT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B87818DF61;
	Thu,  8 Aug 2024 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119930; cv=none; b=kLqq7AMUaJh/Qi2g9f7I/dVZ5pygPjlJaO0StLeJ4+SqNPft4hZOx59hxwET77i+Bh9qvZbrAwiHzi8gd4ecZ/21c29fNhPIkmQcXpckq3wuX9dNWUfZ2FG+T+Z3WyM/mrI6g0KnOytLS1BuVDtS9YpxhLhT30edAqNChE8uL5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119930; c=relaxed/simple;
	bh=jtalaf4i0vBrVvnWmgxU3qfha27p3Pcpv6SHl8PIUGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V2gyf2WG71TSzljb/lqQ3TwVsWbXnQxP1vgAU/SWn4tlFy93qStg3Ar9qgpoPckYpx9yPmPfYEY20/ryy+pNxkuLHsnNRET8bVedY4jF8zGr4PWyDxC/HvRDHcWhcHZRWo8zYQ/aM2OUZS2ymjtGCH2fG6wQDzQChqr4fAbAvfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5ApKnDT; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d19d768c2so681156b3a.3;
        Thu, 08 Aug 2024 05:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723119928; x=1723724728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEXn+6uaDaibQ3LCSAfL1ofGJtzehJXz9fPnsXVCy5U=;
        b=d5ApKnDT8OdSZqMKINK+T85dhzgQxW0QX+cfQo+mZTl6kUm7//6AeE2HeDMvI+sjZw
         rwZ7I8R+15C+4D1DVyKcfPBKTZ+uZ1bbe341LrRgQ/iGmFukC1NRNEgzTTcn/MuZzwSi
         xNVfXb8jig7rP1cqTFdliraRsmM0TaFHk6ujBjVaiYn7xpvyqlFMdQHYrFDzxLkGWQi8
         0D/6qtwVMbwhfmOXI/94UMJsAJoqoRGEbzoj6kyaMrR3oq/NluSS0B0Gt9J5+PSDq32D
         Rp5hcD7jv2HRadKOgWbAWF0VruaORH6UwuDqbdlvJ9G7943gcYXq+Ybetsrzfle6t4Rc
         op3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723119928; x=1723724728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEXn+6uaDaibQ3LCSAfL1ofGJtzehJXz9fPnsXVCy5U=;
        b=udor4NgH9hhYVZqf1JlxnuYcSBLq9hjSX8fSI9mJfJ7+fbUtYlEo035mvs/GKxidMY
         WqYPOPSIi9+uuKFzYiygwE86CDfFBCXTR3wb1EW8jdZ746GwxzFNhFSGh+1iM+3bjsMz
         FiP89SpJYIw6HZ9bSdveUZLlxib9wK2Gbp+BKw8JSeUWwelUH2b4zqgK07t4b1TlqLZM
         8ma0X7uCFjhFdNtwnCfyEZGKeQZCQNqYHnQcMQFvEo3sCJNRp4i2CtcXDUmu87zFwUq8
         I+OU/WEy44ODNKE0A6HfWmtnwIuzAUZeG0O2Mj/Adr1EnQT8oWJBh4DfKx8kcwymztGe
         QKrA==
X-Forwarded-Encrypted: i=1; AJvYcCUVSWSpYc8xunFxmht2kMadOLw9Y8/spK3y4gsKWl6UPpzcD6bCZYT0iSGUAu2XQUH9CY32RSE8dxMFaMglD4nlLocXboPq8tvUne5taPfLg0qZCZeyLbaYyVKq7r+HNFR6kUDQqH/oQe3Brjo9kvU8g+XypDnxOa3mgBuZxL+an4yD9y7J
X-Gm-Message-State: AOJu0YxgFWGuG4HHgiUJocxwQ7YCgIbdoZVI48EkGE3F34QZ+trnucGB
	btA1GPhjkWl7TLM54WXBa0tm8e4QUbSxDD0ezmRA8QqtIHPXaCYQ
X-Google-Smtp-Source: AGHT+IEFssPBy/dfrma+UX+DTVHqmYI5LRvhGTgwyO96rTwXS4qFoS47jS6PHtERr/iaieQ+YoKbxA==
X-Received: by 2002:a05:6a20:f389:b0:1c3:b2b3:442d with SMTP id adf61e73a8af0-1c6fcf7b099mr1325792637.40.1723119927838;
        Thu, 08 Aug 2024 05:25:27 -0700 (PDT)
Received: from dev0.. ([49.43.168.245])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7bb819e782csm5530478a12.48.2024.08.08.05.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 05:25:27 -0700 (PDT)
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
Subject: [PATCH v5 2/2] selftests: net: Add on/off checks for non-fixed features of interface
Date: Thu,  8 Aug 2024 12:24:52 +0000
Message-Id: <20240808122452.25683-3-jain.abhinav177@gmail.com>
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


