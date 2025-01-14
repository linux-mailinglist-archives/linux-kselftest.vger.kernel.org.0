Return-Path: <linux-kselftest+bounces-24497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 477C8A10F43
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 19:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58995161F43
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 18:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDEE224B02;
	Tue, 14 Jan 2025 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ts4DwxNx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E2520E331;
	Tue, 14 Jan 2025 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877811; cv=none; b=QcFSlRCtW0u3ZxowXZwe+suqQOdOylugZTvUOryocylS9T57RUR6rFA+3r8LRs1PsB6sjPE2wdFxMx63/4OZvBMWp1bVXsKH04yAzAYgZRV0N5hxPGl8C65sMqRVCm4DexwbFSOKZxYNjQI4YlFfKop3qO/xww/nU5NhtCHFJjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877811; c=relaxed/simple;
	bh=kr29P4FNAPGgFtp3WjPdDbg/ZxSETtaY2ULfj0zgqpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qLFlfqLUEK1yfABssuubCEoId+kgq8Bdd0HzsVr+HqJAAjdX2VmWKcJ+n/PO5wi1zN+ENQtnVsNLsB0fQJCpwAdunAc/Phj6iLeUWYWciMYknzfVy61nMN26VpbsvArs1upeiIDoZWwxhd+6HRTf4yAqnlkoem/3CmOWohGbEJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ts4DwxNx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A55C4CEF7;
	Tue, 14 Jan 2025 18:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736877811;
	bh=kr29P4FNAPGgFtp3WjPdDbg/ZxSETtaY2ULfj0zgqpA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ts4DwxNxw0u+I1PhrgRhrT3Kom8SwCbB2xUplF2q/T3ZAezKlSqLxNcEiJa8bNJF2
	 hj1NHo6t0ojm9V4yxxdV1l7xtQG1Z6E7T8SmwpPLeVONapLk5OP9lv+NRN+Lcogp0V
	 +TmEgybWMrBR65LAmH/YLekPCYlXx2XacFa8qmP8bIe1uDRiEaf7GMUilDZsnJeCGu
	 LJcWK4KJzwEpa7zAamkUBFAVtE+Yp9AwI6QMMobMH6rzpusAcbTOkB4QsRhVVYxP3P
	 0TkeL72lSPxQMd/Qj7ck9AAO/uxkpnfHi7ORC9y0nSaQOgLSFQtqMGwLY3aXvOPW89
	 Sdcs4usBHCB9A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Jan 2025 19:03:12 +0100
Subject: [PATCH net-next 2/6] selftests: mptcp: sockopt: save nstat infos
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-net-next-mptcp-st-more-debug-err-v1-2-2ffb16a6cf35@kernel.org>
References: <20250114-net-next-mptcp-st-more-debug-err-v1-0-2ffb16a6cf35@kernel.org>
In-Reply-To: <20250114-net-next-mptcp-st-more-debug-err-v1-0-2ffb16a6cf35@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2103; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=A64I+iarzXvYRTzZkj/AeFTqlCRNlqd0J/cTHt9/yMM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnhqboKd2XGZjh03PmlYiLYJJf95j7hoXZGV1L9
 7J7St8mtzOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4am6AAKCRD2t4JPQmmg
 c+8REACW+Xj23yZRzSOtEhx+fzt2JIyoNmD5TZs61WrhL3gSVavdQqi8y+JuxfgVoVaWcnvD8m9
 1F+UJjWFl+ksOPiwOA/EdOSQul0P88itHqpDStPKaIW+8Oa2PpIMSSC6R7dpEomlqTy4DPM2MPv
 M6v3pWguBRItbQnnc9Cjiyb+LnF7Mm8j9l7cgOtwsmgPee4CZFN51u+GrSOExd7nhJyD7AKb3ok
 B+jbyhpN1nDP5tqS15YNjtXhLy68TsTykmFHS2OXVwV+FtnGYzrwv7NWxQ17Qx7zaRIeHlwR+3E
 ZA54yjErqFZeFx//2aEDYPPwxgB29L7Fvr2/9dzuGEuum6LxC/m0+jarxUhT/4NZgVwuWt6XkDu
 gS3ofA9G2JS8TRNoRUVU/oHIij52xYfd/jNWOKnzLz7uOoGnQ9Zg+UU3wKw7A9Gk/HBqJMj+3Ep
 QbNMY0dD7EmqbdlHsZgto7JIPAzJWocPliFebln5ATH3nJWv4/c4x6nSJBiC5RzcUUlxEBtnMir
 51N9Uu67VYoHeKfJtHliEFX5SJTeGuVgxOl+6OUAoLvNUiHWZc5rCPNg9lOBkswR/eitZuPmnEe
 HnU9hHGclK05b/Z9FB6CHo6MK2injlWLTpAMBSdU9kihYswvT6dj58QC4g6G59vYkwpkSslwyy6
 T0Yyhap5ALuQeRA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Similar to the way nstat information is stored in mptcp_connect.sh
and mptcp_join.sh scripts, this patch adds a similar way for
mptcp_sockopt.sh and displays the nstat information when errors
occur.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 5e8d5b83e2d092879efc179f1a450542be4e575e..9a78bfdc3d5e27fdf6859d34f8d313bd08dd4457 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -169,6 +169,11 @@ do_transfer()
 		cmsg+=",TCPINQ"
 	fi
 
+	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
+		nstat -n
+	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
+		nstat -n
+
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
 			$mptcp_connect -t ${timeout_poll} -l -M 1 -p $port -s ${srv_proto} -c "${cmsg}" \
@@ -189,14 +194,20 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
+	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
+		nstat | grep Tcp > /tmp/${listener_ns}.out
+	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
+		nstat | grep Tcp > /tmp/${connector_ns}.out
+
 	print_title "Transfer ${ip:2}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		mptcp_lib_pr_fail "client exit code $retc, server $rets"
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${listener_ns} ss -Menita 1>&2 -o "sport = :$port"
-
+		cat /tmp/${listener_ns}.out
 		echo -e "\nnetns ${connector_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${connector_ns} ss -Menita 1>&2 -o "dport = :$port"
+		cat /tmp/${connector_ns}.out
 
 		mptcp_lib_result_fail "transfer ${ip}"
 

-- 
2.47.1


