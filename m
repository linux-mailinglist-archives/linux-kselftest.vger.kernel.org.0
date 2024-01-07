Return-Path: <linux-kselftest+bounces-2685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EC9826281
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 01:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BBA31C20B90
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 00:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EEC399;
	Sun,  7 Jan 2024 00:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="ad4daJkr";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="r0SALi+R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6CB137F;
	Sun,  7 Jan 2024 00:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 8A2D36017E;
	Sun,  7 Jan 2024 01:39:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704587981; bh=dajTlugDkmvQwmR5oxnLu6s/1NlVZrssj13qErq7acg=;
	h=From:To:Cc:Subject:Date:From;
	b=ad4daJkrAVyrtJibwskRavJ7xTjnKyQ5M0KoRpuBuPXD9A8batZIOgH95HHdY8lfn
	 47CNcWk2N9A6m+Wvo/LTT2rS5LjAKqHKfidkxiEUqpwF6FLYXDKCSfshVDs0mNVU/S
	 0jBSBJYt7hvyiG4itc3Uf4T+Pqdn3shtjP5lndlwT/JYf0QC3MCbwQ50f8AEzN7Ync
	 7smu6mkNSm4znb1mc9KzDLBcW+fyjaE3r5LzcVjtquLC/HnMdusaS7Wt3e1N1pPZFl
	 /n7O/S8YU39zwgk1iwzhEsEZLjWLDsl3KZxHnfAKH0I7OJmpEhSRBsxANBng7Fybz9
	 xwLJrjg/bCWOA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bwdmuwcjnV_x; Sun,  7 Jan 2024 01:39:39 +0100 (CET)
Received: from defiant.. (unknown [95.168.116.36])
	by domac.alu.hr (Postfix) with ESMTPSA id 5DF0360171;
	Sun,  7 Jan 2024 01:39:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704587979; bh=dajTlugDkmvQwmR5oxnLu6s/1NlVZrssj13qErq7acg=;
	h=From:To:Cc:Subject:Date:From;
	b=r0SALi+Rl2Uxlx/IpnEidBfUFy+T4DVAdqd/U6Zj3ncQZghzPDkR3QSsK+qvlbxF9
	 a/gJL7LeFuZkhbeycAzIdcy/YnIOc8hThiD9K6s4Y6It0vFb7qwodll1Hr/x6SFoVJ
	 cn6Kid+JYlfPZKdDQH5sA1MqCwZHCRZmrxEQ/XOcHucC+gbeA7hVueypsIEBJPxuF9
	 I7gsf58gSt9MbxBKXNSWCb4DSmE2/Frki1JnF6Tv+iT2uY5KL1KaZ3tpMxdt3ZR9N8
	 4qPPycYJP7swT5Ptr26HfdK66YeS94VB7ZcdCwnG0Hi4O68KPbSrTgm0Bt6r44taz/
	 1bLultW3QWLKA==
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH v1 1/1] selftests: net: increase timeout value for tests
Date: Sun,  7 Jan 2024 01:39:29 +0100
Message-Id: <20240107003929.891669-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In particular, fcnal-test.sh timed out on slower hardware after
some new permutations of tests were added.

This single test ran for almost an hour instead of the expected
25 min (1500s). 75 minutes should suffice for most systems.

Cc: David Ahern <dsahern@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 tools/testing/selftests/net/settings | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/settings b/tools/testing/selftests/net/settings
index dfc27cdc6c05..ed8418e8217a 100644
--- a/tools/testing/selftests/net/settings
+++ b/tools/testing/selftests/net/settings
@@ -1 +1 @@
-timeout=1500
+timeout=4500
-- 
2.40.1


