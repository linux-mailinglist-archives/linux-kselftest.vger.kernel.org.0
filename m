Return-Path: <linux-kselftest+bounces-43960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6759BC03758
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 22:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4CDB567400
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 20:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACD726FDBD;
	Thu, 23 Oct 2025 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPTBPTQi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC4E238159
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 20:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252847; cv=none; b=mNpQfp+7x/dIU1hs0d4Hfcu47ODoLwL10/nu9jgjjDFgDcMJy5xTbZLdt5CAS+SYf5B61Luh7IMBI7Ez4LlwCMyK0WblMJ0AU9ta00ndBfd8HEwB9oJ2LtiY4/Q26hJ+t/eJKnVHVPWg5gJgX8msOaZzI1dYc0yTeiLVlWZ+EOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252847; c=relaxed/simple;
	bh=hklffgyYK4VMFsD0CdS9XrqoU+fsq1a2y3wTFz4L+Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IKwl35cLoDm0bPBgPXZu3eZmop+NIyJMxT42qq1yNvdCjdQMV3TE4GNITOGp227iZQE2grWw+nAblNL/vyY34pAifeu64IZr6e6ZQ24POBQR1xja0Oc0EcGrdsKUVVxtlLdueeIS9cKYmXdtvADSB7Kda1Z/TaUw78t0W/QawJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPTBPTQi; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-471b80b994bso18041675e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 13:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761252844; x=1761857644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wcTYeshnmr2jeZu3uYGRDZUvk+BEhVzCgVA2Gfj5vu8=;
        b=XPTBPTQiS3KAtT2nBIuEMxUpB+mGeaoUnLN2NolR0ku26czbPRyR/orFs3oUBi6PCc
         8qCz32Z9H3gG8QKSuR42x2SGmyLhCcfl8MlfTwbXAEnAdn2lKyQtton8WxQiac9Dzg2q
         2FccvBUJzgvDNtc0AatZlLJ3ZgIbOEChIjzh5B1d4J3IR3A77GFBSs21GHQHCe6L7HYe
         yTx98ms0AL73kzx/cq4CtTLu95gMShBFhOwwyKKD+hjDJ/IskAj1ERlQjgX7/g78tPHj
         qeDo73mDNre1sitSZlYqxYWUfGArvqAHK1iYuk+as6laYhmaZsEHPTLRAtXmF9gB6N2P
         DLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761252844; x=1761857644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcTYeshnmr2jeZu3uYGRDZUvk+BEhVzCgVA2Gfj5vu8=;
        b=tFxxYli47HgHs7+htSGkvmMbWR+h7agbPXxKyt/2PVjC2BHCEbwl2FYZuIqQ5HYEWl
         a28FIVnsOyT0xuCEBclr0e4y38lCJrjOPPp9Ufw80ObW1ap3PpsWuO6+HxTGNPFHs5L/
         hzKTyiOXPa9QztT7XO00VeUThyZNOxwVJIAwrAwc5QgVvELH+uW1qB0rGujO7jJbFPF2
         7PRmoJUnrT0hD8u/b4bRC9g4jwarb8fAhuWVZLCxlnAAxo7/jHWJXHcu5qip3mquxEOB
         f8QKWdjh/Uf/MyWKAZg4oofRxSaT8YligqmtX2vhUzw9SQLl4csIsE0jRD0GY3Ac2xGz
         59Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXqbCKd/B7gDfcxC3hg5nPwq/WF6spaQtJrtWQAC4trGMOVcdoKDjW4pcjMuKeh3sehIZT/aF97pHH3sHOR1gM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxANS1nP9ndcJFAZXkHAkHAEvny73xFKq+tN8T1FKhMR0F58zpa
	IyKyM0t4c+pW80P7nwPRZ7Y/Ym8NfMA6zQbvbXVEP9shZD77DGRih/Be
X-Gm-Gg: ASbGncu22l46uxPTbLGmh6D+yQS6+hODBzkZnNefVQnN8kL8LQA3l4eMzGj9cqzWu/7
	R/hLW7+kE7rbTuIMz0Ha7x+gWfYnqgYM/x277oYENdwWSdrQx6OsoruqYj7jNXByoWPWmX25RoB
	/BOAd0g+1U/Jz/axr8ufZEgUJ68U59fayhdlP+EAbpuH7y4Wyux7AN8LbRSNl+vBFHTVKuWH4ux
	83LqOPuRgfXlwG2rEC1dhqpmt8hwefZHPZbUOJyOFp5XQmcW3cpMM2bZXo2QEZcnQVGFR5LJdLV
	BjUDmyIZyQThv+laADrqseoumxy5FOmqdhNULSt9M9pLT9CmacffP2pAzc94Z16VjomA+NmgRpn
	tmeEuWZFHnNjsaPqP8hmwVcDtFu0Eq+68bGLQCAcLqaFOerOkwoOB5jGR0g9VTjkS3m7LdEyrQY
	TNMT0NP7yGmp4aE700IB6OON1rSxQZurjrsZMBQdrWOVTcYzW2ANoErCkoAVduvMNkl7ZBiD55
X-Google-Smtp-Source: AGHT+IGNcYfvgrEtyv7m+Z6cYdS9youXfDFaSCxmdJXoMuPMDUIma4zmYzmszUwxmllhSMsx0bTfvA==
X-Received: by 2002:a05:6000:26d1:b0:408:d453:e40c with SMTP id ffacd0b85a97d-42704d8efa0mr18802626f8f.25.1761252843821;
        Thu, 23 Oct 2025 13:54:03 -0700 (PDT)
Received: from alessandro-pc.station (net-93-70-84-238.cust.vodafonedsl.it. [93.70.84.238])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898add96sm5658143f8f.30.2025.10.23.13.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 13:54:03 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftest: net: prevent use of uninitialized variable
Date: Thu, 23 Oct 2025 22:53:52 +0200
Message-ID: <20251023205354.28249-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix to avoid the usage of the `ret` variable uninitialized in the
following macro expansions.

It solves the following warning:

In file included from netlink-dumps.c:21:
netlink-dumps.c: In function ‘dump_extack’:
../kselftest_harness.h:788:35: warning: ‘ret’ may be used uninitialized [-Wmaybe-uninitialized]
  788 |                         intmax_t  __exp_print = (intmax_t)__exp; \
      |                                   ^~~~~~~~~~~
../kselftest_harness.h:631:9: note: in expansion of macro ‘__EXPECT’
  631 |         __EXPECT(expected, #expected, seen, #seen, ==, 0)
      |         ^~~~~~~~
netlink-dumps.c:169:9: note: in expansion of macro ‘EXPECT_EQ’
  169 |         EXPECT_EQ(ret, FOUND_EXTACK);
      |         ^~~~~~~~~

The issue can be reproduced, building the tests, with the command:
make -C tools/testing/selftests TARGETS=net

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---

Notes:
    v2: applied the reverse christmas tree order

 tools/testing/selftests/net/netlink-dumps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netlink-dumps.c b/tools/testing/selftests/net/netlink-dumps.c
index 7618ebe528a4..7de360c029c6 100644
--- a/tools/testing/selftests/net/netlink-dumps.c
+++ b/tools/testing/selftests/net/netlink-dumps.c
@@ -111,8 +111,8 @@ static const struct {
 
 TEST(dump_extack)
 {
+	int i, cnt, ret = 0;
 	int netlink_sock;
-	int i, cnt, ret;
 	char buf[8192];
 	int one = 1;
 	ssize_t n;
-- 
2.43.0


