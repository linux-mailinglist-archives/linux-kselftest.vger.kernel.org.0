Return-Path: <linux-kselftest+bounces-30651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C603A8715B
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Apr 2025 11:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E51179054
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Apr 2025 09:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E36C191F6A;
	Sun, 13 Apr 2025 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjpMTp86"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F36422339;
	Sun, 13 Apr 2025 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744536919; cv=none; b=IurrnXUf41m5LSEEDFzNFox31R3Vrsqovg9KlzyQX8Z0d24sgNtsBtxQRsfZJmXUAjGs5XrjhzicCJbZg2skMYT2+E9dY2bqSE7vyPfOzR7sYcfQiqWLe9JzRT7YQl2Pc14CGndMLdGZB54+xl0VcM5jlwjX4hd45L7DugLIvgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744536919; c=relaxed/simple;
	bh=rKIA8P8ck0NbKkzwHpkUlyV4dTbzRC4THZQ1beZsiJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iBi9Y/xwZhmNuszKR0T2/pkgfLPwYHXKiH6uuHAYkIWGsYszeplCplA+s3zt5pDKqnbePkAOsEBTq/r+U8w4XeoilhxKoBrkbfXpNnj4bC3drKHQL1LqTKZO9xIiyksbC+jnbPHFmR5NtRIkn4NpmjwWW6rPGnwG87Zja0sFlOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjpMTp86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D65C4CEEB;
	Sun, 13 Apr 2025 09:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744536917;
	bh=rKIA8P8ck0NbKkzwHpkUlyV4dTbzRC4THZQ1beZsiJw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JjpMTp86ZHIYQu1lRwubeiaMVq7TEN8jg8CHdTa/jTpmUK8dIVupjijtkum4f6w+D
	 u70LL72DUMxeBZfThe8sD4mR0hJ71o/SZhZpM3wZSVZKfiCWECNgQ09VbPu4DL582v
	 0LDXYDsGGI+LKocj2v59NJixoMSDURiuekXe76Rim8lYRo4Dh6kn/3BVhjmnJKRU4t
	 OrSLpQYmTocmu9hCkSyfoqdxAo+kwM4SCpJuORjd9CTgyF8OMQqwYS+/YMAIIXwgkk
	 SXsdB9FLYyfNtnYyVtvI4I0XpYNe6OFgVCreA+Zc3uU35LpODLE+8xnf88UEurop3b
	 RTirjsLYMD+lg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sun, 13 Apr 2025 11:34:39 +0200
Subject: [PATCH net-next v2 8/8] selftests: mptcp: use IPPROTO_MPTCP for
 getaddrinfo
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-8-0f83a4350150@kernel.org>
References: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-0-0f83a4350150@kernel.org>
In-Reply-To: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-0-0f83a4350150@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 zhenwei pi <pizhenwei@bytedance.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2775; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hAqb+9EwIsZn40xu+6ctRkc54LS4FAN8XGDT4iQnIuE=;
 b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBn+4U8jFTnHLQJUErJPnuIF0DmEVGr6jMGp2rgq
 Qlq2k3li66JAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ/uFPAAKCRD2t4JPQmmg
 cx6JEADlABxgi8dzuxPD7Qp3O9Nv7o//OXHT3ZFtF7ghCs8DSbe4p81cO9/j3gtiVYenslE8tq7
 rBsFR6RumJl1lWKAErq6eG+AbRPoAnTWDzz8jORdcHvOC6OYUrYW8hM8tij99pDq3rMdN9XJ7x5
 wvh5KfkG3P7gSFfsjkmtbB+oH0kLEqN9Vxj6fer5iB14zmM3lRzIzN/+0stctmOa7IFHzoTHmPy
 ihrM1/BibN4BtRrKEyslHnotzxbh3ZVCT3ZZSomgefJIhtiYkDgC1Nl7/FVFX6LUnsNKupWcesw
 JLJ0eFerixT3Egd27EagLRUM+NWEokEaqflim7VQvBX4BGd0tWYTsMqnu4H5YvPwt2700at/iFO
 cJVKrMMgCztCZhHx9GsZtmZCGIjOc76ucDgKJdB9WjGjXd1XajnRvtrkhk+7isf/U0UrQ/3j34K
 sr1Aybs89eZ+3Sf71FZJ3t7i1l5r/ASQs9QqK00pOO53KI/gFGJa3Vr9RtBkda6G2mjFMGd8tn2
 ppgQL/X96G/61peIsiLJ74fzRLzYKF+X4RhF4pa3b5Ovm4N9XagfUpt6aRsIGG+E4wPJ2ahOdWg
 grFRYhN5Arbck7kwwXSbAO9cDHLhblqwotcDe2t+VGp/+0Qf9R7fhshYhbupWiqsPpoIFR0Sur9
 VVfKc63DeEbg5UQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: zhenwei pi <pizhenwei@bytedance.com>

mptcp_connect.c is a startup tutorial of MPTCP programming, however
there is a lack of ai_protocol(IPPROTO_MPTCP) usage. Add comment for
getaddrinfo MPTCP support.

This patch first uses IPPROTO_MPTCP to get addrinfo, and if glibc
version is too old, it falls back to using IPPROTO_TCP.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
- a previous version has already been sent to Netdev. ChangeLog:
  - show how to use IPPROTO_MPTCP with getaddrinfo, not only a comment.
  - Link to this version:
    https://lore.kernel.org/20250407085122.1203489-1-pizhenwei@bytedance.com
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index c83a8b47bbdfa5fcf1462e2b2949b41fd32c9b14..ac1349c4b9e5404c95935eb38b08a15d774eb1d9 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -180,13 +180,26 @@ static void xgetnameinfo(const struct sockaddr *addr, socklen_t addrlen,
 }
 
 static void xgetaddrinfo(const char *node, const char *service,
-			 const struct addrinfo *hints,
+			 struct addrinfo *hints,
 			 struct addrinfo **res)
 {
+again:
 	int err = getaddrinfo(node, service, hints, res);
 
 	if (err) {
-		const char *errstr = getxinfo_strerr(err);
+		const char *errstr;
+
+		/* glibc starts to support MPTCP since v2.42.
+		 * For older versions, use IPPROTO_TCP to resolve,
+		 * and use TCP/MPTCP to create socket.
+		 * Link: https://sourceware.org/git/?p=glibc.git;a=commit;h=a8e9022e0f82
+		 */
+		if (err == EAI_SOCKTYPE) {
+			hints->ai_protocol = IPPROTO_TCP;
+			goto again;
+		}
+
+		errstr = getxinfo_strerr(err);
 
 		fprintf(stderr, "Fatal: getaddrinfo(%s:%s): %s\n",
 			node ? node : "", service ? service : "", errstr);
@@ -292,7 +305,7 @@ static int sock_listen_mptcp(const char * const listenaddr,
 {
 	int sock = -1;
 	struct addrinfo hints = {
-		.ai_protocol = IPPROTO_TCP,
+		.ai_protocol = IPPROTO_MPTCP,
 		.ai_socktype = SOCK_STREAM,
 		.ai_flags = AI_PASSIVE | AI_NUMERICHOST
 	};
@@ -356,7 +369,7 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 			      int infd, struct wstate *winfo)
 {
 	struct addrinfo hints = {
-		.ai_protocol = IPPROTO_TCP,
+		.ai_protocol = IPPROTO_MPTCP,
 		.ai_socktype = SOCK_STREAM,
 	};
 	struct addrinfo *a, *addr;

-- 
2.48.1


