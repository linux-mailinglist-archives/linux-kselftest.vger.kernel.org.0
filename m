Return-Path: <linux-kselftest+bounces-28286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA07A4F563
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 04:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73723AA56E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 03:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2976D1624F1;
	Wed,  5 Mar 2025 03:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsN9q9aH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFF839FD9;
	Wed,  5 Mar 2025 03:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741145352; cv=none; b=oA3cDj8ChplXRf0Mkh7sC1zHeMSkDPgPJSP7LIWRTXPwXjlBjVMOZWXIB2itCrcLvSG94kSQESfKarqBgEV/Bhnc/25ihnwZiAtDwWfVs05KLS0n1fyYmuZQL1oo4Q7H9ol+abBlBYlqHESyxlXiLbAVcQuHdv8O/NsygUsLePw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741145352; c=relaxed/simple;
	bh=+S4iuBOJYh55augYKatEX6mo1z6YwMs35a2/LOsxfbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B96Wy+WI0bwGclZ4+88Cik5nMHx1RK/jIhh/vuJvJ5g0oXVqclxR5vC58QV09w59JUs6G4ltFkJHTBQt5HdPi0hfhYfUlDK9Si/uc5yZ+YIlMBJM2iYGmGBrtCFysk1z2hRZEkZCENUlXil6wsd9eAU1JTv7TRN17DKjWdtRlxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsN9q9aH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA73C4CEE5;
	Wed,  5 Mar 2025 03:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741145351;
	bh=+S4iuBOJYh55augYKatEX6mo1z6YwMs35a2/LOsxfbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NsN9q9aHJUoia2MQpP6sRCtEIu27csfGtxtvg+9vHeDYuT7wu29R13dmPW/BNfzEr
	 787j84T0lJAUVbtkRg2KD7ZGXW5q89cdxxvYXHQNJsM6mB+WuWV7z5umifd7mLxtSC
	 NZ0QRSKmvUzCPy2rOmf9L0fr05tm+WZt/Dp8A0pDn9R12oU7hKBDg6ZJCCfEtdnAiO
	 Lb3ufkBy1JcnQiF91HZw8FLGDpq6hVWQkZn1x6RlGCCo3mdKiVbsaNoUgMGCpTyqQA
	 tcXmwIX9YzitvHKgx00sQIR8fTTu9gIHY/RtbMx4iMsBObsE+aCLuuypztdAU7ZdOc
	 agv2j0PZXtoQw==
Date: Tue, 4 Mar 2025 19:29:07 -0800
From: Kees Cook <kees@kernel.org>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, jannh@google.com,
	torvalds@linux-foundation.org, vbabka@suse.cz,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com,
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, jorgelo@chromium.org,
	sroettger@google.com, hch@lst.de, ojeda@kernel.org,
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
	johannes@sipsolutions.net, pedro.falcato@gmail.com,
	hca@linux.ibm.com, willy@infradead.org, anna-maria@linutronix.de,
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com,
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net,
	peterx@redhat.com, f.fainelli@gmail.com, gerg@kernel.org,
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org,
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org,
	ardb@google.com, enh@google.com, rientjes@google.com,
	groeck@chromium.org, mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
Subject: Re: [PATCH v9 7/7] selftest: test system mappings are sealed.
Message-ID: <202503041928.777F92024E@keescook>
References: <20250305021711.3867874-1-jeffxu@google.com>
 <20250305021711.3867874-8-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305021711.3867874-8-jeffxu@google.com>

On Wed, Mar 05, 2025 at 02:17:11AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Add sysmap_is_sealed.c to test system mappings are sealed.
> 
> Note: CONFIG_MSEAL_SYSTEM_MAPPINGS must be set, as indicated in
> config file.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

Great! Thanks for the negative test addition. :)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

