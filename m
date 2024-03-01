Return-Path: <linux-kselftest+bounces-5750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5C286E81B
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 19:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9B81C22719
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 18:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C807E10A26;
	Fri,  1 Mar 2024 18:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raarnnWk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B564C9C;
	Fri,  1 Mar 2024 18:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317112; cv=none; b=F3dfajLJ8eZqhv3G+yXzkilFtmR1lzML6X+nSl/kcHFKw0JBdg5F2Je20c+szij1sqHeh6aAaRWijO9dZtbPFmMR+itR4zlWsMmaoMKF1mHUtgXwuXJk1tflIeb9XJiCZAe4ZJcGVzYOgDEu7Aij8YpStPPFzUXWfP1VmxL0P6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317112; c=relaxed/simple;
	bh=hii28PLD1bwknV2BFNP4Zmy1bCwPNwEFF1J44mOUCqM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fAAQHsvNmi/MJKpkPr5JAMcqS4/W4+BSSQraInh7LV8zWbawQMXEkwp6tUdwnHudXF5asFuB6U+vKtTq3DPl6/0UnAvWIB398/MT8dj8Bf3j5aRTVNMZYiWjOY/nrnBFP3CcFCnvEGljB1YJALeLJ9v34KKTPIADpYDNBm0G2PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raarnnWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C6FC433C7;
	Fri,  1 Mar 2024 18:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709317112;
	bh=hii28PLD1bwknV2BFNP4Zmy1bCwPNwEFF1J44mOUCqM=;
	h=From:Subject:Date:To:Cc:From;
	b=raarnnWklT9jpRcOoBZFl6h1NxKkJpYlXgbYel+W3ftrVXkxsgJ41ddborR4psNS/
	 /MDZNSu+wlwC2NFSXLOqBD2hlhkZ94eaeXX2gMD1rxaVkn7HHkRvGXoq+F6lJZp3A6
	 et+266Fou+pSOdUneDi4vvFEj1W9914Lw4qzLgXenStwpXJdIg/IzoXWJKqlTYeKFD
	 Ry04fFSSXYY+9T3m5M2ijYORSQOBOl/XkaitrLUsqp5wdYZxLP7aOSnhTUEnEXdqw2
	 pKIDkrBQpbBnOAQjMV8fT73OTfbFktSL9L1b8SzQVexMSdndAQl6WVJ0UcQPQee5HM
	 bt4q2bmQbV+pA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 00/15] mptcp: userspace pm: 'dump addrs' and 'get
 addr'
Date: Fri, 01 Mar 2024 19:18:24 +0100
Message-Id: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-0-dc30a420b3a0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPAb4mUC/z2NQQrDIBBFrxJm3QHHSqG9SulCdNK60A6OlkDI3
 SOFZPEXjw/vraBcEys8phUq/5KmbxlAlwnCx5c3Y4qDwRrrzNUQdtFW2Wcs3MaWhueVpQXBPow
 qPjBKxtizoI+xorU00+3uAzkHwy6V57T8y084XPDath1BAGB/kwAAAA==
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2416; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hii28PLD1bwknV2BFNP4Zmy1bCwPNwEFF1J44mOUCqM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl4hv0qXXi2pXUkV7y7yjrHS7HwrwOPZ/1EYZbH
 itzYafUsJyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeIb9AAKCRD2t4JPQmmg
 c+GMD/42HpNBuHgUvTTb/42tKofmvayz9EPKKd0qpvDdJqh+iPHGbR5uxJJoDL6bLrQIuP7ysTi
 ZMO3aPj/BmxsDOP5eaUyv81tj7oUkiY58IVrd5W5PJ0876I6gGO3KKjRo+4QEPu6fsQGAWeFPAv
 bqQx7GCjMBJiGMmHtAeCJbN6YGMaoEmUW4qqHek1itUerzHptVwSt+b8mk8SnxB+5TCEsW7lcBT
 UW7nRzwsz12OApqRSUK1tj+Es+3tPz33t/6GAqIOel7to/TUMck98DgEz2EHj+ur3A3dg7J6+xU
 Qg5unRI/ZjsuGDB2e1s3SrEnpeE0Rq7Lmw5KhsoHVsR7MwNSn1hu2Z17fzALEZ1MJasbZZo1yPO
 qkx/XH+gzZTW1MzDicaWJGSyELucPDSQ3wT5lmWPIBEGiOPbUj5abJAS8Ctu0jAhRcfbphz44Nl
 KOqSYIWcU6nPBXS7qSolqxAv50q9m8002Y+qyo83ifIrwL9RcYWOUesAG/t48OfTgmXud4IPE4k
 ANlzyY4w96krs7403U1U1NVZmP0vW4XYw/i8h6UfgeH+NyyK3oRTUpLNg9RSeGYme/JnRktKd1E
 su2ggXsccf6u5a1zsBQtAVPX+DF/4FVLcPLYgM3MQNXDOqfHhe2w3bgZAnecX1KRs8CNIjjFWNn
 cQcppVyZcyK6Djw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This series from Geliang adds two new Netlink commands to the userspace
PM:

- one to dump all addresses of a specific MPTCP connection:
  - feature added in patches 3 to 5
  - test added in patches 7, 8 and 10

- and one to get a specific address for an MPTCP connection:
  - feature added in patches 11 to 13
  - test added in patches 14 and 15

These new Netlink commands can be useful if an MPTCP daemon lost track
of the different connections, e.g. after having been restarted.

The other patches are some clean-ups and small improvements added while
working on the new features.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (15):
      mptcp: make pm_remove_addrs_and_subflows static
      mptcp: export mptcp_genl_family & mptcp_nl_fill_addr
      mptcp: implement mptcp_userspace_pm_dump_addr
      mptcp: add token for get-addr in yaml
      mptcp: dump addrs in userspace pm list
      mptcp: check userspace pm flags
      selftests: mptcp: add userspace pm subflow flag
      selftests: mptcp: add token for dump_addr
      selftests: mptcp: add mptcp_lib_check_output helper
      selftests: mptcp: dump userspace addrs list
      mptcp: add userspace_pm_lookup_addr_by_id helper
      mptcp: implement mptcp_userspace_pm_get_addr
      mptcp: get addr in userspace pm list
      selftests: mptcp: add token for get_addr
      selftests: mptcp: userspace pm get addr tests

 Documentation/netlink/specs/mptcp_pm.yaml       |   3 +-
 net/mptcp/mptcp_pm_gen.c                        |   7 +-
 net/mptcp/mptcp_pm_gen.h                        |   2 +-
 net/mptcp/pm.c                                  |  16 +++
 net/mptcp/pm_netlink.c                          |  30 ++--
 net/mptcp/pm_userspace.c                        | 180 +++++++++++++++++++++---
 net/mptcp/protocol.h                            |  15 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  91 ++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  |  23 +++
 tools/testing/selftests/net/mptcp/pm_netlink.sh |  18 +--
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   |  39 ++++-
 11 files changed, 374 insertions(+), 50 deletions(-)
---
base-commit: e960825709330cb199d209740326cec37e8c419d
change-id: 20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-221f169ac144

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


