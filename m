Return-Path: <linux-kselftest+bounces-26009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76280A2C9AE
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 18:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD473ACF7F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 17:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBED01922E0;
	Fri,  7 Feb 2025 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCA7d01T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E0C18FC84
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Feb 2025 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738947684; cv=none; b=JY7gOmZyUELPPDoGXhF2I+zekdhnhTUNPa6zBCDhqf179qqvecGXVIGKZAIuNaUcQbycdzmTPeV5mP1aUU0pAYpnmofdGGiJ9c5G7ziBgph57NSsj0es76XRFLK2/Vcf3LkdsE1BLgSXx2h9NTaaSCgOUNA8C5+oi96rBH8RDPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738947684; c=relaxed/simple;
	bh=KUxFX+4f0Aizw7Mg85WPdNi8c0DEahMb6LLBmtuIvak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LQJ0I64grtrwQeAR6Bu7COv4moFdu5QsGR8qF37s9Y3KLvGI1IZx/aZAv3RpgxSiW6BgistwVLwhK/SKD2gINGkCLmxZ/Yn3fgp2YzkinHGe4pkh00VHm2WmCcbHWovx+KZMMcBHH3RUw+dV+8guEe0C8tIQR4Lye1iAaK7LCwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCA7d01T; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2163dc5155fso48686825ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Feb 2025 09:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738947682; x=1739552482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K89iMvYVIaxnJ+fqwfSq5htV0qyp5rhqJml9Bv4LRmc=;
        b=YCA7d01TkWvtPM5Vwfkv5c8Mb/xXsefK8WNDCrBcu5tLDOC6RUW3cDSYF2qiS5AT2U
         Me4v9jD5AAvZyOC23CmCLL82FJaLEoMgjCdttzyzlB4Rqj24a+oj82bHt7eo3qKrKa5s
         exajEVyVlKsHob9ud5ko6f7Id/lxapbMFKGNN9omfPNtiPeLuyCkynYyUanvtkpvxjfQ
         pM5YFk8Ei5hoxt50lXTGSHPoQv58irqOZKIaP7xRHstSGNjjvnzdGRjYUl8HIJbwMnsD
         bkR93Jsh/cjAtDDIsD0P95sakJHpYQ5w/9Nc11BUw6laJPpoeE0LTjD9UXMnriDAcSJd
         vqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738947682; x=1739552482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K89iMvYVIaxnJ+fqwfSq5htV0qyp5rhqJml9Bv4LRmc=;
        b=wlOTV7xzp7LRjVW0JqVrAwK5fgi4MpJ8SMRlkv+CVoIaeAx0LGHLG++a0z+jsLtwBw
         gBpHd7nuS5LCcm/2afVoVVHUzd+9c3M69b3OpGZ/+yWOFcK9ogxmHev5R13IZHVIJ+6n
         FqKhl/ypdHFEIH+TlIRES0i4YXycFhemONjt7P1TY8+KrNBxwtosZK4AXvLMoctiChq9
         eiKucjdBKQbAHHfd6i6Nb8pFuIrXaTxaMQkkEym6twTaNTkv+dD/lHheZjvcW/5yRHmH
         ySoWm3D2WiQmuQcDJTkaj3wVtIbjmB/ZmEeT8IEswk3x8OORvfT9Vh2ycm0hc2oFyQJO
         HNcA==
X-Gm-Message-State: AOJu0YyN/6dxOtnCmOSbUvsmNpUvem75+ayqECi0xySkgNcu4/cQKBZ6
	Gvps58AcOyXsnm16pU8esNmTf0nKljXD/xyB0JU4QUimhRAoW6ZXoJzlwFZS
X-Gm-Gg: ASbGncuDgroms/VoNQqVJBMYJaNJbfegeDwYCJ1ejek+1M02D+DpU7PSX16y4awNgtj
	OHaZskyJyWLuXlJAJH0GdjLDAdWdSbvL25F/Fqmghh0mvVThY1bgSwVHEcorNrioKIwL4WRH16a
	k4jid0OCO7ZfewDWmU1wS5I3N2hOD1CltXGypyLtwLpMjI6l6xwVFjZ9jb2N/8V4CC3SwdTDjuD
	sFO5AHF9Kq2Qdhr2TC7Rsz9kNA4Ll8ShWGRgODKFOO9sz9Be0WU3KnFOnIdZATJ+1WB3JlqhVkR
	CBD9HFRSBtMLJC8w958+2Nvq7cRiGoC+F1xNXg==
X-Google-Smtp-Source: AGHT+IF5BRP8ZVTaSdgfXjvwOrWRHy+c662VE4SYxICsiTGZQdfE+n3uVs6MwHFvkcvnnfpnrCmSYg==
X-Received: by 2002:a05:6a20:ce4c:b0:1e1:aa10:5491 with SMTP id adf61e73a8af0-1ee03a8f4b6mr8433182637.24.1738947681913;
        Fri, 07 Feb 2025 09:01:21 -0800 (PST)
Received: from localhost.localdomain ([2405:201:5c08:585d:6eb6:f5fb:b572:c7c7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7c24sm3243338b3a.78.2025.02.07.09.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:01:21 -0800 (PST)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: linux-kselftest@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH] selftests: net: fix grammar in reuseaddr_ports_exhausted.c log message
Date: Fri,  7 Feb 2025 22:31:14 +0530
Message-ID: <20250207170114.4585-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a grammatical error in a test log message in
reuseaddr_ports_exhausted.c for better clarity as a part of lfx
application tasks

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 tools/testing/selftests/net/reuseaddr_ports_exhausted.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/reuseaddr_ports_exhausted.c b/tools/testing/selftests/net/reuseaddr_ports_exhausted.c
index 066efd30e294..7b9bf8a7bbe1 100644
--- a/tools/testing/selftests/net/reuseaddr_ports_exhausted.c
+++ b/tools/testing/selftests/net/reuseaddr_ports_exhausted.c
@@ -112,7 +112,7 @@ TEST(reuseaddr_ports_exhausted_reusable_same_euid)
 		ASSERT_NE(-1, fd[0]) TH_LOG("failed to bind.");
 
 		if (opts->reuseport[0] && opts->reuseport[1]) {
-			EXPECT_EQ(-1, fd[1]) TH_LOG("should fail to bind because both sockets succeed to be listened.");
+			EXPECT_EQ(-1, fd[1]) TH_LOG("should fail to bind because both sockets successfully listened.");
 		} else {
 			EXPECT_NE(-1, fd[1]) TH_LOG("should succeed to bind to connect to different destinations.");
 		}
-- 
2.47.1


