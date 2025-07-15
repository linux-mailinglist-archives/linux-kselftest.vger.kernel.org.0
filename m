Return-Path: <linux-kselftest+bounces-37375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238BDB0662C
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 20:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BEF3BB279
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 18:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3E52BE63B;
	Tue, 15 Jul 2025 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJbhMDqn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BAE1DE2BF;
	Tue, 15 Jul 2025 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605025; cv=none; b=elq/EdMlCm9bFqA9oOHeRWauwPZ0PL+vC7DL2yPc1N+/HbPAudomxoKh9TxeABe9Z0iA5Z6Y71T22hq8sF8HrOs/xwgzS7DT71umHhgXmr/zwEEW/kYoHrwkgHpsXGw6ZK3SSSd8hoR++Cu9Dgm3K9XpAVSZMDireDYfmzjWCf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605025; c=relaxed/simple;
	bh=hnwA/Cl94G/uuXZ1hoCLu04p0joBovLqTgYpqqTRKGQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CneSrd/R/md5eDs6S2jopMMzUpRtztk9Gxz0aaeq+UuRmOr3Tkfui7dXgKQYBio7sq31DghoMfL+g/5WO0Gf1btMS94Q1LWPtBPUe74nSmL5RaTsIJsAoytBMZeijVO81w4p7p3/t9U5o7uFj6ijflfyvYxhzBF0rk1EezhSL/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJbhMDqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928DDC4CEE3;
	Tue, 15 Jul 2025 18:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752605024;
	bh=hnwA/Cl94G/uuXZ1hoCLu04p0joBovLqTgYpqqTRKGQ=;
	h=From:Subject:Date:To:Cc:From;
	b=jJbhMDqn4U5Gp9wyAsC8aGRzjq6bXIFKvNCXMrOiVH/YzQJft8dvtlBdsiZCJDVkJ
	 kMXmO2W0q4IYsPDh8FGHA2T2D6HnoKoqPNwoudFz35UKFFy1W79+rYcqoYGH5zPgsN
	 MT+eOYLYWtLx9yDjzgI9pJNgJyDrZRA1TSopUXYJ8JICpKslmMTiJRW/s5IoyYVT0G
	 ro8DJWFEsbhxVIwpAUT02soKuUhXfy2CqMYftgrGAKfMT1rhS6HswURzz35woUXt7m
	 YPeWzVfPsX51st98KyN0DDOPqYmVtGOCePrzM/5KI5EttGmKWqAe3/XTqArL4BmUST
	 CpN3W8ZJmmxCA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net v2 0/2] selftests: mptcp: connect: cover alt modes
Date: Tue, 15 Jul 2025 20:43:27 +0200
Message-Id: <20250715-net-mptcp-sft-connect-alt-v2-0-8230ddd82454@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFChdmgC/42NQQrDIBRErxL+ur+ojQS66j1KFsZ+E2mq4SuSE
 rx7JSfobt4MM3NAIvaU4N4dwFR88jE0UJcO7GLCTOhfjUEJpcUgewyU8bNlu2FyGW0MgWxGszY
 tjXFiuJHrCVp/Y3J+P7ef0GowNnPxKUf+nn9FntEf00WiwMlJq800kR70400caL1GnmGstf4An
 AUV3cgAAAA=
X-Change-ID: 20250714-net-mptcp-sft-connect-alt-c1aaf073ef4e
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Christoph Paasch <cpaasch@openai.com>, 
 Davide Caratti <dcaratti@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1651; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hnwA/Cl94G/uuXZ1hoCLu04p0joBovLqTgYpqqTRKGQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLKFkadUrrUPXOiTVhTyaIT+rqyklab7u9xTM9fYuzH8
 +iclzdHRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwESsTjP8FTu3WUx65cr8fdZS
 l3sOLJBVvbt6i8BNY7svJ9forj4qeZzhf+5GzncPp/dt+fYj97jml3cKeyZ5Xyifv5xHlUkyubI
 3iRcA
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
Changes in v2:
- force using a different prefix in the subtests to avoid having the
  same test names in all mptcp_connect*.sh selftests.
- Link to v1: https://lore.kernel.org/r/20250714-net-mptcp-sft-connect-alt-v1-0-bf1c5abbe575@kernel.org

---
Matthieu Baerts (NGI0) (2):
      selftests: mptcp: connect: also cover alt modes
      selftests: mptcp: connect: also cover checksum

 tools/testing/selftests/net/mptcp/Makefile                  | 3 ++-
 tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh | 5 +++++
 tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh     | 5 +++++
 tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh | 5 +++++
 4 files changed, 17 insertions(+), 1 deletion(-)
---
base-commit: b640daa2822a39ff76e70200cb2b7b892b896dce
change-id: 20250714-net-mptcp-sft-connect-alt-c1aaf073ef4e

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


