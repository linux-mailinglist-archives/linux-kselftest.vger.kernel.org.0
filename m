Return-Path: <linux-kselftest+bounces-20130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751569A3B8D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 12:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B9E281895
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 10:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7D1200CA4;
	Fri, 18 Oct 2024 10:31:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B5D17E00F;
	Fri, 18 Oct 2024 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729247484; cv=none; b=VUCTS3YDY6ED8W+R5sPPol9ghUwuCEg9cDk1fX/fpxYVim+htlJuPEuURttLJX5KOI9GkVBqh2zekIg8I09TkQYkAKHmZoxLo6iI6vFzrOGycG19+RFphKNSLGGCrNfsJ95qt+xbjb5Cj8QemqlcbOZXlL2hefeFKdTcWTKspY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729247484; c=relaxed/simple;
	bh=F4lC1c2kAZMH8MMrkN8RjfUFNB4yZlPMmlBqvwDtmLE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M7VblzsVX4UBcyVvIvqswywO+dVg64SeUaN1PuMF1DkDTncRMdzjf1YNxrw+pnNVH2vrYX7AG2V5B8KcbRUsriUGJT7B7OrongUIcD0n7BHLMFt5/TKEwj1pomaQezCSY1uBNjZ6f3KF5GDl1iJ7wo7pSKid7IeWtCe9Sir29J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee6671238efd80-10647;
	Fri, 18 Oct 2024 18:31:13 +0800 (CST)
X-RM-TRANSID:2ee6671238efd80-10647
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[10.55.1.69])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee6671238ef74d-c700c;
	Fri, 18 Oct 2024 18:31:12 +0800 (CST)
X-RM-TRANSID:2ee6671238ef74d-c700c
From: Liu Jing <liujing@cmss.chinamobile.com>
To: davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	0x7f454c46@gmail.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>,
	Liu Jing <liujing_yewu@cmss.chinamobile.com>
Subject: [PATCH] selftests/net: Add missing va_end in test_snprintf
Date: Thu, 17 Oct 2024 15:52:51 +0800
Message-Id: <20241017075251.127762-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no va_end after va_copy, just add it.

Signed-off-by: Liu Jing <liujing_yewu@cmss.chinamobile.com>
Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
---
 tools/testing/selftests/net/tcp_ao/lib/aolib.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/tcp_ao/lib/aolib.h b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
index db44e77428dd..5db2f65cddc4 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/aolib.h
+++ b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
@@ -46,6 +46,7 @@ static inline char *test_snprintf(const char *fmt, va_list vargs)
 
 	va_copy(tmp, vargs);
 	n = vsnprintf(ret, size, fmt, tmp);
+	va_end(tmp);
 	if (n < 0)
 		return NULL;
 
-- 
2.27.0




