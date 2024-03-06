Return-Path: <linux-kselftest+bounces-5989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBFD8732F0
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 10:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9731F2525B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 09:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A09A60BAE;
	Wed,  6 Mar 2024 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="si9HnoOv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C71D60BA6;
	Wed,  6 Mar 2024 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718218; cv=none; b=D7lYoxnRIYZo1FOURbKdU3CHKyX8c7mWA+WlRGZgGc04ZYI0s132Bd8J954REp4fem828ih7fy1dqFsIWjOqxuwIInzeV74VT6iUTZeSiplPmbkgcGBGPgQvpnM1k7MAFENyhywkVmz7LIW1gpt3UwD964eoVzZCsZcmHMwxs48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718218; c=relaxed/simple;
	bh=QtfJT5E6kufllfcFPKcwgPK1Il9pci90VCMQW43RTRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o+WkvOJ8EX2CY+YB7MOyrDOJJqEnpCBTyihy52JBhFh1qo/G4NnQWgnLxvmLukdLHBInzeGty4r/8KPMv0SLZlesAJUr591Wmdv6MllT28/EpZAKlpNkt8dRg2hYYPxSpIk2jf9YLwIRtnXHI6EJ8cM31KSH7jef0ckuwVuumFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=si9HnoOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA373C433B2;
	Wed,  6 Mar 2024 09:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709718218;
	bh=QtfJT5E6kufllfcFPKcwgPK1Il9pci90VCMQW43RTRo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=si9HnoOvVsS6DyZpUAOu8Bw7YRrLq8fgTQePsXgl4DVp/OxKULSb51825zJKW+TAH
	 1882OOGJEpKzecFw5JGMOVci022ghGrsta4cxRE3KGpf2fQ38Sd7ZAatvYyv6Qt48I
	 /1q77E89YZcQNde2vAAKn9jf2KH0UPwjMEZyMMtXxzfMrerJaR38BMNZTeU06o3Spp
	 tSajVA1tPuGerTThc37RSr6gU+MR89mwpRlYgEOS4cPCoL4qaknnkjzD1mQ2ptppoR
	 SwSgGyIi6dznBqJ5yfgo7cvJsQyEigfaXQySwFGvHu9Lq8rJS/H5jpgqqyvsrww+q1
	 Vamolntf4u8BA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 06 Mar 2024 10:43:00 +0100
Subject: [PATCH net-next v2 11/12] selftests: mptcp: simult flows: fix
 shellcheck warnings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-11-bc79e6e5e6a0@kernel.org>
References: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-0-bc79e6e5e6a0@kernel.org>
In-Reply-To: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-0-bc79e6e5e6a0@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2107; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QtfJT5E6kufllfcFPKcwgPK1Il9pci90VCMQW43RTRo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl6Dqn3omYGLIc6kHzN/JxO3rr/koHrN9hYvS5I
 k53UtwkhI2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeg6pwAKCRD2t4JPQmmg
 c2rOD/4nJovXMlx5CbxFmC3l+MhTM8ZV9c2dakEEBs5Z0frfmoXGP14boKNvrcExZiCcPq4y+/d
 EYOf7eA/Iabf2qFTjp4onU1OlgLdpt+aAAthSFu/DrLhaeQ2bXHABY6QWLbXukW0wEvVq5IwrGw
 Yz/Kk6JWkjLXbKL7+cucU3QYk5TYr2cI2ijNCqrkMR1P6Xjz4olwjp5mD64zAmmr5B8CZT9+ksx
 gzNOT+wgIPKxntaGTFK1Z+Upgjqs36dY5HVd0UoJXRPPDp8zp381mQVj+Ose0QUFgeAVeyHKIO2
 urQRk37WL+Pmak5G3BrN9ta3Wjd0bpSqLodu9rVmTxoOHmpegVx2xs6LyNoYl8wKW54kP/I8SDK
 9MxpKfgIOtvY5fTLVFldSZWZVFDBqNJMBaA9kjRjQal3xYCO3/UEdZacwk8yjOmhyLD29o/tx7r
 dZ1/ZTadUPxSTfig2C+oE1K5unxZvggC3T6NgyGALf9UcIkDvDjk/D2ZxuVn1ngBQW31VJkpytZ
 /6o8xhBLUxTvxXOFZlMVJbnQkIHND5wmMrlkRntyNpq9J5aGckvDcTm+iHVyAOuwNkDlIvF53hA
 PhUCaGD5unjF22uuXicaK900PYYHLtSMIMv+XDKgJDQl9DQ9fgV4H26f5gWt0kdULC2GhYHb72n
 O9zpg0lqMlQxcfA==
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
  - SC2004: $/${} is unnecessary on arithmetic variables.

Now this script is shellcheck (0.9.0) compliant. We can easily spot new
issues.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 5a4b83cdaaa9..365fb3d6ef55 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -1,13 +1,17 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Double quotes to prevent globbing and word splitting is recommended in new
+# code but we accept it, especially because there were too many before having
+# address all other issues detected by shellcheck.
+#shellcheck disable=SC2086
+
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 ns1=""
 ns2=""
 ns3=""
 capture=false
-ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 test_cnt=1
@@ -28,6 +32,8 @@ usage() {
 	echo -e "\t-d: debug this script"
 }
 
+# This function is used in the cleanup trap
+#shellcheck disable=SC2317
 cleanup()
 {
 	rm -f "$cout" "$sout"
@@ -120,7 +126,7 @@ do_transfer()
 	local sin=$2
 	local max_time=$3
 	local port
-	port=$((10000+$test_cnt))
+	port=$((10000+test_cnt))
 	test_cnt=$((test_cnt+1))
 
 	:> "$cout"

-- 
2.43.0


