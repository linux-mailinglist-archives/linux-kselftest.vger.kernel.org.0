Return-Path: <linux-kselftest+bounces-17192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018BE96CCCB
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 04:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B31FB287B85
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 02:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1FC137747;
	Thu,  5 Sep 2024 02:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M9XAks84"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0306A136E21
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Sep 2024 02:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725504485; cv=none; b=fItifL4ZrGFStDMDP5pNkMeR8EMk2rFOpg7bYP2Uk8BrfiF8VxfGYenQDAvHCy0hAuGWMsc1QTtDZ/ZdFeGpAJuLPdUKHipBnGWfgaA/naPghLp3iU7hPjE9kDJ5vOzemI41m5tEFL+lUMpjrVR6I0+LSPVBDBAR5cBh+QaMVV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725504485; c=relaxed/simple;
	bh=LxRKzOknfNVgr/nZkfxVsvIlTTUg446Hy3DXGGEcM8Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=odsVOBrFIan0Re/emPQ1bXtNXC5Vqc5ddllZVqDu4tJg4/wppJG3TkAdJBd1/KQOT3NUG09/KkLrzh8WAiV3yTmhHx7kkG+ZB6d0+5WA67iZrfVTy724meuiOFhasDtAS9BF6gnmLyu4gldHssay4k5A+XGARdp0OarDqI5Nkc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M9XAks84; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d34c57a88eso6485657b3.0
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Sep 2024 19:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725504483; x=1726109283; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eFYjJd8iNrtb63t18R0exGEJbYCH+p9Iky0tcx/gIcw=;
        b=M9XAks84H7CkibWwGVd92v+9IFfvSxCHAkndAx+pHOLGS8dsKt0pFARXRN4aoqHjDF
         5+jTye78K97RVSMtzJRR20ZulnxGGI7dAifCPI6yzj0qt4ysMWSvZp2E2BIOyjyNClFZ
         m2jvl7HHtuXGO1w5bao+KeCTsU8zw+6Fbc36FJu+WWB+j5ELc1RDp5/er2J7gfpiyhhU
         vSoP1/dUhiiZPTR7xqZFlnzpsrjmAp5Op8i7qP5iPGJ3Px4e+8kq2aWGpRF5G5rhd7PZ
         735J1/RXz9HoLTZ6Llr9RLcjgJD6IncVaZggtFR8gxDN0uky1OpYaI2gjI7im/KKc8eY
         5S7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725504483; x=1726109283;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eFYjJd8iNrtb63t18R0exGEJbYCH+p9Iky0tcx/gIcw=;
        b=wIbkTKolTL87Yx04YGMAKXXUZMOo219JsHTlKtm2GNGoUrSbP+jWsWfKUNP3lIAAlC
         4sjdg+rhJxfC6n2nt1Zf8bKVfmZOzSXCYGzyGGbNqyel2odVwvPYUkG94JwjYbZBdocz
         6ZlAsjiBvdLm9ZUIg0wzmoeNFs3UFO392sGdbL01enLzSN5nlhIxaBpZN/ufdkIMnJXm
         scqCWky9SdUOZOCwLPhNafZGxYz0norzZmY0Srop0HJQO/MwMbvNYhNYs8ZYfMo3Dk3j
         ccySl+g+THoYq7MLE0Gc7cGjFwxBTKkJ7tRcbC6ELzgUsvvnzhR9w4PkOIIj6wgn+si0
         Qb9A==
X-Forwarded-Encrypted: i=1; AJvYcCWCneRmPK075ECqtC+CdwonifMF1gcMhWy5Z3/OSWgczFJpR97VKyiEl2yKnzXCkIkiT/aX5ss2gcB4KmwxAkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5M7+2ccLLmRPProp782OWTRbth3ckMX/LDc6Wrqho7cgxkMux
	ABm034iYEhW7DaWuM34C7B5ClQiCdS2CpeGL9r5poCcqv7za6fDbi2RUCL3HzUcOacoJe5CRT6m
	R2CL5BBvxhQ==
X-Google-Smtp-Source: AGHT+IGNLR4PLf7J72aG+yfi5fxLOJ/FPaMyP1DQR34ZJJHiCNMx7yxbuaDtk4sqGOMejduCxj/wf6O5zO1URw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:690c:dc4:b0:6d5:b062:4c05 with SMTP
 id 00721157ae682-6d5b0625124mr7902037b3.4.1725504482897; Wed, 04 Sep 2024
 19:48:02 -0700 (PDT)
Date: Thu,  5 Sep 2024 10:47:55 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240905024757.3600609-1-davidgow@google.com>
Subject: [PATCH] kunit: Fix missing kerneldoc comment
From: David Gow <davidgow@google.com>
To: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a missing kerneldoc comment for the 'test' test context parameter,
fixing the following warning:

include/kunit/test.h:492: warning: Function parameter or struct member 'test' not described in 'kunit_kfree_const'

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/lkml/20240827160631.67e121ed@canb.auug.org.au/
Fixes: f2c6dbd22017 ("kunit: Device wrappers should also manage driver name")
Signed-off-by: David Gow <davidgow@google.com>
---
 include/kunit/test.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 5ac237c949a0..34b71e42fb10 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -484,6 +484,7 @@ static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp
 
 /**
  * kunit_kfree_const() - conditionally free test managed memory
+ * @test: The test context object.
  * @x: pointer to the memory
  *
  * Calls kunit_kfree() only if @x is not in .rodata section.
-- 
2.46.0.469.g59c65b2a67-goog


