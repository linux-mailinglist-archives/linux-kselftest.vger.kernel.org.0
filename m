Return-Path: <linux-kselftest+bounces-42618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09ADBAC29B
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 11:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01F01C0F61
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 09:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C5024A076;
	Tue, 30 Sep 2025 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESzCVw1I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BDA7D07D;
	Tue, 30 Sep 2025 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222928; cv=none; b=TowvkBrGnzcbmoRYp0hiZSbeBzVWSxg8OkmQJeiIhnBX/Uv1EX5+XHX0UzVxhErxk6B7lR3NYZx07pSdwXBmNCu7MIrLEYQiX0AsbvGRlLqHFmnRP7ECRqtYC0/A2w2R/fpAu9RCmFmJOXf1onGl+XavOLWW8KaBDtI2SZI3IuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222928; c=relaxed/simple;
	bh=w3zurDD9xqxTRcLJyIM8m0fnOkwxutlRsGQRM5UAzck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7+QemN2v83x5yqpgHUrnEzkbIwK2iOjHTJmtEz6FoMTJgML3+8F+CexByPIXKgviKXKHPIEu9b66m9x33d8oQ+2KLNmNPvO/hbCCxJen+c4Fj7tpKhLrk86uU3qUY8nZG+FawCLW9B5uqQNzv34BnS6F5xsKStc9zrUjxxz68w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESzCVw1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006A1C4CEF0;
	Tue, 30 Sep 2025 09:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759222928;
	bh=w3zurDD9xqxTRcLJyIM8m0fnOkwxutlRsGQRM5UAzck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ESzCVw1If1fIMXcxsq852ST7SlSL13kQbWNA47ioOEQ19ykea70UrUSNDxVz9k+C3
	 ivfVLKOwnw/ifXoetkZWaU3FCPS4TN9hVc3Q8w4t+af7HvDXqcXFBAImRzViwGIfiF
	 VbHFnYRUhqRfOjMj6ZvgbGfEqLKQYSwHb+7xZEd8kLAE4AyQ04qDuGVqCxrVFOF8GA
	 RWWkHRbUTJtMeAlGPUdLnOVSioq0k/4/ly0kPVfeM5Q8N+mpC5ol7FGJXZ7tfpF5ZX
	 hzffLlq6ab4X3P8/Znjkih9qY9ivSqv/wsgdwxqoLMHsPqE46dKJUCxKkVDd++Pupz
	 o/TdTXIkHhm3Q==
Date: Tue, 30 Sep 2025 10:02:03 +0100
From: Simon Horman <horms@kernel.org>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH net-next] selftests/net: add tcp_port_share to .gitignore
Message-ID: <aNuci8Y9ZO9pd0Ua@horms.kernel.org>
References: <20250929163140.122383-1-krishnagopi487@gmail.com>
 <aNucABvb0PvBtCxr@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNucABvb0PvBtCxr@horms.kernel.org>

On Tue, Sep 30, 2025 at 09:59:44AM +0100, Simon Horman wrote:
> On Mon, Sep 29, 2025 at 10:01:38PM +0530, Gopi Krishna Menon wrote:
> > Add the tcp_port_share test binary to .gitignore to avoid
> > accidentally staging the build artifact.
> > 
> > Fixes: 8a8241cdaa34 ("selftests/net: Test tcp port reuse after unbinding
> > a socket")
> 
> I'm not entirely sure this qualifies for a fixes tag.
> It is user-visible. It's probably annoying.
> But I'm not sure it's a bug.

Also, FTR, fixes tag's shouldn't be line wrapped.

> > Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> > ---
> >  tools/testing/selftests/net/.gitignore | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> I notice that tools/testing/selftests/kexec/test_kexec_jump
> is in a similar state. Do you plan to send a patch to address
> that too?
> 
> ..

Please note that net-next is now closed.

So if you do respin, please wait for it to re-open once v6.18-rc1 has been
released. About two weeks from now.

