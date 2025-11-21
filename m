Return-Path: <linux-kselftest+bounces-46224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9BAC790ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 13:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 993474EABCB
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 12:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD5A2F9DBD;
	Fri, 21 Nov 2025 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdVojLEP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B8A2E173F
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763729357; cv=none; b=U0q5iB6k2r4VXliz5qhnXNc5DMzv7hVZw9YW88mVwNVVkO5q/nbKtqtZ4YCktAu/ukCOgn91UHNGnQ72elEiMrRNnVfeROEBMAuckQ93A3YEPrVBN5yz4T2oK/q7WjveLDeiKo4yJ77faSQ+ra5dGXhhI3ejhovMUyDso7W+RRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763729357; c=relaxed/simple;
	bh=qPjeMOiCaboHjQNvdrrsynsm5YqTyIoZUfaec9H5ih0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LBR7bxkWvEgV6jSBZ+HIiOh+vd6chcIDgmKjvOeUskF2iVMp6esGgMfOfAzkKe/9hLeFWg+EgiLpTtqXdHzksgjhoLVIld1xFntHLBbc+E2Nyh4eCn1j0K2TDk3hThxlW+HbipLE6gqlDXA0MinHwbEYrlRiU+3bEatWmMAcQbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdVojLEP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-298144fb9bcso21595365ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 04:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763729355; x=1764334155; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cWsOvNZkn+5ac5Tx/K5nOImY3pgZu+MaMzBcxSD6nek=;
        b=SdVojLEPQJosjVi0jhwdKzftBR3iJ+OZ2sve8ueVuzTkamJNOAzWEWJNNt1uyYRxnO
         +Q9ppbZNEREfI5tFdATCXPdzyPZhvVizTu1nipDTUUBF44MVUWCv1vdKLgVi7v5hmK0b
         ZGHnBsEAQ09SIuA09DCYbcXo02ggOf5qBaEsqou54q+oTmYMTgJ2TBqYTqdUemCrw1Tm
         L67qmc12GlzPR7qpWljDWA/nAMRX4JKEcY3vu4qJsE7Obcr/vD7/geJaO+n0JUSWc3w4
         4IhTUhOERmLOXgiL88ths+ZHHHzZpb0+B4g/h3EAwxUwYeb5UdszwrCM+3wqIpTZ6iPV
         6npA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763729355; x=1764334155;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWsOvNZkn+5ac5Tx/K5nOImY3pgZu+MaMzBcxSD6nek=;
        b=GP2xc+m17hFYYHLKgWmsdj8nXTy69ncIKZn8WjVF3ciBC4HLutyk9lSm6NLPrb8iN2
         +4Yt3XEhISda7d4gzDhKevy0YJfE0dzsK2xLgn6Zdy4VslXxfBRvg4YguHzb32h47UD+
         xAz5we7Le4etUCCsshAIywowxoyZ6mP/Px5R30QK3roXLOIs+jO/4EqDkhFYAPxg6Yo8
         rWCkuA6AeL+C2vwV60IV/+I40EpKOqCDLy0v/PQuxwfXilNsuP+FD+I6LMZjiJR268iK
         XoEKr6x4Jz45jyTY0ccTFPLfcXquyswNeqxlx5yOz9JDY9Se0GDefxK5kOsB1/bS3pM1
         oRnA==
X-Forwarded-Encrypted: i=1; AJvYcCVqE3OtFqfi7T8FuWwmrlRLddj9pvktCKTI/S+S8CmYF8nrtj73amKD/IRahDamY8em/jpCLOo13rTDOLBPPxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyto3HCcbBoNlrc6+vZlXsVE15MytDeyuEjupGW2JxZhjlMWeWl
	1O6sdHyuIlcaPLPiBBFvD7sEPeBD2PqVqtHr9GxXN+f1yAsKnnQIbDDG
X-Gm-Gg: ASbGnctbifRhzDfWyL0s9Z63w3cxByt/ibodfNopSGRXwn4xGl1kTZv/S6BUIPxZV7N
	WYHLLWSIZpsqEp0bz5WN98dYqYyhCGUADbekF0En5EUYaN6l5KsPcjsYEiT79t0yfnwPFiC/v0l
	LI8ZDnc54uBv69QCG9D2IKg2l60qH//Ce/M0H/eEGM6aa7vGAZQysmKDu8/VIbdeoahLTCMOtaa
	W8UpnMCDqRw6lt0V2JvfDaMeiccnvmcnLc2gVS5Xw0d6Q/HPufMKAmkHRAF5pSP+V7lt3LzR01E
	kYVwM99kcjgVzeR0UU4nrX9PzfhadTCxevpep1kEoI1F0pSJWyyBy4RV9mens8hA7EzhipmvauW
	2sBexGUWjQ5SKmhDCst28U8nEDfwooaOYbyifc5bAKWOgdvaxA5Xl7vEZg0AvaPUfIGEgIFCqSK
	p8U5xTE5KF2LNknQOk
X-Google-Smtp-Source: AGHT+IGPGuZgzOkYsjghLaRxSLoI+ldeVcVH3cDc3ckr4pIf2uTtdGd53W6mlCboH6cNTTmHhqsR5A==
X-Received: by 2002:a17:902:d583:b0:295:4d24:31bd with SMTP id d9443c01a7336-29b6bebe2eamr30118575ad.17.1763729354924;
        Fri, 21 Nov 2025 04:49:14 -0800 (PST)
Received: from [192.168.15.94] ([2804:7f1:ebc3:6e1:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b274752sm56644045ad.75.2025.11.21.04.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 04:49:13 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Subject: [PATCH net-next v6 0/5] netconsole: support automatic target
 recovery
Date: Fri, 21 Nov 2025 12:48:59 +0000
Message-Id: <20251121-netcons-retrigger-v6-0-9c03f5a2bd6f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALtfIGkC/23QwW7DIAwG4FepOI/JOEDCTnuPqQdCTIq0JhVEq
 FOVdy/iMGUdR8v2519+sEQxUGIfpweLlEMK61IK/XZi7mKXmXiYSs0QUMEgNF9oc+uSeKQthnm
 myK30Svajd4PuWdm7RfLhXs0vVsbLyn1j59K5hLSt8acey6L2q2vANNwsOPDOkjUgDWrnP+erD
 d/vbr1WLeNBQNESsAgWaJAAGrv+n9D9CkK0M3RFEFpJhwOMI+lXQR6E5neyLIJCA6PyQoLDV0E
 dhWYGVQR0/TRZDUpNfzLs+/4EzMuCccQBAAA=
X-Change-ID: 20250816-netcons-retrigger-a4f547bfc867
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763729347; l=3569;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=qPjeMOiCaboHjQNvdrrsynsm5YqTyIoZUfaec9H5ih0=;
 b=nd8mzIdtftHJ0cvw3HoeOI9iSHPgDj98lFQrwZyyxBWc6wuySHuP/U7SYMRROgTK4zsdm+8I2
 MpM5iRazKZ8CW6FgpuLrhtvDjzlDTBru3G0QWSMjh78fShBiTk1GRUK
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

 drivers/net/netconsole.c                           | 155 +++++++++++++++++----
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  35 ++++-
 .../selftests/drivers/net/netcons_resume.sh        |  97 +++++++++++++
 4 files changed, 254 insertions(+), 34 deletions(-)
---
base-commit: e2c20036a8879476c88002730d8a27f4e3c32d4b
change-id: 20250816-netcons-retrigger-a4f547bfc867

Best regards,
-- 
Andre Carvalho <asantostc@gmail.com>


