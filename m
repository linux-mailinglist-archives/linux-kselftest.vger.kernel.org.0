Return-Path: <linux-kselftest+bounces-45949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB45C6D3E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 08:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61EBA4F45C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 07:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A082320CCA;
	Wed, 19 Nov 2025 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="he/9mJoi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8322DE6E6
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 07:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538572; cv=none; b=jHDtUy9GMRYRPTGWTeKfxQqGboIMcuXH/k45DiVxPsN+lHAuPesuLiClLClTSBUczb3XX8xm8YZYpBm9hFU/ugkCMszBGG8B0Y4lR2swsqdjlBOmQ2aYp4Y141YnbpdP6Zh4HeEw5K4M+pEGr9wvPoAea/kzYj6Hv0hDF6X6KV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538572; c=relaxed/simple;
	bh=opOkTKn6ORwriqO6kn1tWrJThvcbKhHAemrAcyV1Cwk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JolrO9AaJOWWnfYWQyGCBiRyjui69BwhO6LYnWIcC2sV/VmKql2wcz2no+OVlGfaI95YoXqETkknu+K/tXbHbOO8M+9ex/2/KBNEg5ZOTp36zdDVFYpOhhB1eZD59zKGfRAN0L49yPWQhuPzAETUPwtSvrkky6iFHoyGGvF7zA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=he/9mJoi; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b31c610fcso5440906f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 23:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763538568; x=1764143368; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RIuQqZRadnavbcOLO6rl23QAMdQFOy9Z8c7jjTJnyNk=;
        b=he/9mJoiLF5oAyQAIG5yEeGSnmWSzNA2JPbTk2FqalhdSaaWcIxOV6a3Yh8yETMKPd
         RgN9QFMv3Wapwk8KlMQPuivN9LvIcxZQkHG/u24iYX75fYpka0kAuorVT32xbAABfzy5
         h++rP+FsdKBtLtamZ+5D7UTJVqIdSwTtQKpETCuNoHzpIrOdjklBQzhnR6pH7Q1tNjdo
         bf3zA5QVOMoiHRmxl/I3En9ydh/0nIRim8KJYk94oR6x1eWF07A1IpPsgL+e+YvaieEJ
         nObDY6dG+NGpuw8h7DrxevGrAkPPO7ZJ0qxtAusGjMpQOY4xj6vcVklim8yWmk4h6apH
         4lpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763538568; x=1764143368;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIuQqZRadnavbcOLO6rl23QAMdQFOy9Z8c7jjTJnyNk=;
        b=CSFFLo7/S+THWAXX7PUyEsHt0WI+DPkgljUsfFjyrAqwsphsKqaofzlCy152KUCKeH
         Tdu+STsduRiF8q63n3m7FsyQMZHfTGpB5dSu91uoPVNt3jC9c9F+4LrNifCqlRG/js/l
         Mdy/6Qo2Rp74xrs+hviegkluLYdZnF4CS3yVgzWPMYPj6xwR/5JF5f7lSYqOWAG0OcBp
         i95hb6bQYxj0YTWFByPCIJxRe7uekITY67qCHNPlz6Wt3svfTURzzJrzUYolh1QNaKXQ
         +4VeTIe1txTNKxSoBfNqn1pjJ0mHieGf6AkVMX2d8RJhUksZUwYRaoz+NO8bQM+esZuC
         O16Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDNUJDDNKSxv+woINCt9yak3D4/P5atjXhOrJnDQui5AAHCmvQ5f4DoGGLvJxcPGgNG6Glz5MIT3kWmIBF5Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvFp/Id7GDRnuOROjqgQ/JlNxOFd3DO81HXyfCMXj2o6JKAGQP
	mOjLvPRIAna5tLmSajmqtQzwGH3Eh0auAejBT1jZ/bkJh+vXTh6sOAisNRulc2Q2PR8=
X-Gm-Gg: ASbGncssyrFA9IbzGzqVxokR5gXNiJhTogEULfhNl190UfIA7qRGqlaD5lhA5n8j1bf
	Own2MgLL/1ygtrbOIiwsOHXOPbvRKrxmIZdEnwtuEiW6KTtcHmjnXZgevfJdlLvwUCp4srSLjVK
	xpW4nOGtInOgfMQBLNEYpXoAomBTREHKFCtZD7qgwYm2draWOafhDIeim6CEcOp/YFTN2LuHn4n
	4lBgl6GSmxqo2Tjx8nB1iliRmdvzxLNJVdQUbyqSeb+Ae/018JuUy15zq4zdQylXMESnHaOHuux
	fnfAl/jZK2/5iB/lFI7/3aCFoR9/wGaSozdCBcjwmAqBzLBh/JKkGMHBUtVbfMS3j1mdxTCF+fT
	DhLPWPpAYs84fjqqENDySeUrf5vRxsoNfP+QD4DrPsS6jqjXnCPtE3FLmnslBTA15blNHxM9dlS
	4W1DyOVexXRTzOTLFrWA71Gpi8kg==
X-Google-Smtp-Source: AGHT+IHAVxC4q5FzOVYKsvXozzYgbW4vksvPBg9sojZ5ygQr+g8mJtC8hQaxXCtBPM8szGmEshmWLA==
X-Received: by 2002:a05:6000:1848:b0:42b:5603:3d03 with SMTP id ffacd0b85a97d-42b5934dea3mr20229708f8f.25.1763538568043;
        Tue, 18 Nov 2025 23:49:28 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e91f2dsm37461146f8f.19.2025.11.18.23.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:49:27 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Subject: [PATCH net-next v5 0/5] netconsole: support automatic target
 recovery
Date: Wed, 19 Nov 2025 07:49:18 +0000
Message-Id: <20251119-netcons-retrigger-v5-0-2c7dda6055d6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH52HWkC/23QwWrDMAwG4FcpPs9DVmwn3qnvUXZwXDk1rMmwg
 +koefcJH0bochS/9EnoKQrlREV8nJ4iU00lLTMX5u0kws3PE8l05VogoIFBWTnTGpa5yExrTtN
 EWXodje7HGAbbC577zhTTo5kXwe088ljFJye3VNYl/7RlVbW8uQ7cgVuVBNl58g60Qxviebr79
 PUelnvTKu4EVEcCsuCBBg1gsev/Cd2foNTxDR0LyhodcIBxJPsq6J1w+J2qWTDoYDRRaQi4F7Z
 t+wUXO2XeggEAAA==
X-Change-ID: 20250816-netcons-retrigger-a4f547bfc867
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763538567; l=3381;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=opOkTKn6ORwriqO6kn1tWrJThvcbKhHAemrAcyV1Cwk=;
 b=ncaXc87VvlMerGj01P/l/ztTX4sAbX2vCjMPpqStYxWAyZHflxZY5gRHQ6e2JZVdIxxw3IIk7
 UPJlaYAtAyMB0xRQM8b4wtJZdcwtYUGefmelMhZnBEkIuANk2zwB8C6
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

This patchset introduces target resume capability to netconsole allowing
it to recover targets when underlying low-level interface comes back
online.

The patchset starts by refactoring netconsole state representation in
order to allow representing deactivated targets (targets that are
disabled due to interfaces going down).

It then modifies netconsole to handle NETDEV_UP events for such targets
and setups netpoll. Targets are matched with incoming interfaces
depending on how they were initially bound in netconsole (by mac or
interface name).

The patchset includes a selftest that validates netconsole target state
transitions and that target is functional after resumed.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
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

 drivers/net/netconsole.c                           | 155 +++++++++++++++++----
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  35 ++++-
 .../selftests/drivers/net/netcons_resume.sh        |  97 +++++++++++++
 4 files changed, 254 insertions(+), 34 deletions(-)
---
base-commit: a057e8e4ac5b1ddd12be590e2e039fa08d0c8aa4
change-id: 20250816-netcons-retrigger-a4f547bfc867

Best regards,
-- 
Andre Carvalho <asantostc@gmail.com>


