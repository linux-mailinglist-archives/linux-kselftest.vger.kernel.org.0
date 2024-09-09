Return-Path: <linux-kselftest+bounces-17487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A1E970F3D
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A038B22153
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308901B1D6C;
	Mon,  9 Sep 2024 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f626qjT0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625721B1D44;
	Mon,  9 Sep 2024 07:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865723; cv=none; b=Dav9n6R1//S18AYfmiNkWWgo6vHt09VCeOySLum0RtvkiYRB8S5nAWqkjO6SYCnZHjahnPmtXkDwYiOUIoGILJWBXQdFW+GFZ3AEmEgJ3f3kU7nzZpq+emZPRBHOtVVX90q5ByAcnbugljXEB43QsK6tzP+rwyaUMtlQYqsV3m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865723; c=relaxed/simple;
	bh=+YkTkQsCc/ElfgFXQ9fK2Ix48bUTDK80E7WaH8Zz54s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqKzrwJ3Gt520fjLwV3UNve/RUwozDusXdEDlUkAta5RzDcroEWlfP3kloniuS9cu8hLenQyxECziuHs6Ad1MZI7dzfXb3HI1rYRoyjgqLwyfUihlxnBZMj1C/S+3w/9nqfZBnRd1V1rY7qM+5jpEuDo9t+zw1RvVzOHr6gfMG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f626qjT0; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374c1963cb6so2403224f8f.3;
        Mon, 09 Sep 2024 00:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725865720; x=1726470520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZ/CxQk74jojRioxhgvCcab9AFX1uIzQFXWshuJb0bA=;
        b=f626qjT0sL5UI82/uVGnSvrsCbzK8nm6WUhG/hoowXvDLvcculMquNFfOUdxGE+2fP
         SygzGBO+QU2LAAcBLUc4n84wx5XOACdvQFmndwrkTbY55Liu0p9+XBwou5o1taVrL9fg
         hVNwXzRPsiJqwfVWMOjbqTFUOkC5u0dblGnVpRblmY3W8ma4QnuQ0UwnAcUd2g+WNRDT
         GLtkIoJttfkDSdsT0dA/JXnOLFk7LNMhSgEchvJjCKv8CzaQebfdrLMkBXNqbwLnJo80
         BjCUgcjVmha46exCwSvCKVro9c8AVIjBYJ1WVWuwIpi+sERd0RiKRctehFp5Lxdsna0P
         F+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725865720; x=1726470520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZ/CxQk74jojRioxhgvCcab9AFX1uIzQFXWshuJb0bA=;
        b=FjnEeTR5b4HAY1aJG1QsirGj72SbeacVg5SofSC6NOWZCC7hVJSPMLQI6J3IPX6zWp
         PCiqGlf0nGMgAYpm62/PeBskpQULMc3ZZXyY2qF+J58K9Wy5UF6NZjHvOaTDjymyrnme
         ITfQDz9twBwqISTl6JUjF6YPAy2DE2JMfB/O3mVxqB3wKo49itb7Dassjkv8YOp1hzff
         be7bdGIahVqsGr9QPX8ovuLAUcYHvhD57UsY/uHihvmZy4iOSc6CfrRJQ9M6vZaqIuAE
         /Xlt2S6SwhF8h1K/N/Zw/yOIYXQssfuMdUGSWMUgY4+U30QKNM+DJZ7KhG+Mlz0ga4cQ
         btDg==
X-Forwarded-Encrypted: i=1; AJvYcCU1WyFUEBJtXVtbNWjdse0TR41Ov9IHYLsSi7t/GBZstkM34a99k8VCyn4MlmS6S5NEuKY=@vger.kernel.org, AJvYcCUjwiXNNsYtVrCDO3f28ZgJIyYHA5hBupellzeeGx35nroKKR0faoByf9E949HaPzHuP/f2pFnfMkLWhOR20P+I@vger.kernel.org, AJvYcCVDoXiuH/+uzVFxj0vhfo9bdF5A0QWmpWfRSg9LVr4ay6JShmc5DEq7Kc0lEqx4wbKN+LihcuhqKsxRy32DHA==@vger.kernel.org, AJvYcCVW4NKBHx3jMLufXbIo8sy+LfdyCEu5Cyzbdqacx9ARhg+ngnogb6w9bZTaksOj/6YyHwwfATBZ10yGKCX2@vger.kernel.org, AJvYcCW6ggs6jg0BTjIgV7tphehs0gUI9cIIZ1TOh29bwWQk4bnAlhKbMtSbOer2hYYARYjGdkZmqMnkn6N/vx4=@vger.kernel.org, AJvYcCWyGIu9yLQutobgJiIopSpuhWv3ihrDIThkuzBSrgwg8mLh3bwB6NdybX7NNoAHaRge41VqqTlrFP2iJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHly7l7ILeJji5i8sKMzeSVdD+HGWCaZCIkf9IsIIWrLAQZFX/
	ChqFRWiA6x0AI0zrHc8/lEsPGLnSSCfZAeMsCatQnNke4tHhBImT
X-Google-Smtp-Source: AGHT+IFpMMDkjMFVxEERLEIpvXz5Qb9C8Ij9QoDrxVBU1SpY+XXWpwkv4/0Rcz/ipgLNBmIk031jQg==
X-Received: by 2002:adf:f6c2:0:b0:374:cbc4:53b1 with SMTP id ffacd0b85a97d-3788967e494mr7339886f8f.40.1725865719787;
        Mon, 09 Sep 2024 00:08:39 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d375asm5178754f8f.66.2024.09.09.00.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:08:39 -0700 (PDT)
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
	kunit-dev@googlegroups.com
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH v2 15/19] lib/test_parman: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:05:29 +0200
Message-ID: <20240909070742.75425-16-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909070742.75425-1-ubizjak@gmail.com>
References: <20240909070742.75425-1-ubizjak@gmail.com>
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
Cc: Jiri Pirko <jiri@resnulli.us>
---
 lib/test_parman.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_parman.c b/lib/test_parman.c
index 35e32243693c..f9b97426a337 100644
--- a/lib/test_parman.c
+++ b/lib/test_parman.c
@@ -39,7 +39,7 @@
 #include <linux/slab.h>
 #include <linux/bitops.h>
 #include <linux/err.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/parman.h>
 
 #define TEST_PARMAN_PRIO_SHIFT 7 /* defines number of prios for testing */
-- 
2.46.0


