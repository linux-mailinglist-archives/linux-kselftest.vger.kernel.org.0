Return-Path: <linux-kselftest+bounces-13231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D41992839E
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 10:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1F51C22166
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 08:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4241A145FE0;
	Fri,  5 Jul 2024 08:24:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04800145A0E;
	Fri,  5 Jul 2024 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720167878; cv=none; b=mVqvp95kVq3/HOWqeaJRVowZ+EPcHYyTOwhkxzPduc0DnAhMEWlUbeR1X6zP9IKbFt6M8cuVkOEalLt37nkp/pakKFS8MWH4Sh8MNLiaVM3KLhWvffamOpTCgXGOORxs0ZxYFExJN4RynN/AqzaZ7ml/vDvfhDn40Dws0nJJDvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720167878; c=relaxed/simple;
	bh=BuEZFqk/1LWdUpNXNejOfOHGoX/xRTCByI4h9dJMzmU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rQz1pznO9VOqUGHE0e74K7XGw4edAfABhdpZJ8EnE+qw3jtZhWYHGGPc3poZ5JGf23hGPxdDzdY+cddQfDAPLXcQ4BB3i924NsIBoDeRjEzpjNlrWCyQ265guK0bEcrfGZ0ZXYoM8AObiE3NucwPWVfwMAFluA8rwdo+63qgK7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56687adb8b94-06b94;
	Fri, 05 Jul 2024 16:24:24 +0800 (CST)
X-RM-TRANSID:2ee56687adb8b94-06b94
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[10.54.5.252])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6687adb6346-0f58c;
	Fri, 05 Jul 2024 16:24:23 +0800 (CST)
X-RM-TRANSID:2eea6687adb6346-0f58c
From: Liu Jing <liujing@cmss.chinamobile.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing@cmss.chinamobile.com
Subject: [PATCH] selftests/net: missing close function in randomize function
Date: Fri,  5 Jul 2024 16:24:21 +0800
Message-Id: <20240705082421.7061-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

in randomize function, there is a open function, but there is no
close function in the randomize, which is easy to cause memory leaks.

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
---
 tools/testing/selftests/net/tcp_mmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/tcp_mmap.c b/tools/testing/selftests/net/tcp_mmap.c
index 4fcce5150850..ab305e262d0a 100644
--- a/tools/testing/selftests/net/tcp_mmap.c
+++ b/tools/testing/selftests/net/tcp_mmap.c
@@ -438,6 +438,7 @@ static void randomize(void *target, size_t count)
 		perror("read /dev/urandom");
 		exit(1);
 	}
+	close(urandom);
 }
 
 int main(int argc, char *argv[])
-- 
2.33.0




