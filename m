Return-Path: <linux-kselftest+bounces-37256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 144A3B0411A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 16:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9D5188AC1F
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 14:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1AE255222;
	Mon, 14 Jul 2025 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7ObX0bP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E4B139E;
	Mon, 14 Jul 2025 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502331; cv=none; b=AaeN/uxavR/tw8XKgYBiNTIH0DP4CTpGzKLYUCyHSnmu9B2OV/De1HXYZ1p3tGc2FemxI1oNB8ujd3WME3s+pLnRAjc7RZp4igsWiAGDYBNyTz7HDh0U+wNVNz4EitiUYYBCWWoXFxZDWdkLiyNjDpPBXn8pisNNXfDu6dCwqIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502331; c=relaxed/simple;
	bh=jJd2AdrJxorMf3F7ZC60nhGVIIEZvq6HX9MbQuxjauo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HhI1EsEh9ZfPByfKYw3XwZQ8DYRpYK+GKtSx0Nn2E1w3+Cxc6Tf/WqpDMBw4+r7O2IB/76OiEgZAy/EfZ0p9Vyiw6ZjB6FoKHQIPIvKQcQ34dmmoCzv8tv+hKhkDzsotox4oyNJ1PwxNpOshDoMssI/SRU4hP7e1Ru1t/DIJzO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7ObX0bP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0198DC4CEED;
	Mon, 14 Jul 2025 14:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752502331;
	bh=jJd2AdrJxorMf3F7ZC60nhGVIIEZvq6HX9MbQuxjauo=;
	h=From:Subject:Date:To:Cc:From;
	b=Q7ObX0bPSUkQ69EJdKOGwvA5ZLzXee4+1xnRNQT3bBuMd9Ujz+ynuwZ8QmHXUKAbX
	 y+IA5fCW7A6n1i7g0IXHvP61Q6vplyhwJ7cRrrPOrdl1Oc3a7yBJqCei9DWVo/MY4H
	 xbOF73lBHponN5gRBljnW6AKCS823mAPRqxloTl8gFYmBjhQKI3Sl8rG6K+uyE+qtE
	 SGDLiJaz6o8HnuJmHj6H/7sp6W0QW64KDQ3j5lO6q07W5XGd0hF1JeNxteJrMmzkbW
	 zAj3S7R+j0i54jG5kuOFN49tabXxRt3rpKtcfv7+e3rfXWrsPqo4blXNZIO+igeNKV
	 O7bNGrA5XLMnQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] selftests/fchmodat2: Error handling and general
 cleanups
Date: Mon, 14 Jul 2025 15:03:34 +0100
Message-Id: <20250714-selftests-fchmodat2-v1-0-b74f3ee0d09c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADcOdWgC/x3MTQqAIBBA4avErBP8qYyuEi3CxhwoC0ciiO6et
 PwW7z3AmAgZhuqBhBcxHbFA1RW4MMcVBS3FoKVupVVKMG4+I2cW3oX9WOashTPS2MYZ2/keSnk
 m9HT/13F63w8lVhSNZQAAAA==
X-Change-ID: 20250711-selftests-fchmodat2-c30374c376f8
To: Shuah Khan <shuah@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
 Christian Brauner <brauner@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=763; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jJd2AdrJxorMf3F7ZC60nhGVIIEZvq6HX9MbQuxjauo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBodRA2TyA5UQzLeDchOvAFt+MuHiv5prO176swK
 ig3RX/ErsOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaHUQNgAKCRAk1otyXVSH
 0AqoB/9cFdYXC3nCsSURty3+jZ88U8WEjrrjW5RNBcB6CFm88bnnoA29nI5wrdSvr6xJbToac+D
 /CFoONARS4904VOyXUdMm8L2HaLdekhJDgRyhTYdmp2kuCLFrjtinmt4AyN0u8EA/hxz6DaXpA9
 64BkmAl0i2Xxd/ggzjlRrp5k0qr9tTQlyNE3UJF3cwKImTNHuXZSJocZILh49MVNikLxV0N6+1B
 tfeBly+Mo0Hyy8YetKi5xU1sbbB/KRwzY2ukq0Hba8PikMYs9Zl8EEaJM9VZyZxZDeYFFuVxFtc
 mBemQOdlpLchXdvAyBx9G4d+w0WKaWwl2/aFddZApBGoj4a/
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

I looked at the fchmodat2() tests since I've been experiencing some
random intermittent segfaults with them in my test systems, while doing
so I noticed these two issues.  Unfortunately I didn't figure out the
original yet, unless I managed to fix it unwittingly.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      selftests/fchmodat2: Clean up temporary files and directories
      selftests/fchmodat2: Use ksft_finished()

 tools/testing/selftests/fchmodat2/fchmodat2_test.c | 166 ++++++++++++++-------
 1 file changed, 112 insertions(+), 54 deletions(-)
---
base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
change-id: 20250711-selftests-fchmodat2-c30374c376f8

Best regards,
--  
Mark Brown <broonie@kernel.org>


