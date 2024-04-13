Return-Path: <linux-kselftest+bounces-7900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F06528A3A2E
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 03:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4C1283CCC
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 01:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7D5DDA3;
	Sat, 13 Apr 2024 01:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/MwGqsQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A7E8F48;
	Sat, 13 Apr 2024 01:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712972584; cv=none; b=swa0fg7m4Y71zwW+xncmzNsUTvToSkjpdOrS9PZvnHdPGPpRCEnc84uVPPalRR6OceIx7iae0W7j4RZq54DhysyZzu+8vQWBpkMPFG9+ehEoz5bXZROpDDRD46LBOTWr0ZaUNwEk4uvGRqTCgAHVDZUU8TGmQICqWuKe2NHs2NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712972584; c=relaxed/simple;
	bh=KHPrFD1YMMjtcQAp8KwZm5roaOz4QkN4zvujtINqzO8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y5BuLcUuYcsy/g3uQCEUjTrobJfmIAtEjkEUepuuFBTf66+mMuVHFg76DYxFRFXbUxK+YwbA3TjaFwFWx71wDXK1jc8ju0fIyFia1gN6oF7lykKupkL0tud42EYg9VL6vzW/faeNOYSphrlzZveZrk1gqquRobKMQcYESqR1O7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/MwGqsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56AFDC113CC;
	Sat, 13 Apr 2024 01:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712972584;
	bh=KHPrFD1YMMjtcQAp8KwZm5roaOz4QkN4zvujtINqzO8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=n/MwGqsQM4590CNBTR+NWw7r2c1yzMZm/qGtz/zGicjm6g388ME5VSxeWXCyM7hOX
	 3KQ/y/NG772xoNU5d+Lp/TJARU1McUyiDgPGDXHnmtgpWxkQBjJQ//eleP2B4wNjIH
	 QaJEtNSCkcPBz3a3/VYx8kR0/IiuOyEllEFYHAaEJ/XXF1naWQng/MVAGGLY8fM6yv
	 NTpTcemrsmwyOijDoGXv5jp36eiHO610figA13HUWtk9CwAhnaNWFsg9OMf4b5U9BZ
	 42W3InFKpoU4yjlDDfgwlRtrQYggGefQYCXewAOVx3Lq0Wl9l+EOK6HSVCLySXpTci
	 xyrB3RbrrDQfw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443FCC4345F;
	Sat, 13 Apr 2024 01:43:04 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Subject: [PATCH net 0/4] selftests/net/tcp_ao: A bunch of fixes for TCP-AO
 selftests
Date: Sat, 13 Apr 2024 02:42:51 +0100
Message-Id: <20240413-tcp-ao-selftests-fixes-v1-0-f9c41c96949d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABvjGWYC/x2M0QqCQBBFf0XmuQE1i+hXoofZ2Wsu1Co7SwTiv
 zf6eM7l3JUMJcHo3qxU8E2W5uzQnRrSSfILnKIz9W0/tEN35qoLy8yG91hh1XhMPxhLFI3Xi4Z
 bEPJ4KTgGbx+UUenpMoiBQ5Gs0/75EasotG1/KEN2noYAAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712972582; l=913;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=KHPrFD1YMMjtcQAp8KwZm5roaOz4QkN4zvujtINqzO8=;
 b=g4UdatSWnniIGkEvTKc/9CPb83Xp944jIoxZpzLz9t1htXBnI3Aw6tuhEKco7FkzxCITkkCkOSFX
 jed5RYawCjbpGTDx15YXqwSBIGA97j352IR06NXZUMCi5/8jz2Ef
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

Started as addressing the flakiness issues in rst_ipv*, that affect
netdev dashboard.

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
Dmitry Safonov (4):
      selftests/tcp_ao: Make RST tests less flaky
      selftests/tcp_ao: Zero-init tcp_ao_info_opt
      selftests/tcp_ao: Fix fscanf() call for format-security
      selftests/tcp_ao: Printing fixes to confirm with format-security

 tools/testing/selftests/net/tcp_ao/lib/proc.c      |  2 +-
 tools/testing/selftests/net/tcp_ao/lib/setup.c     | 12 +++++------
 tools/testing/selftests/net/tcp_ao/rst.c           | 23 ++++++++++++----------
 .../selftests/net/tcp_ao/setsockopt-closed.c       |  2 +-
 4 files changed, 21 insertions(+), 18 deletions(-)
---
base-commit: 8f2c057754b25075aa3da132cd4fd4478cdab854
change-id: 20240413-tcp-ao-selftests-fixes-adacd65cb8ba

Best regards,
-- 
Dmitry Safonov <0x7f454c46@gmail.com>



