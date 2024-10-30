Return-Path: <linux-kselftest+bounces-21061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B839B5828
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 01:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B79A128426D
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 00:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614A11B95B;
	Wed, 30 Oct 2024 00:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTqSzKPP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397381A28D;
	Wed, 30 Oct 2024 00:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730246541; cv=none; b=gNYqeIHM95XwWPMCIiS4y1ue2QIwdQRBlmmwjL9AqPrdC0aN2dVgVTH7wqLg5Sgx6GaA840ZMTEX5QpCuSwu8xtHleXT3aTk1j5oN8BiO36WTauZ9z23Px5yz5BtD05z1VJEI1d5Hl94cGOkZNEZiMORKu/bz8yY7Sz1l7kTXps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730246541; c=relaxed/simple;
	bh=23oJHFxrvuSewIwap7rSA/8FNEEUIPofhXCAsl9/RTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OzKEPanmeHGDBxFvyKMA1TNL0Ci33jBLW9wrv2Lrac69YmxZ1RadQ1LhKbR+x6m5nr9I9I/RKnv2Ictia7Dsgs5fE4Vay0gPFwINDfcfXAHy0FVBMmUL8Q7ACvCKtWywoPBWWoa3FBbXKnJrqcPJ2C0rhjInjXREmWK9FJZ/Vns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTqSzKPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EF6C4CEE6;
	Wed, 30 Oct 2024 00:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730246540;
	bh=23oJHFxrvuSewIwap7rSA/8FNEEUIPofhXCAsl9/RTM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JTqSzKPPcQ3dsKDHLaUvm+5/qTGg82iIoB0/XMkkvTmif22ycFYV5U1D8zoNn+Cad
	 sVg++jviHkAluFHIPsCDrqOLFFKbQaG+TKYrLgJZvIqqxFOav3JQ7TIzG00wVSaMkH
	 HT71oYWQePg2sDU0ykkUxvapEdOmXzMn8LjZUKV+dSUyQY2e2MQJCXs9P5XDZorP/Y
	 Du9qVZ+C35k5AanWtgb8wekuIx5zvHBzuv04exYqxoL1x2dgJSK9APa7U8H+zGBNOr
	 lfImTpwHyvfFyf0UW0ByjhuKLcEVvdm+Upmkxc1O0rgtZlRGfzowDF/ZXhKlU5yODO
	 FMwpRNuD+yr9w==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 30 Oct 2024 00:02:03 +0000
Subject: [PATCH v2 2/2] kselftest/arm64: Poll less often while waiting for
 fp-stress children
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-arm64-fp-stress-interval-v2-2-bd3cef48c22c@kernel.org>
References: <20241030-arm64-fp-stress-interval-v2-0-bd3cef48c22c@kernel.org>
In-Reply-To: <20241030-arm64-fp-stress-interval-v2-0-bd3cef48c22c@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1959; i=broonie@kernel.org;
 h=from:subject:message-id; bh=23oJHFxrvuSewIwap7rSA/8FNEEUIPofhXCAsl9/RTM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnIXeGVNSBOH+sGSKXore1Gd/kJ/0o+aCmx3u/FLAV
 9an02buJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyF3hgAKCRAk1otyXVSH0BkzB/
 9WJ/5pJEB0/hdewFpULVhgdAGJs6V0VYgs2vsqJ4fF3/+9XVqhkfpBm838MjBME3clAqFmSW7NQPPu
 hd6MVVNpyxIkCKWQVztJxiGvYr2XmphdMmKiLDDbQx+l9Vgl1pbb2CVlPzbMkF/jv1quOdLjZr8kJc
 6LnFa4YJUxJqoFDrlvPVDQVBtTJZWGhs5d+roa+MbaUSHPGHpiTSSjpkv0N9skoYmPHYYrlu/6zHNk
 aqFZQgJr/XeOmx7Pc4ky8crARqIIZBndN6liHtNL0ftmUW/2+5sA0alwZNowavvNHJNF0ASmaMjMu1
 RS/Nf9gXpN+EDY5FncU40JVbGwKzPV
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

While fp-stress is waiting for children to start it doesn't send any
signals to them so there is no need for it to have as short an epoll()
timeout as it does when the children are all running. We do still want to
have some timeout so that we can log diagnostics about missing children but
this can be relatively large. On emulated platforms the overhead of running
the supervisor process is quite high, especially during the process of
execing the test binaries.

Implement a longer epoll() timeout during the setup phase, using a 5s
timeout while waiting for children and switching  to the signal raise
interval when all the children are started and we start sending signals.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-stress.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index 71d02c701bf56be56b7ad00a5f6614e33dc8e01b..4f1ef260ce7a26d24092fe9337714f8c3922070a 100644
--- a/tools/testing/selftests/arm64/fp/fp-stress.c
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -453,6 +453,7 @@ int main(int argc, char **argv)
 {
 	int ret;
 	int timeout = 10 * (1000 / SIGNAL_INTERVAL_MS);
+	int poll_interval = 5000;
 	int cpus, i, j, c;
 	int sve_vl_count, sme_vl_count;
 	bool all_children_started = false;
@@ -588,7 +589,7 @@ int main(int argc, char **argv)
 		 * especially useful in emulation where we will both
 		 * be slow and likely to have a large set of VLs.
 		 */
-		ret = epoll_wait(epoll_fd, evs, tests, SIGNAL_INTERVAL_MS);
+		ret = epoll_wait(epoll_fd, evs, tests, poll_interval);
 		if (ret < 0) {
 			if (errno == EINTR)
 				continue;
@@ -626,6 +627,7 @@ int main(int argc, char **argv)
 			}
 
 			all_children_started = true;
+			poll_interval = SIGNAL_INTERVAL_MS;
 		}
 
 		if ((timeout % LOG_INTERVALS) == 0)

-- 
2.39.2


