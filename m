Return-Path: <linux-kselftest+bounces-10212-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C29C28C5EA9
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 03:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649CC1F21C37
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 01:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A769A7FB;
	Wed, 15 May 2024 01:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSGYvK4n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B66E8C11;
	Wed, 15 May 2024 01:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715735308; cv=none; b=IrvqDTciIzdOAtcT7YGqfoX2LYribP4CLabRg6nOm/BULIwnTfZFGY0lx8rs+B6COm0qod3U6NJZH1355Xwp/dY96E/mu3QxvqzGzyG2Vou+TwIVAEYL5EvmwH0AGHjHsDsHeE02a+IYNkUDWFD714qjvQpsmKPjxcL2RQgBlzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715735308; c=relaxed/simple;
	bh=t2dCvEvmxqBF0ZoMYUDGqTs5EjeSqTmU/jcy4IIDLtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hS4ionRcvgMhp3aqbR2nuAoGuODUxqMTOmcJ3ZbNDTJj87LMFrRTrBQcmTlmlET/yPwtagLEkXrIFxF+adaeZvjej7haixGOilzpGerfbjBsDiXBT4retxZnYjE/YfQ9XNYOU6y5uX2XYi74S/27KxCiHrk3WXK19+oaj1kAa+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSGYvK4n; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f08442b7bcso12260365ad.1;
        Tue, 14 May 2024 18:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715735306; x=1716340106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXX3A8fyv3exTOOEj1HA+TNTB0ha+l87+h6npCAFwJc=;
        b=GSGYvK4n6Pd+dllkeNP1LiaguKh544hM7PGEk7zHCYML1S5m7SISmjlHrO5Al/K7gO
         Wi0FpCzAecT7l+/sxrnF/zu8QolnzUePei2+yiC4SLuXeWosIbwl1bNvqqMZgf3vX+1/
         xpSLwjcJstVR8Rcroy9i/vCuh7uOxoBsPm9+ENl2q6TKTAlTf+isQrGpMd1CSxlx81sx
         s0QfFx+l0+QVMlDgnDNoP4deRHlgEDbkh5ynm6iLDE+jehNnj37NAmXA4UerQM3q6ehp
         L7Hxqrv5aaJFiC6tbY6SxLePQx7UDvqMqABq/TMgEQwAPicO4fqFApANcQu2x3WKgTQ5
         nh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715735306; x=1716340106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXX3A8fyv3exTOOEj1HA+TNTB0ha+l87+h6npCAFwJc=;
        b=IuIPItBs4alXe9Z5PSLKl05A6h3eHcyTCUQw1MZlDr+n9SsbOy5oEdwA/bPTAc0dtF
         bUDkijj2fxDogmLaDZFVkyNWUNO3cTBwUYcSGPvDJIBpyXN0+YiWwsdNE7VaVeg5B7Tm
         mx/cuDvltbAzYsS4QM83Zcd/Fq8xavYv6WEW/DyXUkd1sLbY2MsTy4nGEzTSeEz4Vgy8
         Me+yBNuIJxW4rA08rdFMJ5m93nydZk4iubTWpnn41Nbwu5cASC3UrPw3x7BO3XQRrsKw
         8bSEHAQu+RZ8W75/YKxZhzitdqVxfMaDLsRTD0SgFxHdxibsJCPPwZ294tWEKao2Fh+T
         8sEg==
X-Forwarded-Encrypted: i=1; AJvYcCW0yVHXa3I0oYze+YxnsbaGQGf1z8Tp4+LFQ2qmOTyZXfNnGzcoZ6cNAJAigwYTJjmKMVUdnqdW3C1pXxJqOJuVv5bh8WVCNT8P5Xjw
X-Gm-Message-State: AOJu0YwYU1JzchA9eYlQr9CISIacpGVRn37HRt2+nGh3V/Jtb1T7nAJx
	pqwXgMv8C33F+zPTFSoVHeGphFCGIYG2WdDnD5feCWkGyC1EYha9WlaeSXhGpMU=
X-Google-Smtp-Source: AGHT+IGFGFFgGkdH0CfKcsVIy30aMwXWQ4riCJ1NMUSAw2aaesIFFlQ9ymwftNpa5+tkUkCey8lYcQ==
X-Received: by 2002:a17:902:f681:b0:1e3:e093:b5f0 with SMTP id d9443c01a7336-1ef43d0adadmr197215775ad.8.1715735305981;
        Tue, 14 May 2024 18:08:25 -0700 (PDT)
Received: from server.ucalgary.ca (S0106f85e42401d5e.cg.shawcable.net. [174.0.240.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d16cfsm104973325ad.18.2024.05.14.18.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 18:08:25 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
To: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Abhinav Saxena <xandfury@gmail.com>
Subject: [RFC PATCH 3/4] selftests/binderfs: Macro argument 'fd' may be better as '(fd)' to avoid precedence issues
Date: Wed, 15 May 2024 01:08:04 +0000
Message-Id: <20240515010805.605511-4-xandfury@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515010805.605511-1-xandfury@gmail.com>
References: <20240515010805.605511-1-xandfury@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the macro argument 'fd' to '(fd)' to avoid potential precedence
issues. Without parentheses, the macro expansion could lead to
unexpected behavior when used with an expression having different
precedence levels.

Example Code:

    #define CALC_SQR_BAD(x) (x*x)
    #define CALC_SQR_GOOD(x) ((x)*(x))

CALC_SQR_BAD(2+3) expands to 2+(3*3)+2, giving 11 as the incorrect
answer. Enclosing with parathesis CALC_SQR_GOOD(2+3) sets the correct
order of precedence and expands to (2+3)*(2+3), giving 25 as the
correct answer.

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
 .../testing/selftests/filesystems/binderfs/binderfs_test.c  | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 4a149e3d4ba4..d5dba6c1e07f 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -30,11 +30,11 @@

 #define close_prot_errno_disarm(fd)      \
 	do {				 \
-		if (fd >= 0) {		 \
+		if ((fd) >= 0) {	 \
 			int _e_ = errno; \
-			close(fd);	 \
+			close((fd));	 \
 			errno = _e_;	 \
-			fd = -EBADF;	 \
+			(fd) = -EBADF;	 \
 		}			 \
 	} while (false)

--
2.34.1


