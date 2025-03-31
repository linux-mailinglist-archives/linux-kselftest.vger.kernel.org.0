Return-Path: <linux-kselftest+bounces-29954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E56A76C38
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 18:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9D5169968
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 16:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DC3213E60;
	Mon, 31 Mar 2025 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GzpEGy37";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2tO7WwrG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8988D2E630;
	Mon, 31 Mar 2025 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743439853; cv=none; b=KkVib7cs68oMCju1OiZgDSQu0Zu/sPtr56sjmlXNKd/Kjd21qziZyFpIbdciJf0vvSeyh2PbQvYQmeGyXgsiVx/+CiLmq34RCAWkzSXb4MfFA6ieicmUTiiwe5lyJWBl8drRG//jkEVG64QAvR+/PE7d70W9VXYWpOlyMeX2R9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743439853; c=relaxed/simple;
	bh=r9Hi5b4hyJfj9D5YpazlV0pPQQS13dOlhOuczIrTZck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jU48/OOqPXlJHDnAXpIFF4KgpCJAqtEnXi9ZF33h02qCmJSjCbuXB1w5oTlUj/FmjODZXM6Pb1uKldeOrG82KN24iwrrG6qCFFbTTLlGChxSw94mSin6RC+e4sctwUbBWqCSJ768SNymcqtoKRMKRqrKpyeRlJ8e4baqJAWX12Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GzpEGy37; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2tO7WwrG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743439849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6dXfLSSsFZMvOsC3Y8AjzvhhtH1JvHI2UVIHizOfW5I=;
	b=GzpEGy379FLeJwqWGK+FJawWlR7VuimWl4TEu7OvEGO4VzeDrUbX2Bj9+dD7VF/yCzUfln
	80O+IIY/rZ5hgJfOcAeSV3TL3LgQdlBTJpp0NBFrEy8plzQ/Wz9iuYbLLtAvvkAqkiZPPB
	tg/aFnOxtTyeqVciV8wnslyqrtyt4Hdov4URjMyE7wYo4nxXQexzxXohP5DdvkdvHK4xeN
	5Mldp7UboWezz4TIdFOAwqhKBQxCvGMa4z1hwSRgLPnQyzLU+7XKEyJlTvfmjE27EA08gU
	xTevcnUR/FTvCIP7sCOTT2uAZE8Dwi4YBOmp2uGW8z5iCy4x3xzAvsNY7BWttA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743439849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6dXfLSSsFZMvOsC3Y8AjzvhhtH1JvHI2UVIHizOfW5I=;
	b=2tO7WwrGZ0BrZJ3+ldcUJCeNZ4OwoCI+U+FIHDRRETNCHfeU+IUVxUxTeR9+C+RLKOR8YF
	Jugn6Dwz6ZFieUDQ==
To: Christian Brauner <brauner@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH 0/3] selftests: coredump: Some bug fixes
Date: Mon, 31 Mar 2025 18:50:41 +0200
Message-Id: <cover.1743438749.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

While trying the coredump test on qemu-system-riscv64, I observed test
failures for various reasons.

This series makes the test works on qemu-system-riscv64.

Best regards,
Nam

Nam Cao (3):
  selftests: coredump: Properly initialize pointer
  selftests: coredump: Use waitpid() instead of busy-wait
  selftests: coredump: Raise timeout to 2 minutes

 tools/testing/selftests/coredump/stackdump      |  6 +-----
 .../testing/selftests/coredump/stackdump_test.c | 17 +++++++++--------
 2 files changed, 10 insertions(+), 13 deletions(-)

--=20
2.39.5


