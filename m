Return-Path: <linux-kselftest+bounces-22638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A029DF01E
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Nov 2024 12:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16FC163851
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Nov 2024 11:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1F6188717;
	Sat, 30 Nov 2024 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6d/Ghp7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A42141987;
	Sat, 30 Nov 2024 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732966427; cv=none; b=F/UuYxzj6c/HT1j037OFJCVhgVndbLy0ujLNcoktTZqUKwCUGEhJ9gZAMcCH43MtTuj+2V6lrB0LtVBALWY5O4z2GQMeOriLCk3AzVdoWI74qOxbmy5029RZuVAm+KYlltY16spMKqrCemb856NhF6I//kATxxCTXvVyH1O61wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732966427; c=relaxed/simple;
	bh=N7UEnsfZfi3Yu71lo0rhgQTRf0xBgW1a2d9UEsE38T4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EqQdxTXYkw5swRaWKYNypV7IESUcSxU1/hpGMdJFISdP84pTWYP+G0+v6lT8XTH8+Tm+CN2ycA13LMK+avY33aGkeBAjR3bYW0AMuDKC5ge4rjCKaJBSGCHTVNd0B6c9JhkELLApCcR7je3FgXidAtiwSLCfZUVV5Whz/TsKc14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6d/Ghp7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a1639637so24900835e9.1;
        Sat, 30 Nov 2024 03:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732966424; x=1733571224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EL6KVlYMiRPfIoR2qBsCEcQAjqvcPLAovHyHcOnwcNA=;
        b=B6d/Ghp75tNuB3E3Nmm5c/PNfURR5O566ey27C70G8CXCjpVAxN9LZT/ILePhk5ic/
         oIoxvJMC+vB2p0ZeYC3CMe+xCU60QnBit/3zWEJ1elJzKopE5fWRZpeQNHbttsjtI9MR
         DeJdT3c2CI99dzlTRPchSA9etKCZtQlNP+tFgOtoyrgLlJSs27vh+0TbekjuNredH1+J
         kTF6FC1sEMRD3zzUlQYrJbfGx2t38hXTBNIo8owK3g4SJOlj4ekDWzALGLadkTPB+x9D
         9a1ORugbaxm0V363QIN9DhmDfIPTU3poWbs9PyUUpLclDiyXFRV0KiBCQOAu7fKCRp/e
         uFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732966424; x=1733571224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EL6KVlYMiRPfIoR2qBsCEcQAjqvcPLAovHyHcOnwcNA=;
        b=ayIRKcaZNUgszYIN++Q3NnhBm7tmITczbpNMQe4kwY/RIEHoh9Lvbn8PBlX35rvEyJ
         PE+SzgiDWfi0bEW6zTBlMNvkWpXVKfJ4rUzYsDp8HdJDZZWjW/ravPdKDn0hA+x3YZ1i
         5eYQfiUUxmDNKOEuIuskkCj6HKhXeL5kWh6RI+zEIA61Y4KIILnp4icQJdzPcRHV7HP/
         y0kr5k8uIpdYyaEIdZW1ueRHCDvsp/1PBN7odR4N5CRHDA38QpZGt3RzbtViFxBSCpls
         g/RhrQo6fHnio9etvCz59CEtpwsSNYEwX7aeWHLjeGe9FzzIZg9It6S65NEXVWxmIlDE
         SUkw==
X-Forwarded-Encrypted: i=1; AJvYcCVzZ3x5xoUOHujKhRj4LTdvmKt85iX5O5HJu6xnyDuZYkDv0XvmQimDEcBnkZvBFYrqJ8WPn2jN@vger.kernel.org, AJvYcCWEZYkgLAybjitfs3KWSFHQDUft+s+jWw5fIBe4UA5TI7QCXKNVY1btj8v4n5YiJcJVYvpufH5vjD+pa6zsHQ5c@vger.kernel.org, AJvYcCXxN0YeIJXhK7lbfZi61qWpuzGJM2FJPZ+5ZH6uaog9YnqsiH/lK9IDGaSLba1I+9drHCcxddAFZfILd/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDR6DnxdWBAB1n+ICINrHUhIQaTxJzl12OUtodZs/+3xEDjWZB
	MA0Md+JtT/5gyVO3TD/Hf3eymfTdGODYS+sp0bDZVkx2Aqa8JJcr
X-Gm-Gg: ASbGncuCTACsh2ywS2I9JtIOJZR1hSqjgZfamr37HieDe/5QDbM+mT74mfO2EjwUT+4
	FRyiRc0Mx2swHd9y9X+LOPy1LQwLOs8pzW5OykmVSr4uUjhh3IdvPRBBFvj71KfswcFpaOIFrFr
	xYqNW3f2Kx6y9ekVo0ykiQY8uUhvZtCuqFchctZm9DNURgSSJ8uyW3aeomsaLWWu4QPxeF4Srd1
	7W42yINEMvXgXq3amy+X+kHlV/EiDj5uUAdiICHsaWnzaXiCY8UL5ibKZoXCY6q1nUg98w6+C7F
	srWOi2CjdVGoGaHdylQ=
X-Google-Smtp-Source: AGHT+IGEquHdV3LyyYusIywiVJxdZDtQStlBx5Sfx3l8/f6Wc0aQaQOyrRPA3gbJCwQZizot/vfuTQ==
X-Received: by 2002:a05:6000:1448:b0:382:41ad:d8f0 with SMTP id ffacd0b85a97d-385c6ec0e2emr13276066f8f.34.1732966423881;
        Sat, 30 Nov 2024 03:33:43 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434aa77ffb0sm113506365e9.20.2024.11.30.03.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 03:33:43 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [net PATCH 1/2] selftests: net: lib: fix broken ping with coreutils ping util
Date: Sat, 30 Nov 2024 12:33:09 +0100
Message-ID: <20241130113314.6488-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the coreutils variant of ping is used instead of the busybox one, the
ping_do() command is broken. This comes by the fact that for coreutils
ping, the ping IP needs to be the very last elements.

To handle this, reorder the ping args and make $dip last element.

The use of coreutils ping might be useful for case where busybox is not
compiled with float interval support and ping command doesn't support
0.1 interval. (in such case a dedicated ping utility is installed
instead)

Cc: stable@vger.kernel.org
Fixes: 73bae6736b6b ("selftests: forwarding: Add initial testing framework")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index c992e385159c..2060f95d5c62 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1473,8 +1473,8 @@ ping_do()
 
 	vrf_name=$(master_name_get $if_name)
 	ip vrf exec $vrf_name \
-		$PING $args $dip -c $PING_COUNT -i 0.1 \
-		-w $PING_TIMEOUT &> /dev/null
+		$PING $args -c $PING_COUNT -i 0.1 \
+		-w $PING_TIMEOUT $dip &> /dev/null
 }
 
 ping_test()
@@ -1504,8 +1504,8 @@ ping6_do()
 
 	vrf_name=$(master_name_get $if_name)
 	ip vrf exec $vrf_name \
-		$PING6 $args $dip -c $PING_COUNT -i 0.1 \
-		-w $PING_TIMEOUT &> /dev/null
+		$PING6 $args -c $PING_COUNT -i 0.1 \
+		-w $PING_TIMEOUT $dip &> /dev/null
 }
 
 ping6_test()
-- 
2.45.2


