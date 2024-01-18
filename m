Return-Path: <linux-kselftest+bounces-3204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A4F831C26
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 16:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD623B2239D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 15:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4191E532;
	Thu, 18 Jan 2024 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="FPbTCBVG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156901E87A
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Jan 2024 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705590890; cv=none; b=mlu35cvc8FzUFoh7M3DGhUu7NbdOvXrMw8NDIrE0rQ6s09/VfpHC7BQ+Y1qGb9i2Zz+6Z+3M3j856v5bJXZnpNE/czIAqSpNvwK9MyehsrcGVKwVvT3EqX5NgHQb3gf5Egi90YLeF5HJ2aGEIN+Od1QLSzN1+tif842hkF3MudI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705590890; c=relaxed/simple;
	bh=wfzdWmYDsVMkIW15jvoUKY33rmNyFvsiWxU9CCXHMb8=;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Infomaniak-Routing; b=bvOeot2jo3OTZEqP369ACed1mrFbpqAwINAN7qm4ZREyr+IghPqNVs2lcPjmL6A9SDkowZCDAlxx/hbF+Jdg+TesMsjbcXxhBfHp805Od9OuzViCue/IIbb2bZH62jq+q3DvLVXsgq86v2ZE0xkutFzJzNhNRVDzP0Pivt+NXAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=FPbTCBVG; arc=none smtp.client-ip=84.16.66.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TG5rY03mCzMqv5w;
	Thu, 18 Jan 2024 15:14:37 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TG5rX278Nzwp;
	Thu, 18 Jan 2024 16:14:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1705590876;
	bh=wfzdWmYDsVMkIW15jvoUKY33rmNyFvsiWxU9CCXHMb8=;
	h=From:To:Cc:Subject:Date:From;
	b=FPbTCBVGfHToxWHSgyc9ArZ2VURiu12BhSGSS51xW08uHuk33uBq5UBeXkRXE9Oz6
	 bFqP6BpeA9LxcM7m8rNh8gihebbooqnR8E8nRNjnj7ylo3ckjkYujx7fiF00kTrXNI
	 pv8tSLxEMIxjR9+SrHoBGjwN8LTUDDMWWTrq034E=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] kunit: tool: Print UML command
Date: Thu, 18 Jan 2024 16:14:22 +0100
Message-ID: <20240118151422.1966309-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

As for the Qemu command, print the command used to run tests with UML.

Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/kunit/kunit_kernel.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 0b6488efed47..7254c110ff23 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -146,6 +146,7 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
 		"""Runs the Linux UML binary. Must be named 'linux'."""
 		linux_bin = os.path.join(build_dir, 'linux')
 		params.extend(['mem=1G', 'console=tty', 'kunit_shutdown=halt'])
+		print('Running tests with:\n$', linux_bin, ' '.join(shlex.quote(arg) for arg in params))
 		return subprocess.Popen([linux_bin] + params,
 					   stdin=subprocess.PIPE,
 					   stdout=subprocess.PIPE,
-- 
2.43.0


