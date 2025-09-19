Return-Path: <linux-kselftest+bounces-41909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3418BB88352
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 09:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21D4F4E2B4E
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 07:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7812D7DF0;
	Fri, 19 Sep 2025 07:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ILMwbVmv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A1E2D6E44
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 07:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267472; cv=none; b=IE7is77Xg+PN8Df8G9JrA7qcamArwex80hKL92HFgopNqEaviDElQsdWZPKLd2uMVKXgyR9W9Ji2Z3pLr7YSj5AKWv/P3ngVAStFDrkQnjrjNblDiXteQKTLcJmGt7l+4DCG3MTEam/aBHXKqZLcLcgpt4+fHLpkyk60VQG3xXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267472; c=relaxed/simple;
	bh=+YpuvhJCI/yShT1rtWNvOFpxGI7l/ehsFRhKIaNPItU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkylIjFnpn8jgf1+V/7Oh+a5aVXY2Id4KT5s225l6ry5i5r/cgaGjQt5XN6O+tuKG2OPlTBaR40M3/tdcsyPiDOJk/G2jL9x1YUF/6Su/R0MK+5V0emhNA35kSNUMSHEEjfhHSZG9rwgxP2VsV1IrD3JR4SWAi85+M/3snbhirQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ILMwbVmv; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1793240b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 00:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758267470; x=1758872270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcpuRb5Zady/Ndj7TK1NVXuo7wdyupAjCmRtQU7qg78=;
        b=ILMwbVmvePhwb63VcL6xWvyq86V2LqZ5vXnadEgJSykWDZwrQbtAnlaKSLd3nA6aMV
         jjV2urD+9mkl06Sa4OQeeh7HWIPO0kMaFmaEAXwdo2FOU60uZ4RIqvqs0I8QlAOBoBxT
         9axFeZevbtti6CXIFJ0keSVca9dPy7hVEEoe1iHCa5009KqC2o7FtDiXeVWQUJOJUvZb
         Lt1y55GTQZmmN1H8cm3gYunoYcwbpSViiSdjlmuPTwSpG+TvAmJzVz6zuk9aIX2gMFCj
         0auPMTS8G7O/CtzigwFHBUHWa9W30oulwiCRzilvQtvO3eJtrZtv0yciY/YDCRyhwVpk
         dTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758267470; x=1758872270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcpuRb5Zady/Ndj7TK1NVXuo7wdyupAjCmRtQU7qg78=;
        b=qms7lLqk8WBJBlMhdts6YFl5LmsvuadQZK4mRqk70TNTPzp2A1fB2zznLDW3tCHRpO
         HHGPAnN33Y8MeMbgMV+5g3UIVHVs1vjNq9jzkcOoIv6MKMUh+9qDig+2gtLl4xZxqb3u
         Cc48VfqJmCvLPra8jmcpXX6mYfF88qGyZJZ0sx/UH0SKfAtHr8OLNf2DJiX3U5Xx013N
         46CZ/MMYH97PLcKKFYObmqHol2idyRkwrlQcakZpIPMNwNru39kb9iW37RV2C5rQJQjT
         VUWgyjA4sLiKNarSGXfMQ1bRYJ7NlhTEPj/3RnGsSbfdAsdB6P2HIsY9A3W0A16FZhG8
         KV+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU65t5QOAWys+XHCuGDIdcWJ1zwA5VSsmNcKdeIUAlmlmrjDldjwzCwmavIKyX4SUlbj10ZyC59s5IN38BQ4+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg6bV34JT4uXPV5GMH5O6yVOZCODj3ofqGcy3cmNXv3p9F7R0s
	k/6eaOeNkxNVrCQ2fEAhwryvL8hOTphN8fjNUfGZTf0yoW04F9+wasD+fUKBnrRVWKo=
X-Gm-Gg: ASbGnct67X6LWL6AQiVpPND1lPiZzWWo7X5I4CQEJKPXUyg9lg0ekU9M3D70BnpP1Sc
	WQNGKyItGRzEWQ/bgiwakKAvEyRPdZ0hmzRQxPU8Pm7pbWDKZ4sOjX46SSIbftV6gC9a6cgbTLF
	A1UBaGWmvU7wbQqTcBzqhIhEiyHcBAY/k75i+l1z3Vmhs3bm3a62y1c5lPvCyoud1f1a9eWolq4
	vKEa+1azDdAfRoVMrTXaiCCFaMIl4NA5Ekt86j8TYqnSGhujXHa5SaTllUpiFc2gro1baWwYPxK
	dQcBlr/+vFIGIYhUrVue9MRoO3OXCGeFzMI2hv4tx37rcU0RImY5k0FvnLF9i/vkRYc9GnDlpU4
	kNh7NUlAHO+1wmSL5wChbOOodwkweU0NcoSlkWX65NFllMjBmP8dHGsvUKWTFcu4EeJ1hiAikco
	1ChFlwXRjo40giop0ugC0dEy+aU1nfRsHGrzHfDWFSXQ==
X-Google-Smtp-Source: AGHT+IEgACB1Se8zkEhUh/liD5ZfRMe2E7bZVsNaOovjpda2dN5kxeT40rB2jna9QVBQYl1FDLn0SQ==
X-Received: by 2002:a05:6a20:258e:b0:248:f6f1:200a with SMTP id adf61e73a8af0-2844b5ca29cmr7654865637.1.1758267470068;
        Fri, 19 Sep 2025 00:37:50 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b550fd7ebc7sm2679096a12.19.2025.09.19.00.37.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 00:37:49 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: corbet@lwn.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	will@kernel.org,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	mark.rutland@arm.com,
	parri.andrea@gmail.com,
	ajones@ventanamicro.com,
	brs@rivosinc.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v3 2/8] dt-bindings: riscv: Add Zalasr ISA extension description
Date: Fri, 19 Sep 2025 15:37:08 +0800
Message-ID: <20250919073714.83063-3-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250919073714.83063-1-luxu.kernel@bytedance.com>
References: <20250919073714.83063-1-luxu.kernel@bytedance.com>
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


