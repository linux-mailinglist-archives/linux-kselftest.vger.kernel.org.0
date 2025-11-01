Return-Path: <linux-kselftest+bounces-44576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6A2C28309
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 17:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84FD2189505A
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 16:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5704226560A;
	Sat,  1 Nov 2025 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOnF0Fpf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDDE34D3A7;
	Sat,  1 Nov 2025 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762015023; cv=none; b=VmUSgTM8J6n10KTsh2yTo0dz+Uy7fcN/1Gs1oz9jmigWXN0pKfG4BrUqRm9SyBN27XJUovVBQoi4kThIlrK2sFfynheKKsuY0alSUTgoHN+k+Oy9NRRFKF//aI7f+4zTw4zMq4Ya3VR8pq46rXlGeQbtskjqxE/F0B1dXiypkao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762015023; c=relaxed/simple;
	bh=QD1sibqRBPzm00GzNbQgSKI+qAFQGKOnEE0guoDboxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Adsf/PUh9kONzsBniv91uNTjfor5V0aufbvVCwLuSwvcwz271rt1Jjz7PZQKkOVVmPKKfUOqIHjlLYfN5pfpumMsgOSGIS4mQGGJmCNPu97PnBggWsE29ZHaswPgfb0xlds6pXXwSenAfiXw4EpI/zKT3OStxeQwgZTtLI7rs2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOnF0Fpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8196BC4CEF1;
	Sat,  1 Nov 2025 16:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762015022;
	bh=QD1sibqRBPzm00GzNbQgSKI+qAFQGKOnEE0guoDboxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gOnF0FpfAq9rrWZiMV3zfkX9ztq4b6Yktm75vsXmspy3ST7BzO1Ixq6JpNyzceFWo
	 X+wPmGG1brQhD9vmmKBXaFJar7QFv/YmuOteYTHBtlKBIbs/2YBqalcRXglEkOKzgh
	 oJ1zVD8QVkEleLhOC9mroC8ZN6JYD6bAFKzfzOAHQTO77Ar0ZCMX1o75+BYUQnHJo/
	 v281cAn4LSibnRiNaeLw4MFUWKYMsJarhweqxCJJhQUbxY9FpHd0GVovxuNcYHhX5c
	 yL6tX0QSg5foWhpnk64eF3SyEyyRy0s9Hmpk4T1kpuVt8+RZZNwP28C+Bs6b6SlJc3
	 6LLCx9xGIXEAg==
Date: Sat, 1 Nov 2025 18:36:53 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	masahiroy@kernel.org, ojeda@kernel.org, pratyush@kernel.org,
	rdunlap@infradead.org, tj@kernel.org, yanjun.zhu@linux.dev
Subject: Re: [PATCH v9 8/9] MAINTAINERS: update KHO maintainers
Message-ID: <aQY3JUGAcS3FR8uJ@kernel.org>
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
 <20251101142325.1326536-9-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101142325.1326536-9-pasha.tatashin@soleen.com>

On Sat, Nov 01, 2025 at 10:23:24AM -0400, Pasha Tatashin wrote:
> Changyuan does not have cycles to commit to the upstream work of KHO.
> Remove from KHO maintainers.
> 
> Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 764df916fae7..6200de2027fe 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13788,7 +13788,7 @@ F:	kernel/kexec*
>  KEXEC HANDOVER (KHO)
>  M:	Alexander Graf <graf@amazon.com>
>  M:	Mike Rapoport <rppt@kernel.org>
> -M:	Changyuan Lyu <changyuanl@google.com>
> +M:	Pasha Tatashin <pasha.tatashin@soleen.com>
>  L:	kexec@lists.infradead.org
>  L:	linux-mm@kvack.org
>  S:	Maintained
> -- 
> 2.51.1.930.gacf6e81ea2-goog
> 

-- 
Sincerely yours,
Mike.

