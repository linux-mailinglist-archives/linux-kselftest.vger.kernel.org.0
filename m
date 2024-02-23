Return-Path: <linux-kselftest+bounces-5349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16447861763
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 17:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C681C24A1E
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 16:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90AE128384;
	Fri, 23 Feb 2024 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYQjiqLi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E26485C53;
	Fri, 23 Feb 2024 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704887; cv=none; b=k0m7SrUUxNOw3DLY+9Hgk14Ceprr8baw646e8BSZo3uU/b6O7lCFb6Z7iBB7MJW6GsMecVO40G3lsbqJzsJl10sLlLazetqjfkVk8SWANOCD2QewiGoRIQYf90ERuLs11RMyHHNvYjqHg0Gp1f60q6ZcO6t9hDGhWqKd2cDm/jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704887; c=relaxed/simple;
	bh=ue5sQop1UX80N3Oly9X4CFXlH4jZY6ypbaPw8tp4MNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dEgRYozT0Q88YIW4SNdC2a5Vp712qf0Q10AgpCvexCOLYyJOcnw4I/0rVRnkEgyWe2yCif2L0Ua8OIhirbr7CqgcLd2z5QBRxq00sSSxZRSyi/K52gEapBam4L+QJ9LCn1q28/GxRRATHZ3739+/TuVDcpInUiz/W7UsgD9vnEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYQjiqLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F7DC43142;
	Fri, 23 Feb 2024 16:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708704886;
	bh=ue5sQop1UX80N3Oly9X4CFXlH4jZY6ypbaPw8tp4MNk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OYQjiqLiSpvM+OSw5U4180OTYu2K26nqI1OOcVnhZcPjuFTcHW7fx3ZOq4tq/hhj9
	 JrEniQ9mW3MVh1IRfbHDC+Zrt2RMEcKcD9vTA5GkgZKXa7NN5nBmvfWWf8NThmmQer
	 XNUpZPo/DZvOayJeETWkt8Q+jm+xz3Xo7OGtGZHBHXtYoeAppzTcrbJj+lxXJ9DV/d
	 3ipgHXmL8F+qO6jw5+PpyuTpXpf5slB2MmqdVteX3YdrhVdqpIKk9EUj7GdGLK3KVh
	 o+PKYG991i5JWw3BCdYZVOWpyjyGEVjoQYLaPB7tcviZFXlxWthnEXupyxQAuUoven
	 4ieaDepF9/w7w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 23 Feb 2024 17:14:12 +0100
Subject: [PATCH net 02/10] selftests: mptcp: rm subflow with v4/v4mapped
 addr
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-upstream-net-20240223-misc-fixes-v1-2-162e87e48497@kernel.org>
References: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
In-Reply-To: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 Kishen Maloor <kishen.maloor@intel.com>, Shuah Khan <shuah@kernel.org>, 
 Peter Krystad <peter.krystad@linux.intel.com>, 
 Christoph Paasch <cpaasch@apple.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3748; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ZFk6g5PlJHfh11TlBjZmbnSS1q5EvGF/kQ+zZYNGb5Y=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl2MRq//6S05QxDI1G5XsvbBsehgLjYNABsmmvO
 oWybwGvJYyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdjEagAKCRD2t4JPQmmg
 c5KQD/92c/GlnMe7YDrf77OPpMvOybwPkaZgMchRNsMt5DqXM0C3dSRihG+iEXnRg3N/kq36R5E
 6XlsivfJHTS8hptn5iw5S2tzvONtgUAtle+kl/HcdWp7VS0AJbM92PRhvuxOBHRtsny+DjkvE0J
 R9+qIQapN0y/oiImFrmumcUJhZLJThoU0lHvLit6/5/mkJcZDJRleC1qJoreiNFqwqNQqfjMir1
 pMNeFDrU4jGhIo+t5pH3k0H/n4DmkIZf3tGT/ZFKOMEqjz7YKmyxVW2KrEygvx9RT81ErPTpjOv
 bITRmuwaQvM8Sd/A0BbQgrAnrzFYdLy76GWF9Hw1IIr6F/UVDVek77TaXHnpuDAAthMgwKj/k4X
 RehOQb/DotcD5xHr31JJ8ko63iQFPIh+ZwjhjkvpfZ/B0WtoSKWEnZdwv+vhTWvgocC7YoU5SvA
 2wXA2QVAGJ41cBdZtI2rLIzZVMfkUt01iAo2ZnEK+T5y8efxKVmaYPr63ooIIzLI8eFkn8ZYhT1
 IVUPmDXtK+ZKvX8Kr/wBTR4ZPPvQCZ3LRdCRVX4MaEA22FiL+3L3fIeu5UfoshD6QEgg3GV90Ad
 GfTVQ60aZ+IeF2uYedQukbC6wyqsX1pW5re2E3Gv9qOF9yxrXJsD8SRMLt5pJdtjWGEBZMOqaJl
 7X5etMjhYRy/8Gg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Now both a v4 address and a v4-mapped address are supported when
destroying a userspace pm subflow, this patch adds a second subflow
to "userspace pm add & remove address" test, and two subflows could
be removed two different ways, one with the v4mapped and one with v4.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/387
Fixes: 48d73f609dcc ("selftests: mptcp: update userspace pm addr tests")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 28 ++++++++++++++-----------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  |  4 ++--
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c07386e21e0a..e68b1bc2c2e4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3333,16 +3333,17 @@ userspace_pm_rm_sf()
 {
 	local evts=$evts_ns1
 	local t=${3:-1}
-	local ip=4
+	local ip
 	local tk da dp sp
 	local cnt
 
 	[ "$1" == "$ns2" ] && evts=$evts_ns2
-	if mptcp_lib_is_v6 $2; then ip=6; fi
+	[ -n "$(mptcp_lib_evts_get_info "saddr4" "$evts" $t)" ] && ip=4
+	[ -n "$(mptcp_lib_evts_get_info "saddr6" "$evts" $t)" ] && ip=6
 	tk=$(mptcp_lib_evts_get_info token "$evts")
-	da=$(mptcp_lib_evts_get_info "daddr$ip" "$evts" $t)
-	dp=$(mptcp_lib_evts_get_info dport "$evts" $t)
-	sp=$(mptcp_lib_evts_get_info sport "$evts" $t)
+	da=$(mptcp_lib_evts_get_info "daddr$ip" "$evts" $t $2)
+	dp=$(mptcp_lib_evts_get_info dport "$evts" $t $2)
+	sp=$(mptcp_lib_evts_get_info sport "$evts" $t $2)
 
 	cnt=$(rm_sf_count ${1})
 	ip netns exec $1 ./pm_nl_ctl dsf lip $2 lport $sp \
@@ -3429,20 +3430,23 @@ userspace_tests()
 	if reset_with_events "userspace pm add & remove address" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
-		pm_nl_set_limits $ns2 1 1
+		pm_nl_set_limits $ns2 2 2
 		speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
-		chk_join_nr 1 1 1
-		chk_add_nr 1 1
-		chk_mptcp_info subflows 1 subflows 1
-		chk_subflows_total 2 2
-		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		userspace_pm_add_addr $ns1 10.0.3.1 20
+		chk_join_nr 2 2 2
+		chk_add_nr 2 2
+		chk_mptcp_info subflows 2 subflows 2
+		chk_subflows_total 3 3
+		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
 		userspace_pm_rm_addr $ns1 10
 		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
-		chk_rm_nr 1 1 invert
+		userspace_pm_rm_addr $ns1 20
+		userspace_pm_rm_sf $ns1 10.0.3.1 $SUB_ESTABLISHED
+		chk_rm_nr 2 2 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 3a2abae5993e..3777d66fc56d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -213,9 +213,9 @@ mptcp_lib_get_info_value() {
 	grep "${2}" | sed -n 's/.*\('"${1}"':\)\([0-9a-f:.]*\).*$/\2/p;q'
 }
 
-# $1: info name ; $2: evts_ns ; $3: event type
+# $1: info name ; $2: evts_ns ; [$3: event type; [$4: addr]]
 mptcp_lib_evts_get_info() {
-	mptcp_lib_get_info_value "${1}" "^type:${3:-1}," < "${2}"
+	grep "${4:-}" "${2}" | mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
 }
 
 # $1: PID

-- 
2.43.0


