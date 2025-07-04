Return-Path: <linux-kselftest+bounces-36567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660E9AF947B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BE54A05DF
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 13:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDBA309DA3;
	Fri,  4 Jul 2025 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4IgKwXrM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ROunPDue"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1AD309A61;
	Fri,  4 Jul 2025 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751636638; cv=none; b=canH9sX9nTe/imlW4op6AlO9OJz9cuYumOya+b+ar56A+u85hjDzoif8uNt/xCMU75zs0v1hDi898b+pCXBymDnKDvw/NmpxFNoznMzwT0QqMhdVAdXwn10Yi0GFJG8kSYv/ampI6ER2jVLqLg8AALhTgg4nfKQ0zw93JhVeq+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751636638; c=relaxed/simple;
	bh=sbyyvykq7k9bxaIjeUmKcMBZluPy5PtwNcI02Bk5Es0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cW5T2O/q7q+byk/HscGnsXUbyjVFBI5TqfPReuW3UNuiNL8T1b9dek3GGBrDWVBVZ19uvO8LS18KBucD11En33pUwXVkIu+gGS5ULfhYL1x85oRRLaHi0FqmhjuB/SJxDo9tY1zleTfiO21A2A7BK5kRhj5uLESwGPl6jrBnX1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4IgKwXrM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ROunPDue; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751636635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZwW0FahEeSDNEBwmMNr8v/XF6zAPS880RbT/B7oXGFo=;
	b=4IgKwXrMZjSLBXBZClVqNfRyg2st5D6E0F6I4+WrsLziAaOhKv4z8BI3qBdkxpInRLtmce
	UkLYy/aGw0Cpq0R/Xwo526QhopbSlWz2wdExFLFr7Pb/bVUYQ2+tVclUE3BSfKGWMHXGS8
	LYZBKRK1WR93AMIjFNfXwrNmz8hQa3ZR7vJ64R2OBF0pe9SfMfSUb1YJvXgycE2jpb2zG6
	8NdEISkeCSBPvoCAmfC90wKqLRQ1HzaoY0+WVPk71qJaiV2ux1kytR6D+fA/XFFzUhuq4e
	kwCYteMP+wnLCBWBck89XjCbm2t2Ywl/zFJJq8tR5A1uIvDqhOBKXDFtA+oQVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751636635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZwW0FahEeSDNEBwmMNr8v/XF6zAPS880RbT/B7oXGFo=;
	b=ROunPDuezJLrlO7lkhqlTsHSkOEzyFuL+cfFZQv8h0oOL7Wkyq5GLktbXLyiN9K3nvJx2P
	bhFIVo9fCxMowCCA==
Subject: [PATCH 0/2] selftests/nolibc: correctly report errors from
 printf() and friends
Date: Fri, 04 Jul 2025 15:43:11 +0200
Message-Id: <20250704-nolibc-printf-error-v1-0-74b7a092433b@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAG/aZ2gC/x3MQQqAIBBA0avIrBswUaKuEi3MxhoIjTEiiO6et
 HyL/x8oJEwFBvWA0MWFc6poGwVh82kl5KUajDZOd9piyjvPAQ/hdEYkkSzovbOxd23Q3kItD6H
 I938dp/f9AIhOaKFlAAAA
X-Change-ID: 20250704-nolibc-printf-error-aa54f951c0a4
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751636627; l=685;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=sbyyvykq7k9bxaIjeUmKcMBZluPy5PtwNcI02Bk5Es0=;
 b=lR7ecbdvzNLwR8ymNbu4varcrN4gc1i0wjZmxNFvR48R94b2gOrkybL+imYaU2Mrx1cSplTeV
 l6jIFPdZvr3Cs0m1dlsJqReb2SEOQuiAf0+mEDIoFaDgMxU6PqcDXaD
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

When an error is encountered by printf() it needs to be reported.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (2):
      selftests/nolibc: create /dev/full when running as PID 1
      selftests/nolibc: correctly report errors from printf() and friends

 tools/include/nolibc/stdio.h                 |  4 ++--
 tools/testing/selftests/nolibc/nolibc-test.c | 27 ++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 3 deletions(-)
---
base-commit: 1536aa0fb1e09cb50f401ec4852c60f38173d751
change-id: 20250704-nolibc-printf-error-aa54f951c0a4

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


