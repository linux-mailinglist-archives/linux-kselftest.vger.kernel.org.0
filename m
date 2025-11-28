Return-Path: <linux-kselftest+bounces-46702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B3BC9338C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 23:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24433A8547
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 22:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711B72E2DD2;
	Fri, 28 Nov 2025 22:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V65nveDI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35A5258EFB
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Nov 2025 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764367694; cv=none; b=S7FyvI5pVVcw/Qx1itEjuhfDHTPqknNcYnkES5JoEZD5nK/WePZp9pfLpwShgqyVc284vnzG1uOVu8RdpWvBL0BoAibMu1YSnLdizLBRpDRkhTJJ6ZmD7DFSontDxV6YNW9coM5s0wrihaFhyM3cG3R3AoMor2DxZPFIAAbDZho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764367694; c=relaxed/simple;
	bh=nJpadpldOBZRqMIPKhAV4aTclKnqAj6/LU3KTCvm2AQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nqO/67oHHQChG5FNC6m+yiuSbBJsgpo5CMTIRvxGc6RvrCmMLjJufQncCCFl9h4QaKhINFl4Lz9ZYPdB8jcoXv8JAT4RUZSTGo0xtRu4n8BfDfuiHKUSjsn3JtvlXN3MWDoXC1N91gnsp5F72cg/QPQPxXxSyYbKjoaWZYtExg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V65nveDI; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2981f9ce15cso25803085ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Nov 2025 14:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764367692; x=1764972492; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUan60wfJsHkrD1kHPjsQ4NVghOy/Ntfd2uLK97RNm4=;
        b=V65nveDItGJZH4Ec1tw7ccqbCWsOrEuvr6fSXyVOT0cPz247NiFVr2Wpyn5Jrc23E8
         T4rMVR6XpBqECLhUjUy0CzMPnRgWq/jOLimbKy4Iias0s55b+7Uc80rpuKbpPjg+qfvH
         TprK6zqeBwYA6QGnBsyy1o5NwdWr7+sNNgMzKQTUwV3drZgKOLDx4K2uRQ3yirvjhzys
         v4IiUzKjS2I1qUrdrejTKID+aGMCjDTH+lnWyvba0sgjPNBTPYYeHCAcxHUyHRB07r6b
         wQHLIMSXItMPsnilxZfPndOy50sjHrOHFoeZJXcHMbbEaATLK6QmoZNIESs8/raPwUVG
         UcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764367692; x=1764972492;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUan60wfJsHkrD1kHPjsQ4NVghOy/Ntfd2uLK97RNm4=;
        b=HoFVGfx4dC9AI6wKmb8MBLKiVsYPkhVXLqzRG4u+y1T9GMiwUJove1Wo3P6E/T/Bj4
         dScg8fjkBfAlzjNjZH6oLG+2L9xOfEnU49Pldk6jARCFbjNHCarq6E0hLl1c0sh4nBKV
         mwACC4Jd2BPOjz+204797chHYrnobKlqu/zAcP7UIt8Ysm1KkhaeS9wUk9TBnyUQdWex
         vN6xmiBzY1YcfScW4WqZCO1HA0rPLZFTRGnt7gW0aI0SS7DnWVw0W1eed10kfQJ9TxYu
         dxS/yhIUIs8J4kCrx9jfC/8rnKCf3zp1oDn7tY2fwZ7ogrPhstobiK7ZSS0K3lIHEGXc
         PpnA==
X-Forwarded-Encrypted: i=1; AJvYcCV6gL35XZGy+SyR4NyNanhYm1WBXSVlwKJtD2bEsSiY0s6sc5FQ4CRB589Wp6y38Y14fpEHqtuI8YE06z5aaN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV9pKrMpodjaXATM0vJXArJvv4BDPKb9OeLyiuQ2/du3cwkedc
	Uc6fiokGvScn0H763UB7bg3GrI5/pFfRQdLebFcxidxz6+AIWWA+igDp
X-Gm-Gg: ASbGncscDKjJ0NleBu5ZjPkqRCbphUHAcBPNaFbiyNaH0V4hF5WE/SpivpiKSmJH6Mu
	CQLLN4WXtX/y5yVnbRZLd24ygJYsd5NDp5YwIs3m6HLO/SxdphyA7pjnnse9EF49CjOxX8V8DII
	mscFjgdfotI8GTgIbfZV2BdD+KND2SthpwJad/mGd5WfQpdO2aPQKgx7TRm7iqan9R/YMWxTbgF
	OwUSdEiarDp/LI2WXOuHs2ko5NBX75jsLOJoXww0FRNzmCdSxMOaUowkQpv3OcgK2dvE0TgZNRZ
	8W+He2L2x8rA+WUTE88hU8V2FHdolTR6Oee6LR7PMzQ+RqR/OSbiQTyOrpVLbwZ79gM49OU3PtM
	O+01JVjiHBeaSgtYG2zMDzsq8A590kaOm3SCSkHQnCE0yYegfZCpi1CTYFD6ams1JGjQte3h/Kt
	OH7ZA8Z9tt5HBt/pEK1h7/M/GQqrBq
X-Google-Smtp-Source: AGHT+IGSx70Oj02Ci9/crptGoCoRHymMO6MlB+ROKyjGSb4e1FmSebU605sdyF6JXWkqWHcYcbzkdg==
X-Received: by 2002:a05:7022:4424:b0:11b:9386:a3cc with SMTP id a92af1059eb24-11c9d872af1mr17173439c88.45.1764367691826;
        Fri, 28 Nov 2025 14:08:11 -0800 (PST)
Received: from [192.168.15.94] ([2804:7f1:ebc3:752f:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee660asm26824205c88.3.2025.11.28.14.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 14:08:11 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Subject: [PATCH net-next v8 0/5] netconsole: support automatic target
 recovery
Date: Fri, 28 Nov 2025 22:07:59 +0000
Message-Id: <20251128-netcons-retrigger-v8-0-0bccbf4c6385@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD8dKmkC/23QS2rEMAwG4KsMXtdFlp/pqvcoXfiZMXSS4oQwZ
 cjd62ZRzMRLIeuz9D/IEkuOC3m7PEiJW17yPNXCvFyIv9ppjDSHWhMElGCYolNc/TwttMS15HG
 MhVqRpNAueaM0qXPfJaZ8P8wPUp/XkftKPmvnmpd1Lj/HZxs7+oc7wNBxN0aBchvtAGJA5dP7e
 LP569XPt0PbsBGQ9QSsgoVoBIBCrk8C/xcY6+/Aq8CUFB4NOBfVsyAaoZvOJqogcQAnExPg8Vm
 QrdDdQVYBvQ7BKpAynHZQjdDPQVVh8MCTtOiCOuWgW6F7hf7LIRgVnDXcMd8K+77/AocPl1xIA
 gAA
X-Change-ID: 20250816-netcons-retrigger-a4f547bfc867
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764367687; l=4229;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=nJpadpldOBZRqMIPKhAV4aTclKnqAj6/LU3KTCvm2AQ=;
 b=DTxYpted+ylrZjL9BC7vPGiTQ1Qy2LgsUdLWMeSgrxAFbIrBaOqKPmWuvDSJR2YlNANr0vhHw
 W/0H7cVY3MkBuK6SETdRXTutbGkECf35aRdZvG+s0yE0D1DNYSYFGqL
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

This patchset introduces target resume capability to netconsole allowing
it to recover targets when underlying low-level interface comes back
online.

The patchset starts by refactoring netconsole state representation in
order to allow representing deactivated targets (targets that are
disabled due to interfaces unregister).

It then modifies netconsole to handle NETDEV_REGISTER events for such
targets, setups netpoll and forces the device UP. Targets are matched with
incoming interfaces depending on how they were bound in netconsole
(by mac or interface name). For these reasons, we also attempt resuming
on NETDEV_CHANGENAME.

The patchset includes a selftest that validates netconsole target state
transitions and that target is functional after resumed.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
Changes in v8:
- Handle NETDEV_REGISTER/CHANGENAME instead of NETDEV_UP (and force the device
  UP), to increase the chances of succesfully resuming a target. This
  requires using a workqueue instead of inline in the event notifier as
  we can't UP the device otherwise.
- Link to v7: https://lore.kernel.org/r/20251126-netcons-retrigger-v7-0-1d86dba83b1c@gmail.com

Changes in v7:
- selftest: use ${EXIT_STATUS} instead of ${ksft_pass} to avoid
  shellcheck warning
- Link to v6: https://lore.kernel.org/r/20251121-netcons-retrigger-v6-0-9c03f5a2bd6f@gmail.com

Changes in v6:
- Rebase on top of net-next to resolve conflicts, no functional changes.
- Link to v5: https://lore.kernel.org/r/20251119-netcons-retrigger-v5-0-2c7dda6055d6@gmail.com

Changes in v5:
- patch 3: Set (de)enslaved target as DISABLED instead of DEACTIVATED to prevent
  resuming it.
- selftest: Fix test cleanup by moving trap line to outside of loop and remove
  unneeded 'local' keyword
- Rename maybe_resume_target to resume_target, add netconsole_ prefix to
  process_resumable_targets.
- Hold device reference before calling __netpoll_setup.
- Link to v4: https://lore.kernel.org/r/20251116-netcons-retrigger-v4-0-5290b5f140c2@gmail.com

Changes in v4:
- Simplify selftest cleanup, removing trap setup in loop.
- Drop netpoll helper (__setup_netpoll_hold) and manage reference inside
  netconsole.
- Move resume_list processing logic to separate function.
- Link to v3: https://lore.kernel.org/r/20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com

Changes in v3:
- Resume by mac or interface name depending on how target was created.
- Attempt to resume target without holding target list lock, by moving
  the target to a temporary list. This is required as netpoll may
  attempt to allocate memory.
- Link to v2: https://lore.kernel.org/r/20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com

Changes in v2:
- Attempt to resume target in the same thread, instead of using
workqueue .
- Add wrapper around __netpoll_setup (patch 4).
- Renamed resume_target to maybe_resume_target and moved conditionals to
inside its implementation, keeping code more clear.
- Verify that device addr matches target mac address when target was
setup using mac.
- Update selftest to cover targets bound by mac and interface name.
- Fix typo in selftest comment and sort tests alphabetically in
  Makefile.
- Link to v1:
https://lore.kernel.org/r/20250909-netcons-retrigger-v1-0-3aea904926cf@gmail.com

---
Andre Carvalho (3):
      netconsole: convert 'enabled' flag to enum for clearer state management
      netconsole: resume previously deactivated target
      selftests: netconsole: validate target resume

Breno Leitao (2):
      netconsole: add target_state enum
      netconsole: add STATE_DEACTIVATED to track targets disabled by low level

 drivers/net/netconsole.c                           | 171 +++++++++++++++++----
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  35 ++++-
 .../selftests/drivers/net/netcons_resume.sh        |  97 ++++++++++++
 4 files changed, 270 insertions(+), 34 deletions(-)
---
base-commit: ed01d2069e8b40eb283050b7119c25a67542a585
change-id: 20250816-netcons-retrigger-a4f547bfc867

Best regards,
-- 
Andre Carvalho <asantostc@gmail.com>


