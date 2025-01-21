Return-Path: <linux-kselftest+bounces-24870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B1DA17E6F
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 14:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6AB1889571
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 13:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915E61F2C3F;
	Tue, 21 Jan 2025 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZcSJcd4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD44A1F2395
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2025 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737464513; cv=none; b=XDsozMHaZ7z9NSiGNleeGgY1SO34gsJOEBOJ6XfMfN/u1GT97vMmpHzJn8E5eB5MIvwfseMRdLN6de67nD+Mz6u0iTVtKUvbXxZi9/mBSB+BndQkLnIckIl5INoYjDYIYLZuQ2EencYyqjwOU7zFdxgXe9RsRJol8KwK2gY7/3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737464513; c=relaxed/simple;
	bh=DiF/6MRNSqtu/NMaiM5rJ3sJyriG7fXeMACCzfM0I1U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XuIoIewF/G+5RTywFg1GkwB8VSArkFpF17/hNNTbxvtVGc019GDyUFj2EsvOZf1B5ZKIWEB9emjuQbRfHCxW+yZr2zGy1FMI6hv6p2MR4WmR+Kfc+EioXwkxShwE8NafdeAZckTsREtULChxe6UTuumZvzHQRo3KjnjJ/+hpVkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZcSJcd4; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4362f893bfaso30338835e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2025 05:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737464510; x=1738069310; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fm5t1lI2UPBaFBWtilwaxYV7ic27Oc43GlyrqP2MvXU=;
        b=aZcSJcd4r+PWq2oVekHTB49DaFSpXSOHQfJ9xWMEuvnyYwdpvuFSXM08ragmMKWbRZ
         tIBbqxGwrFww6iGU3Sh0vPTjaPk0CY5SPT5rjxXc+bg8FwT0LAf1yBqFjE6XHwainJUr
         1dzRarLttJYDWUVhEJT9ePt8BBJ+XOFoFNlPJN/hT0+589ISF9HlaszBRsRqrXk8KYQ0
         b2esllQ/7p7bxWuxRfwsAqA6o+/XnqdEfjBCZSqGoN7CevbLI2AYLgpoIqifaZkR9/eU
         XNPIAvkq4Lb0Y2MFYYD4VV6XIAjCSfCR06bmIA4ai5sdLQKVvJxWSkRrZ0u/D946tFWJ
         ucdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737464510; x=1738069310;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fm5t1lI2UPBaFBWtilwaxYV7ic27Oc43GlyrqP2MvXU=;
        b=ic9dUFT0n57TtfsTHVKVKEYCi9JQ1wFyXBkKdK1+N376K/wXcpex9uT5evY1lDezyf
         y9LmCOCl93JiqMi8FRhu6Y8qb7hjCgXifIxCqPGATib9DBsRB6Z45Jk1b8WaX9NKzDFJ
         fYep2HH082FVBUU5cPc3i2ZH9/h2iqQ/1h+Ux/cSAW5+tuHQkcKnpcQDAIPz25T5a1u6
         vLUo45LX4OFhZ6Ivn/lkqGqzPJw3CrIhuhbvniqN3hGZoOP3APQPcttRLuYJvLKBoZ2m
         BxtqhGPitgc1nnxd3EishEhzO9vcyBhfbmMbZn60aOEC86BE1YhWadvTGyhmYe8dkFqp
         BbjA==
X-Gm-Message-State: AOJu0YxJAk/Emg4oZPwHspB//tyBZbotkkSplCBVG/XtIO8iCv/OEWNM
	Vsg27B4m5PiXyi4iUkDz/IT+ceLfP/rm0S4exnmHZylqRu7xiaM6m6C2GcG8rXVRC9TNiiI2D9Z
	IhyYyL16EPA==
X-Google-Smtp-Source: AGHT+IG+o36jM2cEd9lJJrOOUCpMYXZ/H+DXCi68zo+x1kyJD7yEg611HI6y0O6EjB8qfL0PLdUYeAUSjeOGzw==
X-Received: from wmjk17.prod.google.com ([2002:a7b:c311:0:b0:434:f018:dd30])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e06:b0:434:e8cf:6390 with SMTP id 5b1f17b1804b1-438913c6856mr155230785e9.6.1737464510170;
 Tue, 21 Jan 2025 05:01:50 -0800 (PST)
Date: Tue, 21 Jan 2025 13:01:40 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALOaj2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQyND3ezSvMwS3fSUJN0kI3NjQ9MkkzSjFAsloPqCotS0zAqwWdGxtbU AeAaso1sAAAA=
X-Change-Id: 20250121-kunit-gdb-b27315b4f2d8
X-Mailer: b4 0.15-dev
Message-ID: <20250121-kunit-gdb-v1-1-faedfd0653ef@google.com>
Subject: [PATCH] kunit: tool: Build GDB scripts
From: Brendan Jackman <jackmanb@google.com>
To: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Following a similar rationale as commit e4835f1da425f ("kunit: tool:
Build compile_commands.json"), make a common developer tool available by
default for KUnit users.

Compared to compile_commands.json, there is a little more work to be
done to build the GDB scripts. Is it enough to affect development cycle
duration? Unscientific evaluation:

rm -rf .kunit; time tools/testing/kunit/kunit.py build --kunitconfig ./lib/kunit/.kunitconfig --jobs 96

Without this patch it took 14.77s, with this patch it took 14.83. So,
although `make scripts_gdb` is pretty slow, presumably most of that is
just the overhead of running Kbuild at all, actually building the
scripts is approximately free.

Note also, to actually get the GDB scripts the user needs to enable
CONFIG_SCRIPTS_GDB, but building the scripts_gdb target without that is
still harmless.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/kunit/kunit_kernel.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index e76d7894b6c5195ece49f0d8c7ac35130df428a9..33b5f7351cbb5d0be240cb52db2bc1fa94aeb75e 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -72,8 +72,8 @@ class LinuxSourceTreeOperations:
 			raise ConfigError(e.output.decode())
 
 	def make(self, jobs: int, build_dir: str, make_options: Optional[List[str]]) -> None:
-		command = ['make', 'all', 'compile_commands.json', 'ARCH=' + self._linux_arch,
-			   'O=' + build_dir, '--jobs=' + str(jobs)]
+		command = ['make', 'all', 'compile_commands.json', 'scripts_gdb',
+			   'ARCH=' + self._linux_arch, 'O=' + build_dir, '--jobs=' + str(jobs)]
 		if make_options:
 			command.extend(make_options)
 		if self._cross_compile:

---
base-commit: 521d60e196ecb215f425e04e9ab33e02beaffbe3
change-id: 20250121-kunit-gdb-b27315b4f2d8

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


