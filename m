Return-Path: <linux-kselftest+bounces-5947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6C987275F
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 20:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B0328988E
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 19:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4100241E0;
	Tue,  5 Mar 2024 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="eyIuCu00"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEEF24215
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Mar 2024 19:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709666094; cv=none; b=Eb489WE3CaWsqeeR7yfR6jyC1IR5hZI3QfeXFLKvcL5Y/l0PpSGvIPuPZq012Vh1H7jKhjQFrFZQ/5EXsIYXUhH/vDq5pLWFmF1saGCnYRdeZr3MnATA+icZt5vFuoMPpNYGUWzqAdFtWWKC7jLuePSnfYxd757aJ8FIK8NgISM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709666094; c=relaxed/simple;
	bh=oVcaIR3f/LZgftTQjMVNUrpPr3fRC1Olz5EJlBg50do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0u2BHPUPoHmRayP0sxMtj9Eog6UEb3tX1l2AGHufDGuya3AO2+B7tiQJFlGvhYXXge5V6J+mFxqxLdPE+euPj5WFphNJqEZu9PFAMxjXm2t2e4R8AM2xVfNPKJbk4lLWQ5uBLtZzyGCbBUA/mE9EO4ALtDC2+MG3bUnqS9S4WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=eyIuCu00; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tq4xv4FxfzQcx;
	Tue,  5 Mar 2024 20:14:43 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tq4xt5RWTz3d;
	Tue,  5 Mar 2024 20:14:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709666083;
	bh=oVcaIR3f/LZgftTQjMVNUrpPr3fRC1Olz5EJlBg50do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eyIuCu00U99zo12kkYKyA/lBATCMU/x0cvJGLTgBB24Tl/c7d/JeCO9KYfgcq175c
	 R+8w8djwLcouyvk4IHF16yPJhZjO4E98tf++0EX5Ilg6365pUm9eAjRqsZIOZ26G9J
	 mbHQsR0RVGRiuyS6br5vNfn2+/mZJrkGr5xVMOJk=
Date: Tue, 5 Mar 2024 20:14:32 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Mark Brown <broonie@kernel.org>, 
	davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-security-module@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH v4 00/12] selftests: kselftest_harness: support using
 xfail
Message-ID: <20240305.sheeF9yain1O@digikod.net>
References: <20240229005920.2407409-1-kuba@kernel.org>
 <05f7bf89-04a5-4b65-bf59-c19456aeb1f0@sirena.org.uk>
 <20240304150411.6a9bd50b@kernel.org>
 <202403041512.402C08D@keescook>
 <20240304153902.30cd2edd@kernel.org>
 <202403050141.C8B1317C9@keescook>
 <20240305.phohPh8saa4i@digikod.net>
 <20240305100639.6b040762@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240305100639.6b040762@kernel.org>
X-Infomaniak-Routing: alpha

On Tue, Mar 05, 2024 at 10:06:39AM -0800, Jakub Kicinski wrote:
> On Tue, 5 Mar 2024 17:05:51 +0100 Mickaël Salaün wrote:
> > > I think we have to -- other CIs are now showing the most of seccomp
> > > failing now. (And I can confirm this now -- I had only tested seccomp
> > > on earlier versions of the series.)  
> > 
> > Sorry for the trouble, I found and fixed the vfork issues.  I tested
> > with seccomp and Landlock.  You can find a dedicated branch here (with
> > some Reviewed-by and Acked-by removed because of the changes):
> > https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=kselftest-xfail-fix
> > 
> > Jakub, please send a v5 series with this updated patch and your
> > exit/_exit fixes.
> 
> DaveM merged this already, unfortunately. Could send your changes
> as incremental fixes on top of net-next?

Ok, I'll send that today.

