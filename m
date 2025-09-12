Return-Path: <linux-kselftest+bounces-41381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6665EB54E7E
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 14:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1695832D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 12:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1172630BF70;
	Fri, 12 Sep 2025 12:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNVwEMK5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52CD30BF60;
	Fri, 12 Sep 2025 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681593; cv=none; b=ZHxhfssAOE479Zij2JOoJgni+VGibfTbwQx+7G3m01NDOiKFmaajo/YsCIdR80BeIWiFxEmWu17aYVrN4rkid1M40dJ1g+O/6ZIChqFLpY59AA3U8owq3oQPu9hDU4m5PpHCt6LC+BkAtN/ZRJ+1F0bU9LPeP+m0Ro5S82bHndA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681593; c=relaxed/simple;
	bh=3DaJGpjVW/1i1OPjle+Vzn5UOXmKJIuclLYAV3+LrNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wmq1uHNFpBXer7rdLTkSKQGYR/4BIzCn4W2XKzX8HKX7MiejC9sjNCH54DULYZWZuKnXdkuWVKEnP1aO+cVgtx/khN661paRe78cqJTEcnSMzRAYjlvA2SYEd329Gi8lAdqaQYgMm/cZgYpmEbS1Z3/MRgJf623znBuGyvo0O0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNVwEMK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B310C4CEF4;
	Fri, 12 Sep 2025 12:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757681592;
	bh=3DaJGpjVW/1i1OPjle+Vzn5UOXmKJIuclLYAV3+LrNE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZNVwEMK5XT4XY8yX4eyH0UMpGZsSnU5OiBWkjnNfRj6ety6pyG4gr7rDg4mDzSmRW
	 oiUNZIYmvE2Fd1IkAoErdbHk5vIiTMjU319swWRaaK+7KVR+6ZgrxOsFIowVq2lL2K
	 A+KSNzIP03AcmGf+0upZvBZYvVfVuUIt8vQCaUgnKuXoxw71cvkFF/jeZArHfEa8WX
	 YLzVvs+vGi+gLQZUMhJ5bvShvk0A5UqAc51OAFrzKndvbrWohWWWYmyGasmzk1Bmpe
	 j4oKoidyw5kc5NojkPx34hrto1eAeXsxvFc2ODqx1AJb51oRyxIrTcG8j//6A862cS
	 Ft+3oAucBLm3Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 12 Sep 2025 14:52:22 +0200
Subject: [PATCH net 3/5] selftests: mptcp: userspace pm: validate
 deny-join-id0 flag
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-net-mptcp-pm-uspace-deny_join_id0-v1-3-40171884ade8@kernel.org>
References: <20250912-net-mptcp-pm-uspace-deny_join_id0-v1-0-40171884ade8@kernel.org>
In-Reply-To: <20250912-net-mptcp-pm-uspace-deny_join_id0-v1-0-40171884ade8@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Florian Westphal <fw@strlen.de>, Kishen Maloor <kishen.maloor@intel.com>, 
 Shuah Khan <shuah@kernel.org>, Dmytro Shytyi <dmytro@shytyi.net>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3969; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3DaJGpjVW/1i1OPjle+Vzn5UOXmKJIuclLYAV3+LrNE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKOiC93eVFpvvlz2LJ93tpfXmaWMfxSt2BVY/z55Uub+
 kudGVt2d5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExE4xsjwzs1Jz2uTcf2mope
 5+URm9ynt09xxVLTj8Kn3nV/PHrKNYaRoePnrebND514eGIPJraXLltxOZgncGex6P4VC7nzX30
 t4gIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The previous commit adds the MPTCP_PM_EV_FLAG_DENY_JOIN_ID0 flag. Make
sure it is correctly announced by the other peer when it has been
received.

pm_nl_ctl will now display 'deny_join_id0:1' when monitoring the events,
and when this flag was set by the other peer.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c     |  7 +++++++
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 14 +++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 994a556f46c15163bae6cb517c371801f0cd6e3b..93fea3442216c8fef43731a99c1d5710f234b150 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -188,6 +188,13 @@ static int capture_events(int fd, int event_group)
 					fprintf(stderr, ",error:%u", *(__u8 *)RTA_DATA(attrs));
 				else if (attrs->rta_type == MPTCP_ATTR_SERVER_SIDE)
 					fprintf(stderr, ",server_side:%u", *(__u8 *)RTA_DATA(attrs));
+				else if (attrs->rta_type == MPTCP_ATTR_FLAGS) {
+					__u16 flags = *(__u16 *)RTA_DATA(attrs);
+
+					/* only print when present, easier */
+					if (flags & MPTCP_PM_EV_FLAG_DENY_JOIN_ID0)
+						fprintf(stderr, ",deny_join_id0:1");
+				}
 
 				attrs = RTA_NEXT(attrs, msg_len);
 			}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 970c329735ff14f87f0048ba0030dc7edaaa86bc..3d45991f24ede919264185e3b5c2a3b95c1dcc85 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -201,6 +201,9 @@ make_connection()
 		is_v6="v4"
 	fi
 
+	# set this on the client side only: will not affect the rest
+	ip netns exec "$ns2" sysctl -q net.mptcp.allow_join_initial_addr_port=0
+
 	:>"$client_evts"
 	:>"$server_evts"
 
@@ -223,23 +226,28 @@ make_connection()
 	local client_token
 	local client_port
 	local client_serverside
+	local client_nojoin
 	local server_token
 	local server_serverside
+	local server_nojoin
 
 	client_token=$(mptcp_lib_evts_get_info token "$client_evts")
 	client_port=$(mptcp_lib_evts_get_info sport "$client_evts")
 	client_serverside=$(mptcp_lib_evts_get_info server_side "$client_evts")
+	client_nojoin=$(mptcp_lib_evts_get_info deny_join_id0 "$client_evts")
 	server_token=$(mptcp_lib_evts_get_info token "$server_evts")
 	server_serverside=$(mptcp_lib_evts_get_info server_side "$server_evts")
+	server_nojoin=$(mptcp_lib_evts_get_info deny_join_id0 "$server_evts")
 
 	print_test "Established IP${is_v6} MPTCP Connection ns2 => ns1"
-	if [ "$client_token" != "" ] && [ "$server_token" != "" ] && [ "$client_serverside" = 0 ] &&
-		   [ "$server_serverside" = 1 ]
+	if [ "${client_token}" != "" ] && [ "${server_token}" != "" ] &&
+	   [ "${client_serverside}" = 0 ] && [ "${server_serverside}" = 1 ] &&
+	   [ "${client_nojoin:-0}" = 0 ] && [ "${server_nojoin:-0}" = 1 ]
 	then
 		test_pass
 		print_title "Connection info: ${client_addr}:${client_port} -> ${connect_addr}:${app_port}"
 	else
-		test_fail "Expected tokens (c:${client_token} - s:${server_token}) and server (c:${client_serverside} - s:${server_serverside})"
+		test_fail "Expected tokens (c:${client_token} - s:${server_token}), server (c:${client_serverside} - s:${server_serverside}), nojoin (c:${client_nojoin} - s:${server_nojoin})"
 		mptcp_lib_result_print_all_tap
 		exit ${KSFT_FAIL}
 	fi

-- 
2.51.0


