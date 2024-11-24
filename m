Return-Path: <linux-kselftest+bounces-22473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FE59D6CF0
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 08:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCB3161536
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 07:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED21D185B76;
	Sun, 24 Nov 2024 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbXnN2kZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6C33FBB3;
	Sun, 24 Nov 2024 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732433581; cv=none; b=MFZR4EMzKuihtw7WABxr+tUY+JHAStlS+xkotjQ30YHXzwJa/rcYr4RZtSJ+TAbRbV9+HfzkUYJUhWXEN6Vnq+FKGrQOJwLySg/RYzqUOktQLXlbmA4Ga7FdIViWCV2tCZmTnQCaU0xRLJhUZHr8/xT1bJznIUyDjHr3IhAeUng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732433581; c=relaxed/simple;
	bh=U3pW/br4mPdRA9g2qa3TF6acrn0LRv7kMOPVDiNBhIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q7d66sbkJRUmIN4yPXvcrVgPtHzMA/wkuXY7oE1pKV4RqiamrMOTOA8rUg/obACIzfzQxTUhHDAOBP5+hYoF1q869Yw/YsQ3EqWLqlV3BvM5zzBbMww+YuRcjic+YTuz+QobtnnohjXoer8OBM3Ci+HufqqNByEXGMR5NwkdtwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbXnN2kZ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-212776d6449so37714585ad.1;
        Sat, 23 Nov 2024 23:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732433579; x=1733038379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/QrxvnHLhHHbClsG+fnoj3DaRzMXyXEa249hcftSwf0=;
        b=WbXnN2kZHQgohVZjHoBhpf/ai18NKYHovDgExac4Ec2nObUJipJMaX1tPF2u2ZjqnS
         +9llTuYn4JQYp68EjftXFtpjeTDJPCd+Et+ybJ2Mggz+I08n6LHz9A8HxbDXKG79HoTP
         tUi81bKz+LHmP5qyR0xySthjKF3JSOfDlys++roC6IDIQQHkUs6z+RHbheNZ9n2LsXsR
         iifvuS3d46zvpy6FdFE9dB1Kwg31QQApD4HVTJ3JKK+luyvqQhncausjd00vXwhAeZTJ
         CF1xL49te1kwS++kDLAMsG3SpubB0mDX198y50e/Tx2yS/GmAj9B0SIb59PudZ2rn+38
         +CHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732433579; x=1733038379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/QrxvnHLhHHbClsG+fnoj3DaRzMXyXEa249hcftSwf0=;
        b=BQfV+wL/BalN/YPBll5TXlk7N4nJmfHNsBKqRvjDCNAk9Reiw6jXmDq/RbiTh1Vhhf
         z8B78F9ja3PBDP38lXylcuE0fAtm63vosfXjuw6BNyJ+tX2CfKS2vl2S5LjskYc4qpSH
         cHOfHEjNL4j5jfi9oYDKpNRlRxj48DFZbqTOvyc8k+F6OMWjXo2+2QicndTzr4hyYdNV
         xln4xzgnVPf/8YP0zuWWgL9q5XWT0KTajBzqSuK79xvAH8ocJOptWzCSHcDGuaUOg9/w
         obvwFofzs3XMgpEEGZ65T6LWxF3com7DISdNSyXOa+Y95NeHDSsGeBERR8CpX66QIyvH
         OJgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4MdLZ9fV7un8C3gWyATQuK6Om5eUwRzZLsBTrShYz67GlhyTXR5zNYMsiQPsUXL0oesLeIuqHMhFjkak=@vger.kernel.org, AJvYcCXEHgBH3DrMBlfwZxflGwiK1wx+ddMapv77BpPDgaG7ZAPvhyWbSTuxEc6Wkur8lrx2Ok0D58zvfxM7Rm7XT8eH@vger.kernel.org, AJvYcCXf0NWgK22BEN6LDzs/FocQGreSuEjs5GeUOqO/2rNGdBPmMlCqu4qgilyLYMAAKT8BChv0NR9x74lG3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YynRnPwoLzRsesCip2p0Cv0hZWK252GQx5H3jFHm/q4zPyRccXV
	G/TYABz7ppooc2rmSas3mpOzERX/+vT4nene+j2e95g4ch1koHidZ0d57n+Ldp0=
X-Gm-Gg: ASbGncvxwHl2MT53+2l3rC0uVGV3LECo30W7ep2qeA6LrOzo5nZwFJIO+tiPzhpz51c
	wXv0PL+JolNnWqgPhjK8C2QxlDecLYU3+JnGOTpSyEBXFkqPbpbi1PifbvxKJtO9tYdyr2IBdYG
	Q43oWJydY7056wTvpet1DTzFwE8EPj2ZIcwDFBSErIHQ3FVdVoaQ88N99Wr8w7tvt96tcOqEQZU
	241DgVy+rl0aS+iKyy5V3brP2dx9i7KrEcCfKfulvkPw4+DD4f87YrJbD81IBvnNcI51Q==
X-Google-Smtp-Source: AGHT+IH5VX8VLwH3q/3mONS3hSvP67LvADoIcPzqcrl1vByLw96QkSk+U2+gV5pEhf13xbrM09Cb+g==
X-Received: by 2002:a17:902:e80a:b0:20b:bd8d:427c with SMTP id d9443c01a7336-2129f55a11emr108317305ad.23.1732433579276;
        Sat, 23 Nov 2024 23:32:59 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db8c881sm42838605ad.13.2024.11.23.23.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 23:32:58 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Allison Henderson <allison.henderson@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Maximilian Heyne <mheyne@amazon.de>
Subject: [PATCH net] selftests: rds: move test.py to TEST_FILES
Date: Sun, 24 Nov 2024 07:32:43 +0000
Message-ID: <20241124073243.847932-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test.py should not be run separately. It should be run via run.sh,
which will do some sanity checks first. Move the test.py from TEST_PROGS
to TEST_FILES.

Reported-by: Maximilian Heyne <mheyne@amazon.de>
Closes: https://lore.kernel.org/netdev/20241122150129.GB18887@dev-dsk-mheyne-1b-55676e6a.eu-west-1.amazon.com
Fixes: 3ade6ce1255e ("selftests: rds: add testing infrastructure")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/rds/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/rds/Makefile b/tools/testing/selftests/net/rds/Makefile
index 1803c39dbacb..612a7219990e 100644
--- a/tools/testing/selftests/net/rds/Makefile
+++ b/tools/testing/selftests/net/rds/Makefile
@@ -3,10 +3,9 @@
 all:
 	@echo mk_build_dir="$(shell pwd)" > include.sh
 
-TEST_PROGS := run.sh \
-	test.py
+TEST_PROGS := run.sh
 
-TEST_FILES := include.sh
+TEST_FILES := include.sh test.py
 
 EXTRA_CLEAN := /tmp/rds_logs include.sh
 
-- 
2.46.0


