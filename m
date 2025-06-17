Return-Path: <linux-kselftest+bounces-35200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C529EADC8A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 12:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE823BB593
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 10:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB96B2D12E3;
	Tue, 17 Jun 2025 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PygFdF3a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D54E2D1309;
	Tue, 17 Jun 2025 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750157482; cv=none; b=ljF/QIgtrGcMtOlY4KW4Mmsmw5ltIh4a7cdzxl+JlAMv1LtqNcks4t7EchDfwCf+ivP8ryTH8KGmdOKcfvF+WWifaxYWiFnAg7MgQX/JyfZXJXL0cKY65E8LlE6Q1iEpq5IzEizsBpl16EYiSDgjFdN0EwUdX7/1x4J7YRpyuhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750157482; c=relaxed/simple;
	bh=6CVf9x11AxNTi1wxLqUBjwNapcH1sAvHc9VF7HZPCRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZLGCIfzJa/Q8ZPSV7drH+u4+tdPMNBsiioCLx6EVgO0c/khIBESw5OamFXvjdBFIOU+BA9Yh2H+yuq0miBnXF5qP/krXeGWqIFYfiwLSRUolgEGJ17A2O2p+8N+3ZHS+CJbENpNLFLsnESL3KGw8p5VfezmdPVH5oG8G4TozkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PygFdF3a; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-742caef5896so4583766b3a.3;
        Tue, 17 Jun 2025 03:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750157480; x=1750762280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KJMtlGzGnXHhBRTLJpOzBeSdwiiHlSO2YxrYT8eqQU=;
        b=PygFdF3azViN7/5sMb8Gr5ZRyFHn9Jllbw29lnO6TwTHbpeuNTXY87sKsUfiVxoWLh
         tUfY2x4hGJbH+20ayynbAR84Xtw7WbzAD5pcAY8iePL7PATtUjKg0MpOsRMmKzKi+DiV
         xY1Tbv0jlYvvKja8V7cvsT46jAFvJHTXjOPUPqZe+Y7T54PVFg+tJ+7n919MBottzAGU
         Wejavn9HgyWsJikE2CjjCLFT/hUqkQ6En76Oi1CPM6eOtDM4Z4rlr8YCRZmDFgCVbFhg
         EBherNGslcHDUQIs/NZ6G0KYYSoUIqd5p/fB+2wKAH4+3DjA52vo/iXamjxVfAcNWHUz
         frcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750157480; x=1750762280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KJMtlGzGnXHhBRTLJpOzBeSdwiiHlSO2YxrYT8eqQU=;
        b=bw3TK1/DXzMoyidvKH6wBBruUxUHYfRp3iLftKsM8lGng9SZ5mgX9tjhvj+fFUct7I
         akssFMilYBDcf33QNhM4vxCJSjjR2qXlpTQlFmvsh6UtsVL/ry4vhTCMcVKR1SS0Dp0M
         HazA+RGK3fpY+DkTXJWKE6U+xjuMxVGVh1jsGEo9UWJ3vUMDRS661oCsaTENRPj4BwGj
         /fRSi2xUZP9f4dAvNRmWAEF2vCZtt+bOaeFumPOsWBPrRksjoMYm9TTnkTxAShthSRgo
         AVN3Dfg6C1HwIqFnPYH+uEZjH53P5SKpvIDaUy4J091d6yjpLj/5gPABzRI3ejHJwIri
         8QQw==
X-Forwarded-Encrypted: i=1; AJvYcCVqy8mx6yUMKjUsLbLTCcmrKg1twPXs2Guy6j6Do8+ZaJvUGwNhuAWg81p+aJIp15o+zU5MLDWHVE3Q5BBLTOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy74msrp38ev28HTJiN7cKXcemovkdHw1+XdHkkzCrzOPB60I2i
	0R3QrpZLHuFIjbf/QlB4VoYLncR7TKmbir9/UFAOsUlA6rKklTczyLraWwi+GolJiHKIjg==
X-Gm-Gg: ASbGncu/HV6D2ejR9O4skcVQ6Avm2mrtT/VZdSW7ZkcVXoPDta4dpBToNzD31YHwHOB
	t+xkfdYy1VhkL5zOV0vagmBfGNSpy1cFZ2IOPn8uRstkMudUFMG++XHYGX47WoGQ7YP1LwVj9rP
	f0yDNwmzfLrK6ge3EmJ6nJUEfQyqHRWMOjhgdYMpLpvRk3qdicad15jgu2DQckRUPIN65nTsWAT
	E+qpb/eZP+OhGogwlBlN1qNGhzA+2okvuEwnpKJxrKup8uY4nV5T7vQI+ZKlVntPSIzsNKzrWK5
	btKB7ZyUyYopeorZNQlyJ1+579htjkt6C0EVAClD1CLVRcP6NtfQdotfso4FDuQmMnVtiguQGBx
	qYB3+XQ==
X-Google-Smtp-Source: AGHT+IEHxStz+hhIviDAF4B/P7g11jVSA/nisquZy+ZeKcktn7X8kb1p58fjqszonJa4Lj10CAz7ew==
X-Received: by 2002:a05:6a00:2185:b0:736:a8db:93bb with SMTP id d2e1a72fcca58-7489cdedbb5mr15358326b3a.5.1750157480448;
        Tue, 17 Jun 2025 03:51:20 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d2e25sm8795739b3a.171.2025.06.17.03.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 03:51:19 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 2/2] selftests: net: use slowwait to make sure IPv6 setup finished
Date: Tue, 17 Jun 2025 10:51:00 +0000
Message-ID: <20250617105101.433718-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250617105101.433718-1-liuhangbin@gmail.com>
References: <20250617105101.433718-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes the vxlan vnifiltering test failed on slow machines due to
network setup not finished. e.g.

  TEST: VM connectivity over vnifiltering vxlan (ipv4 default rdst)   [ OK ]
  TEST: VM connectivity over vnifiltering vxlan (ipv6 default rdst)   [FAIL]

Let's use slowwait to make sure the connection is finished.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/test_vxlan_vnifiltering.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/test_vxlan_vnifiltering.sh b/tools/testing/selftests/net/test_vxlan_vnifiltering.sh
index 6127a78ee988..8deacc565afa 100755
--- a/tools/testing/selftests/net/test_vxlan_vnifiltering.sh
+++ b/tools/testing/selftests/net/test_vxlan_vnifiltering.sh
@@ -146,18 +146,17 @@ run_cmd()
 }
 
 check_hv_connectivity() {
-	ip netns exec $hv_1 ping -c 1 -W 1 $1 &>/dev/null
-	sleep 1
-	ip netns exec $hv_1 ping -c 1 -W 1 $2 &>/dev/null
+	slowwait 5 ip netns exec $hv_1 ping -c 1 -W 1 $1 &>/dev/null
+	slowwait 5 ip netns exec $hv_1 ping -c 1 -W 1 $2 &>/dev/null
 
 	return $?
 }
 
 check_vm_connectivity() {
-	run_cmd "ip netns exec $vm_11 ping -c 1 -W 1 10.0.10.12"
+	slowwait 5 run_cmd "ip netns exec $vm_11 ping -c 1 -W 1 10.0.10.12"
 	log_test $? 0 "VM connectivity over $1 (ipv4 default rdst)"
 
-	run_cmd "ip netns exec $vm_21 ping -c 1 -W 1 10.0.10.22"
+	slowwait 5 run_cmd "ip netns exec $vm_21 ping -c 1 -W 1 10.0.10.22"
 	log_test $? 0 "VM connectivity over $1 (ipv6 default rdst)"
 }
 
-- 
2.46.0


