Return-Path: <linux-kselftest+bounces-43736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CD9BFA1EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 07:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D13B1896977
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 05:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DC7EAC7;
	Wed, 22 Oct 2025 05:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvsJ03pG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFED350A1F;
	Wed, 22 Oct 2025 05:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761112124; cv=none; b=c1H7JDzkZUHZd40kFdNqhtFQyGq/Buf4QN4WG7YeBFlSivGS4kBjZhIxcLbSORO8hADIBMY+3x7FzIoW+WJVRYRrfAmg0KaZsVUuAZ9jK/KwYZTs/8AN0RvnxNh/13sbtd8MGFuCu0m7E2Z0+ANOIHV+tTah/33TCNjZgh3KrIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761112124; c=relaxed/simple;
	bh=fcipi0rhSVh/MNjzf96g6xOkImIIzAGSVFrNKZ8ddPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3fDbSVcLAQYSe1idEs02P2MReqbYk36Ucq1RB57pzMVVLX4ycqF4gKJNwmsWuMiHAnEt5q+UMFVZ06x6ocf4f5XVGrViMmH+lMMhW9+p8w0C+Oa19u3T8YMPUxkRE2XmFBSnlNxJjlZEaRC2t017DRLGe0cPFz2Pry+EymvW5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvsJ03pG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65C1C4CEE7;
	Wed, 22 Oct 2025 05:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761112124;
	bh=fcipi0rhSVh/MNjzf96g6xOkImIIzAGSVFrNKZ8ddPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BvsJ03pGBLi1YmtCZ8C0D8WvcHS+RmRHNPZql7RGpbklXYte0LYpupraBCS4xOuMO
	 7tx5BZOJK7thCe6TZFgyOrnoF9I6bfopWVDyL/y65ALY4qy003kQfaka63vmfVR2Z/
	 QSY8SeskvpY9pZE3E/eEtDypZcHUmieSsMAhRtnVIItxCjfIL9qb6gKYQIYYQLGJ6N
	 zVjxCXptAk7rZJ4GIBdloP69N1KCaa0pooMlqHjyNLSBRZPZFANqW8glt6eGdpk20c
	 SH1aazS15ehjZq6kUZtzL0EPiK1//rZkPY9t7G2A6GPPq+s3MgrOUtVcQ9c11GmMYC
	 PQq/bC91NY4Sw==
Date: Wed, 22 Oct 2025 08:48:34 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, brauner@kernel.org,
	corbet@lwn.net, graf@amazon.com, jgg@ziepe.ca,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, masahiroy@kernel.org, ojeda@kernel.org,
	pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org,
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com
Subject: Re: [PATCH v3 0/3] KHO: kfence + KHO memory corruption fix
Message-ID: <aPhwMitTY9De7md8@kernel.org>
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
 <aPchmxfh4ACM0vY2@kernel.org>
 <CA+CK2bAHH1tzMEGxAwbmrLnLTzJANMntRu=cp0J8-n101ER7Pw@mail.gmail.com>
 <20251021135331.8e0185a173a5fa40add60802@linux-foundation.org>
 <CA+CK2bDPLAS7EM--stHkZkx8FSgYBjDOz6FdvWBYrdHwZpZZjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDPLAS7EM--stHkZkx8FSgYBjDOz6FdvWBYrdHwZpZZjw@mail.gmail.com>

On Tue, Oct 21, 2025 at 08:15:04PM -0400, Pasha Tatashin wrote:
> On Tue, Oct 21, 2025 at 4:53 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 21 Oct 2025 12:04:47 -0400 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> >
> > > > With liveupdate: dropped from the subjects
> > >
> > > I noticed "liveupdate: " subject prefix left over only after sending
> > > these patches. Andrew, would you like me to resend them, or could you
> > > remove the prefix from these patches?
> >
> > No problem.
> >
> > What should we do about -stable kernels?
> >
> > It doesn't seem worthwhile to backport a 3-patch series for a pretty
> > obscure bug.  Perhaps we could merge a patch which disables this
> 
> We are using KHO and have had obscure crashes due to this memory
> corruption, with stacks all over the place. I would prefer this fix to
> be properly backported to stable so we can also automatically consume
> it once we switch to the upstream KHO. I do not think disabling kfence
> in the Google fleet to resolve this problem would work for us, so if
> it is not going to be part of stable, we would have to backport it
> manually anyway.

The backport to stable is only relevant to 6.17 that's going to be EOL soon
anyway. Do you really think it's worth the effort?
 
> Thanks,
> Pasha
> 
> > combination in Kconfig, as a 6.18-rcX hotfix with a cc:stable.
> >
> > Then for 6.19-rc1 we add this series and a fourth patch which undoes
> > that Kconfig change?

-- 
Sincerely yours,
Mike.

