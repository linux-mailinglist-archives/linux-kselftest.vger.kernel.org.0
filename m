Return-Path: <linux-kselftest+bounces-17107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0BE96B150
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 08:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651661F24BA6
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 06:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE21012C46F;
	Wed,  4 Sep 2024 06:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yuh3ECRk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F3F839E3;
	Wed,  4 Sep 2024 06:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725430380; cv=none; b=bcYYLiDREjF+RH+lHB7eXiSoep6/y/TPsrM+Pk00dEQfRVzjUhlzyQvc5Bamyef9sE7Bij0BxqKDkIaOhQP+l+z1iZ+Xb+wbWpyqPEk6teJ7iqlm8nRS03YbpJWIUjChnUB8TWe3DPa7Zaxc1xFvBBcI04r5xbjHUG919i6lYGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725430380; c=relaxed/simple;
	bh=jDJ+5lOcDBfCwuW8cMcZIyq7m07Wc97Syr+O3fna8dU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uHabjAeeEBV3GDLA4P9thBLw6Ik46Zq1Z3XFasMf72UAOMn2Nuobxi9KHMi+OjtDmesNdFE6QaaR2WZQfXkoAp7KgO7ktnIHZgM2UQBYANcqoU1iKiK6JpMVDMv0mvKPe2EwkveY/OqBMDkX0/xS+pqkPuIulQGLNXI3qQY6xWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yuh3ECRk; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5e174925b7bso1467185eaf.0;
        Tue, 03 Sep 2024 23:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725430378; x=1726035178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VDIP2Ws7uBqyQ2sSVJAPk82Jzg9nMpj1VtHM7eiwTCI=;
        b=Yuh3ECRkT9EUGCQQOh7OHWFo0/UPxm7Ub9W7kTmtrNEK4vIcqZ8BLA0P8AE+vonYye
         WElh7gii/w7emmivSLGBVNBMR1b4qsGxoUMTY59KRWabdaHIplAZQTpdZjYuHf9fFDKQ
         EDMtw51vAcAPeveKaCOQJZ0G3NRKV3iguqsveWAP6Ipjnbu+g2UvaFIOOTAeuy9rrtsS
         cVZwlEGuvkyQ+Q7DDZ6VRA7/zAl/gZcgzonrIMurfCYiGV9z0+ijL4At+AOte7qR70oF
         EGbjP3Q5z5FL5EL5HPjI6S+ZoaRKlBoS57IYubkiN5C/qFv77dAuEajErDfdYaTkFKyu
         S/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725430378; x=1726035178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDIP2Ws7uBqyQ2sSVJAPk82Jzg9nMpj1VtHM7eiwTCI=;
        b=f59W8rpeCiireMy6aLUtLJBbk0cyrF0HObZY+VpJdjFES8xWxHtmCi2uIwT9LVIz1l
         p+Jei1yfYG1578Su6S3lgeyQu1lQ4udaXh1nY/R5ouQ6B63ynpEQotsk+IlMH7a3Qfx3
         jS+HsyUw1pGutxaEtCLEecyF+2xhb7JzijTspE+OAMuvuh5rM4VxSKRq/d97+pUa+9+D
         uChXRd623hsQjVgkRUVdQoCDNy13bfB+XzNOZv8h6DaODc7HzYj7tS1g1gxKUejS8IWl
         uWPhBGM8PQnFvpo+oW4mK8lLPy01jQJa0wP1ywAO/3/JQ5necxhKnFRL2OWxcWbe1oWQ
         BNBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0DEXuCBB4SqFL+gJ/L/171Q0Vk6gLcCuw6bLLj+jDmVnL+fGyl9MMXj0vO9HvQUA/k5Ay81tQkdsU1Q1LprDb@vger.kernel.org, AJvYcCWI7DuYxUDj6OFz3SFg3oz+v0lpUkMUh920KvC9M6SazvirAPqVZpJVL5+LOr7bDp9fEE9UAd0sFpUgfwI=@vger.kernel.org, AJvYcCXZydRcmJRPc/0JHxnt5n6gehQMJC49Jt4Ntn5BzRzMHx/dG6tdu+/sxg9hFChiwWksBPnUJNH0@vger.kernel.org
X-Gm-Message-State: AOJu0YzwLKdkrpdDF+3oCuujs8OigmlI7dc3eJK8XxHAtba1nBc27X72
	nDD0HWoNkaZDTBf3fYxeQmSF2tVOgoJ+1ZCzW6L60uZ3kVlVWqYy
X-Google-Smtp-Source: AGHT+IHkY6HLIk0SWtABuEyvwmr935J0nVDpJ21fois+8YT+U7ENcDDXZ4luXGchIvGADP1/I7/oCA==
X-Received: by 2002:a05:6870:390a:b0:25d:e3d:b441 with SMTP id 586e51a60fabf-277c81ed3a6mr14354173fac.40.1725430378104;
        Tue, 03 Sep 2024 23:12:58 -0700 (PDT)
Received: from localhost.localdomain ([159.196.197.79])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7177859a3f5sm888049b3a.176.2024.09.03.23.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 23:12:57 -0700 (PDT)
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Joanne Koong <joannelkoong@gmail.com>
Cc: Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] selftests: net: enable bind tests
Date: Wed,  4 Sep 2024 16:12:26 +1000
Message-Id: <5a009b26cf5fb1ad1512d89c61b37e2fac702323.1725430322.git.jamie.bainbridge@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bind_wildcard is compiled but not run, bind_timewait is not compiled.

These two tests complete in a very short time, use the test harness
properly, and seem reasonable to enable.

The author of the tests confirmed via email that these were
intended to be run.

Enable these two tests.

Fixes: 13715acf8ab5 ("selftest: Add test for bind() conflicts.")
Fixes: 2c042e8e54ef ("tcp: Add selftest for bind() and TIME_WAIT.")
Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
---
 tools/testing/selftests/net/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 8eaffd7a641c5d6bb5c63e3015fdd9f32c114550..9d5aa817411b653ac130a1a581d933180a597ce5 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -85,7 +85,8 @@ TEST_GEN_PROGS += so_incoming_cpu
 TEST_PROGS += sctp_vrf.sh
 TEST_GEN_FILES += sctp_hello
 TEST_GEN_FILES += ip_local_port_range
-TEST_GEN_FILES += bind_wildcard
+TEST_GEN_PROGS += bind_wildcard
+TEST_GEN_PROGS += bind_timewait
 TEST_PROGS += test_vxlan_mdb.sh
 TEST_PROGS += test_bridge_neigh_suppress.sh
 TEST_PROGS += test_vxlan_nolocalbypass.sh
-- 
2.39.2


