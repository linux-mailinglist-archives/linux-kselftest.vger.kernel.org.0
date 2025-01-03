Return-Path: <linux-kselftest+bounces-23880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 211E0A00CA2
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 18:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F02D3A3FDA
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 17:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7481FC7E0;
	Fri,  3 Jan 2025 17:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzpOfCHb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CFD1FC7C8;
	Fri,  3 Jan 2025 17:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735924676; cv=none; b=hc9l90IrY6blt52Iu+6B1qqTxeERujMhk2tgFGbeW9FKm8cU4RC0Mu0HaLbhhLSeEvYTrli4l+T1hhK+nBDmkXwB3XhktbDTOylUkaDcVxDNb5n/Az/Ibzd5CWQH4x23pCApW/qLSISJ71mKLWfYOZl98xEnvFCLa0g/28OKvRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735924676; c=relaxed/simple;
	bh=bLsg9Nmdz7tReG5pnUnO25339owtfT9ldR3GR65JQPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IBJtznSr5wWSYaNc3wH+DvYb7ChMwwnG41WW7gDiAoRvZ/CuCBbiyfRRVd7gesRT73hxBmoblOKxxaNyqguFyVnEh0hwuAfp/D1A0V0OwdRoALxB/WnDRrfF2gEyc8QuYhEOHrA/K261tTDegypU1oMRllCGkKrOrnJvtpHFITc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzpOfCHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09504C4CECE;
	Fri,  3 Jan 2025 17:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735924676;
	bh=bLsg9Nmdz7tReG5pnUnO25339owtfT9ldR3GR65JQPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HzpOfCHbuAHR3zTU5toBXqJNFvkmrS340YRMs71cbyLKmvhMyd54qRgE16zhwgNiR
	 zpvr/1cLQTzEu+scq3wH8vxdMLhksinpIeKvGjDLt5QvaxLg6vkwH/x7HCR3gRhM98
	 qQu/wrQWOVOrridsgxN542+5R9rQkUzqT2v0EpDlnKIh5PyevnAXAuoq9/9VvmMkK5
	 i1DhhwS7vFINBjQh7FJClrzTE7niALGB20XKCMmDBnDlqkVf292D9JjI/u7eaH3EcO
	 IKTFPQEpGpYN2k1fVOmbsVjjEq4ChZV3v/fJwq97ce16sHUG0bmnLJMaVVgPtl50GP
	 zcw56gco/WrDw==
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
Subject: [PATCH AUTOSEL 6.12 4/4] selftests/alsa: Fix circular dependency involving global-timer
Date: Fri,  3 Jan 2025 12:17:45 -0500
Message-Id: <20250103171746.492127-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250103171746.492127-1-sashal@kernel.org>
References: <20250103171746.492127-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.8
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
index 944279160fed..8dab90ad22bb 100644
--- a/tools/testing/selftests/alsa/Makefile
+++ b/tools/testing/selftests/alsa/Makefile
@@ -27,5 +27,5 @@ include ../lib.mk
 $(OUTPUT)/libatest.so: conf.c alsa-local.h
 	$(CC) $(CFLAGS) -shared -fPIC $< $(LDLIBS) -o $@
 
-$(OUTPUT)/%: %.c $(TEST_GEN_PROGS_EXTENDED) alsa-local.h
+$(OUTPUT)/%: %.c $(OUTPUT)/libatest.so alsa-local.h
 	$(CC) $(CFLAGS) $< $(LDLIBS) -latest -o $@
-- 
2.39.5


