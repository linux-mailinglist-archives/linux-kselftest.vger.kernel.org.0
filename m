Return-Path: <linux-kselftest+bounces-25085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF52EA1B457
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 12:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E7F168AF1
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 11:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4051D45EA;
	Fri, 24 Jan 2025 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Y3z8DM8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFEA21A94D
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2025 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737716511; cv=none; b=rVtlOqA/40g98f2jdoUmEMf3FqDfl4f0HS6P7TqcqQGWK52nkh9B2s0vWpmPCAEku3X9Xnu6UIdsAa5Lu2LOpI64DrfpdK9qSslV4ilAaCcc4vXYb632AfETKVd1Oj2tx7qLk+loKHjgVvlC3zm2eZ+82E7hahoKYwLxF9AyuYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737716511; c=relaxed/simple;
	bh=O4twTNY6QnsP1zsvS5Bz5IEESFifTVL8CnCIGl+To7k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HoX0+IoKqhdtlqaXhnSkgFvb+/GCZIFiQahMDUWFeK9K6nPjX+ME9q5LvisWGlrTKWQX6UH1bnEEG4QX1ZMGlO06ASCJgkPaVUT4xff2HfoXJhwOyQ75JmiCQ5FGVHENbQvpgXdh6TEiLNvuSVBazeslx/YLHD+dvW5bR2Oaenc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Y3z8DM8; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4362552ce62so9268225e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2025 03:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737716508; x=1738321308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uXkvtWlxL/Lwp+fnncLKVceJYPQb37OhTfMRENmNQHE=;
        b=1Y3z8DM8/ifBm/gY7zJ8HaPMgxgy+sN7/Ltd/HymAq9inX67pDrUjy2AnPJFPv76B0
         tK/bv+S5bRLY15FHMjG8I5fJLm+qtqMcpGM4TGAKrVhpXW/AYzWHDoMiC/GA8pXpKPkB
         zq8viLlW9Mg9zpUDfYijFTneM9/PLhF+7D3MlD8ubibdDZMJ5hYEDGP4aCByD0EPZ0RW
         6GmbN4cwidWU4Ti+wJ3nPcn8ZImoU1C8PAY8Xt3ujDtB9fDR8oyNVdRzLt9NYiM25P8f
         z0OtL7cUwDx/Hq3+nAHnv5yesawJ2+WHlxXURTE9kK9mNYVNb7qiWknjXQOwTIRXxJFj
         lJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737716508; x=1738321308;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uXkvtWlxL/Lwp+fnncLKVceJYPQb37OhTfMRENmNQHE=;
        b=nLBw8RMd38VZApgV/Kd+9IUyzp02RvfYZxP8GyUL/6NfoGby/8efG8GcF+YLurM8oJ
         eY7X7UsZsZ6Vk+KIf78PpAUOUnwCMxxbGtA/R1ivLzraG9Ca7dNoZq5V2dk7lXhpMvOU
         Fz3IwHhKvSKEA5cM9FgPeNjyqWIjWX7CJ32NDs+ZDTj+ZMvnFVZGvEZ8R5lYlYxkywqk
         Y4aOVZNRHbm1I35mLUkYh6e1+fiMVoYOP2W4jiyZbLs2XwVDdDyEAz4X003jLRozypli
         x31WOABNxEr+u5DcAcy59V3gUd5z7SzwKbEv12hSMOZWk3N7yt9KhPZDzMPcIScMKJBQ
         Or6w==
X-Gm-Message-State: AOJu0Yz2q5bMQHuAlg/dmUmt7sxreS4v46q+hFLzwCcNJGGeCNyvZ1JG
	3kEaG37iO8rK0cQTO4S/4a1XZp/Ru6X76YyNim0dDWOVh+eVJ1Y62sH6p7Va+z+M0FPG3f+oOXm
	gVRCgs76beg==
X-Google-Smtp-Source: AGHT+IGLTUBhcjiYAaw6NQGnsFlN4t+zgevq1xO4htxLBsBT2dypWygBhikQQ0AsJLt6pIHYUzuPGZMdBUP/8g==
X-Received: from wmsn42.prod.google.com ([2002:a05:600c:3baa:b0:434:e9e2:2991])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4ed4:b0:434:fdbc:5cf7 with SMTP id 5b1f17b1804b1-438914373e4mr267565245e9.27.1737716508660;
 Fri, 24 Jan 2025 03:01:48 -0800 (PST)
Date: Fri, 24 Jan 2025 11:01:42 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABVzk2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQyMT3ezSvMwS3cKk/PwSXVMjA0NLE9M081QLMyWgjoKi1LTMCrBp0bG 1tQAV/UkgXQAAAA==
X-Change-Id: 20250124-kunit-qboot-5201945f7e86
X-Mailer: b4 0.15-dev
Message-ID: <20250124-kunit-qboot-v1-1-815e4d4c6f7c@google.com>
Subject: [PATCH] kunit: tool: Use qboot on QEMU x86_64
From: Brendan Jackman <jackmanb@google.com>
To: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

As noted in [0], SeaBIOS (QEMU default) makes a mess of the terminal,
qboot does not.

It turns out this is actually useful with kunit.py, since the user is
exposed to this issue if they set --raw_output=all.

qboot is also faster than SeaBIOS, but it's is marginal for this
usecase.

[0] https://lore.kernel.org/all/CA+i-1C0wYb-gZ8Mwh3WSVpbk-LF-Uo+njVbASJPe1WXDURoV7A@mail.gmail.com/

Both SeaBIOS and qboot are x86-specific.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/kunit/qemu_configs/x86_64.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/kunit/qemu_configs/x86_64.py b/tools/testing/kunit/qemu_configs/x86_64.py
index dc794907686304b325dbe180149169dd79bcd44f..4a6bf4e048f5b05c889e3b9b03046f14cc9b0bcc 100644
--- a/tools/testing/kunit/qemu_configs/x86_64.py
+++ b/tools/testing/kunit/qemu_configs/x86_64.py
@@ -7,4 +7,6 @@ CONFIG_SERIAL_8250_CONSOLE=y''',
 			   qemu_arch='x86_64',
 			   kernel_path='arch/x86/boot/bzImage',
 			   kernel_command_line='console=ttyS0',
-			   extra_qemu_params=[])
+			   # qboot is faster than SeaBIOS and doesn't mess up
+			   # the terminal.
+			   extra_qemu_params=['-bios', 'qboot.rom'])

---
base-commit: 8ea24baaaa869adeb39c6b9ce7542657a7251b56
change-id: 20250124-kunit-qboot-5201945f7e86

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


