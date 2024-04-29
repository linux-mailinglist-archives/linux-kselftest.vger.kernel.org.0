Return-Path: <linux-kselftest+bounces-9057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 036568B5F62
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 18:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65B69B20C43
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 16:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECB38612E;
	Mon, 29 Apr 2024 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgnxoZev"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF28D33C7;
	Mon, 29 Apr 2024 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714409511; cv=none; b=PjKvtG1Pg5joiQMpVhiDpsV8mGIxEOIZsaUoz1Q0pdk4TjnEJ53q1U1T4sngh5aMslWvlj/lR75EbtlfFwDrOEpePyjn43U4KGpJgontIqAGg04Cgg1X38pgHzYMgzDCZxR9VJV0OyoSzoRIEMP8Bfop317KKsKpX78sdvaUzrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714409511; c=relaxed/simple;
	bh=QJLySMYgKPWaWMPyrh9HHankw97JNTA7XxHF8MoanDU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pOG++BM63Kf3fSSGuJ4TepB3I1v4HevdIeeCh1TXwwxBq9F2wh0x77iNlxxx1ii6fF12NvqCL+a6DM4JOP04Wl9kX80rGXVD7n4ybMwzQ6b+KlNyVLPdonThGfP1Rl0NtKhv5Vcnq6YSatutVAf2LLTrWYud6xG5ut/1PcUhH/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgnxoZev; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2b24dbd1bb6so289643a91.3;
        Mon, 29 Apr 2024 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714409509; x=1715014309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xFhiFPiemiTSARcy05czXiciKI4zhthcV3gzUyhyfZo=;
        b=cgnxoZevKBHCWyO4V0kUqkFjvWflm3ETUDKQMYGaRRhRjeXkFLoZU/xhGr65VkM+UX
         lqmCi0Jod8H91daMj8lZZEztamwFaH8yYHfRqf0cXik7yB+vAWnUqgeX/p/IXAk3k6uP
         u3T0+mG3NkfAV0H2+AI3niAQZgS9Osr1QYJsj8bIrj7OYMGkdplAeUO0JUVG5MrNUzrY
         vD4p62tdNkBWwaAPVzMt2MvLISAruivZcLhDVn8aP7FC9097q3my8GuwdVPtHdajYX2F
         d6GmBd/TRYUgPyymajazWZqVLWyGjEe0cunyj0uADlD0VJIXUMUtjLMY1c76dRcYsHLz
         q5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714409509; x=1715014309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFhiFPiemiTSARcy05czXiciKI4zhthcV3gzUyhyfZo=;
        b=bDUI2yh46XysM2CCS7afxGidMluOAMVBWLG0O8eoY+zDzNWlrptOAk8+JPS428OJPm
         EmR/Oe+OD3Oxl2bb1QgVRg9xNQkANRyKRJJLAzkL8VmC2bLFiS5pEUXxL27jYqJ1bL01
         hcp2KFSqcMckPh7mHfmt7PbTT0rZGUuCYteqYem2cMuZoWA8OthZ/8Bx0SXSJfs+E6mh
         CpdWRq6J2vGS5bHldkuHM7+UuW3otfmw7MHfvczE1mr1K8fxLFIFrzBCknnF6q5GF7Ys
         G2yczd4DewsbD0Y//mOcBvJaGr34LKGkDUMrDrVjLJ7execS77kfiOqW/A3FYaQciCXD
         G4Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVkLgqOEF1Y5RwHzeWepPSJHYtwEwv63XClKiT/mSmSGerPJq3DlV63xRcgG4QLWzo7LPv4a+Xyy9pLe73oohSeQP9P8zd+miMVL6H6DoDYmllJZY5zT8BUQu4MvklXA2fPJyuoeWfdMy3hZlg+0kOCVPSWTpbP9+Bjm8STXvVwi5ZgZcfJ5dwq
X-Gm-Message-State: AOJu0YyN7GuVWv4/UDTbwgbp72xZwZFuDAXu95We3orKZY2HBE1z9Qjd
	jLXFO6zC8QIYR9KolmSkIF6Sg0Dzv/ZVLqZoSCAupLZBMJSTYxM3
X-Google-Smtp-Source: AGHT+IFTHhZzxxN0MM3ENYoF4u8yyFHcB9HiImRHm+ynCmr7bAYBJup8q1ytVzkGxYOxHJRUEbZB/Q==
X-Received: by 2002:a17:90a:2f21:b0:2ad:eb55:2e39 with SMTP id s30-20020a17090a2f2100b002adeb552e39mr9524317pjd.49.1714409508881;
        Mon, 29 Apr 2024 09:51:48 -0700 (PDT)
Received: from 0xff07.hitronhub.home ([2407:4d00:3c04:80be:64cb:3685:54f4:1445])
        by smtp.googlemail.com with ESMTPSA id p7-20020a17090a348700b002a55198259fsm5322473pjb.0.2024.04.29.09.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 09:51:47 -0700 (PDT)
From: "Yo-Jung (Leo) Lin" <0xff07@gmail.com>
To: skhan@linuxfoundation.org
Cc: 0xff07@gmail.com,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: kselftest: fix codeblock
Date: Tue, 30 Apr 2024 00:50:47 +0800
Message-Id: <20240429165047.16088-1-0xff07@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add extra colon to mark command in the next paragraph as codeblock

Signed-off-by: Yo-Jung (Leo) Lin <0xff07@gmail.com>
---
 Documentation/dev-tools/kselftest.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index ff10dc6eef5d..dcf634e411bd 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -183,7 +183,7 @@ expected time it takes to run a test. If you have control over the systems
 which will run the tests you can configure a test runner on those systems to
 use a greater or lower timeout on the command line as with the `-o` or
 the `--override-timeout` argument. For example to use 165 seconds instead
-one would use:
+one would use::
 
    $ ./run_kselftest.sh --override-timeout 165
 
-- 
2.34.1


