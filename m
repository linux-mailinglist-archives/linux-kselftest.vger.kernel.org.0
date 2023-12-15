Return-Path: <linux-kselftest+bounces-2073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E16814C6B
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 17:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0736B22307
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537483A8C9;
	Fri, 15 Dec 2023 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2B3I0/N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9DF39FF1;
	Fri, 15 Dec 2023 16:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A12C433C8;
	Fri, 15 Dec 2023 16:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702656286;
	bh=21UpLYYm/amrRWsA6Z0Z5i27B+/zK87yVNZjHVxo7MI=;
	h=From:Subject:Date:To:Cc:From;
	b=g2B3I0/NcDq7i9hJlY6LmE9UUvybF0eTEzp/+CvjIBjOsGUvEjDjFaUt3r9psEnKC
	 skT5RdEL4vJg4BUfTGsrRdW8Nkg1+ZlVxrLZe2ytGGx/74h0p4tp5y3CLfY1Q8yRws
	 8s58HnfunGetKbdsjYCuufIHPVTf9okcplVXK9XtskxoPWkpWoPCS3pit1dqPbD/CN
	 KRU6CJ9xzFWWrChTCxbyzUDwyXGZVzvQb12vB25MqwsbQpjSBnQeNB2QJgZ1SoCt3l
	 Gg7xiojErzJbk7px+2XjSe6yDHl1datwFl9w5IXSgmcIILcJYW/A97cwOhYFTrAYG2
	 eP4tfiifqgBoA==
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH net 0/4] mptcp: misc. fixes for v6.7
Date: Fri, 15 Dec 2023 17:04:23 +0100
Message-Id: <20231215-upstream-net-20231215-mptcp-misc-fixes-v1-0-91d20266d525@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAd5fGUC/z2MQQrCQAxFr1KyNtBJKohXERclpjWLGYfJKIXSu
 xtcuHz/894Ors3U4Trs0PRjbq8SkE4DyHMuq6I9goFG4kTpjO/qvemcsWjH/5prl4rZXHCxTR2
 ZZeLLKLQwQcRq098RrRuECvfj+AJQm1PpfQAAAA==
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Benjamin Hesmans <benjamin.hesmans@tessares.net>, 
 Dmytro Shytyi <dmytro@shytyi.net>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>, 
 Geliang Tang <geliang.tang@linux.dev>, stable@vger.kernel.org, 
 syzbot+c53d4d3ddb327e80bc51@syzkaller.appspotmail.com
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1482; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=21UpLYYm/amrRWsA6Z0Z5i27B+/zK87yVNZjHVxo7MI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlfHkadq64+Jj4+lw1xgSumvoytJWthMiPdayoY
 mEerJZN/UmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZXx5GgAKCRD2t4JPQmmg
 c0uJEACf528mDj3ot7R2by6zX9YL7bC37nr3ZzTlXbgvCHkfHlDBlyFKeR2fJp67mlTRYAgnC7G
 tt5gzeyAPE077Zg80RYgdVU26MXDxb8wQud+dtSvkNt0b8w7bITvsS7RTY9rGeURNdTMETdY2T/
 s/dp0h29TulF1M8sgz3/WRJOo/gAPZrVutY2rc9CZUpuX364Tl2FDjI9F3qPj9QOfhjenF7ClJu
 h7GFi0fyGLJeeXhDtPIozh5kZ1hyN12Y+yF0GzeJCA4y3EF4Mzk/1z+UeqcOlXIUG2hlEBRcSha
 jz2RhTkU9hBg7C1eqPRHmaLdHjDyGzxPvKBRcVxxAqFoyXDJuEVlC9ICpXj8RR4BSDeOaJILG1N
 xVEQ3nIZ/HRwcJHUX18MKQ0yezQMACg/Re0yAvi5lgwhOIV8m6dVeWkw7FmerEE7iVA3vhIF/Ro
 dQeEvSf6AbkvuTkc9EczKajr1jKRWMxPprKC7yaAffCbh0RyKmyG2cwq5SVMcUwCFrpoOaBfmxV
 di5ToPnvmchhhqlku2euggC9aL58He+3Ywuhvvlyn06PNPC3kqfuFCSV5wKWZxwgc6H8IcAhBx8
 JZbCg5Lp6AMyfEpY8GikzN3tt6J+TcnSEQyFKMrp0kFWs043XE9OXphr5OVI+2IDxuEsCDIpNcR
 ZVv9j79Ip8WK91Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are a few fixes related to MPTCP:

Patch 1 avoids skipping some subtests of the MPTCP Join selftest by
mistake when using older versions of GCC. This fixes a patch introduced
in v6.4, backported up to v6.1.

Patch 2 fixes an inconsistent state when using MPTCP + FastOpen. A fix
for v6.2.

Patch 3 adds a description for MPTCP Kunit test modules to avoid a
warning.

Patch 4 adds an entry to the mailmap file for Geliang's email addresses.

Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
Geliang Tang (2):
      selftests: mptcp: join: fix subflow_send_ack lookup
      mailmap: add entries for Geliang Tang

Matthieu Baerts (1):
      mptcp: fill in missing MODULE_DESCRIPTION()

Paolo Abeni (1):
      mptcp: fix inconsistent state on fastopen race

 .mailmap                                        |  4 ++++
 net/mptcp/crypto_test.c                         |  1 +
 net/mptcp/protocol.c                            |  6 +++---
 net/mptcp/protocol.h                            |  9 +++++---
 net/mptcp/subflow.c                             | 28 +++++++++++++++----------
 net/mptcp/token_test.c                          |  1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  8 +++----
 7 files changed, 36 insertions(+), 21 deletions(-)
---
base-commit: 64b8bc7d5f1434c636a40bdcfcd42b278d1714be
change-id: 20231215-upstream-net-20231215-mptcp-misc-fixes-33c4380c2f32

Best regards,
-- 
Matthieu Baerts <matttbe@kernel.org>


