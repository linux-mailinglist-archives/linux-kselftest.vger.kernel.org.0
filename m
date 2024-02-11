Return-Path: <linux-kselftest+bounces-4493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBB6850BC1
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Feb 2024 23:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D984B214A3
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Feb 2024 22:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3A75F552;
	Sun, 11 Feb 2024 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FI7Q1tWO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7965B5DB;
	Sun, 11 Feb 2024 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707690026; cv=none; b=U3qgn/TVJawcFyPOG8ZHrRzVwkufsYmiDdFvlJt7uIPQbUef8/x5ii5ZOI+D2UZtTDDmq2TWjnzpUaMFeUPTkB08QNpflCT4yi8pPPWjM6HiHu8f9XXIo8ILaWU60WCgy3l56XyEiDtF2HOuPYBpLtNU0xYnwrdXhZs4RflkztQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707690026; c=relaxed/simple;
	bh=Nhy+1UGTj+1YbWErmpCp/rHyBjelzDo5aTxO0M771y0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K5VWhHgCNlTgf8q8FgxMRKZk5OUp9aPKTcRG6OS6biURpb9uw9zI9yxGJ4NWn+MqF5rg/NhS3nZoaMFimvvr82b3wq0ryuGbI2KFd5rbbbLXWBAI8RUDhYmOqQ8zbLmSCfnt/TNfnb9YkK83g51fMI9roNIrODHRjUcs3MDnE/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FI7Q1tWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E79E4C433C7;
	Sun, 11 Feb 2024 22:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707690026;
	bh=Nhy+1UGTj+1YbWErmpCp/rHyBjelzDo5aTxO0M771y0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FI7Q1tWOWxpVXkcp4pQbLKX9wfovdbY41ti+rf97H3BSG/dsJse+Q7RwQuRYAocgb
	 6lrxFH5H8DcGdd90hQxnHxf3OCSAcXdQTk5W/Z2q6iUxn9B/8iCq26/zaER3QD9bV0
	 LM7gYoHL4wkpMor6GA6i9W1YTLYNBqmrj7OYNeOqTkM85aFY+Jw0/wMqWK+hKow+MQ
	 ycfRF5u9VpaOu6+A/FGFgGnyN36J3JRVNDgTJ6EkVl4+rmn8oFhc7aWefJjN5rVtNJ
	 MPw+wjzA1DN5MTiPUDT2wN0O0BnZsH+p+mT6IXOzbnf8ST96OgJsaZgiL7PQBJBWVk
	 Zz0Oo5AA2hb1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBF70D84BC4;
	Sun, 11 Feb 2024 22:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Allow compiler to inline most of
 bpf_local_storage_lookup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170769002583.30556.5770636109504122664.git-patchwork-notify@kernel.org>
Date: Sun, 11 Feb 2024 22:20:25 +0000
References: <20240207122626.3508658-1-elver@google.com>
In-Reply-To: <20240207122626.3508658-1-elver@google.com>
To: Marco Elver <elver@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 iii@linux.ibm.com, laoar.shao@gmail.com, tj@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed,  7 Feb 2024 13:26:17 +0100 you wrote:
> In various performance profiles of kernels with BPF programs attached,
> bpf_local_storage_lookup() appears as a significant portion of CPU
> cycles spent. To enable the compiler generate more optimal code, turn
> bpf_local_storage_lookup() into a static inline function, where only the
> cache insertion code path is outlined
> 
> Notably, outlining cache insertion helps avoid bloating callers by
> duplicating setting up calls to raw_spin_{lock,unlock}_irqsave() (on
> architectures which do not inline spin_lock/unlock, such as x86), which
> would cause the compiler produce worse code by deciding to outline
> otherwise inlinable functions. The call overhead is neutral, because we
> make 2 calls either way: either calling raw_spin_lock_irqsave() and
> raw_spin_unlock_irqsave(); or call __bpf_local_storage_insert_cache(),
> which calls raw_spin_lock_irqsave(), followed by a tail-call to
> raw_spin_unlock_irqsave() where the compiler can perform TCO and (in
> optimized uninstrumented builds) turns it into a plain jump. The call to
> __bpf_local_storage_insert_cache() can be elided entirely if
> cacheit_lockit is a false constant expression.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Allow compiler to inline most of bpf_local_storage_lookup()
    https://git.kernel.org/bpf/bpf-next/c/68bc61c26cac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



