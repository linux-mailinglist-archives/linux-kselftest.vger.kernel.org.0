Return-Path: <linux-kselftest+bounces-37270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F4BB044BB
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 17:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED5917795D
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 15:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30D925A2C0;
	Mon, 14 Jul 2025 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1CnJ7K4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD49B23B628;
	Mon, 14 Jul 2025 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508370; cv=none; b=MI+iDVH3602b9L6Ebjk9XoxVbIMW4o1yYvhXToBqfGhWyEM00SDD6L41hyGFLs9JxktG7P1j3SYDVzXxxCwsDszwfO+evcKi+QXtM0zhyBLP/7Waz1x/UkCF7oXsbo/FTvwMlTn65XcrLzIvK7Ic92npXeHHOzMrURpoK7NAVWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508370; c=relaxed/simple;
	bh=m/4XxkZsjQtI55V6R8/mJKmYNOcbpabiQbJJFRp7Bwk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uG/43XtentdROTOWvxLnQJx6uli3aMTenC6Jf6gDjRhnzMAnysrOk3dcUlF4jOSuBwP+EiQrYrD21KjRPYplbSLzundkCfKrTbp8m/oJCAtIjJJfbmg/JdlRlV6I56FD+cBNCS+rqOSNt+WaXPWEHM97ToCRcbdfdyhuLanwY8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1CnJ7K4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613D5C4CEED;
	Mon, 14 Jul 2025 15:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752508370;
	bh=m/4XxkZsjQtI55V6R8/mJKmYNOcbpabiQbJJFRp7Bwk=;
	h=From:Subject:Date:To:Cc:From;
	b=n1CnJ7K4VT+/sxdpnB4yRZ2Pju2WvS2BsRuegOqgfq+Oysyuc1KwMIKjqMUIEvc7E
	 qnRo3ZJkFThy8UPhOnF33bYEgeALoYgWFVhTQLlc/3HgBM/NILw44S69iii3iZmETo
	 0uxunAaA0G2CjJlzaJ6bX2J0PeyhYvSID7zaWV7ro0Hwyd5ib1TsB3zjPFUlf1dORV
	 nd1K3TQ2pRtHNsVJ4K26cWvWl9kNqmPD1MSxpZVtN+eQelQsPujPOejSz1wC8pc9AQ
	 f2DIQ6/eQSudqsOzBpviplHnQRt3IVrpLBJNCdEDLgExG87I8aVLnBfPfrVahJ/iz+
	 xtCx2qHCHfivw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/2] selftests: mptcp: connect: cover alt modes
Date: Mon, 14 Jul 2025 17:52:31 +0200
Message-Id: <20250714-net-mptcp-sft-connect-alt-v1-0-bf1c5abbe575@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL8ndWgC/x2MzQqDMBAGX0X27ELiD0JfpfQQ4pe60K4hCSKI7
 96lt5nDzEUVRVDp0V1UcEiVXU1831Hcgr7BsprT4IbZLX5iReNvbjFzTY3jrorYOHyMfQjJLSP
 SBLI+FyQ5/+8nWUav+/4Brnw5NnAAAAA=
X-Change-ID: 20250714-net-mptcp-sft-connect-alt-c1aaf073ef4e
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Christoph Paasch <cpaasch@apple.com>, 
 Davide Caratti <dcaratti@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1395; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=m/4XxkZsjQtI55V6R8/mJKmYNOcbpabiQbJJFRp7Bwk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJK1U/vTaipYtlg5paoyHuucLX6vOsvZCqM1m7vrbLIe
 37e6vTqjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImIhDP8FdVIvZX1tflkper1
 6mqBpTcedJjzTWc/9ez6UxGW19rsXxj+6aix/7bKXf3z2gPPUIvfy6OOeATemiPv7f5m9cyIp3/
 F2QA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_connect.sh can be executed manually with "-m <MODE>" and "-C" to
make sure everything works as expected when using "mmap" and "sendfile"
modes instead of "poll", and with the MPTCP checksum support.

These modes should be validated, but they are not when the selftests are
executed via the kselftest helpers. It means that most CIs validating
these selftests, like NIPA for the net development trees and LKFT for
the stable ones, are not covering these modes.

To fix that, new test programs have been added, simply calling
mptcp_connect.sh with the right parameters.

The first patch can be backported up to v5.6, and the second one up to
v5.14.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      selftests: mptcp: connect: also cover alt modes
      selftests: mptcp: connect: also cover checksum

 tools/testing/selftests/net/mptcp/Makefile                  | 3 ++-
 tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh | 4 ++++
 tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh     | 4 ++++
 tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh | 4 ++++
 4 files changed, 14 insertions(+), 1 deletion(-)
---
base-commit: b640daa2822a39ff76e70200cb2b7b892b896dce
change-id: 20250714-net-mptcp-sft-connect-alt-c1aaf073ef4e

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


