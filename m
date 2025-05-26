Return-Path: <linux-kselftest+bounces-33794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC682AC4139
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 16:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD04189A7C5
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 14:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72A2433AC;
	Mon, 26 May 2025 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MFA0ou3o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF555202C31
	for <linux-kselftest@vger.kernel.org>; Mon, 26 May 2025 14:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748269244; cv=none; b=eJ+5b/nJau0uIwjKvYVrO53qM59df2Qi4cfevUhR0hT6eeaeDLMqJDWYKE2dk68n7QOeWx35v/wV1JBTHlMi6Fk//nmY/vOfAQXzFE313SyQpMeBQDdQmVc/icj4t05zew1YcCkLoKR0Ddo8C4qF+yLb/0541dsf5VSvvMKnCIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748269244; c=relaxed/simple;
	bh=0ugJx3l8Xb2TnjC9q7UR9Vw9xm0HIV4HsHrRVwe3jFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q08SxWtUUCUruR2qH5pUCYbfGVDzec1fJWFtTU9MwPi+lLWFSAGPoRXyk8dPTq174L/QdCq2s+wWoX/Oc7/6SDQ/bcApcYeP2vB6TtHbcoS/59tHNLKrORG9/bdVmiIB32XUaegzfjzsaVN1LKXCmeuXPsqJF0Pe4NFkozMCZ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MFA0ou3o; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 May 2025 16:20:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748269240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QFt3TKWJrqouxpz/ZY/T9FpKwhvXINOjq9tlN17Bdgw=;
	b=MFA0ou3oEpdNJRaXBxjy3B08L0duEhVC1ET+hkOeU1w24sRiPdjyEFWDkhV3ldNMyiuJAG
	iaarR/Txd+XlQ6FUoINEEMpfRZt7vMNfIZSk4ASsHu/9K3x/i+6q2+QWkpZMSrZFu/P+N8
	2yTuREPDPSyGMy+lRSyV/uKuTZcmGI4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Nicolas Schier <nicolas.schier@linux.dev>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 02/11] kbuild: introduce CONFIG_ARCH_HAS_NOLIBC
Message-ID: <20250523-classic-caracal-of-promise-7d22d7@l-nschier-aarch64>
References: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
 <20250407-kunit-kselftests-v2-2-454114e287fd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250407-kunit-kselftests-v2-2-454114e287fd@linutronix.de>
Organization: AVM GmbH
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 07, 2025 at 09:42:39AM +0200, Thomas Weißschuh wrote:
> Nolibc does not support all architectures.
> Add a kconfig option, so users can know where it is available.
> 
> The new option is maintained inside tools/include/nolibc/ as only that
> directory is responsible for nolibc's availability.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>  init/Kconfig                        |  2 ++
>  tools/include/nolibc/Kconfig.nolibc | 13 +++++++++++++
>  2 files changed, 15 insertions(+)

Reviewed-by: Nicolas Schier <n.schier@avm.de>

-- 
Nicolas Schier

