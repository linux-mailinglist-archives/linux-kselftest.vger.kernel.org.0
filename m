Return-Path: <linux-kselftest+bounces-28896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D93C4A5F091
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C06B17D7A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 10:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD691266564;
	Thu, 13 Mar 2025 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6R7NmsL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1736264F90;
	Thu, 13 Mar 2025 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861327; cv=none; b=liqH3hg/gPpu+Nmw+j4pBG9SFub/n/04xi3LuVHVROijKVUI+UHNVlA8K5r1lJeDkCX/4P2wktKax410rkZbUNoS6N3O7329Nll/nPDoY6rkdb8+gDatkojo+HxLMIhQdKiV/QS4bjoEPvNOy09KUX71dmYolLSqbPrdsUfHE/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861327; c=relaxed/simple;
	bh=gnvAK2DVqKk1vkd3h90UM+nAc7VvLnrzZwaOJQEjsak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cL+kG4aXYczJ7v4EGYQeoDxOKsBgHgrEN12FyzxbScfouDr0KGAgtvQuhJ1AoqncmJgGb57s8vVoJHUhajRZF+e/4yC0KzJDlnNwOWpIMYIoEUtGaOAzeuNNq7TjZ2FQ/8kbpKdnwPpsVygwcDFW6DYCxpp7E+Wd5peDL751cgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6R7NmsL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A1EC4CEDD;
	Thu, 13 Mar 2025 10:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741861327;
	bh=gnvAK2DVqKk1vkd3h90UM+nAc7VvLnrzZwaOJQEjsak=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X6R7NmsL33fxtO/HsS8hr/GPx5Xz2c8rdmJoWTei2zQ3mq8PCLAR6Vn4lQhsBb1x1
	 Oke1z1fIa4Qr1ZhP6IbuL4CRj/PlMs2JP7zEjq7sFeHhKJWPG1vERorYv6gQpjVt6X
	 H6BpQO5GoOpr82joZSecaoQigfM8ST9CWUoezryQXTvtQRmXhND5HFUjK5Gy/PDhE4
	 jN9iAvegs7A95yu4/PSgTfhHG96gfF6BRRFalPl+AcXX+xxcl7m9dKwz3/1hye9lVg
	 QfDp2ybzjy9mAbX8jns9JTF9hy8wTEHfeikb2JtXhKRSBNMEDAJzP1TwMJHD3BXSvs
	 6yNQWUlgi4s7g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 13 Mar 2025 11:20:53 +0100
Subject: [PATCH net-next 04/12] mptcp: pm: only fill id_avail_bitmap for
 in-kernel pm
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-net-next-mptcp-pm-ops-intro-v1-4-f4e4a88efc50@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1355; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=pOKZPF4QJCBz4k7O7CQx5Pu5iovYe1r/0fZytYNL+58=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn0rGaYaqtFzbgJXXm7XHO4mV3RMVL8bWv60E0S
 pjcg6KlfP+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ9KxmgAKCRD2t4JPQmmg
 c4MaD/9AtiDNEEeGKWrQKS+a8YSlA3NEU0+Qq6nbeSercFNBgRX1PJaQLR7UZcLw0yW2r9xakV0
 rA3SBdE0NzSUzpL1J9dwgT+ny8TGH8LKt4wLSwC7vXV30enX0mkHHypluFDf6i3dkmF8bWKifug
 B0RYsxDVRRbyDYA6zIeJttwYN5ptBUAShxX33zjSmTxAQV/NTcWKjLnbvOUBh+T+Q+ZAdGMI1mg
 79+vM0QaKUnguwW3xPcH25cPX6BV/5/eMxOod/4fj9e4cwBzbSLYsljcLr2VnyeEA9sMHq5IZNI
 V2GjptHUURlqHP8ej8HDnj+gEoVngL9hWqyXpjsJ6dCnc0t+dj9s6EGmqeIA0mfjfyxk1WnCYdl
 ZLpVN8fn+cpGXyZB5cR2ZZeWhXafFoVaIuFL1ntO23QwD0KMs3Wc+fPz1Wz9sg5SURJqbNu+vl2
 ri0W1p5liSg6sYzwsusNQcL5XC3mSVOyIoicnEvOqnacoXw5SVQrfl8dZoju+G4WsxFtEdYXQpN
 QzrehBTI30+MZO7FaLtd+9JOTOCn+U2tW3029Tmi0jn+cSaJLbhaURkH5rZGxjw00zDLYtl0TEB
 WU9LobaDNtTziCygtav+UTD1FCoVjRYHmcuHdjrN4iPLldbsJa5foHPwN/h417SRgT/KcPtGJBD
 EjCs1KfNsSLHThA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

id_avail_bitmap of struct mptcp_pm_data is currently only used by the
in-kernel PM, so this patch moves its initialization operation under
the "if (pm_type == MPTCP_PM_TYPE_KERNEL)" condition.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 04a156395aaddf50e67d10479086591a37063fa3..af009661477b1743b11221c0d59b53cd89e6e791 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1000,6 +1000,8 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 			   !!mptcp_pm_get_add_addr_accept_max(msk) &&
 			   subflows_allowed);
 		WRITE_ONCE(pm->accept_subflow, subflows_allowed);
+
+		bitmap_fill(pm->id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	} else {
 		WRITE_ONCE(pm->work_pending, 0);
 		WRITE_ONCE(pm->accept_addr, 0);
@@ -1009,7 +1011,6 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	WRITE_ONCE(pm->addr_signal, 0);
 	WRITE_ONCE(pm->remote_deny_join_id0, false);
 	pm->status = 0;
-	bitmap_fill(pm->id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 }
 
 void mptcp_pm_data_init(struct mptcp_sock *msk)

-- 
2.48.1


