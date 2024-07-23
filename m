Return-Path: <linux-kselftest+bounces-14061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B573D939C89
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 10:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6AE1C21ED8
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 08:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5F414D70A;
	Tue, 23 Jul 2024 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Il6soTT/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F7C14BF97;
	Tue, 23 Jul 2024 08:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721722985; cv=none; b=T6oc4ZSNL1R/goa7Ax9ZHC0HTxHyndLspdvCyB01l4yGuSFFNO2qjgnpvgFMKJlgElLfH3rQIQEYi+n+qo60D+se7DpZuhrq9qLV8SG554xWN67aStg5Nav4aBg+hN/5ynRO+cD7ZqhJSFYiZ4PS6g8LM78CjXtPzhyKW5Nrelk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721722985; c=relaxed/simple;
	bh=74Na5iclC6Oq2I0qD+u6pUB4KBNF1s1KWnwxLKBJ0Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pkuLip0u6JmXncsnpJ4/6pPQR8fpfjaD0kUm9517H1UEBS0LHz9ajQmqzC3q8TZDq9+fpzwUHSH+e2isETRW+nLQv209/gCVQMxMVeQX5OlNnowwFkJF2S4nwvno8uHjLkiCm1MQvf5+3C8MBgNIZD9genvflGBgsJJNUsFMprE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Il6soTT/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc60c3ead4so3333825ad.0;
        Tue, 23 Jul 2024 01:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721722983; x=1722327783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RpkADmTnW1B9Fz1HKAvOOAPCUd6EFsu+7DyTF6fyieY=;
        b=Il6soTT/tz21NIw8y1eRg/WssD+FohZsYdi+YuZ/6+THELlZ+VmWKme2psuHhXyBpW
         iFUOu9EArB9KKphH3VcJnqGy/zcKfCIAh8GldjHdiRQHNJWkz+CeWxvW6kkK0XsUvu7v
         CPVakxs0tDMajtHC35eOjyojYr3cwFbr6J5E0bJXL0lL6qvDXvMb2LHFWGjDjLNKbDSL
         hEHuMP4iDpxfZWRLL2I5TdImQrZxeFnzD46gUy7u5akvcSaLxc04dOIk2scUOTGlYZDV
         cGdgSvhwVK79vsVWFIwWfL09s+0HqD5lCDX4EEYK4lwK1end9CZpBpIcgCy1LXAgcD/T
         dCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721722983; x=1722327783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RpkADmTnW1B9Fz1HKAvOOAPCUd6EFsu+7DyTF6fyieY=;
        b=O5C+OJ938hk03s9csa4MFFa7JmcILSrPE261uwd/obNWELzPx+rJNVVBtlLqDTkpB9
         E7pRfuEF1Vfw32BcAPpaaN/lyk0NZ6kAUfYHrGF5m5mLWLkFaMTCksd0vTYIYyyF9c3G
         8W9wruTJSv6uvdVKhEu8eetORq19KetS3vPcx+ypxwqCVnI39mcQrcYu3ucacq94CMx5
         GZitBsZ/c7vFMyFDca9dImMiUurPq/wuyljbANJcg7197EmGvK1vPsX61sr2sxnrSLvk
         63io9aBiqLFkdm4FZ89c9EYHdCWbt9eEBmQfEtpqvoIJZgPxgEGoCwZJPB7Q4CiXkpbB
         BQeA==
X-Forwarded-Encrypted: i=1; AJvYcCXW2VXq+DmQF9Cu2pNGBwdzJalur41vQykMnzPx9kc8sSPvUaqo2ItjrEWO0K4LgcUxbodhmladdikdN6YqnyLRuoE5hRRAt8dlL8X4EdeR
X-Gm-Message-State: AOJu0YzNQCRQ3SMZ2f0BkoxDILr3F/ScT0GY1MNt7gb/J4fhjmMvmnPL
	uBRmHpgxEujCKqoCA4LkZrZ6A/ERxC7oXBfXBFuVn1eKezt9eYWZzFOyO127dp8=
X-Google-Smtp-Source: AGHT+IHic/W/XIMxoFCZKgxrC7WT3N9yOf1EnvRAQcgbUEQvyykp2Ha8u0TBK8sUdDnTrw+ygfqpzw==
X-Received: by 2002:a17:902:d2c5:b0:1fa:449:1dd6 with SMTP id d9443c01a7336-1fd74600609mr67647955ad.48.1721722982664;
        Tue, 23 Jul 2024 01:23:02 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([2409:8a02:7827:1770:9c43:581a:1588:e579])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f4533e7sm68681215ad.220.2024.07.23.01.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 01:23:02 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Johannes Nixdorf <jnixdorf-oss@avm.de>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: forwarding: skip if kernel not support setting bridge fdb learning limit
Date: Tue, 23 Jul 2024 16:22:52 +0800
Message-ID: <20240723082252.2703100-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the testing kernel doesn't support setting fdb_max_learned or show
fdb_n_learned, just skip it. Or we will get errors like

./bridge_fdb_learning_limit.sh: line 218: [: null: integer expression expected
./bridge_fdb_learning_limit.sh: line 225: [: null: integer expression expected

Fixes: 6f84090333bb ("selftests: forwarding: bridge_fdb_learning_limit: Add a new selftest")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../forwarding/bridge_fdb_learning_limit.sh    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh b/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh
index 0760a34b7114..a21b7085da2e 100755
--- a/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh
@@ -178,6 +178,22 @@ fdb_del()
 	check_err $? "Failed to remove a FDB entry of type ${type}"
 }
 
+check_fdb_n_learned_support()
+{
+	if ! ip link help bridge 2>&1 | grep -q "fdb_max_learned"; then
+		echo "SKIP: iproute2 too old, missing bridge max learned support"
+		exit $ksft_skip
+	fi
+
+	ip link add dev br0 type bridge
+	local learned=$(fdb_get_n_learned)
+	ip link del dev br0
+	if [ "$learned" == "null" ]; then
+		echo "SKIP: kernel too old; bridge fdb_n_learned feature not supported."
+		exit $ksft_skip
+	fi
+}
+
 check_accounting_one_type()
 {
 	local type=$1 is_counted=$2 overrides_learned=$3
@@ -274,6 +290,8 @@ check_limit()
 	done
 }
 
+check_fdb_n_learned_support
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.45.0


