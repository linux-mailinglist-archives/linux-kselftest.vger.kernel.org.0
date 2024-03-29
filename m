Return-Path: <linux-kselftest+bounces-6873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE2089185D
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 13:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800511C21D78
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 12:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B2C85C7A;
	Fri, 29 Mar 2024 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRYHvtK1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA4F85C61;
	Fri, 29 Mar 2024 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711714174; cv=none; b=bDsLNoS5HuhOS+B27T4ZSI0pDDnziMRWRaBUwWQrfsz8X//F76srDhfG2FXBRCYOVyxHolw8QTVL1j8s36x9Z18eHBkHecAUT7Le/gpw9Po8tHQ0ek15Z3ze5U9t+OpSUPijdbHSotZ+6Ie9VyLjYuMNVjybYgtZKzvyFCGM7yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711714174; c=relaxed/simple;
	bh=c1vtujffcN4qAMoRTIoYkCUUIFjdmgIs6rF3ALOV3hY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b1OR4xghSMO1bvzqO6QHC8VfaM86c8+J/3iK/8GMEmtSgo6KGOqSjPuMnfNsq1IrdkcIvs+9Ys4XUTQem3TqcPZ3Y5pj8K3lSgYX0oqcvTsgsnkB41WpMyqY/ekNVrT8+NZLbHPIG9+sKcBHuRhBcOkAwDbesLdfPIkYtlYr4dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRYHvtK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A66C433C7;
	Fri, 29 Mar 2024 12:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711714173;
	bh=c1vtujffcN4qAMoRTIoYkCUUIFjdmgIs6rF3ALOV3hY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jRYHvtK1j7Za7E1ZwbAZfu718vlA6rXtHfbnjej2VpOxC1Chs4dsSjbs4Kigthl//
	 j9vg7Gg7V9EDGsOFixuUcRu7r91cHwDI8UMcH0zsjB56AhgTF71+56hm08326C1x9J
	 y2hKQoKV9nEcJRw02qOEAL3H4wBlFAQ7lhNfaZxMatvS+9qpS9FWzz0QTQLKcd1yi2
	 TisP8arukJvcXj7cpspONYqRGq/AvD7qsNM866yBuS0O3xn17rAOQOjpaILrkdhiLw
	 2EfdzzM3KW8x832C+Y4DGvsli3YVQOS1cwN+Twg/gvMgy6KVdmeo/Vl4b9+rXOtMqB
	 /dBpJp5LzYKUA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 29 Mar 2024 13:08:53 +0100
Subject: [PATCH net 2/2] selftests: mptcp: join: fix dev in check_endpoint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-upstream-net-20240329-fallback-mib-v1-2-324a8981da48@kernel.org>
References: <20240329-upstream-net-20240329-fallback-mib-v1-0-324a8981da48@kernel.org>
In-Reply-To: <20240329-upstream-net-20240329-fallback-mib-v1-0-324a8981da48@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CG3/mlos+ef5k7KNLzfPX4+PsklI6wPoeaw8MLwrud4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmBq9ybOsiuCWb5DCppU2p1oFh1Opo5xshrkxij
 LiDXPKR6/qJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZgavcgAKCRD2t4JPQmmg
 czY9D/9OnksBcpV96oDSwJcZUsXdvV1bR6rbZkJQK4NBf6TDRrGZHQrOb3mvkS9pI/SGzK+DSPn
 OFbA5vWXTH51PAChiKMeYg9LPXcd3F3rG6NuHKQ/LUQevvs3Vv95a1DTQMRYS2yb/NEl21DjPKQ
 SEzZ0/ungq0k4vTCvNpUTNFz1/vIkezkWN241Vxinwl80MC5QfpCsjSgtr1wHIX+FEbWQK7Jc91
 vMIygXOpeboDeDo0sMz9oFqwHS6hFxav7pKnMexuwtwrRalKDfxgvEhIyVeIbxZ1M9Ob1+NHl01
 4kA1iFBbRJuUAInLQzhVp5XIp/nQAjttYKrPrk+rcDSXGI0vzSjB2DRQMY56cOdcsFfaitOnCCZ
 ZKaqh9TAOjz4bNII1wAZ7I9+rG8fwIWWXQlvphbXPSgu1PSKzsCHG79Af2O+hAsFwjy+nvInpP/
 Xu3qGAVrMUIuy3XhesKlSwPNyfeEnRbhRbi77xPLvHxJpp/p+SlFbAq2xiyDibQFEQ6WN+HCWJs
 Sw3wM67lE8Q6Gu9eL8BurWm0zonKqsWFUYRnP2PEjxm/Mn0bXOTEeNpiU+IzDDzz6kNN67VZ8A3
 0DH4V8i6QSzkLenLuQpXpgAS6Pr6BntWv48OtTFMYMUCKylBETifhHuD7k2wHmv9IJtbXiJW/G+
 53QzYK2MQ4VG0MQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

There's a bug in pm_nl_check_endpoint(), 'dev' didn't be parsed correctly.
If calling it in the 2nd test of endpoint_tests() too, it fails with an
error like this:

 creation  [FAIL] expected '10.0.2.2 id 2 subflow dev dev' \
                     found '10.0.2.2 id 2 subflow dev ns2eth2'

The reason is '$2' should be set to 'dev', not '$1'. This patch fixes it.

Fixes: 69c6ce7b6eca ("selftests: mptcp: add implicit endpoint test case")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5e9211e89825..e4403236f655 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -729,7 +729,7 @@ pm_nl_check_endpoint()
 			[ -n "$_flags" ]; flags="flags $_flags"
 			shift
 		elif [ $1 = "dev" ]; then
-			[ -n "$2" ]; dev="dev $1"
+			[ -n "$2" ]; dev="dev $2"
 			shift
 		elif [ $1 = "id" ]; then
 			_id=$2
@@ -3610,6 +3610,8 @@ endpoint_tests()
 		local tests_pid=$!
 
 		wait_mpj $ns2
+		pm_nl_check_endpoint "creation" \
+			$ns2 10.0.2.2 id 2 flags subflow dev ns2eth2
 		chk_subflow_nr "before delete" 2
 		chk_mptcp_info subflows 1 subflows 1
 

-- 
2.43.0


