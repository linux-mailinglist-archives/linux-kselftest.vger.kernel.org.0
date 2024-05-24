Return-Path: <linux-kselftest+bounces-10675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB3D8CE8AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 18:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5E01C20B52
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 16:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB7C12C7F8;
	Fri, 24 May 2024 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THm50Jyj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E67E364CD;
	Fri, 24 May 2024 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568268; cv=none; b=INLXUi+U0TwJpf0R7+KxL3BMVufnHX0FjzSJFsMj1HKxNvJsxcu+Ionfaozfzy5rBccUmnCL74rarOE0fvwLJS4+XJmV4Qh7YD2MsncAShMQOLL/OZzLSmRhvV/aMlhmekBb1kjtprLDfe/3pZH1kU3l4U5Jdkl/eVJj4WaGG6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568268; c=relaxed/simple;
	bh=/hhJ7Yey/FzVkrS2QNwcqbxXlf0t73S0oIkmlspyMi4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bjMUY5GxDN9XJv2xRnK4dpcbNSGXQ1/5UC5E3HmmgRR+N8/IDpBIknS+PWNkQQ2wgB7g1olskVjh+MNZvaNv5k3QqoBTdozVI9JnyrhOdwFVMGFI5CoCeaW608F+VOIHTKt1iLtmMmmIKoj4qQUBWmVGTKj7PQhfwtZcCR36Poc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THm50Jyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0A3C2BBFC;
	Fri, 24 May 2024 16:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716568267;
	bh=/hhJ7Yey/FzVkrS2QNwcqbxXlf0t73S0oIkmlspyMi4=;
	h=From:Subject:Date:To:Cc:From;
	b=THm50Jyj9De2hGeqKKDdAg5FezR5gYi+6hrVmalpDfIC59iBXQcF7QnBU//qhTLkK
	 Yy7ZIypSjJK9ELSSmR0X6VhDZtmuG9Ow/c9WmpKFSGiPfBi1Ippt24dWCKULR9RNq+
	 Pg1EIrEKYhYCrZmAvhgoP0JwxeuTTUYrVqflgTE0HdSi/d4quM59ARP3mxoTZoXfmM
	 IKxaD/AuJL4Lbokn0GigQobyYPPzVmQ7gUGKuxR6595yZK4iia/vGpNLC6N1oLa2RJ
	 HGE8xhih6MKlhHaVCE42T5HvXI7/zzlUAXZNXIPSRSbpZKXsyHrjIc0J274ivYBJH5
	 3YpOE1ghwfMEw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/4] selftests: mptcp: mark unstable subtests as flaky
Date: Fri, 24 May 2024 18:30:55 +0200
Message-Id: <20240524-upstream-net-20240524-selftests-mptcp-flaky-v1-0-a352362f3f8e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL/AUGYC/z2NywrCMBBFf6XM2oEam/r4FXER640OtjFkRlFK/
 93gwuW5cO6ZSVEESodmpoKXqDxShfWqoeEW0hUsl8rkWte13nX8zGoFYeIE4/+qGKNBTXnKNmS
 OY7h/2J/73aYPfh+3jupjLojy/tWOVH06LcsXhsjmp4IAAAA=
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1901; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/hhJ7Yey/FzVkrS2QNwcqbxXlf0t73S0oIkmlspyMi4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmUMDIaEszv+73tdZ0a4q6uSoAZkYnaLX2O9hyX
 QKNCYi9UPaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlDAyAAKCRD2t4JPQmmg
 c0IbD/wPaQgXH/X2pg42uDuXnJvwJut1E1qdZ1fQMkSvvAFrts4Z29M1ICAiqbMhJNjFnhp9Pa2
 8KH1bzg/8JasH9up4CEDA6cv2jpJgyipqTx7JoHBbUcRiS3sVg07d9GGlh9cAwdkfzdJ+iPGi/p
 3r347vPyQKMG9z2EwK0pLAU+MITp8ijyb4zf/juormgtVffOt0C6osLkTW3i9fJ9z3LSOqxLWY2
 /sfFONa2D6STp2x/kkqc1v2GyLB20eDcLr2+iOfkI1XIEeZSPBJdSRHNjo1XgI3zrHoeCO8SMSW
 lxrh8ogDhjkWiu90RNPxfcYq5EhFgrkaknPHi1U7vrkH7ioj6BtIkX0E1yf9NpfmtSBoNvrK8eU
 NmS/qUB4+F8Vfj3cegch2iJBOtajkLXBZXlBNFupK6SbAHk0/nvEl2heDGoqao428fV0MNQ4PYV
 q9wq/XLCmzfeqyREFT4VrmVgxHW2uNoIhy1pW2MtA0u5UdyCCC2MP1yUGXBdz9FlTbQMqb3iPfc
 f/Lwea1wvCvo/Dkyc3HIeT94u+fxrnZKDs2rMkFs3vWXv5pupLd0TXqkczhjuCelOL652It23aU
 3jq/14Sy0vJ63kmi9nIUby5LYLYOO9lgUlIZtHASRpTj5+B1b53MEK45mP/cr9Mzx31iDig++zy
 QgCr1aut/T61AbA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Some subtests can be unstable, failing once every X runs. Fixing them
can take time: there could be an issue in the kernel or in the subtest,
and it is then important to do a proper analysis, not to hide real bugs.

To avoid creating noises on the different CIs where tests are more
unstable than on our side, some subtests have been marked as flaky. As a
result, errors with these subtests (if any) are ignored.

Note that the MPTCP CI will continue to track these flaky subtests. All
these unstable subtests are also tracked by our bug tracker.

These are fixes for the -net tree, because the instabilities are visible
there. The first patch introducing the flake support has no 'Fixes'
tags, mainly because it requires recent and important refactoring done
in all MPTCP selftests. Backporting that to old versions where the flaky
tests have been introduced would be too difficult, and probably not
worth it. The other patches, adding MPTCP_LIB_SUBTEST_FLAKY=1, have a
Fixes tag, simply to ease the backport of the future fixes removing them
along with the proper fix.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (4):
      selftests: mptcp: lib: support flaky subtests
      selftests: mptcp: simult flows: mark 'unbalanced' tests as flaky
      selftests: mptcp: join: mark 'fastclose' tests as flaky
      selftests: mptcp: join: mark 'fail' tests as flaky

 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 10 +++++++-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    | 30 +++++++++++++++++++++--
 tools/testing/selftests/net/mptcp/simult_flows.sh |  6 ++---
 3 files changed, 40 insertions(+), 6 deletions(-)
---
base-commit: 0b4f5add9fa59bfd42c1030f572db2e4c395181b
change-id: 20240524-upstream-net-20240524-selftests-mptcp-flaky-5b6836a59f72

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


