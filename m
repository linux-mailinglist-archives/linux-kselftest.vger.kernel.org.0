Return-Path: <linux-kselftest+bounces-31951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD65AA3B6C
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 00:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9421B641A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 22:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982CD274FCA;
	Tue, 29 Apr 2025 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w7N2F/o3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674ED2749ED;
	Tue, 29 Apr 2025 22:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745965636; cv=none; b=B6OttkFdwGsqrkQoJI/dqxP0PGqxw6+f1Kg3oZpYI7lO6EZcVDbrQLrsurbdU5M6kyS0wWHlS3XBY3SaaBfFsIHaAE2M+pyem+DpNeUiYYXX3vg7JJnghweJ5YlhR0+zYdjctqM6jZy8Da7M5aSIlN7rd8W76DoDvzYW0fwJakU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745965636; c=relaxed/simple;
	bh=TV74GC675wYGYzsypg9i0fSQNXZ07KR0kg/ArHgBzUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PcGsGZNLdSDsmkMxEYarfczpLlhM7URaj22mX2SjkCOnjfFY8W+cR187IHAXKZypEdDNesGDE60a/+Onb3R5/YB0Bizq2u1dZiJAPFh8dEghCvhnUrls0gctMFVOMPLFjGd80kBLLKZLcCLkZ3NaHw+WJV9IBtc4pyFI/Dy6FTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w7N2F/o3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1476BC4CEEB;
	Tue, 29 Apr 2025 22:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745965635;
	bh=TV74GC675wYGYzsypg9i0fSQNXZ07KR0kg/ArHgBzUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w7N2F/o3/Bd1+y0glRtqa+BtqS462+UTOJ7uR8HTev7WDuXd2H11BgEMFF/snket/
	 OgrCUN6cdekozvRl6usf4AhlOUlPi0RoTnK35eYwSFOPgiSUgDZe2spfwgIVNkr9MX
	 5WvJJh0U9BwEEgiVR1EwWVzIiKdHBwK74ySAh8N0=
From: Shuah Khan <skhan@linuxfoundation.org>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com,
	corbet@lwn.net
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] doc: kunit: add information about cleaning source trees
Date: Tue, 29 Apr 2025 16:27:11 -0600
Message-ID: <7104475f60568f6a580b03d84e61abe311d63e46.1745965121.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1745965121.git.skhan@linuxfoundation.org>
References: <cover.1745965121.git.skhan@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If kunit run happens in a tree in which a x86_64 kernel was built,
the source tree could be dirty.

"make ARCH=um mrproper" will not clean the x86_64 build artifacts.
Running "make ARCH=x86_64 mrproper" is necessary to clean them.

Add this information to the documentation.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Documentation/dev-tools/kunit/start.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index a98235326bab..568e29aebd6e 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -39,6 +39,18 @@ can run kunit_tool:
 	``make ARCH=um mrproper``, just be aware that this will delete the
 	current configuration and all generated files.
 
+	You may see the following error if a prior build leaves behind
+	header files which 'make ARCH=um mrproper' fails to clean:
+
+	"undefined symbol sev_es_trampoline_start referenced ..."
+
+	This is special case scenario when a prior x86_64 build populates
+	the source tree with arch/x86/realmode/rm/pasyms.h. This header
+	will not be cleaned by 'make ARCH=um mrproper'
+
+	If you encouter this problem, run 'make ARCH=x86_64 mrproper' to
+	remove generated header files.
+
 If everything worked correctly, you should see the following:
 
 .. code-block::
-- 
2.47.2


