Return-Path: <linux-kselftest+bounces-46148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E11B1C76BDB
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 01:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6521D35E52B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 00:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2286F22A4F1;
	Fri, 21 Nov 2025 00:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BNh7+mUT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75AC221DAC
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 00:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684456; cv=none; b=T6yXsp9pGb5i2BWR9TfYWJYBVHI2YWVYEkdbjKlUB++Kvm50KnVo6TBbUVa8iur37Xvb8lQ/4RNzyKQ/dAN8DNv7fZl5tA9+i7s+YUxVfRQSAAkPBLt4trqG8/jdKcBylcpX9FvkwW+u/Xwq7zxhsT39aHfZYXtoxtWS/ZN25vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684456; c=relaxed/simple;
	bh=GrnXLMRsdgFNohgAyAbm8pIb18hIeb6R3DkmtYH93vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpsyfrqeSljRXKI4YDVNVdzNJCCqP+nG0evfwvNDb6qamA9Tq5WLZdfVRXyKcfrJK+fNsXptJ+NNLk0FRj6UtlypygoQQni/8m1Cc8u/X8w3rdKKtEIMascWum7Fiv67Im4RkW1LmzCCL2R3AWD51/WjjazKfM/YswM9XduI4dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BNh7+mUT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4775ae77516so15910645e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 16:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1763684452; x=1764289252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6F1Wn5RNwY0zkpVgGTHfa5EnMBRoW8TlKg/+h7xsfo=;
        b=BNh7+mUTTMroOFd3WLv6xxPz3DLss9hCAL+DJLFvpC/IxnXe07CBu1oMcdoW8RSyY9
         RUdmqkUiNSE0F0xozyro5/bHefOsIxgesuvzf1+hhyy/NCfLXiGQ4It19dJMQA2Y8ztH
         ZAji0qIG5nltMCVyCcGyWihHZHqni8D4/svAjAptpczumH2VJL9I+zeiB+iyiZJVT2Jy
         aacpN4+turly7yuJLG3TKzCXT37O1kOiQjziQ9/GYFvKVH2ZXTIaGywC8c73UpL+pZ4M
         P7D0tTf6rLateCJZeF6x7XffjX4BdtZRO2PEbrK0Y3rP6YgADFTZoXCZn14Eg3VRcARk
         x07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763684452; x=1764289252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v6F1Wn5RNwY0zkpVgGTHfa5EnMBRoW8TlKg/+h7xsfo=;
        b=ue1z4BtU0FuxWadVnzb3r3pFSiuObbw78NMSOeYLgmcMc1MbB3cn63VyMtOsQcr6jB
         E4U3pG+IUA218bojuK5LCqwTGG8SzQbeDKyUv5fE8lMlXY+RekfUhS1BR1IfHDdP1/8F
         dIkuUamoxfsvJu+y8Oal8+SbBRzkVCHYzC7JqJYWIxwNCpOPtNhk8nKi08pDrTdfFcYw
         dkyDB/zXp0A3AyOctt7D5LKFi6rhp/rgqD0JKUQv5L77PyyoNjw+IvqYMVk+ZocuOpmI
         tnBGuLBOy3EJVoJW4hl82WzmBzI32762ihyoMSHbKvBSY7ph/N9Lhy6xTH4l7CDKZwd+
         CQ1g==
X-Forwarded-Encrypted: i=1; AJvYcCWCSmxwsbOTCurLoN2x6shxvnGySfkqCPKiKqoY4XjtwIMSqIsqyKh8m9WyeSkbM+s3gr1gcJwpK0i5aOqyRr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXv9BpDf4qnYv9PNXmo0JOnDB1KNHtR1IhJMrf3fAQmrCFq87O
	/1zBMxV52B+wzeLSHjdagZePdbmY7dz4C9/ORQ0ybpO+cNFOfrbtaAsr6VZYN6rIOZZv5m99xDn
	crObIeAAXtfCyh61HcY4ef2c0MezdwLmJCgUGkMddqezMMAxz2qyppqbRy7RSDbU=
X-Gm-Gg: ASbGncsb+2LHwx8+ubX9tjd+kCLVhCck708UH3TLyh8uuYa+afindTSn5atITUNDVIP
	iMeLr9o+PWUhpd1LAY7eBJGNBzNhvZz7XoO66dKLsiRKunB7hSFRZenhY1bts/Qq/bsPjcvU31Y
	fWu1bZbuRHlYEQhbbueD9taW7m8vd8YroFcStw6Q7WDdkE5vOAuAX/fBR2deZuzQu/xv4WM5H+M
	05xixIkFfa3nnUjoc9dE6dWgk4JgwxcQXPQdbAOcAnukiraS1NhJrMnu1B0dvUpx9d0iMt6IV1y
	kedwrq1uSizZKqazSZwQbHYWJJUV5u4eGTg+Q8y5+n+jOGlGTMYpVfYjslSwebBxibey9uJLfGj
	jdSJfI5vYLPEvb1frxn0yNFdSmPaWsLLcGKvEW7uwy3NBUybvbx/fzSJSHi61VfHe7426ckZKmJ
	84oPdTzB/sKste4sbNUCCqFEum
X-Google-Smtp-Source: AGHT+IECtfzLd1PKZQnJFdOVD2F+AYvHvdZcJcj5SSbPVKZh6YhMSUT8HdJjYTSSezD8nOsVl29XAA==
X-Received: by 2002:a05:600c:45d1:b0:475:dae5:d972 with SMTP id 5b1f17b1804b1-477c1123afcmr1611435e9.23.1763684452157;
        Thu, 20 Nov 2025 16:20:52 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:85ee:9871:b95c:24cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf226bf7sm15287345e9.11.2025.11.20.16.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 16:20:51 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Ralf Lici <ralf@mandelbit.com>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Subject: [RFC net-next 01/13] selftests: ovpn: allow compiling ovpn-cli.c with mbedtls3
Date: Fri, 21 Nov 2025 01:20:32 +0100
Message-ID: <20251121002044.16071-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251121002044.16071-1-antonio@openvpn.net>
References: <20251121002044.16071-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mbedtls 3 installs headers and calls the shared object
differently than version 2, therefore we must now rely
on pkgconfig to fill the right C/LDFLAGS.

Moreover the mbedtls3 library expects any base64 file to
have their content on one line.
Since this change does no break older versions,
let's change the sample key file format and make mbedtls3
happy.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/Makefile   | 14 ++++++++++----
 tools/testing/selftests/net/ovpn/data64.key |  6 +-----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/Makefile b/tools/testing/selftests/net/ovpn/Makefile
index dbe0388c8512..d3a070db0bb5 100644
--- a/tools/testing/selftests/net/ovpn/Makefile
+++ b/tools/testing/selftests/net/ovpn/Makefile
@@ -2,19 +2,25 @@
 # Copyright (C) 2020-2025 OpenVPN, Inc.
 #
 CFLAGS = -pedantic -Wextra -Wall -Wl,--no-as-needed -g -O0 -ggdb $(KHDR_INCLUDES)
+CFLAGS += $(shell pkg-config --cflags mbedcrypto-3 mbedtls-3 2>/dev/null)
+
 VAR_CFLAGS = $(shell pkg-config --cflags libnl-3.0 libnl-genl-3.0 2>/dev/null)
 ifeq ($(VAR_CFLAGS),)
 VAR_CFLAGS = -I/usr/include/libnl3
 endif
 CFLAGS += $(VAR_CFLAGS)
 
+MTLS_LDLIBS= $(shell pkg-config --libs mbedcrypto-3 mbedtls-3 2>/dev/null)
+ifeq ($(MTLS_LDLIBS),)
+MTLS_LDLIBS = -lmbedtls -lmbedcrypto
+endif
+LDLIBS += $(MTLS_LDLIBS)
 
-LDLIBS = -lmbedtls -lmbedcrypto
-VAR_LDLIBS = $(shell pkg-config --libs libnl-3.0 libnl-genl-3.0 2>/dev/null)
+NL_LDLIBS = $(shell pkg-config --libs libnl-3.0 libnl-genl-3.0 2>/dev/null)
 ifeq ($(VAR_LDLIBS),)
-VAR_LDLIBS = -lnl-genl-3 -lnl-3
+NL_LDLIBS = -lnl-genl-3 -lnl-3
 endif
-LDLIBS += $(VAR_LDLIBS)
+LDLIBS += $(NL_LDLIBS)
 
 
 TEST_FILES = common.sh
diff --git a/tools/testing/selftests/net/ovpn/data64.key b/tools/testing/selftests/net/ovpn/data64.key
index a99e88c4e290..d04febcdf5a2 100644
--- a/tools/testing/selftests/net/ovpn/data64.key
+++ b/tools/testing/selftests/net/ovpn/data64.key
@@ -1,5 +1 @@
-jRqMACN7d7/aFQNT8S7jkrBD8uwrgHbG5OQZP2eu4R1Y7tfpS2bf5RHv06Vi163CGoaIiTX99R3B
-ia9ycAH8Wz1+9PWv51dnBLur9jbShlgZ2QHLtUc4a/gfT7zZwULXuuxdLnvR21DDeMBaTbkgbai9
-uvAa7ne1liIgGFzbv+Bas4HDVrygxIxuAnP5Qgc3648IJkZ0QEXPF+O9f0n5+QIvGCxkAUVx+5K6
-KIs+SoeWXnAopELmoGSjUpFtJbagXK82HfdqpuUxT2Tnuef0/14SzVE/vNleBNu2ZbyrSAaah8tE
-BofkPJUBFY+YQcfZNM5Dgrw3i+Bpmpq/gpdg5w==
+jRqMACN7d7/aFQNT8S7jkrBD8uwrgHbG5OQZP2eu4R1Y7tfpS2bf5RHv06Vi163CGoaIiTX99R3Bia9ycAH8Wz1+9PWv51dnBLur9jbShlgZ2QHLtUc4a/gfT7zZwULXuuxdLnvR21DDeMBaTbkgbai9uvAa7ne1liIgGFzbv+Bas4HDVrygxIxuAnP5Qgc3648IJkZ0QEXPF+O9f0n5+QIvGCxkAUVx+5K6KIs+SoeWXnAopELmoGSjUpFtJbagXK82HfdqpuUxT2Tnuef0/14SzVE/vNleBNu2ZbyrSAaah8tEBofkPJUBFY+YQcfZNM5Dgrw3i+Bpmpq/gpdg5w==
-- 
2.51.2


