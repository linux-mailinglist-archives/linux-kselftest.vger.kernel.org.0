Return-Path: <linux-kselftest+bounces-28892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2060A5F07F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40DBD16F1D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 10:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE109261583;
	Thu, 13 Mar 2025 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mq5imFqX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71B31F91E3;
	Thu, 13 Mar 2025 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861287; cv=none; b=fAcUHfpiKvJxwtNbjdZNqmjAYNtPdCgKGxrAruf8A2UeEh6xKY6hEpPwjCi8WnfKvL4fgWT2QZ8Zp8DnURSxgg6aYuTkNe4505YllxuKWoObDEAmU5ax5hSxtZcUgMWFsBUrlwCj+VsTkHzs3OLEcAlH4+4va/hjENUvVx4gAzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861287; c=relaxed/simple;
	bh=8JyIlfgp7w/OCFYo3PZ+U2rTibygUjcYlz7++ApC0+o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A+wcOu2VedT9zCFIWL5mWIGTT4GI06DJzia78afOSDrRsnvW9beGUCu5FV6Ynzkd2IyUiXJt22cmYNT2JOzu7HU5pKZiUJF3MBoRULlYDo5JgAxEMrDTb1ZCFxuorhDMhzDzXxa5gUWAlfCuenXvjSzLQu4rCwJx76OgbHjRTTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mq5imFqX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5078EC4CEDD;
	Thu, 13 Mar 2025 10:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741861287;
	bh=8JyIlfgp7w/OCFYo3PZ+U2rTibygUjcYlz7++ApC0+o=;
	h=From:Subject:Date:To:Cc:From;
	b=Mq5imFqXA9NuI7CXg5Ywpo3gxfJdCZekjxV9E/SN3CEydmIz8fotIlg4lle9mUIDM
	 OtGZq4MPqPG4vjj+T2Ed9tcs3hUrnwMJkNp9NvY7PvUP4OeONy2J5g1c8bkJjn7uWI
	 2aceD3Dj3z/jewr9UfiEUNDco00Z0EroNagQcTKZH2Wl1p2NOx2SsFsKf83NHO1s5h
	 dufgE/d1zJr3DUVSEaEcEAwQ6pV6wXYzxWLKypOSQkMfDtlAH9NftuvhYhgzYqbWVW
	 8Rj3OPX6d/NAMnYHi1k/hq9gg61mVPMYcWaKAMUreCzP4X9NJm/lu8panPhQWnvqyE
	 Ddnpni37nwyew==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 00/12] mptcp: pm: prep work for new ops and sysctl
 knobs
Date: Thu, 13 Mar 2025 11:20:49 +0100
Message-Id: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIKx0mcC/zWMMQqAMAwAvyKZDTSVLn5FHKRGzdA2tEUE8e8Ww
 eGGG+5uKJyFC4zdDZlPKZJiE+o78McSd0ZZm4M11pmBLEaujati0OoVNWDSghJrTmjIkaHB+dU
 xtINm3uT67hP8IczP8wLcJFAedwAAAA==
X-Change-ID: 20250312-net-next-mptcp-pm-ops-intro-01510135cd5e
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2454; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8JyIlfgp7w/OCFYo3PZ+U2rTibygUjcYlz7++ApC0+o=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn0rGaj8Sk9NALlMru3ASwzLQMZEh0aB6QRF4lw
 5gEJ15Kf0uJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ9KxmgAKCRD2t4JPQmmg
 c9yKEACujq2P7gI5r5YxnZlMzqrgCcIxbZbeUqv2KhAFHsA8Hpm1ed7jmkpQOErCt5W9IRPJQip
 opZOyKZTUY4B118dnGPYn3y1PrQ5s1fJO57uDNN3bmBYLwhmXos3mOpIKa7RkkIpT8bxOOhFnf+
 RMXl5k9G6ogQDaP2BSW61qDFW1rkpvMyIP3ribMDCkgVWcfkANRRRzc1uw7DJytJ14OYwQC8pm3
 axaZdXKsj4kJnn9BgX1AO4wnqoiqqyH7hXVFBx/KmtG4sVhpOitLr+n434xB+AprRN2SToOPopz
 JYmBnDbIcOeO42l+D+OVvIORItyYSLqqADDuwn0T5rIRQl7CK21qHqOYswPnpJWLDMEKdTDdpJo
 hbw8hoNQo1g+qd7dVUZyijs13rZ3owydq1Srb8TxwcVbA8+RN2aNYcLqXSRaPGAjJgKLRZg+Fzi
 oxeQATVFe0qDJ1n8PhTfqLDYZKaEGiiYpewUE74MWXRRcCOSQEdFaxdPsIFOgAXjLlu0tlsSup6
 OqvifheAg+jUljlJmIoBZW5gMYBJAQRqpAsWXs0otX9rh4gTZ71twGsbmovBQN127y06Ue4eEa4
 pfc7Tf2Q+N2idxNwkVwbVMlUcLAamoA92zTqVq7nnL4cqvslHjFqW9Fi6z1MvrEsN1evG6hIc8W
 FH37mwF3wHbn0FQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are a few cleanups, preparation work for the new PM ops, and sysctl
knobs.

- Patch 1: reorg: move generic NL code used by all PMs to pm_netlink.c.

- Patch 2: use kmemdup() instead of kmalloc + copy.

- Patch 3: small cleanup to use pm var instead of msk->pm.

- Patch 4: reorg: id_avail_bitmap is only used by the in-kernel PM.

- Patch 5: use struct_group to easily reset a subset of PM data vars.

- Patch 6: introduce the minimal skeleton for the new PM ops.

- Patch 7: register in-kernel and userspace PM ops.

- Patch 8: new net.mptcp.path_manager sysctl knob, deprecating pm_type.

- Patch 9: map the new path_manager sysctl knob with pm_type.

- Patch 10: map the old pm_type sysctl knob with path_manager.

- Patch 11: new net.mptcp.available_path_managers sysctl knob.

- Patch 12: new test to validate path_manager and pm_type mapping.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (11):
      mptcp: pm: in-kernel: use kmemdup helper
      mptcp: pm: use pm variable instead of msk->pm
      mptcp: pm: only fill id_avail_bitmap for in-kernel pm
      mptcp: pm: add struct_group in mptcp_pm_data
      mptcp: pm: define struct mptcp_pm_ops
      mptcp: pm: register in-kernel and userspace PM
      mptcp: sysctl: set path manager by name
      mptcp: sysctl: map path_manager to pm_type
      mptcp: sysctl: map pm_type to path_manager
      mptcp: sysctl: add available_path_managers
      selftests: mptcp: add pm sysctl mapping tests

Matthieu Baerts (NGI0) (1):
      mptcp: pm: split netlink and in-kernel init

 Documentation/networking/mptcp-sysctl.rst         |  23 +++++
 include/net/mptcp.h                               |  14 +++
 net/mptcp/ctrl.c                                  | 113 +++++++++++++++++++++-
 net/mptcp/pm.c                                    |  97 ++++++++++++++++---
 net/mptcp/pm_kernel.c                             |  16 +--
 net/mptcp/pm_netlink.c                            |   6 ++
 net/mptcp/pm_userspace.c                          |  10 ++
 net/mptcp/protocol.h                              |  17 ++++
 tools/testing/selftests/net/mptcp/userspace_pm.sh |  30 +++++-
 9 files changed, 301 insertions(+), 25 deletions(-)
---
base-commit: e016cf5f39e9c53e274a7b7122a949d8839b8782
change-id: 20250312-net-next-mptcp-pm-ops-intro-01510135cd5e

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


