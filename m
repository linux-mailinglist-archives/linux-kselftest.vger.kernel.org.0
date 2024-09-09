Return-Path: <linux-kselftest+bounces-17503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 385149710C1
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 10:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAAC82816DE
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 08:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A661B531B;
	Mon,  9 Sep 2024 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeNWUusB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845701B4C30;
	Mon,  9 Sep 2024 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868626; cv=none; b=BE/FWG7h+WGoHD5WyQOiA+NgR1zs4tnWVPftYygtwUfvK2bma87lZbr8Q6GMq9svtELEK0e45dvOWdcIbWoX60UN1YDNJYKZqNdGr39TCrCLhFjLGIvhdEYk0GOolCP0F0FWJTHK8W/5eEkzLUVqEGbf9ccUo9Bb7TlT95mvjVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868626; c=relaxed/simple;
	bh=p48Rzz1oFrPh7OwCz62uWL5xWiFSQ26ws2cGJATf+h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eX1xKmvr/R89lWV1cZGJmWT1ACwCWdOZZr8EKI3Ttjq/9FFd/03IP0rHXYMCiy74ifWLisC0izDAZJqV5vV7NA4SvG7dYlq7DbaxnYtlXlhKYTpUV3+gelXfPI/4Len1GdhhF+h+3+pBmYwd+nJHrDNb5hJP+TNRNxgZVdJ+zvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeNWUusB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so16824975e9.0;
        Mon, 09 Sep 2024 00:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725868623; x=1726473423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aK7oAHt19v4bPo2zqG0Ykp0jbeXdGIHNkoqennHtifs=;
        b=NeNWUusBeRfWdHhdYpYsK6JG4jdLVCvcZXyr8TU218ZPkahdDPEjBEzFz2Lm+VrvnG
         LPiFWbauvw581GrZFJqAxVTJAbgbRGPXC8gg/bC+l+xA7Su0EuWV15bodnWzgAZKYjpp
         G3vXkQu+fW9BzteFOucEbX9TK1AYfh9+8jX0nFos0OVTpJsfARj8j0eA2FR1hphCvkYG
         oMLN82AoTuhawmrM7XNdHVlTfnRI8H3DV2Zn/HJFkQ/DDW0hu2FA4MD0obOjKoFVfJp7
         8FeQIwd4YHdBOP8P3MFZ1oimVgaBajOjv3B94jg6f8f/eN2Eaa4LEfmnED+/CfWxv8lp
         pRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868623; x=1726473423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aK7oAHt19v4bPo2zqG0Ykp0jbeXdGIHNkoqennHtifs=;
        b=HfW8iYbWbrwm7aiTyWYtHRbC4wter+868G5dcUw1lsSz3hkd4i75n9rAKRsAHx/AXS
         aDDWnbr/tcAybFJ9NR9KEekTI09bj31ZMrrOmvGqnyEG9hbjjSPquMxr9804r7+hW9k4
         7vnmQB9no9fhsXxOs/9auS4Hk5OkB7Mx3X8VCGScScQC2z/ljoCVIbUNChByTchZVIIr
         GANPp3lYaJpcpHWWe0nB7OE+Tt2qqVp3wAu4hGlyzUvHO+EXWEI/ZuPr5YtgkSkra2pB
         sCPMLURh0wpKfpWymfkfPIxq8du8GxC9UIRZ3dEDBXpsySK3+16Mudi6v0BKFz1cXRJK
         Gyew==
X-Forwarded-Encrypted: i=1; AJvYcCU9xQOtqzeNq4u4PeCVAAmklQGJZr38vfjKq9IWtAhrh8gqDqRrMb1uIXBpwrhhYn9ChRuZwsb4HHO9do919g==@vger.kernel.org, AJvYcCUACy4Rds898aKxYGzjy3ywglw0NQQOPx14tBRnUr63Ds0mNAutxz9sJV91X7+qSG/29DpwQI1/gLE+Exg=@vger.kernel.org, AJvYcCUHbUvY/qajIp7+4mxAidnqFmtTfgZ7mOr4yVjWyHikafY9E8gjUb8IeWfQijqyuqrpdE2L4T1LDg174PJl@vger.kernel.org, AJvYcCVF30OkrvjnJZ3FyIgmIKanrTHD/Qb0Z1LwueRWDxE3CwVPVXER1gKCfboV23pJsNqPKI0=@vger.kernel.org, AJvYcCVLl0i1YnoxNAnLXaNfjxLTpdM54FBi0CmWdo7qwDUCenfX9KMSiQfk1p3EnQTMM+nSb9lLpJ5t3jm/BcuC@vger.kernel.org, AJvYcCVz7Xk+47zd9Qi/e/sKXZX6mL7s4JAQf7mX09lD7hrXSKMU1nPNCy7Jpw6B7xjasyqE/cc/rIEHdSDXBg1RkvWB@vger.kernel.org, AJvYcCXlbd85pMTpzC1qkJoBTOWD2/o+m1OStop3h89ukCGP3HtlSRLx0oqjUTKQCL/3SydN0PrqkpQ3s3l9lw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbqK+zHCam1xtqSv5YOl9JmUe7AwCNmk4vR8yip5xErIR8gZzR
	nIVoU7jXRIYP6udVFHOgtva16n4gzzOGSLCoZqo3Vv+UDBWmvpA0+0sdONIF8Tc=
X-Google-Smtp-Source: AGHT+IE9kxClsfj4lFt+9I6K+XsyLZJIMNPvzQQtiREHo0bljCJBd8rPdnCe8AqgSk7kgXsrHagO9w==
X-Received: by 2002:a5d:460c:0:b0:374:c35e:de72 with SMTP id ffacd0b85a97d-378895c53e2mr5981884f8f.2.1725868622808;
        Mon, 09 Sep 2024 00:57:02 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675b7esm5303001f8f.50.2024.09.09.00.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:57:01 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH RESEND v2 10/19] lib/interval_tree_test.c: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:53:53 +0200
Message-ID: <20240909075641.258968-11-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909075641.258968-1-ubizjak@gmail.com>
References: <20240909075641.258968-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Substitute the inclusion of <linux/random.h> header with
<linux/prandom.h> to allow the removal of legacy inclusion
of <linux/prandom.h> from <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/interval_tree_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/interval_tree_test.c b/lib/interval_tree_test.c
index f37f4d44faa9..837064b83a6c 100644
--- a/lib/interval_tree_test.c
+++ b/lib/interval_tree_test.c
@@ -2,7 +2,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/interval_tree.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/slab.h>
 #include <asm/timex.h>
 
-- 
2.46.0


