Return-Path: <linux-kselftest+bounces-17414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B4996FB71
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 20:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD161F23556
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 18:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5961D86D0;
	Fri,  6 Sep 2024 18:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OT/hBink"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7197214A4C1;
	Fri,  6 Sep 2024 18:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725648394; cv=none; b=gDUSTIn4yqRY0EqnZD8cTcKZUrEOt++TIIHLu0pLQDKlXyNnKsGn4bAJ7rwn8bkbqCXWjogt0ez/SW/kiSD14ptMDXRwC13WsV6blNhEkV1ZA0HjSMhXLp7nHGgIc72XaLgBRdCTKUhotQwcaLYGY5mIiF1nJUNUKUhxBWTl5No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725648394; c=relaxed/simple;
	bh=5veUrZt4a8truXcimSm6Y9QmQ92Ra0EaYasr2Zmdcgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B0KqqSnfw6g7UhgN0lXC3za7ZScB1/FwMnyXlBD7NOQNJOiWQup3Jqdty4NJJEmJE6SQnmq8m30eu16MeqI604391/uYVPiw5fRqC7PEhR4BcN6c6Dec5cy9NHqgAy4TQ2p6HBKu4rvHwwuV23GiTvxD6VnN31MRxzgGm9S6RDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OT/hBink; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB16C4CEC9;
	Fri,  6 Sep 2024 18:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725648394;
	bh=5veUrZt4a8truXcimSm6Y9QmQ92Ra0EaYasr2Zmdcgc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OT/hBinkt1SwaFdXMRiJrkE6O95fr/MZnG7aRavFHY6V8YcZyptwh6T/eqvUrgRA+
	 SkMIlQVI4PUSbHVkRMKcORWVMPvmsmLhYsQg0xOURuHsS5aym4mWKAqXHmmZfYElPf
	 aLxNUhDCMx84rDyHtNu1kGoTx4ncxXHU/In0E4ThUE5CpXzOW3EL8qdz5+KudSZ2EH
	 Vy5BjgCYumzlVX0apBBneRFztGExj2nVW0XkYfXU6KP3ZmLs2jdi23w/oXzv1bqZNO
	 jHmHB+FSs95RFe0lWJeXniYrL26HTf1kcm8av/xFi9tT6dtMiS6miRSbCjCX6PaxWt
	 0KIy/1/rBaiaA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 06 Sep 2024 20:46:10 +0200
Subject: [PATCH net-next v2 4/5] selftests: mptcp: diag: remove trailing
 whitespace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-net-next-mptcp-ksft-subtest-time-v2-4-31d5ee4f3bdf@kernel.org>
References: <20240906-net-next-mptcp-ksft-subtest-time-v2-0-31d5ee4f3bdf@kernel.org>
In-Reply-To: <20240906-net-next-mptcp-ksft-subtest-time-v2-0-31d5ee4f3bdf@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=907; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5veUrZt4a8truXcimSm6Y9QmQ92Ra0EaYasr2Zmdcgc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2038U18YSTE88hJT2LbLn/QOUBAEkygpSPs/D
 BQyRfr/WCeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZttN/AAKCRD2t4JPQmmg
 c2kAD/0Z4zmbgu6NOXQVKkH9FtwVb5ARaIe5w4QnNPy+uc3drD1vodBA6wtynp08ypzo1BQRHaR
 OlIe0M8KlSeji/AlsvdeQcuaiUJa+/id5xnjKbHzWJ5RCkK4VS0TqIzreaiVa55EjTpE+T6CpAF
 Gu4kioWBU2SjqaN+Cvz+i+njx6R/uDCWts1z5NVseRZgCCKuAP5QvqZe/5fjJpK6LxkjNN2L67k
 WT4/IT5ivLVf87YAEeVl4wr7SIaUuX3cdBtBriyAcX0n82E3aBhs/5ySQS75eCXWHNfh21NVu49
 fAykDey3aR/ggqkNDlmZMAjVCM3SbXRvpUGYFvCMltpTS51RYaCBkS4ZAN2IXHk506PuWLpLIrt
 k1RZ/wX/ki9wSn23LGEJHDrJr+enL4FP7Ija6yxjOmLlWDG9rhmnT96a4zx8MYAr/mw2C2mITGq
 +UzYLNp16DFMP6c0l97qfEFCGBLD0MKjKpxV3aq5I60StQAEPAQ7mohcQiC2fGeYkvcf4tYq39O
 41v6YfY9wkqOkEesbJ+bjCLm9g7uNL3+mEt4gZGdGoZBkjWXSP94CL5928s5rFEcYzrgjLME28X
 vXMx0dIBwf2jGnHZICWvgQpJpwEdg/mKUiR0MATdaYw8G0X8TVeQqbHDdYZtdd8wyhZI/wE8CVj
 BKQdS24nUv4Azow==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It doesn't need to be there, and it can cause some issues with TAP
parsers expecting only one space around the directive delimiter (#).

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 776d43a6922d..2bd0c1eb70c5 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -284,7 +284,7 @@ echo "b" | \
 			./mptcp_connect -p 10000 -r 0 -t ${timeout_poll} -w 20 \
 				127.0.0.1 >/dev/null &
 wait_connected $ns 10000
-chk_msk_nr 2 "after MPC handshake "
+chk_msk_nr 2 "after MPC handshake"
 chk_last_time_info 10000
 chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"

-- 
2.45.2


