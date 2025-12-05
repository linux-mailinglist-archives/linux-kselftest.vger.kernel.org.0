Return-Path: <linux-kselftest+bounces-47201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3BBCA8F96
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 20:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 200FB3029A16
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 19:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2376393DCA;
	Fri,  5 Dec 2025 18:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXCDpVrA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815FC393DC3;
	Fri,  5 Dec 2025 18:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764960933; cv=none; b=HOpJnSwa4T4OrR+OW/c4y+gU45mYOI8sdi8sJGpaJGo+sKOpOtxApRiTu8dzHrTaSgNCNMy/uYfcYt8uGZXBtan7psq3AE4d46HlxgXz2Kt+3nbghGM7Fy16DwxauEdsbzMQVzYkjlcZ0NwQUix+J9ALLObl0xYrcOzpj3PUTMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764960933; c=relaxed/simple;
	bh=DYcgUyRPCbhHVUeeLI22n/mljYVmmFnZoPtgjphW1Bs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dIYlnqWDZ7Z7CaojfCy6uhff1O5gf6YGKkp6QaOpSMgKgjPqKGBlxFMn+7Qz3Sp3rhUsPZfnZ0ix9TtUze3bPohWju4Tvaezc7qDIc4gbhe+pZoSBF8qV06+dzy4wB3DyHsMP3sPzqcBkSaSgEmj34XBoxpxJJgmmq805BgBl0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXCDpVrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731F8C116B1;
	Fri,  5 Dec 2025 18:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764960933;
	bh=DYcgUyRPCbhHVUeeLI22n/mljYVmmFnZoPtgjphW1Bs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uXCDpVrAt5NtmcjwQh1FVMt+l7vt22Mkq5JU7Oc3pufEJvM/Wcw62dyS1QqHi27cn
	 NqYEeemURKKC+knz6qGST+EEtcUr3AF4Qyyv8dQ6B34v52VXOIuOB1tWL/9Xh4g3JD
	 I1XBkCpovGZdVNCwl+N/d6kSTCK+AcrxcuuH3JUHguYLmbeG3dRRFYJpzgl/RHJvZS
	 bGJWRWmB6YVV5u3DZls55iPLPlf6lzNfj//drheEcWFJ8V53yQmCCxuw1mxVAa+uLI
	 +RTv2O/7L0iJOJ+noUkQiNS8VqVXKp18RTTfyb7SMBr9hLhx15oRiW5Mvu+e+x0lH+
	 IEppz/NW7RnXw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Dec 2025 19:55:14 +0100
Subject: [PATCH net 1/4] mptcp: pm: ignore unknown endpoint flags
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-net-mptcp-misc-fixes-6-19-rc1-v1-1-9e4781a6c1b8@kernel.org>
References: <20251205-net-mptcp-misc-fixes-6-19-rc1-v1-0-9e4781a6c1b8@kernel.org>
In-Reply-To: <20251205-net-mptcp-misc-fixes-6-19-rc1-v1-0-9e4781a6c1b8@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Dmytro Shytyi <dmytro@shytyi.net>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2373; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DYcgUyRPCbhHVUeeLI22n/mljYVmmFnZoPtgjphW1Bs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKNtWadbZi2p0l1894fT6rNRDhuiAjN/ucYepk9cfO8a
 9t9O680dpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExEhJ+RodvhxHwLgW7PWYcv
 XpY3YDJ3qxOcXHzxYf6ZCWftFXcz5DEy/PFdkzZbZHt5m6RfhW+y4i6BW9Jmny7UTtn7XKPc07e
 IHQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before this patch, the kernel was saving any flags set by the userspace,
even unknown ones. This doesn't cause critical issues because the kernel
is only looking at specific ones. But on the other hand, endpoints dumps
could tell the userspace some recent flags seem to be supported on older
kernel versions.

Instead, ignore all unknown flags when parsing them. By doing that, the
userspace can continue to set unsupported flags, but it has a way to
verify what is supported by the kernel.

Note that it sounds better to continue accepting unsupported flags not
to change the behaviour, but also that eases things on the userspace
side by adding "optional" endpoint types only supported by newer kernel
versions without having to deal with the different kernel versions.

A note for the backports: there will be conflicts in mptcp.h on older
versions not having the mentioned flags, the new line should still be
added last, and the '5' needs to be adapted to have the same value as
the last entry.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/uapi/linux/mptcp.h | 1 +
 net/mptcp/pm_netlink.c     | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 04eea6d1d0a9..72a5d030154e 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -40,6 +40,7 @@
 #define MPTCP_PM_ADDR_FLAG_FULLMESH		_BITUL(3)
 #define MPTCP_PM_ADDR_FLAG_IMPLICIT		_BITUL(4)
 #define MPTCP_PM_ADDR_FLAG_LAMINAR		_BITUL(5)
+#define MPTCP_PM_ADDR_FLAGS_MASK		GENMASK(5, 0)
 
 struct mptcp_info {
 	__u8	mptcpi_subflows;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d5b383870f79..7aa42de9c47b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -119,7 +119,8 @@ int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
 	}
 
 	if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
-		entry->flags = nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
+		entry->flags = nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]) &
+			       MPTCP_PM_ADDR_FLAGS_MASK;
 
 	if (tb[MPTCP_PM_ADDR_ATTR_PORT])
 		entry->addr.port = htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]));

-- 
2.51.0


