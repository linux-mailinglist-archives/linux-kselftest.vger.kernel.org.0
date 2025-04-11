Return-Path: <linux-kselftest+bounces-30611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3867A8615F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 17:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0151BC0B7B
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 15:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D2420AF7B;
	Fri, 11 Apr 2025 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xULx2QQ6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jT8hwW9y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF36B1865EE;
	Fri, 11 Apr 2025 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384195; cv=none; b=tb60eCqNjsp74iKqzYDhWT6qbb3d/w89Rcq6UFKstgQcyy+VcKshX2FQ/SgeC7ttckDfzzMo1xyxE++LPJyOF4WLFgim3cwQfJnN7LMOQQxuPBeU46v8pTlUBaixlB0fA466vbRqMv0PsrPt5qT41/MLojrzH+M/2J5qICQiuik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384195; c=relaxed/simple;
	bh=vRvjFLIaHRHwz8coabD46czxQlxA65v1S4h1KbCVTW0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SO+vAg31YwS0eNXDpSU2VpIoSCd4vrlwdFk6KXJyjwj22APN9TXdBvY2ww/GSfJaN9hDYk4U7O25Jla4j4UUfDJFGNhVa7rojyaBehipQpgiTuoGqeX1z7do5ormrPwnxwni4msBXckauV76PR415eBuRtFTCTXk0UQVw1Vjrj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xULx2QQ6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jT8hwW9y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744384191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wYnQXLpuI/DZh9uvxk0vRGpla9rYF/JSxVayBxKGboM=;
	b=xULx2QQ60x7E/UEUWefHBQFCqCbOpcgPr8Pu8htRoPaLe2kj3E4xAxq7qPI6QO0pW7SS66
	JZn+vAkqVgpmkX8DI8Nv3o2H+E9PpbTqJCZq1U69kWv5hC2iC33rph+QuyDxqiVUalH98K
	fYzedExWlH1NYPixCYcSytSyaPO0CCxliQFTiv9ATEUi55pYPqKytBelaR+FGl7aJU9/+F
	/T43kLMIoXuC6Swxebj3OPcF+aVUTPwI0iSvCxWo/bu6wXKVyqK1APqDkAE0SRxI3HchRB
	Z4IPPwWg2KM0zBvSUxFMRag8mXznomlEOAhPkYUu2R2uxS4am2PxVXZcWGzl4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744384191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wYnQXLpuI/DZh9uvxk0vRGpla9rYF/JSxVayBxKGboM=;
	b=jT8hwW9yiGVgl2t3kPfsV0FGB9J/BkqOC+EHo6hHqXbnwdX4F7pJ0GmmnEldvA/K7Md+gf
	UkxAywPeX0ySvKDw==
To: Christian Brauner <brauner@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 0/3] selftests: coredump: Some bug fixes
Date: Fri, 11 Apr 2025 17:09:40 +0200
Message-Id: <cover.1744383419.git.namcao@linutronix.de>
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

v1->v2 https://lore.kernel.org/lkml/cover.1743438749.git.namcao@linutronix.=
de/
  - use getline() more precisely [John Ogness]
  - be absolutely safe: waitpid() for the child process, and still wait 10s
    for stack_values file to be created [John Ogness]

Nam Cao (3):
  selftests: coredump: Properly initialize pointer
  selftests: coredump: Fix test failure for slow machines
  selftests: coredump: Raise timeout to 2 minutes

 tools/testing/selftests/coredump/stackdump_test.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--=20
2.39.5


