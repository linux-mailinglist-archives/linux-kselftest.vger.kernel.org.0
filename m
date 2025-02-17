Return-Path: <linux-kselftest+bounces-26764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1762EA38112
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 12:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75053A3882
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 11:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D6D218AD8;
	Mon, 17 Feb 2025 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q79gzYY7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8IQrGUkI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF048BE8;
	Mon, 17 Feb 2025 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790040; cv=none; b=nZYl6x8mFroO4ICAM2Lmcz3wSUZSFJUMn0gGF0EBFFWPelxAY9b5Fq8MrH671ZYo+KZRO3ft8t/xU3YgpDa8SjVYuBv3CravXug6qwEO+d5Sf65uhHRCrNtS4NkhbgX6cxHqD9a4LNfPPJg7l3JEl/SBUDR3f+zR14Pbk+G7ySE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790040; c=relaxed/simple;
	bh=rAGgEZdn3WzkyARocDN45a3nXlF+LE9psWomiX3VZbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q1kIVvMEAJKkShfbIPZl/XOJVaPjH4hX9NRD/eP8F+yxuwNt+zEgW8xQdeHtF8MVDxOoE5zdEPJ2VBzuBZIdm5gx+Uw/+b2cZKKMgeNHVSPpqaD9puKsMNNVMlcW4wtMg3qux6ZhdtJ8qEyZqazNYatvpET7B0IWxYEgHUDRIEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q79gzYY7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8IQrGUkI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739790037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0KmdHXYAy6wfYle32Vznj1iqwKW38Fdm5LWbDAU9Ds=;
	b=q79gzYY7H5aQENDnuljxzAOcUW5Bq8UVdCGZlKgS3hvcR/EAz1cG4cJyBBi9aVabOgxQwG
	ZFJhA2l5oFpEEywIiKgMy1z4hd2UvM+Jo4J3alJiRth0lm/71WuAmHxaPYCcLLuxDoh+0R
	YFmX1dw9MVjaBJjPGpRmI0sncvtzBPMmklxFvkpNHnXUW5eTMPQVYnBkaU5MxftuEMSq9G
	rBU5YgiTsTZHmalI5d3c/y3Gp71CAHvu7LWyUV+ICnhYXzz/Kv7bBp58FU28l130BGTEAf
	9/n7WxQJm3esT6fE17aXiz1bTOc49s1piqH1p1ViNqoDleJ40hwAXCB7iqXDLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739790037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0KmdHXYAy6wfYle32Vznj1iqwKW38Fdm5LWbDAU9Ds=;
	b=8IQrGUkIUlNndjucwoA1Kbokjbm6nYIGigjozCDlGkIINASF1wIsySLabRVAH4G3UGY7l/
	e2Kt8YiLXilwcvBg==
Date: Mon, 17 Feb 2025 11:59:23 +0100
Subject: [PATCH 03/12] kbuild: userprogs: respect CONFIG_WERROR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-kunit-kselftests-v1-3-42b4524c3b0a@linutronix.de>
References: <20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de>
In-Reply-To: <20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739790034; l=918;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=rAGgEZdn3WzkyARocDN45a3nXlF+LE9psWomiX3VZbM=;
 b=iCG1DkYz8U7H0zYtB6qsp2O8JjkNFY3/h1Ef41Q1I0Pro/fkc59gYfmIgBKDXUNW/I2EM5jsg
 vK/dr57TgQfCM0IaRLVkcZhz5Sw1a/J1AA1lLozmVJmoUUF2mL5jtlW
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Reuse the general CONFIG_WERROR to also apply to userprogs.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 scripts/Makefile.userprogs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/Makefile.userprogs b/scripts/Makefile.userprogs
index f3a7e1ef3753b54303718fae97f4b3c9d4eac07c..debbf083bcfa01c89c204a322a1b17e2bdbe95a1 100644
--- a/scripts/Makefile.userprogs
+++ b/scripts/Makefile.userprogs
@@ -21,6 +21,10 @@ user_ccflags	= -Wp,-MMD,$(depfile) $(KBUILD_USERCFLAGS) $(userccflags) \
 user_ldflags	= $(KBUILD_USERLDFLAGS) $(userldflags) $($(target-stem)-userldflags)
 user_ldlibs	= $(userldlibs) $($(target-stem)-userldlibs)
 
+ifdef CONFIG_WERROR
+KBUILD_USERCFLAGS += -Werror
+endif
+
 # Create an executable from a single .c file
 quiet_cmd_user_cc_c = CC [U]  $@
       cmd_user_cc_c = $(CC) $(user_ccflags) $(user_ldflags) -o $@ $< \

-- 
2.48.1


