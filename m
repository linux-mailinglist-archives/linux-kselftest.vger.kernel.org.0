Return-Path: <linux-kselftest+bounces-15638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AC1956A94
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 14:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F315F1C21D5B
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 12:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839B116A399;
	Mon, 19 Aug 2024 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5zI7iHy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114B01684A0;
	Mon, 19 Aug 2024 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069591; cv=none; b=bZch09q0+6DA09cjQfS+t04lGV/hipJlP82s+XkBkcnQE7nAXhV3Cl0uWX6NsUu4bvgVmBz981M9Oi3o/LYET9YVz0Whwf/ZRO0htWIsLpt7MxIGXQ0sSXonVMGtFwE5f918nI8pjzTVYRXUYCYOqY/hk30VJUzY7Mc65PDQtaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069591; c=relaxed/simple;
	bh=5nsXh4/6+iBagB9FyASdhKhR1uaJ7EfUKKknawQXyxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UNgBUBHgBbn2jAc/l11a3FvQ6PeDB+CvbQchwBxnOvoZoNEB8H0D/NHUaqcjiQfRnW76+WG+g1qhtp1YFgKfG6WaELB5EX9DjeIVRs3FJx+TvquPaNetera9rl9iZG2wcRByqaywN9rUKo6P/5WB8Gov5fLN1YavL53FhYiZ6mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5zI7iHy; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d199fb3dfso3488426b3a.3;
        Mon, 19 Aug 2024 05:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724069589; x=1724674389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=507HrI1sGsFpmzhUJTe8Zd0vw+ttWGb/fMNitOrEEEc=;
        b=h5zI7iHyvNyOWkbFHv60DBbJDoOaGvk8o+uPFYlK99S2KRcWS+SXAPVm5pLtpTyObE
         Ayw6feTAA4JFKNTJOhSUAJumioWXH/p7QomsGeeW6gmfZ6/o4RTqRz5cUFI65+TE8XaJ
         EYKPeMt+So6WWjASd5ebZ3TukYFef/lJspgIwSO24UPSyybetQulxinQmghk7SnCv/rc
         BaJqzCqraJ7Ko/9xW+7diNjfKglplo0klfOmy5oBQ3xZLZ44MJMuEjDJTUCEd7K59Znl
         CllEXbuE5cciFlY03HHp4CrbTYMJ74Kjtkq6H9CAtlpLN+Km5yK2sy0x13pAR2MmnKMV
         inXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724069589; x=1724674389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=507HrI1sGsFpmzhUJTe8Zd0vw+ttWGb/fMNitOrEEEc=;
        b=kRT1iALD57QpDosPRvxneWE7C4XdYpMLblEl1p+XO0c/6Gvd5qAD2svNWo/fhWDN/V
         sW5Dvgxo/b3E1FQHoaZv7vcRxDeJp+gOgbvXQlSwnakE+zN8QvHCIgOrcmcMp1scl35t
         3A3ct2rBBO1ltD7DiJuL+LRbJsDXD5yu3yQ6S1iSMRbwmZH0UWyFJ992aMnOuow5QW6U
         i/55IuNPy0L3wYkBkpn5fOICfMvzo7h7p8rclCHVy+RWO5IkF8MvADC8+jIfoY+gpXD+
         mR/wYSiAPeQhyALrLyg6ifa7lAxgmxAFzeGRkkz3CbKCwGfsImk4rEqSgSt7aoGFEkxE
         8OWw==
X-Forwarded-Encrypted: i=1; AJvYcCUtbiVC5+0NIOFKJrUwx+rMLxeXC3EW88Fwn+XfU2/bpRg55Nl1gfiHOatRCYM+1G585infwbuf5mrvYgSllxbwxzGbp4wV8Mzaeh1OTKzHfLcGJj3VLUGcO0jgEM1yhUcueER9eC7Jjr5F+xBDLeB4V3MNR+1vpfjbPTkrQ9FLoSMqTcVW
X-Gm-Message-State: AOJu0YzJrt0nE4qfusuT3ixXGNJlAPLkMW3jDaGzybeHo78lpOc4Y5e8
	MZIgP9uUgotEtGSl8EEZtZvdBQ4UpWjoF6LrOYKzo2G3RYeUEuAx
X-Google-Smtp-Source: AGHT+IE93TdEKOfWWUViExyUN6KKRUtKILN0gxSULvSYzrFNuaqGuJ5ubfEHTk9Oln5QMyncrPkeIA==
X-Received: by 2002:a05:6a00:2d26:b0:710:7fd2:cb2 with SMTP id d2e1a72fcca58-713c4dffd3amr13230126b3a.6.1724069589220;
        Mon, 19 Aug 2024 05:13:09 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:30b3:1f59:cb71:c749:d10f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef4136sm6501798b3a.100.2024.08.19.05.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 05:13:08 -0700 (PDT)
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
Subject: [PATCH v8 net-next 2/3] selftests: net: Add on/off checks for non-fixed features of interface
Date: Mon, 19 Aug 2024 17:42:34 +0530
Message-Id: <20240819121235.39514-3-jain.abhinav177@gmail.com>
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

Implement on/off testing for all non-fixed features via while loop.

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 tools/testing/selftests/net/netdevice.sh | 35 +++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netdevice.sh b/tools/testing/selftests/net/netdevice.sh
index 0c32950fdd17..20febf9246ea 100755
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


