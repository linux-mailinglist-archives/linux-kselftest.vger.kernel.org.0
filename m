Return-Path: <linux-kselftest+bounces-47050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2377CCA4D0F
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 18:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F540307483F
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 17:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48192352F8B;
	Thu,  4 Dec 2025 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gc6eJyU1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9D8352F83;
	Thu,  4 Dec 2025 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764870202; cv=none; b=Rw9CUqzjogpVSFGvSTCCXPqA9ONM1LSUrqVXtNmQBmtr9fgCoBP7KWngwp0VyS9je651g+ujEAJYiVOKXMje0QLl8rkEs3yaST5Lri+dy4u6d8t0h3GD5Ur0ZTrV2m205rPIAe1zoCHTFWYsQIwxKkcqZ64xmuyL1ByMheXbBdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764870202; c=relaxed/simple;
	bh=mYZIOOq06mjq+T/sWW3LlEpqFe/2OwghAQwEPkmaWqk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GXIhpW9XZUOVZ0bZqNMZClbE3S64RbWlK/fQnAPjBG86KV51iR+vVAQgkj4U5Eg4nI/E9w5PtLVkjJ92cFkjUAAZh30wVtyxkR5cFB7Fsd4N76ZGJIx0PA/fiaZb+W0izp5ymfAsCQ6Z2qPm+jNtlL5o878wbDTKNfdh9PvYfP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gc6eJyU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5035DC4CEFB;
	Thu,  4 Dec 2025 17:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764870201;
	bh=mYZIOOq06mjq+T/sWW3LlEpqFe/2OwghAQwEPkmaWqk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gc6eJyU1ONak02uBUpRuZhsZGy3ns3OboWyZB1YYbMRvkHX7mDkeBCSvq+n/AuZPh
	 9pSTAd8/OacTbj4V1OU1DzaS78vf64d4OFhN3Z7ykKYD5Gr57fM+wus4PQjgRXsudk
	 xoGTMhwJD9SEBkgClZDzPb9q28DDf6JBWunYiqL5AiN3f1pOKY1PRV19dP37MPQYjr
	 UqxSdSU1xMLBMrLkEXSpdEw4nmhT/qf1BbYrRV77NBYgG2hvumZMK5OdsukMcH+GKP
	 OV0Xhtxk9GojI1SVbIlY9QIWomwkVzN9XkM676BpQF9IGKYOlyTAKRIi9J1JAOZnsc
	 +zrrqyztfseCA==
Date: Thu, 4 Dec 2025 09:43:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Elizabeth Figura <zfigura@codeweavers.com>, Thomas Gleixner
 <tglx@linutronix.de>, Eric Dumazet <edumazet@google.com>, Kees Cook
 <kees@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, wine-devel@winehq.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 00/13] selftests: Fix problems seen when building with
 -Werror
Message-ID: <20251204094320.7d4429d1@kernel.org>
In-Reply-To: <536d47f4-25b1-430a-820d-c22eb8a92c80@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
	<20251204082754.66daa1c3@kernel.org>
	<536d47f4-25b1-430a-820d-c22eb8a92c80@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Dec 2025 09:16:16 -0800 Guenter Roeck wrote:
> On Thu, Dec 04, 2025 at 08:27:54AM -0800, Jakub Kicinski wrote:
> > On Thu,  4 Dec 2025 08:17:14 -0800 Guenter Roeck wrote:  
> > > This series fixes build errors observed when trying to build selftests
> > > with -Werror.  
> > 
> > If your intention is to make -Werror the default please stop.
> > Defaulting WERROR to enabled is one of the silliest things we have done
> > in recent past.
> 
> No, that is not the idea, and not the intention.
> 
> The Google infrastructure builds the kernel, including selftests, with
> -Werror enabled. This triggers a number of build errors when trying to
> build selftests with the 6.18 kernel. That means I have three options:
> 1) Disable -Werror in selftest builds and accept that some real problems
>    will slip through. Not really a good option, and not acceptable.
> 2) Fix the problems in the upstream kernel and backport.
> 3) Fix the problems downstream only. Not really a good option but I guess
>    we'll have to do it if this series (and/or follow-up patches needed to
>    support glibc older than 2.36) is rejected.
> 
> We'll have to carry the patches downstream if 2) is rejected, but at
> the very least I wanted to give it a try.

Understood, of course we should fix the warnings!
If we're fixing warnings, tho, I wouldn't have mentioned -Werror in 
the _subject_. It doesn't affect which warnings are enabled, AFAIK?

