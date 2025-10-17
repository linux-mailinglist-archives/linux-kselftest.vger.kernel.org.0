Return-Path: <linux-kselftest+bounces-43358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAD4BE61E8
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 04:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E954D4E1726
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 02:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940BD244670;
	Fri, 17 Oct 2025 02:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlUBZvys"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B57019D082;
	Fri, 17 Oct 2025 02:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760668873; cv=none; b=UHbLJheEz+4ThkkGJRUiJERl0rECY79O3RouCPy81f+GYsi+nhF2O+k+A54XJGyoR8RTfR0J7NYa6mkTKyUGk2whNR2T6+9z4ET6QsWnBawLDZNHlqw6Y0deRkM4ZywChtSP8BoYBkdS69UMhcPQj0i617EhKyZ0IwK+J9zvG40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760668873; c=relaxed/simple;
	bh=t2ABghWu1AEWfoMEPQGRUpzpfie+nrx/dKkRBboY3Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5sM1VognKG4QF6FHFY1KxFOuuAaODGapc17QBeLBSnvKzriyqmXLqMfiyYMpNsRKvc6FG1tOQtnCZuhDCSbpIirrVnyKVnejnvveXNkjpo4Pqe00mHXIRthug3SbWW76cX4s4ptwWnr+7zlmKxKOqHk2RujsyKKzWzPxE2nx7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlUBZvys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75BAC4CEF1;
	Fri, 17 Oct 2025 02:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760668873;
	bh=t2ABghWu1AEWfoMEPQGRUpzpfie+nrx/dKkRBboY3Ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JlUBZvysp8UUaWkIRXU9xcXPTjwDMQ8xaXglu7J/GU5YLs4oUNuZcIiDStAU+QOyX
	 b9vbRs0DPij8+HplOYLZQNvXoYKC8frWg81gPKHjgnlEdW7EkqLFjZEru239VVyGbA
	 FZIu/mckbjQRQBUpW7+5WR2/o0AwM+D6KeZZXtpoD5nocGbWknLP7O6DIoNmD3wwBt
	 iPs5B2HjlPJObA6q0NMN4jNjemuEUsWsDlAUWG6x0tnxZD2PwOeYMDdVu2YCA4KVfr
	 VjS+vmdf9HgkDPWhoQqBXpdscPpQH5TodFDUd+N+PV/ikQSlyz3TdtWxlhMqGYQaVb
	 NN/+MYPhBMrFA==
Date: Fri, 17 Oct 2025 02:41:08 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 5/7] revocable: Add fops replacement
Message-ID: <aPGsxAoZQfC6igUb@google.com>
References: <20251016054204.1523139-1-tzungbi@kernel.org>
 <20251016054204.1523139-6-tzungbi@kernel.org>
 <ee48ad77-e6d5-4954-832c-ebc42e6a1cfe@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee48ad77-e6d5-4954-832c-ebc42e6a1cfe@infradead.org>

On Thu, Oct 16, 2025 at 11:38:27AM -0700, Randy Dunlap wrote:
> On 10/15/25 10:42 PM, Tzung-Bi Shih wrote:
> > +/**
> > + * fs_revocable_replace() - Replace the file operations to be revocable-aware.
> > + *
> > + * Should be used only from ->open() instances.
> > + */
> > +int fs_revocable_replace(struct file *filp,
> > +			 const struct fs_revocable_operations *frops,
> > +			 struct revocable_provider **rps, size_t num_rps)
> > +{
> 
> Please add the function parameters to the kernel-doc comment to avoid
> kernel-doc warnings. E.g.:

Ah, thanks.  I didn't intend to make it a kernel-doc (as PoC code) but just
wrongly copy-n-paste around.

