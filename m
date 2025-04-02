Return-Path: <linux-kselftest+bounces-30033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B3BA797D8
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 23:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE693170FEA
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 21:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7981C1F3BAB;
	Wed,  2 Apr 2025 21:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="WJY2+kuc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3814B78F58;
	Wed,  2 Apr 2025 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743630402; cv=none; b=qYsMLGjB0vUqkEq0NYxvWWa2azDuplYbV6QkE3/MggTLdwzvBpbR7U0rdQNdc4f/KP86fP9Ijbjq0N6cseUZStHidW0F88hIAZd8jhYyaTeGJOVbdYuszJns8bnKx53PGNKxz8bfAI2+PbDWKVP8k4x465CFCyq09lQgQEtkNAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743630402; c=relaxed/simple;
	bh=8zn+UTYXBCV8dmhmdtiNV+XZmY98vsMXcAG/BpCM/h8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JiNR5eI9ZJK4Qan1yARp8I8L+4tRNtV2fUy0KuM+0repMIQtXVZrubgmcrXXnVzKJpqrNwDkYbgUCud97BcXyjFQkmHcH6hcQ2GXDiv/D9G2H5gOG27wwRWvAgem9sAYuIZWOcj/tUQgnX5OW/yVFrYTrCJCY1Q80uAE5P5+SkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=WJY2+kuc; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1743629944;
	bh=8zn+UTYXBCV8dmhmdtiNV+XZmY98vsMXcAG/BpCM/h8=;
	h=From:Subject:Date:To:Cc:From;
	b=WJY2+kucuLAoOdo/5R5H3s2DMAnCPTW/L0tQvjDnRlraQQG7UV9oX8PQqa7VOM3U2
	 lXf1o7gNWOEi5AZ+TVSe6BRw1rwzWeeDEebWPd+pnVNdBiulcXAfUN3CQjiEdHARzZ
	 AfE4gxul7K53IHBU+qFqsm6dF9p+VbAiRG5VD7so=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/2] selftests/nolibc: only consider XARCH for CFLAGS when
 requested
Date: Wed, 02 Apr 2025 23:38:58 +0200
Message-Id: <20250402-nolibc-nolibc-test-native-v1-0-62f2f8585220@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHKu7WcC/zWMSwqAIBQAryJvnWBpH7pKtLB81YPQUJEgvHsSt
 BpmMfNAQE8YYGQPeEwUyNkidcVgPbTdkZMpDo1oWiGl4NadtKw/IobIrY6UkHdGmUGZvlO4QOk
 vjxvd33uac34BxqNIKmsAAAA=
X-Change-ID: 20250330-nolibc-nolibc-test-native-6d4d84d764eb
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743629943; l=580;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=8zn+UTYXBCV8dmhmdtiNV+XZmY98vsMXcAG/BpCM/h8=;
 b=hstap0eLL4ot+gUfFvpSsgcFgsC/Hnww+EcaGrXa8kqwB3zp+HPx+2W12dWmBMLOCmGgrToN/
 XBof5CcYJybAWM5GhbhVYOwZUNWd3AtV1nlXbsyMvuqfOPud0JsaWfh
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

If no explicit XARCH is specified, use the toolchains default.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (2):
      selftests/nolibc: drop dependency from sysroot to defconfig
      selftests/nolibc: only consider XARCH for CFLAGS when requested

 tools/testing/selftests/nolibc/Makefile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
---
base-commit: 9a9b20007ab833c1aa3791efcfdf67e7e3ea8902
change-id: 20250330-nolibc-nolibc-test-native-6d4d84d764eb

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


