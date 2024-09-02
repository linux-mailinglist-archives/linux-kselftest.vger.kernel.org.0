Return-Path: <linux-kselftest+bounces-16937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B14968512
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 12:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30A05B22C75
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 10:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4E115FD13;
	Mon,  2 Sep 2024 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4h6tffD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B86156B7C;
	Mon,  2 Sep 2024 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273969; cv=none; b=cMbwoWHly2eGS6TW4gd+JmpuNemRlFs7X0dXGtrmgLKPX8xVE+0v6dqLou4g451c+QqPBez5RR2mgptfBF7QvOrtAwXCrs+9jG21tVVCL5Al94CJjV9oemO3KhrE5eSBrCA6T0J4ZvpSIKHjWYnylXS1Hx3a8iCgwgqa5yOZYDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273969; c=relaxed/simple;
	bh=JZjtdwQfSEp8GA124fcMpM+PxDlG3oF/fyGd7aXpRh4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uGJYkrjZrFrmQEoF+ZwSy4xsOwsAYI0wgkBhy2Ecdj+/ZsiJaGrEvFSICNyF4OeikZLr7kWkV2rx9zXWZm4erHtqCNdC8aGtR2T/XlJuU35I5meQuoQXpwIGowwIrutlaTPYsShS51zu5AShZRGfjqZ9MUCZHWtOjn1pRA961gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4h6tffD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62127C4CEC2;
	Mon,  2 Sep 2024 10:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725273969;
	bh=JZjtdwQfSEp8GA124fcMpM+PxDlG3oF/fyGd7aXpRh4=;
	h=From:Subject:Date:To:Cc:From;
	b=i4h6tffDcd0lRuLY/mgKx5uSgS8HjkThv9StR6Lvyiz8gBTUd9yQYxsk/X0ylCWle
	 9opFLUHlEAB4otes39jbetOavpss+qjpIxyUf+Mk0B6yEzicG/9ZDRjhaXId2Ds8tM
	 G3Ui/b2wuhEPT5IiOKmWQUtgmhNBKcx4JG5u6N3exVHJQFvf61ooXdInt8+SOpA077
	 J+RUqmECcah7fZfcaYcrI/xhELGAoztGKPrP7/N2/knoYVF8qBcxhvkpv3TohGONM1
	 aSQPODGK+qM6OEmkJeaD0jBoAPNqgHN9+mdNm+3ZqgJ5I+uxLW+zTFpp+BE9NPE018
	 SETRk2bilBTFw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 00/11] mptcp: MIB counters for MPJ TX + misc
 improvements
Date: Mon, 02 Sep 2024 12:45:51 +0200
Message-Id: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-0-d3e0f3773b90@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF+X1WYC/zWMQQqEMAxFryJZTyB2ZKheRWahNaMRrKUtUhDvP
 kFw8eG9xX8nJI7CCbrqhMiHJNm9Sv2qwC2DnxllUgdDpqGWDHrOupJxC9kF3GRUWnNRSg4nS6a
 1zdtS/QFthMg/KXe/h+cK3+v6A2CKXRR5AAAA
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2953; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JZjtdwQfSEp8GA124fcMpM+PxDlG3oF/fyGd7aXpRh4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1Zdtiw8kWDftZWvx84/2hCxkcRC3HiCSNv1fD
 7hl+94VRDOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtWXbQAKCRD2t4JPQmmg
 cylnEADqL9SfjVBe7EZSSSAV0VWYXqnQpwFYKfa+LValfOeYrGwia4YDquvoAC33HtCGzDG/F+u
 Y5ZGBPwldJnniGFGFxQZE47yEZThSxnM1LZpWGOY5hlfpaO6a3WXO0Y9Ad6BasFO2+25Kq7y30D
 AcIiStDtzjwNDk5tqvsLEjL8bb3B3i/s0F8H2B11w5Hk/R0KDb1SCmbmAqxBiGRBugQD+sOkPM3
 pBtt1B2YBi3MGHHo7FMRkHHbtJnuHK2OGgwX4b8l/xczX8zFnkEsjoVfUuptVDKhqDK403jCU/U
 xjsLYmjMlECMuyBgWeCkNMDqOQeeZAsV1hEKxYFrdtLTtXwGVneiryUBUUx/wRNiyhiUjKrCXpp
 A6by0rP29WTctfTK4CMnnY2kq4pZfaMLknCmdPAwXmRyZN+Al6wFKNXC3Sw3p4TFXdHSFClpZzd
 LU6mBiWT6lOsHpXm+FpnnxCTBA3G+/TKMSJL11GRgRODzE7W7qUod6O6Po+/cQ0FtiHTBl/FE4Z
 mdmNwQeuecVSy59CrMzjDr8CBzJoenSQgzbCpJFEgV0TYECUmvNFygEJytNCPntbgint+OucLSG
 qMvnVetSHeILE1zHGLwgU9T/cAX7CHbRudvYhsjcpaiKWj8e9dVkeNMPo99jqUpxD73sjeRzTPH
 XTbGtMmlaxDaH5Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, a few issues have been discovered around the creation of
additional subflows. Without these counters, it was difficult to point
out the reason why some subflows were not created as expected.

In patch 3, all error paths from __mptcp_subflow_connect() are covered,
except the one related to the 'fully established mode', because it can
only happen with the userspace PM, which will propagate the error to the
userspace in this case (ENOTCONN).

These new counters are also verified in the MPTCP Join selftest in patch
6.

While at it, a few other patches are improving the MPTCP path-manager
code ...

 - Patch 1: 'flush' related helpers are renamed to avoid confusions
 - Patch 2: directly pass known ID and flags to create a new subflow,
            i/o getting them later by iterating over all endpoints again

... and the MPJoin selftests:

 - Patch 4: reduce the number of positional parameters
 - Patch 5: only one line for the 'join' checks, instead of 3
 - Patch 7: more explicit check names, instead of sometimes too cryptic
            ones: rtx, ptx, ftx, ctx, fclzrx, sum
 - Patch 8: specify client/server instead of 'invert' for some checks
            not suggesting one specific direction
 - Patch 9: mute errors of mptcp_connect when ran in the background
 - Patch 10: simplify checksum_tests by using a for-loop
 - Patch 11: remove 'define' re-definitions

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (1):
      selftests: mptcp: join: simplify checksum_tests

Matthieu Baerts (NGI0) (10):
      mptcp: pm: rename helpers linked to 'flush'
      mptcp: pm: reduce entries iterations on connect
      mptcp: MIB counters for sent MP_JOIN
      selftests: mptcp: join: reduce join_nr params
      selftests: mptcp: join: one line for join check
      selftests: mptcp: join: validate MPJ SYN TX MIB counters
      selftests: mptcp: join: more explicit check name
      selftests: mptcp: join: specify host being checked
      selftests: mptcp: join: mute errors when ran in the background
      selftests: mptcp: pm_nl_ctl: remove re-definition

 net/mptcp/mib.c                                 |   4 +
 net/mptcp/mib.h                                 |   4 +
 net/mptcp/pm.c                                  |  11 -
 net/mptcp/pm_netlink.c                          |  78 ++----
 net/mptcp/pm_userspace.c                        |  40 +--
 net/mptcp/protocol.h                            |  16 +-
 net/mptcp/subflow.c                             |  50 +++-
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 350 ++++++++++++++----------
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   |  10 +-
 9 files changed, 309 insertions(+), 254 deletions(-)
---
base-commit: 221f9cce949ac8042f65b71ed1fde13b99073256
change-id: 20240902-net-next-mptcp-mib-mpjtx-misc-d80298438016

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


