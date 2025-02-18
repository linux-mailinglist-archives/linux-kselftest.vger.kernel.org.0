Return-Path: <linux-kselftest+bounces-26873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA68A3A320
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 17:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5744188DA0A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 16:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCF526F442;
	Tue, 18 Feb 2025 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pXXKbITS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F70D13B7B3
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897214; cv=none; b=qYmVXiETdxEGhE9CDxMlqG1gv+JeSy3SuviXtFIka41x/IUcuBAYsLULsRlUMJK4WEqP9Pn6lxSKKqR5uQLzW1e2ci3LjtIwTb29VtupbvuntzPltKwcjy+cm4zBJadlXns/F0gT8uXwcxvQ87EEY8xaLx5j5cRCZjcNbyRVRpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897214; c=relaxed/simple;
	bh=hB7UW+PmNq3DmiGSuXn2nDlFpRK2UeweO6ZapX8GizQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fS6AKScsBd3DQxbEEqT7/P0q4xYNZue148F2eFFdyOc6SkqoRVCLnkaEeSjN8V9rGWuXH1PLmeNXulzl3lOsYjbd92xhEMXorwlFtje/RSUjXv3LgF1Yah8z4Muucv2i55ZLWpE5xOo1Iv68ulYr6NdALn2jP5room9u/gMxyBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--krakauer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pXXKbITS; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--krakauer.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc1a4c150bso11134543a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 08:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739897212; x=1740502012; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mlx8JusrMvAxwGjao1rFJfj7oaa3+n+hmVGabdbHNaw=;
        b=pXXKbITSI6TOA4VSCLmLd/h5XRhbobs2AO25gn2eUyc6kR0f5Rm97nBnXief5kSebY
         d2K+/M0CQnixHpHDj3r0OJWOHzKi1VXaxuF6YX/mfEWw3sGb/ZShK9wQs2CgTrn0pJS4
         S62g1i1KWq+mQYRf9v3HxSxphLFRqkJKTqPo1qgKzAtmAWeJdFGRf1CEReY6id6N3aoO
         S0R3BYpjLNGz+GY/DFSHpNPOZZNw/GNYn7iYb90k/M5bqK0GXXIHgFFglpnddzKG05yu
         nbRwRTzpre9uoX63Q0O8P5tF2R/Mo99CUC3wLE2V4crTyeSArngJz+oINXaCXre9jGpA
         hLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739897212; x=1740502012;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mlx8JusrMvAxwGjao1rFJfj7oaa3+n+hmVGabdbHNaw=;
        b=OqTnfoRt0RlVPJzZBhCT+q5XL6c7jXR7hJfPFj9RlcVhfSSpMRLUwxr2y5XK/56jNC
         0ytR9fPxtPEwT9qneD45m3OCghgl8D/mHAKlROptAvNSSVPNaq3A2fQqELtlu4wDM8cK
         a/5Wwb/u4D8waB4ADpQQDhzTanAlMuP5RPrvI0sRGq5b+4lJRDpQj2ThiMubP6owDMdF
         Pbrwv7xLUwqEeb7MT5VRbsqxxLVbgFPlehdNYlQMqcECuCLrBfcDiEYiNhdt0ldJZQui
         ZzLCoDIF7PvxQ1hEDIgxZPip1Z/rnDQyOR5eM7zTxtgFHgDBN51jNUt+FMm4e3f3Zj41
         L+AA==
X-Forwarded-Encrypted: i=1; AJvYcCV2CSq7+0E60HQovvtrVRKEDrDTSjLaYJyRqdwmP/d6stPugzc4K56aHgEV7VdIbFu+MMe6aGsw/ydXrOHdYoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQBuUXFwkE02MeKaRL1UbWstMvZ5Pd/KyY9ExBCQ0EpONmPK5u
	s9/WTHBgx1gywFcFMnb8ZaiFIYNDxsQl0D7yDIOf2gfVv7b8bSb0Y9Jmq2Xsrx7HTK6dCZanJ5E
	LsoYFZfYd
X-Google-Smtp-Source: AGHT+IGQ565WwS0bcE+njAMsD6uuxc/9MmPyUG5Iox2HfLd6QcEJEWMbyoxQA9aBfz/ryG5Dk17Q7F6AH9dpiw==
X-Received: from pjbpl3.prod.google.com ([2002:a17:90b:2683:b0:2fa:1481:81f5])
 (user=krakauer job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2b4d:b0:2fa:226e:8491 with SMTP id 98e67ed59e1d1-2fc40f1027cmr21526874a91.9.1739897211731;
 Tue, 18 Feb 2025 08:46:51 -0800 (PST)
Date: Tue, 18 Feb 2025 08:45:55 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218164555.1955400-1-krakauer@google.com>
Subject: [PATCH] selftests/net: deflake GRO tests and fix return value and output
From: Kevin Krakauer <krakauer@google.com>
To: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	Kevin Krakauer <krakauer@google.com>
Content-Type: text/plain; charset="UTF-8"

GRO tests are timing dependent and can easily flake. This is partially
mitigated in gro.sh by giving each subtest 3 chances to pass. However,
this still flakes on some machines.

Set the device's napi_defer_hard_irqs to 50 so that GRO is less likely
to immediately flush. This already happened in setup_loopback.sh, but
wasn't added to setup_veth.sh. This accounts for most of the reduction
in flakiness.

We also increase the number of chances for success from 3 to 6.

`gro.sh -t <test>` now returns a passing/failing exit code as expected.

gro.c:main no longer erroneously claims a test passes when running as a
server.

Tested: Ran `gro.sh -t large` 100 times with and without this change.
Passed 100/100 with and 64/100 without. Ran inside strace to increase
flakiness.

Signed-off-by: Kevin Krakauer <krakauer@google.com>
---
 tools/testing/selftests/net/gro.c         | 8 +++++---
 tools/testing/selftests/net/gro.sh        | 5 +++--
 tools/testing/selftests/net/setup_veth.sh | 1 +
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
index b2184847e388..d5824eadea10 100644
--- a/tools/testing/selftests/net/gro.c
+++ b/tools/testing/selftests/net/gro.c
@@ -1318,11 +1318,13 @@ int main(int argc, char **argv)
 	read_MAC(src_mac, smac);
 	read_MAC(dst_mac, dmac);
 
-	if (tx_socket)
+	if (tx_socket) {
 		gro_sender();
-	else
+	} else {
+		/* Only the receiver exit status determines test success. */
 		gro_receiver();
+		fprintf(stderr, "Gro::%s test passed.\n", testname);
+	}
 
-	fprintf(stderr, "Gro::%s test passed.\n", testname);
 	return 0;
 }
diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftests/net/gro.sh
index 02c21ff4ca81..703173f8c8a9 100755
--- a/tools/testing/selftests/net/gro.sh
+++ b/tools/testing/selftests/net/gro.sh
@@ -21,7 +21,7 @@ run_test() {
   # Each test is run 3 times to deflake, because given the receive timing,
   # not all packets that should coalesce will be considered in the same flow
   # on every try.
-  for tries in {1..3}; do
+  for tries in {1..6}; do
     # Actual test starts here
     ip netns exec $server_ns ./gro "${ARGS[@]}" "--rx" "--iface" "server" \
       1>>log.txt &
@@ -100,5 +100,6 @@ trap cleanup EXIT
 if [[ "${test}" == "all" ]]; then
   run_all_tests
 else
-  run_test "${proto}" "${test}"
+  exit_code=$(run_test "${proto}" "${test}")
+  exit $exit_code
 fi;
diff --git a/tools/testing/selftests/net/setup_veth.sh b/tools/testing/selftests/net/setup_veth.sh
index 1f78a87f6f37..9882ad730c24 100644
--- a/tools/testing/selftests/net/setup_veth.sh
+++ b/tools/testing/selftests/net/setup_veth.sh
@@ -12,6 +12,7 @@ setup_veth_ns() {
 
 	[[ -e /var/run/netns/"${ns_name}" ]] || ip netns add "${ns_name}"
 	echo 1000000 > "/sys/class/net/${ns_dev}/gro_flush_timeout"
+	echo 50 > "/sys/class/net/${ns_dev}/napi_defer_hard_irqs"
 	ip link set dev "${ns_dev}" netns "${ns_name}" mtu 65535
 	ip -netns "${ns_name}" link set dev "${ns_dev}" up
 
-- 
2.48.1


