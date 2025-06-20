Return-Path: <linux-kselftest+bounces-35398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4837AE11C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 05:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E91A4A21A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 03:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5051C5D53;
	Fri, 20 Jun 2025 03:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/2hK56y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F86817C21E
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 03:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750390106; cv=none; b=USg52OB9azW+mzhEbmb14VanveskiekmROLuMgQn+yQenxPrIsStvDv/n78XQ4Rz3QdoN6kroq4nw2XHU/8EV04qjgwbFWSMtnd3EzZWnGXgDZ3bBCkVqZ2C/KcsW4rwTsK3sKEFTX0ci3pYyWrAWcGM85I+2DAcLjm5o9fRnZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750390106; c=relaxed/simple;
	bh=y7XYsEiV8pu+FtX9PfQDMuiu3QFDejbzcFpX8zmMwy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSBy7WMqvyUr80CenppIUvosBkNce+a1e+44KH3bVFreQfg+ztTueVu57Jx9txcf9PJVVuzLBKyHqSne3sOmpD9rdWBGNY4vGY4FGsFud8ixut5QPTxBKAyDH9foCHgaA0Em8lREIuCI4ugEkHhANSqkr1RvKb5SHqKY4KVicvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/2hK56y; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-adf34d5e698so510199866b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Jun 2025 20:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750390103; x=1750994903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LP/ixAp/tgtOc499/nVx41tf1PETzmQTfQZn9MTpP8=;
        b=E/2hK56yhzLcNMm//qwKIcy4Zh0MFIDCK2YKQ32AgUvZ1jE6CrtBVBckhxlY0una50
         iji4+R5BOEtuG9cS1dv5fMNi4XIR1O/3TeCgFjbE1x4D9FTGvUuRxJuOqssvEZ7bUZdo
         /0wa4AKYOGig9o5CmTCN9PENhtUeUD+GKcL+wmtMIPOwX+lRcduHYPqx2srUYSSfi4+5
         lMxDuKxaqFRo+d4DLwrUgAWIPeZUqRWEGfgpgfZTwXqpNUoiFOYGGZSkKbC8ixifFWEv
         4P7s/f6agq8blq4BE11clb/yd0zXS21JZdqIdAZYdL7w/ttPE9M+5W3QaZD8w2lV1End
         OQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750390103; x=1750994903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LP/ixAp/tgtOc499/nVx41tf1PETzmQTfQZn9MTpP8=;
        b=tTytDe19FtvKNbNinVNi8WXCDtey1MR4AKLoEHHBmL+VGgJf0mGj6QybcZJyaOfQlT
         QlkPk3+wpcpYpFDMAWw1BVPl7TEFlvJXES6k0pYWESR3t+Fvt65MdQwnm4HSzLHbxLUl
         cBRzyCfYVBkC7YAKtNxD+1Mdz0dcVfQ9LqneXNzMFeF9llsWkyKBwzZuw5SR1mtjQxVJ
         scQuSthuWqquzzTrrFkQcTyb9I4pagzevH4TATqzU1ROdSMCaMlw6cwkBqGfnYqD2i0Y
         tSetLFPOIL+uWCOSvy7dJXeOWjnd1Rn0OCcFHJaB9VFmDUS2zX/BYCrnQ8zjj9YRc3sY
         ibpA==
X-Gm-Message-State: AOJu0Yx75zL35h+n49nBMUgi6c4ZO6dgSkoEp6TtwSz2nvCphwnlfodL
	Igbfmb4A+Nm4Pw6qNXr3H/jKIbSVroOsey5/HjcNR4J6u47J9IxoRPsR
X-Gm-Gg: ASbGnctJelcjkU+vqNhAfAQwHFPyvOzGIkNBs5zVhDOnqt58PD/3RtkbN7JvJFdNug7
	TtS79iPw1fHm8vDXyUJJGrw2Max+T8ElRKldJOesrr0wdkUf73urhMYj4J9Hce5XGVaB6MdYUTx
	F9EO5DcJ5GIJZMacXbxsh82AaY0InA+zvbLF6HOfbzqhRL/1FlytFn3OFRrnWtSZkBMB0zBjpt+
	duKnGF4yBKynkzpyrqkVixZkMjKMhOXht9uNqm+/fHOzrkx2TVeuq3lh3jgnuR20zNMCGqCbwyW
	SNHm3UkBOgd4FQuRpFBac+ab9RVbMojtapRtxwmA53FJAfcv12ij4hbTB+DokA==
X-Google-Smtp-Source: AGHT+IF+zxkwOJY3hfEvDSLLkBpxInM45i1duCJkwUzTxGvPw8GKSVFXVjcePXwoAsthlHy63pSKFA==
X-Received: by 2002:a17:907:948c:b0:ad5:2d5d:2069 with SMTP id a640c23a62f3a-ae05ae7169cmr72609766b.13.1750390103270;
        Thu, 19 Jun 2025 20:28:23 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053e7d1dbsm88861266b.16.2025.06.19.20.28.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jun 2025 20:28:22 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	usama.anjum@collabora.com,
	thomas.weissschuh@linutronix.de,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v2 1/2] selftests: harness: correct typo of __constructor_order_forward in comment
Date: Fri, 20 Jun 2025 03:28:14 +0000
Message-Id: <20250620032815.14543-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20250620032815.14543-1-richard.weiyang@gmail.com>
References: <20250620032815.14543-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The name is __constructor_order_forward.

Just correct it.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/kselftest_harness.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 2925e47db995..674a6112e6e1 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -936,7 +936,7 @@ static inline bool __test_passed(struct __test_metadata *metadata)
  * list so tests are run in source declaration order.
  * https://gcc.gnu.org/onlinedocs/gccint/Initialization.html
  * However, it seems not all toolchains do this correctly, so use
- * __constructor_order_foward to detect which direction is called first
+ * __constructor_order_forward to detect which direction is called first
  * and adjust list building logic to get things running in the right
  * direction.
  */
-- 
2.34.1


