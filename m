Return-Path: <linux-kselftest+bounces-23860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E60A008B1
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 12:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 981857A1FE3
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 11:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9381FA15C;
	Fri,  3 Jan 2025 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ew+0hrnB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32461CDA2F;
	Fri,  3 Jan 2025 11:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735903910; cv=none; b=HjntnqjhH+wshMgTs7B8KM1aiwHcAg8/MtY2oUm5E3oO3YnTlZ4bJ2RREvDT2yQLyxO5LVpjuC0gVrRygl4itT11VytOQJ1gmoX9kc4tc9sDW2uTxYXoiaZTb9Rkk18BLHveYW/x3FGtqUyosSxHo+h+XRdddIqtcmcyjRvu0h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735903910; c=relaxed/simple;
	bh=5OjME6BSm/Atzhp4f5AdGJUG6pQDE6dzaH0awQrddjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MBP3ZbnBDJC0dgZoMiz538UM+iW2J9a0rjmb0U0TBS19m++KPmRqjkyfi221p0ra78r1DZ4Tk/RGmX1rLchCBZ67A09/PNwRVhcU21sfZwz5LeoRri/jUiPCqk/0dAQv7n30dDEy7kJwMijQrm84ySpwM9ekTTe3qsSWlv+CGwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ew+0hrnB; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6d8f99cb0d9so96804256d6.0;
        Fri, 03 Jan 2025 03:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735903906; x=1736508706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ys2oJFhfKDPHWIzvxKVUVfTyMPCWohwYzSs7v5VHzo=;
        b=ew+0hrnByR8a+fEM3haVvibYOAZZZv0NU/tSqu0ptzAtJwS1yyHSvgKinzeYPUzcIx
         qYAqxM6IsukX48hevfPtJwcq4oRoBB9MGJBG5xj6uUdfEBl8tx2M71dyFb44XOjR2wvy
         MyS7q287swM9GBP8FnA1g+uSKtbYTyjraT3wIVWoc29GhksQQLNf32F98nWtZ5vF77zd
         AyN2NCczP7nJAeCqUco3yaiB1WTKytR3SpZR1cOHpb6xZ0/MURbELLeC1tf/HT6ijAMJ
         LAGBXQp3KH2GAPWu0HHZD3/ThGxEjgJ0d9leBKgymYXa6uZCbhlcl4L5l1nUtm/RL/S4
         jxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735903906; x=1736508706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ys2oJFhfKDPHWIzvxKVUVfTyMPCWohwYzSs7v5VHzo=;
        b=YVlMNkrkd5pk+3CXQUdDZ1MGXHtjtxP8tZ9Mabi8TL9eYsFjBV9gTt/gXTgHz/DpHY
         hGTU5jfI+S21APhkS8XQyJGJ0K4Zyt5l2YvRxuMlNltCIIyJbimzBB2xOTnAH9/m6hbM
         fd2cqMXdqxAsCa54nh9n7LXVo6NKXgFLKApXaSthJw+2ACuIZ1Hj7extO05hkNDIChJB
         UC120iBDFtS7ChKf3gb3SrZFn/+BZ2XIobRCnMoSVhuaNnHKWByn9EcWnegU9Uuef0eu
         6qYh5y140nVZCBQRP3uU+6ux0LyG8Et70ENNNZMtJtne4MwvLzVJhCtsUffbbLJRWq+l
         rcJA==
X-Forwarded-Encrypted: i=1; AJvYcCWHAhlUWXDPHdQmQzIqpm1rTgza8MHd31/IlvC9WTVpkDyWpdHKNom79VSWx2k2Kq5KAd6VaAqB+rlf+PzmrgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPx4lw4aOAnzLA9lAh13ThlXGdF7GLYC9JL/aD6/iwiKPNs8KR
	VUGITF9ME/OxoDq3eHr9Did/6C8+Vejfgf0HLeUGqc4/VvA1FCLi0g46iFZgcjs=
X-Gm-Gg: ASbGncvKXM6DeFTsRHr3fwN9IWuxVAhlb0U0gq4cGfcHk5fH9tCPYBaiiE3WPGi0nKn
	3ReVz98ckVxTIRGv3Wv4Nrl6Ym0fehjnL1DqsQKk4w0IwifgSZy3VVVtS6EG3lw8tEZZBQ0NRX2
	LkFrQSUmdFK4H+BgSkf/d5MSUm7Aw26Ys5Q0nmDyMATFZwpUsMHfmIE/mtIGe61ecYdfDgP1oAX
	ClZLsMnaCqdbPDL1Gy/0ywoNIYhJBT7INl/bbK7ticT0nRHywMFjhO1Vd8AztqryHa/fXVr2HhL
	sAauYVR0foMX5ld9jjSf7QY5TEQasbNlRPWsohBw0QMZom9cPu8=
X-Google-Smtp-Source: AGHT+IHVm6imLAd/tpOMb1+qa4nnH103Eu2aIZO1ILl9wLFBNX61gx73eC9oYaf3grk2eoaB6lJVlQ==
X-Received: by 2002:a05:6214:1d21:b0:6d1:9e72:596a with SMTP id 6a1803df08f44-6dd2339dcc5mr726878596d6.37.1735903906175;
        Fri, 03 Jan 2025 03:31:46 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd18e3c3ffsm140117566d6.13.2025.01.03.03.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 03:31:45 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	sohamch@google.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] selftests/net: packetdrill: report benign debug flakes as xfail
Date: Fri,  3 Jan 2025 06:31:14 -0500
Message-ID: <20250103113142.129251-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

A few recently added packetdrill tests that are known time sensitive
(e.g., because testing timestamping) occasionally fail in debug mode:
https://netdev.bots.linux.dev/contest.html?executor=vmksft-packetdrill-dbg

These failures are well understood. Correctness of the tests is
verified in non-debug mode. Continue running in debug mode also, to
keep coverage with debug instrumentation.

But, only in debug mode, mark these tests with well understood
timing issues as XFAIL (known failing) rather than FAIL when failing.

Introduce an allow list xfail_list with known cases.

Expand the ktap infrastructure with XFAIL support.

Fixes: eab35989cc37 ("selftests/net: packetdrill: import tcp/fast_recovery, tcp/nagle, tcp/timestamping")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20241218100013.0c698629@kernel.org/
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 .../selftests/kselftest/ktap_helpers.sh       | 15 ++++++++++--
 .../selftests/net/packetdrill/ksft_runner.sh  | 23 +++++++++++++++----
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kselftest/ktap_helpers.sh b/tools/testing/selftests/kselftest/ktap_helpers.sh
index 79a125eb24c2..05a461890671 100644
--- a/tools/testing/selftests/kselftest/ktap_helpers.sh
+++ b/tools/testing/selftests/kselftest/ktap_helpers.sh
@@ -7,6 +7,7 @@
 KTAP_TESTNO=1
 KTAP_CNT_PASS=0
 KTAP_CNT_FAIL=0
+KTAP_CNT_XFAIL=0
 KTAP_CNT_SKIP=0
 
 KSFT_PASS=0
@@ -69,6 +70,16 @@ ktap_test_skip() {
 	KTAP_CNT_SKIP=$((KTAP_CNT_SKIP+1))
 }
 
+ktap_test_xfail() {
+	description="$1"
+
+	result="ok"
+	directive="XFAIL"
+	__ktap_test "$result" "$description" "$directive"
+
+	KTAP_CNT_XFAIL=$((KTAP_CNT_XFAIL+1))
+}
+
 ktap_test_fail() {
 	description="$1"
 
@@ -99,7 +110,7 @@ ktap_exit_fail_msg() {
 ktap_finished() {
 	ktap_print_totals
 
-	if [ $((KTAP_CNT_PASS + KTAP_CNT_SKIP)) -eq "$KSFT_NUM_TESTS" ]; then
+	if [ $((KTAP_CNT_PASS + KTAP_CNT_SKIP + KTAP_CNT_XFAIL)) -eq "$KSFT_NUM_TESTS" ]; then
 		exit "$KSFT_PASS"
 	else
 		exit "$KSFT_FAIL"
@@ -107,5 +118,5 @@ ktap_finished() {
 }
 
 ktap_print_totals() {
-	echo "# Totals: pass:$KTAP_CNT_PASS fail:$KTAP_CNT_FAIL xfail:0 xpass:0 skip:$KTAP_CNT_SKIP error:0"
+	echo "# Totals: pass:$KTAP_CNT_PASS fail:$KTAP_CNT_FAIL xfail:$KTAP_CNT_XFAIL xpass:0 skip:$KTAP_CNT_SKIP error:0"
 }
diff --git a/tools/testing/selftests/net/packetdrill/ksft_runner.sh b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
index 4071c133f29e..ff989c325eef 100755
--- a/tools/testing/selftests/net/packetdrill/ksft_runner.sh
+++ b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
@@ -23,7 +23,7 @@ if [ $# -ne 1 ]; then
 	ktap_exit_fail_msg "usage: $0 <script>"
 	exit "$KSFT_FAIL"
 fi
-script="$1"
+script="$(basename $1)"
 
 if [ -z "$(which packetdrill)" ]; then
 	ktap_skip_all "packetdrill not found in PATH"
@@ -31,16 +31,29 @@ if [ -z "$(which packetdrill)" ]; then
 fi
 
 declare -a optargs
+failfunc=ktap_test_fail
+
 if [[ -n "${KSFT_MACHINE_SLOW}" ]]; then
 	optargs+=('--tolerance_usecs=14000')
+
+	# xfail tests that are known flaky with dbg config, not fixable.
+	# still run them for coverage (and expect 100% pass without dbg).
+	declare -ar xfail_list=(
+		"tcp_fast_recovery_prr-ss.*.pkt"
+		"tcp_timestamping.*.pkt"
+		"tcp_user_timeout_user-timeout-probe.pkt"
+		"tcp_zerocopy_epoll_.*.pkt"
+	)
+	readonly xfail_regex="^($(printf '%s|' "${xfail_list[@]}"))$"
+	[[ "$script" =~ ${xfail_regex} ]] && failfunc=ktap_test_xfail
 fi
 
 ktap_print_header
 ktap_set_plan 2
 
-unshare -n packetdrill ${ipv4_args[@]} ${optargs[@]} $(basename $script) > /dev/null \
-	&& ktap_test_pass "ipv4" || ktap_test_fail "ipv4"
-unshare -n packetdrill ${ipv6_args[@]} ${optargs[@]} $(basename $script) > /dev/null \
-	&& ktap_test_pass "ipv6" || ktap_test_fail "ipv6"
+unshare -n packetdrill ${ipv4_args[@]} ${optargs[@]} $script > /dev/null \
+	&& ktap_test_pass "ipv4" || $failfunc "ipv4"
+unshare -n packetdrill ${ipv6_args[@]} ${optargs[@]} $script > /dev/null \
+	&& ktap_test_pass "ipv6" || $failfunc "ipv6"
 
 ktap_finished
-- 
2.47.1.613.gc27f4b7a9f-goog


