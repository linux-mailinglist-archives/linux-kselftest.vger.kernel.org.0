Return-Path: <linux-kselftest+bounces-9572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192248BD8E9
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 03:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8009285FBD
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 01:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA871C3D;
	Tue,  7 May 2024 01:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erF2OyYo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D9A1877;
	Tue,  7 May 2024 01:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715045229; cv=none; b=QegrAwzP03WbEUQzZ7g+MgYI865RNl/i9+dzEX90PhgBhmjdFhkpaojK2tqF/9/sO2g5J0fuwi5o6qirw5RhudJOFYMzRNYo3nh0IqtjOl0WXtJSQ3S2kcbvJYrjtnTWpRii0cz7VdvbOYFWMTK0LeRWaJx9WNieByFw16DfEO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715045229; c=relaxed/simple;
	bh=+wuctz0AiwVRvA/EpqH1dAUfEc9dgfyNT226PxPonE0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iQilpMCv50KNIaxh2ldBzTnn4NRCPLk2E9gftv+dOXHDG5KDPQB1HQC8JOG/ExNxzM7kq+hL2709O4qjiTxHl6aAs3X0uCaHo5JIvMkgh59CCq+BmX31P6NpupP/OKeoqnJxRjYg3kUJBDRVt6XzH042n0VWJCVMuq3cSGQOsaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erF2OyYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582A3C116B1;
	Tue,  7 May 2024 01:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715045228;
	bh=+wuctz0AiwVRvA/EpqH1dAUfEc9dgfyNT226PxPonE0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=erF2OyYo4g4QHD5j+j/3El51K5HlY9YjpCRnz5+/o1sT/zNOJPJwzyi6m6MZDvSys
	 5sAwwmFyjwIsLj0TcrgdOKkFnsVqRy57dxu+rlRnVFdvJfZhMr6M9JpIxiPBCfganM
	 Gqan89L+VItIyncqv/8uLollGFRnVZusKMFrg3hgWyRxxtSIDYmpjmYhKIKjFcQzel
	 Z4bNtAcx+8yiiBOkgD5JHG1Mhdt7NdAz3qnDeNJ+Cu6VeWQaIA6sfJRFS24fSeTDex
	 IIkLisFrox1YdCcoA/+mw1ftDA47lfMNklduD9b2h6jA4UmOeCkAHQlyPLXaGOVa2R
	 1xE25HTw3e+KQ==
Date: Mon, 6 May 2024 18:27:07 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
cc: Shuah Khan <shuah@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, 
    Steffen Klassert <steffen.klassert@secunet.com>, 
    Herbert Xu <herbert@gondor.apana.org.au>, 
    =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>, 
    Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
    Matthieu Baerts <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>, 
    Pravin B Shelar <pshelar@ovn.org>, 
    Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
    Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
    zhujun2 <zhujun2@cmss.chinamobile.com>, Petr Machata <petrm@nvidia.com>, 
    Ido Schimmel <idosch@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>, 
    Nikolay Aleksandrov <razor@blackwall.org>, 
    Benjamin Poirier <bpoirier@nvidia.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org, 
    mptcp@lists.linux.dev, dev@openvswitch.org, 
    Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v2] selftests/net: fix uninitialized variables
In-Reply-To: <20240506190204.28497-1-jhubbard@nvidia.com>
Message-ID: <610f9818-b899-1f70-8110-f88db47595ff@kernel.org>
References: <20240506190204.28497-1-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 6 May 2024, John Hubbard wrote:

> When building with clang, via:
>
>    make LLVM=1 -C tools/testing/selftest
>
> ...clang warns about three variables that are not initialized in all
> cases:
>
> 1) The opt_ipproto_off variable is used uninitialized if "testname" is
> not "ip". Willem de Bruijn pointed out that this is an actual bug, and
> suggested the fix that I'm using here (thanks!).
>
> 2) The addr_len is used uninitialized, but only in the assert case,
>   which bails out, so this is harmless.
>
> 3) The family variable in add_listener() is only used uninitialized in
>   the error case (neither IPv4 nor IPv6 is specified), so it's also
>   harmless.
>
> Fix by initializing each variable.
>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Hi John -

MPTCP change looks good to me:

Acked-by: Mat Martineau <martineau@kernel.org>


