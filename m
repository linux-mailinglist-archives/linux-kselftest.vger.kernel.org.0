Return-Path: <linux-kselftest+bounces-37472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1857FB084FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 08:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DCDF1AA3B45
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 06:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF4A217648;
	Thu, 17 Jul 2025 06:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfhWIG3D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4863B216E24;
	Thu, 17 Jul 2025 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752734014; cv=none; b=JTX+Jute8CSXhXU2z2jY/CTh5kpr5L8ExDfcEsyHkZ8eC8osBhltlYVMF0u54t40UL7Uv/bh80CMu6IuNKl/UQFE4Hn/cypwmSlKREWJB+EIWMUPOKtVNoC/4lnKTt4YzxoeqHjY/vNdejskGu/n9zeSe7LqOgsA6f8/czccK34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752734014; c=relaxed/simple;
	bh=PGd/+lq1oK+4JW50NPc/6RDONBXyUIxM6AF9r0EQwD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjjHjYbyLeHbWSACtwcndKeeASZQam1ISJwjbZp+Mxbb2eoXbM1gTsXqKCCT9x79xhYGfyBuJp7Of28QIwK+GXcwpdx5hPejlwJ6sFMnEAyXten7q7uXMpGRRCZ8QyV4K8g9F1080LxAu4kZD09RCQsQRbxqN/BkPFL4PK0We8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfhWIG3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9E8C4CEEB;
	Thu, 17 Jul 2025 06:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752734013;
	bh=PGd/+lq1oK+4JW50NPc/6RDONBXyUIxM6AF9r0EQwD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CfhWIG3DLlQhY2riH0nWBxonIlCeI+P3O3w9+12K9FSGlnpwKJCWLKOIY5Q4ytxPy
	 sU65i5Gjo2EF/on00Nv1xKZDmBiTOCVuhoTb9f2tZI/WAlf9jtWaZkredkmjx1e7rB
	 8KqqpadbtM/p/xCJdA1EKWvngb0pb/vX88tB1rXYJ/nUtYT0o11RtkTgOARvNaNslp
	 VFWdQ3SW0OziGnjPCKn59IX3ptE/USBhIcqUJ13wKITAI7amsa63NaORYbERb0qb4G
	 pwZ9RoFF6GDfdji66EWoSCWm2IMT3W62wLALw8O1b7vSBXykiohOKavNHpgnGMe/yo
	 5f2sJfz88I1vQ==
Date: Wed, 16 Jul 2025 23:33:33 -0700
From: Kees Cook <kees@kernel.org>
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH v4 5/6] binder: Convert binder_alloc selftests to KUnit
Message-ID: <202507162333.D4C3B198@keescook>
References: <20250717011011.3365074-1-ynaffit@google.com>
 <20250717011011.3365074-6-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717011011.3365074-6-ynaffit@google.com>

On Wed, Jul 16, 2025 at 06:10:08PM -0700, Tiffany Yang wrote:
> Convert the existing binder_alloc_selftest tests into KUnit tests. These
> tests allocate and free an exhaustive combination of buffers with
> various sizes and alignments. This change allows them to be run without
> blocking or otherwise interfering with other processes in binder.
> 
> This test is refactored into more meaningful cases in the subsequent
> patch.
> 
> Acked-by: Carlos Llamas <cmllamas@google.com>
> Signed-off-by: Tiffany Yang <ynaffit@google.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

