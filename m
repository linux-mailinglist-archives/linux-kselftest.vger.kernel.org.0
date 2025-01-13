Return-Path: <linux-kselftest+bounces-24378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B31A0BC5E
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 16:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17BA57A2320
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 15:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7982E20AF73;
	Mon, 13 Jan 2025 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNH7Y/pt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0391FBBD8;
	Mon, 13 Jan 2025 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783125; cv=none; b=D+2CyzQlK3V7OP6S4Ao8Z4Es8fkl1tIn3YlZZO+6tgDyJ6a1HKS/VBUM2MBSbRVSWTQoIqaQfkz84nri6cyjGbkXwoWoI5Uxat3SyE/QvhqEyNqGyVAu+6K/Vdm+Ri7CGo6WSxMA3NyOL2XGy8zZfCSlyYWpa5LZquejc1DAWWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783125; c=relaxed/simple;
	bh=eBa2zjx3438AEFfw3XkdYt3G6AIFl2vJ8TFgPWssURc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=am4zrFVf8xfDafF6EPnMYyDLRDkuVf0xBD6GU/ceajogUGle40CbiGKdCXFjsxaqpM3pwC5fRfiATzITouX+kHewdnEYxkot+KlYaA+atqHdDJ+zJ4E42gzxTa6oeNJW9d2QsMgfsn9IHk7j8IiKCOfwwTf23/51f+1dndvjNzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNH7Y/pt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA8DC4CEE2;
	Mon, 13 Jan 2025 15:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736783124;
	bh=eBa2zjx3438AEFfw3XkdYt3G6AIFl2vJ8TFgPWssURc=;
	h=From:Subject:Date:To:Cc:From;
	b=YNH7Y/pt8WixVlAwYoYGHGZd1KPkjXKPvnVKvRzc1/em2cHTqeuJdQhoGpcohPjIF
	 D92R36aVB3Lcteed8OPkq9ciO9UKIcpFnPZ+f44cucJ/WC322SMeHWRkwOpEbK3Wua
	 Vs8mN+9MxFi/rQazcurzR7tw30XbGL8mSwTmSAs20hE4XJvGy1tB/3meTg81zJlMjv
	 ukV6F00/+siDdHwnTVDGy0s40UshxyifM1chlvUydpYUtKByjd4WwUDx61zMu6GyxJ
	 LCXPsv5RsRsArZydJ0PFnBJQHKMYj6JwpCpMZCt3NPzPlzJM99bDAy+pCJbMHkKMNp
	 S2lf3cpVkCryQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/3] mptcp: fixes for connect selftest flakes
Date: Mon, 13 Jan 2025 16:44:55 +0100
Message-Id: <20250113-net-mptcp-connect-st-flakes-v1-0-0d986ee7b1b6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPc0hWcC/x3MQQrCMBBG4auUWTuQtCrRq0gXIf2jgzoNmSBC6
 d0NLr/FexsZqsDoOmxU8RGTVTv8YaD0iHoHy9JNoxtPzvuJFY3fpaXCaVVFamyN8ys+YXyM+Ty
 FS3BhAfVDqcjy/d9v1EOa9/0HomUy/3IAAAA=
X-Change-ID: 20250113-net-mptcp-connect-st-flakes-4af6389808de
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1814; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=eBa2zjx3438AEFfw3XkdYt3G6AIFl2vJ8TFgPWssURc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnhTUNN/iQ2/MEWI+X/rp1NR5/7Ry3663i1bYf+
 hnb8tL3HgWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4U1DQAKCRD2t4JPQmmg
 c8MfD/9NJHQzkdTbG3MSbTUrvIcfSUc4thcPws6X7/l4xyG+zhHI+ttMLS6+D/1DqymMJICWQWU
 y8ZtyXzqyEJK479BWMtQ5+Ae6RtdLOGSZo3+kkXoYzvwDVAL2EhAXKlh69LfmFeTKYdfPJ308hT
 AjqceQO3UMjMLMlIcOv8Ie0WjN2diBPzorszSi1ZueCEIzY079pF00kEt3DGvK2RIKhsC1vNoPn
 VYsQY9LpHFILY0Ck3Vu7JnnynXRti6tCSZc9eaEWCCic2kVOjAL/UKQFJAadxx836JMaMPkkh0n
 SBf/Pqpps2hUbxm8obPEGUrotnP8OAoT63LiokjtHQdFAILcyepUqUGwNbEHkrkxIC+8CNXIsf1
 KlmosmRggqL+kSYBV/RNjMqhyM1J1R76zq7i7UPwru1ZPEBZ1a0gi3PPGlIS4pXdjtUcqQFe2Jk
 Nu181iu1meWTrzIwRR9PZRSuoJPjYBAxfKPfmqFpt5MZPwyRqz1FRTYezMbZcsUCVOxorA7nZrD
 AmQLppU4hTQFyvysYzT6y19ZYQNy85MkE2C2u1xA857M3pEiSM/kzxVAitoIJdMRnDiBOmH6fpE
 0Qd9l1B2O+/eXOGC7cL7fmXCCklLu4GjEDF+STtW6sEziRXD2ercIQLW59g32dzh08bYYvVP4FJ
 AQGJDUJl7sqV8XA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Last week, Jakub reported [1] that the MPTCP Connect selftest was
unstable. It looked like it started after the introduction of some fixes
[2]. After analysis from Paolo, these patches revealed existing bugs,
that should be fixed by the following patches.

- Patch 1: Make sure ACK are sent when MPTCP-level window re-opens. In
  some corner cases, the other peer was not notified when more data
  could be sent. A fix for v5.11, but depending on a feature introduced
  in v5.19.

- Patch 2: Fix spurious wake-up under memory pressure. In this
  situation, the userspace could be invited to read data not being there
  yet. A fix for v6.7.

- Patch 3: Fix a false positive error when running the MPTCP Connect
  selftest with the "disconnect" cases. The userspace could disconnect
  the socket too soon, which would reset (MP_FASTCLOSE) the connection,
  interpreted as an error by the test. A fix for v5.17.

Link: https://lore.kernel.org/20250107131845.5e5de3c5@kernel.org [1]
Link: https://lore.kernel.org/20241230-net-mptcp-rbuf-fixes-v1-0-8608af434ceb@kernel.org [2]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Paolo Abeni (3):
      mptcp: be sure to send ack when mptcp-level window re-opens
      mptcp: fix spurious wake-up on under memory pressure
      selftests: mptcp: avoid spurious errors on disconnect

 net/mptcp/options.c                               |  6 ++--
 net/mptcp/protocol.h                              |  9 +++--
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 43 +++++++++++++++++------
 3 files changed, 43 insertions(+), 15 deletions(-)
---
base-commit: 76201b5979768500bca362871db66d77cb4c225e
change-id: 20250113-net-mptcp-connect-st-flakes-4af6389808de

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


