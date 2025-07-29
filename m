Return-Path: <linux-kselftest+bounces-38067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AABB1545C
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 22:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE4F18A42DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 20:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0E0272E56;
	Tue, 29 Jul 2025 20:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wako6R1Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A43C272E43;
	Tue, 29 Jul 2025 20:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753821280; cv=none; b=sY68jO3YyW+5pN9+aGcDZiugUpP8gv9DGq0blrZEU31kr0ROSFBIWbozFBLFTHU+0tIMVfvr0FDmsJieQ7vLuR4cxACNDSUrvWnL96IQjA/Rhl+hN5plqcSMrxPzQwr04okVULaCRnvurwSKArCquitq5AP+L11DiGmhzsBEL04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753821280; c=relaxed/simple;
	bh=ZwSuK/RTuYCFAVr+NkGfCj7BKRlN3w5TsrLdxs5eF88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JiHHOxowmZAEWUm2f9LkWtj56Hz42Zj+9f3wWCqHLK18Ms41oTOAW8BBXoInfKubdpj6DvkgpwTglbgnpKnuXLb+A3F1xR80fL7hgi61qdZ5VVrQfqUsKPxouDiSPtAF+Oue63JxuOp0+Z8VaN3Rag4YxB8cFLmYgSvINSF7sXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wako6R1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BA8C4CEF6;
	Tue, 29 Jul 2025 20:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753821279;
	bh=ZwSuK/RTuYCFAVr+NkGfCj7BKRlN3w5TsrLdxs5eF88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wako6R1QV2fX3AR8woOWygSqg8VAlXE6xf7o9NsaNMDpXiZs+JBts9eP21ACN4stU
	 5Cvw1UiV3OUFZYSJn2RNjHjgMXwI1pLPcEO/gLWddLSIjPe+AKxKOK3dRfyxlR8+XG
	 3qGikNiIvgb1vJKlWhC0H16z3drvvGsqYj9Nq4lc/5qs1Mly7rUc8tEkuiDz4KPqtm
	 f3gum2zXUGR8OgTkPs/36FNu8/TAtDdzIlJNVtHHC4eh3WSBltjUrE0AFOK+EhVSYB
	 +8NgZ7MZ5MEmTuzDgQgI9PTfdDQHJV9LVgr/DMzH9bEgs/y8K8MC49VHLZV7xbzx9W
	 u54nNRaP7CI7A==
From: Kees Cook <kees@kernel.org>
To: Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Sargun Dhillon <sargun@sargun.me>,
	Shuah Khan <shuah@kernel.org>,
	Johannes Nixdorf <johannes@nixdorf.dev>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	Ali Polatel <alip@chesswob.org>,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 0/2] seccomp: Fix a race with WAIT_KILLABLE_RECV if the tracer replies too fast
Date: Tue, 29 Jul 2025 13:34:21 -0700
Message-Id: <175382125844.1703528.15225839014415526576.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725-seccomp-races-v2-0-cf8b9d139596@nixdorf.dev>
References: <20250725-seccomp-races-v2-0-cf8b9d139596@nixdorf.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 25 Jul 2025 18:31:17 +0200, Johannes Nixdorf wrote:
> If WAIT_KILLABLE_RECV was specified, and an event is received, the
> tracee's syscall is not supposed to be interruptible. This was not properly
> ensured if the reply was sent too fast, and an interrupting signal was
> received before the reply was processed on the tracee side.
> 
> This series fixes the bug and adds a test case for it to the selftests.
> 
> [...]

With minor edits, applied to for-next/seccomp, thanks!

[1/2] seccomp: Fix a race with WAIT_KILLABLE_RECV if the tracer replies too fast
      https://git.kernel.org/kees/c/cce436aafc2a
[2/2] selftests/seccomp: Add a test for the WAIT_KILLABLE_RECV fast reply race
      https://git.kernel.org/kees/c/b0c9bfbab925

Take care,

-- 
Kees Cook


