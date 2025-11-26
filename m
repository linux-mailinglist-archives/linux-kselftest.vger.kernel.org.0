Return-Path: <linux-kselftest+bounces-46487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAAAC8888F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 08:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B1D3B2B3F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 07:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B563529E11D;
	Wed, 26 Nov 2025 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDdwGEo1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EBA28DF07;
	Wed, 26 Nov 2025 07:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764143885; cv=none; b=fQTN8Kr3cGa7yahxmU4rCZ/maUSAvwNQXxacjfMAmAeuXO9WPjWXV88vDgHp3f154QdVfewJ7lxY3XchrjMBKGi/Xhwu0JSVZCoxV2aPSAgsXjvWaca31RMWfLq9lgT39bw0tfqK++jXqtCTNVyCx4BIPYrjVWpamurk7z0SMwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764143885; c=relaxed/simple;
	bh=TLRzos+G5nktJBYQEE4hvX7mJuXSl8xJvHDBeMRlLj4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uzfH0XsyRIPeYM6LUgUv0tCATa2mREtLbcrX/osP9FQdWOmGLguiuRnOq742MkuBSVw0oLekqhbs7vY+rCN2TAYSVTXOX2Q1qrXPtUYrXDcbVRnsFZka1+RUFQTdWVAdYcJtRG0JBef0NpWtd//Za4KIvM3XwmPsUsOnqMIPQSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDdwGEo1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E93CC113D0;
	Wed, 26 Nov 2025 07:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764143884;
	bh=TLRzos+G5nktJBYQEE4hvX7mJuXSl8xJvHDBeMRlLj4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=XDdwGEo1lLv6bSaf7r6iY2zJYWB5estti8dNDMVjX+96L0PKD2l3z01RrUhbR/HhC
	 HR2iPN0HMHQGodeDjB7COlL2wJag01qC9c+oBK7PeotNE0LUOhxgKJyAJdWxbne7Kl
	 ti6cmb+oPm24frjdy41PRGpxMWv7PPmGjeSJOUKxtGO1gALokb+6ekNY7q4gAkNA5d
	 9g/fxaMKL31Np+0sXHf1Z5cfRzT5Fm3nIBaMjdEiLXytA4K1QyoJMjCHCYv4etmmrh
	 tUQCF55lg8JupNHAhYbSZfBTn42FaScK7OUP3g8i19hY4DjVEP8VQbACWXLVoMTiH7
	 Q6r9D2+HBmHgg==
Content-Type: multipart/mixed; boundary="===============7516842318733721634=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <67d85605b603942683e285ed0f88d463fd85bfe0972b92e787c15891c0b1e32c@mail.kernel.org>
In-Reply-To: <20251126073308.365432-3-hoyeon.lee@suse.com>
References: <20251126073308.365432-3-hoyeon.lee@suse.com>
Subject: Re: [PATCH] tools: bpf: remove runqslower tool
From: bot+bpf-ci@kernel.org
To: hoyeon.lee@suse.com,bpf@vger.kernel.org
Cc: hoyeon.lee@suse.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com,tony.ambardar@gmail.com,charlie@rivosinc.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,llvm@lists.linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 26 Nov 2025 07:58:03 +0000 (UTC)

--===============7516842318733721634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index bac22265e..4e8d32318 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> @@ -209,8 +208,6 @@ HOST_INCLUDE_DIR	:= $(INCLUDE_DIR)
>  endif
>  HOST_BPFOBJ := $(HOST_BUILD_DIR)/libbpf/libbpf.a
>  RESOLVE_BTFIDS := $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
> -RUNQSLOWER_OUTPUT := $(BUILD_DIR)/runqslower/
> -

The commit removes the RUNQSLOWER_OUTPUT variable definition here, but
the variable is still referenced later in the file. Around line 232 in
the MAKE_DIRS assignment, the undefined variable RUNQSLOWER_OUTPUT
remains in the list:

MAKE_DIRS := $(sort $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf \
               $(BUILD_DIR)/bpftool $(HOST_BUILD_DIR)/bpftool \
               $(HOST_BUILD_DIR)/resolve_btfids \
               $(RUNQSLOWER_OUTPUT) $(INCLUDE_DIR))

Should this reference be removed from MAKE_DIRS to complete the
cleanup?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19696291804

--===============7516842318733721634==--

