Return-Path: <linux-kselftest+bounces-11924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BF6908ADB
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 13:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27302883C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 11:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F153F195969;
	Fri, 14 Jun 2024 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lb9gJZwF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703ED78C90;
	Fri, 14 Jun 2024 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718364771; cv=none; b=tMXdKd/xphvahM+KAo3T4zKEdm3knh98DWtGpoZStCgBAJOiLRg+O8ludx2SepqmMg3zdoLB/wfYZ13nMpdIR38ES8rrB3/H1WHEskydDDQlr6J9yCH5dWY66uiPECr0xzVCTSjqgTvsrctQhwpaogzj7EQc7IgZGEQrM9ZVtOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718364771; c=relaxed/simple;
	bh=BZxQFdVeG2QT4ILRMGsZqQyCOlQ7KBcsO2feZ2kEUnE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BYMjed0XbC8g4Ps3uOkxNb2mLjF9ONinZNsDCZF8DTE6puCds4BJQ+b/27qui/ljbJQ3DP9BwOwVi/8cuG39BlUV7Fq0d8HWrJxr5Trzcnp2hRSCeBUry7t29L+8DULPUpXBpkKAoW7tvCU1EOk2Rxfd35MEsZKk5gREq827Ckk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lb9gJZwF; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2547e1c7bbeso993612fac.2;
        Fri, 14 Jun 2024 04:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718364769; x=1718969569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eEf7gvt8spx/WQGM8gzqsUzpDdVScLyfQu5pad8/08k=;
        b=lb9gJZwFVst+oCJbvuSIl8UjtLDgsCDR3mTnL3HrL81nB98jNpATEVy1bfNV2L2aW5
         39R/gAAugqZ//48eX9P48N1m2yO8OvCnrB1TQzGzum9nOEgCOFL9sKQy67DrYGFz+GGx
         RD/4P7dYqur/GnbFL930MQoOk03sLJBL4jmjCrmBhXAO1yQ8S9PsS5P/kd6UESjqtmEX
         EwvYmgRiOVQtCZq6zj1RnsF9DYCH5n5BCeTQ8plcX41qm5L+yZ7a5iUaGOFm84k9qp5F
         aQPHKjQ5BEYTHfjJKEnVcL0drXx7UIfO+FlAFglh/KQAZMTI5M2js+COmr/BUPwexVTm
         oG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718364769; x=1718969569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eEf7gvt8spx/WQGM8gzqsUzpDdVScLyfQu5pad8/08k=;
        b=e8Wxi5vRn5CRaVlkfoJmsZ+UVSxoS9r3kVTiLaO274SqSwgIhhObU+zF5AsoiadeMF
         ysYykb7Sm/9Rp0BfpcN9/eXGnDK93g0tT0ExayUjFs8ovMCvJYMVu1qKBOthzoTzMQd2
         qsxgN+y9W4aI75u3RzJG/z2GRAfOMXEyc9gLhTYS+XHSX63mhEU6ohfMcKaJGjxkoDn/
         YsOV3HYAh2sw/FsXnwYLRjvUo13EA0+5u8/1Hm4TxboMi5pmu7Omal0m7gorjLMxAP4c
         OA9J0DOReOs8SdYYPnh0T8NsrTtOXbcG8FhS8bILzYi5504z4mH1cEc+m1ndZ7SvLik+
         4LNg==
X-Forwarded-Encrypted: i=1; AJvYcCVBDgDThT0cY+KHXpsMHH6b5T88Cu1WzWjucoa1KiQ5MyLfgTOB3x3YB8EHZ/TWpTxUgOtyhg9Q2h6fELbg/reYOvz7JCjLDwQiszD59GJU5kgFDsY/Uoa8MeIE2ZxCpmmHtctqGWREIlvkoO4By1VyblkZJDQDrgLWN18BRfgWCXWs/MQ6
X-Gm-Message-State: AOJu0YzC0oLxmY6KaARUkvSdKfZIGTjBbZktem40Fx3D6zbAA0dn5oKr
	geRp4zG36szlDZJNK4uRmocmlr4eidvaV5hBGg6WMkcBZMFdFJSc
X-Google-Smtp-Source: AGHT+IGWbIK7SenoDtzFtCrqP2fbskbuS12NCnmeZb5JH1qUBznPIz22Vy037PSvdnlOhNciw6zXwg==
X-Received: by 2002:a05:6870:1488:b0:254:8e90:2d19 with SMTP id 586e51a60fabf-2584288bdb7mr2467251fac.4.1718364769311;
        Fri, 14 Jun 2024 04:32:49 -0700 (PDT)
Received: from dev0.. ([49.43.162.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc91dc0asm2841474b3a.34.2024.06.14.04.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 04:32:48 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: kuba@kernel.org,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	jain.abhinav177@gmail.com
Subject: [PATCH v3] sefltests: net: Add on/off checks for network interface non fixed features
Date: Fri, 14 Jun 2024 11:32:40 +0000
Message-Id: <20240614113240.41550-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses the TODO (add non fixed feature on/off check).
I have tested it manually on my system after making changes as suggested
in v1 and v2 linked below for reference.
Patch now restores the features being tested to their initial state.

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
PATCH v2:
https://lore.kernel.org/all/20240609132124.51683-1-jain.abhinav177@gmail.com/

Changes since v2:
 - Added a check for netdev if it exists.
 - If netdev doesn't exist, create a veth pair for testing.
 - Restore the feature being tested to its intial state.

PATCH v1:
https://lore.kernel.org/all/20240606212714.27472-1-jain.abhinav177@gmail.com/

Changes since v1:
 - Removed the addition of tail command as it was not required after
   below change.
 - Used read to parse the temp features file rather than using for loop
   and took out awk/grep/sed from v1.
---
 tools/testing/selftests/net/netdevice.sh | 55 +++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netdevice.sh b/tools/testing/selftests/net/netdevice.sh
index e3afcb424710..d937d39dda6a 100755
--- a/tools/testing/selftests/net/netdevice.sh
+++ b/tools/testing/selftests/net/netdevice.sh
@@ -104,6 +104,20 @@ kci_netdev_ethtool()
 {
 	netdev=$1
 
+	#check if netdev is provided as an argument
+	if [ -z "$netdev" ]; then
+		echo "No network device provided, creating a veth pair"
+		ip link add veth0 type veth peer name veth1
+		netdev="veth0"
+		veth_created=1
+	else
+		#check if the provided netdev exists
+		if ! ip link show "$netdev" > /dev/null 2>&1; then
+			echo "Network device $netdev does not exist."
+			return 1
+		fi
+	fi
+
 	#check presence of ethtool
 	ethtool --version 2>/dev/null >/dev/null
 	if [ $? -ne 0 ];then
@@ -124,11 +138,50 @@ kci_netdev_ethtool()
 		return 1
 	fi
 	echo "PASS: $netdev: ethtool list features"
-	#TODO for each non fixed features, try to turn them on/off
+
+	while read -r FEATURE VALUE FIXED; do
+		[ "$FEATURE" != "Features" ] || continue # Skip "Features" line
+		[ "$FIXED" != "[fixed]" ] || continue # Skip fixed features
+		feature = "${FEATURE%:*}"
+
+		initial_state=$(ethtool -k "$netdev" | grep "$feature:" | awk '{print $2}')
+		ethtool --offload "$netdev" "$feature" off
+		if [ $? -eq 0 ]; then
+			echo "PASS: $netdev: Turned off feature: $feature"
+		else
+			echo "FAIL: $netdev: Failed to turn off feature: $feature"
+		fi
+
+		ethtool --offload "$netdev" "$feature" on
+		if [ $? -eq 0 ]; then
+			echo "PASS: $netdev: Turned on feature: $feature"
+		else
+			echo "FAIL: $netdev: Failed to turn on feature: $feature"
+		fi
+
+		#restore the feature to its initial state
+		ethtool --offload "$netdev" "$feature" "$initial_state"
+		if [$? -eq 0]; then
+			echo "PASS: $netdev: Restore feature $feature to" \
+				" initial state $initial_state"
+		else
+			echo "FAIL: $netdev: Failed to restore feature " \
+				"$feature to initial state $initial_state"
+		fi
+
+	done < "$TMP_ETHTOOL_FEATURES"
+
 	rm "$TMP_ETHTOOL_FEATURES"
 
 	kci_netdev_ethtool_test 74 'dump' "ethtool -d $netdev"
 	kci_netdev_ethtool_test 94 'stats' "ethtool -S $netdev"
+
+	#clean up veth interface pair if it was created
+	if ["$veth_created" ]; then
+		ip link delete veth0
+		echo "Removed veth pair"
+	fi
+
 	return 0
 }
 
-- 
2.34.1


