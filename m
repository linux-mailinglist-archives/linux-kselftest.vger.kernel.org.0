Return-Path: <linux-kselftest+bounces-44617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D5EC28A2F
	for <lists+linux-kselftest@lfdr.de>; Sun, 02 Nov 2025 07:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2E574E15ED
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Nov 2025 06:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83D41F37D4;
	Sun,  2 Nov 2025 06:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0PownLD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04CD13A265;
	Sun,  2 Nov 2025 06:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762066791; cv=none; b=j3JY5g8cMW3Upju4z5aWAYRk2959No/Wv3GDtxErdGT5o1J55pGr0DoFcTriHiTC3VzvRn2d6xkau1+h0gLzxOWgb6fANSJCHULQ+mYJaasfwTdQp6QqhHgBdookTTNSInKKYT3od4Ob725S7rD6+VCB/MN3xWg67V6glbSkcVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762066791; c=relaxed/simple;
	bh=tZauxRiF+oHUfUJ6HFpFdgYgUz1Y0O/xSwPp9Ax33bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLqpDzYUcMPSvE4gTyhMthZ6OvJUqcWO55eRY2BG59OGrDmrfsyQq9GCsF6eJt/evJEvjHWhilhCS7se0QbGC+ON/S8Qo+o+pKrjL+o6S9BXUuu9KqW7H8KEYFRU2kug47BCu+GxpFqXhk/os+c9BqY5z3+7nuRlvR4BgXbuoR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0PownLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D057C4CEF7;
	Sun,  2 Nov 2025 06:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762066791;
	bh=tZauxRiF+oHUfUJ6HFpFdgYgUz1Y0O/xSwPp9Ax33bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p0PownLD6rGjXsR5XIoGxxmKz93L0EcSsB2xkR5xWsoLkpqRqqSOMUHjJ0R+fuLTB
	 ByR08VTC7i9hkxMWFQAlsLtgTlHE4yLMwwar8PzXUswkVkg2T872d4i9jwV+v3D23A
	 AuS4xQA5/uI/akctZZDL4roCf53ggcy71a94AHXnOv/UnkmfFyZp6CPnPY5tejMDI6
	 d36+6lmcxRdHvBU3E3BLj6bN4JV76TVMmGLZa5P8qamMP7A8qDfLIaN5mebYy5KSXi
	 Mm5fq5TAR+yxkz2pGV8R4kJEs1P7rtyy6y9+h5PXgW10BW5OGGMXOCxwKBGeTMGfq3
	 FAsr+Km3p5tQw==
Date: Sun, 2 Nov 2025 08:59:42 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	masahiroy@kernel.org, ojeda@kernel.org, pratyush@kernel.org,
	rdunlap@infradead.org, tj@kernel.org, yanjun.zhu@linux.dev
Subject: Re: [PATCH v9 9/9] liveupdate: kho: Use %pe format specifier for
 error pointer printing
Message-ID: <aQcBXnYEzMhssa-C@kernel.org>
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
 <20251101142325.1326536-10-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101142325.1326536-10-pasha.tatashin@soleen.com>

On Sat, Nov 01, 2025 at 10:23:25AM -0400, Pasha Tatashin wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Make pr_xxx() call to use the %pe format specifier instead of %d.
> The %pe specifier prints a symbolic error string (e.g., -ENOMEM,
> -EINVAL) when given an error pointer created with ERR_PTR(err).
> 
> This change enhances the clarity and diagnostic value of the error
> message by showing a descriptive error name rather than a numeric
> error code.
> 
> Note, that some err are still printed by value, as those errors
> might come from libfdt and not regular errnos.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  kernel/liveupdate/kexec_handover.c         |  4 ++--
>  kernel/liveupdate/kexec_handover_debugfs.c | 10 ++++++----
>  2 files changed, 8 insertions(+), 6 deletions(-)

-- 
Sincerely yours,
Mike.

