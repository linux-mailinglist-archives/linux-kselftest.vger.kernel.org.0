Return-Path: <linux-kselftest+bounces-9174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC8B8B83AD
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 02:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E76B1C21867
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 00:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FFD1109;
	Wed,  1 May 2024 00:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rS8f8JJg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0C0173
	for <linux-kselftest@vger.kernel.org>; Wed,  1 May 2024 00:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714522931; cv=none; b=rjO01eI65trHzofLuspEB3xO4lSjCJ5d8FG4ZQ9Xq3Cwz+zkWAie3JdpF/kG9029XOtwopOUWEkZR6yxWtNAIEdekL9gXAmB+bftEIZgyB14FVpRleTiCxqF+dKh/bgnaUJNdF5rrczEZwknhDVueMLrs1R1XaP+oMZTotvKsIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714522931; c=relaxed/simple;
	bh=X0WM2lVVVkrpkqRH8pWOu5puLWSYx1PKBK2oxI4tuB4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dsdmw90DlJ5G7mhPEO1ZjPnqwp9YYCk/4JU+NHDNUDjBqAZzkae5Phux6iugSkoLsi6QhS41XaLzEspduKfb+6zwBac4n72UzRTwenI4Pspn1RQdobBCTkfuvOs3xQGhsLBuJI0bUjtWwHeT1Uw+bjWbAho/J3wNAnI06hG81ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rS8f8JJg; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61beaa137acso24678047b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2024 17:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714522928; x=1715127728; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aOeVT5ijOmluYWTqyy0kihWy6E7/FOShE/HltlDIAgs=;
        b=rS8f8JJgNyNBX4VffEd/p7utgRtfbyqdOOSI0UjuUThBpbIJ/Kz6yp7ZikxYlKCVWv
         ctfFzzxlzJm1Lt0PgHqcuLv34KOtuOJh4ATEthbNBOsGKNjqtJZu5mYLOCmP78ARyuKA
         gBAPvSRzBYh2unuZBxywSXgB5al3rgyyOCMNjZg6RuHOG9l6tANBpv73UwXtEJ4L0UN9
         kwGioub22oGxJESpDrtSI1Cy81D3VP7q9oi0OgzEgGqPa6S/Pa9hPPM6MKiMetu8cP5i
         pRAn3jLAeewFbUQupG9Cp5dukm28d45aZK2ytAQ/AgrJVhL9CiOPNWK+QH64KOKPZae7
         hwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714522928; x=1715127728;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aOeVT5ijOmluYWTqyy0kihWy6E7/FOShE/HltlDIAgs=;
        b=m8P1lhSoGKb8Hhqk1cmVaV1Z755X60fVyx1kFopuD5yHBXTTWhzncFhm8/4xos/UJQ
         wSKmbWoutd8hjfnQfmZVCpJ+sGa/5IrJ8ZaTOKQhYOz+YUlKDmw58CZcomk3Bhm0JwDk
         UnS7SPyHPli2ZWYztNsWfKGPn1iXDNyrtYlvNwhtdsVJ4NiclDlj+FDhm2yqsqIM+qUj
         W/0oKy+SgudQ+V2nNGM2j3LnXqUBxQWllgx106ZaqA1XZfhzNxyMU6ma3VIf6L2l7Lyr
         sohJwcGirr6G4t9whTn4tD+RBuW+v0v7xoRb+/r0gf9uwe0RXrqV3/3ouYzkHjVJ3Err
         6ZWw==
X-Gm-Message-State: AOJu0Yw2WvRaTpO+0lw/VwPIUcX+NZYW+iCcvB7z3ykuNBZIZGfWtXn5
	odri3eVbH+EINi7pUJFlAN1SlQWnDRaJp5Ssc+gwuwovG2pJUuZDWS9HfTAv4AJ1ZN90sgMA2FU
	wDw==
X-Google-Smtp-Source: AGHT+IEklaC0M02gKwu0vEYUSv6f+jBLX5i1o80HacxvejQgGQU/HK8rwZXcSzpBPGZ7mCbPiYEdzIATv2o=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:2b8c:b0:dd9:1b94:edb5 with SMTP id
 fj12-20020a0569022b8c00b00dd91b94edb5mr169322ybb.10.1714522928046; Tue, 30
 Apr 2024 17:22:08 -0700 (PDT)
Date: Wed,  1 May 2024 00:21:48 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240501002150.1370861-1-edliaw@google.com>
Subject: [PATCH v2] selftests/vDSO: Fix assignment in condition without parentheses
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andy Lutomirski <luto@mit.edu>, "H. Peter Anvin" <hpa@linux.intel.com>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fixes clang compiler warnings by adding parentheses:

parse_vdso.c:65:9: warning: using the result of an assignment as a
 condition without parentheses [-Wparentheses]
                if (g = h & 0xf0000000)
                    ~~^~~~~~~~~~~~~~~~
parse_vdso.c:65:9: note: place parentheses around the assignment to
 silence this warning
                if (g = h & 0xf0000000)
                      ^
                    (                 )
parse_vdso.c:65:9: note: use '==' to turn this assignment into an
 equality comparison
                if (g = h & 0xf0000000)
                      ^
                      ==

Fixes: 98eedc3a9dbf ("Document the vDSO and add a reference parser")
Reviewed-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
v2: separated assignment from predicate
---
 tools/testing/selftests/vDSO/parse_vdso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 413f75620a35..fdd38f7e0e43 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -62,7 +62,8 @@ static unsigned long elf_hash(const unsigned char *name)
 	while (*name)
 	{
 		h = (h << 4) + *name++;
-		if (g = h & 0xf0000000)
+		g = h & 0xf0000000;
+		if (g)
 			h ^= g >> 24;
 		h &= ~g;
 	}
--
2.45.0.rc0.197.gbae5840b3b-goog


