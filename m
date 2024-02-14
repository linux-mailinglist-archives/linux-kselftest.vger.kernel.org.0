Return-Path: <linux-kselftest+bounces-4608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B758540A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 01:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27EFD1F22D51
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 00:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D1E8C09;
	Wed, 14 Feb 2024 00:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8Yivx0z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6183A46B8;
	Wed, 14 Feb 2024 00:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869020; cv=none; b=eqhxel6mEFebAeoHRanJVGm7waukeZXFAb3Fx5QrjQqkEJrGMMpcXEfOSFgiEyqxwjduuD5irFrPgP3ouqSzGiBcRP4rr5k6GQxklvjYwkSI1CtEwbQXpYjtvIxxGWu9+MY4MNbK4hwmclu4mq/2dv3z36MubjWlM5uE9umUCwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869020; c=relaxed/simple;
	bh=w5VzuQadUGXDHaurnkp1xJatgCg2tWCeQ0RMcYcdwcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VpBzmaF/yl4H09UoN9p9hXvCSUReTB4+xTvwvyi4MMTNdhtQLtRfl2ql0bUFdDyRtWsws/YXP9fPp8UdCpyP3MKSCbysFwJNQz76qyoyaxjnO3XCTt3tDSwzfBD7O6YkGG6VfQVvv8HToyfSzzAKKWcp5xb0IPuHSIMz8zX8Tlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8Yivx0z; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3cfacf0eadso144861866b.2;
        Tue, 13 Feb 2024 16:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707869016; x=1708473816; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GNDHPu7XhKcCz1lLARLwTjps5fYGCjGiEa8mM6D458=;
        b=U8Yivx0zAHqLDZbhgbfrB5k1MieveI13i4E/O/tOsxBMUe1nUh1mBZe6nl43+gpz2A
         QGHoRUjDuLcpFgOkCFxmishP2yFLkY199gEm7MqBnx8I2ITLUjrHibliCyPvoeaJawoy
         8COR1NzHWQuMwcSl7ssQ5tLy/4a+ReNLLkwolAkRD1eVruq/d5ya5monEkDWp5K7zD8A
         cTC/Rg/bU0zlgMFqRMKLimQI1vzVZ2P25GtgPvqVHB0zTQYnabAdJIxUUCIIPohSnXy+
         SZOC2wzAbukY9KcWtc3jOntuLAt8fAGf+f+tGTInyEDWg+EJZEtJXGejpSiIPVyH2WgB
         omXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707869016; x=1708473816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GNDHPu7XhKcCz1lLARLwTjps5fYGCjGiEa8mM6D458=;
        b=uL/pFN+pp6i+PQ6pBiAO21W6ZUL6lIVMYp0C7Id/mgUtOoeOr2vxqH1534hhuS6Nhr
         DN+sA534GAm4gwtNDxLP/T4m0mvxBfQWedKHOXeDqltgBnAVxkk3rKyaAG9j4Xkk9oWW
         i3U4TnfdWcxsJKvUJ2hPAgx0Zurj/I2J6D0Mehxu7M7VWWEgKQ8CqT2TNWAE2MQgFue5
         tKhgZ6tgZ4Bfq3rmfYeibU09akknwzqYwlmET0C39Qo4V9LpKSMtd9xmrAud2SFQ+KoZ
         7nUi0sH1XBJYSJ+CvF/oKQPYYYqpxzc9UlOFXw7KUVVHoxucMAUQEBoN1yxuyOsaLTY+
         32FA==
X-Forwarded-Encrypted: i=1; AJvYcCVNgZXBNd5tJpvN7hc0pdtgNhpVVRAlcqLBZiL4gLlJ4+7C2RzoJ4wjBPAQUWOpIBWz3VIF4xZMQtc2CeOXZnfCLmw91yOI1XnIiaQkdypU
X-Gm-Message-State: AOJu0YxdAEjZkN41zzpH55WzUgqHk6GhNW6RhMgb2Ipr22zYH6J+NrZT
	ZMOTLvCQwSH8OaZfYaDnT7sLAmTGbY5y+gYpz7NAxW22zix/9X/q5Gp4/j+8qM4HdA==
X-Google-Smtp-Source: AGHT+IEKfzxEhMeRFX6rTQzLFn7UAg7u1zxtJJ7dS/pr7WwWDpxlPImwCRXTLyQ+MAGsPySRT6lhNw==
X-Received: by 2002:a17:906:344f:b0:a3c:92c2:66e0 with SMTP id d15-20020a170906344f00b00a3c92c266e0mr577096ejb.64.1707869016343;
        Tue, 13 Feb 2024 16:03:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXNtwUdg8vSqfxr0+0rMr9p3A5JVfq0wovd988RgQvzUKdKpHUO6h1RNiZQwRt1302PtW0F7oU4PLtVRr33miVDrt6anRpkkar7ETelrQuNyodMZq22eR2TQBz964gEv+7OQaSLAFo4uI/cRpahJX7UfCRvoi3I/scx8D1AnsY=
Received: from [127.0.1.1] (2a02-8389-41cf-e200-68a7-7041-4298-e66b.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:68a7:7041:4298:e66b])
        by smtp.gmail.com with ESMTPSA id vo10-20020a170907a80a00b00a3cfd838f32sm1160901ejc.178.2024.02.13.16.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 16:03:35 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 14 Feb 2024 01:03:32 +0100
Subject: [PATCH v4 2/3] selftests: thermal: intel: power_floor: add missing
 gitignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-selftest_gitignore-v4-2-857b39cef2fa@gmail.com>
References: <20240214-selftest_gitignore-v4-0-857b39cef2fa@gmail.com>
In-Reply-To: <20240214-selftest_gitignore-v4-0-857b39cef2fa@gmail.com>
To: Shuah Khan <shuah@kernel.org>, SeongJae Park <sj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707869012; l=738;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=w5VzuQadUGXDHaurnkp1xJatgCg2tWCeQ0RMcYcdwcE=;
 b=Usiw/ybeuPBKFgZtt641rMXHo0HeUVVBJ/bdsanaTyN/1qNkyTq8+YZMvtM3piyb7lPmYkDgT
 t6hknwFH/k/AfjOZjfkWuJjnxss2+XV6M5KxEDwzWNd5hUVVC4J3eV4
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The 'power_floor' test generates an object with the same name,
but there is no .gitignore file in the directory to add the object as
stated in the selftest documentation.

Add the missing .gitignore file and include 'power_floor'.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/thermal/intel/power_floor/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/thermal/intel/power_floor/.gitignore b/tools/testing/selftests/thermal/intel/power_floor/.gitignore
new file mode 100644
index 000000000000..1b9a76406f18
--- /dev/null
+++ b/tools/testing/selftests/thermal/intel/power_floor/.gitignore
@@ -0,0 +1 @@
+power_floor_test

-- 
2.40.1


