Return-Path: <linux-kselftest+bounces-15112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D65A94DD26
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 15:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5FD1F21068
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 13:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F07158544;
	Sat, 10 Aug 2024 13:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjEWXJxW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15D4157E87;
	Sat, 10 Aug 2024 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723298023; cv=none; b=tOBRs0Ni9VlIu1pQz2LHc3paf6HOKYoWu9OXjKqEwQURPuslfmgYmLLhwCfTpLWhMRRQrr6Bo7vxPuAdOzm94NvKNRXStcLUijCEvfmbq/j/denBDkOdi27BQa5a8VJmJ09ZIG4X2tgCexnNSWCmN56k6+fy143R95cvoLE/ZVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723298023; c=relaxed/simple;
	bh=TL9SBHZ3Of0qFRJZEwFUH6a+xx0rZtC1FIueuIbaijw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=T09IdVUAi//5iX9LEqTXwyuRvioQvh/MQVSb9YxVhB1LPLdFVivXBjqPw5FQCy3WptqeXmjCA4ZjybBdtviMmPB/6V1eAYsSXRqnSeg4enYUYRHkiLjG8bjmFPfTfaHxlurfpmrEr5Op93vtgZh7BEaExU/y2jSK+SEsrZe96lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjEWXJxW; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-710ec581999so299044b3a.2;
        Sat, 10 Aug 2024 06:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723298021; x=1723902821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rJAwO9+D33fPB0w4WqDUJ7+khhrjnGCpVIskO9r4ZQ4=;
        b=JjEWXJxWL/AylESAQTfQighZ1XMSd10WmuHxlkyAePhY5zt+rBELoCxgfjHnTO6K68
         U+L4DG2+4RZnoGW0+cVMqn8lKUUyXhx34yoTb8+M/p/LkcAvCCH4NEiW7rBNT8XOAxF9
         R0xL700OyrGoGGnL/XuT8LiVGB8yD+JqGu/9QuWmJgcfAwkr5BurGWL2OF/FJ7iYOO8l
         qEBmdRziFsLadluPzrVla+lA+YoQM9Olvzhv6xAaefDP00YuFO1BW8KxNfgjtX/EiX0Q
         3LSYcSSZtwkddTjUh0m+es1/ncJCgXzfJpcxpe3xh944RWYvuU81sRZMEgzQN0rF2fw1
         YykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723298021; x=1723902821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJAwO9+D33fPB0w4WqDUJ7+khhrjnGCpVIskO9r4ZQ4=;
        b=S3Mwi/bO3ZQkrNApMVuldYtXDHETJeHqLKixnZk2KEcdw5yrjPC89jU3xpvrDtE8AS
         K7ZCYFLgvzPgxXtxPoXeMSE1CJfQBfXzLp+bEvZ1bsZJWC1I+XjRBR5jJs3AACQCXf4c
         Dj5IAHeLsOOOy27ddfAsQ6erTX5qPqNilcvxqXUGfxLiKFN96XElwOlmkfbrIaqBoXZM
         kRryU5N80vPtoS8575Eyd9savFiurbd63HHyAd2RpGkXbgSXds44W7XnQO/8rpWEQ7//
         xwS7YbVuCoDUVroGbyNWC+PRlwPxI0mbuwFjBZqfvT2SZeMZoL4UW/f7CecqOxoANUfC
         IPNg==
X-Forwarded-Encrypted: i=1; AJvYcCVvxtqybereLZOLOBpJvwAN+HqZ+nsGdmi0rq09nsgF8bB2xFX2WByGN30kLO0ODwLE0OEoBXZdRcxhdpV5NDIDa3B1tWG5+eZacw9+8PL5Pztg6kB7h9vV7pm2XhGlH3oJ4qV/I7IMXiZ0Cx0R
X-Gm-Message-State: AOJu0YzWiIwXH8TQ6gRvX3tyH5HseTy3S8vg0FNphgtSflFZmrpiDf/d
	x0ghfVzvVYhqLUSORMUltl4KAKExO/vU90I5+sZdyptT+3RNkppb
X-Google-Smtp-Source: AGHT+IFgdIxTfbezU1OPet1TfdxCPMCk1L5X7ZSGt7qACP0tfD0d27u13OSwjjufETx0/c9dJBOutw==
X-Received: by 2002:a05:6a00:3985:b0:70d:1dcf:e2a5 with SMTP id d2e1a72fcca58-710dc6c1056mr5579749b3a.3.1723298020805;
        Sat, 10 Aug 2024 06:53:40 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:30b3:43ae:d83d:a773:c8db])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a8b508sm1314532b3a.177.2024.08.10.06.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 06:53:40 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: shuah@kernel.org,
	brauner@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	Abhinav Jain <jain.abhinav177@gmail.com>
Subject: [PATCH] selftests: filesystems: fix warn_unused_result build warnings
Date: Sat, 10 Aug 2024 19:23:33 +0530
Message-Id: <20240810135333.672845-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add return value checks for read & write calls in test_listmount_ns
function. This patch resolves below compilation warnings:

```
statmount_test_ns.c: In function ‘test_listmount_ns’:

statmount_test_ns.c:322:17: warning: ignoring return value of ‘write’
declared with attribute ‘warn_unused_result’ [-Wunused-result]

statmount_test_ns.c:323:17: warning: ignoring return value of ‘read’
declared with attribute ‘warn_unused_result’ [-Wunused-result]
```

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 .../selftests/filesystems/statmount/statmount_test_ns.c    | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
index e044f5fc57fd..70cb0c8b21cf 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
@@ -319,8 +319,11 @@ static void test_listmount_ns(void)
 		 * Tell our parent how many mounts we have, and then wait for it
 		 * to tell us we're done.
 		 */
-		write(child_ready_pipe[1], &nr_mounts, sizeof(nr_mounts));
-		read(parent_ready_pipe[0], &cval, sizeof(cval));
+		if (write(child_ready_pipe[1], &nr_mounts, sizeof(nr_mounts)) !=
+					sizeof(nr_mounts))
+			ret = NSID_ERROR;
+		if (read(parent_ready_pipe[0], &cval, sizeof(cval)) != sizeof(cval))
+			ret = NSID_ERROR;
 		exit(NSID_PASS);
 	}
 
-- 
2.34.1


