Return-Path: <linux-kselftest+bounces-42263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527DCB9C70F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 01:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B97B17A3C0C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 23:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F3D27FB3A;
	Wed, 24 Sep 2025 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrLRx5BJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9191B20CCFE
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 23:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755068; cv=none; b=mI+GJsPeS8tKudsMh4Cf7MUKiNnqhdhxhram59gu8ohwmCYX0Dqpir8HADn7A0gwsXZzH5StOkM6MyDZVl3iXPrrkmW7Irv2Fwyyc1QofWE6qs6fmZldFRk+WwoNzdJFUYxCA34UW40uMBk90EAkwMbgd0lL17m4P7dYGQKQH4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755068; c=relaxed/simple;
	bh=PUMWr1KcbhmB/IOqYU14+Ove2tvnxcz4UzVWOTY2pAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h4LdEOnQLyXjZnIWRe/yrUZrzmAXq3hcEzwYoCd68vx1vxuWIL0Pzdqt1Dn9mIet/bc/J+xfKBmQO2LwpcdMnirF62p3ZZFWVaS2DyPwUJND223f9ShUi8zdSU/eyr6wNoSAp9koMMJO5nuTFxXO+7Dr3i0ZG+Oq0vN56EpB0B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrLRx5BJ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b07883a5feeso75296566b.1
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 16:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758755065; x=1759359865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fnszhabCzVTZUNrenHHSvEHdol2FKszGcCj5sQfSnxE=;
        b=UrLRx5BJGBQ+LztwingaNwl/eEbPDYfCxN5BFbeySAnj7PRfHBdqI4nH9ckd50Q7Ou
         Fsd7ZitkKDvkXgsVmSXlKq1OXaSRaWyew2/9zVcEfkeInTmmWTa9Y3Zkuxf0zZ1Slf0A
         fAoN0QLwbZVBuTeRoSHoCj9rQRIA+GXDNTxRhuGOpvs4QdQLhmx+cUxasqlGFSySUX7U
         NXpOG5asC4rt78A6A/N+TJhYMo9UVQ36kXuChSrFwfxOLTbTIMHD6B5R3REJiZmvVDIO
         MhUj8AWSqACpEgDeX8BkbEfFgE4yCH5AYTIk+fLjzk6ls0A3z8oX4iq8oMSI2Cw17tzV
         YHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758755065; x=1759359865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnszhabCzVTZUNrenHHSvEHdol2FKszGcCj5sQfSnxE=;
        b=mtoH0JZVX8oHvvzZkrq1Y2KLo3lLWg1PPgYDri3cq1nZhIulw3NIM5z5DExFBd2Zcs
         BiHz9aL8pwVEVhztUEbm04qVlY5+81yNVeYftbQL+XxviXpZcqI9gJBQ2vaeM6Kz8Lhf
         BQOJkKYfJBUfhKNey1jccdvhwW/If2u1Jyykh4+NVuZzlORPoHQRgxLGTF0jBpyQcvxq
         SmqaMjqEYFKs3qMlY2ggxaQp/wP2maX+reCBDgbpmLXzwj8Lyur+LV8hFe74Q7Vdfjpz
         rre5+TngD/syMYXl3WpPQmMHQ6wPjkPS7nbMjzY+a8YCRWJI5XLxwLV8lln1Tkaq8hOR
         Xq2w==
X-Forwarded-Encrypted: i=1; AJvYcCUYS9IdIU/QSRPXo60pGC/rhtE+MLGtR4GniwxXsKip6ZQ/XSLnwCmRuGtmYzUcL2LvVvN3aQmTih5UK2ZzZCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcRyzTN+p2EnhSx0TwrNE/hcgjWtGlMCmlFUlbqn0uUInIpb1c
	uQ9aDuLXmWW23wReBkdC27eByOYkxN450sZ9NgrsMAE6uHvf0j9nGuOhcniLyDoVHLk=
X-Gm-Gg: ASbGncsrBCKT60PW5WLGssbqyaujxsVlxMuyA0h6ai2PT60w6mku2pPz58w59L5ASHp
	Lyg4RLQsEaFu5xZsI6UnBF3oTOYIqdMhYwdK2ohGLXhft3+RrQoI/pOserwRZgdgyqI0+SFT/HF
	tV8Vax8duQkmBdOPgRs9GujNkygJpr2WyGPzgrblZxaQ1CCPqQqtg7r9FUPzmh9qAtZQ9enyxwI
	RmyaG5PU2uaNftcf/C/HFvHeF52B6f0RVfav9op6r/ehUx7XTir8TmHBZrPYXHVTLpSuE69UjSm
	sR9xuOFTzEW3zOIpQJTFFQcYkhn42QvEB5eIahDNqkjzV18Iw0ldrP3+TujL8uTxobzxZWVQFwd
	7HWi6HG6Wiifzm4Fo7tr8A9T4CCaRT66gU+ad8CliG+eAYZHYhHQCgko0MvZNtktMXJkf3EQOEp
	6VifcLjyrcyvVn7XXJ
X-Google-Smtp-Source: AGHT+IEppvE3960x6XIR7URKU78EOKSYRIAcJdBEOqPrulJnmbx5gMilskPWXare99l4J1hqwdTmQw==
X-Received: by 2002:a17:907:6093:b0:b04:6a58:560b with SMTP id a640c23a62f3a-b34ba93ce11mr146872666b.39.1758755064614;
        Wed, 24 Sep 2025 16:04:24 -0700 (PDT)
Received: from alessandro-pc.station (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353f772528sm34363266b.37.2025.09.24.16.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:04:24 -0700 (PDT)
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
Subject: [PATCH] selftest: net: Fix error message if empty variable
Date: Thu, 25 Sep 2025 01:04:07 +0200
Message-ID: <20250924230413.75246-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix to avoid cases where the `res` shell variable is
empty in script comparisons.

The issue can be reproduced with the command:
make kselftest TARGETS=net

It solves the error:
./tfo_passive.sh: line 98: [: -eq: unary operator expected

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 tools/testing/selftests/net/tfo_passive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tfo_passive.sh b/tools/testing/selftests/net/tfo_passive.sh
index 80bf11fdc046..2655931b2396 100755
--- a/tools/testing/selftests/net/tfo_passive.sh
+++ b/tools/testing/selftests/net/tfo_passive.sh
@@ -95,7 +95,7 @@ wait
 res=$(cat $out_file)
 rm $out_file
 
-if [ $res -eq 0 ]; then
+if [ -n "$res" ] && [ $res -eq 0 ]; then
 	echo "got invalid NAPI ID from passive TFO socket"
 	cleanup_ns
 	exit 1
-- 
2.43.0


