Return-Path: <linux-kselftest+bounces-28233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCC4A4EB62
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 19:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA29188AF3E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 18:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F7C28F931;
	Tue,  4 Mar 2025 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgV18Yza"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3029B285402;
	Tue,  4 Mar 2025 18:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111578; cv=none; b=TkBwejujiAr6Tz+a04Vc1ve8ISFAhQG92fxaeCVyiEiR+v3AseGpQ3gx6VArrpJBpMvLancROCeMiCP/4lC1OaqJvE98oCzjPR9N5JA/n3G+pgWlTy/1f7dI/748fsE1C/xJbMEWO18xjEx+ijg7/b84BOF9A7FJZf/pPvlVeNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111578; c=relaxed/simple;
	bh=/mHrneXC+FDFR+ulcKLKzYeJxuL6kACz3C5Ak/ky3F0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Snrf9Ssx56Lv+OegfTvzxVrcjmUgg3ahwppFzAErlkUl/TMRabUdHIDJVHip82vDxL9cysQuMSTHlX7OET14bl66Anmq9J75EBAf7rGMxdHTX7uGKDTc7C/oFlYLo5ksv2HiAuFdYcCN8kbcPbqQ4nFnHEiQBskCipG7+xX7NDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgV18Yza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEF1C4CEE7;
	Tue,  4 Mar 2025 18:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741111577;
	bh=/mHrneXC+FDFR+ulcKLKzYeJxuL6kACz3C5Ak/ky3F0=;
	h=From:To:Cc:Subject:Date:From;
	b=rgV18Yzagv9cverj+FZNtx0115Jef9e5DyRMVPT0V3pN3e2KVaQUCtEsoAs+bLdFa
	 wUzBBow+vrMYDxc9ReyxGohY7QY9s7hJc3W9Lae0cbsG5AtiQS/2/f8xd8SVAoqr1v
	 37YJqjKCD46nns86s330YOVZf9V2GGOk0FOY72JPfVi6VvoCzcYrFe/K+y6zzUV4Lg
	 qqw7jSd33lSRyims26GfPgX7RjZzaGR41Oy4mVapn+BEe8EkIZGcBkRyRZjJVqju6r
	 QLKq8K/2/C0rtMZ0ul0OFHjTqGATWujILMljQd3iiyJbebQcFdt/7sRUIOpgpBqcPJ
	 mXREknW0ADuIA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	pshelar@ovn.org,
	aconole@redhat.com,
	amorenoz@redhat.com,
	linux-kselftest@vger.kernel.org,
	dev@openvswitch.org
Subject: [PATCH net-next] selftests: openvswitch: don't hardcode the drop reason subsys
Date: Tue,  4 Mar 2025 10:06:15 -0800
Message-ID: <20250304180615.945945-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

WiFi removed one of their subsys entries from drop reasons, in
commit 286e69677065 ("wifi: mac80211: Drop cooked monitor support")
SKB_DROP_REASON_SUBSYS_OPENVSWITCH is now 2 not 3.
The drop reasons are not uAPI, read the correct value
from debug info.

We need to enable vmlinux BTF, otherwise pahole needs
a few GB of memory to decode the enum name.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: pshelar@ovn.org
CC: aconole@redhat.com
CC: amorenoz@redhat.com
CC: linux-kselftest@vger.kernel.org
CC: dev@openvswitch.org
---
 tools/testing/selftests/net/config                    |  2 ++
 .../testing/selftests/net/openvswitch/openvswitch.sh  | 11 ++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 5b9baf708950..3365bcc35304 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -18,6 +18,8 @@ CONFIG_DUMMY=y
 CONFIG_BRIDGE_VLAN_FILTERING=y
 CONFIG_BRIDGE=y
 CONFIG_CRYPTO_CHACHA20POLY1305=m
+CONFIG_DEBUG_INFO_BTF=y
+CONFIG_DEBUG_INFO_BTF_MODULES=n
 CONFIG_VLAN_8021Q=y
 CONFIG_GENEVE=m
 CONFIG_IFB=y
diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 960e1ab4dd04..3c8d3455d8e7 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -330,6 +330,11 @@ test_psample() {
 # - drop packets and verify the right drop reason is reported
 test_drop_reason() {
 	which perf >/dev/null 2>&1 || return $ksft_skip
+	which pahole >/dev/null 2>&1 || return $ksft_skip
+
+	ovs_drop_subsys=$(pahole -C skb_drop_reason_subsys |
+			      awk '/OPENVSWITCH/ { print $3; }' |
+			      tr -d ,)
 
 	sbx_add "test_drop_reason" || return $?
 
@@ -373,7 +378,7 @@ test_drop_reason() {
 		"in_port(2),eth(),eth_type(0x0800),ipv4(src=172.31.110.20,proto=1),icmp()" 'drop'
 
 	ovs_drop_record_and_run "test_drop_reason" ip netns exec client ping -c 2 172.31.110.20
-	ovs_drop_reason_count 0x30001 # OVS_DROP_FLOW_ACTION
+	ovs_drop_reason_count 0x${ovs_drop_subsys}0001 # OVS_DROP_FLOW_ACTION
 	if [[ "$?" -ne "2" ]]; then
 		info "Did not detect expected drops: $?"
 		return 1
@@ -390,7 +395,7 @@ test_drop_reason() {
 
 	ovs_drop_record_and_run \
             "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 6000
-	ovs_drop_reason_count 0x30004 # OVS_DROP_EXPLICIT_ACTION_ERROR
+	ovs_drop_reason_count 0x${ovs_drop_subsys}0004 # OVS_DROP_EXPLICIT_ACTION_ERROR
 	if [[ "$?" -ne "1" ]]; then
 		info "Did not detect expected explicit error drops: $?"
 		return 1
@@ -398,7 +403,7 @@ test_drop_reason() {
 
 	ovs_drop_record_and_run \
             "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 7000
-	ovs_drop_reason_count 0x30003 # OVS_DROP_EXPLICIT_ACTION
+	ovs_drop_reason_count 0x${ovs_drop_subsys}0003 # OVS_DROP_EXPLICIT_ACTION
 	if [[ "$?" -ne "1" ]]; then
 		info "Did not detect expected explicit drops: $?"
 		return 1
-- 
2.48.1


