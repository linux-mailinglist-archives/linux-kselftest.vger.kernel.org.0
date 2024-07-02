Return-Path: <linux-kselftest+bounces-13055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 688C1923C7F
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 13:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05F46B2443A
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 11:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEAE15B984;
	Tue,  2 Jul 2024 11:33:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201CB82488;
	Tue,  2 Jul 2024 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920012; cv=none; b=ZkrPJe0vgfgapi/OyuChMg3hoH9h33IMLx6rEfXLaZBQW4GjZYCq4t1jeUyo4DtBIqUy54JliTF3vkTjco2A1ZVceYN1xo7DiTRkjd4/EAxC4Y++ayxuSYTVsUB98nliG95MOXG5tmcqPU1shtTTrV+SPb7DR+sVw5eGGcT8ONY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920012; c=relaxed/simple;
	bh=WQiuwDDoZehRrDSjUiALxlVpbCKwODdp3MxFrPhK1P0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=URt0snryBHOk3MTt9C2sDIpLjl+t6aNa15HbEM9r83x4ztxaVwXiAfgbNuOjjUzU9Ah1pqh/zsLqfdZhR77fhozXxaFv0rWb4L/77t6jULF75Y96JSHm/UUEOydlI0WQwEnGlnbo3RFQaSRlacdURHZFyKpfkZptTNq/0LiPRuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86683e5699d3-259ff;
	Tue, 02 Jul 2024 19:33:08 +0800 (CST)
X-RM-TRANSID:2ee86683e5699d3-259ff
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.99])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66683e573678-94de5;
	Tue, 02 Jul 2024 19:33:08 +0800 (CST)
X-RM-TRANSID:2ee66683e573678-94de5
From: Liu Jing <liujing@cmss.chinamobile.com>
To: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing@cmss.chinamobile.com
Subject: [PATCH v2] selftests: mptcp: always close input's FD if opened
Date: Tue,  2 Jul 2024 12:05:18 +0800
Message-Id: <20240702040518.11058-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

in main_loop_s function, when the open(cfg_input, O_RDONLY) function is run,
the last fd is not closed if the "--cfg_repeat > 0" branch is not taken.

Fixes: 05be5e273c84("selftests: mptcp: add disconnect tests").

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
---
Changes from v1
- add close function in main_loop_s function
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index d2043ec3bf6d..48b7389ae75b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1119,7 +1119,8 @@ int main_loop_s(int listensock)
 		if (cfg_input)
 			close(fd);
 		goto again;
-	}
+	} else
+		close(fd);
 
 	return 0;
 }
-- 
2.33.0




