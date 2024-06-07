Return-Path: <linux-kselftest+bounces-11405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E816A900919
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 17:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 488EEB26125
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 15:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF7B19EEB4;
	Fri,  7 Jun 2024 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEToTIEe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD4F199235;
	Fri,  7 Jun 2024 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774143; cv=none; b=s5Xi87xygf207HnIw3nbSCDoj2Vj/3lnDUwTl4QBvR7KKiGkHrRAhhGsmrDGG3Al2baB91/AyDJQefxEW3xEu8nSnbtF+uxd8zDtaE+vqFmW5yPdfcLYsmuqKGJy1Tm4Li9jwdp9vx2Pt1zipIG3a/hiAWL6jL8/dA7MKzAYEP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774143; c=relaxed/simple;
	bh=I+dIeYVudaaVppZA75Mhmfe5/A6IezUsfk2xb4OPEt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nfBs1zMhL8p5tG7EzynNzbnxlbRmoTIZAfHpYFk4CNcmjH8xvl6OFlHtWh9XO4Pavp5jciA7jC3bQdqDAePjxdD4u4nlKyEYHUI7DZb+VYa1MXYU3/K8Fan5oNtIjJ4jXHNWkHvx9bonEhMEqWeKtKVSRDOOYjcQ2DrS4fFfE3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEToTIEe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FC0C2BBFC;
	Fri,  7 Jun 2024 15:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717774143;
	bh=I+dIeYVudaaVppZA75Mhmfe5/A6IezUsfk2xb4OPEt8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mEToTIEemjqpbTxImmzQEa+R2S+QyCNCdN71rbWlVWvXr03fbhUywhcf+Ck8jXaqP
	 Qo1cfOYjdOEzdQBuRKcpEkuoWyWfXVVllo8YRHzKt+/KjceuEdxwaCXEnXuX95hHxL
	 oLcWx83rES2hiYoR3QNgpG3QtXwGVltUIZp0QOOasEDxEdU5xkksFVu5DM6SfT3KTo
	 hraidkRkEeScwMUIC3mCll+8/r4RF/KH6qkkSRdd4G3sxFUURS6kLPmbVWgoL9O5mb
	 UanjsvE8BnODMK5LCeaBSeLNaJakEyg79NmL7EOiYT8x/ymKJ3cYs9sCXBfNa/YouS
	 u6Skc9Bk0oMBg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 07 Jun 2024 17:28:33 +0200
Subject: [PATCH HID v2 13/16] HID: bpf: error on warnings when compiling
 bpf objects
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-hid_bpf_struct_ops-v2-13-3f95f4d02292@kernel.org>
References: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org>
In-Reply-To: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717774109; l=765;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=I+dIeYVudaaVppZA75Mhmfe5/A6IezUsfk2xb4OPEt8=;
 b=DSqErPEebU7kKkR8ad7F3DYOeoTE30eJ3em4Yn/FhZjAQfI5jnw5CAbuAffw1mZq61dkdUwr1
 mTYz1GLOjA0BsfKxVexNOnAp1MdnRvgKdUn0Eyvnt7XUTTNzlNFsu0E
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

There is no real reasons to paper over warnings for such small programs.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

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


