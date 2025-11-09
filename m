Return-Path: <linux-kselftest+bounces-45192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69737C43C43
	for <lists+linux-kselftest@lfdr.de>; Sun, 09 Nov 2025 12:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 547694E1A05
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Nov 2025 11:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22ED2D9ECB;
	Sun,  9 Nov 2025 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="On+neItZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EE534D381
	for <linux-kselftest@vger.kernel.org>; Sun,  9 Nov 2025 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762686378; cv=none; b=TAOWF1J8gkhb1R11VOvWkxLZKtn/TLLKlrC1uBfL/LhWpMW8kI/k6Zp6j912nsqmwIHumPrgTRldsh2aPR+OR+Z2fJoFo+9FV37q1Y9B7kHKrw8ao/AT6ANXXld2xOUcC7CkuFr/aNQN+TRvNcVbpxShTHoGlUJLCi32Ib7SjmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762686378; c=relaxed/simple;
	bh=De9+MX2vBk+SbIGIUhl/ERdEJOEzL0rWaAO/AnsvYOA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=id5eijMu2rPpW9BpaV2MFy6Pl1tnmAoW9otXSgKM7o5oJB6l9cOWgHUYgU2Jam8aRKuoeTpJ9unRUoupz409nOwpUqJbNP3Wu6ayURuBVfCScX8NAynGnOX3fypGCmTloH3P+i97H/9Yb6EFC+vJAHAAy753RQNtkGNTS9mUowA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=On+neItZ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b379cd896so125206f8f.3
        for <linux-kselftest@vger.kernel.org>; Sun, 09 Nov 2025 03:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762686375; x=1763291175; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rbXLUKgX0TjXrMF250y0CMZbN90r+Agvhxuop5xsxpA=;
        b=On+neItZlelMtvUVkVgo9Y2xdgyublfgVzh/IHCYyV5FlsO1s0q89HSmRQCpFdboxS
         8wjt0Zq8ONS2yOg8s8hDWBUrmK2h1XeBrKGGbvEr2ui2sMjuscOFh54XpWbpnDlAwzZ+
         qScME3QidRds+bAJUQDa/iPYLthbqkgJ+rwR8Vb8RTlWk81lW4t/V/RJjG0NpC+4EwFd
         MBTcMnz8bxlmMMAY27KUwPSPUEsLwk/YXmJlWua3LQ7oR68abYaNAuqAHsYrvTqL9RlE
         aYh7AayOlxiwgbtakVuj2FnY1QjrToET+7NLVbq9xu2KoaINhkjEF/qmtoq1nVhPH5Rd
         z21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762686375; x=1763291175;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbXLUKgX0TjXrMF250y0CMZbN90r+Agvhxuop5xsxpA=;
        b=TJ//YJfLfE1zX3b+UIwVtFF5dGBEh5dZVwd7MxlK5T0jcuo4ZZImkZumqLoKzDZLpJ
         K3Sy+I6FALKwGdJxdakaUEDNoYcomHVxqdyBfAaPdGPibTUS1uTaJSJ/r7AbyiLCj0nK
         5WAhivRsFJG0gXpFzI1gLDIqgKldUnDXf3hYoPRUhcG2WcvCWbxwT9E4YjMRB39V/UFu
         uw6N2iKi0+jbGeC3LS460bjJISK0npw9TaPgd2aHg2BClf9D38qy6L50GoeZEBNFqxR6
         pxi+VizGyW5qCWeMrEZUe1xtYDQuDPuRQmOJz4gskOKd79vH0gg9tfQS3uiHfBjjSojE
         y/wg==
X-Forwarded-Encrypted: i=1; AJvYcCU2BQny/TS8bJsM66klzQovxCVLRkFsPKp6TSYPaQ8hgtoprgtc8TsYmYolW16oisya868WAHjel26osNH4aYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL+/nrYLoMthU1rMZVqi+tRxcWBBQ6v20gXWpB89KxeG7uxJ+K
	KVyUSJ8STqp7R01yuPkmbidAFhCcO6HSC8fs5Ipf/Kfw4zcUNjeq9EZU
X-Gm-Gg: ASbGncufOhhKHUtxoLf7XnSfzzaRyXG/vqAQuuND4P0VDJemt2FAnFWeZhcVR4JBN3P
	4bXDRVx8oY7IyqfwMVjO5Y91jN7BTStAj4EMF1hif/EEfFA27ZduPnHxjc4tpaFoS9roIu+I7ZZ
	xEeaQiBrM3lf9Mn+YqRDQR/Tzh/wX23lTzZbdqRd44ilJ3We22F1TckcfqqyXTXrCJF8wRetcX4
	Git8AkGYflxupXpYjjwbsL5hLkbMZfM+Xe6w6B52a6M2shIRbuPm7gFxk4yBbAQmUkKKksRjdhe
	VDS8hPajuqTWeQBCxJAdR5om5eRN5S5R8K2xWtGn+oq6KHb+o+6YjG+zLUbz4Te8+NG48mpyqUo
	ZSNDTe/ZQZqdbmK0H1EGZQiBQxsPun5scZ41m8HKsxVMgEDxd/YNlD6jnqdi+Ru5LfAeI9pDnwc
	j3Ut7v
X-Google-Smtp-Source: AGHT+IHOM8dW1nNtCVe3CJGefgr1ytYvZGBfxsEPPKC2wEBPgxCwVt7raDzU9Z8qtaYHfVcnNwAhDA==
X-Received: by 2002:a05:6000:144d:b0:429:d0ba:f002 with SMTP id ffacd0b85a97d-42b2dcb7b58mr4045923f8f.51.1762686374822;
        Sun, 09 Nov 2025 03:06:14 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b316775f2sm6354925f8f.16.2025.11.09.03.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 03:06:14 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Subject: [PATCH net-next v3 0/6] netconsole: support automatic target
 recovery
Date: Sun, 09 Nov 2025 11:05:50 +0000
Message-Id: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI51EGkC/23NQQ7CIBAF0Ks0rMUApbS48h7GBeJASSwYIKSm6
 d0lrDTp8ufPf7OhBNFBQpduQxGKSy74GvpTh/SsvAXsnjUjRthAJiqwh6yDTzhCjs5aiFhxM/D
 xYfQkRlR37wjGrc28oXpeJ2tG99rMLuUQP+1Zoa1vriTywC0UE9wrUJJwyYQ2V7so9zrrsDSts
 B+B0SOBVUERmDghgvXjn7Dv+xfnBB2y/gAAAA==
X-Change-ID: 20250816-netcons-retrigger-a4f547bfc867
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762686373; l=2776;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=De9+MX2vBk+SbIGIUhl/ERdEJOEzL0rWaAO/AnsvYOA=;
 b=g8BeDrs1E3DrUbsmWpHWBNWzcwWTIF2Cz1mzTszz480dnFZW86hvDQRQKf6MYun6o2xBPnhsB
 bPfqtOVGXvlBfukd0ByJSfdl2LyBDevykjLYfxl8VLu3/eb2f3pmuJS
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
      netpoll: add wrapper around __netpoll_setup with dev reference
      netconsole: resume previously deactivated target
      selftests: netconsole: validate target resume

Breno Leitao (2):
      netconsole: add target_state enum
      netconsole: add STATE_DEACTIVATED to track targets disabled by low level

 drivers/net/netconsole.c                           | 126 ++++++++++++++++-----
 include/linux/netpoll.h                            |   1 +
 net/core/netpoll.c                                 |  20 ++++
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  30 ++++-
 .../selftests/drivers/net/netcons_resume.sh        |  92 +++++++++++++++
 6 files changed, 238 insertions(+), 32 deletions(-)
---
base-commit: a0c3aefb08cd81864b17c23c25b388dba90b9dad
change-id: 20250816-netcons-retrigger-a4f547bfc867

Best regards,
-- 
Andre Carvalho <asantostc@gmail.com>


