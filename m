Return-Path: <linux-kselftest+bounces-3566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3905183C27A
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 13:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE231F24EBE
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 12:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72A445974;
	Thu, 25 Jan 2024 12:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zb5oRwwy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DBD482D0;
	Thu, 25 Jan 2024 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706185642; cv=none; b=QjLN1xinvWRSkd+PhvQbTHmE2A1Y6h3ka9Z4GEkqNgAY9FfuPjXKaDOqYCkQjS9nNwx37CULP0TLTSiZ9bZ2zfkxSpQ045X8Y0CWYJK/HYFI7sXETuhy7u6MUB6MInE8txlj/Q8i5GfNX3CmxOyzvQ9OK+uI3jIkI2AxSFxj3gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706185642; c=relaxed/simple;
	bh=wh37IMxjc+9bQCZsbY1TgpxkregHG9E9PMlCKKotk7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nLSlQHbCD2Kah3qlD6xcRSn9F5rRR33lYUSNCa8KXHPFfuDpOy85kzWnbCyp74t1IoFSBGtKa6Mu0NvWMzfL/8KKYWsuijIKWDV7srXa707+vyS9sIJ6rhYJof469ZZWwTVt3tUp+aC0lcc88Hg5qRUBagdWwNzs9V5QHPPRmOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zb5oRwwy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC4FC433C7;
	Thu, 25 Jan 2024 12:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706185641;
	bh=wh37IMxjc+9bQCZsbY1TgpxkregHG9E9PMlCKKotk7s=;
	h=From:To:Cc:Subject:Date:From;
	b=Zb5oRwwyg39VNJRcQcMUVEx/ehxJJIOETD2edb9eZCTcZhRTdomAvDAlqmGqdUcHT
	 o1ddALaJhWhFW1b8UiXK3mOxQxCgvue/wmFUG681aAPSHRLCPZrfAzk/v7qJuDqcjh
	 AqHylmRX4cXWRz+pSul/XGo9AeG+nh2m29aDuuK29Gsy4GsIWMNx5801Ts+ruTh7aB
	 AfTsdyp7ujg2R9YvvcvXjEL/NnCR5hS5GpI2ozZUS7fr8q/HlAe94zqxIYQsaEi8Vg
	 nB53ktzLb29nlnJcVDlO+HgMxFSKc4Mv0C30Ol3JZwWs+HwPBsvBpUver2rYtljGAU
	 4spjAJSjcICew==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Include runner extras for install target
Date: Thu, 25 Jan 2024 13:27:15 +0100
Message-Id: <20240125122715.1443022-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

When using the "install" or targets depending on install, e.g.
"gen_tar", the "runner extras" weren't included for the BPF machine
flavors.

Make sure the necessary helper scripts/tools are added to
corresponding BPF machine flavor.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
tools/testing/selftests/bpf/Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index fd15017ed3b1..a5e63ef78bf1 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -747,5 +747,15 @@ override define INSTALL_RULE
 	@for DIR in $(TEST_INST_SUBDIRS); do		  \
 		mkdir -p $(INSTALL_PATH)/$$DIR;   \
 		rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;\
+		rsync -a --copy-unsafe-links \
+			$(OUTPUT)/$$DIR/bpf_testmod.ko \
+			$(OUTPUT)/$$DIR/bpftool \
+			$(OUTPUT)/$$DIR/ima_setup.sh \
+			$(OUTPUT)/$$DIR/liburandom_read.so \
+			$(OUTPUT)/$$DIR/sign-file \
+			$(OUTPUT)/$$DIR/uprobe_multi \
+			$(OUTPUT)/$$DIR/urandom_read \
+			$(OUTPUT)/$$DIR/verify_sig_setup.sh \
+			$(OUTPUT)/$$DIR/xdp_synproxy $(INSTALL_PATH)/$$DIR;\
 	done
 endef

base-commit: c8632acf193beac64bbdaebef013368c480bf74f
-- 
2.40.1


