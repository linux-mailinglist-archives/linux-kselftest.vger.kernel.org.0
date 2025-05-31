Return-Path: <linux-kselftest+bounces-34098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAC2AC9953
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 07:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157AE1BA4023
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 05:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7050E28A1EA;
	Sat, 31 May 2025 05:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfCgZX3G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62E11096F;
	Sat, 31 May 2025 05:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748668258; cv=none; b=LmJ7QzMqrh/IVGJNq2O9yGujIoKNCnoGLg65anQgNM7T6A1n2uDgO8v1WVSsj/CWsk1SrlDUuD4bvhRp/7V3egJ/kj70D8yXC4Omg+27hIhR/sGKF8uj4y5LL6LcAT152jyt/juC6h/QVGvV7xU0QtuEp2RzmQlL/aFjn166NK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748668258; c=relaxed/simple;
	bh=Q/3NgC5YAv/sLlRho9eipXhR4jPMKVejH7/5YMH1zLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AiSENV0nQ2uk11r9lL1uhmHxSKg/vThVD8XE/QvnJnKJ0DjMKmdNDeyP2a0p1Eprtwbx6TvfcFbW7IJBN0p1ewX7OvuNM/v48ZZSLJ8i90qkzsLKsZIhUEbH275quALS+4nENUONl4g/DE7ZaIM/fH/y6kyCGReMImnNvT6LVxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfCgZX3G; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b2c41acd479so1856364a12.2;
        Fri, 30 May 2025 22:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748668256; x=1749273056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mU0qbiJgr9zua+cBR3kFzOAUJVTnz0mj9Ono3++R7a4=;
        b=hfCgZX3GAcmkT2IA9Todqy/fEuMBp7QgqM5TAjdXLuZSjeoPRHlmSHoJtBUEHM2zpL
         pCyyJemsbaFOzXF9/vXnHxsvXPfqLNkJ/96KeEsi0LmfTVAjfh+EfH5BV9otLgSFdvGq
         TSWBHcvJ/O/z2yjsd6tSDH5i0T2O611gs0Kh+CsYkdUa3pb/wSpxZlfFYDCDP8sQwTjx
         Bj+2r8/pumpQRUZfL53co7H8svB6b++BZ0craVpkO760/A1LtHfV309eHRwVDKMawzYp
         J2tvrLkceBNMNDpOrqg72Nbr0pTXRGCFGYzHudAwi1OW3EZ3gfsh6nMRNFJR/YIjHzR1
         RCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748668256; x=1749273056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mU0qbiJgr9zua+cBR3kFzOAUJVTnz0mj9Ono3++R7a4=;
        b=DpqIvwsMYFPpGi2ocP7bPC8bBIVl9V3fUW9xye//31sTawZ4BFCwSphO1/Kg3jl+72
         /H8kvJQg/y1ZBC4gOH2vUmYLjpUsv6g76ATej9TXHU3r+C9DQg2085vHkMAe3p9V++/W
         RiEJLyMHU8clj47/sB7Ow2oWgcXqnlDsyK6Gt9AP2LOySUGqh8DtIGzyTKLeeN1rNsBs
         t7QCmJU9Nn9n0U11VMusWw8eyDCd2K5otpQYGc5e1DBFMVnKD1Ea/SwJ2vuYrJlLf7De
         MdeBdW1L7npXJjxhOkgckmoVdfCeCq+2q4+QQuxKLCIcuiZL5JyOWQC9XEmQ8NHvi01a
         3Q+A==
X-Forwarded-Encrypted: i=1; AJvYcCVBC1dAZOgso21mw0sXEYDKJfeF11p9pm/ESuwxO4lx9nmiCyv79PW6o+6gtpj24QPGq+ZIVTx3o1ID31I=@vger.kernel.org, AJvYcCVZuX6FO7bpLNVbqLOLdMQRyenOw5PC/8Wr6qcRWpwTGxpHHZFujQ3FX2D4G3Fr2OR+g4OewI71pH5C8vcgCWMt@vger.kernel.org
X-Gm-Message-State: AOJu0YyMWCgDhOhPgwYK4Tk8t2kW1ZGnD572Nvuts3NSOB/CwwJ4NSOq
	ktyPefCUXKkrFQR0YBi4iPyNvgxOTLABQVhwLYn7+gwGpbEuxo7MH/iNUU3ipTKu3Cw=
X-Gm-Gg: ASbGncua3GMGYf6zkCUUzy1SVAWRVeAELCEVbyLWDgoU8H2uSWlL+dYitrkAqK0kD0p
	zHLlszTGOWGdcVnCeTj9I3SRvs/Dj0OxwLSRDvC43KiZWTid51p7FJG7xwITxKrcPP2LTpfuJfk
	2SRzC/quN4j+30uAmKpBzybz8rKAfpO1lirKQp/o9ANYLpBLAGj8N8Lgll+PFKMNUNxePdAErhr
	gtkCa9NtjTM4cYpIhsqjn73FBU7zWWR4CtK2Dk9eNWUIP05woJshBng2CVbD4i623Z4PLjJzo8t
	Tjq61CBe3Tf9DAYkHBZtTjYUI7LEVI/ypjS3xxqAZ19a8uKBqP84Fwy/4noeHLVqDvU=
X-Google-Smtp-Source: AGHT+IF7KKaVbGsmx/RswYFw51WZct5NOZ14VEoN8FMOS4cHviEpTeI3GVxjG6n7f1TM0qV2ZO1J1A==
X-Received: by 2002:a17:902:d58d:b0:234:8c64:7885 with SMTP id d9443c01a7336-2355f784ab6mr13423525ad.53.1748668255766;
        Fri, 30 May 2025 22:10:55 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:1655:88ee:e7f3:487a])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b2eceb297c8sm2291117a12.26.2025.05.30.22.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 22:10:55 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Philip Li <philip.li@intel.com>,
	oliver.sang@intel.com,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net v2] selftests: net: build net/lib dependency in all target
Date: Sat, 31 May 2025 12:10:39 +0700
Message-ID: <20250531051039.6561-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have the logic to include net/lib automatically for net related
selftests. However, currently, this logic is only in install target
which means only `make install` will have net/lib included. This commit
moves the logic to all target so that all `make`, `make run_tests` and
`make install` will have net/lib included in net related selftests.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
Changes in v2:
- Make the commit message clearer.

 tools/testing/selftests/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 6aa11cd3db42..5b04d83ad9a1 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -205,7 +205,7 @@ export KHDR_INCLUDES
 
 all:
 	@ret=1;							\
-	for TARGET in $(TARGETS); do				\
+	for TARGET in $(TARGETS) $(INSTALL_DEP_TARGETS); do	\
 		BUILD_TARGET=$$BUILD/$$TARGET;			\
 		mkdir $$BUILD_TARGET  -p;			\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET	\
@@ -270,7 +270,7 @@ ifdef INSTALL_PATH
 	install -m 744 run_kselftest.sh $(INSTALL_PATH)/
 	rm -f $(TEST_LIST)
 	@ret=1;	\
-	for TARGET in $(TARGETS) $(INSTALL_DEP_TARGETS); do \
+	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install \
 				INSTALL_PATH=$(INSTALL_PATH)/$$TARGET \
-- 
2.43.0


