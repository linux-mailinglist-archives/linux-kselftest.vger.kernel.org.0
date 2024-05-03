Return-Path: <linux-kselftest+bounces-9343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEB28BA65F
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 06:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA906B20B1B
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 04:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2372513C9B9;
	Fri,  3 May 2024 04:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="osLlR5bj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A481A13C91E
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 04:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714711638; cv=none; b=q5nEFqX6NZLhciD1jdIbdbfHfVtgJLaNmNbCJlw4Ta/8OBZHlQsd5pKMq3x9/FGQa8LqZhlUNe9BF3OVLnoIE/zoWoBTuuf52Ea8EX02UhlIfPXy3PJwo5sQMr+S/OqmKpbiR6S0alqwUbntCKXk08semoAjHsGRpABQskoFUXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714711638; c=relaxed/simple;
	bh=VVos6nAzmHOy7EOA1ppaqJ4Dx+U57WxCTD6XuCvS0Gs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aq0ilIxNGwNBauVC5kmf0nmaQkMKfN0rore4Hkq/9XYYZUTbdWL9b+6ffiQGsU2nPbUfKjJjjSz0Gtrr/krwsdY1O/4iyTXSf3u5ozKthOt8jS7B7vahcNFwseLnAPm/JTOKE7JGC7Y3WwG1Lgz40vvhhU4KTJFRlzehHUQiU90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=osLlR5bj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e9ffd3f96eso72684085ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2024 21:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714711636; x=1715316436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3SjbYRlfVLcKXzSMNjYRrKo8hPdxAu3bA3GNGrI0mQ=;
        b=osLlR5bjV8se4xC41aJcjcabDbsnc1Dt8k1cKHqSrJvzXZpRYSHu7FE0Wr1Gl5Ud1K
         9XJLm64ZfCWeKdsSjTT6Z/uqeEqPo214gVy/b/oSBeQQaZ1SvuG+I2Gure9TY/NDCzc4
         1yrnxsnZFKzDJsuRPPyRi3/yRctkNJHmYRcOFHFcPcpro1O6WXi4X6wdFCi1nKrLpsWn
         +2kRHhAuUsm1wOndhj6IYbqbtwk7tOdEpmdxGf5/d4wc3tcDGYNo0DVUg5J+FZpZbZIZ
         TNu5BJUNFb6m2LSkv/e7Vj3NSkLJNKbLEQv9TUQPDIF81wXCEiY8d/P/vLOwnI1RMQd6
         SKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714711636; x=1715316436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3SjbYRlfVLcKXzSMNjYRrKo8hPdxAu3bA3GNGrI0mQ=;
        b=FlGtdNgArTcPZn5sfiZG9+91XD0C851QKH0YyK1lyfvZZFmIPv4D09tXSh9vClRymJ
         1dz2+7Q3jETddP4QRrB13cjJZRskI6JDPawSLC3MTyJ9mJh0Y5iAMyEkzFKTPotFZH0r
         J3MjKO49MoTbcujrWjEKuRhoBB7jPtptr4Opf6r2hsLRlHOGyu0DNhAyzluT2OK0PHQL
         pxF0wTaYhedYFUiOOnD222cEvV+HgFtZdT2ctxZkbXIsX7Vp7QqoZJr04EY+vIYlktZR
         Kp7yEreGS1nit1HoJn3Q6cxJCYz33oZKkFSu5XFzFZFaD9EoyZ9mAh6YeZM/gOpeiLd0
         khxw==
X-Forwarded-Encrypted: i=1; AJvYcCXLcPa17H2kI6RdJEUmBnqrwt1XjPtY7+bzi9bzS0gdkFkH8WDKjmOrkAvVvDCJFQiU4M/GdNd5k0iZYwLZfaLzwmtthz5JljG8PPe9hOHC
X-Gm-Message-State: AOJu0YzF6CHqb5TPT3yt7mFvfnzxUvQAY2vTFPie3cNKwseCdkvr0ly+
	uywc8ULHkV1m6dfO42ym21nhbw9i3IPc8qesrYMczDA8I8aeVq+kir0EPjg2oC8mYbsBS0KzqfH
	S
X-Google-Smtp-Source: AGHT+IGM/dp68WsaICJolpFnJ7rVWv8zpuJnZkNE7iR04J0tEr/yBdhTSU5oueJaXbYqQhfKWlcWFA==
X-Received: by 2002:a17:902:d484:b0:1e7:d482:9e09 with SMTP id c4-20020a170902d48400b001e7d4829e09mr2156048plg.7.1714711636126;
        Thu, 02 May 2024 21:47:16 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090301c800b001e2bb03893dsm2240411plh.198.2024.05.02.21.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 21:47:15 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 02 May 2024 21:46:50 -0700
Subject: [PATCH v5 15/17] riscv: hwprobe: Document thead vendor extensions
 and xtheadvector extension
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-dev-charlie-support_thead_vector_6_9-v5-15-d1b5c013a966@rivosinc.com>
References: <20240502-dev-charlie-support_thead_vector_6_9-v5-0-d1b5c013a966@rivosinc.com>
In-Reply-To: <20240502-dev-charlie-support_thead_vector_6_9-v5-0-d1b5c013a966@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714711602; l=1205;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=VVos6nAzmHOy7EOA1ppaqJ4Dx+U57WxCTD6XuCvS0Gs=;
 b=6na65VRDMTnnCy/+6CqiPA9pKtnlM1Q98D2vcAEWM2LB61+5gCXnut4ekMn7J31diUbqo7FHE
 zcnD9r7WgrtBVI5ezwnTpIeMoEFwFXIDsE30Dn+rGlOO0XYaU2+kgye
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Document support for thead vendor extensions using the key
RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 and xtheadvector extension using
the key RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index b2bcc9eed9aa..b2bb305140aa 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -210,3 +210,13 @@ The following keys are defined:
 
 * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
   represents the size of the Zicboz block in bytes.
+
+* :c:macro:`RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0`: A bitmask containing the
+  thead vendor extensions that are compatible with the
+  :c:macro:`RISCV_HWPROBE_BASE_BEHAVIOR_IMA`: base system behavior.
+
+  * T-HEAD
+
+    * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR`: The xtheadvector vendor
+        extension is supported in the T-Head ISA extensions spec starting from
+	commit a18c801634 ("Add T-Head VECTOR vendor extension. ").

-- 
2.44.0


