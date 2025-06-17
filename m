Return-Path: <linux-kselftest+bounces-35199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CDCADC8A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 12:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6323E3BB455
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 10:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72B82BEC53;
	Tue, 17 Jun 2025 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaOafEP3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2732C221568;
	Tue, 17 Jun 2025 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750157480; cv=none; b=bOiEGz/F2jhYHqJNnpH8/y1POR4xWUE5mUP4IRb91jLvmYsNcOre2K0sEN2Gl81XnYZl25wUEo6E+rKu9uwOXOgG+pASaNKc2tA/6mSbJnbLi5ZN7c+DOwXiHwU0qrToGCtJIwtiMAF45tpenA/yUGtlGxTDXALLojn1sBDQCAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750157480; c=relaxed/simple;
	bh=kmYjANBc4cilzNOz65lEztNpcUw3yfVhLJuqdv22NSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qub4ZAnwq4taA1SZ/EIp5WxWc3BzI09Nmlu4owvqqZ/BZCIwQatYhSpTGi3WdYtytVRG0nSPY+dXKbOSwWazP5wxz5aojQQKYH4uZHan6H2RWFQp30rtQOXDandyRsY7/eD4+qCU96aldyMomM+2QS+sBcaIK2XbsMnU3HHifuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaOafEP3; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b2fd091f826so4003651a12.1;
        Tue, 17 Jun 2025 03:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750157476; x=1750762276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYirVNrH0sBRP/I/DuDVQZwpZNmktE5hYvkDuLzNhwo=;
        b=ZaOafEP3LNeIl8pw7m2T/cHDG5Xy66BuY0Me4Zgwzpuxkmz/1alERHuRFMaS1KSPkd
         xnbDvxqhJI8/16k1QeqvxPrcv3CkXzK6akvsFI8SqctLwE6CRu4ULWGdsigvaEz/ApJf
         UKMj3sg0XxuQL/VXkVMI5OjdxHsOCmjYBNSxarlXfbZtRjwTeoknrAGLoCBgElwYXP7P
         LfNhBOOyDvPGCWN3HfP3k/1uo4fQEaoqgGtBlnOc1qrgjt1S6qvGi1bCgBIt+LNs8g97
         CZv81suVGgOYPha0xMs263XaXAiphcof4iTxCH7/vTl+5yrA58nGvwl3f2uIrvIF2Ql8
         sHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750157476; x=1750762276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYirVNrH0sBRP/I/DuDVQZwpZNmktE5hYvkDuLzNhwo=;
        b=Cz4Vfq+MiQpllIjP96H+2WvSsG44Swpj5eKypVQoPiyiaJeNl+5ZzOCFgi819fEXgB
         sK82nr0ahPECtUM4GKBQrUieg5l4+VZ3oVkgf4P2cJmv8x3RFKF23E0gAojEizeuHSeg
         nlZK1TSbariXsZPgub2pj49dBI7ZzYOc3oOX8YEYg55AE8YmFzkXPO2U+5H6BiZMoo0+
         dDzrKabWuxqp2OOsAUd3Ei3/+MLg42e6jHnMD8U6Ax/K4dDh/FYCyOvh2/+TOvZTZyg+
         wqWFeqbvqOEb9eAkY17Zv7tsveuF4CsP1DxhHPUCqrOIq3EF1WaNrOBJeFMly4WIV0cD
         1opg==
X-Forwarded-Encrypted: i=1; AJvYcCWOr+jzP48Pm/5zSFzBD+zJPHwC4BWktnVXEMujbaufAUBx733TJwxniILmexW8PUx9IChEiTA6HVJWBSk2q8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDi5aj3Ll/fB2BUVHzmpWsShBuThGLLveLKFVjcDQma4WMCRNK
	0mh4Ah3vntwayxkXqwuNhei7naeEXYDjw0xw9oOmNbXew+hdZ9CtmkNxy1UFGs23YCjrkA==
X-Gm-Gg: ASbGnctcjy7I7sF3SoVW+aaa8nT5PSkZXrs7YvL9EspWv1cGQrDSDhhHo9w+AtrVKFo
	iPGMm+ZH9jagUG3/rjIQIrDow/xAFi2hWOM81tJJ+sD+p8Tpqzq4PLOUdhCyb+PKbgnX4UeqjB+
	AqoRcCORHFOf6qPMe4dHLjYUu0otDuPNF181YGD6xTluD935zVyaNVxRfK8FRmP8BZp3/v75rn4
	r2/EX900kVADLf/tatPUe6X03vFAymv67burfLy7LRjI9/NoIrbj4Vr2KVmBywa9/zKsVkCF0Rz
	UvJBV1K9mrfkIyboX7w8idQYeDwu+sl9RaDHMwDRMC2HVf3++HfH1SjvZq9vrxZcDmvhHKMP8K2
	ilpt3TA==
X-Google-Smtp-Source: AGHT+IG67XV8NAcrc8a3X5TrNY6qOpafQ7r4n3n1P38piqvubgHDmdu+tSgHjAfW2cCwXvv3qdMtpw==
X-Received: by 2002:a05:6a21:1512:b0:215:d41d:9183 with SMTP id adf61e73a8af0-21fbc62c0e0mr22406556637.1.1750157476221;
        Tue, 17 Jun 2025 03:51:16 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d2e25sm8795739b3a.171.2025.06.17.03.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 03:51:15 -0700 (PDT)
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
Subject: [PATCH net-next 1/2] selftests: net: use slowwait to stabilize vrf_route_leaking test
Date: Tue, 17 Jun 2025 10:50:59 +0000
Message-ID: <20250617105101.433718-2-liuhangbin@gmail.com>
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

The vrf_route_leaking test occasionally fails due to connectivity issues
in our testing environment. A sample failure message shows that the ping
check fails intermittently

  PING 2001:db8:16:2::2 (2001:db8:16:2::2) 56 data bytes

  --- 2001:db8:16:2::2 ping statistics ---
  1 packets transmitted, 0 received, 100% packet loss, time 0ms

  TEST: Basic IPv6 connectivity                                       [FAIL]

This is likely due to insufficient wait time on slower machines. To address
this, switch to using slowwait, which provides a longer and more reliable
wait for setup completion.

Before this change, the test failed 3 out of 10 times. After applying this
fix, the test was run 30 times without any failure.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/vrf_route_leaking.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/vrf_route_leaking.sh b/tools/testing/selftests/net/vrf_route_leaking.sh
index e9c2f71da207..ce34cb2e6e0b 100755
--- a/tools/testing/selftests/net/vrf_route_leaking.sh
+++ b/tools/testing/selftests/net/vrf_route_leaking.sh
@@ -275,7 +275,7 @@ setup_sym()
 
 
 	# Wait for ip config to settle
-	sleep 2
+	slowwait 5 ip netns exec $h1 "${ping6}" -c1 -w1 ${H2_N2_IP6} >/dev/null 2>&1
 }
 
 setup_asym()
@@ -370,7 +370,7 @@ setup_asym()
 	ip -netns $r2 -6 addr add dev eth1 ${R2_N2_IP6}/64 nodad
 
 	# Wait for ip config to settle
-	sleep 2
+	slowwait 5 ip netns exec $h1 "${ping6}" -c1 -w1 ${H2_N2_IP6} >/dev/null 2>&1
 }
 
 check_connectivity()
-- 
2.46.0


