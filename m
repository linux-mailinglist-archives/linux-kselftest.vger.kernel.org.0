Return-Path: <linux-kselftest+bounces-11384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7431900818
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 17:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91CF928A22C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 15:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7811990B2;
	Fri,  7 Jun 2024 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgRNkV9V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E6C197521;
	Fri,  7 Jun 2024 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772534; cv=none; b=WsFKnpt1FjhnR6V3EmKzhJd0iXd5gTwUCiNxd8QofSMInQQbqa8HU8sm4JjpDdw9hnyYIpuUnkIy8fTK82r8uYdvcwihkSsbjSEDX8fVBOHdeAysF2s4asZeFkZ5rBoqFDXJoJyI583HAeHRKjSMV6HyN80d7U2TQkh+CjwQ0jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772534; c=relaxed/simple;
	bh=uF8vT+OcPDdR5VdfX4WfqKuZuRJ7pOLHE27ORfVXlFg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CHvjRW7xEHBtgzFSg2K4yFaTJMXWrFFacvTBSuXejbOFpQK6rEAICZbj6TsS+1VVUTQDCM9yDH0lXup/CfRjIrOaN/UcwYNdgr4cHc2LM8cMF9X0kq+8ZQZc4XmAD0mAiOOLXSKE0khH3VDxQ9RSwnvWBbWzisdCd1JBxRyV6Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgRNkV9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C9CC2BBFC;
	Fri,  7 Jun 2024 15:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717772533;
	bh=uF8vT+OcPDdR5VdfX4WfqKuZuRJ7pOLHE27ORfVXlFg=;
	h=From:Subject:Date:To:Cc:From;
	b=OgRNkV9VGlIiqIjSZo4jIJWcrQzU0COGkyi78cBkg3cKtjgtogWfVZWKbD6CD5h8W
	 VRyfEsfQxh3Q8SpvnVep+nHhzruYU8tzsaV+GMyFRhD/1AsgWbzGmZyMpzsuo0kHmb
	 7Zt+JCeYOM8C0zz77ryy6E4LsA2I6/MmPsw0vQK22A8iR7P6SlZSEpBDV0JoX5n9GH
	 Z7t3YpRtBHvNJgAy0zvfFyBZFkBHsJnHJhre/wM1yMWaKzlD8cWJG43t0s0vb2kQy5
	 bx94E9tOdG71lD2bnPrCqMPjhrj/Y4rG/2HAIsZpoN9u1KViTFTuWCcpHfkKHTwrVh
	 XCaClJrwAOQSw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/4] mptcp: various fixes
Date: Fri, 07 Jun 2024 17:01:47 +0200
Message-Id: <20240607-upstream-net-20240607-misc-fixes-v1-0-1ab9ddfa3d00@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANsgY2YC/z2MQQ5AQAxFryJda9IRMYmriIWYogtDpohE3F1ZW
 L73898FyklYoc4uSHyIyhINXJ5BP3VxZJRgDAUVJVXkcV91S9zNGHnD386iPQ5ysuKryDvvQkV
 gmTXxN1ilATtBe98P4PwTtncAAAA=
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Davide Caratti <dcaratti@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Christoph Paasch <cpaasch@apple.com>, 
 YonglongLi <liyonglong@chinatelecom.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1437; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uF8vT+OcPDdR5VdfX4WfqKuZuRJ7pOLHE27ORfVXlFg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmYyDyXD9GnRwMZjOUY8pzRftCN0te079/gk33y
 QAyGVFlIjmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZmMg8gAKCRD2t4JPQmmg
 c+toEAC5Il+4G9yWn+KCtBNluOSVUDQ1BitLnWbvmxbZks94ofCsmkGIneSZlEx4E6dBjdq0OCa
 sRLtJ44sEd20/adnP4lBIEYhX1Nvdmgcokg9/8MkjhUMEsrDMtOVC4oXdd7Qny4q3eB7VEzw0AN
 SlIElE0hgYqucoXbSGLZQ+B19mhIryj2/iyD0pym/8mOckfybU3qls+9PyPsuZx7QWqEcMAFnL/
 VNl81+gke9qsq7+slP0T/I05fnqcA6VJTUy9d51g6FrEAutlFlYW31djKuIRYHmEDTO8kC+NKSq
 ewGw25W1To59re8VHRAFu2KNcyc9fBQIyZ4ilw1ntCRxa6W9f4RKQAfvBx0HoFudMfUIVRNw5ap
 ZBq9hLKDibELegf8ojRAO0IG2F36ATYVXRa8gqNtqkr0Rtd3bbA6qYJ+BuLVhVoz2bPf2W6jAvk
 Dko75mBdNWFvqKEZDZV4G0vbomOk+IDeyH7LA6Nwfn2X1buBrTgE9R29oI4a/DdKZJDmUJIwDk5
 Ig2j93I77bDntjyxGD1V5Dpj52qNxYmK7DSZVpWTOlZ0Nzx+rRbDJ1cjrlU4U146rOUJRYvwv7K
 nRC394Y0NlGcUeokkSBpy/f9jxmanVrtAYytUNQxY97e1zwfLg2Kw8CvtCwGAd83b3b1qZepwS/
 n39TKg6jAKJkx9w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The different patches here are some unrelated fixes for MPTCP:

- Patch 1 ensures 'snd_una' is initialised on connect in case of MPTCP
  fallback to TCP followed by retransmissions before the processing of
  any other incoming packets. A fix for v5.9+.

- Patch 2 makes sure the RmAddr MIB counter is incremented, and only
  once per ID, upon the reception of a RM_ADDR. A fix for v5.10+.

- Patch 3 doesn't update 'add addr' related counters if the connect()
  was not possible. A fix for v5.7+.

- Patch 4 updates the mailmap file to add Geliang's new email address.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (1):
      mailmap: map Geliang's new email address

Paolo Abeni (1):
      mptcp: ensure snd_una is properly initialized on connect

YonglongLi (2):
      mptcp: pm: inc RmAddr MIB counter once per RM_ADDR ID
      mptcp: pm: update add_addr counters after connect

 .mailmap                                        |  1 +
 net/mptcp/pm_netlink.c                          | 21 ++++++++++++++-------
 net/mptcp/protocol.c                            |  1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  5 +++--
 4 files changed, 19 insertions(+), 9 deletions(-)
---
base-commit: c44711b78608c98a3e6b49ce91678cd0917d5349
change-id: 20240607-upstream-net-20240607-misc-fixes-024007171d60

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


