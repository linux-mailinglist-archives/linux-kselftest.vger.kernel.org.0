Return-Path: <linux-kselftest+bounces-29887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3169EA74CA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 15:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD3E37A3A28
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 14:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF84C21D3D0;
	Fri, 28 Mar 2025 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyzKF0JW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5391B4F15;
	Fri, 28 Mar 2025 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172101; cv=none; b=MQiGUKdMprmTIKAhjO7pFMM8nAtbk/eQV6Tz810jiqX/Un3yKgA2D2EsDrz7Kp8blQUPPFemzzwRqplWd5HCGWUXU8rRPGeZ8p93+h/6anCqxwvIRlWNApz3SpoKE7Kw7eAvHIfKlTSnOGqzPIBzeQFr0uBB1KGzxEN9bYvvcTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172101; c=relaxed/simple;
	bh=huDQ4vgkjBwI5c/TpdXiJlPetTIhi7oSTen6uASUw+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KG1hPLDCnOu/maB5FuV7SWZjP5krDDYtgyg5AuQilmB4KK1jz3NsC4IYAmSLuyZaVzEglJH5IeE116sNkNo/iEvoiRTncBE4vYLxKrz2MRCOuGlYXfmuL7kUgL0am4qMtZXoHkikVIoX3vBJwg7Pt1JHlI5GkF4+cY1EvrDNueA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyzKF0JW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E21C4CEE4;
	Fri, 28 Mar 2025 14:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743172101;
	bh=huDQ4vgkjBwI5c/TpdXiJlPetTIhi7oSTen6uASUw+U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dyzKF0JWikCnB7HKrZmFCk8Lt8Xl5jWowejSsDXyvTQY20oDL5WTHBrdr6Sft3Nce
	 vJQ8XqJgTXlavz8pvc66yAv+1WcvrDPpYoFUuGETOCi9PFX19Z8oACMvCaqSup3bEl
	 m1JTyXzxPybWHqGp3EABD2QOSGzb1m5IkhnqYLX2hv3wjz2K0XLAWKPcuxH5WKy4XZ
	 ZGMpAVk6zSEc8fHzSZzygxipCE1N0/e7bym5RGsD0ZYvUCtu6k6R0ZXdWA5ef7tBf7
	 kazpM5gowIeu6p79ZEheauedQjC5tKfFXbLLbx9yZ+p/MHTO0J08XqaBZ997eTSgZE
	 Phed4UQc3x9aA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 28 Mar 2025 15:27:19 +0100
Subject: [PATCH net 4/4] selftests: mptcp: ignore mptcp_diag binary
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250328-net-mptcp-misc-fixes-6-15-v1-4-34161a482a7f@kernel.org>
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
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=917; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=huDQ4vgkjBwI5c/TpdXiJlPetTIhi7oSTen6uASUw+U=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn5rHsXJqxAQ434DU1KAL3sueAHT0ICgCs3bYA3
 4HFIxsYT2iJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ+ax7AAKCRD2t4JPQmmg
 c+dSD/sFlsNkJp+W+2zDwXFLCWl+ajZ0L4vgRRzfGH2xBdnYTk5wYHDKGPwKDgiIDQRtIzoqL69
 cGJ6JAvyP27k5jQYPaqfUEULi94nLo1blElJ9O7DWdS3AN4I75VpnHQmjOBb37v4hIms9cswdoo
 Hj9mAtFZULR3xvit5tnogDmyV+XJmNA6J0JKjgum1vMyfoBp2VzP2CXZ0U/0HNZb3+hOYui+7Kc
 mZJkzAyja8QN1BEW/xaq1Mc1GkDqy1qPQjRl4LD4SnD3FEXcD+6DHekcNwAOX/R9ypfYAiVPcyy
 sV8cvcEWYurC8BJb1LEXd3tCEWPgCaVDpYx/qfLF824v1K2CqspFHnNkHLMazGjNH7Laaa7P+aF
 /YcCotYwoBECyxZpMfFxzWfw2FddEyyzkLidgk82ApL12fdH9gvTqGugW+LFtUprQKhZ6Snaar7
 rWgXeLhARzFW0B/sNKVr4fHQpLa6ntBQByS+3oIb4C31mJMi5Seu0E7RPiOReLSWDAUkc+M/guC
 dZpLz3fqFj84NbWg2bYkBsHmKA/cIenDiogJsFfnPYOCp8+GQnRweM8YsJ8S6LSRziNAIqD7rca
 FDgvd0FbrnIIBb/idFzImFsRGiIbS/juo2E/DJogiMHPtcNu4kcF1Ed31rBSyQqlRBRl4Hnlcad
 UwdOHwvmVmAkBCQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A new binary is now generated by the MPTCP selftests: mptcp_diag.

Like the other binaries from this directory, there is no need to track
this in Git, it should then be ignored.

Fixes: 00f5e338cf7e ("selftests: mptcp: Add a tool to get specific msk_info")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/.gitignore b/tools/testing/selftests/net/mptcp/.gitignore
index 49daae73c41e6f86c6f0e47aa42426e5ad5c17e6..833279fb34e2dd74a27f16c26e44108029dd45e1 100644
--- a/tools/testing/selftests/net/mptcp/.gitignore
+++ b/tools/testing/selftests/net/mptcp/.gitignore
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 mptcp_connect
+mptcp_diag
 mptcp_inq
 mptcp_sockopt
 pm_nl_ctl

-- 
2.48.1


