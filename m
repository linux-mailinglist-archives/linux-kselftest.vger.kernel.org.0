Return-Path: <linux-kselftest+bounces-28895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63680A5F090
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A25B3AC046
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 10:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1E1265CBE;
	Thu, 13 Mar 2025 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9DgNpNB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DB7265CB9;
	Thu, 13 Mar 2025 10:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861319; cv=none; b=tlkJZtQ2rQEyooj97PIg56xriApyp08/VVlS8knIFLkDQFPJh3Hzu7k6YTPZefpClTzrh//NTvKMzCjhpqiYYB2zXiBG8+sRyQNto7TDw9krq1m/zsfE8ZBUICd1Mn9K6GXWErgxb6TQlXYkfLUaqipdnCK0NxrXKtHKsMouNnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861319; c=relaxed/simple;
	bh=o0CjrfZ5Is2Xux0SAn6zModXKrNd/29zuYsF/mkkoEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SigXNXow4iUeD4HsmPxUPmYc2frq39dPwJRGZyD9/vRjJwVaLNkINSvglXRIZidgkE+HBQUJz8rhSHFna3NJH16ZP9912rii3Ss2IcgiIF9jd0EXapsdl477P4SBhu1ulZHOnD5RN/+fQsdIOBneInN9+F2//rKWDpvc6aXSIr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9DgNpNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4FDC4CEEB;
	Thu, 13 Mar 2025 10:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741861317;
	bh=o0CjrfZ5Is2Xux0SAn6zModXKrNd/29zuYsF/mkkoEo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j9DgNpNBbokOYGPvl1RgIi4wbdzj9NA9CKPQP8IuPfk2YiVm57J+HuUuYmI4XpuQA
	 jX67foYWSeXki0emiAcbbTAOAFamGnu9I8/a2ghOcEOpSYy8IY6lbH+aJKwii3g7A8
	 Xr1nRSqt0gs19G9hPMRiDHGyHJ9JGRW0w6/DBAjj23RTV2cHMVE/enfOp3BoK/U84/
	 Ilv2Lp0wNyxrlOP6dfXRuooCpFTrzQ8MEOyLIU0AxAZ7hhsWLiAr0tlgpoH9P8AAMS
	 X2y/nLloqSQz4DjoB3in5h+DE2XG3GFkk6Muf0S9fYuG9l8b2sSFre+l0B42wBjiBV
	 FL/0kRhabjZKA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 13 Mar 2025 11:20:52 +0100
Subject: [PATCH net-next 03/12] mptcp: pm: use pm variable instead of
 msk->pm
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-net-next-mptcp-pm-ops-intro-v1-3-f4e4a88efc50@kernel.org>
References: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
In-Reply-To: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1664; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Lum1mU2EuCIAet8E5qg09InifroIj9AZFDk1mNVEyWA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn0rGafkY0DTp4jYWOVXpJtuTkl0P1tfntlRyl0
 40LQV/lJNuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ9KxmgAKCRD2t4JPQmmg
 cwhrEADdFiwZGOsbSzQYg2yHmK5+0HjJq2daQap1pmQVFyUW1Zgq+VqMPUpz3ofHoHs/SefrXde
 jaKN7ZBeqBQFti/K6FquzRmpCuHU/qR1A4Gar/o0i6efqmUNcMTmx0eU89lPKxUzOMK0SgvSzIb
 c/Q+is8NBB9nUrhSban6+MBR5apCnI8S51bNpkK625ekp4LsKGhK0Pl1HQy9OSZs0WDbhlDZCKc
 m6wuTJSMmBMZ17Mclx8TAU+NmgLoGlKXtcGzF0ufIoEPqnMJthFO0aCGVdtOF8Fsm4j75nvP2aL
 ZCH3DVay98vacgijrU9fcOme8TkMpahPa6KlQpzQ3ux1L0aAm1tXeTSApuYdX622BvFCXjwGFLv
 MHaON58/lFYLIphVoZJ5i2AHPniSrUQkZ67dUcPb+yDJirhX3y/A9AjZpzSI1ikbjzON7Qcu1xP
 eCg/NxRK6S3icORj2EVHYKdwI8J8c2KBCmMVTsw8uRq/pVckTtUeeoWRyhkMVQAM4/D22h+RyUo
 2d0xWKml5HIEZ+Hn5GAFhVFnpC3U0IEUoGLKNfa9cYZ+3omGol2OE5txy4fOF8SqQrloLFgD9WC
 83mX0qyaysB69KhzFi8g5hrO0uhMVxICp+w/3Olf91c0SBTwAmzSr1KCegiwn28Yz504TYqM6Ci
 wCoDHtxoxTvqU7g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The variable "pm" has been defined in mptcp_pm_fully_established()
and mptcp_pm_data_reset() as "msk->pm", so use "pm" directly instead
of using "msk->pm".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 8e6a325a389803196c35175cd5ea7637624d0ee2..04a156395aaddf50e67d10479086591a37063fa3 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -511,13 +511,13 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk)
 	 * be sure to serve this event only once.
 	 */
 	if (READ_ONCE(pm->work_pending) &&
-	    !(msk->pm.status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)))
+	    !(pm->status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_ESTABLISHED);
 
-	if ((msk->pm.status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)) == 0)
+	if ((pm->status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)) == 0)
 		announce = true;
 
-	msk->pm.status |= BIT(MPTCP_PM_ALREADY_ESTABLISHED);
+	pm->status |= BIT(MPTCP_PM_ALREADY_ESTABLISHED);
 	spin_unlock_bh(&pm->lock);
 
 	if (announce)
@@ -1009,7 +1009,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	WRITE_ONCE(pm->addr_signal, 0);
 	WRITE_ONCE(pm->remote_deny_join_id0, false);
 	pm->status = 0;
-	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	bitmap_fill(pm->id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 }
 
 void mptcp_pm_data_init(struct mptcp_sock *msk)

-- 
2.48.1


