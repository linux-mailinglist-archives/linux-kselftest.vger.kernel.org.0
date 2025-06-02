Return-Path: <linux-kselftest+bounces-34148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0B2ACBACC
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 20:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3EA83BFF96
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 18:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C738F2253AE;
	Mon,  2 Jun 2025 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eaf/jt4z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9857E5D8F0;
	Mon,  2 Jun 2025 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748887734; cv=none; b=p5A7dKw4Jt9TgWCU4ppBAc2VTaiHPSY9bf835MoWhd6KyS1mVVWYvpemS3eIvfMe48OR7iqvHNpMELcvwGRbctrier0IaC8w37A1Hi1wUFznLRu1pngQpp7afQdm4xDQa258zVWXeC64DFqoJwtC+YoX5z6Usjts802IKFK0OnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748887734; c=relaxed/simple;
	bh=exvcHTQL5wekR42ghldPfL+3tZSs3pqr9YlpM7hdzcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=revVmSsKPCUUWzsfv12Ex6U4BIO4lE1Nhv5nnFRNc8mpjNeaKsZes3OeQPVRDZF9FT6IkxiCFmuiInFx4MBQRh0BREc0pn8O0UJg84y2tPvPKy4EHmQ80g0sV+/yYFH9je5STmh77x2wnQIXfUpD4La9NaOP8lOQRHyHwphA49o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eaf/jt4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C9FC4CEEB;
	Mon,  2 Jun 2025 18:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748887733;
	bh=exvcHTQL5wekR42ghldPfL+3tZSs3pqr9YlpM7hdzcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eaf/jt4zASimQGSoTU6ssLIdeWNkmC98i/FpUC3X5SYiJeSkZS6OSPpCbysrGIIUn
	 ozpEB48H1WytxV+20WEgetQhMAfOPvfpKqNyShWbjiAyWXeCaCIZI03fUnRJYHCGQU
	 dAqgXHjq4HT3d4XknAtwW5l+4V0udblx+UNQLmKQ0+/ta7D/lPba5arpZ3ki7/ddrx
	 KBP5l6kUIp8SRNMO8R3uStCrZxZGubDtNEVfimcWbzxbabGoau3pPy9r5eG5xq2sjT
	 SnKfTbbjtcKUn7VfKgxn9/EiLboK1I+sma4nq2dF/bKGZmTl7t5MongxyX2+TpEBvW
	 bErPxedZxrmlw==
Date: Mon, 2 Jun 2025 11:08:50 -0700
From: Kees Cook <kees@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	David Gow <davidgow@google.com>, linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/tests: Make RANDSTRUCT_KUNIT_TEST depend on
 RANDSTRUCT
Message-ID: <202506021107.EA2F1CBDB8@keescook>
References: <22d9c2fa9e751a9de3c599aa082be588ea82a7a0.1748875640.git.geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22d9c2fa9e751a9de3c599aa082be588ea82a7a0.1748875640.git.geert@linux-m68k.org>

On Mon, Jun 02, 2025 at 04:49:51PM +0200, Geert Uytterhoeven wrote:
> When CONFIG_RANDSTRUCT is not enabled, all randstruct tests are skipped.
> Move this logic from run-time to config-time, to avoid people building
> and running tests that do not do anything.

I don't like doing this because it means that looking at CI output means
I can't tell if the test was not built or if the config was not
included. I want to always have the test available, but skip the test if
the config is missing.

-Kees

-- 
Kees Cook

