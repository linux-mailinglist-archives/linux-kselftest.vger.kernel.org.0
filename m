Return-Path: <linux-kselftest+bounces-43522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 634CBBEF3E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 06:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59F254E9FB9
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 04:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D498F2BEFFB;
	Mon, 20 Oct 2025 04:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JAwoh/o3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2A62BEFEB
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 04:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760934089; cv=none; b=T7nSfxLs9WlnQIJuV/bwXcNIw+SLYctumHnVo6jWg69/iPrxq8xxRT2I4GIlRM+8/xQeZvxHbVBBRTHNm25+LFtwBVUqwXhvgiq+dtHawG1VBDZmiB0jKd0Bl6J71q1s6r3tCdyLRtaNBpqn+E7hQ5r5UudSBtF8sPOOMUn3V/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760934089; c=relaxed/simple;
	bh=+YpuvhJCI/yShT1rtWNvOFpxGI7l/ehsFRhKIaNPItU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2wCz5DcrF3AocJMmHty76ESEHAMqDetw+8kdd3lfvv5dtZe48Fqpt5Hp2INalJakery6vcupDuPwbcwdDhcmRqJhEzAIR47IiqVbcMzJxQ46fDZDxIjZFapT8QIKKtcGIK0QCpQLNUCkfDtWXf6c1hLM9UqOGKruxyoOk8sBPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JAwoh/o3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27eec33b737so59773505ad.1
        for <linux-kselftest@vger.kernel.org>; Sun, 19 Oct 2025 21:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760934087; x=1761538887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcpuRb5Zady/Ndj7TK1NVXuo7wdyupAjCmRtQU7qg78=;
        b=JAwoh/o3l/iy2sFi1ugjUdmHcjBCKevt+8mUOi1sqitp2FwVzGYui3vaZBOuiytuPT
         e1QgVvpp8M5J2ent8fcwzPtqA7OxuFbUDUYhKVO4Kbhp96nSM5O5t+VXW7j/qC2NcDx2
         6xEbZ5nnhwBGTMxHfwBZjfhnuuljD+Z+WTzEz/o9N71R3A5ar1111AqE3jcJCEJR6AlT
         9QI0q9WlWcKyNqJSz5mApRiEwnVH2gndZhW/zopueiEBRED1jTgJchUZY93SftSQ94C/
         DDQVY/VCrnTGtWXCarpbGgVly96YeFbemv55XWqGgSmoTT4c0Cz0A2LCvcZp7DK+9Sc9
         KbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760934087; x=1761538887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcpuRb5Zady/Ndj7TK1NVXuo7wdyupAjCmRtQU7qg78=;
        b=uJhcckjWaKq763seXZZipUZVgrZwS41b2qyElNta0MKqJTMOJ3t9CwUYWlzSbBibxI
         3f+58IuUcdv3S79u1/58/bZt/rBXAa3SPPHi4KbkVvQeafJUdRdzf6+S8kbQQ8Sl1M5h
         tTFA+88qrEkhwDSU/O7DTmK7XsBg2IkTAmkDsJ02GCnZt1yhpfJA1eJa2WN1iH5W4P/C
         NAbiY4tsvwMoXcY2C0+9D8Qphs4PQf3G/+oLcVQJVZ1pknSuEVsXTvjEozIPKejv69wA
         ybIXjfl66zNS71TRdn/1plophsHr236Cx0Y4hd0ZcE1L796BUUR4cTIDA9pjeD9fLtAZ
         Tx7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZJBlSbmYXt8oogzXhu8lLufPTDH3W3h7K0Th1aeIrm6yOZxXDLWobjeuAVDTSvxpeKJOoS0crIts1dokzKLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw49FUSsInQYKUlQ73QUq+E9cpcRzz0TWQ9H1nXzugRxBXvTL0
	Mi03Ac8NNJ7fTEFCanWXwbulb+W7HgqoleaAGSwUjinh7Q0jMt0JVzfZi9+beP1tL7E=
X-Gm-Gg: ASbGnctv5VAA/kDXqc/o3B38jTQBPdrKiMdzCC8FiWjaJsCcjVeFWHl16XgE3uPP2Yg
	d8N8kIiCGvtc/A+7YxzWiG01tn+d5ljZrSVBSNGy21cAfJgM6Gskt9yGemz6fKEXHXtBA2mrzmS
	M5Q2aZZbUHkXmPSKDx6Kn9WkhqyLAQNEwrsT0/sw/eKZr8ggCN7IgaGkyQPlo2MBdOz3BdRJc8K
	8SdjfT7MF3AobYK0ZNW6B6QpH9lEeNU+4EDDAGATQ1hBR5ymAssHKEDDfAZZxAW/t+CxIWCEDsn
	qQD7dEC2vFBprO+L7jGieVOxXWp1pOC501dUeOnR02rCD/06u3SWLq1e6xBfQNQukpLQwiYsZMW
	12sBk8WJGubOq+4C9QBSGPw6QyRkOx1acHpCw8RBViS4CNzpIsGrGkNmC4gMiT2hTAvTOJVlH0P
	mPDrSSo5Kfcsg0ClrvkxNl2amTTfNQSLDAmZkFgXsCXJjLnksF5mS9dFPYJQSHBEpyX3Nk5wIlS
	g==
X-Google-Smtp-Source: AGHT+IFwTwTOglfCAcnv2eeIJKbKLKoLeYRBKMVD09UkBscMOUOH5n7kgqBF6beeLtv4Tcs3gbZbaw==
X-Received: by 2002:a17:902:db0b:b0:264:70da:7a3b with SMTP id d9443c01a7336-290cb27af60mr170024945ad.49.1760934087485;
        Sun, 19 Oct 2025 21:21:27 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ec14e9sm68762035ad.9.2025.10.19.21.21.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Oct 2025 21:21:27 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: corbet@lwn.net,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	will@kernel.org,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	mark.rutland@arm.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pbonzini@redhat.com,
	shuah@kernel.org,
	parri.andrea@gmail.com,
	ajones@ventanamicro.com,
	brs@rivosinc.com,
	guoren@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	lukas.bulwahn@gmail.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v4 02/10] dt-bindings: riscv: Add Zalasr ISA extension description
Date: Mon, 20 Oct 2025 12:20:48 +0800
Message-ID: <20251020042056.30283-3-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251020042056.30283-1-luxu.kernel@bytedance.com>
References: <20251020042056.30283-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description for the Zalasr ISA extension

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index ede6a58ccf534..100fe53fb0731 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -242,6 +242,11 @@ properties:
             is supported as ratified at commit 5059e0ca641c ("update to
             ratified") of the riscv-zacas.
 
+        - const: zalasr
+          description: |
+            The standard Zalasr extension for load-acquire/store-release as frozen
+            at commit 194f0094 ("Version 0.9 for freeze") of riscv-zalasr.
+
         - const: zalrsc
           description: |
             The standard Zalrsc extension for load-reserved/store-conditional as
-- 
2.20.1


