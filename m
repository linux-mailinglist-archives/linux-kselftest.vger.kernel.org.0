Return-Path: <linux-kselftest+bounces-6543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0FD88AB26
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88CE41C2ED82
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 17:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE391272C5;
	Mon, 25 Mar 2024 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b35y4F8l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881AF126F25;
	Mon, 25 Mar 2024 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382174; cv=none; b=vDkV3TcqzqOaaA48IBFdUrHkldbKrd6zp4zBoSHfd7DL56FtqPi59/gfN6LsY3kkge94eIEg+YHgS2jC4Po2AM67TG2ATlVZy6oyr2CHEAFS1zLLWsQ9K7CF5DEfHrACvROhsFJf1+tNAnbZQuRwk1hD9jT2aLE0kSmSkhT0dRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382174; c=relaxed/simple;
	bh=9DZxNa0tZYW0WZcFZ98bUReG52X4+qyjAVdts/vjFSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ul5+F+6EVeCF/zjQ6Jgn483thjWO6LLBI3VCnZvaOy1nRw++rS5viB//hIkb2xvboSbYbakNb/kjnAW2LxXLNxgmMZJGUU4tdRs2ZAy24xKZgYJ6xdLxC5JIk/mAJ4zZg9ZZCWjAa0CVGElMZ0Tyd8OpDEUa/MvIhbU5bxOSLZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b35y4F8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8207C433F1;
	Mon, 25 Mar 2024 15:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711382174;
	bh=9DZxNa0tZYW0WZcFZ98bUReG52X4+qyjAVdts/vjFSE=;
	h=From:To:Cc:Subject:Date:From;
	b=b35y4F8lCsdqQeS5z97atf8AYtglRqcp5iJz1J5AIJdQcGCKgoZSKWG2yEPmr8Yx1
	 +MDWebi/8jcafQ83fsAZ4yiu2c8w26Vpge9/DqNZ/ni4dwpBHDiP/3DnaCyiEDwOy4
	 MfkK/qyEKdJHc0gnCaICwdvFpcCCNIoSNBamVTGsXZBpYYjEvJBU33wkOC7I7Du1J5
	 lCXv0xm9XnuxBbaaejpNZA4B17J1V7rBB9W7i26rMHe+V8fJdBdEQ2Z0Zohv/Mppe3
	 QJw6MqWSMpigkGkxd/OGgVcqPO+Lm29BdUBlJk4e1nHcGt5H4jtinz4Fzs09dKXjSL
	 lw+EpUVB4oJpQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	dw@davidwei.uk,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: netdevsim: set test timeout to 10 minutes
Date: Mon, 25 Mar 2024 08:56:11 -0700
Message-ID: <20240325155612.2272174-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The longest running netdevsim test, nexthop.sh, currently takes
5 min to finish. Around 260s to be exact, and 310s on a debug kernel.
The default timeout in selftest is 45sec, so we need an explicit
config. Give ourselves some headroom and use 10min.

Commit under Fixes isn't really to "blame" but prior to that
netdevsim tests weren't integrated with kselftest infra
so blaming the tests themselves doesn't seem right, either.

Fixes: 8ff25dac88f6 ("netdevsim: add Makefile for selftests")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: dw@davidwei.uk
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/netdevsim/settings | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/settings

diff --git a/tools/testing/selftests/drivers/net/netdevsim/settings b/tools/testing/selftests/drivers/net/netdevsim/settings
new file mode 100644
index 000000000000..a62d2fa1275c
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/settings
@@ -0,0 +1 @@
+timeout=600
-- 
2.44.0


