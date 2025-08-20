Return-Path: <linux-kselftest+bounces-39396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5999DB2E713
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 22:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A831CC2CF3
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 20:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B727D2D9ED8;
	Wed, 20 Aug 2025 20:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUBNLUPQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43E7308F11;
	Wed, 20 Aug 2025 20:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755723529; cv=none; b=Z7t/PHNWgObzIRPVXjUp4/o6ZkS7PKVbnSQAW9g7apWInQz8qN4nf14ClKJ7MHBXn0duNKDS3wcFySm6CVS+LAINwODP2ZUwRBdAuqphnDj077De0Lig71l3XQil4A3Nm0xDc/E1KpgEmXYVAgI93UG6r0mqyduHpWeaQoQMWWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755723529; c=relaxed/simple;
	bh=C9ibzsekJnVBSXwleQs+67Y4Xjy6ucyIUtUkncTGaZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IpXGswqoQYS8SB1KmWlk98SspAZFj1nX03kZGRuOlrAZq0ubDckCo6+vjAUvYIH1EJcHJ0UZ9lh8q7W8nLO6imZyyfNhggnZxFcLkiZcmZV2WPRFWp16leuu9Utm4JKTYznl1XTtzRQRvO0lwe2i1tQs2ZrLX6Au7P2PVOlfN+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUBNLUPQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b9a342e8ffso226394f8f.0;
        Wed, 20 Aug 2025 13:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755723526; x=1756328326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t6Edp73bQQiSNyixqQ0B5YIyV1/7MLtaSk5DDgGwemI=;
        b=aUBNLUPQQDggL7mFsaq9XOrPklfqBmo5yuethBp25HWujuE4Rnj5TeCWsI0JU9yAIU
         2cwjHRl3o+c+bIf3Se2rqjfkbhnK72UACG8uzt1oSuDaJQXi4BqyboG/SrjCyHcOuRmS
         FCSt3Ozs1NcCI6C3V2h9qIfhetSMjZ/XcOrKNncndGOHScgDfQHdbgsHqGaZxTaE5zmp
         O8gR7YT39pTmDHmt27QlzHqphttAJ4IOqggPOyZ2xS2vF4zynja9YO2A3guRkvwFmMcT
         /7F47EFruXhhTy477F/RPdPurVyIn7mhJnk2nlNSOUBtsI63x3J3xlJne0z1cXIrEYRM
         T/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755723526; x=1756328326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6Edp73bQQiSNyixqQ0B5YIyV1/7MLtaSk5DDgGwemI=;
        b=tivdoumtPwZayLqOQzaMsnRjjjRzxElgReLS5kj8Sujau05URrulCbob+tU+zlDwKN
         h15WBZr4jCzwFYArkoYa9KDzWTWDQbQW31+c7Ndb5rPXBDzFrD6Q2+8PDlticsB7dtsd
         9IeyyptSyjAU73GEh6KIiwkHgyzAKsoFa70C6aerU+PznG4/iODJUycOu2amQFE5eQDr
         /21Sb/03G6dQ5eVWa7SK+4m63DnVDQ4fyJ2Io+EWmBuvp06sjwK4N2QERd5SW4jXjCBz
         lmFzYzuON0FcZuSQL2rMggBWkbNOVOSP9gi3XKCqtoftI0xs+DSe4A13MPfhwcyfFrTS
         2tSg==
X-Gm-Message-State: AOJu0Yyp63MM94RlyJlQfzCKuWMfToxQ0NTaRCPiA1KItgJTJgGVMYZY
	B26GIZZnYgv3IfTO/QsKQw1A/pxTIHjXDnmvuG9K1k+0ZLHLS6Wcn4VfXkAXF99S1M4=
X-Gm-Gg: ASbGncu3WE6tRIIhsDCBMkSYsgjRrRUsNRmSw+DgJLUKvVveNHWZe1ta3oHO1foZUxU
	BbrN5xIthpH3Lk3McLRliWry7yD440w5DcXDGsvIhK/LkeQFrCgLGROzRPJUfaMd9R+xz3i6pcu
	a7q21l/Q5KrCPZmrM3YS5k05xEwOsIz0rt7aaermEfosq3X//zRUGz5nxOQEdgW/77pxad/4PQw
	sP+VGEQoN9mhPyT1U5jXbvwXFvBekO/Q6cv3VNn7MApP2oQV8gCVrW7UC7PrfprUq3RTM22xXuR
	i2qwySg+4JfN2xBnZBi2fPqlbOUIOUsG8j69zmJ4msnhqSGusiRpbxslhJ8iM5cAmxzBGBicepN
	WsY80hGk9xfT0ALL0PyxfgRdgD/jkG4A5
X-Google-Smtp-Source: AGHT+IEEMvxpVzbgukpXq+PGYJJ5lV3rWBOBws9imBFzkyPoncfpZFKpE3Fffh0jmdp7St/8AngReQ==
X-Received: by 2002:a05:6000:2411:b0:3c4:516:bf62 with SMTP id ffacd0b85a97d-3c45e6322cdmr653237f8f.6.1755723525705;
        Wed, 20 Aug 2025 13:58:45 -0700 (PDT)
Received: from moktar-desktop.. ([102.31.181.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4976bc73sm45779575e9.6.2025.08.20.13.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 13:58:45 -0700 (PDT)
From: Moktar SELLAMI <smokthar925@gmail.com>
To: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Moktar SELLAMI <smokthar925@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH] selftests/powerpc/pmu/tm: fix typos in tm-trap
Date: Wed, 20 Aug 2025 21:58:16 +0100
Message-Id: <20250820205816.23146-1-smokthar925@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistakes:
tmp_trap.c:94 te -> the
tmp_trap.c:96 tread -> treated

reported by: codespell

Signed-off-by: Moktar SELLAMI <smokthar925@gmail.com>
---
 tools/testing/selftests/powerpc/tm/tm-trap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-trap.c b/tools/testing/selftests/powerpc/tm/tm-trap.c
index 97cb74768e30..298bd09c55bb 100644
--- a/tools/testing/selftests/powerpc/tm/tm-trap.c
+++ b/tools/testing/selftests/powerpc/tm/tm-trap.c
@@ -91,9 +91,9 @@ void trap_signal_handler(int signo, siginfo_t *si, void *uc)
 			 * LE endianness does in effect nothing, instruction (2)
 			 * is then executed again as 'trap', generating a second
 			 * trap event (note that in that case 'trap' is caught
-			 * not in transacional mode). On te other hand, if after
+			 * not in transacional mode). On the other hand, if after
 			 * the return from the signal handler the endianness in-
-			 * advertently flipped, instruction (1) is tread as a
+			 * advertently flipped, instruction (1) is treated as a
 			 * branch instruction, i.e. b .+8, hence instruction (3)
 			 * and (4) are executed (tbegin.; trap;) and we get sim-
 			 * ilaly on the trap signal handler, but now in TM mode.
-- 
2.34.1


