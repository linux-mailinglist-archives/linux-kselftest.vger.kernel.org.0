Return-Path: <linux-kselftest+bounces-32598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBB7AAE8FF
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 20:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B267F16ED34
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 18:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEA728DF43;
	Wed,  7 May 2025 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kArIe70s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEF128B7F0;
	Wed,  7 May 2025 18:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746642148; cv=none; b=FwVHuCOV7Hj5PcdBWsG/WgtYapEOL83WoFqMEkvhT5PHFRRLbwMzfPr0N/7yiFk4YqJpCp/ZOIdj/f0WZieyY5kUxN4SaCw13nZzh6B5Zv3kClFrKlZv5zxZYHWQ/lS1D7Mab8GqN4PpW0OKN3a/CkvTern2jvvhDg07hYlGB2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746642148; c=relaxed/simple;
	bh=YMcr7kQ9TGaTP6WhqfZiDNaymUksVxM7RBsyZue/exk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZysm5zbaCya86x2ZX1+gWWl4QlzqtzfGb+tynBy4bNSZMkOo2dH0jRZaLtM8vvYIYrtuT+SBr1olsZTGyHNlM3vwezfCNUHx2UvLNnASlQqPapgC1kO89ijsm7/17DNQtCIXNZdjzIdK7aVDgczZI2NtbQFuV3lPYzw4amq1YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kArIe70s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDE8C4CEE2;
	Wed,  7 May 2025 18:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746642147;
	bh=YMcr7kQ9TGaTP6WhqfZiDNaymUksVxM7RBsyZue/exk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kArIe70suXHlXZo0TV+JN/3u2UOxD+7Wnj5//RanirT8XGGST48Cq2TG35hw0Z7Fr
	 UWNR5TDLpwEXsfC33lcbuzTDQ5f+O8bD4Gn6w3Jr7YaUIwSJbQOnJtxUocmVtFxNVE
	 aGFiRZTyZMpNd4jGQ8kI7pxc7mQl2pXAnSMeBC1cuqrgDCb4JAP1cdDy3JpM43jACf
	 BKpvKrUq9hDaiqZVf5uNcwhpLrXdarNIGqD7pouUa9gW0iKYyxFgeHW5Tf8aNXVgZF
	 1gAz0R8tZedOmkHmd2KIOUhjmzVIorHzuYLnK5oe7p42v2BpEpmlsIQCM356k+k3RT
	 /Hti7w7Bm9udg==
Date: Wed, 7 May 2025 12:22:22 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH 1/8] nvme-pci: Make nvme_pci_npages_prp() __always_inline
Message-ID: <aBuk3nBDOv_6wFCT@kbusch-mbp.dhcp.thefacebook.com>
References: <20250507180852.work.231-kees@kernel.org>
 <20250507181615.1947159-1-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507181615.1947159-1-kees@kernel.org>

On Wed, May 07, 2025 at 11:16:07AM -0700, Kees Cook wrote:
> Force it to be __always_inline to make sure it is always available for
> use with BUILD_BUG_ON().

Reviewed-by: Keith Busch <kbusch@kernel.org>

