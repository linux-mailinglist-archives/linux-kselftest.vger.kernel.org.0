Return-Path: <linux-kselftest+bounces-54-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BAC7EA6C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 00:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C16A280F0C
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Nov 2023 23:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EA63D3A0;
	Mon, 13 Nov 2023 23:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzUHl78q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBF320B28;
	Mon, 13 Nov 2023 23:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9948FC433C8;
	Mon, 13 Nov 2023 23:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699917406;
	bh=B3CDSKAh5EeyTf0TZ3ge4LVPSyWJ3s03LlETBXgm6LU=;
	h=From:Subject:Date:To:Cc:From;
	b=FzUHl78qx9c3bb7dlwp6spsLyZViukUly7NLW8cVvNb/q30K0AYT5JdC+ST6qTKeg
	 mwOzO+gLjV94eVzafQV8J0K3uVdfWuq9B5R1NoC6ciov+sFa7iZC0ejodsx6y03k7W
	 LPGo09AWkKx1H2dT2GFxb+r9b+gUGIvFfwOVlvtTLQLYiDjYLmn/vpKJlDn+kVyvCL
	 1MoNe/8EgYWUutTuiqxFHJKHO9wDPuGXO4yis7VrKiabxZrjO8ZeLZSMTX6tQfPgoX
	 l5VYMzilxuAHLVjhl94ltiPzq4kz4twtn5FUyuBdZFxTbb9qKyrbEsCey+oslbu5Ab
	 1W7CTVi1Z2agw==
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH net 0/5] mptcp: misc. fixes for v6.7
Date: Tue, 14 Nov 2023 00:16:12 +0100
Message-Id: <20231114-upstream-net-20231113-mptcp-misc-fixes-6-7-rc2-v1-0-7b9cd6a7b7f4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADyuUmUC/z3MQQoCMQyF4asMWRtoWhzBq4iL2qaaRWtpqgjD3
 N3gwuX/eHwbKA9hhfOyweC3qDybBR0WSI/Y7oySrcE7H4go4KvrHBwrNp74X2ufqWMVTVjkw4o
 rnnAkj5mOuazu5mIoYGgf/DuYeQEj4LrvX8PMRfyFAAAA
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexander Duyck <alexanderduyck@fb.com>, 
 Geliang Tang <geliang.tang@suse.com>, 
 Poorva Sonparote <psonparo@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>, 
 Christoph Paasch <cpaasch@apple.com>, stable@vger.kernel.org, 
 syzbot+9dfbaedb6e6baca57a32@syzkaller.appspotmail.com, 
 Xiumei Mu <xmu@redhat.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=B3CDSKAh5EeyTf0TZ3ge4LVPSyWJ3s03LlETBXgm6LU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlUq5ZU08Ykzt8hJW2cUGoPBfTmSwG5QDo+IPSz
 5UPDpNInrOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZVKuWQAKCRD2t4JPQmmg
 c6ePEADI2lHA6ITonWXfosREfVsFyqN4PzF7vVcKLB+XveJGG0+N4ynir0BbWZsxnsUB4aLVek/
 BQXZFOrhoqX0lLHLiRbM66fH0jNJ6p0wWnDy2kUi+NsL09H0ouKmkXe1eeD4Z4oAeRz4RfiRPV5
 BckD7EWXVTk4WTha9yibaSOOeJ+Ord6nozEn+fdoNfotGiG+G9tN1nc0M/B0a+V9rliNSuDvsj1
 DwMBAvUxjdb+4XywzzM4bPG1RE53fd4gqSAxNsevx9SDfwmumcH3zwWP0N3lmmvuv57FYVeEKwe
 8jLhH7NNc+CgyK4l8QYwZuI6mzHOSzql949h6vFZ2ar2Um5Mkaz3atGDMrWQyAxRdOpau9ltD9I
 cTSOLdiobYniWe2MqKOVQssVZxXVcwMNokrSp3sDE1ie/ZT4ryYtILjpjpqDP/r30F+hicUhRbv
 20jJ7Zct12aISuXRbgFPC07CxrENlV2156BItsw2hxREh/53WaF5v7OUAazXvb1FcTOyWLx+RSl
 mEBO6UaeWbsDBDMRhMCs6fbnUiYZG201ajrQLO/vgDa6o2nUF8xfCpAhT2vI6FGkz1b9bMJASWK
 RHBhNesM9FiBqMi2rZXDDDIatT2NmPOUJiQvxs6VFJcEu/cRa/N5OsoUBv+CJQ8wOLfnV8eKgPu
 5KDuEYzM7THv0aA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are a few fixes related to MPTCP:

- Patch 1 limits GSO max size to ~64K when MPTCP is being used due to a
  spec limit. 'gso_max_size' can exceed the max value supported by MPTCP
  since v5.19.

- Patch 2 fixes a possible NULL pointer dereference on close that can
  happen since v6.7-rc1.

- Patch 3 avoids sending a RM_ADDR when the corresponding address is no
  longer tracked locally. A regression for a fix backported to v5.19.

- Patch 4 adds a missing lock when changing the IP TOS with setsockopt().
  A fix for v5.17.

- Patch 5 fixes an expectation when running MPTCP Join selftest with the
  checksum option (-C). An issue present since v6.1.

Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
Geliang Tang (1):
      mptcp: add validity check for sending RM_ADDR

Paolo Abeni (4):
      mptcp: deal with large GSO size
      mptcp: fix possible NULL pointer dereference on close
      mptcp: fix setsockopt(IP_TOS) subflow locking
      selftests: mptcp: fix fastclose with csum failure

 net/mptcp/pm_netlink.c                          |  5 +++--
 net/mptcp/protocol.c                            | 11 ++++++++---
 net/mptcp/sockopt.c                             |  3 +++
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  2 +-
 4 files changed, 15 insertions(+), 6 deletions(-)
---
base-commit: 2bd5b559a1f391f05927bbb0b31381fa71c61e26
change-id: 20231113-upstream-net-20231113-mptcp-misc-fixes-6-7-rc2-d15df60b0a3f

Best regards,
-- 
Matthieu Baerts <matttbe@kernel.org>


