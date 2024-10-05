Return-Path: <linux-kselftest+bounces-19088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B30799147F
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 07:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DADE1C21EF8
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 05:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C67912FB34;
	Sat,  5 Oct 2024 05:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5qUAZlA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E23056B8C;
	Sat,  5 Oct 2024 05:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728106193; cv=none; b=RxVaeW3XL8/wWKAk6+zqD8tGc6TO3p01ARHxih7ZA74iGhruwasBbGuyCMeXUSx+bZcKI3SQt+c25xgbr78WnEFyGPjV+GVylr2UzYLAKFRHv2zETUBwwoepxlGSiegh64RSHC0sa1ZG50AhkbOCFfklVKDN+8zmA5PIZ9P5x3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728106193; c=relaxed/simple;
	bh=8790Q/Q1L9GpIQvA++SYhF21GrVeItoSfRTYmLGUJdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d/NSXAonMJG0LJ3f3KAhqV1Gra2PhsP33pCIWsde2Bo5a5HrLjDhCG8LbFP7h+P/Jj+CgRzCjFd5emVIiKwfCqoR2h5UYE7KK+akq0aoqV89OhkOAgfpRVtMkSbPagph644WNTRHnS1BPvCMJQYxC+yrdlRWXHp7AD4Y27wWFIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5qUAZlA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso24640225e9.1;
        Fri, 04 Oct 2024 22:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728106190; x=1728710990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfTolaWUR5Q7eogVqqR9oLr+YzOGV80VHcoSRCsh1YQ=;
        b=B5qUAZlA/L79im4QUcQuo+47rLT4ZCjKQbtkKBlo5RTV2kS0P8ic8Xzv3SnCu1axEd
         mJ9fpWsAGE6c+6AQ5HnGlftif5qO6WL7JUDg4VkafZW4kPkqR4nt6+N/dTOExbHHCiLA
         pU+cm1VyUkh3A+1rrONS72ZUq+VbRs/kcyGYUDIYiVnWVlaZGdFv9ifRLqWopxayw1iy
         9OG5b2ZVocpHgh5Ru5c3tNf2oEUBV+xjy7jskvhJ16S9BaZbtbst1+l55ijOvTHrx68e
         uM5S+cRI7vAhGwg0JKiK0F+qKkz1JSuMiZJE2FyeP/LzK/Ha5CxUUjpCEeg9hQlZLZye
         Ehwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728106190; x=1728710990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfTolaWUR5Q7eogVqqR9oLr+YzOGV80VHcoSRCsh1YQ=;
        b=RKDt1f/3Ji3ljvS5zsjFElfCCBiMTHuzAFpfd1Nv26TU4ub7XlReU1UAiwRuW2ZiDg
         wQ7Pb0gFWNbCHJ+j2m0OM/d+cpKosT45xC7ss72RzpyqIIHPdYN30om4stMUSt8OIpRx
         ceNdN35sV9EiGsfSRpazU1WXKeJY709bnlk0HK6dCKlqGtkbYaFDDTuiYO4Tq7hLxTHd
         FcRMJbc9dC0l8m6XX7KLHK5ki8DAb5/aEANsiS2uCzDoW/S3JPQWNaAOxs9DKAkNcY1w
         oT1nQvXfTiJQbldooHqfa9mLLY70gWtp2F72SORKudHrFPJlm2alwYU8zuOudfPk5wOK
         Bt+A==
X-Forwarded-Encrypted: i=1; AJvYcCUUdbS2mSQAjzDxUCropMDi3HaQbcRgS8Ny7nH6bfA7caorsMJL6jvv1OCHGm1tcmAqtGWCYpoboV+AaYyb0XqG@vger.kernel.org, AJvYcCW380pPHgBmrMJ/ZJONUW7ZTezXP4YiGl/2cHng4raJAFFhI3SfY5EVOyNDofd4PB8nfbfaJuR5AaXLXA==@vger.kernel.org, AJvYcCXOxvelwCacF7NvlHzFnIoOrukYmqOT/gITLWWOoVenqdxskDRBfd5L26y0vYIm8Act8r5Rj8eYHaKFyeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgTtv8VWFR9UaFJxSRlrTINYn429jZ+3xC7tYjcAmr9fAPwn85
	CUNHc6bQWjA1Ps//HSFOP5qOGB5kjTYbzL1wew0JfvFv3G6ikHXk
X-Google-Smtp-Source: AGHT+IEiiKV2X+DFQ18qbBAB5KxJpAfXKOAQHXiJYlgTQ7qEjXUbETWXjNl0bgLzoKFteDYRrg00oQ==
X-Received: by 2002:a7b:c8d6:0:b0:42c:b22e:fc23 with SMTP id 5b1f17b1804b1-42f8a01e691mr10715685e9.15.1728106189476;
        Fri, 04 Oct 2024 22:29:49 -0700 (PDT)
Received: from [127.0.1.1] (ip5f5ac341.dynamic.kabel-deutschland.de. [95.90.195.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ed952asm13103105e9.45.2024.10.04.22.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 22:29:48 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 05 Oct 2024 07:29:41 +0200
Subject: [PATCH net v2 2/3] selftests: net: rds: add include.sh to
 EXTRA_CLEAN
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241005-net-selftests-gitignore-v2-2-3a0b2876394a@gmail.com>
References: <20241005-net-selftests-gitignore-v2-0-3a0b2876394a@gmail.com>
In-Reply-To: <20241005-net-selftests-gitignore-v2-0-3a0b2876394a@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Allison Henderson <allison.henderson@oracle.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728106184; l=852;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=8790Q/Q1L9GpIQvA++SYhF21GrVeItoSfRTYmLGUJdc=;
 b=Ev9uEdDejL/eR68OQnFj6mhsBC+kqAvTslFI/lXRqBFNuW3X5AwUFZ89W5KYkenVmWkBNVwaM
 qJM4xppVYB5BuF1n9q9pygcIu8VGSoECgGgiULjzfiYUQVsMhITzaC6
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The include.sh file is generated when building the net/rds selftests,
but there is no rule to delete it with the clean target. Add the file to
EXTRA_CLEAN in order to remove it when required.

Reviewed-by: Allison Henderson <allison.henderson@oracle.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/net/rds/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/rds/Makefile b/tools/testing/selftests/net/rds/Makefile
index cf30307a829b..1803c39dbacb 100644
--- a/tools/testing/selftests/net/rds/Makefile
+++ b/tools/testing/selftests/net/rds/Makefile
@@ -8,6 +8,6 @@ TEST_PROGS := run.sh \
 
 TEST_FILES := include.sh
 
-EXTRA_CLEAN := /tmp/rds_logs
+EXTRA_CLEAN := /tmp/rds_logs include.sh
 
 include ../../lib.mk

-- 
2.43.0


