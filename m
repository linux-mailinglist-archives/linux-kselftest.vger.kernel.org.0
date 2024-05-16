Return-Path: <linux-kselftest+bounces-10313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590E68C7D59
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 21:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF859B22911
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 19:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE33C156F29;
	Thu, 16 May 2024 19:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BFQIgZIw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1151E487
	for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2024 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715888315; cv=none; b=G5HUCoYHel8vdJ0rKtbg/Ib0VNT9fR+p43D4AW8HCvX04EkSrePiLMaamFfOuMju4M8vHpvoS091Qln+IIzirlJX7lKXJvvnGpuk5Z5TC1YZjs9I5FPthggQqwwWgSpztrpBdbxwxiTS6NUZo5naBy3XC18dT55PXXKxJDzKvZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715888315; c=relaxed/simple;
	bh=mlnMYRMZywee+bU7X3E/HTKmms1wgK1WMiDq3bygPLc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c3lags+GuWULCAWBB39BrI0TKEMOiDYOmkNNC/9t6jQQ/8H3Fb8n73v/qcF3XXFN7wKHQwPv5m/UO/hizHWYSh2kQ+r3CHr0jRRiA0PgECGToexcinxsY5Y4r3y58DQghFGlQM5OddY8CmfFhpOR04WXqCC33g3MELjPUGjk/y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BFQIgZIw; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61bea0c36bbso167107637b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2024 12:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715888313; x=1716493113; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GTNya4KcgcK2eGurHUl9hyGe1sf/dMjmphGQ/IQpeU0=;
        b=BFQIgZIwLjEW71n1n9fcx78hCAtFLlWc2e4G4rD6SICAOrFst9bfAFB0FLmr2O79c5
         jreVp0gAhYe/9gIkc/TDC5RzbXkGppLGjsIdqG6PPDtg6QcmWA9TK9RlQjJNtYqTQuMf
         QYSmAIcPKG+CeLKx4Ovk68ea96q04zNzHTKKO4nX3C4fzyAJGrR8ZFq8FlUOguU3JLjS
         ZCn+4CXaK+GaDN6xq/fxcREM/e8yT+xjn4mGIDLSrXpGZDLU0ANenOLaBCensnW1Q071
         w2BKC3fZfrGnoDSzZrj0+JWGZdarp40cGqiceJ1ceV1ySCiTxT9wdNd4SrRTBa7Aqgyz
         RjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715888313; x=1716493113;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTNya4KcgcK2eGurHUl9hyGe1sf/dMjmphGQ/IQpeU0=;
        b=mjCm9qitkAN6PvHW8YdVzVh75xKxDHN3zAi7jZK7bixehj506mAI5H78EeW1V9RfrA
         sVKeMSqQhwQMny3QimGLJAUsJjuJcq0ShSJbOXV9CsiljNuS555OG8+F71B3hwOW/knF
         DDYt/CcM9MsCm1sseATY3pXWNPzMLL+c6xvKs7q2c45uxeAvMqG14ak0HUoX+a9irRK/
         2HP9I+x/tvZcLePM3q19wW4kX7BhJBg2+62loNZbe6/im+5+y30SSF3enD76xIEzIgJZ
         kAYILv/Ky70lsswJrGvoUxcR+ygcsEN3hiLl/TWpvtpCVbeMUJiXJPSvjn5e2GgNgPlU
         GyiQ==
X-Gm-Message-State: AOJu0Yyk9/JVmj1Qjl8AWqk0vYg2bq0fLmNekZLtbX1xLbOAp11GQAqM
	jxoZr1NsoDoZJ7o8KiZGVW1OmPWA6WZPjzEvY1rDQseV2m5MpM0iE8vFiSdTskYXR0JUWGNSRq4
	lJZWJ89PdOw==
X-Google-Smtp-Source: AGHT+IGr/aLkFgMRkSjlxVh1xA+fX/na3/5ELahuHu4kuYZN2vLitNc/Cs2NtJ6FKvCmAN8Sir+chzojBjOS2Q==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:690c:b96:b0:61b:791a:9850 with SMTP
 id 00721157ae682-622b0168adfmr51024257b3.9.1715888313401; Thu, 16 May 2024
 12:38:33 -0700 (PDT)
Date: Thu, 16 May 2024 19:38:30 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALVgRmYC/x2MQQqAIBAAvxJ7TlCxwr4SHUy3WioLrQiiv2edh
 jnM3BAxEEaosxsCnhRp9UlEnoEdjR+QkUsOkkvFC1Gy6fC0M7suG834cTHeRea0VrxSvZUdQoq 3gD1d/7hpn+cFped4W2gAAAA=
X-Mailer: b4 0.14-dev
Message-ID: <20240516-kunit-compile-commands-v1-1-05fc32b79312@google.com>
Subject: [PATCH] kunit: tool: Build compile_commands.json
From: Brendan Jackman <jackmanb@google.com>
To: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

compile_commands.json is used by clangd[1] to provide code navigation
and completion functionality to editors. See [2] for an example
configuration that includes this functionality for VSCode.

It can currently be built manually when using kunit.py, by running:

  ./scripts/clang-tools/gen_compile_commands.py -d .kunit

With this change however, it's built automatically so you don't need to
manually keep it up to date.

Unlike the manual approach, having make build the compile_commands.json
means that it appears in the build output tree instead of at the root of
the source tree, so you'll need to add --compile-commands-dir= to your
clangd args for it to be found.

[1] https://clangd.llvm.org/
[2] https://github.com/FlorentRevest/linux-kernel-vscode

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/kunit/kunit_kernel.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 7254c110ff23..61931c4926fd 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -72,7 +72,8 @@ class LinuxSourceTreeOperations:
 			raise ConfigError(e.output.decode())
 
 	def make(self, jobs: int, build_dir: str, make_options: Optional[List[str]]) -> None:
-		command = ['make', 'ARCH=' + self._linux_arch, 'O=' + build_dir, '--jobs=' + str(jobs)]
+		command = ['make', 'all', 'compile_commands.json', 'ARCH=' + self._linux_arch,
+			   'O=' + build_dir, '--jobs=' + str(jobs)]
 		if make_options:
 			command.extend(make_options)
 		if self._cross_compile:

---
base-commit: 3c999d1ae3c75991902a1a7dad0cb62c2a3008b4
change-id: 20240516-kunit-compile-commands-d994074fc2be

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


