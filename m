Return-Path: <linux-kselftest+bounces-18479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42C498861F
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 15:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96AC28266C
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 13:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB7618E05F;
	Fri, 27 Sep 2024 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcAAV3e9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE8B18E04B;
	Fri, 27 Sep 2024 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727442854; cv=none; b=bp/wlE/oebjbofrL9g6ND+LzFyKDIr6mOWaP0aq3GGTlnPimkccR3lApfhGRM21lV4PFgbJot/RCmVloZxaK6xphtu59YPaE2VqdR/2tSK7RL4nj+B1ehpmcgyHYsirzxf2W1RxmJMxOzKlvTW2IAoa93p1PpeA/Oa+6JJ/V7rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727442854; c=relaxed/simple;
	bh=lD7X3F4aQ/DImEMn86wtBbghQxJBS+VINHajn6ohurg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P26y3I3vLI8lKnfiEtnnqvSC4ASDGl2BhIsDCST6BHDi9gafdwV6apsuWMaJQfyHQAis2hjeA2/HuMYZjfdex9+wOhgIz2OkC+HEhOyjFqe2Qqzu5JnZ4XsAsLcNjN//AX/OJoZ3pnlJTXPC9CESaZ/GUrpHlWHKPoHy7X0s/uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcAAV3e9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D65C4CECF;
	Fri, 27 Sep 2024 13:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727442854;
	bh=lD7X3F4aQ/DImEMn86wtBbghQxJBS+VINHajn6ohurg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HcAAV3e94G5tfukXw6esqeXcQngIwF6ANCFn55VINpxDqY+aXJe+qTQAw/QXDna4P
	 tEPEqoVP9orhnYRsUUsvO/kn/UAEnddgJIb1hXW8nNlJ7QBxbuEK1QZtmkORScMCJK
	 0X/uCPHyFVRPF0jLHfpHWSNHmJVkog+TxTb9SUW1ZosS7wSI2vL1auCike6htB/2SJ
	 UaqomXoJj1vpV6DaiazieraciOTcpAJo8AKDW0CfS5ws7ICZ1D1Cfs9yiLV5ruU+id
	 nBWtslwECXay1dByV2zMHZc85rs9kNG3qBKX7jLRXaE023R79ZSIY8kem/1fi1MTCT
	 iZA/RFziNyQWg==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH bpf-next 2/2] selftests: bpf: Add missing per-arch include path
Date: Fri, 27 Sep 2024 15:13:53 +0200
Message-ID: <20240927131355.350918-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240927131355.350918-1-bjorn@kernel.org>
References: <20240927131355.350918-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

The prog_tests programs do not include the per-arch tools include
path, e.g. tools/arch/riscv/include. Some architectures depend those
files to build properly.

Include tools/arch/$(SUBARCH)/include in the selftests bpf build.

Fixes: 6d74d178fe6e ("tools: Add riscv barrier implementation")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 365740f24d2e..d6a53afa449f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -10,6 +10,7 @@ TOOLSDIR := $(abspath ../../..)
 LIBDIR := $(TOOLSDIR)/lib
 BPFDIR := $(LIBDIR)/bpf
 TOOLSINCDIR := $(TOOLSDIR)/include
+TOOLSARCHINCDIR := $(TOOLSDIR)/arch/$(SRCARCH)/include
 BPFTOOLDIR := $(TOOLSDIR)/bpf/bpftool
 APIDIR := $(TOOLSINCDIR)/uapi
 ifneq ($(O),)
@@ -44,7 +45,7 @@ CFLAGS += -g $(OPT_FLAGS) -rdynamic					\
 	  -Wall -Werror -fno-omit-frame-pointer				\
 	  $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)			\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
-	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
+	  -I$(TOOLSINCDIR) -I$(TOOLSARCHINCDIR) -I$(APIDIR) -I$(OUTPUT)
 LDFLAGS += $(SAN_LDFLAGS)
 LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
 
-- 
2.43.0


