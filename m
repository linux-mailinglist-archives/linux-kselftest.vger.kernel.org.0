Return-Path: <linux-kselftest+bounces-33494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59581AC0447
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 07:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1EF3B040A
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 05:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127261F130E;
	Thu, 22 May 2025 05:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQV6OTdD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D908A1F0E49
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 05:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747893245; cv=none; b=i500dmVdhg9VcuZ6q3ZFrkMgdeslGM7r/rs0oEfbI2qIHXjqaR0Lb34p5rufgUIvs52xnxfbUXu4kw5HMfOXkX4g+kAz7iKiAxMAZhsRXydlWYNdwhwkui8wir4cYUNj9wLuicX+WM+yG1z+gn+MuEiLCXRt8i/n9qXtfjij2OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747893245; c=relaxed/simple;
	bh=0WdLXCNPzfr9KwNVrqD3u38i3QIPikgCLd7f3SWGNYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ma7MbpFwxXz6wlB/wakXdilL4Cq/uvdSsyY4BlgEXOPrZ5WBFlssh/wNsZakGWT0o97hhHRozwxwlETSF/QNvpsA3tEPhdIGh5V/5coQkaSfgTo5/7JtL12t2h59USoxKwV16RpBPC7NaXs8uOTmAuj68vjwjELKkV1qeron0OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQV6OTdD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8ADC4CEE4;
	Thu, 22 May 2025 05:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747893245;
	bh=0WdLXCNPzfr9KwNVrqD3u38i3QIPikgCLd7f3SWGNYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NQV6OTdDAY+BRziWakb/sry2Sw8e/gP6S97YPInIFmYaUpWxm7vsW6eWjPrPQeheh
	 jW184505Krv0e6+LxmVCBIf/YCpG6qrZx1Ir4x0gCaWfHA+Rdsr1WmJk4c0604kTd1
	 J1wkpm/7GozPc1FrkcqJwQL/W84/sfrXUYHIIwvf9Pxo9MU50zd0PrfqQxPrDa96f2
	 ZZp/r3F0mPQ1vbmCV1EKqF4TSEad7A6vgaQfLgy4j4aS4eXraPp2tWlHYBa5848/ds
	 9aIolb9mDOsky78TlyoJbSnn8NfzcTOXVBw9BT9KLOypLkSsz8WbzoXk+1+SHw4h+a
	 YsueZBKdin2Wg==
Date: Thu, 22 May 2025 05:54:02 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: David Gow <davidgow@google.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH] kunit: Fix wrong parameter to
 kunit_deactivate_static_stub()
Message-ID: <aC67-mvJFxwn2sNo@google.com>
References: <20250520082050.2254875-1-tzungbi@kernel.org>
 <CABVgOSkuXoa_bad-Djm+5s0ivZ5XogB2SUJ-9t_GC5xzh=iKVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSkuXoa_bad-Djm+5s0ivZ5XogB2SUJ-9t_GC5xzh=iKVA@mail.gmail.com>

On Wed, May 21, 2025 at 03:44:04PM +0800, David Gow wrote:
> On Tue, 20 May 2025 at 16:21, Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > kunit_deactivate_static_stub() accepts real_fn_addr instead of
> > replacement_addr.  In the case, it always passes NULL to
> > kunit_deactivate_static_stub().
> >
> > Fix it.
> >
> > Fixes: e047c5eaa763 ("kunit: Expose 'static stub' API to redirect functions")
> > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > ---
> 
> Nice catch! I guess no-one's ever tried to pass NULL to deactivate the stub!
> 
> (Maybe we should add a test for this somewhere?)

Added a test for this,
https://lore.kernel.org/linux-kselftest/20250522054912.2948008-1-tzungbi@kernel.org/T/#u

