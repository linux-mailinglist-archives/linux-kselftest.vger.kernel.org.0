Return-Path: <linux-kselftest+bounces-48611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F52D0AE1A
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 16:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FABB30DE07E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 15:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D2D35E526;
	Fri,  9 Jan 2026 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOcCxIYH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B113176E3
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972138; cv=none; b=D0Jzv+WJSd3a/IbVfXbUGfWrNqR3qzJqg4ppHtMXMO1Cdm+sA0Rb9zoWBmBEA4dzvv02cZ2eMQEBNRMLXoUFJSEfpuH+RvkrbmrgPn2t4xAaWrX4ZEuLbr3Q2x/uF7eIRSXpO9PxkL7rjCU31gr8yziNEPBS1nzJpgBjF0vrmek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972138; c=relaxed/simple;
	bh=/0dRPRjqg3IHIqgYOrn2vyyviwdlxxFzHDkKNcZEB7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uxX8mP0L57zluyyA4KPkLQoFIcaeYK2CMV3wUI5xWCU0gcudkSWteCgeoPSzVKeTrigmtJEdQpPIkx6YdZ8VpsS1hORV36ljMaH4oHDFPiU9Tt+4M8Vb/NREDS0T7dT1m1tMPi/KNO/3RuP15+lpdgqpZdHqqm7h57It4OxsOqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOcCxIYH; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a137692691so31276005ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jan 2026 07:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767972137; x=1768576937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l02srCpqwS/PPVAYoAwmWqO0txf7t8pnFoogY5rh/QA=;
        b=KOcCxIYH7ZfzPZW1EgMeCaHB8qzTB4V8M6dVzLqboXwd/Hov8grmVhhBnWFEZruIAI
         PMH0+w7EJVtTiszm0ibb3c6A+OO7Fbgdc6nvKgbjcB/ADx8G31SitVtH4IoVhgsx4gvb
         sXkIFHmq2xukww/+00iDj7O+MzukW+exdkkWyyC64XiVGnGYNfn3cvvHzInhciOS9u7m
         lSCrsIQ4YHxdDejbHnoGFTEbDhuoPsCCCRQ1KbvSzb+cS9Yc91uEZeq2K22cxB9sA84Y
         4MUtGye4XgcRrX8rQ/8/62/jgNMMSPOVG4ORPFgv9S9137O29rxrOFAkUd3PXIWZlr4r
         9Tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767972137; x=1768576937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l02srCpqwS/PPVAYoAwmWqO0txf7t8pnFoogY5rh/QA=;
        b=SNHrYCTEgZn2mBXWHKyEZY9TRD5L+d7YhEJkmcBjZ5lF1q7V8i/D6fCs0RskMSBseK
         xS/yXot+D8hBreqQJWfv3ZwYaQGnNP2nzDrnvirXKaXisR0rkmvdfrkvP/y4O50tOoox
         YUtcgMrmahkuxkYTj2ncMSd8zSQ5aT8oLSxIUx3aer5P5vc5ocdMtPp+PqYb0bKReqXu
         /y4u8zfqLuK16xg+gJaR679k5bvA7rE4Lemk8rayZ311j5X0tcTN5BAcdudX/Vv9X6M2
         wJD12+SN5HfFC3xvLfFzk/IOKjoelw9B8Yf07ijgkTzVxf6P4RJYurMWTtxLr84Ii/Vq
         3xdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5AtYny+J2gK30r9TL/m11tyVffm12d6i7ruOVue1DdoIhhQfciOZ1cTM3F/oWpXvTN89lO+XdQSe60KB5VRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqbZywKAMBunR0pdt4XlffI0c1xbYRAhwUfM6DubCxOsUJaXOr
	ZlKhzWh9TQEh+QBQUT7yIgkiUpNVcI4RTem/OQLj7oa4AQdeMX2AeORH
X-Gm-Gg: AY/fxX5o0wKv890Z+zxmxN1dm0Elbok6to1gcxBfQ0sC560/G0L6wa1d1iH5lD4CBeb
	HeIdSYLXzCjwEud+AueACKVyz3Gq51LCjJyIQ4c3vTYoxdCb2bkixeivzR7lMbKcehZCj3S6wr3
	SMoLebvkD7/aUAeicwB+sm8AdhEHY1N+S43hL3GPqkOeMtQmojI2q1pMXhzw7NmeYMknC8gy7sP
	uAjNW++fREIMXYg3ibFUl5Lki/wtboNG1186hLLw3rIIxLTsjf6seVj+3tcu94cguKqLPhTOP0v
	0bcY2UFlvNiC7rE0gVV8Wil3hJdAb+fgYY+fSRK+XobfuXmou60GD5/SqbgyZ7+AAeMrnGdK56F
	kpIyEbIe74X3Uej764nV5kK42cJ2/Yaa1rzAPSjM+Np0rg+eBY2bxyA2vzNNGaOjs8wXKxrByoj
	1+QxR8LLmnu2rFo0+gdRBuXtMU2iySTjQ5Ka3nUsFg
X-Google-Smtp-Source: AGHT+IFjwhs5i9G743dkgLzBhWBTZ55yy5yc6JsaoH2/JUYyPH+SQo8zbecqIuA/7HClY6kISME1yw==
X-Received: by 2002:a17:903:478d:b0:2a0:b438:fc15 with SMTP id d9443c01a7336-2a3ee468407mr97193875ad.11.1767972136629;
        Fri, 09 Jan 2026 07:22:16 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc87f8sm108021895ad.77.2026.01.09.07.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 07:22:16 -0800 (PST)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH RESEND net-next] selftests/net/ipsec: Fix variable size type not at the end of struct
Date: Fri,  9 Jan 2026 20:52:01 +0530
Message-ID: <20260109152201.15668-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "struct alg" object contains a union of 3 xfrm structures:

	union {
		struct xfrm_algo;
		struct xfrm_algo_aead;
		struct xfrm_algo_auth;
	}

All of them end with a flexible array member used to store key material,
but the flexible array appears at *different offsets* in each struct.
bcz of this, union itself is of variable-sized & Placing it above
char buf[...] triggers:

ipsec.c:835:5: warning: field 'u' with variable sized type 'union
(unnamed union at ipsec.c:831:3)' not at the end of a struct or class
is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
  835 |                 } u;
      |                   ^

one fix is to use "TRAILING_OVERLAP()" which works with one flexible
array member only.

But In "struct alg" flexible array member exists in all union members,
but not at the same offset, so TRAILING_OVERLAP cannot be applied.

so the fix is to explicitly overlay the key buffer at the correct offset
for the largest union member (xfrm_algo_auth). This ensures that the
flexible-array region and the fixed buffer line up.

No functional change.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
CCed Gustavo and linux-hardening as suggested by Simon.

Previous patch: https://lore.kernel.org/all/aSiXmp4mh7M3RaRv@horms.kernel.org/t/#u
---
 tools/testing/selftests/net/ipsec.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/ipsec.c b/tools/testing/selftests/net/ipsec.c
index 0ccf484b1d9d..f4afef51b930 100644
--- a/tools/testing/selftests/net/ipsec.c
+++ b/tools/testing/selftests/net/ipsec.c
@@ -43,6 +43,10 @@

 #define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))

+#ifndef offsetof
+#define offsetof(TYPE, MEMBER)	__builtin_offsetof(TYPE, MEMBER)
+#endif
+
 #define IPV4_STR_SZ	16	/* xxx.xxx.xxx.xxx is longest + \0 */
 #define MAX_PAYLOAD	2048
 #define XFRM_ALGO_KEY_BUF_SIZE	512
@@ -827,13 +831,16 @@ static int xfrm_fill_key(char *name, char *buf,
 static int xfrm_state_pack_algo(struct nlmsghdr *nh, size_t req_sz,
 		struct xfrm_desc *desc)
 {
-	struct {
+	union {
 		union {
 			struct xfrm_algo	alg;
 			struct xfrm_algo_aead	aead;
 			struct xfrm_algo_auth	auth;
 		} u;
-		char buf[XFRM_ALGO_KEY_BUF_SIZE];
+		struct {
+			unsigned char __offset_to_FAM[offsetof(struct xfrm_algo_auth, alg_key)];
+			char buf[XFRM_ALGO_KEY_BUF_SIZE];
+		};
 	} alg = {};
 	size_t alen, elen, clen, aelen;
 	unsigned short type;
--
2.52.0


