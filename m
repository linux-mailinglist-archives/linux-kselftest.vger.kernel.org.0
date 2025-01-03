Return-Path: <linux-kselftest+bounces-23881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E84A00CAA
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 18:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226313A4631
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 17:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836A91FCF45;
	Fri,  3 Jan 2025 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btpj1l4D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556871FC0FA;
	Fri,  3 Jan 2025 17:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735924685; cv=none; b=KLNmLXLwtep/au+MZP3q9m2uUxnL7by5zLe4kZtcn5dwYAjCjH/29PFO7inm0HqjyC9aAVFTi9qI3jMy0l636DN7i+HCBExHOHAg6JDMjkxOg8GRzJ21252k256V/acUO9XaCl2tsl7ceWPabtfNtBL3VSxHXJF0P5GVMJdtZ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735924685; c=relaxed/simple;
	bh=SqCjzWuL9FY9OVHCuPhbiYvaKmVxKTYgjqxCFqz1ytI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pxDSitA38H3QWOwy6emytZc4KR9VJk98g23hZbX4N08h3EeidTCSVSVEVa8ckUIU6cCmHeJQCpH0+bV1AIGrdNrX7jE8r0znopZC7C4Nr6eEtzECGW+/z6FoauVYWZbBHRA2QpEwL8di44gMw6G9wkyBpbxM2S1X9zJp+sjZ+Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btpj1l4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A331AC4CECE;
	Fri,  3 Jan 2025 17:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735924684;
	bh=SqCjzWuL9FY9OVHCuPhbiYvaKmVxKTYgjqxCFqz1ytI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=btpj1l4Dw0lF+zMuDN6WGqtK3vb9fMChTb3mkkmDSqRtX+TEPX+Io2sB0seNxWqPO
	 5yLlt3G56fmdVmzysxpjTNfgnBtnJ6Yqv1DUvKpyWajjcznGx6dx2K98BUDhl7714f
	 AQ/SIWGo6IL2XK8B1bMvxEtB+n4zLCFV+GHQwD9ePrapLtwNuiijyQH+mD0pSvvPJG
	 FF+i62PG/HaMTT5cy+D2MEZ0j5nhTkYrc45nO5H6+GsrbRQndJK99Tbg+Q85vET8BB
	 H9UfVDn1kSWu+jZq0dMWi+AvjtC+z2b2TPJ8YMBIxzGTVjIsj/xTfOOwawnvz5K5Cu
	 QlA+YntrgKwxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 3/3] selftests/alsa: Fix circular dependency involving global-timer
Date: Fri,  3 Jan 2025 12:17:56 -0500
Message-Id: <20250103171756.492191-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250103171756.492191-1-sashal@kernel.org>
References: <20250103171756.492191-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.69
Content-Transfer-Encoding: 8bit

From: Li Zhijian <lizhijian@fujitsu.com>

[ Upstream commit 55853cb829dc707427c3519f6b8686682a204368 ]

The pattern rule `$(OUTPUT)/%: %.c` inadvertently included a circular
dependency on the global-timer target due to its inclusion in
$(TEST_GEN_PROGS_EXTENDED). This resulted in a circular dependency
warning during the build process.

To resolve this, the dependency on $(TEST_GEN_PROGS_EXTENDED) has been
replaced with an explicit dependency on $(OUTPUT)/libatest.so. This change
ensures that libatest.so is built before any other targets that require it,
without creating a circular dependency.

This fix addresses the following warning:

make[4]: Entering directory 'tools/testing/selftests/alsa'
make[4]: Circular default_modconfig/kselftest/alsa/global-timer <- default_modconfig/kselftest/alsa/global-timer dependency dropped.
make[4]: Nothing to be done for 'all'.
make[4]: Leaving directory 'tools/testing/selftests/alsa'

Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Link: https://patch.msgid.link/20241218025931.914164-1-lizhijian@fujitsu.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/alsa/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
index 5af9ba8a4645..140c7f821727 100644
--- a/tools/testing/selftests/alsa/Makefile
+++ b/tools/testing/selftests/alsa/Makefile
@@ -23,5 +23,5 @@ include ../lib.mk
 $(OUTPUT)/libatest.so: conf.c alsa-local.h
 	$(CC) $(CFLAGS) -shared -fPIC $< $(LDLIBS) -o $@
 
-$(OUTPUT)/%: %.c $(TEST_GEN_PROGS_EXTENDED) alsa-local.h
+$(OUTPUT)/%: %.c $(OUTPUT)/libatest.so alsa-local.h
 	$(CC) $(CFLAGS) $< $(LDLIBS) -latest -o $@
-- 
2.39.5


