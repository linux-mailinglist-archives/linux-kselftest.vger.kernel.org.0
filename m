Return-Path: <linux-kselftest+bounces-38857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC5FB24B9D
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 16:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A0A3ADA25
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 14:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9245D2E5B23;
	Wed, 13 Aug 2025 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGLp84KU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B291A2C06;
	Wed, 13 Aug 2025 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755094066; cv=none; b=onDvSnDBn1mE3gMkqw5l/pJRyCyG3E2t/Bs08lpz2xn9RuWjBvAVB2ixjRP+g3/9YP+UjYwsFA6VnO7PFKp+ewsyQJTcGHlxbVgV0ltZJgIy0MgzAka/LLSwaWimZ5G1pknNIUYVHuBqWjade1PsKt62p4oZPZhQ+UOc6+G2ovk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755094066; c=relaxed/simple;
	bh=zcy05gnuZEZXeY7AcRHHwUP4PLtQj6zb6GUfETiaQHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iB+yOHBtFmHe0yaZh6aQ+ViduodNhPUkd174OB50QtOu41dt4v9hZm9p2cDQUFFCKK8KJMLfHlGyjMq/KTOfVIBLUWHEg9B5lfYy7bwctL0tvNhCPr9hK7WejjaJiZRgO83j/ZiDdl86swvBepHE3AYixaOfBpwbYOtaUW2q/JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGLp84KU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74674C4CEEB;
	Wed, 13 Aug 2025 14:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755094065;
	bh=zcy05gnuZEZXeY7AcRHHwUP4PLtQj6zb6GUfETiaQHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gGLp84KU+EeT4RVlZZn1mxWiEgYlbumqzXI8nKzbJxjlVREp+Zs6ALnfyvnMfFErF
	 31fMPzmEx4EHqHpO6Wu+CvDMTmtPDQeTuasIg9iW97uzRuAkFrD3HVlkLpkJtdUC0l
	 ISlqWHNAoicN7z74YGHwCmCT5XmgE13ppqLFcXudAJlJePhowH/MHE5zDptawuAka/
	 PGrwr9CP1+eBvTPWXq0sof73YzBVS30gLU2D1l7w1WTv2nEV7hmDkoo9ZjYPVRVx+v
	 Z3z3FIshqVLGS6KWgkksnaZeqt4mLN6fbPaYtpbZk+O1/boH4govioIDHsln6O521V
	 nqV9cl+peU80A==
Date: Wed, 13 Aug 2025 17:07:37 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Weischuh <linux@weissschuh.net>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/3] kho: allow scratch areas with zero size
Message-ID: <aJycKRCEqbW0pgwR@kernel.org>
References: <20250811082510.4154080-1-rppt@kernel.org>
 <20250811082510.4154080-2-rppt@kernel.org>
 <mafs0349vwd1i.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0349vwd1i.fsf@kernel.org>

On Wed, Aug 13, 2025 at 03:45:29PM +0200, Pratyush Yadav wrote:
> On Mon, Aug 11 2025, Mike Rapoport wrote:
> 
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > Parsing of kho_scratch parameter treats zero size as an invalid value,
> > although it should be fine for user to request zero sized scratch area
> > for some types if scratch memory, when for example there is no need to
> > create scratch area in the low memory.
> 
> Can the system boot with 0 per-node memory? If not, then perhaps we
> should only allow lowmem scratch to be zero?

In most cases yes because most of boot time allocations have fallback to
"any node".
And there's also an option to omit the "global" scratch and boot with only
per-node scratch areas, so I'd keep the possibility of setting any of these
to 0.

> > Treat zero as a valid value for a scratch area size but reject
> > kho_scratch parameter that defines no scratch memory at all.
> >
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  kernel/kexec_handover.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> > index e49743ae52c5..c6ac5a5e51cb 100644
> > --- a/kernel/kexec_handover.c
> > +++ b/kernel/kexec_handover.c
> > @@ -385,6 +385,7 @@ static int __init kho_parse_scratch_size(char *p)
> >  {
> >  	size_t len;
> >  	unsigned long sizes[3];
> > +	size_t total_size = 0;
> >  	int i;
> >  
> >  	if (!p)
> > @@ -421,11 +422,15 @@ static int __init kho_parse_scratch_size(char *p)
> >  		}
> >  
> >  		sizes[i] = memparse(p, &endp);
> > -		if (!sizes[i] || endp == p)
> > +		if (endp == p)
> >  			return -EINVAL;
> >  		p = endp;
> > +		total_size += sizes[i];
> >  	}
> >  
> > +	if (!total_size)
> > +		return -EINVAL;
> > +
> 
> Looks good. BTW, unrelated to this patch, but should we also check that
> p == '\0' here to make sure the whole argument was consumed?

Care to send a patch? ;-) 
 
> >  	scratch_size_lowmem = sizes[0];
> >  	scratch_size_global = sizes[1];
> >  	scratch_size_pernode = sizes[2];
> 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

