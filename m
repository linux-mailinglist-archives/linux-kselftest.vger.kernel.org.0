Return-Path: <linux-kselftest+bounces-38171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C58AB17EA0
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 10:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9723B5801CF
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 08:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA802213E9F;
	Fri,  1 Aug 2025 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ym77SURc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BC521421D
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Aug 2025 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754038498; cv=none; b=f9g9yEd3Qt68+fV5swLuWB1B0IoMoQJIikR0tuMCMckgExYji0oha6dWJweSi/EK2r8UbefTgtLVc4gReLDRlzoPxO5oa2ubLzRUz93cDdbM7F+GYAKAPzo9PocpO76B6G6L0kta0tTYmjSJbeuYeeQUkuzwAbWRAqeDm8UwOd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754038498; c=relaxed/simple;
	bh=lfL2grWKViqTBwcoomF5oXgApZotCUrPhoRP/HyAKjU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=P60qEwi/v4wC7/xVOCoWkimegzqBRU87OxMWS72ke+VMyL8GvHu6969KIcmETE9NO/YTUa/sjN9WDCg/axb78QWJ1BrvrjApx/m30aHcUZSCo1c1h9jR/OyaZu+jT5vmEtJtKcMCrD0INF342uqkH0IuAfw6zgW6YDCvbM1rmqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ym77SURc; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae361e8ec32so341800466b.3
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Aug 2025 01:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754038495; x=1754643295; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3AB98eeKucxvuyx0BTmR/h9RGShiBxVhNzuqMeHWSo=;
        b=Ym77SURcPu+8VRMWVj0D1cbAxQ3H89hAXHX9L2sV2gD6gDMstTtp+MKpWpMTUdJmtg
         6Ng0rW0vZTIztzCavm4Du2cF8mMRR2AVSh7DDU7tnznpMt4in+z/Jcbc9VJa7N5KzXMd
         Vlo8J2KFOatP+gpv/26SGxk98h7J7C286zFVaCQZZ7kbT9u0ON6/JeO/EUwWQitZ/RER
         e6GEyzKljMmB9Sb1t3paGPuyVN4b1S+qwoWjrJhu3XFwZ9XPNKkPySB+E2233ffFKXrH
         9xSEebE2BvIaV/+wAQsVrT8T4Rp9+3XGq+4BJKof45/0JcASst52WBBZ2mVuFhfZrCk9
         4z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754038495; x=1754643295;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3AB98eeKucxvuyx0BTmR/h9RGShiBxVhNzuqMeHWSo=;
        b=ou68BsQeWdg3YObMtEWD0dv20oleBhtm/fWkrh4ji3Y1NISM4YB8HEKOX0ay6jaBhy
         6CJHzQDqIMeiqbXz8nuuyeoZiAxdPHAdEVOWXdI8KrX4vkCGy+xZ0SRD5AydYHY9+ZLQ
         yvhLrYUf8ugj97OL1Y9CDhRIjEwPSNup+IYsRIDaD1cv6yS4cWOlxFZe+v4pvx/qDrAD
         C6LJwoRQXqxWz4gffN7TWr4LscVzsYKCJT+U0dZZyCjqHH/ZsNy7VIN9lfsRDsv2OCEd
         c2UDMmMhKbjKwMM0jIrhDA4Zlqx5TWgF/wjSJoOj1ApO7RoXP2yZpwAPmQ8yU9E6aU1N
         r3Iw==
X-Forwarded-Encrypted: i=1; AJvYcCU8k7iar+AWhl9vOc1CXP26q8CeMKctvOF2ydSy76hxU7Tc3v39FV+14URlqew0ceqrFiOHk5JIUMi2OCDZF8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YytuL9Oz59WqHXQsKnHmxh1JgCboUzp4KqFyRw0XY/RqgEh136S
	XhZ/LJIcVaOOdG/Pufv/ymWiM74O2doDvnU3gLqhJHD+/iVmYCZY4oKQ
X-Gm-Gg: ASbGnct2JDB6Vwmmmw35/mRY3OL6xQqBBBDSUAUUW8X5dJ7ton8DgAQq/Tv7eVVm9vj
	KxqP6lss5ZnhtdNIqr3746hLG4Stg+Af0UnOZzi9aXUIhEHLfZQ90APnTC9sonOApPgivXFR15x
	SQWsIoMLGi3YY2SrGi8qY+X1F9cb0fra+onvhuyAAQKEPxrawF7sUlaWR9FCqCCa2K/ct69fQzo
	w3Zr+cG0aEu2g1zWUA3Ri5QXJi1MUZb8x9bO1fubpBAcgNeg45JIS0isFqBWrATI51TYOwSK1iE
	j2g4z9MezTr5Nb06EILSElFwuesJ/taJ/wHLy+SqXa7e35QRVtbqSykebOr4M+PW+i3p2kxkdOR
	os95jLhRWitRULU6pYYEaZg==
X-Google-Smtp-Source: AGHT+IE11O24u0tms2LfFyxN8pzbR53soXNrbtbLeno8ALixj998fuXTqYMIWsbeqsHnubUB+/vITw==
X-Received: by 2002:a17:907:3ea0:b0:ae0:b3cd:b7f8 with SMTP id a640c23a62f3a-af8fda3d2dbmr1218378666b.40.1754038494834;
        Fri, 01 Aug 2025 01:54:54 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a1bf9sm255151466b.31.2025.08.01.01.54.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Aug 2025 01:54:54 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: [PATCH] selftests/mm: link with thp_settings when necessary
Date: Fri,  1 Aug 2025 08:54:44 +0000
Message-Id: <20250801085444.27182-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

Currently all test cases are linked with thp_settings, while only 6
out of 50+ targets rely on it.

Instead of making thp_settings as a common dependency, link it only
when necessary.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/mm/Makefile | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index d4f19f87053b..eea4881c918a 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -158,14 +158,19 @@ TEST_FILES += write_hugetlb_memory.sh
 
 include ../lib.mk
 
-$(TEST_GEN_PROGS): vm_util.c thp_settings.c
-$(TEST_GEN_FILES): vm_util.c thp_settings.c
+$(TEST_GEN_PROGS): vm_util.c
+$(TEST_GEN_FILES): vm_util.c
 
 $(OUTPUT)/uffd-stress: uffd-common.c
 $(OUTPUT)/uffd-unit-tests: uffd-common.c
-$(OUTPUT)/uffd-wp-mremap: uffd-common.c
+$(OUTPUT)/uffd-wp-mremap: uffd-common.c thp_settings.c
 $(OUTPUT)/protection_keys: pkey_util.c
 $(OUTPUT)/pkey_sighandler_tests: pkey_util.c
+$(OUTPUT)/cow: thp_settings.c
+$(OUTPUT)/migration: thp_settings.c
+$(OUTPUT)/khugepaged: thp_settings.c
+$(OUTPUT)/ksm_tests: thp_settings.c
+$(OUTPUT)/soft-dirty: thp_settings.c
 
 ifeq ($(ARCH),x86_64)
 BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
-- 
2.34.1


