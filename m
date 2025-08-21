Return-Path: <linux-kselftest+bounces-39528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0F2B2FF4F
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 17:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66206249A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 15:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48BF341658;
	Thu, 21 Aug 2025 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Wn4rSLgA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464B62D12EE;
	Thu, 21 Aug 2025 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790839; cv=none; b=ZNE7yVUt4cubS5yGvuyt7qK91yqg42NR3OWZbC9B1MRXQRORPeOG4LjSz+qW5CaJzyQ7ufJkken9jv7Bn96cg9WamunN2HmPqqeZJBtC463T3J4jDaM+GAzXEmcAK89to7j+jLu+lmYoVfgWkQtjWi+yUhVRRsAvI2m6SXvWKRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790839; c=relaxed/simple;
	bh=EDi7kgFTFGG9Vox1cVUjyMOtC59OypbC935AUmppWQM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=thQhzF/ox51G/JGMSxKC/FXB9xtbIbqiNxRTs/MLoBMDSNEezQsCQaOh8SmR3pu4vwVyyyzxJjaBh5xfi7cFdeomk10VbD5n6TAIIM9Gymx0wuSw+8Do+OsOn9Su+KNrjucxNGIi2z1vKSgT+DksoPjVgeYZc0Iqgp4LZrjxjAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Wn4rSLgA; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1755790835;
	bh=EDi7kgFTFGG9Vox1cVUjyMOtC59OypbC935AUmppWQM=;
	h=From:Subject:Date:To:Cc:From;
	b=Wn4rSLgAtBESNTpqj4tuLfgY95Xb0GTw1j3Yjf1aWIl+QbESxXrkWN+oq/d1EkFGt
	 sNthlD3h7gTF7wnD8mNtzl69KvFjL4BwpGQUqZKpJJnS10BiLLybmqBS2txPp2FNC1
	 KsY+eqDn92GhYEQ0FJKP9nzDDHezyltqFPr7Gm+s=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/7] tools/nolibc: reduce __nolibc_enosys() fallbacks
Date: Thu, 21 Aug 2025 17:40:31 +0200
Message-Id: <20250821-nolibc-enosys-v1-0-4b63f2caaa89@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAO89p2gC/x3MQQqAIBBA0avIrBN0QIiuEi3UphoIDQeiEO+et
 HyL/ysIFSaBSVUodLNwTh12UBAPn3bSvHYDGnRmRKtTPjlETSnLKxoDUjTBGRc89OYqtPHz/+a
 ltQ+QOsuCXwAAAA==
X-Change-ID: 20250821-nolibc-enosys-2b2ec0b505ba
To: Willy Tarreau <w@1wt.eu>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755790835; l=1762;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=EDi7kgFTFGG9Vox1cVUjyMOtC59OypbC935AUmppWQM=;
 b=IWi1WXyurTh7V5K7rWfEYUuPalw0ndbYdqh6apShuST0cLYoa1D/Ii+IMbwJFHiFj7eau7szJ
 aZbpUT8VPeYAaNLfOyw9Uqpz9yDKCnzYiCoI0jqlT91qHoe4fU4/1Hi
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The __nolibc_enosys() fallback is used when the UAPI headers do not
provide a certain syscall number or any possible fallback syscall.
This is either because the syscall definition is fairly new and nolibc
tries to be compatible with old UAPI headers or an architecture does not
support a syscall at all.
Many of these __nolibc_enosys() fallbacks have become unnecessary.
Either because the "new" syscalls or not so new anymore or real
fallbacks have been implemented in the meantime.

Unnecessary usages of __nolibc_enosys() as it is not obvious anymore if
a given function is really implemented on all architectures.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (7):
      tools/nolibc: remove __nolibc_enosys() fallback from time64-related functions
      tools/nolibc: remove __nolibc_enosys() fallback from *at() functions
      tools/nolibc: remove __nolibc_enosys() fallback from dup2()
      tools/nolibc: remove __nolibc_enosys() fallback from fork functions
      tools/nolibc: fold llseek fallback into lseek()
      kselftest/arm64: tpidr2: Switch to waitpid() over wait4()
      tools/nolibc: drop wait4() support

 tools/include/nolibc/poll.h                |  4 +-
 tools/include/nolibc/sys.h                 | 90 +++++++++---------------------
 tools/include/nolibc/sys/timerfd.h         |  8 +--
 tools/include/nolibc/sys/wait.h            | 17 ------
 tools/include/nolibc/time.h                |  8 +--
 tools/testing/selftests/arm64/abi/tpidr2.c |  6 +-
 6 files changed, 34 insertions(+), 99 deletions(-)
---
base-commit: 850047b19741490631855a475ccaa3ed29316039
change-id: 20250821-nolibc-enosys-2b2ec0b505ba

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


