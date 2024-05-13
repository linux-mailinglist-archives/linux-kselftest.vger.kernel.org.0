Return-Path: <linux-kselftest+bounces-10129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F05A8C3B26
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 08:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2469E1F21332
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 06:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4B4146596;
	Mon, 13 May 2024 06:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX87UbdN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD6350280;
	Mon, 13 May 2024 06:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715580557; cv=none; b=So65WmKpadf2rSTfC4iBZzq5uzZ+w4S05YcmjQZCRDFiqa4qB0PxNeuQKsobqPSqiYwYlHL1RjhelAkM8Vb1JpO5e/E/rZJWyudSvm7QsEa+SpGUq5X8LXP5jKdiuM+HOLZloDZyy0Ru/k0ZgHf1Z+6fTau430FjmvhkOCZP2aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715580557; c=relaxed/simple;
	bh=G6TxMzZEjWTt8/9mG4lMC+ndwcD6oEw96BfOtdlHxu8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lWe407U8w/NIL/lF10on+LIv0UFvVze+VsP5lsXNMdP4VhRRgLw6zV2Ku+sm5WODZ5PvVSVAMwnEAMN89hwrIiQdawu+EXTxZ0AGNpZaWIyEqAUHoF13yTTKiQcxIFCaObHJIgyRHCPxnQeezWNyDr+Pgv+oP9qcjTxWD5IP56s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fX87UbdN; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f4f2b1c997so1061625b3a.0;
        Sun, 12 May 2024 23:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715580556; x=1716185356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uuXJwcX4KqD+qIcLKgPP2fT2dHU0gUYgHHAWU3cdYOI=;
        b=fX87UbdN3ciW3PKynJWV+E//RUg+JQEfAADxEfz2aDADSAPI0VZtUnSIf16gTwxkwz
         rZNPo1Wo05m5r37b7KvRKrwhFl5lgV7ZKt2RwoL5XFeznJ+v/cFXNhEdBiOzf/S+KfLn
         yFw6HYgx//qwcT3dJpAMtTDjiiDXYsz4z47fM6ND2bHtxO/4/3CgNR7HothuPRBpnw5C
         SMWDuCnGvIQDqhsZV6oX+jHELWLWJHa8XK/FyK0wD20N6utl2G6LEO9s+cn01ACNACQv
         qaaBtr25CTB8sHfMpdXWFsXygvyYIAUsJJ/KxDCdovt9ZYln/kqIWcC1Gy0c/vkuYb+w
         ikew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715580556; x=1716185356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuXJwcX4KqD+qIcLKgPP2fT2dHU0gUYgHHAWU3cdYOI=;
        b=wZ1XFeYmcI39lY0Vq9zUNmjw7O69hfJvkvUYRw267aY2+PIDjVw44FSrJbp/If9gOQ
         Dif81QlFZ7u0yAbgIoAqHNVzWzmw23xkCzE0EG824dFBWo+IxtvptAS4Al4QrZpZpgo3
         LOuWl6XSAE7YWOYCE2DU5/pNjxcX/o3Mx/eG5H1XYJ1XCwfSueDKKKiQCliVJxuN9/37
         Hg2YKJv5C7PEUy5/dujEt3Pj1S+FwR/W36g+9oWdQPdvAf/bwZGwVCJ2PPXvdttVLWIO
         5QL6CRF8nLx19j0WbgUJYeQ0yISunR+Hn929jLKKS86JDSc534DCtzWE/QdFaOCh0emb
         jlkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4qa21vfaYyyrXgXH9EeCMhvzsXG/vJSMPNiDcwaUISqJfbcTORMXoigphLxQ20uvxFjBg+LA4BTAfR3P64WrgbmuTyLXrOXFy17olAGCKedf5te7lnMSSfmZKcfYzRPRRTwMd4lzc
X-Gm-Message-State: AOJu0YwWh2OFecaKgoM2iPLgVfvYY//D8O6raGMNTW5kqfGLcYhawbVC
	Bx+gg+klvkRjL+4vt8KyYaAW8h8Bx9v3wLwF6gtadJfLyr22hJkd
X-Google-Smtp-Source: AGHT+IH4tlHldlTTLMUwonFbo/ItKnDcx9sHDjVu6pyff6njeeE6pEkSKAonyPIHM804TSSj1NjxrQ==
X-Received: by 2002:a05:6a20:748e:b0:1af:b1e0:85e6 with SMTP id adf61e73a8af0-1afde1df6b6mr9364398637.56.1715580555564;
        Sun, 12 May 2024 23:09:15 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b6711660fdsm7121718a91.16.2024.05.12.23.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 23:09:14 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: ap420073@gmail.com,
	horms@kernel.org
Subject: [PATCH net v2] selftests: net: kill smcrouted in the cleanup logic in amt.sh
Date: Mon, 13 May 2024 06:08:52 +0000
Message-Id: <20240513060852.1105380-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The amt.sh requires smcrouted for multicasting routing.
So, it starts smcrouted before forwarding tests.
It must be stopped after all tests, but it isn't.

To fix this issue, it kills smcrouted in the cleanup logic.

Fixes: c08e8baea78e ("selftests: add amt interface selftest script")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
The v1 patch is here:
https://lore.kernel.org/netdev/20240508040643.229383-1-ap420073@gmail.com/

v2
 - Headline change.
 - Kill smcrouted process only if amt.pid exists.
 - Do not remove the return value.
 - Remove timeout logic because it was already fixed by following commit
   4c639b6a7b9d ("selftests: net: move amt to socat for better compatibility")
 - Fix shebang.

 tools/testing/selftests/net/amt.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftests/net/amt.sh
index 5175a42cbe8a..d458b45c775b 100755
--- a/tools/testing/selftests/net/amt.sh
+++ b/tools/testing/selftests/net/amt.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
 # Author: Taehee Yoo <ap420073@gmail.com>
@@ -77,6 +77,7 @@ readonly LISTENER=$(mktemp -u listener-XXXXXXXX)
 readonly GATEWAY=$(mktemp -u gateway-XXXXXXXX)
 readonly RELAY=$(mktemp -u relay-XXXXXXXX)
 readonly SOURCE=$(mktemp -u source-XXXXXXXX)
+readonly SMCROUTEDIR="$(mktemp -d)"
 ERR=4
 err=0
 
@@ -85,6 +86,11 @@ exit_cleanup()
 	for ns in "$@"; do
 		ip netns delete "${ns}" 2>/dev/null || true
 	done
+	if [ -f "$SMCROUTEDIR/amt.pid" ]; then
+		smcpid=$(< $SMCROUTEDIR/amt.pid)
+		kill $smcpid
+	fi
+	rm -rf $SMCROUTEDIR
 
 	exit $ERR
 }
@@ -167,7 +173,7 @@ setup_iptables()
 
 setup_mcast_routing()
 {
-	ip netns exec "${RELAY}" smcrouted
+	ip netns exec "${RELAY}" smcrouted -P $SMCROUTEDIR/amt.pid
 	ip netns exec "${RELAY}" smcroutectl a relay_src \
 		172.17.0.2 239.0.0.1 amtr
 	ip netns exec "${RELAY}" smcroutectl a relay_src \
-- 
2.34.1


