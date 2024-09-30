Return-Path: <linux-kselftest+bounces-18670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4797D98AB29
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 19:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796EF1C2340A
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 17:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B4D1991D6;
	Mon, 30 Sep 2024 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR6J/gF7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA18198A3E;
	Mon, 30 Sep 2024 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727717665; cv=none; b=hiVnPCLW0Jf4liu0/qzmsOLufINe8ik8Hdt/MRCI5JbyZJ4GN0iskuxtBjB4+oCQxKvPjyl6dRovhlr//XiGV2g455BSzWjFTB6X70lqTdPdG2s8XlnzT0CT1FojmPI4DKAX8LJUXqwBGq0ktLb2qGMCc4GejBrjdWmyQcgXtMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727717665; c=relaxed/simple;
	bh=xNHnyhJFePMRWD0xmlV7oaH2NuiwOtkciszm0bIRYco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WEo+vCUAgf/SBFB/R0Uv3KiTRlrLU7T7RDMoiR1CS4x2bI3zjPhuXZuo+F4qHHx+JdKggqgjtZ0wE9v9P/QqQuxe5kpgPnPmfNODcDkleYYbNr2uV7at3elAbdF1rDsqJd0+XeuOdyNClzlBQ2Fxmg3rnPadBfKhHz47nifaFzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IR6J/gF7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso57329685e9.2;
        Mon, 30 Sep 2024 10:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727717662; x=1728322462; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0fLhVR1VuwGVirwx3qztf7J7hxhejcQybt+qUHv768=;
        b=IR6J/gF7YfVH9hEJgWx9sUvCCw7t3AyFBVnILCw32fWdaKAr6/nhccvOvi0rzVwGM7
         VRZnuqbFqeZ74IiOGESeSTLJN3V6xBQU6ld2ZV2MkMFd+ymUMRUA7rZ21YHJ2AaxotJx
         g4dr3jogFp4oarqPjJroiuK0jHb5GwdjlJmfe+xxBTI7mFRxM3N0vJU2/lx8uitK4iZR
         ZY3pbSDqxxz4oF9jlt4SWiRklVaLpl4vWUn5+RxN0OO6VZnN7hurlk2YdWlLsY/8TK29
         vH0blF0DEOJIHPMv608cj+oCzN6ocs54xfh9h63l7Y19M47T7GXiEFdOelZB9IpE8jK/
         iQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727717662; x=1728322462;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0fLhVR1VuwGVirwx3qztf7J7hxhejcQybt+qUHv768=;
        b=FCUL/wleAcGs7RwaInDv0Z/7nms40vtxlUw6RiZgdUT/JiDAc1ccsf8K+HPBMX94f7
         f0sHFtdwvg6QLL4DlfeqM0D4X6apteLIAEKDtdVvbsLK8PBKCIR7WhW0LqcoCCFay3Pl
         j8fRZNTBJvmzuPaze1cYTAVhoccoAScV5FmxEv+U655L1mQCRmxw0h99sG63GarPSz5g
         ImCIC4VGnz0dm/oUWWHhBnzyJoIjaKVdVTWtBX5es15RSqq/oiYsO3/mYFpr9+J0XN8o
         N1LPeXpddSUtmlSLXdIoontipkw+n4MYbo4CxiUHE6R3qdgNOJA2te8z+V3No+75JTfB
         fQ7A==
X-Forwarded-Encrypted: i=1; AJvYcCUodAEiMmzC1Zu/hXsVPhVZAaUPFubE2/66PGFpYCOi2KXSRr9NHmLYViDbLVHBt241Ib9expkK6302t1xTzWL0@vger.kernel.org, AJvYcCVd9r5Rzx5LmKPUfNvJbrhN6CdxQraZM/1fJV6bZpKBdvlRa52aK//LiRbpBOTc5LVXyqdpktAXrZndikk=@vger.kernel.org, AJvYcCWU5qV6fV6/2NNA6bVJWaj3os7OBuTk9CuPVsU97Ik2r6C//TJ78JE2ZvuCNKAU8v9aiwTUrFEAAVZYuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YziYWpWdlvCwQgG63cM5Uvcd8nMMssW4kdfheCKUKlUdGFo2NcO
	o7Ogg5iTbwzkD2wXxt6S4ANGZI4KdFK1Bw+aK7DaD3Q8cNA7geCR
X-Google-Smtp-Source: AGHT+IELPWmvg2Wbjhkw1fG8uwujsYhXvbdR5djEvHP+eTEY242/owKNHgpAwVdu/9e5r9fJInTMog==
X-Received: by 2002:adf:fa88:0:b0:37c:cce6:997d with SMTP id ffacd0b85a97d-37cd5a8c952mr12644004f8f.20.1727717661871;
        Mon, 30 Sep 2024 10:34:21 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-91b0-e3db-0523-0d17.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:91b0:e3db:523:d17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d01esm9706942f8f.3.2024.09.30.10.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:34:21 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 30 Sep 2024 19:34:11 +0200
Subject: [PATCH 2/3] selftests: net: rds: add include.sh to EXTRA_CLEAN
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-net-selftests-gitignore-v1-2-65225a855946@gmail.com>
References: <20240930-net-selftests-gitignore-v1-0-65225a855946@gmail.com>
In-Reply-To: <20240930-net-selftests-gitignore-v1-0-65225a855946@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Allison Henderson <allison.henderson@oracle.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727717657; l=849;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=xNHnyhJFePMRWD0xmlV7oaH2NuiwOtkciszm0bIRYco=;
 b=wsXr/ablv8P6XLdEM6fY692PKSQ8S5bmeHENFAqjSvmP73mrehfefpBJPErasKU8NKc4bBGt8
 1XH7Oi1/dBTCvIoHzoBDH9iELmLZGTEwOSEJknDb40auLrOaXn6oSzr
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The include.sh file is generated when building the net/rds selftests,
but there is no rule to delete it with the clean target. Add the file to
EXTRA_CLEAN in order to remove it when required.

Reviewed-by: Allison Henderson <allison.henderson@oracle.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/net/rds/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/rds/Makefile b/tools/testing/selftests/net/rds/Makefile
index da9714bc7aad..0b697669ea51 100644
--- a/tools/testing/selftests/net/rds/Makefile
+++ b/tools/testing/selftests/net/rds/Makefile
@@ -7,6 +7,6 @@ TEST_PROGS := run.sh \
 	include.sh \
 	test.py
 
-EXTRA_CLEAN := /tmp/rds_logs
+EXTRA_CLEAN := /tmp/rds_logs include.sh
 
 include ../../lib.mk

-- 
2.43.0


