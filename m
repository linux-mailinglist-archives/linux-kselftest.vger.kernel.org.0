Return-Path: <linux-kselftest+bounces-16999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6435F968C58
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 18:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCD1283C03
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 16:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2D01AB6CB;
	Mon,  2 Sep 2024 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2CFJsCO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310A719F13A;
	Mon,  2 Sep 2024 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725295574; cv=none; b=ndspDVQ21+SYVGHOJa4K0nSD5Mu1SoJ1jp1pwuhcqN09hOQbdAqin9GMO3Ty/3/xF2ZDtIIObAjDzT2DBUnBzYLLCmtTrr+aU4LrL/cba4t4x/+i1D/B/Zt3Ji/Ci3sDokA3LtHGe4LVWYYTiCX3qH0A2yrYAmOaKSAR3IrYdbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725295574; c=relaxed/simple;
	bh=ZOrR0OdXFU035Sm7viikKM70jBcWIZYBHLfYOgH5DvM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bZO7393mxOV9nmhXEOsmSnHatclPgjIHDqPQQBMLqwfC3a+Ps4/KuVGjrxiFV920gMDJzDbHLCYPkFPaMLn26sCLOvEo9BQo0Euzy8g7AU5wprvFHavH+d0/ySxptcbmml8Gn3ZG6WwrZ8yd7hpSA2jMfF4bGYCwRXb5cYqDVzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2CFJsCO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269E3C4CECB;
	Mon,  2 Sep 2024 16:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725295573;
	bh=ZOrR0OdXFU035Sm7viikKM70jBcWIZYBHLfYOgH5DvM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z2CFJsCOvWXzFn7cVEUOwB1jXDH+w5wDQabGS6VrcECPtQmJFt473PLjA5Q5zS9uL
	 LMsGT5pQTVNzeUI3zil0FGOw11r5IR/0Jvk50tnRILiNsIDOYPe9nku9VIe7fc/j7O
	 5v45olV7UbDdGrkH2c7UEE0ToHjPQRn0D66mWEbzHHnLhEH6TT4tqvQmodBctdVUlQ
	 uqd4UzoIyA0lFp0DgExhpx5FhcKjjSOhmPoiAu+vem+Fc4CGMVgbBOc9IanlCm+eFe
	 oGlxL/r3FP6/J1PZua5k916IJ2SfrLk3fHxOx+XOunMw8wrrag4ZP/3ETskv1dlIjd
	 AYlaE2Ch7n2ww==
Date: Mon, 2 Sep 2024 09:46:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, ncardwell@google.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, fw@strlen.de, Willem de
 Bruijn <willemb@google.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 martineau@kernel.org
Subject: Re: [PATCH net-next RFC] selftests/net: integrate packetdrill with
 ksft
Message-ID: <20240902094612.6d40a914@kernel.org>
In-Reply-To: <66d4d97a4cac_3df182941a@willemb.c.googlers.com.notmuch>
References: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
	<401f173b-3465-428d-9b90-b87a76a39cc8@redhat.com>
	<66cf2e4bd8e89_33815c294b2@willemb.c.googlers.com.notmuch>
	<20240828090120.71be0b20@kernel.org>
	<66cf7b8d1c480_36509229439@willemb.c.googlers.com.notmuch>
	<20240828140035.4554142f@kernel.org>
	<66d1e32558532_3c08a22949e@willemb.c.googlers.com.notmuch>
	<20240830103343.0dd20018@kernel.org>
	<66d213cf6652e_3c8f2d294b8@willemb.c.googlers.com.notmuch>
	<20240830144420.5974dc5b@kernel.org>
	<66d23f2349f7_3d8dba29489@willemb.c.googlers.com.notmuch>
	<66d4d97a4cac_3df182941a@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 01 Sep 2024 17:15:38 -0400 Willem de Bruijn wrote:
> Changing kselftests to preserve directories turns out to be trivial.
> Patch inline below.
> 
> But, existing TARGETS of course then start failing. Because they
> depend on existing rsync without -R. In (at least) two ways:
> 
> amd-pstate fails because its TEST_FILES has includes from other
> directories and it expects those files to land in the directory
> with tests.
> 
> x86 prefixes all its output with $(OUTPUT) to form absolute paths,
> which also creates absolute paths in kselftest-list.txt.
> 
> These two are examples, not necessarily the one instances of those
> patterns. So switching to preserving directories for existing targets
> like TEST_FILES seems intractable.

I wonder how many of the targets actually need this behavior (it's
intentionally useful to them) vs they grew to depend on it accidentally.

> Plan B is to add a new TEST_PROGS_RECURSE, analogous to how
> TEST_INCLUDES extended TEST_FILES with optional path preservation.
> That is not much more complex.

Alternative would be to allow opt-in (diff at the end), I'm personally
biased against yet another TEST_* group because it's hard enough already
to make sense of the existing ones. Maybe it's better for the test to
"declare":

PRESERVE_TEST_DIRS


---
 tools/testing/selftests/lib.mk | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index d6edcfcb5be8..7be9bd583642 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -51,6 +51,12 @@ else
 CC := $(CROSS_COMPILE)gcc
 endif # LLVM
 
+ifeq ($(PRESERVE_TEST_DIRS),)
+RSYNC_INSTALL_FLAGS=-a --copy-unsafe-links
+else
+RSYNC_INSTALL_FLAGS=-aR --copy-unsafe-links
+endif
+
 ifeq (0,$(MAKELEVEL))
     ifeq ($(OUTPUT),)
 	OUTPUT := $(shell pwd)
@@ -150,12 +156,12 @@ endif
 
 define INSTALL_SINGLE_RULE
 	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH))
-	$(if $(INSTALL_LIST),rsync -a --copy-unsafe-links $(INSTALL_LIST) $(INSTALL_PATH)/)
+	$(if $(INSTALL_LIST),rsync $(RSYNC_INSTALL_FLAGS) $(INSTALL_LIST) $(INSTALL_PATH)/)
 endef
 
 define INSTALL_MODS_RULE
 	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH)/$(INSTALL_LIST))
-	$(if $(INSTALL_LIST),rsync -a --copy-unsafe-links $(INSTALL_LIST)/*.ko $(INSTALL_PATH)/$(INSTALL_LIST))
+	$(if $(INSTALL_LIST),rsync $(RSYNC_INSTALL_FLAGS) $(INSTALL_LIST)/*.ko $(INSTALL_PATH)/$(INSTALL_LIST))
 endef
 
 define INSTALL_RULE
@@ -179,10 +185,17 @@ else
 endif
 
 emit_tests:
+ifeq ($(PRESERVE_TEST_DIRS),)
 	for TEST in $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS); do \
 		BASENAME_TEST=`basename $$TEST`;	\
 		echo "$(COLLECTION):$$BASENAME_TEST";	\
 	done
+else
+	for TEST in $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS); do \
+		BASENAME_TEST=$$TEST;	\
+		echo "$(COLLECTION):$$TEST";	\
+	done
+endif
 
 # define if isn't already. It is undefined in make O= case.
 ifeq ($(RM),)
-- 
2.46.0


