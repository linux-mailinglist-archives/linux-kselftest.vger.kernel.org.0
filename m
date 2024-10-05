Return-Path: <linux-kselftest+bounces-19086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45EA991477
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 07:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F931C21F40
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 05:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353144B5AE;
	Sat,  5 Oct 2024 05:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ed/n7f1B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F42538F83;
	Sat,  5 Oct 2024 05:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728106190; cv=none; b=KgdC/nm6MrbQDwYUi758xIWwLXLULX+ezY6jHxiugF3s080kqiccxumKoPchJmNv2l1sHQAKI9/AGVVOdPygjuTSnLax8QBwefefpgQ+b1zik31QYOHAjSH/BQMMUu5qtX0hFbbR/x1wZ7a66pymi0TaxJNhNR6kwPO1PnoboXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728106190; c=relaxed/simple;
	bh=lM12Y+PVWbIVjbEYFSGMppBuQG4xpTvfxfd2/7jNf4s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QCjCOHPKlOi180y09wT5mgv7udK1Fxv4tnHXx0BHHgUl1TammCGpEnHIEUlbSQqiYT0G0tBYaY+/1FfS5jL6KprkyaBMZzZw8UKfpJDiWHU8/eUmWUM83h+TS6LZXreXXNstcDMpKNCGOu5L2IckzmQTkAeYCdvl48uL47f6jZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ed/n7f1B; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso26850805e9.0;
        Fri, 04 Oct 2024 22:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728106187; x=1728710987; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cezS5WqQoRrzltU/78vgyz+Za+pNv3jbvKTQSP+KMnU=;
        b=ed/n7f1BNa9gBbYw5gtIjg5OCBqZrYDoechrFh39l/vAJMK3S09oWzi9FitFbzAeGl
         Os38iJolAUnmYfmlvfhmPWfO6qZFVCmhfRZdeq+UTUXEX3ohoXkqkPzFOZXUdwAkqByU
         1R/hzNL6wITwtwViNKISok7OAcoZpvX6uw0DhlyXRXnMi2H2+1iPVLGhgFoOS09D3ZEb
         l2TAu07sCdcj8hFo9c2J/A+WO6O4B3ctQvY3LCDI56kEyoDFUIIX9Y/QxG1GA7JrzXGt
         dqR2rCGwiSHeMwTLCmoIz3eW6uLnfz16h2Wr8vf6zpQHnxvOuzUYat9vgiVqmNEu1QxL
         Av5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728106187; x=1728710987;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cezS5WqQoRrzltU/78vgyz+Za+pNv3jbvKTQSP+KMnU=;
        b=u25tsNoEazcxvqBJcmQDodHqAWa+W1pf+S9l+dmUluWXKiq2rwA3Qm+EQMjkPKCJnl
         +PVGRkpTGpr3xektr/tGDjz4vIIUJNumaqJLHFj6qEae+q1KJxOFdmyvIGX3IiS/9+NI
         sl1gxi2iRr0QFbQw3kA+eGv6ImhpwXV+EJi8MLWnpTvzHbXSKRcx1DWbUWJDpua5jYWU
         vMceSFVtEQr2sAHNnit/3By1VjaRFF5ggGdshqbjoPTpC3A5KsDOf4BuQ+bfNq+MyRam
         pJoq3i3fvRcevKpPNfdU3VUTLblwHM3ZtVAOKVwmqeLd4vSBetwXSheLbPkTcanr3h1+
         R7Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUxlBZ7Pk1ajPPXqcJDTCQTTP/DB3FkUylapgNjuDXQ9OyGrbudsbDXXDhwVRFbUH3A6sw36JbgShEBiQ==@vger.kernel.org, AJvYcCWHQgxORJYZG2LSN5IQzWK6x2X2ae9quFY09b83uqjfzB8jVM2DuaJoPHRGd7Kh8IzpDh+yyXDqXcXXy3Y=@vger.kernel.org, AJvYcCWSwX2bKGSLOeK+/GRilWV3s/UtsnA2uDns+vh7c5c9Hhm4DRlbw2UBB7IfiCgSTWABpueFoi7Ns2EopOnmmaHD@vger.kernel.org
X-Gm-Message-State: AOJu0YxBdEXszEyeZQlGyHSc55w224EB38nwZBmo1a5YtvBaPjlPqV+s
	Arr3/CADATgcTSfPe+ZpfXbv9hhD93WDbrQ855kxIpWeMcNWDXHd
X-Google-Smtp-Source: AGHT+IFyg01Usy09oOmEfGGEspmAOO/Bl2UKeqMaKZgpKsxwJKNXeA4Kkty9DRhG0y5aZYXJxKQp2g==
X-Received: by 2002:a05:600c:5804:b0:42c:b1ee:4b04 with SMTP id 5b1f17b1804b1-42f85ae918amr34911575e9.28.1728106186329;
        Fri, 04 Oct 2024 22:29:46 -0700 (PDT)
Received: from [127.0.1.1] (ip5f5ac341.dynamic.kabel-deutschland.de. [95.90.195.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ed952asm13103105e9.45.2024.10.04.22.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 22:29:45 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH net v2 0/3] selftests: net: add missing gitignore and
 EXTRA_CLEAN entries.
Date: Sat, 05 Oct 2024 07:29:39 +0200
Message-Id: <20241005-net-selftests-gitignore-v2-0-3a0b2876394a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMPOAGcC/4WNQQ6DIBBFr2JmXRpAMNJV79G4sHbESRQahpg2h
 ruXeIEu//957x/AmAgZbs0BCXdiiqEGfWlgWsbgUdCrZtBSG+laKQJmwbjOGTmz8JTJh5hQqP7
 ZGzNr1zoFlX4nnOlzmh9QIRhquRDnmL7n267O6a94V0KKzmptx95aZ7q730Zar1PcYCil/AAZ5
 NVYwwAAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Allison Henderson <allison.henderson@oracle.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728106184; l=1165;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=lM12Y+PVWbIVjbEYFSGMppBuQG4xpTvfxfd2/7jNf4s=;
 b=Q0cK5x2ObhU8Y+UlH9imRYK+xSig0v1Ockl9buoou10l30xzbqeLhmAEyfoDqrw5SVIdRD24q
 yEzwaXRw6VpCxZdl3TyT+ecKHxwadY29zHfg6lbhahYt5Pqjm4IR3zd
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series is a cherry-pick on top of v6.12-rc1 from the one I sent
for selftests with other patches that were not net-related:

https://lore.kernel.org/all/20240925-selftests-gitignore-v3-0-9db896474170@gmail.com/

The patches have not been modified, and the Reviewed-by tags have
been kept.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- rebase to net/main and solve conflicts in rds/Makefile
- Tag series for net.
- Link to v1: https://lore.kernel.org/r/20240930-net-selftests-gitignore-v1-0-65225a855946@gmail.com

---
Javier Carrasco (3):
      selftests: net: add msg_oob to gitignore
      selftests: net: rds: add include.sh to EXTRA_CLEAN
      selftests: net: rds: add gitignore file for include.sh

 tools/testing/selftests/net/.gitignore     | 1 +
 tools/testing/selftests/net/rds/.gitignore | 1 +
 tools/testing/selftests/net/rds/Makefile   | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)
---
base-commit: 9234a2549cb6ac038bec36cc7c084218e9575513
change-id: 20240930-net-selftests-gitignore-18b844f29391

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


