Return-Path: <linux-kselftest+bounces-59-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 613F27EA6DF
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 00:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDC41F233F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Nov 2023 23:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA9C3D992;
	Mon, 13 Nov 2023 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LI7K/IS2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4797A20B28;
	Mon, 13 Nov 2023 23:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA07C433C7;
	Mon, 13 Nov 2023 23:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699917426;
	bh=d/7LlCiNVS1nIuW7H/Teg2UKQha/cVG2+PsK03xJFXQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LI7K/IS22AZ09mbMBkVdw/sA0B/A7+IzXl2u1mNAY54FjC66ikj7Hh/c8tEwMvx9Z
	 h9e/KpoYtyU8BYiFj8q7p+xT1+YmtYZN4A/b3abX4Xo5m/6FwSBnrS421VecXBCkNe
	 6E7g645bvZXQZwYgBeVCFM8md+pEt93AIvWsOsbTK5mkVddxk8h92+kS55itkzKasf
	 kNiogk5nJ/fndt7N222fY+tAmWFjlhTstb5U68JjI1UsWUvdCLAnwGJFEOnopOtuVC
	 cNMDau92c6PcWP75OHgciCsnOlB441uCoO+fNmdFT9AfeJ5QK/wL+UotPB7WTO+3O0
	 O1KOAnb4NAsbg==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Tue, 14 Nov 2023 00:16:17 +0100
Subject: [PATCH net 5/5] selftests: mptcp: fix fastclose with csum failure
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-upstream-net-20231113-mptcp-misc-fixes-6-7-rc2-v1-5-7b9cd6a7b7f4@kernel.org>
References: <20231114-upstream-net-20231113-mptcp-misc-fixes-6-7-rc2-v1-0-7b9cd6a7b7f4@kernel.org>
In-Reply-To: <20231114-upstream-net-20231113-mptcp-misc-fixes-6-7-rc2-v1-0-7b9cd6a7b7f4@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexander Duyck <alexanderduyck@fb.com>, 
 Geliang Tang <geliang.tang@suse.com>, 
 Poorva Sonparote <psonparo@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>, 
 Xiumei Mu <xmu@redhat.com>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1VtnS1TKj7lyzMRKX91SxQBtSgw2M4w3HXFlGeZDrN4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlUq5aMuCFwbwzlyq4ysRgP3pqKahOxzRgxFnnw
 l+BNxMHQauJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZVKuWgAKCRD2t4JPQmmg
 c7BoD/0SIPywq8PWF0/z161pvvpt0tmrXqnaBOoOkASD4y6f02LxkUk05rMrTNWgC7zilJlNX3J
 zFwGVBtcm5oy9rMgshSRH2n93HKzFliMOFwPtNoLH7YJEfbPJ3tSS+lLrHsiLnstgRkxVtHF3x1
 cRvJYr17YuqBxLz1ZfZ8nshn7zRox0YV+SU2K9hivi0iOH2eQ+rZOaOwwZRV7x0zSQcA/x7saWW
 GuDMNfS1JWJYT6tyA4jKMGeVIPcRwFkODGbY+R7FizSjZPU8tlebHweL27O8gO7Uu/7tzB/bloV
 25RnyYerFDFP0e1nuaZuPNUwTQq+CF8Y9FAeLZKU54drxQFWwcNuU1ROPDO497+glcAeydvY6h5
 dEsFpdquMy7zepnqf0KL4Iz2SzsbbBdN9jg7JCEB1k4Iq1F9LSAaokA2FNmJUv1vF32BhHTfo3v
 uJJQzk/a/kC2l4PlJqFdJWa9RokLJ5Ep2mnUm/dv3VwMkpsKc00nAPJ4YC/9BHtbgjUPlaSmfq2
 4mVzD5d32cIlossWdbJJOM6cVtyJJJqvmIZiaFC0yOy99wsEy/6STe0x3Rq0y2AjHcXDO1+s2KV
 gA+A/USQQ5tp0sQZCwQt/DpF5WBT3hN4808EpysM1+5xVwd8/GqMhDfhhgwT+8T0nUkpsQjQ/vX
 Zfwyy5OVpsCugUQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Running the mp_join selftest manually with the following command line:

  ./mptcp_join.sh -z -C

leads to some failures:

  002 fastclose server test
  # ...
  rtx                                 [fail] got 1 MP_RST[s] TX expected 0
  # ...
  rstrx                               [fail] got 1 MP_RST[s] RX expected 0

The problem is really in the wrong expectations for the RST checks
implied by the csum validation. Note that the same check is repeated
explicitly in the same test-case, with the correct expectation and
pass successfully.

Address the issue explicitly setting the correct expectation for
the failing checks.

Reported-by: Xiumei Mu <xmu@redhat.com>
Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose test-cases")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 75a2438efdf3..3c94f2f194d6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3240,7 +3240,7 @@ fastclose_tests()
 	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
 		test_linkfail=1024 fastclose=server \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
+		chk_join_nr 0 0 0 0 0 0 1
 		chk_fclose_nr 1 1 invert
 		chk_rst_nr 1 1
 	fi

-- 
2.40.1


