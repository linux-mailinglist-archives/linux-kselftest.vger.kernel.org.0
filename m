Return-Path: <linux-kselftest+bounces-5988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670698732EE
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 10:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998241C252EA
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 09:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129A160B85;
	Wed,  6 Mar 2024 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/3ZDfSj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D872260B80;
	Wed,  6 Mar 2024 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718216; cv=none; b=Oa6/9orHUMUM3Me9ClSMcHKL9v/865azy/nBDawJoa6aQLks5ypqISuD/mH/cQj5tt1Rze9xhLVZalmMa9Wo3pX/BafUMpL1H3uFiRgkxkj7saW7XkEtKkNC11i8aUnzyyMljy36pscPoz0Tnfa5WvYy/3s0ZCv/jHrgErJvdWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718216; c=relaxed/simple;
	bh=jTLgdGpKQfPiNeklV9atb8fDhX9KNQWViIOBx/XoGv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sIK14afmTjmd06SaoquqtXlA9IbJNxhILAGnWguLuNviZXZkrnoGFcqgLIPPPuDo4dHIOAsGql7SicRYWWVDFVQsdHXq89EogzLki8yBpaA3PPaXpw1WwpRel19BCFe6ajwc8tTbOu72xfwyRvTJBbJfQb3auVPrMFQCsqoFHzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/3ZDfSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25556C433F1;
	Wed,  6 Mar 2024 09:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709718215;
	bh=jTLgdGpKQfPiNeklV9atb8fDhX9KNQWViIOBx/XoGv0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P/3ZDfSj+bsLsO5rfpXfm/Q3ULCnsUQHdsDhVDpa/VFozh7cRwDj2Ho9pGncmA6g/
	 NTXwPFiDrIOxX+UpTLrK3dq65exs8FO7KcKhIKxSxzK3fbbyEXywvCf2ArpmvrCghl
	 LTfoN4xXe0mi0Jy/zbIXruNYmbwuJoQKObze7StWcc8xG0GLC8Ac3effzWUwPcT0Ax
	 RFrxSMVTBaVeMTA+MfU+4G6JB/b1SfEygmXr5soyrg6GDyLvjfYSXMua3jfwn2gsMl
	 w22+Z2tKv4F5066p1pfG1yHa+hZMjsuYFqtTcFYAzq1YnQqbQPHFEMrMWcj9XEdsYc
	 9Mq914aNsVAOw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 06 Mar 2024 10:42:59 +0100
Subject: [PATCH net-next v2 10/12] selftests: mptcp: pm netlink: fix
 shellcheck warnings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-10-bc79e6e5e6a0@kernel.org>
References: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-0-bc79e6e5e6a0@kernel.org>
In-Reply-To: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-0-bc79e6e5e6a0@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2721; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jTLgdGpKQfPiNeklV9atb8fDhX9KNQWViIOBx/XoGv0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl6DqnM/9IQsJwyayMY02xLpa8rIJIfF1JTYDpr
 gq4nvlo54WJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeg6pwAKCRD2t4JPQmmg
 c/fXD/9RrbzM1eoVcpQlEWrT9czT6st+Xtonbpv5cjnQZSkK+0fBprLsSMjQQqKUydWPJNig/Qd
 /5Us03RZS3aqoMHul9DJ+IjRQjiohraJ373vomKKuyJEskYMw3qsKEg89pdeH9OEl3H3sMVDo2n
 G2rYd6t6VkJwgL8sKL66Wz3xDnIs5g6VLiBoSUdAGQeW3TypwtFRMmsoCPOIiLeyy+Qg+Bmn2+e
 76N5q3MmPRudXAzR3cc9fz8puW/CCV6Ik12N6UqFz6cbhuEsjG6PITCVGec+UoISWeOF5+QV/S5
 MzIOnuIAlPbfw9/SVEhGOhPPTV3Artm1u9oPkNMRvLnFfg2XozmqqBeLx9+kzEjUjIEcU3VDBlh
 s4u5qiWL3QlXghA7OQtVw3LT8pT25cCMhnCaUinwBYTY2zzhVRsRJpDPijak7O6ZrBzAKSuIevt
 MnX7tINUdE3WxywNcArhSCz+eu3aqHYSsUyUJknnqCDuZOEncYbQEG3FR3bd6nl7aT5a+47PVHH
 WIRAKdlDLQvCIC9KuW9aS+wLnkKMEHTxT/nce7KfOvuzFILSIWE/WiwX28qrnxn7CtBxJMxnq00
 e8atVHPw1SElvWN/dlN6MA0PBuGZil4beSetwVWnOGvsmOYsfht1chSLCC5RLxoqd1q/1cHCXin
 OIlWe0VMLAt73Xw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

shellcheck recently helped to prevent issues. It is then good to fix the
other harmless issues in order to spot "real" ones later.

Here, two categories of warnings are now ignored:

- SC2317: Command appears to be unreachable. The cleanup() function is
  invoked indirectly via the EXIT trap.

- SC2086: Double quote to prevent globbing and word splitting. This is
  recommended, but the current usage is correct and there is no need to
  do all these modifications to be compliant with this rule.

For the modifications:

  - SC2034: ksft_skip appears unused.
  - SC2154: optstring is referenced but not assigned.
  - SC2006: Use $(...) notation instead of legacy backticks `...`.

Now this script is shellcheck (0.9.0) compliant. We can easily spot new
issues.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index c7c46152f6fd..427fc5c70b3c 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -1,16 +1,20 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Double quotes to prevent globbing and word splitting is recommended in new
+# code but we accept it, especially because there were too many before having
+# address all other issues detected by shellcheck.
+#shellcheck disable=SC2086
+
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-ksft_skip=4
 ret=0
 
 usage() {
 	echo "Usage: $0 [ -h ]"
 }
 
-
+optstring=h
 while getopts "$optstring" option;do
 	case "$option" in
 	"h")
@@ -27,6 +31,8 @@ done
 ns1=""
 err=$(mktemp)
 
+# This function is used in the cleanup trap
+#shellcheck disable=SC2317
 cleanup()
 {
 	rm -f $err
@@ -91,14 +97,14 @@ check "ip netns exec $ns1 ./pm_nl_ctl get 4" "" "duplicate addr"
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.4 flags signal
 check "ip netns exec $ns1 ./pm_nl_ctl get 4" "id 4 flags signal 10.0.1.4" "id addr increment"
 
-for i in `seq 5 9`; do
+for i in $(seq 5 9); do
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.$i flags signal >/dev/null 2>&1
 done
 check "ip netns exec $ns1 ./pm_nl_ctl get 9" "id 9 flags signal 10.0.1.9" "hard addr limit"
 check "ip netns exec $ns1 ./pm_nl_ctl get 10" "" "above hard addr limit"
 
 ip netns exec $ns1 ./pm_nl_ctl del 9
-for i in `seq 10 255`; do
+for i in $(seq 10 255); do
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.9 id $i
 	ip netns exec $ns1 ./pm_nl_ctl del $i
 done

-- 
2.43.0


