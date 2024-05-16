Return-Path: <linux-kselftest+bounces-10314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 028EB8C7D61
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 21:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952751F21B13
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 19:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB4F156F43;
	Thu, 16 May 2024 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sWHzItkG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E7E156F53
	for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2024 19:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715888465; cv=none; b=LX+wfRXCkIpx/hPkJnPmJuMq+9qlt64yQxgC7Rz/TSjVaehV5II8q7ukfuzQ42aVcL5F/dMBeNMwIVs+BcoiUFBj73FuT+vCWU5i+CT9Z8g6KdbNlRV431ZpUwWJ0hg9uqT0ugZ+ONv5VYknHfktxIjvc/jT5UgmIGumMvD2KfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715888465; c=relaxed/simple;
	bh=qRGrAjcAOw/BpdIDpIw29VUbCdUpk5nCvIPyhVcCtco=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=neSfsDqTeDuJJ1aRp+KJHXnSNBRAcsoURPK81/7w+ObcPURMlxuCqgRlbHZDFX9UKd7it5qXF5PZPjyvyXU1//2bi87LCitqWt5BtFlxefSsG798UdSQLPqaSMmSSaZ3J7S0p5g1VWNP8mzRlZRrfqX+exta0k0zOiFOfGJ1xaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sWHzItkG; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-622ccd54631so97189347b3.0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2024 12:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715888463; x=1716493263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e1P6Db3qkzX3owazVizLczKyUZgazBAYnFdo7ANHUs0=;
        b=sWHzItkGsGuUcWNOxHQF3Ctt3honpuyXin7TXnIw6s5PN6d/3ojvgknGkawPtGAWuz
         Nfy9MQZ+fO5xRSjPAJrK6MjYZDpqOCPQpn1xvm7qHEkv4o7WI6dfXPyxONWZc9358Z5S
         80XxFwYwtxU9+Td8F7wcyZh+fqL8/iuUO0yUgG/+SNMi6RvaJKy+OE0yfStjZrwNsr+9
         8Zwbw0Q2thAu5A+tfUyAP832Ww7XGzXaKopSI3WX276AYxVCWC5RmiGrptMImtWYIZbq
         Sqa7Kr5qQDg0StHwcTIoX61pJQYDqvO9vLyLOr51QKSCAHVMWRmCdeWnaOXnOUFoQhOy
         hDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715888463; x=1716493263;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e1P6Db3qkzX3owazVizLczKyUZgazBAYnFdo7ANHUs0=;
        b=McK7nxI7ZXlbldPG4bWzEZp4xI/BRnrv+1mA3MQWb9nrrBxInydrnr22gyhuOYmdUb
         ryrE5uYFlsprAN2syLdB4dubxhc+VynykpFSEY/XQCcNn/kGrmp4U5jZFKFlrkaremq5
         m3O5Tf2Zh4Nca6GphYdoWTl1Wg1D6cq3CAdfMGV8C2uR6H0I4+QC0Y2gpAykOdUB60Ht
         TfyfFfyrBo+7OT15/ZMBkkm3/X5auspevnfOF5A/Ro5I+e1/8Mr3FcblhHyIsY2Kg0b8
         gj+B2Xg+mhWmOpkFny9lzz9jroCIZvPfYI1906NXgaod38DkOXreF7psZgq10GZqUeU0
         su6A==
X-Gm-Message-State: AOJu0Yz91WKCz2+Lxy7NxPleGqzvLGL6wFeoOnXgiFhDycdoH86OYQyl
	LIg6Ni8XWGrP3SFWIPcnppPpTLnDiwpl7zuZPLTkom+ocTyw9LHicBuJay2JXd4kFvvdgoCD6/g
	RWazpDKkYhA==
X-Google-Smtp-Source: AGHT+IFN8NHYHCx0Mp5JwPViDfrjX4xtgJESmyjLorrTrnPM7FlMf7IPZ+ZzzNyfzySoyjQbNXwc78fPagVkYw==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:6902:1142:b0:df1:d00c:130c with SMTP
 id 3f1490d57ef6-df1d00c1507mr450667276.5.1715888462994; Thu, 16 May 2024
 12:41:02 -0700 (PDT)
Date: Thu, 16 May 2024 19:40:53 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAERhRmYC/x2MQQqAIBAAvxJ7TlCxwr4SHUy3WioLrQiiv2edh
 jnM3BAxEEaosxsCnhRp9UlEnoEdjR+QkUsOkkvFC1Gy6fC0M7suG834cTHeRea0VrxSvZUdQoq 3gD1d/7hpn+cFped4W2gAAAA=
X-Mailer: b4 0.14-dev
Message-ID: <20240516-kunit-compile-commands-v1-1-86e61857c820@google.com>
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
the source tree, so you'll need to add --compile-commands-dir=.kunit to
your clangd args for it to be found. This might turn out to be pretty
annoying, I'm not sure yet. If so maybe we can later add some hackery to
kunit.py to work around it.

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


