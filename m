Return-Path: <linux-kselftest+bounces-7259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8923F899B3A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 12:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B55283ADB
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 10:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF6E16ABC0;
	Fri,  5 Apr 2024 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCn6Daww"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AD64D5A0;
	Fri,  5 Apr 2024 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314345; cv=none; b=tko09H/k2dQrBX/jVIegZwyiHdxdStr/RpW01xWifEe0Uk/qZRaJ87rKZBLohRkD7oGhf8ibHGXGEPTSm/9UBeoysxf6I+vFaQVmOrJM8Jyf5UFSwr69/oNXGaKVNGiXvtOh7mO45MH48PgZDCXvEYvhAsztSkS3jDObxJSprHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314345; c=relaxed/simple;
	bh=4cBVJpU3X7dIPVhhAjRHxZNJxNztq5qvGbJcVAE20BU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gowANXjRmcQC7JTITPd4fYWMmxfb4ELK1GHQ5MzjEg3ksmsCjqBjeVyoWrchYIoWXqHbFxJpAh0L1t7Asm7Gwm9IWP4B0GCwe4SWW336YxjVZekPJ6Fq5xxW9DnKT2wfeFt8Kkhqy4i/kwCxsjnhj5dFI7BEbTJNIO7wRjVdzVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCn6Daww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC9DC43390;
	Fri,  5 Apr 2024 10:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712314345;
	bh=4cBVJpU3X7dIPVhhAjRHxZNJxNztq5qvGbJcVAE20BU=;
	h=From:Subject:Date:To:Cc:From;
	b=XCn6Daww1ja7WDSrTWVmIBsTV4ZbHSes9xE5mT1NXsrZYmHO/SvAW598Y7uuptVHe
	 lu45Kunek03tCxEnLcRu/I+cwKuHudsjO5pQX02j9MI7c28/Dk75rGd4/rilrNxYVI
	 ndrFp52KOSvF7cUoieNX7AOauIID34Jfi5wkJv83XLv4Bm9h1bA0Zjcl6voodXZp2s
	 1lynq6erZ9YMt/+S6PZuC3eSczW1xQMwTDso7vj7DDWj0tp48g1BSTEHcR9P3uah/2
	 aGfl/qCX4tecd8DINOFaFW+gKPC2/jyLBzklcLXy4yMh97d6eOJqNfkWo3z5/liaCt
	 vxynNWf4avARw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 00/11] selftests: mptcp: cleanups and 'ip mptcp'
 support
Date: Fri, 05 Apr 2024 12:52:04 +0200
Message-Id: <20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-v1-0-eabc9b960966@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANTXD2YC/z2NQQrCMBBFr1Jm7UAsLVavIi5K8lMHbBoyUymU3
 t0g6OIvHg/e30lRBEq3ZqeCt6gsqcL51JB/jmkCS6hMrWs717me16xWMM6cYHWb8V/N2XxmxSs
 a1JQL4uhtKZImjj3C9TK4EAdQjecqZfse3+mXosdxfAB7AfHukgAAAA==
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2201; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4cBVJpU3X7dIPVhhAjRHxZNJxNztq5qvGbJcVAE20BU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmD9fkPXcohyMDtCEsZR+mIMb7dP47N2VzOCJmN
 8CH0mzsHeKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZg/X5AAKCRD2t4JPQmmg
 cynDEACsEXR+NP3YiPx+QfKZNq1fnfb4M3E0g1eEQ4S7y7q83c8YttaLBlXpr1rWKZWYkKIrmhA
 ZOfGKn8Rf/fFuERD9c/1LkC+mt/oTj+jvEy6/LL19feXRMquk7Ec6voYdUUgaVp/nEw2F+2xvh1
 lFz2siigg1W7uunqpLkWdq9dqqcfZBZsd3oEMJqoHZnoTjmuj2u56PlbFMTqcisdQyIcO0zKAQu
 31xZpJL8HNILFPBokZtHc9foir/3somMv+wR7YdYHZhx+70RmElL6FLyDG08Z1QzPpsdqTlZH9Q
 w0GssY69oJ/5NfuZnwifbNN4aZCwjuSv/d1GM9MK8GEIwhbDkegdStOUNCpwfluG8qXnFC+YSeJ
 1A6C2HKXSTPtqwiGIwrUsh/RBLJEzvFiCRihrX+fxUPrwq+pfqEXyruzpY1uG6omquVDAkVzAOU
 oNOTCk+JV3dTZ6q8zS2oOE4guCiWpYiilEq8e6RaDyiYY+R7LmTqikUuhwIoZi7Z4K2fd+hFzdD
 TWFWNhjQLRVWpv12povcafhSxgiLMk9ew+RPYy6Oq92YdKPyHQXzgIHbrJKO4wgPBBUBJcIJYti
 w14xXE4d/ReUhsDAzo9O1Z/yI6r1vFB4GM1jLA3DLtGpmDBU4AqKJz5sx1vPajkrDHcd00E+Br3
 VlVvjjLKvISBCTA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are some patches from Geliang, doing different cleanups, and
supporting 'ip mptcp' in more MPTCP selftests.

Patch 1 checks that TC is available in selftests requiring it.

Patch 2 adds 'ms' units in TC commands, to avoid confusions.

Patches 3-9 are some prerequisites for patch 10: some export code from
mptcp_join.sh to mptcp_lib.sh, to be re-used in pm_netlink.sh,
mptcp_sockopt.sh and simult_flows.sh ; and others add helpers to
pm_netlink.sh to easily support both 'ip mptcp' and 'pm_nl_ctl' tools to
interact with the in-kernel MPTCP path-manager.

Patch 10 adds a '-i' parameter in mptcp_sockopt.sh, pm_netlink.sh, and
simult_flows.sh to use 'ip mptcp' tool instead of 'pm_nl_ctl'.

Patch 11 fixes some ShellCheck warnings in pm_netlink.sh, in order to
drop a ShellCheck's 'disable' instruction.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (11):
      selftests: mptcp: add tc check for check_tools
      selftests: mptcp: add ms units for tc-netem delay
      selftests: mptcp: export ip_mptcp to mptcp_lib
      selftests: mptcp: netlink: add 'limits' helpers
      selftests: mptcp: add {get,format}_endpoint(s) helpers
      selftests: mptcp: netlink: add change_address helper
      selftests: mptcp: join: update endpoint ops
      selftests: mptcp: export pm_nl endpoint ops
      selftests: mptcp: use pm_nl endpoint ops
      selftests: mptcp: ip_mptcp option for more scripts
      selftests: mptcp: netlink: drop disable=SC2086

 tools/testing/selftests/net/mptcp/mptcp_connect.sh |   2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 155 ++----------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 135 ++++++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  34 ++-
 tools/testing/selftests/net/mptcp/pm_netlink.sh    | 281 +++++++++++++--------
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  20 +-
 6 files changed, 375 insertions(+), 252 deletions(-)
---
base-commit: d76c740b2eaaddc5fc3a8b21eaec5b6b11e8c3f5
change-id: 20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-f5ed9780df8e

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


