Return-Path: <linux-kselftest+bounces-17410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C30AF96FB64
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 20:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B1B28B303
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 18:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2AD82499;
	Fri,  6 Sep 2024 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuyyIMLX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBAD1B85D5;
	Fri,  6 Sep 2024 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725648383; cv=none; b=ovohUDSNLPtW/LA3klPKEebwZPNle92dTMtVs9P1chYSYZ3ACNKb32ooIBAN7BvdOmMYDRtaGY/iO7S5FBpjQM02efyYtXt8nhA8j8AVNkrRQMTL58sybTRCjZQrEyZykxWmdFNo95/1XPDEOzLi6AyyfBoXuzJJtKMEcZHTIEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725648383; c=relaxed/simple;
	bh=/TWWVM3LOtpuoyPVfgax7PiTjbUDXYPw9cdrQ05JEyY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a7japptRUWQqxaKtk8F9f1mEnqltuDtVw0d0X7s1QZV4/HqtYTi3QfejN3tNufDy4YZOgaCQRkKSVSjUnjHFPA4NpGuMf7S53Mbu3S8QPchTXQH/vc431ruZ8X6f7eC3DOtVY4WFKlxwNl9EHSPFM3Za7cEq76xzgmaFn+Vz9rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuyyIMLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635EBC4CEC4;
	Fri,  6 Sep 2024 18:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725648382;
	bh=/TWWVM3LOtpuoyPVfgax7PiTjbUDXYPw9cdrQ05JEyY=;
	h=From:Subject:Date:To:Cc:From;
	b=cuyyIMLX7RFEfVJPtgOj7gTSphB0xfb0k491wxM61WD+CttTIOEug5J7GazISADiF
	 ybrTlTa+rrGvqoyJ6OXk7EfVgAVo33MscJNK/pKnmQu2Z9oV/7n6czYslL4AY/6udD
	 7y6r2qFyKYK8kjZzRPRS726+/NmrG1iX4UdwH4IwiNVKRg8JvE/6M20laT+WU/Nrzu
	 FPstCU2mQsN7D1I18NGpjgmvpXPGiWheaINCDCFJ22WkAMODylkw/8ycxRj0ZSS+AU
	 I6KKpadeOrSRo3pvYmOM5LuEP/jt9GX/MQ0c7cA90OWRkmsYgN9CbYcsAHMa5gUuzC
	 OApuLMsxywAwA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next v2 0/5] selftests: mptcp: add time per subtests in
 TAP output
Date: Fri, 06 Sep 2024 20:46:06 +0200
Message-Id: <20240906-net-next-mptcp-ksft-subtest-time-v2-0-31d5ee4f3bdf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO5N22YC/42NwQqDMBBEf6XsuVuSmIPpqf9RPGhcNVijZLdiE
 f+9Qei9hzk8hpm3A1MKxHC/7JBoDRzmmMFcL+CHOvaEoc0MRhmrnDIYSXI2wWkRv+DInSC/GyE
 WlDAR1mXhyduiLZ2FfLMk6sJ2Kp7wW0OVmyGwzOlzuld99v9rVo0KO02tda7WutGPkVKk121OP
 VTHcXwB1b2raNsAAAA=
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2273; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/TWWVM3LOtpuoyPVfgax7PiTjbUDXYPw9cdrQ05JEyY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm20371FkgbH8kqFjiOCr++/l5SUutuGGl1GnQP
 p3vSMu7p86JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZttN+wAKCRD2t4JPQmmg
 czE3EACSU/6XzXHCzZb2xzTNxspcEnAAetZpcPzJCxKewkpqNMFwEnw0rxSAOmRQSwohUWmShlh
 KSfkMcr0JHEvrDKYmkFHCgs65g92TI/uvYuz1XQN1ys/mKogtcJjn5jLdMhLeWp8n30i77iWDzl
 UpnYWlFNHeefgVPOvELVeq7RvEvG46r4DF9kKB4XyAH571IJ4EHzo68dS2Lqgj7alZ3UHEhS3oW
 UbiVSpttIJ1XsE9bD+HwQFye2MbsuWVJbEwKM6WgAYSyVbIQBt2jc+uOaeqiqKsUg5V5AU9XmdK
 aPh5NmuKRsQjmb62a+ARgbMAyfPLsyq25nzBRS+PQKdriQP4SE6cZHC/PjTpO8qX9G1vSiqdVUl
 +v+aV93NtvKwKCeZb9Q2W+hPR0eLuUCuLNS2qvo8KZphc6sJv+z6qs8A6h93IfDZiz5t7H5Nij2
 yH3jgN6oWJ41flHSZi6Y2hMIORhgiEUupIU0gbfdRYr+bRML+Oz0uWZtp9DsiQLAGgLzFEeD3Lv
 JEgSCX9RlFRT3DlFSNLjiMgH0VENZuze1s3Rnj/ZCkeIuLNmToIc1EDJCPTeTbUIq4Esx3GhOks
 42hzIilxOBhLjvvoTkRUg9K4KLirHBfIFMlUFl5J7OxEZZzTWSJc++UW1TMkE3yx7vohPP/eoHQ
 fqKe07DzGmD3FvA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Patches here add 'time=<N>ms' in the diagnostic data of the TAP output,
e.g.

  ok 1 - pm_netlink: defaults addr list # time=9ms

This addition is useful to quickly identify which subtests are taking a
longer time than the others, or more than expected.

Note that there are no specific formats to follow to show this time
according to the TAP 13, TAP 14 and KTAP specifications, but we follow
the format being parsed by NIPA [1].

Patch 1 modifies mptcp_lib.sh to add this support to all MPTCP
selftests.

Patch 2 removes the now duplicated info in mptcp_connect.sh

Patch 3 slightly improves the precision of the first subtests in all
MPTCP subtests.

Patches 4 and 5 remove duplicated spaces in TAP output, for the TAP
parsers that cannot handle them properly.

Link: https://github.com/linux-netdev/nipa/pull/36
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Typo in the commit message of patch 2 (Jakub)
- Two additional patches to remove duplicated spaces in TAP output
- Link to v1: https://lore.kernel.org/r/20240902-net-next-mptcp-ksft-subtest-time-v1-0-f1ed499a11b1@kernel.org

---
Matthieu Baerts (NGI0) (5):
      selftests: mptcp: lib: add time per subtests in TAP output
      selftests: mptcp: connect: remote time in TAP output
      selftests: mptcp: reset the last TS before the first test
      selftests: mptcp: diag: remove trailing whitespace
      selftests: mptcp: connect: remove duplicated spaces in TAP output

 tools/testing/selftests/net/mptcp/diag.sh          |  2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 17 ++++++++++-------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  3 ++-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 17 ++++++++++++++++-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  1 +
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |  2 ++
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  1 +
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |  1 +
 8 files changed, 34 insertions(+), 10 deletions(-)
---
base-commit: 52fc70a32573707f70d6b1b5c5fe85cc91457393
change-id: 20240902-net-next-mptcp-ksft-subtest-time-a83cec43d894

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


