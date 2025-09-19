Return-Path: <linux-kselftest+bounces-41934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4A2B8959D
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 14:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467553B1CED
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 12:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133E130DEA7;
	Fri, 19 Sep 2025 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tx5sT9GH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71212F291B;
	Fri, 19 Sep 2025 12:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758283758; cv=none; b=MtKyGJSmXyqwozwWycFQnpGpZAn8NgSIH6w/Y/WyCg71mZjfjyfJQg4uaiKjmWeEjLFtNTYn9Hv8IqLLrCW5QeeKaoYlw2AAAVAHkd35zlRURMP34V2os8PfyJROPwYXtTmyJnbyMhR5mTI3/RvS5hjjw6UcJLcVmMd4cRheSoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758283758; c=relaxed/simple;
	bh=1vul3IVIA/c9vDvm4EZdDOWTmAcYvFJnpooh0+LKVUM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z34Os+Sqtpzsisw5D0DY31SQ7Na1FdPG42UVEXbs/mPFGu+VRHb52YaQDaG4qXP+AQe9AbjA5mJK8uMKEXmgvGLF+rJQ10XCQsBR7X2b2PwroG8/ws6SoG7Al/IDi7/VXxqWWnleyz14CEhcd4wAyBpGTIhn9L9bo2qomRrKjQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tx5sT9GH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25DFC4CEF0;
	Fri, 19 Sep 2025 12:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758283757;
	bh=1vul3IVIA/c9vDvm4EZdDOWTmAcYvFJnpooh0+LKVUM=;
	h=From:Subject:Date:To:Cc:From;
	b=Tx5sT9GHMsXSrqbfsObfuyjSmnHv4/qOrVEh0wiALYzZne8hDDXrrdz6i3jORDBjP
	 lUEzk6J7jC3WytA+ht2T1k8B6EJQLCuFrhqhs7FtdY4TlOu80rFci7XeBTpLHE2LS+
	 OlZpdvmkcbJp4T2+DlRCjrUffI9OF43+zBzyp0veJWdXm/l/xpt1J0SSuhBCqrmIS/
	 4fidhyhPSjQTqR78wFyprgCFJn4l46AMBojyvyw5nCzvP67iaKatT36VvUWed7QbDw
	 m/mdF//fgjtBX5apFERlYyo8KccX7R5C8EVQQ+Rh/FIyhSxBg/U6xWZ1ANZQp6m6yV
	 +8raGRLllucvw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/6] mptcp: pm: netlink: announce server-side flag
Date: Fri, 19 Sep 2025 14:08:57 +0200
Message-Id: <20250919-net-next-mptcp-server-side-flag-v1-0-a97a5d561a8b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANlHzWgC/zWNQQqDMBBFryKzdmASrNRepbgQM0kHagxJECF4d
 4dCF3/xFu/9BoWzcIFX1yDzIUX2qGD6DtbPEgOjOGWwZB80mREjV91ZcUt1Taj6wRmLOEb/XQK
 SJ7KDeU7D6EArKbOX8/fwhr8M83Xdrpyme3sAAAA=
X-Change-ID: 20250916-net-next-mptcp-server-side-flag-0f002418946d
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1616; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1vul3IVIA/c9vDvm4EZdDOWTmAcYvFJnpooh0+LKVUM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOuj8qZ034LX/mtlSi+vVj6mu/tNfPPG29KFr2xkEpy
 XhfER2njlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgInEsTIyzOLYv75DVrKwsLN7
 lS2jTRnPn2mt7y7xCu4WlvrWeaePmZHhy5Gsn4VXNnnPU7Bs/nxf7Zwh90HZ255KzK3CTvlWwqE
 sAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Now that the 'flags' attribute is used, it seems interesting to add one
flag for 'server-side', a boolean value.

Here are a few patches related to the 'server-side' attribute:

- Patch 1: only announce this attribute on the server side.

- Patch 2: announce the 'server-side' flag when this is the case.

- Patch 3: deprecate the 'server-side' attribute.

- Patch 4: use the 'server-side' flag in the selftests.

- Patches 5, 6: small cleanups when working on code around.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (6):
      mptcp: pm: netlink: only add server-side attr when true
      mptcp: pm: netlink: announce server-side flag
      mptcp: pm: netlink: deprecate server-side attribute
      selftests: mptcp: pm: get server-side flag
      mptcp: use _BITUL() instead of (1 << x)
      mptcp: remove unused returned value of check_data_fin

 Documentation/netlink/specs/mptcp_pm.yaml         |  5 +++--
 include/uapi/linux/mptcp.h                        | 11 ++++++-----
 include/uapi/linux/mptcp_pm.h                     |  4 ++--
 net/mptcp/pm_netlink.c                            |  9 +++++++--
 net/mptcp/protocol.c                              |  5 +----
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c     |  9 ++++++++-
 tools/testing/selftests/net/mptcp/userspace_pm.sh |  2 +-
 7 files changed, 28 insertions(+), 17 deletions(-)
---
base-commit: 315f423be0d1ebe720d8fd4fa6bed68586b13d34
change-id: 20250916-net-next-mptcp-server-side-flag-0f002418946d

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


