Return-Path: <linux-kselftest+bounces-48727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFB2D118C8
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 10:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 936DB301057F
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 09:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D0D34A775;
	Mon, 12 Jan 2026 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbrDW/lb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A019134A793
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210875; cv=none; b=TapoF9sMRC1wn7aZ9DqsOdotwJ1LhM8ydC95zelJ0rwaj1cKQITENKzmKckACQL8+b9wwBodCxRnlny7X/dkWpj5kC9vE57uq77HZw/0PY1FE0WIRktK0l0ETVMB1Yu0e1x7ngdK4pxl8f38WIpJlDpIaK46SFFh0kGy75lqtCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210875; c=relaxed/simple;
	bh=D1nZ9kM/EuuYno+ZDSEcuEqHNLsDwCPEuHBego3wBFU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=totSYYgpDD6yWqWxor3SNxzD0YPiYO7yBvAvWxpIbumgbYmvnOxKwiLh9u3bJ9DbMLCAsJ/+cZdL8B7aVqD/YJ8IAiiSYhq5CtSAnjluvbxYYzfT7eSPEW1i3RRVKhzAk13BOIb/qX4NYp4dsW1ZO8LdGjFt0WdmB0FGzi9jY1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbrDW/lb; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8716197f3eso119300366b.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 01:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768210865; x=1768815665; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NcMCCbvb41kzTSUcvB+DuO2lx4ImVuo+wx0RXCc+wKw=;
        b=SbrDW/lbtiIqu6d8HO68/knngsw5di+Fe/1guDTerjtHsHpTkTiCihnuWkmvDW6cdF
         pxr8pQOT1P1/amv8RSerVYNKo2LQOe79NBg8r6LzeTut3ihG5S5otwSPgg9aqssmhXWR
         2iK6gZCpJ2xoqXZNNLoSySXioiluUn3LAyleeI7vg+u9y525AAf8plrRzVlN8NE9uFjz
         s7B12Hi64i8afjFfhi204kn4JOJlcLhRWCRrqoUA2cdLRBDXtD9FmM1BmWErqGLigHmm
         RCkzXBDKbnVxytIewKM5RnbADgys0r4OaUwLg4xJFzmA93og+PpgnnuD3v6WXqmwdomP
         TOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768210865; x=1768815665;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcMCCbvb41kzTSUcvB+DuO2lx4ImVuo+wx0RXCc+wKw=;
        b=QxmRe2Af5y6+RHTS5DrQSPIDYVzYcsQqpPUXFIdQEkltteGQf+obeKEJ0up4TxU+EO
         3ew95VRhyRcoUdw0IDv9n4JP6nJ5EKZYklRzSxNVp0cIWL72BtlcqxvlyngyyGtwZDi0
         jKWUaF2LBIT3r/zrEC6pDPvCj7Gwew5YgbVEg2Zw+Zg41FvrUUAj/WxrJ8veZtdjf/Pf
         QFto7sXobaIeyK7M7zOMVE/lBUGOTfP67ft5xVRgQV/lOlfQBJ5JEx+kjPlhBw7J6viA
         FuxEJvHccvzyAfnwNlBbyynlT/0uH/MJOQtfWJtW5eFpw3ffHwaa9mQjGJpD9F/X4rnp
         36Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVeYbsLMDXoD8aM233eHAkbDvwekSm6DB5qjg/Q5Q6cdYYF99qK0jhrwhxzHuwkSvC/7O0qxZxbB5u0vHlfP98=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ+q5ExBsS8fcvP7ScsirTSx2lCsGGFAqhxg+r9S9p7a+p2Aow
	/Y5/rqIhucrgZleCzE40ft7GoQYBgPuKs47QrESpb760iAiP7k6FU8wX
X-Gm-Gg: AY/fxX4Pht0E7c+MmRtQH9tNcBY8Krua0ZIuqdi29UkLp30Q4JomxRdKbbrSpG/dAhq
	Tt5G5p2oiNgzL8BmOARViHQYN0xu5o+sRwiWDBM4xUm84OagJkdzt3fLkBy0KRQS191etUZ+Ddg
	HzRaTMaQ69lx79XwaI8vy3ZWjaItMyLPvGyFYNYojeeTYZEOViyma0AmsBHIiTFIb3LIY8EpjjP
	483FJinPzLGEvH3NfW2eimeR6vOin7PsdPV599HmDzTVJ3N2jG687DOty8SnEiAr44UgH5OphM6
	Pcm5QA3X0wmidPjKJ8pWGsymoagtRdYJwrSgDZ8K5mGLSEFh3i4lsHUX2K11E9bZw23UcS8GSdA
	AqZl1jD9jxCrvEz/o/oOGKZo41KffT8x/jAptMCUy5JZPG6tA1uU51NS1Fq6zKB1bPFhW+z3GPI
	oovpz1S9JbgX05HznoibfLrN7M
X-Google-Smtp-Source: AGHT+IF3qwzBAX6fMwi+kTQzS94PxeyMpNh5glINk3hu98hkCYF7yoeLu5hs9WjReRTsg2GxRg4Jkw==
X-Received: by 2002:a17:907:3d4c:b0:b83:7fb8:1f54 with SMTP id a640c23a62f3a-b8445357b42mr1845150866b.39.1768210864497;
        Mon, 12 Jan 2026 01:41:04 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b870bcd342bsm410828766b.56.2026.01.12.01.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 01:41:03 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Subject: [PATCH net-next v10 0/7] netconsole: support automatic target
 recovery
Date: Mon, 12 Jan 2026 09:40:51 +0000
Message-Id: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23SzWrEIBAH8FdZPDdlHHWiPfU9Sg9+JSt0k2JC2
 LLsu9cNtEjWo47zc/zjjS0xp7iwt9ON5bilJc1TWXB4OTF/ttMYuxTKBkNABZpTN8XVz9PS5bj
 mNI4xd1YOSvZu8Jp6Vvq+cxzSdUc/WDleWq4r+yyVc1rWOf/st218r++uAdNwN95BJ2y0BqRB8
 sP7eLHp69XPl13bsBKQtwQsgoWoJQCh6J8E8S9w3p5BFIGTkh41OBfpKMhKaKazySIoNODUwCV
 4PAqqFpozqCKg70OwBEqFpxmoEto5UBGMBzEoiy7QUw59LTRf0T9yCJqCs1o47o+CrgXdEnQRw
 HnvBulJaHUUzJ9AwEG2BPP4D9pakiIgalEL9/v9FxFYnA/NAgAA
X-Change-ID: 20250816-netcons-retrigger-a4f547bfc867
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768210863; l=5324;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=D1nZ9kM/EuuYno+ZDSEcuEqHNLsDwCPEuHBego3wBFU=;
 b=1afp2v24P7yuBbwAAnExTNyO1WOGF/SSGt8ULaCiEPvIup1BBSdm42w5whAQqdFDFR843w2R7
 +2FCTRI72X0Awdb1+JbYSOZvrSTHnTnTsq0GosRsOHCpx/Qsy++SI0H
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
Changes in v10:
- Define wrappers around dynamic_netconsole_mutex lock/unlock and use
  them on process_resume_target to avoid build failures and #ifdefs
  inside callsite (suggested by Breno).
- Refactored other dynamic_netconsole_mutex to use the wrappers for
  consistency.
- Ensure we cancel pending working during removal of dynamic targets,
  which requires also holding dynamic_netconsole_mutex.
- Introduce standalone workqueue to avoid potential leaks during module
  cleanup, flushing all pending resume events before removing all
  targets.
- Link to v9: https://lore.kernel.org/r/20260104-netcons-retrigger-v9-0-38aa643d2283@gmail.com

Changes in v9:
- Hold dynamic_netconsole_mutex on process_resume_target.
- Cleanup dev_name as part of netconsole_process_cleanups_core to ensure
  we correctly resume by mac (for targets bound by mac)
- Link to v8: https://lore.kernel.org/r/20251128-netcons-retrigger-v8-0-0bccbf4c6385@gmail.com

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
Andre Carvalho (5):
      netconsole: convert 'enabled' flag to enum for clearer state management
      netconsole: clear dev_name for devices bound by mac
      netconsole: introduce helpers for dynamic_netconsole_mutex lock/unlock
      netconsole: resume previously deactivated target
      selftests: netconsole: validate target resume

Breno Leitao (2):
      netconsole: add target_state enum
      netconsole: add STATE_DEACTIVATED to track targets disabled by low level

 drivers/net/netconsole.c                           | 305 ++++++++++++++++-----
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  35 ++-
 .../selftests/drivers/net/netcons_resume.sh        |  97 +++++++
 4 files changed, 364 insertions(+), 74 deletions(-)
---
base-commit: 60d8484c4cec811f5ceb6550655df74490d1a165
change-id: 20250816-netcons-retrigger-a4f547bfc867

Best regards,
-- 
Andre Carvalho <asantostc@gmail.com>


