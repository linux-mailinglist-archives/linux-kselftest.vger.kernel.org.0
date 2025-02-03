Return-Path: <linux-kselftest+bounces-25543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80609A25551
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 10:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3151886919
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 09:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD8F1FFC59;
	Mon,  3 Feb 2025 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JhMKYXZh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sjZoTqPe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E585E1FF1D2;
	Mon,  3 Feb 2025 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738573526; cv=none; b=g0E6FSxJaqOXf/CqmgO38CQbLCpw0L7jjchKhFVJOX+bdw+gs2Ml5VDmcX91yoVO3VFWyxi00pqelr8n+ZUENlY4MoqBwsTHIjrMyjeddJjGoDyzlSlTcNHGDogP7bKkJt2c4O0qJpOmExGyjDNlH1tjz6R6upfrn/+JYQhq8pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738573526; c=relaxed/simple;
	bh=0OYIxTlpnbjEhvswabtZg49j38hT3MAFwMnYXuy7rHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YCqO7nuHP5nN/scx9bA0iz9nuNXZGIbLSa4NRlOjM2J8WW93NC59tF9478EIEGvzIguypTeEZcMyVCkATHdncxrvY3ho0iw2J78lkwENueLSK6jCBHX+9Eq9pvABUxb+RmVq0ONrWYpDuVTgjI8ubPg3zrIoKNthhM+TzNdq/MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JhMKYXZh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sjZoTqPe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738573522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sG/oZgAVhh6ntwQfY2W+UbeC4PlDV/c3H2R+4urGbL8=;
	b=JhMKYXZhVSl8/w2BmQY+EqIs3pyiQ1lhM0emDgv0arK+K4XfGigIh+g7r0at1+9pdkHLaV
	BEDeI0QuP5p2TSNd7UcHI4NU5k/ph0uuA3OrMPWoMI6Xg9xCBm0mh6N2wJPUumv53sSPSg
	jL6FXZz5CdlgIxGLAYDIyDs2pVr4njxIO9MAQ/YKVAH80I3CQPxXcCx/QgeUJYzh+Fp3+v
	rwpHneaSmTQZujuYiT7zMvIFTTSt22ck+3CsHkeKfaSkBQsDE4PMEIFzV2RxeOgTYch/7U
	AcVJEAcWLxm//knVgt04bowdoOenBJzIBREKOl5QDJ9UsN9f+OedDsp6JRfQvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738573522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sG/oZgAVhh6ntwQfY2W+UbeC4PlDV/c3H2R+4urGbL8=;
	b=sjZoTqPehK2ud05RLSFDc5lU4mzS47xZKf+CsUnMXqFCM4Bm54cCYDsz1eW1TtpPW2KZbw
	nGrE4YodtXB7OtBQ==
Date: Mon, 03 Feb 2025 10:05:09 +0100
Subject: [PATCH 08/16] selftests: Add headers target
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250203-parse_vdso-nolibc-v1-8-9cb6268d77be@linutronix.de>
References: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
In-Reply-To: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
To: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738573516; l=1095;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=0OYIxTlpnbjEhvswabtZg49j38hT3MAFwMnYXuy7rHo=;
 b=7OFfX8P7FhSczFpGy/axi3iZncIH116trhlD/v/wjEr2m0wr4S0g/2HGcyDlWkMjKCfp4pL/9
 UfyCKzpFw7ACjbY83Xh0CMIYZqw0+FIc4YHGYKq3pWuiltxDT9sA6C7
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Some selftests need access to a full UAPI headers tree, for example when
building with nolibc which heavily relies on UAPI headers.
A reference to such a tree is available in the KHDR_INCLUDES variable,
but there is currently no way to populate such a tree automatically.

Provide a target that the tests can depend on to get access to usable
UAPI headers.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/lib.mk | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index d6edcfcb5be832ddee4c3d34b5ad221e9295f878..5303900339292e618dee4fd7ff8a7c2fa3209a68 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -228,4 +228,7 @@ $(OUTPUT)/%:%.S
 	$(LINK.S) $^ $(LDLIBS) -o $@
 endif
 
-.PHONY: run_tests all clean install emit_tests gen_mods_dir clean_mods_dir
+headers:
+	$(Q)$(MAKE) -C $(top_srcdir) headers
+
+.PHONY: run_tests all clean install emit_tests gen_mods_dir clean_mods_dir headers

-- 
2.48.1


