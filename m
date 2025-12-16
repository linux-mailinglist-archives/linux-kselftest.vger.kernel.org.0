Return-Path: <linux-kselftest+bounces-47604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE50CC38BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 15:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED739305DCCE
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 14:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D790734405C;
	Tue, 16 Dec 2025 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HERlvNf/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556F12D641C
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765894902; cv=none; b=p6ltFidzWvdF2N9vT1VYshX+zjUW3L7bDf3+1EQyBseVCn3AXjtd4QPa6tBkn9A83hHnXPhCw3wG3eONNhiHxuudh3ZPrKbTeVQjnnfay9y9x5ucs41aR1DPqXBWDbqLhr8iNpZM4zbHFRNT5wa00Obka0++3dfzKSFrYPzJSl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765894902; c=relaxed/simple;
	bh=xk4akIQ4zkMZwyNu5en5aAFYUYM6zO5HsLOJvD66TMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gtKGTZ312LP5JDtAQ0u48XC87eBjhCApP90gohyLNlLgaOyEc//Cb/Tx2H48RgJ7+7NAluLbgF4f9KllwgATHIBzgP5eFzwHip+KwwaFb7bgCH2POPJ+1yfepn3fMt6MiSJqRT2sQfqLmz0t7A3BZnRDekLi7RRZpQG1bx3Htgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HERlvNf/; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64475c16a11so5317860d50.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 06:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765894899; x=1766499699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1nOmunptNy3oemoV4rUx/DnbH6DXevdS7AhcMbpo7U=;
        b=HERlvNf/OOXZN7T7CHl/m8v5LKf//+2Bg3jEqISnK7TuDjomY9VjXHhtqFoMxn8rjw
         OqJu++veyBtKqjVkO9Z8EFW4/lyxA7hGlAorrUQN3Q6GCUvfxCBxvssVfMht10ZzMPfw
         JcMhfnyq82mAqjxGUe2t4Qa87bcqP6Pyw4Z7bzMY0q1T1NiEACTPRqr+uON2BOBjkc+h
         5hhGA1HqWH86IUyF7DEZeU1CkIUjMcaVfJd+ljW3YfJO1vYmwMBdCmuBlbaXEw757ptY
         HJIi/1tePBX6dA0acIYyrYraaU4QzC64m/LYRhGFZshTALKwwhGIc0Z2qtRHiwoxgYTK
         dO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765894899; x=1766499699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h1nOmunptNy3oemoV4rUx/DnbH6DXevdS7AhcMbpo7U=;
        b=kdWYhM4/SZcxRLte5IzKSjtxa3/TBZ24typpoHVO409ovGhLcbX+8NaYmISYRgVGfh
         bUm/xJdXHv37UhJ/rPUqPW6TVQ+zzGPVj69Xj3RyS7aUaIaPieKI5cttrRCBJjxaE3/v
         CGf3X/vcKgmZo2pJ0mNl/qUO0Dp3OsrHWIu1hRNDSLoriJ4cYAgyQJnsh77b3k3gBKy8
         ro/JqooOE7mb7P/mBUQ6yr3gMpXFk5K1ilpdEe1QyIwds+mmTYi3V1FOYJNhIOKKv60q
         NFp+qvxgnEHGhVwSk4JnRqG4a/4rLArWjlrElxnnmQBM7Xi9fXl7j4nP79KyvmNiennC
         7/ew==
X-Forwarded-Encrypted: i=1; AJvYcCX7ePoI2BzPqVxGAuE4vn8AYieMNKbQFJgwikg4d+slHDhcI06Er2BThVQeiQ0WBA7s/6XsSTzCm8CU7NjnZxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHgE3+JSsYoH4b8s/VnYA37CVxE8jv5/rl47xhyILzs32F+06Q
	hdcowveRUPfbzN6HlOb/aYiE3vP4x8B3XEx9glALJIe/m0sH0+t1advH
X-Gm-Gg: AY/fxX5+KnTAQaM/vTMUsitoyMIzfFE+cFjPD5fgfaTyDvNIiNR0hHn87UkbJGYLqFI
	4L2ajpTb0eKyJDnpZ52MuBXa9XWqIiaiKx6qe9tkMvNLn0UYtdeCs5mwXAX5UctoxhasNsZeAVI
	08AfB07waiuIjXe2klAztFQ3aQoq5/U2gV2xiNBk83BwPIvaHf7NrpW4ET2CWZHlI5gQsniVOlC
	3poDx8BQRTnPnlXf00gWGZ2tInKurtQZbvQUPlEums03eMHI3ia0QBA/hk+rs4dRjz7kzxZB8Z0
	J2bbWbXITCLdsmQcTSG1xWj/9LG9WiwJ8BhtF/fFF+B3dbWFqV3CfOPvlcwcyOxnScxKL4rs+Ry
	9Blcgn3ChNhD/7OjYiH/cCPl5Sta6BjJnEYBT2oAaA8f67aL5S9GYNGHS3zRvLHcgw96j5kkUNV
	CsMFNl50R0VFCcoj3+EIU=
X-Google-Smtp-Source: AGHT+IFEQrF+xExK5KQL1vPJpilA4DpXFZueEXCvaSd+rgtVfZpJUrEjgFisTuNBxOinrGlRuRt+ag==
X-Received: by 2002:a05:690e:118a:b0:646:518b:b179 with SMTP id 956f58d0204a3-646518bb635mr1685481d50.15.1765894899145;
        Tue, 16 Dec 2025 06:21:39 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:e::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e74a42aeasm39297997b3.52.2025.12.16.06.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 06:21:38 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Tue, 16 Dec 2025 06:21:35 -0800
Subject: [PATCH net 1/2] selftests: drv-net: psp: fix templated test names
 in psp_ip_ver_test_builder()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-psp-test-fix-v1-1-3b5a6dde186f@gmail.com>
References: <20251216-psp-test-fix-v1-0-3b5a6dde186f@gmail.com>
In-Reply-To: <20251216-psp-test-fix-v1-0-3b5a6dde186f@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Daniel Zahka <daniel.zahka@gmail.com>
X-Mailer: b4 0.13.0

test_case will only take on its formatted name after it is called by
the test runner. Move the assignment to test_case.__name__ to when the
test_case is constructed, not called.

Fixes: 8f90dc6e417a ("selftests: drv-net: psp: add basic data transfer and key rotation tests")
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 tools/testing/selftests/drivers/net/psp.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 06559ef49b9a..56dee824bb4c 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -573,8 +573,9 @@ def psp_ip_ver_test_builder(name, test_func, psp_ver, ipver):
     """Build test cases for each combo of PSP version and IP version"""
     def test_case(cfg):
         cfg.require_ipver(ipver)
-        test_case.__name__ = f"{name}_v{psp_ver}_ip{ipver}"
         test_func(cfg, psp_ver, ipver)
+
+    test_case.__name__ = f"{name}_v{psp_ver}_ip{ipver}"
     return test_case
 
 

-- 
2.47.3


