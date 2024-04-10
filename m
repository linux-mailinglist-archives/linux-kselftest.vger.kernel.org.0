Return-Path: <linux-kselftest+bounces-7560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E904189EF15
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 11:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D94B283BA4
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 09:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB412155A21;
	Wed, 10 Apr 2024 09:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZMzT0em"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2CB155744;
	Wed, 10 Apr 2024 09:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742511; cv=none; b=b5yw4C45BwKw2//Pn5A1388iEf4b05BZT6e3LBOzs05mWkHAYwG5mS/VoU0JWtrPaPQE1Tc0aIwlvsZT9NTynbwWYjM7ia08sTb0w1zHcjGCyNAaXbtWiXb3VrARWxmTS3CTFidkNjNWXuJByCrbBA+xontu42sS7NJaJ8zwxAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742511; c=relaxed/simple;
	bh=1s0oiBo2Pj76zj482KObdE2PpY+vfqZgUvcrnvoopgw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h11VPq0i6mOB3GeIyUkv52woo9Q/XI35czYMzYh/eJNEXG2XTlfPguKDnRDujJSAbLhQwdvVSGrbyiQvh4SH0lXOm0116WELF9HSmPhnx65dHDeebXR3LKvo6FkGxwLmCRbR7cixsesxV7yZ46AO9eiBVtXCl3IMF03U8emuom0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZMzT0em; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0632C433C7;
	Wed, 10 Apr 2024 09:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712742511;
	bh=1s0oiBo2Pj76zj482KObdE2PpY+vfqZgUvcrnvoopgw=;
	h=From:Subject:Date:To:Cc:From;
	b=WZMzT0emdyQUTtK+HL5QTvS5wxNYb3itthHbKQ3hMgvRqzyb4VwDMqTq1HeMpvumj
	 fH604hmCfz0sE70zpPYsyaFnqcEFGHBpb9/8RXYXH9UuxS4V8hO+dhzeZzNuTHq2x6
	 2ak2S+meTTRBxxugmS2WdUgtkGL/VRB/rWk9hFT7uECVmKGychKBd16hJPE/vXq7xh
	 YWjxDzO8bwwFECy4dw4c+yToMHmGZafTlvXruu8224OSMh4V29t+DZzlpXbbDmHOO6
	 ZIkUztljwrtwBEXR48tFwPNA8jU66W4AqTkrN9mPDnzB2DKVFcxFl493NruExHEvKR
	 OS7AS0UZg+R6Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next v2 0/2] mptcp: add last time fields in mptcp_info
Date: Wed, 10 Apr 2024 11:48:23 +0200
Message-Id: <20240410-upstream-net-next-20240405-mptcp-last-time-info-v2-0-f95bd6b33e51@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGdgFmYC/52OTQqDMBCFr1Jm3SlJjKJd9R7FhdVRh2oSklQs4
 t0bhPYAXbzF4+P9bBDIMwW4njbwtHBga5JR5xO0Y2MGQu6SByWUFlrk+HIhempmNBST1og/NLv
 YOpyaEDHynJKmt1g9RFbIkkTZS0itzlPP67F4h28H1ImMHKL17+PKIg/+9+oiUWCuulZXOs8KX
 d2e5A1NF+sHqPd9/wCjHIuL+QAAAA==
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1526; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1s0oiBo2Pj76zj482KObdE2PpY+vfqZgUvcrnvoopgw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmFmBrp75LAfC3NH0qx8F3cRbNS2uWU+d2hOFH2
 sA80zSDE4aJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZhZgawAKCRD2t4JPQmmg
 c/6nEADYk8pzJSlVjM8Bsrw57zGUwUyiPmBmVRfSX7j6GFPGBaMudIaa/n4TKjQ6/UHevD+yXkB
 yhb0tF0MNsK94kj6DbSSW5qBnxL5un9Dh2wwyCCNWp0DCvZNLjaQ1r8W4Y1mjrgxMNxCZhx1J+d
 f5te/IlB+9lvEK+3TuyflBipdp3RLiS8Fl5Ek2oo/u3V7JyabEM7TLaJlWGOsF2zHVoJ7v7aMjc
 OD5fvLoL0NOx6EfXVq/GYAhh1Gg4LMQ+WtixzMAlStL4QtGQSOm3x0UcVQRfQSPOWXKdrDekPB8
 3GaNsoDaa1MCeFFrzDrsDUZ5/SzoQelCGtPI22WC+lP2D8B315GqPwFW1ZcA3k6OCRWiw/nD1/o
 HRklDf0wfp+MzQGOHuzFJcr3zRMQWfL4QhPHpxkY+ElutoX91GtvPQhSTXPy1hPFFRdK3It4k/y
 G5WfEc8GUG/l8vCvCd7G0lHBN7JcThw+hGcpcY8xS47IKJd/rCq1VbHHt2ITlw5oAwpan89y6cK
 CwSv/Cg3Qyas0WjvNz1KNeEw7UG0Ps7Bl6kbkpfWz/Z3Vj0MbGEutNOYWqiskeqXUL+q9UpN2Eb
 bdKAZiIy3o+9vtMrPrV4LCX397wL2Fqziilv5l5eGc6etqh8tPK3A8ZqFKYwlt3IS9vSAk+KYnr
 ekdWKs4K6qOIjbw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These patches from Geliang add support for the "last time" field in
MPTCP Info, and verify that the counters look valid.

Patch 1 adds these counters: last_data_sent, last_data_recv and
last_ack_recv. They are available in the MPTCP Info, so exposed via
getsockopt(MPTCP_INFO) and the Netlink Diag interface.

Patch 2 adds a test in diag.sh MPTCP selftest, to check that the
counters have moved by at least 250ms, after having waited twice that
time.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Only patch 1/2 has been modified following Eric's suggestion, see the
  individual changelog for more details.
- Link to v1: https://lore.kernel.org/r/20240405-upstream-net-next-20240405-mptcp-last-time-info-v1-0-52dc49453649@kernel.org

---
Geliang Tang (2):
      mptcp: add last time fields in mptcp_info
      selftests: mptcp: test last time mptcp_info

 include/uapi/linux/mptcp.h                |  4 +++
 net/mptcp/options.c                       |  1 +
 net/mptcp/protocol.c                      |  7 ++++
 net/mptcp/protocol.h                      |  3 ++
 net/mptcp/sockopt.c                       | 16 +++++++---
 tools/testing/selftests/net/mptcp/diag.sh | 53 +++++++++++++++++++++++++++++++
 6 files changed, 79 insertions(+), 5 deletions(-)
---
base-commit: 2ecd487b670fcbb1ad4893fff1af4aafdecb6023
change-id: 20240405-upstream-net-next-20240405-mptcp-last-time-info-9b03618e08f1

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


