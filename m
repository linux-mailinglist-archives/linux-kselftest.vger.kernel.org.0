Return-Path: <linux-kselftest+bounces-11414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C96900A6C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 18:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E01EB2611A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 16:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C4A19ADB9;
	Fri,  7 Jun 2024 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8LJpdch"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3310D134B2;
	Fri,  7 Jun 2024 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777875; cv=none; b=iQiyrJ+PABt5dxEWVInA4dBhCjitzw2j1/L1ZCpF8gHXqldW1g5274fW+YQMsAAzaQ21jbKtWrDIB2AWZnKgTHjt/Ib+RI9GNKPVSCmTsCnGl0eaHptf7k1RAWKob4a6xmoWKmOYN0LupkN8lOyfokUuEYFaMZtUMhWWYzfttl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777875; c=relaxed/simple;
	bh=jhLtBrMAo8ryDnhWQTtDLfSSE4LNiPRN3afuSKN4v8Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YAFH9N3SkjM9RbGz3Q0A9wptXjHmpVkMSOCYJDRIZdxMe6nU3q038gwY/RXQ64K9dwx255PsvTvCRKTMnEekmLI/UfbIxaCq3YIQDyB03Km1hawFZ6nIBbTaUoGNwKj7UE3TsVyQzBbd6+VL0PGMXRl7Za6d252UU1JcrbTOrBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8LJpdch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDC1C2BBFC;
	Fri,  7 Jun 2024 16:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717777874;
	bh=jhLtBrMAo8ryDnhWQTtDLfSSE4LNiPRN3afuSKN4v8Q=;
	h=From:Subject:Date:To:Cc:From;
	b=R8LJpdchzAmPkZB3CQqsWbRchh4lBgCpjcc/u5EtLHj7wDjm+cSEYIIUysptV7xKc
	 +lql0j496256hrtgYFdnnBX5qq91mn8vg2fb1aHJcjUb3tGrA9NE9ffdxlCLnxMiyX
	 Ck9mlHo/H4I1lOs4PKXq+BwA2ZTgciY2Ye22e5tRkWI8ldkd9B7zm8iqj+3JwoKkuD
	 X4L3xWhA6CIzDp+0Dfm2kQA7ZuZZQcm5q1hH0M5w0RY6KyjOFbrdyul3JGA2pSBIDe
	 t/24waOtkijFzszzL2lmoHwjV7bv921rdKAZ5t4e7oiqCkUjo3L6j9fL+bT7jqHXGA
	 0ZNgLbOrKxcOQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/6] selftests: mptcp: use net/lib.sh to manage
 netns
Date: Fri, 07 Jun 2024 18:31:01 +0200
Message-Id: <20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-v1-0-e36986faac94@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMU1Y2YC/z2NwQrCMBBEf6Xs2YU0rRX8FfEQ41QX2hiyqxRK/
 91Q0MMcHjO8WUlRBErnZqWCj6i8UoX20FB8hvQAy70yeed7N7gTv7NaQZg5wWoW43+lmEaDmvK
 cLeZ9McmNu+GIvoNHGwNVcS4YZdlPL/TT0HXbvqkbt9+OAAAA
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1664; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jhLtBrMAo8ryDnhWQTtDLfSSE4LNiPRN3afuSKN4v8Q=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmYzXPzkHF/dP9UOJPwz+3WRICf4XmqHzCwJCMy
 ZGrKGQ0BxGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZmM1zwAKCRD2t4JPQmmg
 cw0vEADdwBa+vFOXcyCHnBWs8kybF7ImH9DJbc0enEgjonqQYfehgbizvU3ENFoJQlfqT7cC60A
 h/EHNbo9BkOdyh8ZfaISU25EJqTe9dbVDA+f1lOYnqxQMWEtkIEnhGV5A9pV32fVgBLtuG8Q7iF
 Huyz4W9yWD5a1c5xGz1fiz753EXts/qRuwJLbf2JPDHCP7zCHJoRNnDBotPjf0c3kRn9PkFK3bV
 YmM7MmxLBvl0J1Ho/SR5S0+D8ocQiWPdx7Lt7S3w8uyA55YxrPf+SDCpwoIF4/9N2vyRHOe+2x9
 S/yGZSkzJ60KtdCFJ55Anvf95U1SK9pjKZtLYPLyNmbEqiKnrLjpY7dofk/VqwKwF1gYhdthk4r
 A3e/fekh+j2ChXRcKKYgGbfjsTS0A0/lBRj9jpTnnQ7XIUlwBl2PWZN2NuraQihI5xrgpUrpAOe
 AiLSvugJMicSEQscVU8RPQ/YwVWiB5hONvuoyiy+M/zEgaaA+8yf3TM/o4N/1VEt8ZOT2auZd/i
 3qmLl1dINopja5k9dp5FEaVjPDGHCx+3zU6ynNnTPhRcPeAPSYji+/Qvstr4/msfPG9hQ6eudlq
 um6qKw9RroBp04SbGptkHP3QpzMOtR5Ahm6hubzGl/R0dQ4nZZMLO90tMC46NEE+2nFJZWkCum1
 HwlEb88ashD45MQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The goal of this series is to use helpers from net/lib.sh with MPTCP
selftests.

- Patches 1 to 4 are some clean-ups and preparation in net/lib.sh:

  - Patch 1 simplifies the code handling errexit by ignoring possible
    errors instead of disabling errexit temporary.

  - Patch 2 removes the netns from the list after having cleaned it, not
    to try to clean it twice.

  - Patch 3 removes the 'readonly' attribute for the netns variable, to
    allow using the same name in local variables.

  - Patch 4 removes the local 'ns' var, not to conflict with the global
    one it needs to setup.

- Patch 5 uses helpers from net/lib.sh to create and delete netns in
  MPTCP selftests.

- Patch 6 uses wait_local_port_listen helper from net/net_helper.sh.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (3):
      selftests: net: lib: remove 'ns' var in setup_ns
      selftests: mptcp: lib: use setup/cleanup_ns helpers
      selftests: mptcp: lib: use wait_local_port_listen helper

Matthieu Baerts (NGI0) (3):
      selftests: net: lib: ignore possible errors
      selftests: net: lib: remove ns from list after clean-up
      selftests: net: lib: do not set ns var as readonly

 tools/testing/selftests/net/lib.sh             | 55 +++++++++++++++-----------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 33 +++++-----------
 2 files changed, 42 insertions(+), 46 deletions(-)
---
base-commit: a999973236543f0b8f6daeaa7ecba7488c3a593b
change-id: 20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-365e43e2e1ca

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


