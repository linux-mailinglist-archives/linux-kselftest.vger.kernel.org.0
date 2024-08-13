Return-Path: <linux-kselftest+bounces-15222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7C89506C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 15:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16DF81C229B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 13:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E5119B5BC;
	Tue, 13 Aug 2024 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtXwyBtc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE30D60EC4;
	Tue, 13 Aug 2024 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723556389; cv=none; b=WiRNMg9A6w2C9OdBnfJJOLKTU01BXdDG0tJWyTq0RnW4jzsxYPSMvkpE71b1iSrSZbe6QF5xKst6ObxdlUvHHjtjGuCo/AxQ8z6MLAu+ll3glv/L8kQ2LyJH1gbBPhJizN1F0UOFcXfVHhxz1jb6eBx7Ilvaj5CQStoPQSSobsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723556389; c=relaxed/simple;
	bh=JiW2g111/T9vwg7V0O7d5Da9gYPfoiBmqdXrIR1zkBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hvMdLx3sAQFVq+2HHstY1aQ7q5pAeCEYwCg6bgZ458YJ4ieE7NR8uLG1zUlyCehVaIUzCKgjx62jPMPb+K8tOc+rG6yqYdgCwUqXK6VG0rTxTNSQQSgFMCdkTWDT+nkM7mB6eSQPDQr5kYsfcgxvSFTXrHElMNLgAvm8XP85ThY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtXwyBtc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C0BC4AF09;
	Tue, 13 Aug 2024 13:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723556388;
	bh=JiW2g111/T9vwg7V0O7d5Da9gYPfoiBmqdXrIR1zkBk=;
	h=From:Date:Subject:To:Cc:From;
	b=CtXwyBtcQmclsv9nEWsuu9fWoRpeALgeMKF3XTOwLR0DPm11eO7eo7wd6RivlwAAo
	 RWmiJ7FNnck6Z5N1zdtbmZoPtoG32dIoOtt6AWoHBS22Win4/QyWyoSTiMWVXQGKTz
	 2e3ftaV/EaHa6Bpsr6L8kOkL65dQCcv8pJho3I4JUYS1aaVz+jYtsHk+CZAUodEmU3
	 HyAn1PFowIMUG46kjyERJGlmaXvI1mGOM6DpAgZXKKjvIM6x9L9SijW1LJrwaU8YJ/
	 nzWnDt+de2JXzFWGZJOdBxET/x0WhfN1BR6G/TXduWfLbPWjYBNmhXkU9mTPYWRGql
	 BccoFIPm9weFQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 13 Aug 2024 15:39:34 +0200
Subject: [PATCH net] selftests: net: lib: kill PIDs before del netns
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-upstream-net-20240813-selftests-net-lib-kill-v1-1-27b689b248b8@kernel.org>
X-B4-Tracking: v=1; b=H4sIABViu2YC/z2NywqDMBBFf0Vm3QGfrfZXpIu03rSDMUomFUH89
 wYXXZ7D5dydFEGgdM92ClhFZfYJiktGr4/xb7AMianMyzpvi4q/i8YAM7FH5L9VOBuhUU/t5Mm
 jOMf21l1rU5mmtaCUXAKsbOddT2lJj+P4AUP8F1KDAAAA
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Hangbin Liu <liuhangbin@gmail.com>, Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1427; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JiW2g111/T9vwg7V0O7d5Da9gYPfoiBmqdXrIR1zkBk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmu2Ih2tgE3mKo82PooAHQqtAlS0SutfN+iLo+P
 bd/L7QH6tKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrtiIQAKCRD2t4JPQmmg
 c9lZD/9pH0LZLwr1ok0Jgepa9D2tQqV6P+qgeuOxnAnxA8j4inoPl5PUxLdLI1H3nKECS9WgFSZ
 yXsDwhtCQHKOzFfKrueNnTZSxJQJ5mHpMorxxPuhun6buI75wZXdIKEqCGekKq1GeCmaqv4+28u
 vW6mLWbQ0sjH2fpkN6KpWiQCgEmnM55iiS9AKWJF16XIkJMm7wzqwYqmoOAEFtqBrpPa6D6ikli
 90eKHxe7apSl1upOIXCNKI7bmPC/h6Ugr1cz81Bi/ieq5ApS6zmbQEGNHS5yh2jugWxPTp7Btc0
 x2jVqw0N0THPhmJBrA54S6dxspohY7f9MmSn6dYbu2zFbGDdcI5fHprscZRvMzgDqa/XeMjTKTb
 NYh/TsaWK0QVcqYuGtuXMjl+6Kj79Ll1+aPTGlPKlriXi0o/1Tns2yAVI1M1nqXQmpGM6eJlMMJ
 FLOGAU9m7S58OTd3LLb4AG19rrm5jtviQZkTe2UbQfssDfYT90jWz56bqGE0JcuxmbNb6qWUzD0
 UBeNJAbpVqCymjIZEsQL+jDXvRiTknCFovhYyqC00qZwrjfXKTaEbPL0GttFX4mK/zsBrVPLdvY
 +hbE5Tc9jatIMeJgO+jXjHCGUz9iBy7oKklJQ7B952H26nvac0d+rQ3HlhemfIM5Rx8Q7m3u4FS
 Iy3cpdO1gW3IvrQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When deleting netns, it is possible to still have some tasks running,
e.g. background tasks like tcpdump running in the background, not
stopped because the test has been interrupted.

Before deleting the netns, it is then safer to kill all attached PIDs,
if any. That should reduce some noises after the end of some tests, and
help with the debugging of some issues. That's why this modification is
seen as a "fix".

Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
Acked-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index d0219032f773..8ee4489238ca 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -146,6 +146,7 @@ cleanup_ns()
 
 	for ns in "$@"; do
 		[ -z "${ns}" ] && continue
+		ip netns pids "${ns}" 2> /dev/null | xargs -r kill || true
 		ip netns delete "${ns}" &> /dev/null || true
 		if ! busywait $BUSYWAIT_TIMEOUT ip netns list \| grep -vq "^$ns$" &> /dev/null; then
 			echo "Warn: Failed to remove namespace $ns"

---
base-commit: 58a63729c957621f1990c3494c702711188ca347
change-id: 20240813-upstream-net-20240813-selftests-net-lib-kill-f7964a3a58fe

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


