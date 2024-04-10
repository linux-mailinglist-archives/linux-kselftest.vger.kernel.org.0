Return-Path: <linux-kselftest+bounces-7555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0141889EE70
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 11:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC542871DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 09:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D1315ECCB;
	Wed, 10 Apr 2024 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nKaDTPkY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC5815D5DA
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740282; cv=none; b=GmYuUv/JJ91GoeWUEWr3k3iosZip9xowJkY6DJGv5OPbc93QaCYmBCSOAxBY9YWE1Xn001o21IWqQYVo2fvQHIhPeLA/T2ve+wpxtEU8tlcg9/6UWiukPyTPrEMl/9XwbzR6tqjBP8kR8GWplyPefENcOsC1zadP+xxqXhy4fmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740282; c=relaxed/simple;
	bh=7TJa65aVZsIDvLrvGp9e3paZD0UGS+Da2Fbvkii8Emw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkSObY4EuQWIYolIDaPmCtMtRgW/E0CRumYQC6p+0VxYEIeZDJpRZlsbjmEnTHFV1Cx0Y5tirnCKaUumHfzkinFSu5zvnRa7P6BMGD//T2j4LXJ3D/DYdjrdxUWE/cSaNVeLkluD6/Eob4bkESnxZFqoyR9LV4wKfLt0Otyy4xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nKaDTPkY; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d23d3bceso1854819e87.0
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 02:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712740278; x=1713345078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t15PVccKugGeH48k2RjHxzRDqhwHnpwL852aH0G35EQ=;
        b=nKaDTPkY6MlAhfIM77n7fpW1iMGvr31pUchaJ9U9st8VEZ5rz2q6PWYjdAXELuYs3s
         lehD2Ra4DK+kuhHSX8aMR9AOk9eahrD4PI/EcNkj9XDgqQxSfw/+hU6kDZCMV8wpxV+G
         VKwpO1Fv5hdpgW/8Np62S2NqQnOcKwPgzBygqdgv0V5dhvUQwiunP0efmvKPBTnmigUP
         OYnlOwy0yR0GMbyP8OEiOgfK7L/bPulmRFGsWlHs/xu31ukdXJGh9tya2b452pKZH4dQ
         RkOvgHYJSyEkSt5J9tz97ODRXBsh/74ukF/3DgmeajSTPA0lzZDI4mIDJs5MoTBPVwpg
         +jEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712740278; x=1713345078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t15PVccKugGeH48k2RjHxzRDqhwHnpwL852aH0G35EQ=;
        b=FS4DtE/nw6SYQXC12HSGm1KXBW/NFE5ZRqX8YU9hpwczAI6EOGZuDXXN1FnVosWY3N
         0YYmKZpZ0EnDc+xcqjzHhzySIK1L8VjqPv+5Rby3r34gFjUNe56iNE/gSeRkPq/DMu+q
         bddnKNAo9srbWrSPBzKc8SfKMQXxMfwTMslm5hIWy2KsNJy4AGr0QxoW25tDNzcD0dXV
         vshFYErbO551Zx4me/DAXQGAKIH8pJ9+MSRHoqXVx/lhHAhjcmET7wFGWZjXaOgz2JJ+
         ee9jdj4YO13AHL+uZl4HZb6GfYnDq7wZdbStB45tB7XI3wQ8J67ZVpZKgW2ZSEx7eOHE
         cixA==
X-Forwarded-Encrypted: i=1; AJvYcCVzXODTdM687104w0kEUF5ixiIOWMjOgNtOJcuammKO8PHhBd0hwRFlghL6zUxLvCaDgcR0YUHQlCpBehmK88jjAdJHv4/CZXEMpDUKAi5N
X-Gm-Message-State: AOJu0YwWcrMm0WgWBp92KrpJHQmc7vfF6xGGZwTJbPHpv7Auag/tUb7E
	FsaiCpYXwKI/xj5+1JjmtHjrbKFdnjlmFqsWGDeiEfhPyGD1/HN5yAzUJJf4Z4c=
X-Google-Smtp-Source: AGHT+IEJVPrhhNyrwtKSmL80bhwWSb7hKQIJxpwscC0mKQBtReP2KsNql54gMOZNVGMTZPZ+xSnEDw==
X-Received: by 2002:a19:8c16:0:b0:513:ec32:aa89 with SMTP id o22-20020a198c16000000b00513ec32aa89mr1163732lfd.2.1712740278556;
        Wed, 10 Apr 2024 02:11:18 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:d4a6:5856:3e6c:3dff])
        by smtp.gmail.com with ESMTPSA id d6-20020a056000114600b003456c693fa4sm9079086wrx.93.2024.04.10.02.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 02:11:17 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 06/10] dt-bindings: riscv: add Zcmop ISA extension description
Date: Wed, 10 Apr 2024 11:10:59 +0200
Message-ID: <20240410091106.749233-7-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410091106.749233-1-cleger@rivosinc.com>
References: <20240410091106.749233-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add description for the Zcmop (Compressed May-Be-Operations) ISA
extension which was ratified in commit c732a4f39a4 ("Zcmop is
ratified/1.0") of the riscv-isa-manual.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 516f57bdfeeb..902800b6dfe1 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -252,6 +252,11 @@ properties:
             merged in the riscv-isa-manual by commit dbc79cf28a2 ("Initial seed
             of zc.adoc to src tree.").
 
+        - const: zcmop
+          description:
+            The standard Zcmop extension version 1.0, as ratified in commit
+            c732a4f39a4 ("Zcmop is ratified/1.0") of the riscv-isa-manual.
+
         - const: zfa
           description:
             The standard Zfa extension for additional floating point
-- 
2.43.0


