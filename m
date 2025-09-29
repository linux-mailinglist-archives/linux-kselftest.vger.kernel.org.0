Return-Path: <linux-kselftest+bounces-42591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A75BAA04B
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 18:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C3B37A1F17
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 16:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EB330CB47;
	Mon, 29 Sep 2025 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ig8KDxvO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8990519F13F
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163512; cv=none; b=MW8E2eOHyizHkCIdB3XzWASa/SFIhmenbK5hRlgIQO+SGrItlUJMNYeTfQhFPVJ7CHXzGXLF9YqRS7MMaZY7rm4kKrjZZhrIT9bOzf477cTIUOLVzEEgRuF0iglYa6T2LTBBvQdC+aBEP8X8N4t4Iq5CZs/0x36biub86E/OUJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163512; c=relaxed/simple;
	bh=nTErp6MjM2H9FJt5b0VdfDXyFtxk1zguj9gOTg/Op1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h36ah0lF4tYSRguqi2ekLntUkP5/XqMuvwclg4ElbvBGU5rs1ZiNGeMQKp+jh2/vltKlabZJM4EouiTgk4JbXFOU4BzWJVEVKN4oqqo12G4W2auhnMf2rVK0cIYjU/Tq9IwJz289ckygtC+arPg9amAXHwloJ8DTuDI2O9Ud+ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ig8KDxvO; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32ec291a325so3790244a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 09:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759163509; x=1759768309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lka4+ZyxLfYllS696TYLXMts9dTS83swxEi3cmvk4F4=;
        b=ig8KDxvOg2N8ygrGO+MRxh/HOl/sue8Haw+ylPPuB564h0nVSAKa/bjPrWHhmt3Cdv
         ZDTdp+QyLn/lykIBpJI8m43f7p9M98JyyboaHFGYLXSnsP45JCmAIPFv/QTMSJZIqU0k
         CITqCeurdTd/d4Ap/ArWbYIXhmD83GU6JPvRsx4bNWC8PGkxIAYApmH01ybIM2303SJ+
         5njQ8AbGw9ry2Q82uy76+b/9OEfIvOIiHQ0WKhM2UPBB9VDBrMLd061fSreNT7eE0VHs
         lDHX2Bjnd6ZRRQWN42EEhI+AyaSBxKraXS+96NBtvIOAc2tY3TC/dFD2SCwr0XJUSOdC
         GAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759163509; x=1759768309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lka4+ZyxLfYllS696TYLXMts9dTS83swxEi3cmvk4F4=;
        b=NwxpNKD26N3V4uYzlVZVIx3h0r0JuIX66aI6cwi/08CPd5DgbQF9o+ECkZ5aF7kQSw
         B01mcqc/gB6OQLDl9t2jTtOPUHEZHO7uM6d+3TYBfFcDT6wOeLKOclYJlrTB/8i1CqdD
         xAOyxhf4zgZ/BP/ILShe5l9uoUaYHPzUofixZxO9Hye+Gsx6yqr9OQuoJ940r6wHN/VE
         3iA0vA7RbQr+SECDdBlNAVmtMBy0BvTE8OWqUbXXVLfTgbcURCm1RxLU9HIaRG+ZrISb
         TOtv3b5XqR2Q19M94Uws2FE+CKBsV2NGUFs3a5hdia7MhlDbVo1OaaRbljBTaCL9SDT+
         snRA==
X-Forwarded-Encrypted: i=1; AJvYcCXcQEo8azLhVoCVhnIs62kkLXg3mR1YWtnn/bzth1gMOS/nJ+yW0s72Ifg2UJMw55/oOhEsb3TcyGXdFLVnLP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7a0O4+H6xf84m2YqA1C3CZSBUOIPzt5B5dudMTuZorNFGO2Zc
	vSpMEyMffEGi0aPH6OXNvNdsp47PCkZJNQdW/q7RLl2AwvZehf5VgS4N
X-Gm-Gg: ASbGncvrBPI4LRtzkm+sc23zxg2nr/2sKCG2MnNubrh297F9AAmUk1kchQADcLThOBj
	3uJgVWT0HUmoS15o9CZbf4ayedIgOrkLfbh0RkvBRo1eSOFigxWGOIHHDj4cV13TB7rriM6rbtO
	E0GHYnRWlsz0vFra0TUdzOdJPBBqCxFiL5hn4MQjMS6pXVDg8RMhRGZQqMUemRW0QXFKNJhg65t
	BbNclwYJgYVCYBDP5aFOdJBB/T5yH0xC3w502lgCn2hn7GKqCgq42aaJ2I3Z3avcQQIbZNM6qZP
	Qung5TAxLnri3jfEaWNmtVHsT9TL3YW0aUiLNPF8Ho2H0SiDgZYLpPtnANBRg/DmpXF453lQph4
	gfUPPE0GFNVrIJJ8cqttzxSN3Yne1OQVCnSBOEfFZ0uwrXs4Y0BeR
X-Google-Smtp-Source: AGHT+IEZeT16n1Qx68AceriYoS2m5DQH3UD7/ggp2pq32iz566aW/AJGDTJkg6J0/p2eGeMqMpos2Q==
X-Received: by 2002:a17:90b:350c:b0:330:6c04:a72b with SMTP id 98e67ed59e1d1-3342a2498f2mr18362711a91.3.1759163508737;
        Mon, 29 Sep 2025 09:31:48 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bd90327sm17674419a91.3.2025.09.29.09.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 09:31:48 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH net-next] selftests/net: add tcp_port_share to .gitignore
Date: Mon, 29 Sep 2025 22:01:38 +0530
Message-ID: <20250929163140.122383-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the tcp_port_share test binary to .gitignore to avoid
accidentally staging the build artifact.

Fixes: 8a8241cdaa34 ("selftests/net: Test tcp port reuse after unbinding
a socket")
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 tools/testing/selftests/net/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 3d4b4a53dfda..439101b518ee 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -52,6 +52,7 @@ tap
 tcp_fastopen_backup_key
 tcp_inq
 tcp_mmap
+tcp_port_share
 tfo
 timestamping
 tls
-- 
2.43.0


