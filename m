Return-Path: <linux-kselftest+bounces-18374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0E29868B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 23:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D63D285215
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 21:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66242176FA2;
	Wed, 25 Sep 2024 21:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWossW7u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EA21741FE;
	Wed, 25 Sep 2024 21:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301326; cv=none; b=LVrgGuhRBJ9V8RErbOSOTLCgdUdx84wsaIlvOEsRBIHTbseeXbkzgvFHTo7sncvZIJksP126y1vkPpXg0aDjI1v6ykj56gouNr0iF5gqvB+gfw1xj1nbGjNwX5obnbrdL6Bv8rZk+EdETIkFl2TATX/3GUpQLIWPrrXWnf7ZMyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301326; c=relaxed/simple;
	bh=GhQP3J2nKwfiXrLOqCxmXd7UQTbYFkQpLCYaHd5lsPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uALazfsNF8oO2dUJCAVEeUotVKhgLc3qEqHECdE2IkX6z8jNy6LEOJ7qoOIktpBPI0m7PU+STknvGxExhuPJ+oekaG0gwKAjWHkryBnVBcWGNrPOx17/lDzEaOzuvcFon47ebBQWFtJSbffK/mo+CxFwCbrbmdTpISInsuqYf4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWossW7u; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb1e623d1so2565865e9.0;
        Wed, 25 Sep 2024 14:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727301322; x=1727906122; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DvPOQYJRyRd7U7aH4BgtwF0snD1det/GMDLsQ3VXPSE=;
        b=VWossW7uFXPeDJ7OZdqnvePZQ6T+hxX2+6koukKSFdlelf1CNdp0f0KQ9ds8vNMKiq
         KepMSo1fDy08U93MtbujXlsuIWsyChEGR3D8pp5uFEIXWCdAe1r4xHJQb33RZ6z3Zz1N
         4pbv6R/QKFvkjnBdkopCVSZtcgCL0oHUgnr3dws6j/wlsfBmpmQWtqrg2JxWhEseAj7P
         ZQCPYsIhzfldpKXaVbXje4pN6RYW5d0JpZFVOfraFCZOA7Dnoigxheg/R+IoQLfSL5/9
         3bMH3wrLkhvRQtJCG/s2/tLxsFhDr4gEs/Az1ION+TTEmeQSICVJpWe5RhKRC7MfCTrt
         +2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727301322; x=1727906122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvPOQYJRyRd7U7aH4BgtwF0snD1det/GMDLsQ3VXPSE=;
        b=YCmTJd96AMFE3bh/Whg0wbZg8TSkENp6kpGh52qn3PHB1xRkI4SbA7IDjmblG9rGre
         3MPPUWBr3rehi6YC6LkjlWtfXdpy8p3jreHrAhSha8XCvvGwiNUtfpKdSLargewMGpS8
         PuR18qd4AquDcFObvOfJS15mH2H+yFwX2tnsGrHSl6tHCePNQBaf/nu5n5zQ5ahASgJ4
         Tu7tJvVYmoTE1X5AdEyVdNQdoGBkomZk4jvjsf9l7i9ylGfaepC1SlTrMfCWKz88hXzj
         MeUgHfnRyKZ6ByotKv+K53IlUbKaPOXw+5VvHHzMa5CEh1BBCySPX4A4n5Iv9Yu/5X/L
         CwwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2/u1AtWPipOwjFwbUACpMzU8AXwOP5/IYnyvTYpaBZHvEWJtMf8yyuHLrLWr2GjpnG6kQpB75Tj48oQ==@vger.kernel.org, AJvYcCW/gNc0c2F2BinH2+Qsr87P4u4dYsaZ0p7Ka48q/v637gHDBE6rDh/k52tjP6ESmU/a26XWwLz8@vger.kernel.org, AJvYcCWdbd5D0oJoZ0YnP/IEcR9ONyNS3KoAhSPCQ/s3qFTTPv+AeqB8/Pj07QILN17u4ZdbAI+/kMB8SEUCUHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6SFkr797eh9qvsnuaE1iEaNC7h3/ZxFHLCzmz9pP6eG7DQrkL
	6Yu5TwTtMM4UtJNHgSrn4wT3I9n4cyo2pglVyWs3U2LZF9Y3jgm5snWm6HY6
X-Google-Smtp-Source: AGHT+IHSjnCpmYE2jsBZh8NoFgnXuuwSbgd4y2MTbQ5HYjU7j4izubwfPMa5SBZXSGo/SUyyhz5Pug==
X-Received: by 2002:a05:600c:1d27:b0:426:61e8:fb3b with SMTP id 5b1f17b1804b1-42e961362f3mr28765395e9.27.1727301322442;
        Wed, 25 Sep 2024 14:55:22 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-370b-ca26-d622-f1c3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:370b:ca26:d622:f1c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a165fdsm29129385e9.34.2024.09.25.14.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 14:55:20 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 25 Sep 2024 23:55:12 +0200
Subject: [PATCH v3 2/5] selftests: net: add msg_oob to gitignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240925-selftests-gitignore-v3-2-9db896474170@gmail.com>
References: <20240925-selftests-gitignore-v3-0-9db896474170@gmail.com>
In-Reply-To: <20240925-selftests-gitignore-v3-0-9db896474170@gmail.com>
To: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Allison Henderson <allison.henderson@oracle.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727301314; l=629;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=GhQP3J2nKwfiXrLOqCxmXd7UQTbYFkQpLCYaHd5lsPg=;
 b=cNxXiSWi3vOnhwZaNf7MAFrH6iT9+k550CuhHSUih074ea67POJPnpJpESipibG2uiHtalD6v
 xJYyD3qlUqcB579IuFOrDTVdujgF6r7e/4q9w6dNQiR6jv1PEIRiFQD
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This executable is missing from the corresponding gitignore file.
Add msg_oob to the net gitignore list.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/net/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 1c04c780db66..9dcdff533414 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -17,6 +17,7 @@ ipv6_flowlabel
 ipv6_flowlabel_mgr
 log.txt
 msg_zerocopy
+msg_oob
 ncdevmem
 nettest
 psock_fanout

-- 
2.43.0


