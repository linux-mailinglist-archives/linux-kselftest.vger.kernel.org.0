Return-Path: <linux-kselftest+bounces-43599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30838BF388F
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 22:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 512B34FD6E2
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 20:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DCA333735;
	Mon, 20 Oct 2025 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCj9aUeg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88950333429;
	Mon, 20 Oct 2025 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993629; cv=none; b=KCXQps4QGK0qXFAUMjuH5g4DA45HzuanqfSSr8omcFhoY2h5/SaRlRf4GzUAaULgVzcIIGPk4D9ZlALbpSTYD7xPTK2yeO8e+NeDaLgFu4HwpQOwAZevEw3H6/vSXj9y0G10jBGo6tWx+3LRByZOVaizMFpEPsqvGVrbht2nfWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993629; c=relaxed/simple;
	bh=S/ifjXOYBDFszUtppvkoFMLw21lm2v86af3/kIW0+2k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VhvcxWefkAOzLiZtF6dHnrseobV34O8JZOebfW9MQENX6hq5mrPBU+gx9sbVOm4bdVetNPB2OAHYtS0YtRCFGYbm7jjjZXHrPsWwwHFvPOnfciTU9VDTSIa2MeWoIH4SNdbkWw5P0eYrxqpRBfqgPCZIJIA0oNRhyCh6TBrjXck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCj9aUeg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4176C2BCB5;
	Mon, 20 Oct 2025 20:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760993628;
	bh=S/ifjXOYBDFszUtppvkoFMLw21lm2v86af3/kIW0+2k=;
	h=From:Subject:Date:To:Cc:From;
	b=tCj9aUeg+Za34o3VZ6IBrupw8bPe97jRp6pWjRbRscqn2WLzo9G2+sX0GLFUz2D3S
	 NTG8D+ETVBIlMedHIO0FINIsUjqMzuueFq1dxVL/t8uCskRFnjIhmbdu+Iyd5KaPiv
	 H2bumF6bvpdS2FsWcKyJ/vjT7Mx6BIK9b9zRFOS7uuVzyCavY6e+Ssu4+3Jai6Mj2r
	 0YLkLVv3s1QBRiOQEaOYaJ3jjKhktYsokHAU0U6oC87qnPwlQLHrpxh6x2yTd7wtkG
	 d04fT7ch3P/tTl8ZxdLPsCaiXygoM/ykUfSHRmMleIUpKKLXCZcmj6mWsfNRjlrxy9
	 hwPgjIC51P/7A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/5] mptcp: handle late ADD_ADDR + selftests skip
Date: Mon, 20 Oct 2025 22:53:25 +0200
Message-Id: <20251020-net-mptcp-c-flag-late-add-addr-v1-0-8207030cb0e8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEWh9mgC/x2NQQqDMBBFryKzdiBJa0WvIi7SzKgDGkMSpBC8e
 9Mu3uIt3v8FEkfhBGNTIPIlSU5fRbcNuM36lVGoOhhlOq2MQs8Zj5BdQIfLblfcbWa0RD8iahq
 6J/fv14MM1JEQeZHP/2CC2sJ8318qGzrrdQAAAA==
X-Change-ID: 20251020-net-mptcp-c-flag-late-add-addr-1d954e7b63d2
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1295; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=S/ifjXOYBDFszUtppvkoFMLw21lm2v86af3/kIW0+2k=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK+LQyyKp3b7xHvGPVrVV9OvuyzU9+4dnw9+G2yt1UWX
 4mkR0tSRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwETm2zIy7NaXmFW91GiS2P6p
 P5teXjo169DjQ1tNHlsvkpa14Fsaps3wzzJvIlP/6cXO9/RWzuLZzhSynr90wcqD/dlKPxZttzO
 s4QUA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are a few independent fixes related to MPTCP and its selftests:

- Patch 1: correctly handle ADD_ADDR being received after the switch to
  'fully-established'. A fix for another recent fix backported up to
  v5.14.

- Patches 2-5: properly mark some MPTCP Join subtests as 'skipped' if
  the tested kernel doesn't support the feature being validated. Some
  fixes for up to v5.13, v5.18, v6.11 and v6.18-rc1 respectively.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (5):
      mptcp: pm: in-kernel: C-flag: handle late ADD_ADDR
      selftests: mptcp: join: mark 'flush re-add' as skipped if not supported
      selftests: mptcp: join: mark implicit tests as skipped if not supported
      selftests: mptcp: join: mark 'delete re-add signal' as skipped if not supported
      selftests: mptcp: join: mark laminar tests as skipped if not supported

 net/mptcp/pm_kernel.c                           |  6 ++++++
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 18 +++++++++---------
 2 files changed, 15 insertions(+), 9 deletions(-)
---
base-commit: ffff5c8fc2af2218a3332b3d5b97654599d50cde
change-id: 20251020-net-mptcp-c-flag-late-add-addr-1d954e7b63d2

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


