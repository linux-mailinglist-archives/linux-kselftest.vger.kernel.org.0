Return-Path: <linux-kselftest+bounces-15348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D42F95228C
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 21:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD77281811
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 19:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29AD1C0DCE;
	Wed, 14 Aug 2024 19:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgZQbsUY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2F81BE876;
	Wed, 14 Aug 2024 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723662945; cv=none; b=at82fwVpE5hM1qgQ5du75XttRLazBAKcCEVcUXFO8levtafIMUTWhAnXqSHmrgSEOcUwCsABA6W2dFiPXdrh9NtHzcyLdfnd0NHV134MTsV6kTL1Qi7zruqWa10eTb+V1XU/FitWsNUmFCuWbfuneFDA1PWwOuQSuh20W0ub4G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723662945; c=relaxed/simple;
	bh=ycMDhvAMt9XitySHnfVoDSahqTeK/1BRpCchicWdgU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QogBlR/Rbif+sTVLFKzWDvc267TQNVHItSsiyphxgRr3esoB2+0SIkntCy9Y1kAMc6fA/VzBgeqRyOyrgodeQVmkE98mb0GetqoAPJ9qvSw8kSgEx2+wKvklWos0sktLfPoSOu6rSQYDnrWeDOoeOya8CnSZFYqv3/I5/tTkTZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgZQbsUY; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7c68b71ada4so213471a12.1;
        Wed, 14 Aug 2024 12:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723662944; x=1724267744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9ELp+TsJeawl+KmNfSk+NqeKqbfk83tQ/09zTpvk3Q=;
        b=lgZQbsUYCwxiMJGMIEpfbH94D4nzqNylAdbr5MqdgZlFRULsB7eODjvmvZB5wt+lXy
         6ke+3E8eEo8A0JNkuVPUrJ8HAsTsAplQAPzhj788nZX7XCnRGRFmoQK3TGDPS5QUL/KN
         u/JnjEGLzqb4Fdr1kvavdNvqaeLgeavEgGulfTyP2JkdB/OoFUV3/BNvz7H/z2OH77i5
         n58uTQU/h5HjypYdWpJLyd1iogG3rk1BHygkoRbm4+CgUSMsQSeQK5gLpAnKzt2qNpwF
         TMbj1irfh15nr+P2z9Y8mzntWVcmzFtSQyACxwzdsVHiTEmeJzZYD8RtDAPmjiAjT/pt
         CPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723662944; x=1724267744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9ELp+TsJeawl+KmNfSk+NqeKqbfk83tQ/09zTpvk3Q=;
        b=KujgJiGb5GnZg2aE6eBU3jqH3oH5Xn7m4a9pUbc95fkbsbMIb0VwHLs8FssHXXrfNA
         HdCqW8bG+YH57GDZlFnplyYCOkrq8Y9W4LKAfVmo8p6eN1UflkTJlKqkJONZy/T1fE0c
         QuEcaggMwdbLtKWe79PvRfx71lMXBT7ePKzROrVZq/1oM3JydoMEw7veBBIpnKwkTZ7O
         kqi4qXuyXY49PCJHs9psCT/nsEjnHGIjsSJCklkh9+HwQwtbV/KyMdFoSAsjv0DpsBbe
         YLfAvtHjyhaS7v6zEuwnVcisPvZUQoo7+6U8ufTJJ7tj5mUFZRC+Qji3QZQpz1M0qFMe
         Us3A==
X-Forwarded-Encrypted: i=1; AJvYcCXkaYY+l/e5nnHOhHKX7zxxZ1nOb9EKAG0u1dXwbui8x+eaX9eW+eF7YfscGz7LL0MuYY6w/L2n5+i9KblhCtNGr63RIEskq2Me7cyT6SL6quHMuX09XYnH2V9kPLnQo9bIG9oFguqfLiA+5PnWrDpK+jYSPVhKMKVZFwEEqhs6ZWoRlW64
X-Gm-Message-State: AOJu0YwS3MHTDCfUMVFb+CgH5yOPDyHPU1gv+JgNXkaBAj9QXUap3FJF
	BxAkf8dej1+04f1K6piWWPVXz4DUJZeOAkdz76IyXcQakA6IvoNn
X-Google-Smtp-Source: AGHT+IFPdMohyGwxBctM0X3ck3Ceg11wSYqqveuGO6+sfNMblSznmotD7ev6N3M0BYCqT7tNB2oZOA==
X-Received: by 2002:a17:90b:248:b0:2d3:ba92:b27c with SMTP id 98e67ed59e1d1-2d3ba92c7e1mr1809616a91.42.1723662943609;
        Wed, 14 Aug 2024 12:15:43 -0700 (PDT)
Received: from dev0.. ([49.43.168.58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac844e54sm2134282a91.44.2024.08.14.12.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 12:15:43 -0700 (PDT)
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
Subject: [PATCH net v6 2/2] selftests: net: Add on/off checks for non-fixed features of interface
Date: Wed, 14 Aug 2024 19:15:17 +0000
Message-Id: <20240814191517.50466-3-jain.abhinav177@gmail.com>
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

Implement on/off testing for all non-fixed features via while loop.
Save the initial state so that it can be restored after on/off checks.
Use XFAIL for unsupported ethtool API.

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 tools/testing/selftests/net/netdevice.sh | 39 ++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/netdevice.sh b/tools/testing/selftests/net/netdevice.sh
index 0c32950fdd17..1c9c7c358ee6 100755
--- a/tools/testing/selftests/net/netdevice.sh
+++ b/tools/testing/selftests/net/netdevice.sh
@@ -86,7 +86,7 @@ kci_netdev_ethtool_test()
 	ret=$?
 	if [ $ret -ne 0 ];then
 		if [ $ret -eq "$1" ];then
-			echo "SKIP: $netdev: ethtool $2 not supported"
+			echo "XFAIL: $netdev: ethtool $2 not supported"
 			return $ksft_skip
 		else
 			echo "FAIL: $netdev: ethtool $2"
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


