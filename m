Return-Path: <linux-kselftest+bounces-20266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5FC9A6ADE
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 15:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162D01C22B07
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 13:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353301FAC4F;
	Mon, 21 Oct 2024 13:45:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE531F8F1E
	for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518303; cv=none; b=ZOGm+OZxYjCL/4K4bTbhdXGo7X/YZYGTDTFUzK7fRr5F6hA6ZtSxE8oXAixOHMHRI42W+QR/myYQBI2U+iBlq75MvWMN/ENxpoFMYVMrUSF+xCEZsNboA6QFc9WPMBEx2LLb99M27kYgWa4BQ7DXul/uEMcr7RkcF9abL9aRJNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518303; c=relaxed/simple;
	bh=b6BCOnsSoqHEFJf+TvQh4cCIQhKoygR6F2KaIjObrhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rATCSlcFvV+ckzVcskulrhh4DwGmL/bSGjUXYYgJMWtd2hgfzvpoQd8QfS/xfs7J0UvoRBswHYhL8RQGJE1DEy4RHFTE0msx8TLZGBbLirGo+BA0kqZfip5ysmRYykFUSxdNnc6UrovTC91QC8h0zq+0F4fSVvdZnU3p32QiDhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F32DDA7;
	Mon, 21 Oct 2024 06:45:30 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87EF33F73B;
	Mon, 21 Oct 2024 06:44:58 -0700 (PDT)
Date: Mon, 21 Oct 2024 14:44:55 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com,
	broonie@kernel.org, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, jeffxu@chromium.org,
	joey.gouly@arm.com, shuah@kernel.org, will@kernel.org,
	linux-kselftest@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 1/5] arm64: signal: Remove unused macro
Message-ID: <ZxZa13heTXFwiQXM@e133380.arm.com>
References: <20241017133909.3837547-1-kevin.brodsky@arm.com>
 <20241017133909.3837547-2-kevin.brodsky@arm.com>
 <ZxEyCTf/Zt9kcHVv@e133380.arm.com>
 <7793ba63-1d3c-44b0-8daf-10c4a7b79bc9@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7793ba63-1d3c-44b0-8daf-10c4a7b79bc9@arm.com>

On Mon, Oct 21, 2024 at 12:05:30PM +0200, Kevin Brodsky wrote:
> On 17/10/2024 17:49, Dave Martin wrote:
> > On Thu, Oct 17, 2024 at 02:39:05PM +0100, Kevin Brodsky wrote:
> >> Commit 33f082614c34 ("arm64: signal: Allow expansion of the signal
> >> frame") introduced the BASE_SIGFRAME_SIZE macro but it has
> >> apparently never been used.
> > Nit: Should there be a statement of what the patch does?
> >
> > Same throughout the series.
> >
> > (Yes, I know it's in the subject line, but Mutt doesn't think that's
> > part of the message body, so I can't see it now that I'm replying...
> > and submitting-patches.rst and e.g., maintainer-tip.rst seem to take
> > the same policy, albeit without quite stating it explicitly.)
> 
> Ah good point, I didn't consider that. Will make it explicit in patch 1
> and 2.

Thanks.

(I have a patch for submitting-patches.rst knocking about to propose
making this more explicit, but I didn't dare to post it so far...)

Cheers
---Dave

