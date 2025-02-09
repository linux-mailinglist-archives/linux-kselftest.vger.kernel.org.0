Return-Path: <linux-kselftest+bounces-26124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A94A2DA04
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 01:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538BF1887D25
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 00:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32019243389;
	Sun,  9 Feb 2025 00:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTD3kuG6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDAC819;
	Sun,  9 Feb 2025 00:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739061701; cv=none; b=L3T2x4vkYzOf4I0IrX2zSTn9zQHCaLJZEnZx52M66L7RvjuP4nuud55Vtfka+OqAZhDW28xojJsnyfOJuJu2rXjDQ+XgY2JswlBW2x9SDlZyoSBSghcwjyR8hBmWXq5x2XldGmjD2ZjMOgl/zX0TgDc09jlMP/+alavtelFpnL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739061701; c=relaxed/simple;
	bh=SpWHB4Z5KMf4LSaMFuL5WRBvdcw8Q42qJix1nneUIoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tue0wq1KimKngAEM34zEBor/8b0oRh1Pi8k8IKphOqh3YMZixLzR72rHTMmRlnGIDnh3E4UJ6mZF7jm5ezYPmjzfOmiBesznzQ8rSpupNqdSqZVz0CAWvSql9ibQ7fSoYW+VzGOk3n7nkuo5tmpIDLtmbq1AbzCd8ZFf+StFlkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTD3kuG6; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c04e462c3bso73069885a.0;
        Sat, 08 Feb 2025 16:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739061698; x=1739666498; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vwp2Byu00e90GrZn/qF/rycqYIQg0TgfP/aWBzdBhUo=;
        b=jTD3kuG6xPVONUiCRketLQrGktDKcdcYot32qzXRRKM0SOqx5AbuOxPtuf22IoiiOp
         pN5Cv4npvKQRRxVMgRChrjNZACtaSqgTijtqs10bWRriJzI/BY+/QE8oiierXb4CMuef
         ExF1nR7tiXXMZPt/MJPWlPMQH86hfQvGw2dpB3eAWSyvpl6Be46X7EIWHj9xvfp3z5d+
         ASQS4q3mTQ6Np8TZF1FoTCCl1gIIeyywOpXSslr8dT2A2cA9bQh6ShxSfoHXCsTp9xFC
         /VnqPTvBi8UJYnqLubhEEvfQKBgYEUvCpNniQGMhLsXhtaFXOXI/bqLZCbKA3amaOAX6
         O5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739061698; x=1739666498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwp2Byu00e90GrZn/qF/rycqYIQg0TgfP/aWBzdBhUo=;
        b=Ad8Fpt9Opc0HJxsOMxTcp6e/9V+KImi89nT9GWNl7UMUhbyH2be1HAcBQjJhcr6Kuq
         bUygv68R7ubj+gQKawjwHuVaerMTqFJ7+7ZTnqT2lqGE+5erbpA0FbgvfEWKb67WuduD
         YOqmQVuKW7NnsLcFYW3SyPkhpb9HYAygWK18Szq2/5tIl6GkVYHGjjyuiFLrFpVwBey2
         gEzpYjvK5YLFjDAGIj9QoodiJSeHL6wkHs9sbobIkycNGmWrSzJ9HoI1dduG7ebwfMVG
         C6GORUhNvZ/K0jG4c05ch07Moe37KjJ9n3+VtvNBpDDZ9IdkLd5ruIdY2I+Kf0+fFhQu
         LB8w==
X-Forwarded-Encrypted: i=1; AJvYcCWN9PZtwjmDfx2oU02iJ5XE+hM35uL4c50H4FNy2mvMIBwqXLQRrJIo3dt5cS90J3i/D2K16Xoi1ejhfHLPYVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhDzPE75dLbPPDbFuIbaHMPMfTGdv1JMvzKxikDB1zQSrkpHTi
	n+xEAy3BCVVK/z4iGm5eoDzVKhsQQyZWbjj1KA6+nZOXMekFihqQ
X-Gm-Gg: ASbGncuI+9Jr2kyWaXcezDa4GLN992CMLn5CDPPjdXWiHZZW6R4Cj7L+tefytSinImO
	uc2e50gePgBHY0ALtQdN0+sj7UAbAag+nI/HfKX+lJ4WN3l5J6HF1pm46HyMLZGYfxgVc+xBCAs
	KE2uNClig0Df6TGLiP76wIulgETQpMOgRLWJ0WX605ueuBhLg1jRWYDGzb5gIy/KdOBvLWqob6v
	CWMWlPJgHMevbVh4iZXDtmDL690+hU2e2QC0V5FXWytvWDuJfXiZ2PaRzs22gPgtCZfnp9Ic9Tq
	m1cpigxtLwzLrWmHZMOLSvn4VEOi+YyNHeBBIv5vIHKGF7/FASi+l9hGdnMe53aR1AIvnZ+vEC+
	sr2kyIkefGrMc7fcC4SP4U/fajfyCdcOa5lhVaw==
X-Google-Smtp-Source: AGHT+IHU/3ZKMy93GC5XkNwM0qnXDXb4WoQ0ymaIR9ECBBjvmCz+OiUd01j/7rldo76Moa306WnFTg==
X-Received: by 2002:a05:620a:4551:b0:7b7:106a:19a2 with SMTP id af79cd13be357-7c047c389c2mr1272038885a.31.1739061698341;
        Sat, 08 Feb 2025 16:41:38 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:15f6:96e9:3308:934a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041eb7f94sm353272885a.96.2025.02.08.16.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 16:41:36 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 08 Feb 2025 19:41:28 -0500
Subject: [PATCH v4 1/2] lib/math: Hook up tests/Makefile
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250208-prime_numbers-kunit-convert-v4-1-76e36bca06a5@gmail.com>
References: <20250208-prime_numbers-kunit-convert-v4-0-76e36bca06a5@gmail.com>
In-Reply-To: <20250208-prime_numbers-kunit-convert-v4-0-76e36bca06a5@gmail.com>
To: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Luis Felipe Hernandez <luis.hernandez093@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This Makefile has been dead code since it was added in commit
7fcc9b53216c ("lib/math: Add int_pow test suite"); the tests worked
because of the duplicated rules in the parent directory's Makefile. Wire
up tests/Makefile and remove the duplication.

Fixes: 7fcc9b53216c ("lib/math: Add int_pow test suite")
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/math/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/math/Makefile b/lib/math/Makefile
index 853f023ae537..d390da9a59fe 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -5,8 +5,8 @@ obj-$(CONFIG_CORDIC)		+= cordic.o
 obj-$(CONFIG_PRIME_NUMBERS)	+= prime_numbers.o
 obj-$(CONFIG_RATIONAL)		+= rational.o
 
-obj-$(CONFIG_INT_POW_TEST)  += tests/int_pow_kunit.o
 obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
 obj-$(CONFIG_TEST_MULDIV64)	+= test_mul_u64_u64_div_u64.o
 obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
-obj-$(CONFIG_INT_SQRT_KUNIT_TEST) += tests/int_sqrt_kunit.o
\ No newline at end of file
+
+obj-y += tests/

-- 
2.48.1


