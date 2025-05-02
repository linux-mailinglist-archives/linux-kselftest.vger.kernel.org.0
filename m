Return-Path: <linux-kselftest+bounces-32177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 701C3AA71CF
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53161BC490D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE3C24BBFD;
	Fri,  2 May 2025 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzzBfZVR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0036425486C;
	Fri,  2 May 2025 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188982; cv=none; b=MIVUP9tNNv+EdU0jI/2tqSD7EDQOtRb6ebZYmHQR9l8teRExcfLvAEV+JoOFK6zWPVP7f+czDUrYpIX7qq0/Rkw6yYFegnINfHUwwP/31U4mYz5SMypcwS50t4n5sSCz8cn6tp2OKjn775R930NgLO1cFsORODtNPXLNK25/o3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188982; c=relaxed/simple;
	bh=7UMUwVfeSCKCbHTkA47Yw4k/uIlln51ZfD1HEo3PtXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l54HuEASu6AuN4ogB41zK22hln1LyKaJSMd3OtXSgPisc+BDHxkLC8VgegOrvGt4VpFTDb6lYzz0AU7qviB+tfz0pu4STTUkaiKE5w7t1+2QKyiUdq2mFCZ1topiahIMdOy7gbBfsmQfzrpHXCNwu1S8eYBpPdVYBp2BtvRf+q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzzBfZVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C07FC4CEF0;
	Fri,  2 May 2025 12:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746188979;
	bh=7UMUwVfeSCKCbHTkA47Yw4k/uIlln51ZfD1HEo3PtXs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RzzBfZVRAPH6XVBJarfLSHC2JJ0cf8qExjN7XCcyKM+DkXIKbVsM3bhaL8SGZ/udN
	 PSQSB+fRTkRUJLLK7buVH5mHq5WHEpqkmAyZ9ECEEUTyumWbDoAm+0t4d/gaDl38mj
	 71TCB8R/TZcmmNA/T2WUZJxAnA7zQD2+MBW9ITHYGG9KVZmmLB8KKIWhzNST0fw30X
	 +5OvJ5PmVbURXDwdZjwTKn621X8Mmi2JGlbON2VkcSiE3BlJRGrZ7RAvw4GRdaiIUf
	 fkPh7w2AzKxQsk79yMKzKYPaTlI/xF326F1UzfaUFg2C/oPyO30FhDMZ1hk15jOufk
	 Lcg2+8Z6XKvhg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 02 May 2025 14:29:21 +0200
Subject: [PATCH net-next 1/7] selftests: mptcp: info: hide 'grep: write
 error' warnings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-net-next-mptcp-sft-inc-cover-v1-1-68eec95898fb@kernel.org>
References: <20250502-net-next-mptcp-sft-inc-cover-v1-0-68eec95898fb@kernel.org>
In-Reply-To: <20250502-net-next-mptcp-sft-inc-cover-v1-0-68eec95898fb@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7UMUwVfeSCKCbHTkA47Yw4k/uIlln51ZfD1HEo3PtXs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJEdi0T3N9c9U2koObk/9py6SMeQgWTZLOyfh/TVRJ/7
 PH1CJd8RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwERKDjIynHAOlrxwMb3x+bbd
 DStnGJlm7plkODVRcd8n0ZorD6fpejEyXNvArZ+1ujgrYuJB7jmvTyxY9a5FULTBuTlaK2/yR+s
 yRgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_lib_get_info_value() will only print the first entry that match
the filter because of the ';q' at the end. As a consequence, the 'sed'
command could finish before the previous 'grep' one and print a 'write
error' warning because it is trying to write data to the closed pipe.

Such warnings are not interesting, they can be hidden by muting stderr
here for grep.

While at it, clearly indicate that mptcp_lib_get_info_value() will only
print the first matched entry to avoid confusions later on.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 051e289d79676c5feb9f46da67a08116548f4b47..99c87cd6e25563e220263c813223206ef6f4b311 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -331,12 +331,15 @@ mptcp_lib_result_print_all_tap() {
 
 # get the value of keyword $1 in the line marked by keyword $2
 mptcp_lib_get_info_value() {
-	grep "${2}" | sed -n 's/.*\('"${1}"':\)\([0-9a-f:.]*\).*$/\2/p;q'
+	grep "${2}" 2>/dev/null |
+		sed -n 's/.*\('"${1}"':\)\([0-9a-f:.]*\).*$/\2/p;q'
+		# the ';q' at the end limits to the first matched entry.
 }
 
 # $1: info name ; $2: evts_ns ; [$3: event type; [$4: addr]]
 mptcp_lib_evts_get_info() {
-	grep "${4:-}" "${2}" | mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
+	grep "${4:-}" "${2}" 2>/dev/null |
+		mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
 }
 
 # $1: PID

-- 
2.48.1


