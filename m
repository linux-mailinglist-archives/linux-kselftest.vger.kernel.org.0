Return-Path: <linux-kselftest+bounces-48135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D00ECF1350
	for <lists+linux-kselftest@lfdr.de>; Sun, 04 Jan 2026 19:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 494333018970
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jan 2026 18:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313B222D4E9;
	Sun,  4 Jan 2026 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+lagqRn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7E030EF98
	for <linux-kselftest@vger.kernel.org>; Sun,  4 Jan 2026 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767552100; cv=none; b=hChG+Wr5RdorTfKteJlgaCbs3eyWLVMkbiYzYPsDjITZKbXTNGQiLkmv960cz5A7MDBEA+3Y0Y6ihket+h9IhW81EpzgLlpvrK8v0hrWv4Z5QComdXD6WaJB8Ankshg8nhvgbb5NwpJoZFNTHxdiNuVGZuBrbXwR1z4vayhUQEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767552100; c=relaxed/simple;
	bh=k6HYkuFjGOkMGYq7NrGDAXkhegT+uwp4gHCdoaClonY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QQJJaIh9F/K2F/EYuhrZcNWdO3EVMWn4Dbgy+D6hYtI4s/4eJ3uqs8lakvvUK074R/CW2YVWFC9SD1SsRm/bqa8GpjTMvbodw+2GO5B62N1nrFjIx/etZwFPEokAFF45m+7cqGZjt+jFsxGBfd66D56hhp2WhJVZpIlJh93oCxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+lagqRn; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-11beb0a7bd6so1563347c88.1
        for <linux-kselftest@vger.kernel.org>; Sun, 04 Jan 2026 10:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767552094; x=1768156894; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TMiD346ICb1bspuV7cqGoIBZJwRiXZOhPp5cwrAlU3s=;
        b=i+lagqRnijg9iar6YL/ftREFJIhI5m2g3BFoVClagvXawP0YzUDXZsFj0CBD/c9dnt
         7w2uke5aGs87OtQy48QRHDnX9qDeu2vW4V/PpeV2WNobyWlWrcKd0+lYfQTCciyFiF9V
         UhmbqTQuv8jKivpzoC8EyRQ+aC+gJ7Wd0K5dL5+3pO1lrFEUWSAPNbvXdWQpS2JuUlLH
         bpTXzdMw6OL05TRlPJRTGiMuLccwcLnwBGUe5RRVbD+/WVQ/AFZ1MDDRZvFjIqGVcYaD
         EsCr25UnjauN2PBOwyViApd05MtWck9mMrMvwiBEhApd9TsiPz2K+F7t6F99ORNo+Gj+
         p2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767552094; x=1768156894;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMiD346ICb1bspuV7cqGoIBZJwRiXZOhPp5cwrAlU3s=;
        b=GaZJUuKbanhyi2B+PQB5LvE0Tyk8PyrgBEToldvUPvs07l8zzK90n5OxvdX8H0UM8k
         VUXLc8SQe9T3oaI4KhYarcdsaOpazIDs9OVtljHT3N/3tUt3b+REC95vps/Js8jeCI9E
         qDNV8iAGeU7TlJJCAljj2T0pbe/enpa7y+mlCgQld3E9GjF0VLaSc1hjZ/0TD5OdP2qX
         Gb4xjJHQf88WRU7fSoL+1xHqhoeRC0RH1sQQ2/EQM/GHjmIxC2msoOM4YdumTmclE4DM
         F7A55O2/J7EEvYiYYGARDYETDNZ4JAdBNAN0lY7mOX8wWnqQ1fsxLaTkH/NAfIgczHPb
         wBTg==
X-Forwarded-Encrypted: i=1; AJvYcCWSL786tWkao/f6eg+Z22K1DIVfjqARLGm7o0gC9/wXjgbTt+x+t2IrM++CMZqU72HRUz4pVtob58cwLgbeiGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ej4+s8xr+FHEyWALy8i5j/Grb4VCf53hZmRaBTJapNz8C0kj
	2LTq0xNdPyu7jY15cnYdtVxBRG1q6HodXyx5qUtIN7ForT/mLm0X/9pC
X-Gm-Gg: AY/fxX55r//gdzqLrC9VEaBuJr+I19ztWiyEs1lhzsaPxcrEujQLOd1yYJYvc86kfDh
	QP139Caov4uPlSOMoHdlQjAjGdjIW5KL+sTKq1nGqT6zy2CxWM7xFE894HT8PpCBJj+WUZXrWxB
	0SHH/49d86iU87ZQcavO8SlM+d4JwjR4JZwf88KR10quCN6lcwyNZPbF8F9wTlkb3YCBKKUqQ63
	LflRVBl5wT769GniJwpvnfBihoSr0k11t0COODJDlJPD/+6Vpm/4BQs+VHO8gfNYEzbZ+AoJ9FI
	s2Y4QldrgXK6tV8PYzdcvQU+8p0UMERfCcdMua23oRMziHx1ugCw2bl4Eltd6DNJ15yWP31Iuif
	BX0yRzVSv+06QfEBo6e5M7H9WmQRlPJ3Buq74CowGLrsRY6Z/qvWcaYOdZQdW0XdPymQwMiBwiE
	H9p+odiJog2vMlD5uboCmEG8n7A7I=
X-Google-Smtp-Source: AGHT+IEQw3jWBR372JNKXP+kV3AP4HMYDSMrhVC7CyEowmce5ByqdcDNZSCGiF8GmqwdMKdNBSlYNA==
X-Received: by 2002:a05:7022:49a:b0:119:e569:f86c with SMTP id a92af1059eb24-121d80a2831mr4561121c88.9.1767552093505;
        Sun, 04 Jan 2026 10:41:33 -0800 (PST)
Received: from [192.168.15.94] ([179.181.255.35])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254c734sm170975553c88.13.2026.01.04.10.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 10:41:32 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Subject: [PATCH net-next v9 0/6] netconsole: support automatic target
 recovery
Date: Sun, 04 Jan 2026 18:41:10 +0000
Message-Id: <20260104-netcons-retrigger-v9-0-38aa643d2283@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEa0WmkC/23QS27EIAwG4KuMWJfKPANd9R5VF2Agg9RJKhJFU
 41y99IsKpRhaRl/2P+DLLHkuJC3y4OUuOUlz1Mt7MuF4NVNY6Q51Jpw4AoM03SKK87TQktcSx7
 HWKiTScnBJzR6IHXuu8SU74f5QerzOnJfyWftXPOyzuXn+GxjR/9wLdiOuzEKVLjoLEjLNab38
 eby1yvOt0PbeCNw1hN4FRxEIwE0F8OTIP4Fxvo7iCowrSRyA95HfRZkI3TT2WQVFLfgVWISkJ8
 F1QrdHVQVOA4hOA1KhacddCP0c9BVsAgiKcd90E85DK3QvWL4yyEYHbwzwjM8C6YVTE8wVQCP6
 JNELYxqhX3ffwEckM/kigIAAA==
X-Change-ID: 20250816-netcons-retrigger-a4f547bfc867
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767552086; l=4592;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=k6HYkuFjGOkMGYq7NrGDAXkhegT+uwp4gHCdoaClonY=;
 b=g2T/UnpauvFW+HV51tODfeoldeNAV4osAHAyv6P4JevBfseVIrzcIeeUKRa2GQciBYSUoAw/1
 EOkaIGo1oofC82MLds4rBJ9FeT3QbSn33QnAtj5n0SbI/NH5st0PhSv
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
Andre Carvalho (4):
      netconsole: convert 'enabled' flag to enum for clearer state management
      netconsole: clear dev_name for devices bound by mac
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
base-commit: dbf8fe85a16a33d6b6bd01f2bc606fc017771465
change-id: 20250816-netcons-retrigger-a4f547bfc867

Best regards,
-- 
Andre Carvalho <asantostc@gmail.com>


