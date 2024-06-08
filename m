Return-Path: <linux-kselftest+bounces-11483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AF09010E3
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 11:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19DE51F2149D
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 09:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7833C17C9F1;
	Sat,  8 Jun 2024 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shD3lBca"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4686D17C9E7;
	Sat,  8 Jun 2024 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717837312; cv=none; b=PhHNnmjdj1dxuVeodJtO7gxK26eWoJPlmvqf6wmBNkMb6v6MGYLJev7JkgjM8vf3ln/66uxLA2TZXxMd+tigvMl1eqM9bbCvPhUqXsIrzmxeqU49ouvAcfCLOTsM+U4874Qt2mVvjCdJfQE9R8uCVjPbFjjEvO0VrYYYkbnmZYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717837312; c=relaxed/simple;
	bh=vy4mezYjZtrXyMz65bPN043/fx8Jb4rfGeuYveZNR50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d+H4gqR8EU4KyGeDv71xsGxnp/pwCZTfJ7WRhImjsfvdUfyLXBN8bEDiyUenGLaND5QtkQCMpWuoCuNKuFD+0ZEz9O/YpASM7FIhm+27UPov/R/Z/FFsL0+Ra8ndC0tao6Xf5G8MzW3CJuvC9PoRiQm++FLKzlVGpZNurJMtUa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shD3lBca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F1CC4AF08;
	Sat,  8 Jun 2024 09:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717837312;
	bh=vy4mezYjZtrXyMz65bPN043/fx8Jb4rfGeuYveZNR50=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=shD3lBcaP5UhqoE5qXZlKCoGjv5f5sg2Mk9aSUx7NocZGD6xG+sKDANnxFAU0IvvA
	 fJAUonGfBakyAtIe51DEdavCWka2UQZn1KPFUSg+/coZiXW4NGCfEgw/Av3QjqiKF5
	 VLsJw8v7mkmqhcreySIducfjBsySf6bSzPET1E2O3l+6wf9EZyGK72sNsL1urJGx6L
	 WfnU+qxisv49f0+rYMfuMT3eRG92hS8j5Fb5Rzq16CPUDf3I6TmOyZmuLzYv8Qdvld
	 Mo8lRnMZyZMrhP0OlAeXSIcaCdpHlmbBRjV/houRP4qK/uHExaXZ2eK1sBz8Qq+dyy
	 2ZUIOxmH3SKvQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Sat, 08 Jun 2024 11:01:25 +0200
Subject: [PATCH HID v3 13/16] HID: bpf: error on warnings when compiling
 bpf objects
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240608-hid_bpf_struct_ops-v3-13-6ac6ade58329@kernel.org>
References: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
In-Reply-To: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717837279; l=785;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=vy4mezYjZtrXyMz65bPN043/fx8Jb4rfGeuYveZNR50=;
 b=Cm0xeT6L2mEWnBbNTcNf6Eg2hL1BMyLChleBIQdszevtTvtVQR/Z/dSkx4uT1I2L8TQXEur1Q
 mL2VetAFIfCATyvns1fvYG0G2x56sNVJfbnCXSHaPUUziQLxcaI1D91
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

There is no real reasons to paper over warnings for such small programs.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v3

no changes in v2
---
 drivers/hid/bpf/progs/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/bpf/progs/Makefile b/drivers/hid/bpf/progs/Makefile
index 63ed7e02adf1..ec1fc642fd63 100644
--- a/drivers/hid/bpf/progs/Makefile
+++ b/drivers/hid/bpf/progs/Makefile
@@ -56,7 +56,7 @@ clean:
 
 %.bpf.o: %.bpf.c vmlinux.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BPF,$@)
-	$(Q)$(CLANG) -g -O2 --target=bpf $(INCLUDES)			      \
+	$(Q)$(CLANG) -g -O2 --target=bpf -Wall -Werror $(INCLUDES)	      \
 		 -c $(filter %.c,$^) -o $@ &&				      \
 	$(LLVM_STRIP) -g $@
 

-- 
2.44.0


