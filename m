Return-Path: <linux-kselftest+bounces-30005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F22A785F2
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 03:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055ED16DA06
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 01:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6776B67F;
	Wed,  2 Apr 2025 01:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZU8QSn5D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7688F8837;
	Wed,  2 Apr 2025 01:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743555612; cv=none; b=s+s4WNOuLh9LzU5McgKUpP7A7kZJWiDICH1pB4y3rg99pUaAUhK0Gp+h8JjDpV51MzBqGULZiQtkmZSE4yHJBtJmIrUN5I95X2q5M76XgHG97Kvhf5MRuZ0D0KcDrGwCA7klKvOjjylcfzFVAXIydVTJlkl6ogi83BbUBR27i40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743555612; c=relaxed/simple;
	bh=/ACN9qX6EOkrFeO0FdXlvcbraUtdbf8Oecbf6xTmBUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KonBvE/RstdRsAcQmJQdmORL2evKjnS3A7b7Cob7G9hxUxoIMo/4uGlTZjvabFPwN6owh6QgUrBPFQ5WLzLbZ1VqsxR+0+6wBmeygF2mRyvxTqU7gSj00aeI1vvnNrK4pCABWRC1HvT28v/yLnSeT83cXCB40/vp6baM1g/ONjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZU8QSn5D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C44A4C4CEE4;
	Wed,  2 Apr 2025 01:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743555611;
	bh=/ACN9qX6EOkrFeO0FdXlvcbraUtdbf8Oecbf6xTmBUc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ZU8QSn5DbNG2E0S85Y2UCrLS1bRLLU2RSpMbDLuiDhm4MIiKn95CFWGQuzgKJJa6z
	 r5EXDT2B5otmGCd+lGyoXkW/5X3sGLNeCR1+sfGgENESbngWN3bqejq+k54p+ZxHFZ
	 ZUxtgv6kztuCAiZd+Mmr4geXm7kWgqC+PL0Sbfs3szxcXs0Tar/SY0AtpYmvOPBrIa
	 0hikOoklT5bVc9Q3QMA9Kam/tlu3SrMiHyGeGt98DvjCgjP3z/3T2x3QznGXSk2XJg
	 2jiGH/ZJvAAofAfjU8re5i1d7WmzTUMmD17i8uIklsbTLr0n0c7IGNImnilJS+RUOT
	 PaPIZoBHoeh+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A57C36010;
	Wed,  2 Apr 2025 01:00:11 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 02 Apr 2025 01:59:31 +0100
Subject: [PATCH net-next] net/selftests: Add loopback link local route for
 self-connect
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-tcp-ao-selfconnect-flake-v1-1-8388d629ef3d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPKL7GcC/zWMywrCQAwAf6XkbDCuL/BXxEM2Zm2wpmV3kULpv
 7sKHodhZoGi2bTApVsg69uKjd5gt+lAevaHot0bQ6BwpAMFrDIhj1h0SDK6q1RMAz8VlZij0F7
 ofIKWT1mTzb/1FVwrus4Vbs1ELooxs0v/Xf/d9sXmsK4fxrqPW5QAAAA=
X-Change-ID: 20250402-tcp-ao-selfconnect-flake-e0aabc03c076
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743555610; l=2603;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=VxuHQuF+lHn7Z66dGwiCR30NCU5Nd0bRf7ml37EyIQ0=;
 b=3aqwhOYRQXABmt30DhIo05TJTESR3xflbbuTR3dBAmI3yMdgAoZyxUVPrqaM+Ncc8k/aXIzyA
 mxoO5rvkEHQC0Jz5Odvs0oX666np6SxSESKORHPedn8ROHccfn/nftx
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

self-connect-ipv6 got slightly flaky on netdev:
> # timeout set to 120
> # selftests: net/tcp_ao: self-connect_ipv6
> # 1..5
> # # 708[lib/setup.c:250] rand seed 1742872572
> # TAP version 13
> # # 708[lib/proc.c:213]    Snmp6            Ip6OutNoRoutes: 0 => 1
> # not ok 1 # error 708[self-connect.c:70] failed to connect()
> # ok 2 No unexpected trace events during the test run
> # # Planned tests != run tests (5 != 2)
> # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:1
> ok 1 selftests: net/tcp_ao: self-connect_ipv6

I can not reproduce it on my machines, but judging by "Ip6OutNoRoutes"
there is no route to the local_addr (::1).

Looking at the kernel code, I see that kernel does add link-local
address automatically in init_loopback(), but that is called from
ipv6 notifier block. So, in turn the userspace that brought up
the loopback interface may see rtnetlink ACK earlier than
addrconf_notify() does it's job (at least, on a slow VM such as netdev).
Probably, for ipv4 it's the same, judging by inetdev_event().

The fix is quite simple: set the link-local route straight after
bringing the loopback interface. That will make it synchronous.

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
Sorry to send this during the merge window, it's a test stability fix.
It seems that netdev build bot has hit the issue a couple of times, but
seems not hitting it constantly at this moment:

https://netdev.bots.linux.dev/flakes.html?br-cnt=150&tn-needle=tcp-ao

I'm marking it net-next, so that build bot carries it until the merge
closes. If it's not fine, I can re-send it after the merge window.
---
 tools/testing/selftests/net/tcp_ao/self-connect.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/tcp_ao/self-connect.c b/tools/testing/selftests/net/tcp_ao/self-connect.c
index 73b2f2276f3f5410aaa74bede7f366f81761bd6e..2c73bea698a677f9aedd7bec28f6e7fee7845d2e 100644
--- a/tools/testing/selftests/net/tcp_ao/self-connect.c
+++ b/tools/testing/selftests/net/tcp_ao/self-connect.c
@@ -16,6 +16,9 @@ static void __setup_lo_intf(const char *lo_intf,
 
 	if (link_set_up(lo_intf))
 		test_error("Failed to bring %s up", lo_intf);
+
+	if (ip_route_add(lo_intf, TEST_FAMILY, local_addr, local_addr))
+		test_error("Failed to add a local route %s", lo_intf);
 }
 
 static void setup_lo_intf(const char *lo_intf)

---
base-commit: 1a9239bb4253f9076b5b4b2a1a4e8d7defd77a95
change-id: 20250402-tcp-ao-selfconnect-flake-e0aabc03c076

Best regards,
-- 
Dmitry Safonov <0x7f454c46@gmail.com>



