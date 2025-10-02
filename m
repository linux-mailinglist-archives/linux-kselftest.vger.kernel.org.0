Return-Path: <linux-kselftest+bounces-42675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983C4BB4501
	for <lists+linux-kselftest@lfdr.de>; Thu, 02 Oct 2025 17:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F0B57ADCDB
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Oct 2025 15:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28291A317D;
	Thu,  2 Oct 2025 15:26:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CD0156230
	for <linux-kselftest@vger.kernel.org>; Thu,  2 Oct 2025 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759418801; cv=none; b=rFliECWDogVH6ZR+i8j+n+H86+We48u0O9lNLCEHcqkmZE9ZceDOYa8UPFtvXenlddwtKllqb61rHhoRdMWCZualV01OvXEEWqpvwweyFiEnQPa8PKG9Vs0vEL4Udu7oyJ4DOEHNW1usJHRh76ibdwJNTpA/Muw0imA3DYSUAyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759418801; c=relaxed/simple;
	bh=o97ssWS1XLnkBDbG8UDuOY3aKVcNvG347gRIilI4pS8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pKvm+Bhcn4fcdV4VsTYlA4xg6wp2wYqqWBsM4C+M3GbeZfpP9iPu5S5ERJpguSOBa8gahZgv13/LQgGPL2j+KIRYCTNs6+NNYdkKZG+rrdZ+34xLXn6bx18ihfJ3ayLE8sJca/sjkGbB2Q0RMNJCjewfYu2b+ttQHkoFycvPwEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3e9d633b78so255863666b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Oct 2025 08:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759418798; x=1760023598;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbBEdwOKCu0k96xIOmCVZhuXhz2bKiR0OgCLj9FWUXM=;
        b=Avp4hGFYcyfV8WreAOrebz1vCoi60k3nHbPuSwaYLYXniGqQurPac3KV2AjYyKyHfi
         WJHyvw0M3YJhV6aUdUp4lJkJJPzo/TvjYpV90JhvQXNbm0WqkJmG3NPqGv2yc8ua93+F
         huWn97QsCIAWTvHR68M2k4WSXQ6YVrlZPr/W77F6suRX9SsVn8lAVddaMhkpVzQnbf1T
         3vljBg3wAib3pTCqPmISOWM3LMSr5EehJcU1jR38GpeLD5mqE2OG4lhZc20QTgCTLE5J
         rYvZ9lTWodhrw/ZpD7A9Or+q90L/56d0l9ZiL0PLgg20oWDsa4mfURO8WXl3HI7DaQH2
         gIzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/R1/yfRbBe1mvNkYo2FUOKaFdY2P7YAGbMhq1R0NERVAJfZ/L6BYhVbgnoMRz0rTJZWPpzGUS8E35YE0qG10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqb6uAPcie2YwVuHjxx01fcwVIp9uUeuhVgHIO+Ws6Csnv/yPO
	KepsJw8EPKCMeI54I1jtZjiR9zBJyMAmwhBsS3LFNQy2HJHhOJdOOKrU
X-Gm-Gg: ASbGncs4Etw6ALUaBLdc6v+GvWNn1afBARPhMI2gm6W5LEATk9V7nYb95m63vFVbDka
	yjCGFwMvaiRzIqn2fm2Y/bzNDyarSW22c7SaOmt4bSdw0//ndGw1n335tk3rUX8f1Rh7zW38zSA
	KVVpsMI0Fk/Qd9a8jPuq+p+8Hbl2xLV2cgts3+xA5YYex9l/Wj2Kas9cwes0CVp5V+XRUd5Sxsq
	biejaOKuhZRtgu3u/4e0z+QQW9IG8NHWweMkqu9E+1ekrq69jgPlIPcVAQn3k2Or4DRtOJ7HpvG
	xEBnQtAlIiOO4J2UhO3+ZOUKWcznvQFDCT/CNAdUAfAsApqVTEjxLztMitQrESXSmEhQ1ubiHn6
	NgORqw7NPKvNFtwmaIC7bVgUT0oMKbW21Kq4o
X-Google-Smtp-Source: AGHT+IHJubONATMqOpM0aphE/8E9mxBxm+qVR6z0xeXhHSIOScfHf6lN7uyPcMlhiwlXUofQ7HBbrg==
X-Received: by 2002:a17:907:9444:b0:b3c:d31:31d9 with SMTP id a640c23a62f3a-b485b2a6401mr471849866b.20.1759418797676;
        Thu, 02 Oct 2025 08:26:37 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa62csm228377666b.19.2025.10.02.08.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 08:26:37 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net v6 0/4] net: netpoll: fix memory leak and add
 comprehensive selftests
Date: Thu, 02 Oct 2025 08:26:24 -0700
Message-Id: <20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKCZ3mgC/33OzWqEMBSG4VsJZ+0pJ4n50VXvo5QS43EmUJIhW
 mkZvPeCK4vS9QfP9z5h5pp4hl48ofKa5lQy9MI2AuI95BtjGqEXoEgZ6khh5iWWPJdP/lhKXb4
 qo5+i0hOFGLoOGgGPylP63tE3yLzAeyPgnual1J/9aJX79J+5SpRIOlqy1nSeu9eRhxTyS6m33
 VvV0WgvDYWExjnDoxmjtvZk6KNhLg2NhN6Z6CYeRi3PRnswpLs0WiSkYAY9+MnLyCfDHA1/aRg
 kdI6VYQotD387tm37BQGrs5TKAQAA
X-Change-ID: 20250902-netconsole_torture-8fc23f0aca99
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, calvin@wbinvd.org, 
 jv@jvosburgh.net, Breno Leitao <leitao@debian.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3275; i=leitao@debian.org;
 h=from:subject:message-id; bh=o97ssWS1XLnkBDbG8UDuOY3aKVcNvG347gRIilI4pS8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo3pms6lJKB0FbSWZRJJCtCqNJP88m2CpjoW/J7
 jG7j5+mRsyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaN6ZrAAKCRA1o5Of/Hh3
 bdP2D/9FhhvEn5Y4fs/RB3oFPb9J3lK/v58q3Nj2XkSLehybA33BF0L/qXA7Vccy+BAaVLHj15W
 GgpzyXp7UeLTA2lOh8BsxkVdbY69nHgJiQy1neHu6zCzCqb2kwE1pOzEz39NDY5or6pDTXVfr0g
 DjQVyi4+EEfG+fpq1J68wMPzCt8kDNgr0wkGMF502lBjohK5DWRqQ+YhKkdvaJ5RCi2tM2W78mG
 ellyrqS9wpo/RvCg/ytHcM6xa0MS3W/Vdt5f/Xwx44KA5/Of9pJt500n0dSZpDnihJmeCE4mfBY
 Ww5O0KEKomUh87ysenyshXN0ZgIQQJtxtx45PiJw1B491oyULAZv50xG8ylUj1+4uibA1CqViqb
 NWBD1hpHeVoVUxFToltgrCoJUiOqg+peTBihZqiQtz3RSYt94miFBifb2yD7kWaOilM3QmwWEc/
 F/MTO2Nv7OAmbCZUo/DY5abqfn/Tv3rki5ZAqhLrqZ0ou9XNx+H+xsYOTJvV62f3F0nGRH9Cs46
 A57Ls8J1IqP4JOlm8Da/ybKWjsO/hAW+VCKnPS1NENhsIGIEOceyPm8e9afiJYCGV0AjLo63jVH
 OhQFurRrJwuaznF0cqw2IyM/QzDIEvlNVO5sVbUJrMyHufZAI9X7b7CpFJxmAP7vyF1cSeZv+/I
 BNwHnmFrqGEXZgA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Fix a memory leak in netpoll and introduce netconsole selftests that
expose the issue when running with kmemleak detection enabled.

This patchset includes a selftest for netpoll with multiple concurrent
users (netconsole + bonding), which simulates the scenario from test[1]
that originally demonstrated the issue allegedly fixed by commit
efa95b01da18 ("netpoll: fix use after free") - a commit that is now
being reverted.

Sending this to "net" branch because this is a fix, and the selftest
might help with the backports validation.

Link: https://lore.kernel.org/lkml/96b940137a50e5c387687bb4f57de8b0435a653f.1404857349.git.decot@googlers.com/ [1]

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v6:
- Expand the tests even more and some small fixups
- Moved the test to bonding selftests
- Link to v5: https://lore.kernel.org/r/20250918-netconsole_torture-v5-0-77e25e0a4eb6@debian.org

Changes in v5:
- Set CONFIG_BONDING=m in selftests/drivers/net/config.
- Link to v4: https://lore.kernel.org/r/20250917-netconsole_torture-v4-0-0a5b3b8f81ce@debian.org

Changes in v4:
- Added an additional selftest to test multiple netpoll users in
  parallel
- Link to v3: https://lore.kernel.org/r/20250905-netconsole_torture-v3-0-875c7febd316@debian.org

Changes in v3:
- This patchset is a merge of the fix and the selftest together as
  recommended by Jakub.

Changes in v2:
- Reuse the netconsole creation from lib_netcons.sh. Thus, refactoring
  the create_dynamic_target() (Jakub)
- Move the "wait" to after all the messages has been sent.
- Link to v1: https://lore.kernel.org/r/20250902-netconsole_torture-v1-1-03c6066598e9@debian.org

---
Breno Leitao (4):
      net: netpoll: fix incorrect refcount handling causing incorrect cleanup
      selftest: netcons: refactor target creation
      selftest: netcons: create a torture test
      selftest: netcons: add test for netconsole over bonded interfaces

 net/core/netpoll.c                                                  |   7 +++++--
 tools/testing/selftests/drivers/net/Makefile                        |   1 +
 tools/testing/selftests/drivers/net/bonding/Makefile                |   2 ++
 tools/testing/selftests/drivers/net/bonding/config                  |   4 ++++
 tools/testing/selftests/drivers/net/bonding/netcons_over_bonding.sh | 221 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh           | 189 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------
 tools/testing/selftests/drivers/net/netcons_torture.sh              | 127 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 531 insertions(+), 20 deletions(-)
---
base-commit: f1455695d2d99894b65db233877acac9a0e120b9
change-id: 20250902-netconsole_torture-8fc23f0aca99

Best regards,
--  
Breno Leitao <leitao@debian.org>


