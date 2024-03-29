Return-Path: <linux-kselftest+bounces-6871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A622A891854
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 13:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C0A1F227AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 12:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408FF8529E;
	Fri, 29 Mar 2024 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObGfya8Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CF4F9E9;
	Fri, 29 Mar 2024 12:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711714167; cv=none; b=rqwfs5fq1jSBxQJLVnjsHWfypW+1LGRFhOi5bslIZLb8D2TD6m4DcKOro36jt9045sf+k6u9sLAOySAnghaTgkiQD6UkB5HNgvpb4Q91PrNgcyg+S2pdS9SgFahRyiWBKG3RUBDFLsZ10WC5CjH4Oc2Rm3D16VaV3rGafy2JpTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711714167; c=relaxed/simple;
	bh=m+3PhEuKQY8IdjbEtysl1BbGEhPFQoeJQ+TKvYfzpZU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ka95hfjrh1XB//aXtctVlHDnhKUQETTkzQm8fBTiWI71LVJGJTk7XfYxWe4rFA6Z8NSdOMNJ0098Gqaoqp4mLu2YbulRQIylFeC+B40pn7dtzxISJ4BVhRxzB29rhK0cZgkJpX0bATCbSP7b4ugAfeW+N05I/RP3yhu7UYKAwBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObGfya8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340D7C433C7;
	Fri, 29 Mar 2024 12:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711714166;
	bh=m+3PhEuKQY8IdjbEtysl1BbGEhPFQoeJQ+TKvYfzpZU=;
	h=From:Subject:Date:To:Cc:From;
	b=ObGfya8YPEdDQenbAnfrzuc9L2FkYhvYXgL4uSCnoersXEReqVlEyjj7HaTB3Qtc5
	 eWITMoKe7AXYP/380QXbpImTAfs5h8cajYw7+AH29jPcdtm1lWAEj7uT/qjYiYxVlC
	 V6OBfxh59UwtCUrhQSc8s46bx2BczxSTFVeTXeCZAThNNMHQ7rAGULOa2Yb/Pwv7qe
	 yUh1ZQ42LEWiJyLmJ9mKDP22yqQpsSxr8RkHEcQ8WiVWp34O5rHefGMWeM54XDYqsL
	 VWXK7GyI6mpAl/w2PwrgkTAPM7WzGui2HdVqMzcQWNyGymjfrNW9HEeiPLiKCXQdmb
	 BxwoxFW2r7P0w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/2] mptcp: fix fallback MIB counter and wrong var in
 selftests
Date: Fri, 29 Mar 2024 13:08:51 +0100
Message-Id: <20240329-upstream-net-20240329-fallback-mib-v1-0-324a8981da48@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFOvBmYC/z2NQQrDIBBFryKzzoDaEmquUrJQO6ZDEhvUlIJ49
 0oXXb4P778KmRJThklUSPTmzK/YQQ0C/NPGhZAfnUFLfZUXbfA8cklkd4xU8L8Gu23O+hV3duh
 kIG/8qG7GQT86EgX+/CJ36BrMrX0BdRXQ+nkAAAA=
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Davide Caratti <dcaratti@redhat.com>, stable@vger.kernel.org, 
 Christoph Paasch <cpaasch@apple.com>, Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1366; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=m+3PhEuKQY8IdjbEtysl1BbGEhPFQoeJQ+TKvYfzpZU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmBq9yDXv9ElWpwWReyDotfD+mjvsIUrG24E2sr
 S+OAHR+zn+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZgavcgAKCRD2t4JPQmmg
 czW9D/9eoNJNMauADyIM/SBxJ6E7RitnO4DQXAtkVtGXDWIbuW6dLozfPSmO/QYHkjEgqafQw89
 GcYPmNCVjizfXMk06ai1YK0o54BbUWofDgfCKRC8x7aQ98psGPBLRogYkUYCbKz00KRQxL+tmcO
 wOOnwYvsSg6iEnZcNB0qYcLsba83yikJBaTxSYdugf3IL0kosIgOc6xkC1k7l11APLaw9IXOYgY
 6NGJH6Ny4wxkzKOyJnbu581INx/p9RauQPezZknXbGDDf4k9CHP9EEN3kbZ6aT5fFINS84034j4
 RfYNRQ0kz6JeQ6y1Ul19FkCPoBK0ET3UM/xPfXNIIY0iDSflCj7FlBArwSf6vnYfbzH5HZAuP2d
 ycd4qSYyd4ckiquTLw95x0IQxNC1C/wqmSxBA1xqN7KSBHxGrPMXVVRzhs7hBcEU7rmUB0KcVfF
 MzF87BjnOUTpo4Sd9wk31PpWsaw6GygGXcaksJO65Fcw0SPIQcA3Fd9xM7aKYymAklSgpOEISpz
 YMNaxf2z6r4ebPNhtR4pu8Tp1MqkS11W3xyfeFwlh2PV1TAOh2oyjisZ5NVB4BV9G6DYThaMD58
 Gudpsjgtwfi+wDb3fAqFnmrz5weXdEkktfryN4+QZM0O5uvuIL2Q2hnaUVnfW37f+ZQ4G2G8hzQ
 n/4UWBRMpfZbbSw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are two fixes related to MPTCP.

The first patch fixes when the MPTcpExtMPCapableFallbackACK MIB counter
is modified: it should only be incremented when a connection was using
MPTCP options, but then a fallback to TCP has been done. This patch also
checks the counter is not incremented by mistake during the connect
selftests. This counter was wrongly incremented since its introduction
in v5.7.

The second patch fixes a wrong parsing of the 'dev' endpoint options in
the selftests: the wrong variable was used. This option was not used
before, but it is going to be soon. This issue is visible since v5.18.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Davide Caratti (1):
      mptcp: don't account accept() of non-MPC client as fallback to TCP

Geliang Tang (1):
      selftests: mptcp: join: fix dev in check_endpoint

 net/mptcp/protocol.c                               | 2 --
 net/mptcp/subflow.c                                | 2 ++
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 9 +++++++++
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 4 +++-
 4 files changed, 14 insertions(+), 3 deletions(-)
---
base-commit: 0ba80d96585662299d4ea4624043759ce9015421
change-id: 20240329-upstream-net-20240329-fallback-mib-b0fec9c6189b

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


