Return-Path: <linux-kselftest+bounces-17474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E003970EE3
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2C81F22A24
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A4B1AE84B;
	Mon,  9 Sep 2024 07:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2p/Cs6p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C2C1AE845;
	Mon,  9 Sep 2024 07:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865703; cv=none; b=P9u7zUrdD0lPi3r6Fyj/LjaKVph6EFS1gs14adzcb4Iy5Ix9lyZtAJAKOOuEEQDJPKUqHGPeE9zOYD0oVzy81BXehrwWIfSW5rz1Zdmju4af6sEPCuxliafFrw45AupgqzUsOL57b0fwgyJRnKGM6BVYrjHYHJdAUcZts86nLeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865703; c=relaxed/simple;
	bh=1U0hmGZ4pOGyuQtP3rk/Vzanpq0gsss3Giyw2VXlUys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/IXxTiyPYkf+4oPAwXQFgXZREbjcyg2DAjtyQJQ8N7md6ICVZzOJaHs/+JS/z+NWZFKX1T2ceebzlvJbwtQQ+4xuItFzQj5fSeK0DlouyKaR4gy9cm9vAmv4kY3XJz1cfHTFqNGQNLrIufZJk4aA55PI6S05wo5lybdTIp7Xb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2p/Cs6p; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso17276335e9.2;
        Mon, 09 Sep 2024 00:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725865700; x=1726470500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRfmK9XiELkgvke2KZ1pLgHNaRcKS5bA/Qy7jNwAfDM=;
        b=M2p/Cs6p6zbwfvl8FJhhftyKbkcWy4L9XCJoQKTGNVVL7wJNkKAWKXgwWcg/7Q2Dzt
         vq2B7ii1SJ5v3oE6lZxu6yHutcb4VQA6ztJlu20sHdKa9s5TTLl2t15uMSBVdohinw+s
         KPprC/ZLiyI1SH64N4w2bj/rOib6qb+GYbCUb1MIzG/WuSnhedL7ZaLE2mnOG+VP8o/3
         7eSfGFax8NsLCVxUFWz9nIq7wAy2NQOQ8EXjBCc1zKlqAam1MjSnfM2Vtan6HWZ5bA/Z
         iHPTsSxj0g/ZEKkgbBsehGADn/TXrKHJcDRAckh7PEb1N68zKe1Vk0YBGuYvSQj76ZOg
         PEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725865700; x=1726470500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRfmK9XiELkgvke2KZ1pLgHNaRcKS5bA/Qy7jNwAfDM=;
        b=WYijVh4VKDtYK44ta7llIX/HHrIB+af/9+btFVQ5/V4hDNRfA0deRsbF8KdMCYAiRn
         Jx9LHmkjPJZe4+Crw+Np3Vv23gD4TDX2SgK+gP6WGqY19po5/SZkJADfwtzFtB45Z8vl
         JAXiPinpaU/sRyCIHTQIPIHgIJfXJCP4fl54+txexcY2UBa74VfP/0YYFQfjxJIB+Jhr
         kCQe2Xn7XGNgsLUZw09hzBmytfmn331gtbkYWMjB8VDfSUdQYK7lcb2ap5GmJmuTluum
         mr5cu3aR5dZgP9P8A9Ff5MxNjFHm6VLny7eeCjVM/E0RqJOqHinKCZGk8tfyAkJVt4QP
         8znQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1BJKpr6wH8a7udXIm0V++VBIAtDO8Lly6/GXPxob5mW5Jt1GfzWSy+nZ/vCgAgtYzi6OEEEJMMh+p6W8=@vger.kernel.org, AJvYcCUXw/ebTr+2mA+USbul7MQvoZxewVQv9dfTm8tRJ4dKGFFRf+xRy7oEXcTGbnDc9YAEvwlHI9l2V32Cs322@vger.kernel.org, AJvYcCV+gDF7h6PEUZER42zpQaBaZ5OU38SHtGs2fgJX8UQI07bBAR0+6otq4VWUEcOMTYDiHLyoIsDZn/3Vkg==@vger.kernel.org, AJvYcCWxysS23QiEch+iZBjjscbPuo/EfcBFzcWslpB6mtC0Bf8aw8A50ucibRIZmI9VNJ6QX0E=@vger.kernel.org, AJvYcCX64MuUpOl1G8lEmuIP0ALfsJnBdwCY8EHW6mv0vn/1vlr+3s7fdLf78IhqzR/aZ6WdiKZ21ps5p4cJ7V8cKQ==@vger.kernel.org, AJvYcCXhetI59ZG4nj3MCV98+Dv4d1cHQjXhUfu+gU3jOZBD2PzDXPkZKuqXKQo/B+rbmydGw8QfVVV1o1vwhaV9Q0dX@vger.kernel.org
X-Gm-Message-State: AOJu0YzXPMunYZ7fkTw8BRiaiCZBWdKS5VQXG0bkg9T0XF13VAM6wq1S
	7i47HZv9lhFAHf4aSEW9OorRKRPuQMTzyuSVbaQuGPlkUWY0kRZY
X-Google-Smtp-Source: AGHT+IEQzX2PbRsNpI7OC/KJTEmDR4766NrwIckhKr3JcIgfhLZTDniK2o3Elu8rKu52YDTKEqoecQ==
X-Received: by 2002:a05:6000:1566:b0:374:c8d3:5f2f with SMTP id ffacd0b85a97d-3789269e55bmr3943369f8f.31.1725865698964;
        Mon, 09 Sep 2024 00:08:18 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d375asm5178754f8f.66.2024.09.09.00.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:08:17 -0700 (PDT)
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
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH v2 02/19] crypto: testmgr: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:05:16 +0200
Message-ID: <20240909070742.75425-3-ubizjak@gmail.com>
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
---
 crypto/testmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index f02cb075bd68..eeb7edd99a93 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -23,7 +23,7 @@
 #include <linux/fips.h>
 #include <linux/module.h>
 #include <linux/once.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-- 
2.46.0


