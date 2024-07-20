Return-Path: <linux-kselftest+bounces-13950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 683EF937F56
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 08:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F908281BAF
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 06:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6801F101E4;
	Sat, 20 Jul 2024 06:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KDxjVFAg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46652913
	for <linux-kselftest@vger.kernel.org>; Sat, 20 Jul 2024 06:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721457617; cv=none; b=ljrXL4Df55a1UwoQmm2a3NmGzoBoNMmupv8LpFP+52kUO1YimC/m/7vtIr3W1kKiQVJf60cPtnNyrBlRjpNXEdeiXSlat5g6buzBHspEH2IvT/ew6O64tVFnURZMOFMKoxl60hVIbbX/cEctRZ/8EyjMDlyAsZlr+KqbGrSSl2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721457617; c=relaxed/simple;
	bh=SOy+vUdyj1QZcGWTYw65/TCSGgJIWpduJn+NULiO/Cc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=e/5CPoaflAQ2dAoxaWFVOvs3CKXm4mII8/JIbuOS81OZxUfpYwDj2A5gFVVAh5CsF64rYJrrD27e6i78CjVOnc0qWueKn6vVnYlQn/43fUQGCSovd12ssgCVDRbepfH4mQINtKd/HSvzcq7YIrC7VcTHVnHVf6X2jfQ+U559s7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KDxjVFAg; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-65f94703b89so78205957b3.2
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jul 2024 23:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721457615; x=1722062415; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5LutXjcb92XtVBL/NbsMLJelzWCET6vfhvJ/jrymSIw=;
        b=KDxjVFAg4ZJ0/FpQbpIjpuGdQt6KWZbTn7WOdvmh+q7smpZJZ/4fJg1oN+dqdnt7V5
         VR8yZNQYEOCkkqoK3g3f37m2rLBWdZVnVGGJxGWI5A43YFDaugZTwTlc/wrP/mP4pXSe
         aPyvsuUDRZJlEbyDXi3p2BjEjx41L074C6T61G4uo0M61N9Ji7WSTFYNvwbdYGX3ZoPO
         B6dReDG6ZIHEwiZK9T+wkfWGUjdz41qwuq5jjZj4L7S12ttpcPnIneYYi0OwwAmAhdJ0
         0YdahtA3zXBAyp7flbH7mI0hv3ELqiV9587XJs31yUpwgInpuksGm2IWQj91NXQiby/C
         Cvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721457615; x=1722062415;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5LutXjcb92XtVBL/NbsMLJelzWCET6vfhvJ/jrymSIw=;
        b=W/I3ab+29GMnkEwhXdyPjSNvzVFEJJSSb4IerrxbQR8bmrPlt32P7xD7838cbH+hb0
         tDhWGu++w0VtQaVtrMhokmGVUfxVw1ojupSL9zaLbaSJz3IH3miARz8F1mApnLZO5VU9
         KmKffW23IURTf/JfeY4fftraup3OKpvVKPIlLWYcOZDqTocpi0p8HczKRYHsX7dkohLk
         VRpSs2mxEZP6XzNouoAxe/XWhk2oypjTe+acLM8TNavRgHR6ddH9o0jNQRfNHg09WN4M
         NSuVo0vHb4T7yQGnDXpOsAeOA5kLSPGhJHFTFwXpbDLnz62C7xiJ69Ql/TIwJPg7xIC8
         +x9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVm/QrQ2QrHn0iSN830RY/XoUm4oIZ4bAttmdMj6aWMhaCBEEQlORR9H+HPWya9CGyXH+8grK9JRrWyHNVoYjTAGUt9rRTUBAVMjIQxrYgX
X-Gm-Message-State: AOJu0YwtkOCKKs+8n55/QVhh9TffDHKFsnhHrBoBO7JJQtalUCHnnyY8
	NMgxkLST/W2E3MaJAJjNHzy+uUC4FlpPjt8qKGJc+cpVs5++GocdGeL91zCdoTkCh77GfWjH08H
	CE1xDrUDnFQ==
X-Google-Smtp-Source: AGHT+IHm+r6xgzeE55nrCV4/1oEivTgFJ4DVkMpbrkfGmdu3DZ48cSfxn6o0bpk0LnUFeecr9OHhzLrvPZF9Ig==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:690c:3148:b0:62c:ff73:83f with SMTP
 id 00721157ae682-66a6673b3d4mr395367b3.8.1721457614697; Fri, 19 Jul 2024
 23:40:14 -0700 (PDT)
Date: Sat, 20 Jul 2024 14:39:34 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240720063937.2311958-2-davidgow@google.com>
Subject: [PATCH RESEND] x86: checksum: Fix unaligned checksums on < i686
From: David Gow <davidgow@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Noah Goldstein <goldstein.w.n@gmail.com>
Cc: David Gow <davidgow@google.com>, x86@kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The checksum_32 code was originally written to only handle 2-byte
aligned buffers, but was later extended to support arbitrary alignment.
However, the non-PPro variant doesn't apply the carry before jumping to
the 2- or 4-byte aligned versions, which clear CF.

This causes the new checksum_kunit test to fail, as it runs with a large
number of different possible alignments and both with and without
carries.

For example:
./tools/testing/kunit/kunit.py run --arch i386 --kconfig_add CONFIG_M486=y checksum
Gives:
    KTAP version 1
    # Subtest: checksum
    1..3
    ok 1 test_csum_fixed_random_inputs
    # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:267
    Expected result == expec, but
        result == 65281 (0xff01)
        expec == 65280 (0xff00)
    not ok 2 test_csum_all_carry_inputs
    # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:314
    Expected result == expec, but
        result == 65535 (0xffff)
        expec == 65534 (0xfffe)
    not ok 3 test_csum_no_carry_inputs

With this patch, it passes.
    KTAP version 1
    # Subtest: checksum
    1..3
    ok 1 test_csum_fixed_random_inputs
    ok 2 test_csum_all_carry_inputs
    ok 3 test_csum_no_carry_inputs

I also tested it on a real 486DX2, with the same results.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: David Gow <davidgow@google.com>
---

Re-sending this from [1]. While there's an argument that the whole
32-bit checksum code could do with rewriting, it's:
(a) worth fixing before someone takes the time to rewrite it, and
(b) worth any future rewrite starting from a point where the tests pass

I don't think there should be any downside to this fix: it only affects
ancient computers, and adds a single instruction which isn't in a loop.

Cheers,
-- David

[1]: https://lore.kernel.org/lkml/20230704083206.693155-2-davidgow@google.com/

---
 arch/x86/lib/checksum_32.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/lib/checksum_32.S b/arch/x86/lib/checksum_32.S
index 68f7fa3e1322..a5123b29b403 100644
--- a/arch/x86/lib/checksum_32.S
+++ b/arch/x86/lib/checksum_32.S
@@ -62,6 +62,7 @@ SYM_FUNC_START(csum_partial)
 	jl 8f
 	movzbl (%esi), %ebx
 	adcl %ebx, %eax
+	adcl $0, %eax
 	roll $8, %eax
 	inc %esi
 	testl $2, %esi
-- 
2.45.2.1089.g2a221341d9-goog


