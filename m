Return-Path: <linux-kselftest+bounces-29885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C5CA74CAB
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 15:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334171709EB
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 14:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A14B21B9DA;
	Fri, 28 Mar 2025 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nggSPkdQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EC31C4A2D;
	Fri, 28 Mar 2025 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172095; cv=none; b=nuwKvcue3dwHVTpGfPwWLRIWGBMUwg9h/ZhW5bhe13yk27qpIqNpmIES+1CtptCim22SyTBeVmNIVp2KPM3M5Az7pPY4ByU2z6xN52GIKsOCMmWCG0Ua0x8Fayb/loexhsRn6nznAnQKCedNMTvLtB1SDHM3XjlYrxDpk6Rr6VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172095; c=relaxed/simple;
	bh=UzzA5fAP2Dx0SztHOiKfMPXcl8apEI1hqtTzaMI+F/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R2cyHZtueOrPNPAAL8D+R7MIAcC0b3THQ3zqEf5wiye0T8fj6vMzi1U0YX94f6RQLdI0JcQi1TpWfv/UolUiE2baDfBortzAql7z3JIsAGF+EXcY3qxu5vv6yN+4oD5SyL8krlHIEvwlQveghC6fVof2ew6IUrzVx3rdTywLUmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nggSPkdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E7BC4CEE4;
	Fri, 28 Mar 2025 14:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743172093;
	bh=UzzA5fAP2Dx0SztHOiKfMPXcl8apEI1hqtTzaMI+F/8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nggSPkdQ0XpACcjJ+7ojDG4wsiDU5c9b9g5/LcPapFygTaCwu3larsnQkyJE3iDZA
	 L0CVQyTWkBUETI2UEmkPZ3DClgP4EV8p9QhRIU7k/WwDT4KWb5iyF47DbScjdLKXlL
	 +pZujubpFF3nvtmZkNg5jOH49A5ghb+Sif6pFKHG+5LrL+VwsbA+bjuO0Ehx4j1G6Q
	 xxZRcs5rbNRGK+BIkxONGgGXKHXVnll0iUvJOeBbpUSd/MMPq+lxvpDzAUraT5i/bQ
	 yyPmAq1CkrRUMlM55wQmZ8PgN5oGWpA64VLgNJFijyiCjrvZmAepSo41IkDM+8avaC
	 4f4wulcvnjY1g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 28 Mar 2025 15:27:17 +0100
Subject: [PATCH net 2/4] selftests: mptcp: fix incorrect fd checks in
 main_loop
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250328-net-mptcp-misc-fixes-6-15-v1-2-34161a482a7f@kernel.org>
References: <20250328-net-mptcp-misc-fixes-6-15-v1-0-34161a482a7f@kernel.org>
In-Reply-To: <20250328-net-mptcp-misc-fixes-6-15-v1-0-34161a482a7f@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Florian Westphal <fw@strlen.de>, Shuah Khan <shuah@kernel.org>, 
 Dmytro Shytyi <dmytro@shytyi.net>, Gang Yan <yangang@kylinos.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Cong Liu <liucong2@kylinos.cn>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1533; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=IA96LjQa8kXcVI3ABDI0xQDEyIBxJV4dvjuDH3s9p1M=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn5rHsOowwUolVqffW3vZ5A9oAXqXLAfO72SP4v
 AF7T9ugrR6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ+ax7AAKCRD2t4JPQmmg
 c81CD/9UQJIbICFRPFxRNPn7FMRv4T5Ng1tACi1BNyuEU5w7lt8/9gz+1ZZ+KE/ZcmkHC/fgTqD
 L8F1WNboFU5e+YZGmERBHM2APdPl8eTMW5Dpm6t5r6DbxllsJ8ggldBGRTCEwpzcuf9UWcrUWXy
 bkSBVx568SkTNsZPrLZidR4KAI4uUXtFAGNzdjxdQ+ooalAQ+ylOPPRTK2mzU7c3iL/EofhaO0N
 VgE/ccsBIq+PnTwZTxIGYxQz7Z2ULVsyObN+HejSBnNlOsEAh000srn/4Mca0GBJ86/cOVTE1jP
 UZN+Vyc0O84hGoxaRfgCeNG5p+QvP50xugkAAgcpwR33xascPXUMlrMmmZoAWo8AbygWy6qzKBh
 Py14sKuHEp6P1VNOMgOIwqPgjhiMrk7cBG3kiqPDMCXfiu8i8+8a7M6vdRRJ7wmXACIEaudxGVI
 Y5/fA4pVr43WHFcdM9x8k6ebsxoeaVsv4AcDoyNW32EXij+co7dU83teh2EmAg115otvyJQxr5o
 4T+JuUQ6vsxTlnr2XQ+XLWfFsgY/ppPCdfywJIU32ZvlBDZt2h+bEm/xQ8u2i7WQ1caoh9vIUKK
 S3CHgdjye6FuIPWJWSk9AApZ4zcF5S7RzMJAaTDTPRbrcQyXjFMBfYL+PbCbNnt7GQlGixSnZuG
 iYeQJ72LnNPDjsA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Cong Liu <liucong2@kylinos.cn>

Fix a bug where the code was checking the wrong file descriptors
when opening the input files. The code was checking 'fd' instead
of 'fd_in', which could lead to incorrect error handling.

Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
Cc: stable@vger.kernel.org
Fixes: ca7ae8916043 ("selftests: mptcp: mptfo Initiator/Listener")
Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Cong Liu <liucong2@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index d240d02fa443a1cd802f0e705ab36db5c22063a8..893dc36b12f607bec56a41c9961eff272a7837c7 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1270,7 +1270,7 @@ int main_loop(void)
 
 	if (cfg_input && cfg_sockopt_types.mptfo) {
 		fd_in = open(cfg_input, O_RDONLY);
-		if (fd < 0)
+		if (fd_in < 0)
 			xerror("can't open %s:%d", cfg_input, errno);
 	}
 
@@ -1293,7 +1293,7 @@ int main_loop(void)
 
 	if (cfg_input && !cfg_sockopt_types.mptfo) {
 		fd_in = open(cfg_input, O_RDONLY);
-		if (fd < 0)
+		if (fd_in < 0)
 			xerror("can't open %s:%d", cfg_input, errno);
 	}
 

-- 
2.48.1


