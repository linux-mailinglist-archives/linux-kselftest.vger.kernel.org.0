Return-Path: <linux-kselftest+bounces-9793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0518C129F
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 18:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251941F21868
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 16:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6372C16F858;
	Thu,  9 May 2024 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+rOxQTr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2FF50A6C;
	Thu,  9 May 2024 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715271564; cv=none; b=i1MwSDNX9aJ+or9kTsooMcNCxWGoSLj1mzml+Uk1FkakdjH2wzyk8LLx9SrY3NT7MIzJbyHR9wcnPqpMj+fYy2PHT6vtJ3Zr2pg29ZIWVqB0OQSdwYCheHrAxAAAyDoQvLSf1HhDXaepnt1+zytIt0QIVwW6PZ+lFOCErFF4y8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715271564; c=relaxed/simple;
	bh=hWk5ss/Fl/0KtjTeWoegbpR2nB1MeTUqAKsLmIanE4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rTCj0izwy516xmv40G3Jjs8t/LVAHNzniQKFekXe8DbcGg6k5WMHu/5zVufBTIVVHlJxNENddbQTwBEmtdfnO3Nm0EhtXVedj3DVCvuXZHDSiiwnXAPR6rIwE2q+t3VAq1DUjD3zEdBfKmT/yml/dPDFF4PTYFGHZVG+LRkrB5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+rOxQTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544B5C2BD11;
	Thu,  9 May 2024 16:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715271563;
	bh=hWk5ss/Fl/0KtjTeWoegbpR2nB1MeTUqAKsLmIanE4I=;
	h=From:To:Cc:Subject:Date:From;
	b=t+rOxQTrbzTAaTG3HCR2sxpBOJGT2ZVOZl0LjENPLTUWLLehoqZcVRiiNb80MntKD
	 CJb9L6Pgc6v0qm9OtMHJiq5YDnrPyI3FjxoF+SecphEXeXPfgSugYm5SIRJ+KnfaFD
	 X6otCytm9H9FWdIzW3wSTAfWDTZQSZyxkK+9h0YpbbHGF8nciRmWnYgUDp1d2tzHc+
	 Mhn8WkhXGWQI3ySaXWXViAZPX0ducM3dqflUezxq/e/faFOjY5hBGT9ioCZYmvPdNd
	 8MLeEmjJEc5SekCve7ND+zXof0BvLxgEOzoeID7lAvVlxBMpg7g9zyCcCwq9cuLLhq
	 o01quQuZe5g0g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	ap420073@gmail.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: net: add missing config for amt.sh
Date: Thu,  9 May 2024 09:19:19 -0700
Message-ID: <20240509161919.3939966-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test needs IPv6 multicast. smcroute currently crashes when trying
to install a route in a kernel without IPv6 multicast.

Fixes: c08e8baea78e ("selftests: add amt interface selftest script")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: ap420073@gmail.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 5e4390cac17e..04de7a6ba6f3 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -30,6 +30,7 @@ CONFIG_IP_GRE=m
 CONFIG_NETFILTER=y
 CONFIG_NETFILTER_ADVANCED=y
 CONFIG_NF_CONNTRACK=m
+CONFIG_IPV6_MROUTE=y
 CONFIG_IPV6_SIT=y
 CONFIG_IP_DCCP=m
 CONFIG_NF_NAT=m
-- 
2.45.0


