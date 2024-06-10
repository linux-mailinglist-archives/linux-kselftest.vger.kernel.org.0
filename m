Return-Path: <linux-kselftest+bounces-11618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1D7902C09
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 00:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6E61C235F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 22:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5108C155393;
	Mon, 10 Jun 2024 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QLbzE9IJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5463155335
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 22:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060223; cv=none; b=OFV2L9KK0L3X7mGBUJvYP3EcO5IFEYDvzooRx1Yu96R5mzAyLs2YkfUcRAPAg4IkKEzf8ae4yF+Oj3ekxWFk/QhxvTJdLQ+oAZJ1AHfkTuE2+qMT8GWwjz0twvVlPBaoH0Ng9b2gKAJ1WPV1ij7Lc9l+Y5oJswL+5m6HrUeJcr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060223; c=relaxed/simple;
	bh=YRbwjAEMooOC1Wqfne0YGBAOlvdWm2exzND7IqGSDDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FLnHeJGlX3B3RVF4jguFIa/KVwYROdYawSfKzJw9jPfji7n2FwZEz2wshaboEEZqnPwxhshdtAaHG0Q/2VwD+wKn8MtyINNebwaMYBAQJvUK0G5WuIFA6OFce83HAO81tw35n4u8loeLeFDk8I1Y2GyWlj4r6vgd0kOhU76ElMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QLbzE9IJ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7041053c0fdso2385614b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 15:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718060221; x=1718665021; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HBSOfNpcERRo+IfFfSUzbZmQ8OANKCSab29OA8NgQg=;
        b=QLbzE9IJ7OiNESxkyeN1jywesSy/24mBAcn/dMJm5hjMlCQrj2whZAXQMAJPXcgVsa
         /SQiPwbNkE8nrGXKwph/gRfUAnZ/GaHCasjqZqBXald9FcFRYWT2375bMbI04oe9Vw83
         pw9gFjxyMjyqdbPPxYK77e1j0hQderLwYXUNaTqY1ySapba15lnjwomBh/etwMcfUnQy
         FBuFzNC8G5sekaAl4tw+v8DRK/DC7DFLtmscMwP8wMEjNn4dHxqjh7zBoczo+rjuh7/T
         0Zr4zsbTxDJTJOaCECWEw2oiqxSh+uYNDsjYT2FtMkqagohWhmbqlpVUZMr8anM46DJ3
         Znfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718060221; x=1718665021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HBSOfNpcERRo+IfFfSUzbZmQ8OANKCSab29OA8NgQg=;
        b=egxBLG/mYecf0wI/9TqfltEcLuNtFzEAZKYSwVGfXpK8imU5+PQdLRGnf+snwl8vnN
         ld7tI232uY5CiXkv4u/tg8kyuqpKSEbxVUCJBW1ex56bFifrfq7vqSJ5/aDphXYraRBd
         23JIw5GSA4dKZkE2IY1qteWAYf6JnVLIVRyLYRxftnxcm9EbryXsWqXBvwrcksaIgDiw
         Z94rrbQbNRpXWbZO+OZyRqFAtVdmM6Tm0qz43+oIO3KiA+m5T35uVPxAejGfaGDSHZQt
         /nu5KmPPoFhFQgcX3zGmPz2AeYHazLkujwlRh4c7vZlaNZ62RFmEG87gFOEarM4ob2eX
         iEdA==
X-Forwarded-Encrypted: i=1; AJvYcCVqwUJyR+oSh7kFpt93T7dP8IzhSLbdouq830rG5CB7suRLHB9gcL3RnPwkRjQ4Dyt7vQPbMCT+aFmue1/+np2wmCD/Sxv/c0ODZpbv9AIA
X-Gm-Message-State: AOJu0YywhriNu32f+bs6Pfi2BFXTFzt/ILk2nGC6N2202LVREijVzOqn
	NCcf/n03ClsSvacnD06GRTWYKXqlEjUHSfSxPlPfH1Mc9Jr1C7WcNJIu26gn6Ds=
X-Google-Smtp-Source: AGHT+IGIZbpFLMHE/lJ5GbefKME8Gn68phzhUe0FaeJN8+1dFczSl0GMa6MPZKO47tw63mwCQaqOEg==
X-Received: by 2002:a05:6a21:9991:b0:1b4:772d:2885 with SMTP id adf61e73a8af0-1b4772d29d3mr9114268637.3.1718060221031;
        Mon, 10 Jun 2024 15:57:01 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f71b597072sm18355865ad.99.2024.06.10.15.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 15:56:59 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 10 Jun 2024 15:56:44 -0700
Subject: [PATCH v2 07/13] riscv: csr: Add CSR encodings for
 VCSR_VXRM/VCSR_VXSAT
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-xtheadvector-v2-7-97a48613ad64@rivosinc.com>
References: <20240610-xtheadvector-v2-0-97a48613ad64@rivosinc.com>
In-Reply-To: <20240610-xtheadvector-v2-0-97a48613ad64@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Evan Green <evan@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>, 
 Jessica Clarke <jrtc27@jrtc27.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718060203; l=706;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=YRbwjAEMooOC1Wqfne0YGBAOlvdWm2exzND7IqGSDDM=;
 b=BM5m5V/nQRNhZjvOPuMabe0KTvggdAN05fZDbXe+2vVdatDi9tChErTOUmlzrP1AEH9N7fbby
 PcLGUrn7jT5APulSOlHctEyjRk1D0HhX5Gm8tzJtZGG2+4QDc9oh7fv
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The VXRM vector csr for xtheadvector has an encoding of 0xa and VXSAT
has an encoding of 0x9.

Co-developed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 18e178d83401..9086639a3dde 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -220,6 +220,8 @@
 #define VCSR_VXRM_MASK			3
 #define VCSR_VXRM_SHIFT			1
 #define VCSR_VXSAT_MASK			1
+#define VCSR_VXSAT			0x9
+#define VCSR_VXRM			0xa
 
 /* symbolic CSR names: */
 #define CSR_CYCLE		0xc00

-- 
2.44.0


