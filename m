Return-Path: <linux-kselftest+bounces-8818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CAA8B15EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 00:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D2E282D91
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 22:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF8F15FCF9;
	Wed, 24 Apr 2024 22:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7fe+5HV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566C51DDF6;
	Wed, 24 Apr 2024 22:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713996891; cv=none; b=rkbUnKvcl231oFCyB7812adegpWyU/fHsoe7yz4U++oyFDwB1/QKR9K0llm/166wy8dhp8sBAfRtzl/zdA3NeJGH9RN+D0HgVEwdTXkUUmXd2BBBgtvZxmnFMB3OKi5XtwIF5UMjhySNzqCTAfQGmmivWIig7UJEztss7kjq7Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713996891; c=relaxed/simple;
	bh=PmLt5pELqT64qaRUZH0Q1tQDrQwMBJ0ULHkVMwn7Ul8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dtnsVWSds6+qfES54Va9SWmIKEzTIPcVIBN35APJQA9TDQdac1IA/I0114F7cvYZp+dVk2DbOUgv4jtXmCKEuXvLngmR6RIwnExli4+bVNIXRzTW0mGlqkJFoX9QkKruvcbkl7d/Mktrg3gBz+26+0waQPClWj5+wZkLbsDzSYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7fe+5HV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A016DC113CD;
	Wed, 24 Apr 2024 22:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713996890;
	bh=PmLt5pELqT64qaRUZH0Q1tQDrQwMBJ0ULHkVMwn7Ul8=;
	h=From:To:Cc:Subject:Date:From;
	b=N7fe+5HVDwoZtpkH07iwn+1SS20zVjC8rma/JdcsLFf1MmXLQ+fss28FlOJmFrihX
	 uutAWbwVEULCuyUrK/kRTwfE7lnAijtVyiKshFmbqmWOFy7vy96B8cOTkFNZmdURjw
	 mB6Fzlqd3ZxOVYWUkInp5F3pFTopKzd97ekTh9LB5tBZ1ei6FGKXyWWlElRI3hcW4b
	 gqxfN4iguHkx1OOTPvkz2FFIcHbt9xBNLIk1Sr/Ft9sonwPPKNrJmDud89p6TLMc/p
	 ORWYZjCDN62fyY0ZaPRqmTNKN4+sifz9E8YSKz8w4cXtG8P53awvIVZDhFI798TKh+
	 jwoG6G4I/QCYw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/4] selftests: drv-net: round some sharp edges
Date: Wed, 24 Apr 2024 15:14:40 -0700
Message-ID: <20240424221444.4194069-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I had to explain how to run the driver tests twice already.
Improve the README so we can just point to it.
Also fix a potential problem with the SSH remote sessions.

Jakub Kicinski (4):
  selftests: drv-net: force pseudo-terminal allocation in ssh
  selftests: drv-net: extend the README with more info and example
  selftests: drv-net: reimplement the config parser
  selftests: drv-net: validate the environment

 .../testing/selftests/drivers/net/README.rst  | 95 ++++++++++++++++---
 .../selftests/drivers/net/lib/py/env.py       | 46 ++++++---
 .../drivers/net/lib/py/remote_ssh.py          |  2 +-
 3 files changed, 118 insertions(+), 25 deletions(-)

-- 
2.44.0


