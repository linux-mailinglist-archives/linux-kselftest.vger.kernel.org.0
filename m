Return-Path: <linux-kselftest+bounces-10787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AB08D1CAE
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 15:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5271D2854CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663D7176FCF;
	Tue, 28 May 2024 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwMtJSDW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358EE16F292;
	Tue, 28 May 2024 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902147; cv=none; b=SyrjlGbd+8ozr92O48C+Evim2dQP2HUbjKMFS8MebmyxBpn1J3csTNfLwG+OZF1P/LOnhGYIk69g2KamCs6OXqJq1rxtnbXSkLASn15muYxGpS38NIM0Lm3O/1D92VlGGBFRjojtdCzT/NA3c6ycsjwwLONWgScHBxShA6fbisw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902147; c=relaxed/simple;
	bh=Tr1yyl5glZHjQNVjRPObhpi0VbS6TeTAGCRSkl0ml0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bG7c8HvsDFOtfYsoP/9b1GDZCChwkWLDz2KcX2J7H5M7FXRo8XztBdDzeBBPsLapXnVX3MLZ2370rw5S9H1cg3OP56uvdVr2nEA5D2VTN4DpCStjJ+F0AMEffVTpxxtq3QYpKRoJ0tueLGDA18mKKqSDsBOSAhFc+RNePbTqzyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwMtJSDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CA4C3277B;
	Tue, 28 May 2024 13:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716902146;
	bh=Tr1yyl5glZHjQNVjRPObhpi0VbS6TeTAGCRSkl0ml0o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TwMtJSDWPlzw5fDvIRqsukaJzOvsTmwKO7Un/0JdBdOdTfgD1/ceFpckunTXnRS1B
	 3DfhAj6WRP/p8mXGE26jZqwAgBiFk1w2rSAHhjyIK4ea9qMc2FKgrMiLLUUtTd5E1Q
	 TxHmmzKvTV9A41HSxhhcOu76csJkauFYMaPWemJWE5Lhj7JZLDyXkBrehzv478E0Nl
	 Cfux73/Tsh3G8xowzc7fqV3wFF07nbNaEU0IdGVjJ3nr1P55NR7+s/JqyZAmnEbfZ7
	 k1p9UsKpaG7e12fZmJUOawIt9b8JtUITIRCRfMlLMtnxouFFxFin6ZMfCCJMwPjVZl
	 N2fWBYOMnjEkw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 28 May 2024 15:14:51 +0200
Subject: [PATCH HID 13/13] HID: bpf: error on warnings when compiling bpf
 objects
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-hid_bpf_struct_ops-v1-13-8c6663df27d8@kernel.org>
References: <20240528-hid_bpf_struct_ops-v1-0-8c6663df27d8@kernel.org>
In-Reply-To: <20240528-hid_bpf_struct_ops-v1-0-8c6663df27d8@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716902113; l=738;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=Tr1yyl5glZHjQNVjRPObhpi0VbS6TeTAGCRSkl0ml0o=;
 b=qxiMEpLA+Im0ChWCITPIRK6TeeA/TJVdvPQGZsHorM0DpzVPYNhMnXntGCTYXbSlMKw16m8on
 rlOPAfnnqQDB6Wir5YKJ+ohEXsRXC4xGagLLtLa8oWalMqZiQMk6HEi
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

There is no real reasons to paper over warnings for such small programs.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
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


