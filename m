Return-Path: <linux-kselftest+bounces-18446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D62987E0A
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 07:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968821F21FDF
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 05:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A629E175D32;
	Fri, 27 Sep 2024 05:57:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538B1184F;
	Fri, 27 Sep 2024 05:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727416649; cv=none; b=rNW7/PRbACiLmQBkRLXHb/Slwrd/A11b4d2ZpoxWZeF8Zvom+QcZFT9YV8MDaXvc5xDmpXfBoqGSMCQ0vCj5/Z2vcJXELUvv5kkHyd2XL4JpM9Wss0K9Pqsv2+bsBW7IxO5ATRrylDkxTQ6L5peG4nRwoxVg1VgjzCbokrf3sx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727416649; c=relaxed/simple;
	bh=0eBJjXppsXKOVBE8ZmXHF2h0FfXYLjW23lgos8gS2Tk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B2xq2fsaRw5+JNMnW0lUV27otynUfZ/OJGDk05kyWF/1jWz4jLavYixur8XoMK7Dce0WOCiKJNnLNYOAv7KsWBUhbyyeKgDr8WqMWeTcAfv+ECPwhK9eWZfL692dKIOQZDkHCbi/F9krUVcT8veR+GbMa/X8cMCyxkpQsnDlnos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee866f6493cd50-d8d86;
	Fri, 27 Sep 2024 13:57:17 +0800 (CST)
X-RM-TRANSID:2ee866f6493cd50-d8d86
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee966f6493cbb7-34997;
	Fri, 27 Sep 2024 13:57:17 +0800 (CST)
X-RM-TRANSID:2ee966f6493cbb7-34997
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] selftests/net: Add missing va_end.
Date: Fri, 27 Sep 2024 12:00:50 +0800
Message-Id: <20240927040050.7851-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

There is no va_end after va_copy, just add it.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
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
2.33.0




