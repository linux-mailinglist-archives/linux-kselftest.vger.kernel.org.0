Return-Path: <linux-kselftest+bounces-9692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6075E8BF8F1
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 10:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C151C23C6D
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 08:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B92D54744;
	Wed,  8 May 2024 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZzmm8Ud"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EA247A7D;
	Wed,  8 May 2024 08:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715157682; cv=none; b=S4CgTA0AowGyQNgQBfAn4UNCtQiyr6CudfdjdJR1+i95vDLdtA4ypUHfVmGLmQfXGPCPxUmVi6Z2/QwIvTpoVLc7HJzPjh7OjnZnzj877g7XwMjkumvuNBMRQUk9YGxt+eE+5wxuYZwElaiX9d7Ls9ioif00Qli5DBHEFrISamE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715157682; c=relaxed/simple;
	bh=tFrBko3fZ39c5ExxzecBIB9057Bs/91qzrR6wSOjiec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tJ5pr5Fp4T9aBvytn0h5bfLmc60PFq4YFGhU9FDp6m7AnPjcOS3ni2jGINPJEU/Dd9HkKQCRWYc/E8LHr7dAcQBjhEtn8ziDpOB9D2APYlqGq6yYXQqH+uwTtUZnK2bEdrPDovQszFlFG2gJ+3NyAVOEuSdi8eWVL0IMOQt9YL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZzmm8Ud; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41bab13ca81so42477145e9.1;
        Wed, 08 May 2024 01:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715157679; x=1715762479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oahqZfDyyAg3+t3i7wWbHAtk2w+BE0/9KN4JkqkuepE=;
        b=eZzmm8Udekh/RgfmJqoT6pcGhKkn+JDt/1XeAZ6ZzdBh7SfGoeMaJbU54jxgofVDZa
         0mNZ6auWxISh+9xz4kAtwvUvff/SjNotmVDZHB0mWC956+9oADxKWOL9RL07oYw/4pVl
         4nQ8UDH4FWF1b4swQn7LSNDfnaW8aKn4u9b1i9rnWp1y0x+DyCLpeqIu9ql9XjqzNsbM
         OGbaehjPve/LCsQTQdj/aRmPRMCiATbGj6wdnaouAT0NnE9sQ3KABRoES9RXVF4ODW3d
         APqkke6PiVj9+SIsXVIFXNfXE4HD92I3mr5HhvSngn48suW6LncN7nOeN39melSwGzY3
         AITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715157679; x=1715762479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oahqZfDyyAg3+t3i7wWbHAtk2w+BE0/9KN4JkqkuepE=;
        b=byc6OLI30TtgZUmnK8zeDBgECKsIqXzkh4C58Up6TB0c1ZTuoORhyH3W61d/y+Fsfn
         y3gxcFQJ9QoktkxdmuM6AmlLqf0vSpGEQBeTBfw6lhdT+a1FEJg+UL9v6ZGjPTB9aZCZ
         2L4PDg3znSUtpqshXJYGpcjeK0XsNqg75TIO0YDxT8A6MBvj2ADROeKEubkPZq9x34Bf
         TYVEDXLQoZxdG01nuZplvzJ3pv5L+M9LHN6S+3eCp5n+RCYpN3B8AhWlPLNir2TvG82q
         lyQZZ/D6vGJQ/7Gg691IwoUCpxxaig+GFXGjlPkEfD4qizDe2q8odnPJ1GnuVTdbcWmG
         cWeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyRQMgJSL2frtioO4ngNn8Y/nZaLdcCOqDXSddyWcuYOcN6chr24g1qAOA0Kej5g3r1JEiTKjADVqe+kAYH9BH5bl5qSz9mPx3CA7U33HdB9WM9xwoJ1ll+5lksAV3ma5LQWFiP8lQ8Uos8TSn
X-Gm-Message-State: AOJu0YwUwszuvHPzYhVDxc7dnVic2KPwJN0DHile/fRaG15zU39dRiRD
	vZOICG+61YsLo9HybCpbuWmwsXLRHnNSJ7cFGwXlQ/2AuHKs82h+
X-Google-Smtp-Source: AGHT+IFlZthE/gNpHlsP4PzBCS7/ATHrR1sotaFVQmvVdO9ZDKPaoW32q0ewDHy1qLhhfNuhcB32Bg==
X-Received: by 2002:a05:600c:3587:b0:41b:fa34:9e48 with SMTP id 5b1f17b1804b1-41f719d6190mr19055165e9.30.1715157679003;
        Wed, 08 May 2024 01:41:19 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87b26675sm14959835e9.2.2024.05.08.01.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 01:41:18 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	Shuah Khan <shuah@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	Benjamin Gray <bgray@linux.ibm.com>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests/powerpc/dexcr: Fix spelling mistake "predicition" -> "prediction"
Date: Wed,  8 May 2024 09:41:17 +0100
Message-Id: <20240508084117.2869261-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in the help message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/powerpc/dexcr/chdexcr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/dexcr/chdexcr.c b/tools/testing/selftests/powerpc/dexcr/chdexcr.c
index bda44630cada..c548d7a5bb9b 100644
--- a/tools/testing/selftests/powerpc/dexcr/chdexcr.c
+++ b/tools/testing/selftests/powerpc/dexcr/chdexcr.c
@@ -26,7 +26,7 @@ static void help(void)
 	       "\n"
 	       "The normal option sets the aspect in the DEXCR. The --no- variant\n"
 	       "clears that aspect. For example, --ibrtpd sets the IBRTPD aspect bit,\n"
-	       "so indirect branch predicition will be disabled in the provided program.\n"
+	       "so indirect branch prediction will be disabled in the provided program.\n"
 	       "Conversely, --no-ibrtpd clears the aspect bit, so indirect branch\n"
 	       "prediction may occur.\n"
 	       "\n"
-- 
2.39.2


