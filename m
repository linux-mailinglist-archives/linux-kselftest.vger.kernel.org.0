Return-Path: <linux-kselftest+bounces-19011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F012990051
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 11:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91051F24650
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 09:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1825C1487DF;
	Fri,  4 Oct 2024 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlImvfew"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF91714659B;
	Fri,  4 Oct 2024 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728035638; cv=none; b=oiyoIeWRi+gvqQFq5y++4O5zqWQ7wais/gywEi0HTPT5DTF+XA9+7aTzgDPLO92C+esE7AxPBCaxDUy3mE3CK56hNVzdPHg1jMWD8vGSB3vTjTvPsqeIZBYKSmk/brUybxyHEx7+n74jLv6HtMk+G/EzfTDMbcYXDRtOvOKHvnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728035638; c=relaxed/simple;
	bh=+gpexw+GwzFZ1lHSAbDPE9XzLQf8wRp0a9tbaMAgoHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aINnCqSN+SnxujzrQqvkXn5hZwuB7MujeC4YxNZ3ApEsge82YW9CeTZqDL+KZGoWjP7Pwx/gJsFOCRlVy0qrXLODZH7g+4XeyoNFV565V4/d+yelBJKFYmvNOw3NIARZqkUEvCAfFbAcxJJIVHMnBGYnq9Awvh8qLaveIrLus0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlImvfew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55C4C4CEC6;
	Fri,  4 Oct 2024 09:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728035637;
	bh=+gpexw+GwzFZ1lHSAbDPE9XzLQf8wRp0a9tbaMAgoHY=;
	h=From:To:Cc:Subject:Date:From;
	b=IlImvfewMB2ZAGEK2TtFwv+s6oPed/fZfd0vY+v7tn6rsY8dKyGaWZVUbxH8/FiaP
	 TJbDmjgthJAyCsX394bPOyNilMqhBu3rw0ayhCGQ2sc/szq0bxxU19Py2QuvwJjtfB
	 S4hduUL0Fgqx60GcBoiXUSZb9ZRHBtcN2aIekUzncWB5EvGrh6lUrqHqnJXHiVuE+8
	 QuiK6JrVE+ZpdiDFvSSuIAKeDOdlnKfXd6/oS+bNCD/GmDw7fRyug1TwFJC0mTJNIz
	 5e9obZNTkgni0SmOkfMQVh5IJl06s/ivk1q5JUWiv1B5E+6/D4uI+EfKncv9E/Zs8J
	 CVVjnAte6oRSA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: Do not skip BPF selftests by default
Date: Fri,  4 Oct 2024 11:53:47 +0200
Message-ID: <20241004095348.797020-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

This effectively is a revert of commit 7a6eb7c34a78 ("selftests: Skip
BPF seftests by default"). At the time when this was added, BPF had
"build time dependencies on cutting edge versions". Since then a
number of BPF capable tests has been included in net, hid, sched_ext.

There is no reason not to include BPF by default in the build.

Remove BPF from the selftests skiplist.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index b38199965f99..88f59a5fef96 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -129,10 +129,8 @@ ifeq ($(filter net/lib,$(TARGETS)),)
 endif
 endif
 
-# User can optionally provide a TARGETS skiplist.  By default we skip
-# BPF since it has cutting edge build time dependencies which require
-# more effort to install.
-SKIP_TARGETS ?= bpf
+# User can optionally provide a TARGETS skiplist.
+SKIP_TARGETS ?=
 ifneq ($(SKIP_TARGETS),)
 	TMP := $(filter-out $(SKIP_TARGETS), $(TARGETS))
 	override TARGETS := $(TMP)

base-commit: 0c559323bbaabee7346c12e74b497e283aaafef5
-- 
2.43.0


