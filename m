Return-Path: <linux-kselftest+bounces-2077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A286B814C7B
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 17:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E521C2378F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032383FE44;
	Fri, 15 Dec 2023 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQaX8NIH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A7C3FE40;
	Fri, 15 Dec 2023 16:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB61C433C9;
	Fri, 15 Dec 2023 16:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702656299;
	bh=mEEyQsmCIMqT+EIvuVvdc3euGh/zmow8EeCo+TKdPoI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DQaX8NIHovESKeQHduownHwMEP6hKSiwqfTNrSbRob8tHe0iy5+a0MbS3K36UW0LB
	 Bx+EKlsXdWwe1njy+BjfIkn465pMaqn5fF30hAaOVJuzv1pK0x+xI/Nu4gexzQBnH6
	 g+uCLgTs1YUz0cKDLcCrNlgmz9+7QBpGDoHbp6FJDEuLzUWT++XzSNeNwUG6tynLua
	 WKiaZUDrnndRuFowgNUA+caZbJIfg4ncGKSShMfiU8PwE6EPalE1XLMhVXFWkNvXN9
	 4wc6GUHWCW0Rr9WpwcTnjJKbPCjED5waZBJz+5OarHKz5RqHGuY6JKnJERYw0g2Owg
	 MY4lXLluw0BRg==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Fri, 15 Dec 2023 17:04:27 +0100
Subject: [PATCH net 4/4] mailmap: add entries for Geliang Tang
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-upstream-net-20231215-mptcp-misc-fixes-v1-4-91d20266d525@kernel.org>
References: <20231215-upstream-net-20231215-mptcp-misc-fixes-v1-0-91d20266d525@kernel.org>
In-Reply-To: <20231215-upstream-net-20231215-mptcp-misc-fixes-v1-0-91d20266d525@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Benjamin Hesmans <benjamin.hesmans@tessares.net>, 
 Dmytro Shytyi <dmytro@shytyi.net>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>, 
 Geliang Tang <geliang.tang@linux.dev>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1162; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=F+SFbQ1h53EM63JkYmEA4FqecIVJLbDI7sWcAXIJA8A=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlfHkbBU0vL8oo3TD8O7+05tLkIK3rTr1TIpgbC
 XH5/mXP5q2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZXx5GwAKCRD2t4JPQmmg
 c1bdD/9Df8lKXoEqQTB1znSsnUo6yQt/h0EVbLpP4kcIVAtsQWlJeJ6bXZEyP5u1ONR6N+b95oK
 NOccqbP9Nkl/60ZWH5XdRKEpM9NMDSNwukvKZwDMEkm9pA8Hn5Fs5wqs3TH5wYNNJKUFMcNv91E
 uVzCLPzLGgUAbKSe5zNAimEci0SIQEX8H4Hc87rY89TwDbWimwHNyPwvCqHrSCe8MRRG+mlXbrG
 N3Inf3AtVwF8AAjwisUTVOSJKkD1hAx+SKZQne973WYOAUXuVytOjZnoEXXL4phVrtFVJQu6wRc
 3ydVuWfPf2dVw583zyH8E6ku0HqQeCVwPJOICdfK+GzIiJhxBh6f7UZpL5a1or39U/poT83BOiQ
 yr35vOCGqC2+zjbkRGv6VLkLoopQi4slPXiD+JEYY/wSgpQO+SyNDwyKLNiSR3h7YAMgTqmERkp
 aSaP3lL5vnLaUvUxscO5rayZ/nA7rw3YXvgaFkl5drMDzzByqjjiw/rI078MWqpVAuMCZMNnLhD
 /VsJfbEacNnLU4cRObB5n3xS6vtH6Q66ge4NqMkyFKJ8A69z1lbxB5cZGnVdy9Fcd6a9v8SkgTD
 AjsgHx8g3l+f/JBO1KMd80xk+PAJpY3yvYt5ShHTMmt5vsFTXq8+BVPjhHJ3iFyXCRopBSDOC4S
 km518yJZ7BevPXg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <geliang.tang@linux.dev>

Map Geliang's old mail addresses to his @linux.dev one.

Suggested-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 .mailmap | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.mailmap b/.mailmap
index 3ac1c12545f2..68e72a6017a0 100644
--- a/.mailmap
+++ b/.mailmap
@@ -191,6 +191,10 @@ Gao Xiang <xiang@kernel.org> <gaoxiang25@huawei.com>
 Gao Xiang <xiang@kernel.org> <hsiangkao@aol.com>
 Gao Xiang <xiang@kernel.org> <hsiangkao@linux.alibaba.com>
 Gao Xiang <xiang@kernel.org> <hsiangkao@redhat.com>
+Geliang Tang <geliang.tang@linux.dev> <geliang.tang@suse.com>
+Geliang Tang <geliang.tang@linux.dev> <geliangtang@xiaomi.com>
+Geliang Tang <geliang.tang@linux.dev> <geliangtang@gmail.com>
+Geliang Tang <geliang.tang@linux.dev> <geliangtang@163.com>
 Georgi Djakov <djakov@kernel.org> <georgi.djakov@linaro.org>
 Gerald Schaefer <gerald.schaefer@linux.ibm.com> <geraldsc@de.ibm.com>
 Gerald Schaefer <gerald.schaefer@linux.ibm.com> <gerald.schaefer@de.ibm.com>

-- 
2.40.1


