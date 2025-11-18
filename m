Return-Path: <linux-kselftest+bounces-45830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8A8C67E36
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 08:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 3D2D82A1A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 07:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011692FD1B2;
	Tue, 18 Nov 2025 07:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jve2/w/d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAE02FC870;
	Tue, 18 Nov 2025 07:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450454; cv=none; b=MMIW5jj9a7JxM15J3V051VWH8mTUJQ74nCH98uqk3Ccm4rpHYQ4weazVKGfYaH0eGnladCd4fbTvTckRnxyTa9BX586rC3aU3sk+aC1YxFQy2L1w1OwYZ28Ru0+eEB+3yV2Bfx/amUK1kYzyXTbuYuNyHqmHNC0+8jk9jMUQ/WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450454; c=relaxed/simple;
	bh=4I7Laa5+hC5Y9u/mA3pB6EsQ/92TksAlCPEnL7riiIQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SPWy77qwh2V7j27qGBnHMAa1phw8fmtxiCjMpZUZWZM0mHzF0dcGV6dJ5SnNcZmMvriKPVfeEjh2xv4QistnCVk/K1RhuvH0Z+LbTLegd54amXlOWTIX9ycqSkz5P1X5QQyw/xlJrCsyULPWIw+9B61e5LQ4eHNifA1Jc723tbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jve2/w/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7531AC4CEF5;
	Tue, 18 Nov 2025 07:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763450454;
	bh=4I7Laa5+hC5Y9u/mA3pB6EsQ/92TksAlCPEnL7riiIQ=;
	h=From:Subject:Date:To:Cc:From;
	b=jve2/w/dLl7zivuYmSJvJlPkHCCaWGxqwYQkh1Qy8eJPlG2Vq3M7ORAdvNo9RKSNg
	 ezE9XdfHSvpRPv8c921NPUZdkegCwvmfErboVsN7KoBYEmwBcisJFvbnE/NFH1alfX
	 0IOXT0Q0SnqYIiqJpuxvIDp+9cBXJFX+3TJZre2/kx7EnNbpuOSCemkN2fNljjZ6Nk
	 OYidkXCTk8MutsGcf14dJlrKFp3GgDVmJjDB3S5rCP6o/0yqykLMMPOKX/DGsmSeuq
	 wWzaW+zX9JzS7tNFuNlzGCYgMcVNEdj28Y3fI8q05LjoVvsUSIAp+VcSeWmk6P1V3M
	 fWC8ZFJeWGBig==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 00/11] mptcp: misc fixes for v6.18-rc7
Date: Tue, 18 Nov 2025 08:20:18 +0100
Message-Id: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-0-806d3781c95f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADIeHGkC/x2MwQrCQAwFf6Xk7IOmurX1V8SDZKPm0HXZFBFK/
 93gcWBmNnJtpk6XbqOmH3N7lwA+dCSve3kqLAfT0A+Jmc8oumKpq1Qs5oKHfdUxgic0GTEdU55
 PkqWfE8WjNv0bsbhSpHTb9x9Jp71fdAAAAA==
X-Change-ID: 20251117-net-mptcp-misc-fixes-6-18-rc6-835d94cdc095
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2139; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4I7Laa5+hC5Y9u/mA3pB6EsQ/92TksAlCPEnL7riiIQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJl5FwmSChc3juNqeyjwPdt77oSIjQij/I1udZM8lJlP
 nzpqgJfRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwETMXRkZrs3vX+XQxrNG8yPH
 xhs1ubfMmxmjWH9MP/Ns1byfe349Xc3IMOHD/xmpesVvD07/1rROQkhOq1tm2TKfXxW1XS+uLsj
 N5gcA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are various unrelated fixes:

- Patch 1: Fix window space computation for fallback connections which
  can affect ACK generation. A fix for v5.11.

- Patch 2: Avoid unneeded subflow-level drops due to unsynced received
  window. A fix for v5.11.

- Patch 3: Avoid premature close for fallback connections with PREEMPT
  kernels. A fix for v5.12.

- Patch 4: Reset instead of fallback in case of data in the MPTCP
  out-of-order queue. A fix for v5.7.

- Patches 5-7: Avoid also sending "plain" TCP reset when closing with an
  MP_FASTCLOSE. A fix for v6.1.

- Patches 8-9: Longer timeout for background connections in MPTCP Join
  selftests. An additional fix for recent patches for v5.13/v6.1.

- Patches 10-11: Fix typo in a check introduce in a recent refactoring.
  A fix for v6.15.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Gang Yan (2):
      mptcp: fix address removal logic in mptcp_pm_nl_rm_addr
      selftests: mptcp: add a check for 'add_addr_accepted'

Matthieu Baerts (NGI0) (3):
      selftests: mptcp: join: fastclose: remove flaky marks
      selftests: mptcp: join: endpoints: longer timeout
      selftests: mptcp: join: userspace: longer timeout

Paolo Abeni (6):
      mptcp: fix ack generation for fallback msk
      mptcp: avoid unneeded subflow-level drops
      mptcp: fix premature close in case of fallback
      mptcp: do not fallback when OoO is present
      mptcp: decouple mptcp fastclose from tcp close
      mptcp: fix duplicate reset on fastclose

 net/mptcp/options.c                             | 54 +++++++++++++++++++++-
 net/mptcp/pm_kernel.c                           |  2 +-
 net/mptcp/protocol.c                            | 59 +++++++++++++++++--------
 net/mptcp/protocol.h                            |  3 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 27 ++++++-----
 5 files changed, 113 insertions(+), 32 deletions(-)
---
base-commit: 8e0a754b0836d996802713bbebc87bc1cc17925c
change-id: 20251117-net-mptcp-misc-fixes-6-18-rc6-835d94cdc095

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


