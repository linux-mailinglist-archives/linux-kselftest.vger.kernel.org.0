Return-Path: <linux-kselftest+bounces-21340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB939B9FE7
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Nov 2024 13:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C73C1F2184B
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Nov 2024 12:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09700189503;
	Sat,  2 Nov 2024 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9+/MqLN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BFD189F5A;
	Sat,  2 Nov 2024 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730549413; cv=none; b=msTxn2WEYPLesIcakCoICTYz6Kd0CzFW2rX1Nyg4yqTRj+UcWrpfMdRzo545GVHiHq8h2Cr1IPo5oKu9fedc22gS0cEy0IFSEM5RsRFQhX0LOGLgkHtaV5fJjNkd40E0wSopBhs2a19LikDSW6FokYjrkuxtp4HuCXjFIwpxFx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730549413; c=relaxed/simple;
	bh=RmETCFe5x+lP5bHc1J8Jizfo3pKb/RAereNfrUN5osY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YbixxCdnE88PqKUJgtG+v+2uNIQcNIKtwkw+2X+uBO0oHioGy9imIIpQZkygTF0OPpOvH31cgOSbM0d6NydfV3Z1Ev4uqJ+0sYPsY9kP6O6Q6bHMkHylQGWop27URguParQGSJag54FK17AN0/ri3z2/1j9yrDYwZwQ8IxBT94U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9+/MqLN; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e2918664a3fso2337194276.0;
        Sat, 02 Nov 2024 05:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730549411; x=1731154211; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZqvRtfQjrnuWPv8FX2A9hzDN4crJUYk0z9dSFXFnBv4=;
        b=S9+/MqLNrhVgaQsmMWBIycdB9P9W2FczSitz6hPl9Zg4XyJofroRdzpdeOuxgU0umV
         He3O0mvETlJi0V1PbhLgIaJnyUvUJOW9Bih2jFMy3NpkBQ+tOowevSf7QcD1Dy7EFDW/
         ihJdcBQOJ4z5JPaG+8ZSi4XQ7oHrcn+NA/sx5Z0+WcbGvAfXuzeI9jLKMy5hR0cpu5et
         0IKtS9Oo+/5mFlX4939LqYSXmYocen/DxMXVjuyq/HQetWbY/FhMXPaQ2zIOsfaWufJl
         JP33Tp3nke/XAi45aYLOHsQzIZ1KYkh/q13SLUGAw3qtenMkXZYIC3jl6Pza3/SGj0Ew
         E+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730549411; x=1731154211;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqvRtfQjrnuWPv8FX2A9hzDN4crJUYk0z9dSFXFnBv4=;
        b=E9eoOxfG0lhk47tpSi4aUhkBSi/hSNtnh0m97zS9DO6lfee8nY7DVtbiTn4LD8q+iY
         +AyTySYzeTY2UQts5isZD2IBtUuuBlH7SIbxjUgRTDWgwLLvteON2awC45zqMf8JPc7Y
         /PcFQaxX/Sf3cBdyiUx2WxXp8A6lFCC7ruNgZWqnBAgHzg9FHOA6/XHzNe6SRYdK1mcj
         MBujJWXKvEuRijP7zDZVfW1+3JC8tDUxGqVG8SWzN480N/SK09fbCrLj6ThyyGWEHaUm
         WbrD+D3lEmmUJRqCs4JTltyu2IN+KerArZmvj/Mmxw8WHCYQK6eBLsOKKsiNnJMzoLMz
         MRkA==
X-Forwarded-Encrypted: i=1; AJvYcCWeCzinxqwBARONfd86ed6xVItohY4MUhcrMUfTcaufmY0TyM9voXuQTdl/jGGjmUUaPhQBWr8YGvHNHtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVDNirSwGdgbvpmH52XIFUdbW0S+a+7SGbpzLzp7LetAP5+wbO
	5QAeOE0mdWAbuW9LILw3RgwjLbR20vgVnbBJoQbtMw8IxPCvrzrL5TfhVrcN3zI=
X-Google-Smtp-Source: AGHT+IGwC6VkGtOUhcvUVsS9q/sBhaGEqtCp7G2bPHETsYXTRGmu5CNrP2r7h8lxcqfE6owAlOXniQ==
X-Received: by 2002:a05:6902:c0d:b0:e29:2560:914c with SMTP id 3f1490d57ef6-e30e8bce90fmr7190642276.9.1730549410862;
        Sat, 02 Nov 2024 05:10:10 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (186-189-35-150.setardsl.aw. [186.189.35.150])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8adf9ecsm1139393276.59.2024.11.02.05.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 05:10:09 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 02 Nov 2024 08:09:49 -0400
Subject: [PATCH v2 2/2] kunit: enable hardware acceleration when available
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241102-kunit-qemu-accel-macos-v2-2-9d4579fddd20@gmail.com>
References: <20241102-kunit-qemu-accel-macos-v2-0-9d4579fddd20@gmail.com>
In-Reply-To: <20241102-kunit-qemu-accel-macos-v2-0-9d4579fddd20@gmail.com>
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Alyssa Ross <hi@alyssa.is>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Use KVM or HVF if supported by the QEMU binary and available on the
system.

This produces a nice improvement on my Apple M3 Pro running macOS 14.7:

Before:
./tools/testing/kunit/kunit.py exec --arch arm64
[HH:MM:SS] Elapsed time: 10.145s

After:
./tools/testing/kunit/kunit.py exec --arch arm64
[HH:MM:SS] Elapsed time: 1.773s

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 tools/testing/kunit/kunit_kernel.py       | 3 +++
 tools/testing/kunit/qemu_configs/arm64.py | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 61931c4926fd6645f2c62dd13f9842a432ec4167..3146acb884ecf0bcff94d5938535aabd4486fe82 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -123,6 +123,9 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
 				'-append', ' '.join(params + [self._kernel_command_line]),
 				'-no-reboot',
 				'-nographic',
+				'-accel', 'kvm',
+				'-accel', 'hvf',
+				'-accel', 'tcg',
 				'-serial', self._serial] + self._extra_qemu_params
 		# Note: shlex.join() does what we want, but requires python 3.8+.
 		print('Running tests with:\n$', ' '.join(shlex.quote(arg) for arg in qemu_command))
diff --git a/tools/testing/kunit/qemu_configs/arm64.py b/tools/testing/kunit/qemu_configs/arm64.py
index d3ff27024755411441f910799be30399295c9541..5c44d3a87e6dd2cd6b086138186a277a1473585b 100644
--- a/tools/testing/kunit/qemu_configs/arm64.py
+++ b/tools/testing/kunit/qemu_configs/arm64.py
@@ -9,4 +9,4 @@ CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
 			   qemu_arch='aarch64',
 			   kernel_path='arch/arm64/boot/Image.gz',
 			   kernel_command_line='console=ttyAMA0',
-			   extra_qemu_params=['-machine', 'virt', '-cpu', 'max,pauth-impdef=on'])
+			   extra_qemu_params=['-machine', 'virt', '-cpu', 'max'])

-- 
2.47.0


