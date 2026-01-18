Return-Path: <linux-kselftest+bounces-49253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6115D39450
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 12:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C0D73009AB6
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 11:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E15314B77;
	Sun, 18 Jan 2026 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je814rp/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F36428AAEE
	for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768734029; cv=none; b=KlYWkvNKmlGHdccI9njO4d3cRVnuqF+gZxyRk71RnZcR1gO6U1e3p3I4/u56AJJd6KAQIeQ55QtoT9yfEsgZMfd4SSDREh4QKX9P/nbK0l+e/39vJrBYcbP4Xv0c7b347rLqQMGvrsTLSWOoaoxsZglUroj9GZvtI3O9IVS/sPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768734029; c=relaxed/simple;
	bh=j/O/ZdXNE/AJ9XmfXXavSQWdNO19Kh4bM+xEHlKCQS8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OBqnER+LWEr/5eVw0WePUe7La8NW5UNitNIEb3zFBbazL4crPCKHt+5CWFL91pTAvAWDOHtgxOvKTaAF6eQT24MXs2bqfls92fKnE3W4CMZFomTR0MKQHoXfB3CmBMFofguFHmLiRPsGfT0pWnd4uUon6ZSr4JmVBmP7Jkv9Gzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je814rp/; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so1599815f8f.3
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 03:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768734026; x=1769338826; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C2QflZZM30fHvvXvMmYMqyrigzgY4KSpjxPmG1MN9fo=;
        b=Je814rp/qRiR5TEltjiSP/Kh2wX/QbXC0D7+pnha98qCSP/2q3ccJsDxL4nqtociqH
         x4DADlYVlwKnBQS76Tq//qffXSivmJcyLUFS2YQEQ2c3DYXq1IaVxYZ5ZXkIo35XehbK
         yhDBGx4Za5GCpVCTr++TgnHm+19pgKR3WjM5DjO4mTk6tSU+YNJDWZnsznxWvnSYf8Ng
         WZVs7TTONf7TnGOsCsavGFIrnjPsr2VTzl6gt0qds+4jWBC4qv0yvoo505kRlRmKGyoK
         YIZDMgR/1zJ1JQqiWtQTWa0QEM6Nd08SZdnD5uZXGXL/2LS+SAgr0k7Y5/lm28v5uwNZ
         HOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768734026; x=1769338826;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2QflZZM30fHvvXvMmYMqyrigzgY4KSpjxPmG1MN9fo=;
        b=Zm9SZGeXO/RUAihn3/MZSHbgrUUa8Q1ty1JQ+yFKsIzCQM16MY8xPZwomTL+qmHpu8
         i69CbUmBoxv2Xavixl/HhJc0rSJMWLA/gxU/HQvzEFQxCIFe4nV3NJmtQupCWAJySglh
         v00CgHQt+kgT3ft/YNmjWuGvP40Z0JPxgFfmmFxcD5/FH+ErqnVR9U8tesXZZdZv/DHf
         ai7/Hhe3fmB/o/qz2Zu0N7R/7JdqCqZFm/WYio6fBhabwifUPM1TSxE8ZW1UtdmLHM4K
         7oT3+K91Qw0dkdTGajVR7mKbV647thYmef61VhuZw3hwFoy0TfFlphAvA4JortCva5Qk
         hDJA==
X-Forwarded-Encrypted: i=1; AJvYcCXdVidlUNY0sK0ud3nFfYuKKV4DRAd65r1ybPcR+7ecoexZFUO7bcCGNKoRtgoLwXoYouQvzCGgZ5PNE0vcYP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzzXs8txgYXczorsfshp0gP64g6eeZYr7v9KzI9NU7GLk5SyQ3
	+JcfzNVv3zjFKTnn5j+TtUsPnQKNGsJPBzO1ACkmE3Eunnp9oai/6pKdqQ3BdZ8tBAQ=
X-Gm-Gg: AY/fxX6r2p72EwR0eDJrdQOXxkQ1mxHrCjCHk/E5SVx57p260RggIiiRggTDQ/8Mocs
	ceFuAEjITUP+I7uGU+I+NYYECyNnTgwLd6X8VeQRJdKzJqk/dqJlKf4aQsdrI36jjdWgGgAQ6EO
	ORqEoRsFZpovxG7G7DlhBspw4cj/gusKzd8/SiDvweciXya0f0lKxiO8b3SbdSq6/VoCYA2XtVs
	KG09HFQfF1Q2TFDOmbDUMrwK2tmxl2eabprOqWsJVvLbaU9Vn55P/eU3jY8HsQlFSSxUBMdTsdd
	4IwQRU7ZIZrb1Ghvtsn56DQTJtXYJKrj1kuCpq8qitsaGwdESjGEEMsd9BuZQmUjIXW/m8ConiB
	hFZ55Jz5E0/iBFz3iUTqPMj+yl/z2aCnJCLkftb8jQEVj4SZBfMsWi5UtjbhHY6ep1rfJ/tB66q
	MgoZSGafvCKI16+A==
X-Received: by 2002:a5d:5d89:0:b0:42b:2ac7:7942 with SMTP id ffacd0b85a97d-43569972ec5mr11440987f8f.5.1768734026180;
        Sun, 18 Jan 2026 03:00:26 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992201csm16864635f8f.2.2026.01.18.03.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 03:00:25 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Subject: [PATCH net-next v11 0/7] netconsole: support automatic target
 recovery
Date: Sun, 18 Jan 2026 11:00:20 +0000
Message-Id: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23SyWrDMBAG4FcJOtdlNFos9dT3KD1osyNo7CIbk
 xLy7p0YWoSjo5b59GuYG1tSyWlhb6cbK2nLS54nWnD+cmLh7KYxdTnSBkNABYbrbkprmKelK2k
 teRxT6ZwclOz9EIzuGdV9lzTk645+MLpOJdeVfdLJOS/rXH721za+n++uBdtwN95BJ1xyFqRFH
 Yb38eLy12uYL7u2YSUgbwlIgoNkJIBG0T8J4l/gvJ1BkMC1kgENeJ/0UZCV0OzOJklQaMGrgUs
 IeBRULTQzKBIw9DE6DUrFpwy6Etp90CTYAGJQDn3UT33oa6H5i/7Rh2h09M4Iz8NRMLVgWoIhA
 XwIfpBBC6OOgv0TNHCQLcE+5sE4p6WIiEYcBQ4VwbE5UpShiwYTjSuNjUi1cb/ffwGFKybjEQM
 AAA==
X-Change-ID: 20250816-netcons-retrigger-a4f547bfc867
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768734024; l=5665;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=j/O/ZdXNE/AJ9XmfXXavSQWdNO19Kh4bM+xEHlKCQS8=;
 b=3yLjTs5FCZwgBaXzT5NYtLsUs/Scbb5lae31ukx8HNtOrzSCOkpN/+T3rG/j660RORtOw+1cM
 395/2UjqrKNBCUa66mIB6LlEvQYrDdiX0psENA0KO6wSCaw5syLi9A7
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
Changes in v11:
- selftest: Remove dependency on persistent mac addresses for
  netdevsim devices by saving (when disabling) and restoring (when
  re-enabling) netdevsim module. This should fix netcons_resume.sh test
  failure in CI.
- Link to v10: https://lore.kernel.org/r/20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com

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
 .../selftests/drivers/net/netcons_resume.sh        | 124 +++++++++
 4 files changed, 391 insertions(+), 74 deletions(-)
---
base-commit: 74ecff77dace0f9aead6aac852b57af5d4ad3b85
change-id: 20250816-netcons-retrigger-a4f547bfc867

Best regards,
-- 
Andre Carvalho <asantostc@gmail.com>


