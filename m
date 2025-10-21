Return-Path: <linux-kselftest+bounces-43671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E899BF7CB0
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 18:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE9874E9321
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 16:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087A234A762;
	Tue, 21 Oct 2025 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNRc5cnX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CDA347BC0
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065707; cv=none; b=DqLccU4HwwdGSrTatgoiDTRqcmA2PnWgYVHhZQ94h9GvT5wiCJ7koaEn3rbrT71nIoxUPrajf9vUgOJy1B8rJpG3iyHLErq0XuKoQeAkRJ3w2/FTwp56eu2mP50dqQMaayD0G9W3SrxMoRw1pYlmc7UjyBlGg8MKALezuAu4htU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065707; c=relaxed/simple;
	bh=MD15u5LqqmayWloxdzFGq0sNLTBc1b1Ii0ATLOQcv8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qhNFx56vWnC3sWUk0pfIgMI0ZYu2QROFSaicsY+E2pwhv8pNXnXhkM5eZDejfO5bzfTiGVTMZjJl22p3Fnxs6ArtYB3BIajsr4r+lCff/6cN4bwqB8U4GvdrNkNIu9Bf53iykdpwmcidTuZBRFxum53pkj+6CGM1JmPUEIocock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNRc5cnX; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-426edfffc66so59086f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 09:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761065704; x=1761670504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qn9OLNMyl8gChDp28IqA1MLvsXpL32JwaHFC00xTtCc=;
        b=NNRc5cnXLfbWheS5JvW+1vO5mWwePGxYnLtn01PAfA8vOtmQgEH3BXpgbYE8SclLYk
         8a4pbZfjxmSgujPZLxwhP4zb96V/v8PsjkxYq1YdTF7DUAnudpRCWr0wK4tJOu59Hc0G
         09WR0FfLVoRl0GkpwNk+vbcDMiSEGpRwRZ84fgxqepsGR4WGySjqrbof4L8qqRsutft4
         ndac/Fn9/YZEYqqiLSXOskn3N0ca1MHiHvZOZQMHxqqE+zgiIlcm5aQMd4QGEx7qktQH
         g1opwS5cWzwg2yrN7pyEQq5CR+69rPX0HDQBjYnXAISKd8JS4rrhIh0DjmEPMDfGXccI
         dy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761065704; x=1761670504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qn9OLNMyl8gChDp28IqA1MLvsXpL32JwaHFC00xTtCc=;
        b=K2oSQYA7qldeHmPd8+mVEWhqzQbE8IVYEJBOS0Yj95uLCG5o/Rq+s7h//UGKDaBzBF
         TqZAqeLadddeP0gc1VOcziMRsyzMvJShnd1grOYeXSWwRvOPTQcrxTtOvnhImMzZVfyH
         0aNolATPq41EPSS0FI3JO0aF7MJFLcMSgwE2N/8XhHoOWndWO1bwpc94IV54l8+G29hh
         BuiJEhUczlt9eO3bCj/tPW8J7u9CIFTVOzgatZd9Tx0UnXbHoigUlOV5+U8L94tU0Nrl
         ah620/+X3Eg2J8PNP30HDtkZUSGd8nO1+Swg1MChvR2+wz3lwTOtbVLDXO34StD5880C
         dRww==
X-Forwarded-Encrypted: i=1; AJvYcCWCXWZ6Anpw/4yXOii3wQpWZWjr5zKNX8W/DCQYiz10ChdD6yU5INDB20gICM3gpFdx6H3agUobO1VDOYGkEx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhUGMLlXseuYQA3HY4GBP3hzyO2MspMaMkPfx14E6whJgNffY1
	XqFCZ+e9EF7nIgsa7SovtD5gnCPJGDZGvaWhoPPBOGPy+m+DaPspR5Se
X-Gm-Gg: ASbGnctYK8BmuNBbOh6VPw790GJfig5zLIrM9PTmdAgKzbp9lLLhJp8xSbvoPefnssP
	cppZnnlXbN7XrDUuVVlPsp/6YZ+/ozn2VVlO0xEJhOmLFBWzRNH716JuTHlNs3xU+zc+WsIOjsT
	3+9aqIyYehSbhU3H8H0w9Hj886LpmknFfNUoSYSfAJQN3/353R3u6D3oDPwhO4Q/qXfBK1Af1VM
	nj2cQeC50lyYAoDJP7Z/9knAjZCp+QV0nT2Wgpn5f9aNmUTYdj09GmtbyIKcyTEy8Pip46mT2J5
	C/qk+ppNlxZpxcFj0GGYN7XhjUEOx/mUp54irJ8TecztPeMJ+55FTXq/eyfR5C6BlMUNdMmvssr
	9HPgvUt6EmVr1WmfYFDlJgHAbvqE+FZIBVxxP8W3UHJExVtBuHvRBuJfVKGKg6Jk3/Uts4wXIVw
	Tk/m83wJdkd2SbTKEGQfEs+u5OzHDn+75dT69DOpmFzMA1RJhM8NVy7bpV2EUw4tWsjSy8Xw==
X-Google-Smtp-Source: AGHT+IFB8n84f69J64AkWR9VGuZDwOZaYOeLxR1PP9RJZ4VLcpx4xH2b3szKu1AMRcrRkxak/JLlHg==
X-Received: by 2002:a5d:5847:0:b0:3dc:1473:17fb with SMTP id ffacd0b85a97d-428531c8828mr255369f8f.20.1761065704306;
        Tue, 21 Oct 2025 09:55:04 -0700 (PDT)
Received: from alessandro-pc.station (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm1649005e9.3.2025.10.21.09.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 09:55:04 -0700 (PDT)
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
Subject: [PATCH] selftest: net: prevent use of uninitialized variable
Date: Tue, 21 Oct 2025 18:54:33 +0200
Message-ID: <20251021165451.32984-1-alessandro.zanni87@gmail.com>
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
 tools/testing/selftests/net/netlink-dumps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netlink-dumps.c b/tools/testing/selftests/net/netlink-dumps.c
index 7618ebe528a4..8ebb8b1b9c5c 100644
--- a/tools/testing/selftests/net/netlink-dumps.c
+++ b/tools/testing/selftests/net/netlink-dumps.c
@@ -112,7 +112,7 @@ static const struct {
 TEST(dump_extack)
 {
 	int netlink_sock;
-	int i, cnt, ret;
+	int i, cnt, ret = 0;
 	char buf[8192];
 	int one = 1;
 	ssize_t n;
-- 
2.43.0


