Return-Path: <linux-kselftest+bounces-11388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AA890082B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 17:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1303728C00A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 15:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D703719AD74;
	Fri,  7 Jun 2024 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X32ZPqp8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C8919AD68;
	Fri,  7 Jun 2024 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772547; cv=none; b=A+XU3UhiEFFbRaSan8ZQ+CtAst3E5YsI33zdsqtiRuWxuxQ8EUBq3vKP3+lE/QtrjdsJvvovTVSLdUie6MwpFlmR6fMRyJqtMU+CgLL7ltZ8lfkS1IPSUt6lUjMGUBKPA0mQvFKzirPjmpxlIedbZqQc9jXbzFBBdQ1fiyvEmtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772547; c=relaxed/simple;
	bh=cKM7RuuLhFgMfOSpl1D5KVRChq2EXU3zXiDN20uZq1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fJtIXEYNxoXUbRn9VLP41sgoomqgOoojFIiQGaS6MGJ6PrSXmtXGJy1iLjsKd1ZxeRH6s/xRfRof/TTInvL04J3ur42tWr7O30EVJh2MdhMlBueyqeIgxIYuuaxoai7Ayw791rB/N+CaT9LDRpWLpWX2F4rQm5J1n39SuYLzH7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X32ZPqp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C620C4AF0B;
	Fri,  7 Jun 2024 15:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717772547;
	bh=cKM7RuuLhFgMfOSpl1D5KVRChq2EXU3zXiDN20uZq1g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X32ZPqp8pL3M7UEoem9LcpQpherccDkUfwgMXRgsuqOPQiN7PZD8+vwJHTuMwzjsB
	 th+dnEIKItMTFlgKAoCt9c2fFG5E1jcAoXCvncx/e8d/Kd5Lw3f6Sg/D7ug6e/YwQk
	 DYu+IXhyt7kNNArMbvL9eSlpSPF5GkwuBERw0sPAhzAiAD/Ehx9jP8hgpDTU4eDw79
	 TZDSWPSPvytDfnzlgZr2GUBACV72cycCn5+Axwig9BTSmASPa3JiLfKC7BnYWyQB6X
	 fzBeVIeKZgQsqkA3SBkbVFxlJp/vhmdHRfsHG9eYAPccbhbAg7FUZ+KjqZp5R23i1D
	 mTNn7Xrb/CcqA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Jun 2024 17:01:51 +0200
Subject: [PATCH net 4/4] mailmap: map Geliang's new email address
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-upstream-net-20240607-misc-fixes-v1-4-1ab9ddfa3d00@kernel.org>
References: <20240607-upstream-net-20240607-misc-fixes-v1-0-1ab9ddfa3d00@kernel.org>
In-Reply-To: <20240607-upstream-net-20240607-misc-fixes-v1-0-1ab9ddfa3d00@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Davide Caratti <dcaratti@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1254; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wGAolGEs102WghMQ7nzLMzzJ0ECkA6N6A+zrTa6R6YY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmYyDyw/2uP1W59Z1eDvUQwISaJzZPOC18sXrTH
 fkMMUend7KJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZmMg8gAKCRD2t4JPQmmg
 c9zQEACJtxn7Ps76NavfBl9WiQKM1Js/m/TEgiPPw1GmtPdE0HnnwRJoUBH3vT1euwto9Yh9FJR
 xgpK+OB9EQOaw+RdyxBN1xoivdn3D0eYfobK0LlH8ZJgdTfirnQ/3AD+QVPACdB2Bm1UAmlk8ZB
 DMkYE1gFHloTGNQ/yCVlODhP35T1Rm2LmW99qeRDrsSIZSQWNxUSTJt0y9q9VKdNDPWVASl9EgA
 QlATCd8glOChFVab0Y4HR0oQ/ew54tNx06mgpoeVLoCmFKS95T9FxLXyUQoALD0mB8MATJHaboW
 njZ1IcEITRi3XIo3q5eqTb1F4VYC9cISz8yoiPsXKwCcuy+ZfU+1p5YyactsKPmXx6/N8Jyl5dR
 ZiXjN1O9rzFifuIvgQhofX3Sv+njIcpRkfBO6hd/GkEhe6jHa1Rzsia6mN+O71bXQTK+DcSdEY4
 MElswUIXBejARdqdUTHhkLXQqH1y3JTNTZfaoZoVbI/hpxNw86q057+eSLNdN4ckE1RssUlPR1r
 dEfW2sfZDne302UeumIZF/O5Lc0pzsUHvBN+iEPSykzI53mZw6S9dufR6M+YSVqMWnlHUjCQ2eh
 yoDnxGxqoF/vitap2aj+/T/ltOYgd4bhkqIoD71RXCK5IIXhns1IAr8EX71F0M7tra/vxXrav8k
 TrRkS7TLkKkQewg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <geliang@kernel.org>

Just like my other email addresses, map my new one to kernel.org
account too.

My new email address uses "last name, first name" format, which is
different from my other email addresses. This mailmap is also used
to indicate that it is actually the same person.

Suggested-by: Mat Martineau <martineau@kernel.org>
Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index efd9fa867a8e..9af91bd3584b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -217,6 +217,7 @@ Geliang Tang <geliang@kernel.org> <geliang.tang@suse.com>
 Geliang Tang <geliang@kernel.org> <geliangtang@xiaomi.com>
 Geliang Tang <geliang@kernel.org> <geliangtang@gmail.com>
 Geliang Tang <geliang@kernel.org> <geliangtang@163.com>
+Geliang Tang <geliang@kernel.org> <tanggeliang@kylinos.cn>
 Georgi Djakov <djakov@kernel.org> <georgi.djakov@linaro.org>
 Gerald Schaefer <gerald.schaefer@linux.ibm.com> <geraldsc@de.ibm.com>
 Gerald Schaefer <gerald.schaefer@linux.ibm.com> <gerald.schaefer@de.ibm.com>

-- 
2.43.0


