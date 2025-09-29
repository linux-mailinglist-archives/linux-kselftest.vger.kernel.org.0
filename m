Return-Path: <linux-kselftest+bounces-42595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99F8BAA299
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 19:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8045A16FF5E
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 17:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D13D2EF646;
	Mon, 29 Sep 2025 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K97J425c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9B521257F;
	Mon, 29 Sep 2025 17:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759166847; cv=none; b=Tqd1kLLDEqww9HN0XyWaXSpDr/slIxFPL/99XoC7c19twlz4KwlF0zCP2DHtUdTkbQWtVb5Lko+K5XWFY1tSdyI0D7ubMzVhIuxx462ga2mpjeDHPTQiytGNZ/f9mSQkBxwYvdjZS0VFpkmiIihm6dTclsrZbKDTjoV47DXj/hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759166847; c=relaxed/simple;
	bh=xZx6R7dFweaok8lUi1K5smoZfZMEh6mwF0ylBiXnklI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GBybDVhN5oA+cnmO1jvQYaSwT5wXb/v3XvMeig5+eXYWnfjF011Hhbaby/emvLXMmZ/ZljuUkNb7QQtSFNop6QIUPVe4/HanThb3sN33R1m6x84qH2oNVd5DIjcXJwfiamecJSuGtu/r7yi178Z5NoUrV6Z1l+FavoUQnrCvbdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K97J425c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F70C4CEF4;
	Mon, 29 Sep 2025 17:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759166846;
	bh=xZx6R7dFweaok8lUi1K5smoZfZMEh6mwF0ylBiXnklI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K97J425cVsFjCFh1Q8tmEELHYGOHWnTCj/bu9zQ233PfivIJxVPevSyB6e8VYUMzS
	 N1+VU7lnaoIrqJRfnxJweMR2GK9U0/PUC/eS8P8y/z4enU4HUmv+izHrwm5O5iMAZt
	 zH67euXt2quG1eZG903nfE8s3Vd2Ek5Q0qowifkwYJbn+oDjaRL3AVH6He47mXGcHY
	 dInbVrGPGMq1LU84tcrkULofi8qbw2pOhd44T54sbkuYRLdNxnx2zvd90ORxxGThfT
	 O7ke91CytHn3hSWrXBsP3nmfFjKWmSehEDIzwpGJqrNu0KFbGTNNzZiOn3oSAhNAn0
	 qn13KCfRzVTIg==
From: SeongJae Park <sj@kernel.org>
To: Sidharth Seela <sidharthseela@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	nphamcs@gmail.com,
	hannes@cmpxchg.org,
	nathan@kernel.org,
	shuah@kernel.org,
	morbo@google.com,
	justinstitt@google.com,
	nick.desaulniers+lkml@gmail.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	david.hunter.linux@gmail.com
Subject: Re: [PATCH v1] selftests: cachestat: Fix warning on declaration under label
Date: Mon, 29 Sep 2025 10:27:24 -0700
Message-Id: <20250929172724.75108-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929115405.25695-2-sidharthseela@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Sep 2025 17:24:06 +0530 Sidharth Seela <sidharthseela@gmail.com> wrote:

> Fix warning caused from declaration under a case label. The proper way
> is to declare variable at the beginning of the function. The warning
> came from running clang using LLVM=1; and is as follows:
> --
> -test_cachestat.c:260:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
>   260 |                 char *map = mmap(NULL, filesize, PROT_READ | PROT_WRITE,
>       |
> 
> Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

