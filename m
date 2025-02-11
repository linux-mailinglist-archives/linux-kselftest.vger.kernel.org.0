Return-Path: <linux-kselftest+bounces-26368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048FFA30F5F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B60A3A3657
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 15:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612AC25333E;
	Tue, 11 Feb 2025 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5txZy7I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCAE26BD8C;
	Tue, 11 Feb 2025 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286823; cv=none; b=nU6B+2mC1nUixYcGqLFUdZFgidfQwZ2vFKEys7zLfl7IKAbu/P+Q/JEgYiKxQsi93vlktC6OGCr6z1e7o7Dbn8s9U7yRGuxUic2zJ473UNMeyxLs96+65DiRlQwBOpoFZJ7uSg3M/9piVJH7txoLxW8bGcLQRV65aPG9aCK4F4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286823; c=relaxed/simple;
	bh=IuVvvZtPoUGGcmxIWcY0gncFYLrFzRkM5f/+XVpUJ68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FOXlUjiLnp26muxgUwHiE5CGLYUU9FwZddiKvW4uPLe08Uj+1jYBsEBTrRM7gIL4qD4rr1KW19Bbm+kzeuD0N5N6K3QM77kdZ2N0OTvUuxNR0RU/RDn448klKuGfVfxnJ+jH90CNwQF4CZXwHfzhj+Spbwv53t9YGhhU6wpipuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5txZy7I; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c053a2118fso293827985a.2;
        Tue, 11 Feb 2025 07:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739286820; x=1739891620; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=22Bstn2976wUKe82wjuA5ZVlk+B7sh1UpKdDUKp4KuA=;
        b=d5txZy7Iu/fR9A2TVJA7SsJl5x1xoRs2xy84aDpJcVWCnJ8z6Sx6HgmRDLl92BCbVC
         5Q1w/RPkLBVu3gzZZHpopI4pCNKjz0sLw2Ko45RhM3ImqZRvMV72pzCMjo5AsbEilOPk
         IY00owLyRhPscEmzSLr+f30Q09eEIcTDTjMB7ProLkMmJbVJVZCOjX7DKG4zW3errTJc
         m7MlwYqGBTTp/tIcFN7beAIQaPPbRcvWTWJHkshlt0eW3QxTD5+pd7epsthG2Jh1Cr8i
         d1rluyfHGHa//wpS/EkcEM1msmPof+RmF45xqw+6eZK7tNXSxZQge9RT93dVe27HRsCl
         vJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739286820; x=1739891620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22Bstn2976wUKe82wjuA5ZVlk+B7sh1UpKdDUKp4KuA=;
        b=YKbWQDKZMWnIlgDsm6+NPKooscc380pHNCKLRxBTaJ5kPIN73dUyWWGLeIEjXeMdae
         H7FdhcDtIf3w6Bejpl4PezS4rCiR94dDMYdX4/0Ldokot0UegIDVP9jMmNiwb1z4PK42
         dR1mPS11+YD1TbjxoBAmm8C8kpZWDGz09rgMHlcY6Yuhs5xzdOD0Xvr4NqVb9L1Xe5jm
         Z6oz/JaNfk+xgVcgjmMoobZ5rF/+Gm/nNzjdY/e6n6nKYNpQNyCrtp634QDGbj1T5d3T
         ivkHV04h0sqUBnPoL40Xu9BdIoBAXWy765l0pAzAJ4s41HaGlOeHQX78kTt8dfOJohfj
         7D0w==
X-Forwarded-Encrypted: i=1; AJvYcCXFKMDsHDEzuloxfJbtOdV5kfHXmvk22b/ccjjwZHGy6mwDF6FoqZyAP4SZlGsKK4b1jHoH9/vB3zxJ9IvuENmq@vger.kernel.org, AJvYcCXl0QhIVfag+7uAcIMJDmrOEdtlUH1D37FADXVlnOCtcSO/lrNLCqzQW2H8HCCRENh2WC6l9z90z17aQ14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgIzqahNTs5/bvvchdUKXb4KoTQPfXUlPRD6tJruGQ61oXZMtX
	nhB4hFu99zeAr/yToKSyjlYEpU2/8LnPsIFXL4F96NKK+0A/Cmeg
X-Gm-Gg: ASbGnctCzwGwgSDX3q+jIYNruVbx8e1QEn3Yecl8QljIaHlbzoV3Vzaf0fkVy7zSnqR
	QKNcxu0XFh9DygywV1otNLmlRPQwEY19cBSQQY8b1Joh4cB+EnWfoSZLBtcYMK6d9boetyQjLhx
	xm8rmoie2iTChmIZo00+AWQ2pPDC5yDLpr5zcR4lg2IfNGtBbZ07Md1tCLQF6Zh2gp5WCtMvSyz
	BYACqpIMbJWHyP6hhNis7/rc+uYALYg30cB7WgoN3oL/SgtqeCdAO1WsmH03m1ZRB7hdsfTvNEt
	jVKbtCuOvE7lgOvLFZTa/3FXh9VRpKcaUtiD
X-Google-Smtp-Source: AGHT+IFeo+WjS/5Yd6JC8PWzDXkblp2JHuX7GuxZb5CP+Lk6VEHpDk4LizyTtdFx1q2Rpaq9GKWAXA==
X-Received: by 2002:a05:620a:3725:b0:7c0:602c:e68a with SMTP id af79cd13be357-7c0686e14d7mr608046485a.18.1739286820564;
        Tue, 11 Feb 2025 07:13:40 -0800 (PST)
Received: from tamirs-macbook-pro.local ([2620:10d:c091:600::1:b3ba])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47193e581cesm26852561cf.40.2025.02.11.07.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 07:13:39 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Feb 2025 10:13:37 -0500
Subject: [PATCH v7 1/3] scanf: remove redundant debug logs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-scanf-kunit-convert-v7-1-c057f0a3d9d8@gmail.com>
References: <20250211-scanf-kunit-convert-v7-0-c057f0a3d9d8@gmail.com>
In-Reply-To: <20250211-scanf-kunit-convert-v7-0-c057f0a3d9d8@gmail.com>
To: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

The test already prints the same information on failure; remove
redundant pr_debug() logs.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/test_scanf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/test_scanf.c b/lib/test_scanf.c
index 44f8508c9d88..07444a852fd4 100644
--- a/lib/test_scanf.c
+++ b/lib/test_scanf.c
@@ -62,10 +62,8 @@ _test(check_fn fn, const void *check_data, const char *string, const char *fmt,
 
 #define _check_numbers_template(arg_fmt, expect, str, fmt, n_args, ap)		\
 do {										\
-	pr_debug("\"%s\", \"%s\" ->\n", str, fmt);				\
 	for (; n_args > 0; n_args--, expect++) {				\
 		typeof(*expect) got = *va_arg(ap, typeof(expect));		\
-		pr_debug("\t" arg_fmt "\n", got);				\
 		if (got != *expect) {						\
 			pr_warn("vsscanf(\"%s\", \"%s\", ...) expected " arg_fmt " got " arg_fmt "\n", \
 				str, fmt, *expect, got);			\
@@ -689,7 +687,6 @@ do {										\
 	total_tests++;								\
 	len = snprintf(test_buffer, BUF_SIZE, gen_fmt, expect);			\
 	got = (fn)(test_buffer, &endp, base);					\
-	pr_debug(#fn "(\"%s\", %d) -> " gen_fmt "\n", test_buffer, base, got);	\
 	if (got != (expect)) {							\
 		fail = true;							\
 		pr_warn(#fn "(\"%s\", %d): got " gen_fmt " expected " gen_fmt "\n", \

-- 
2.48.1


