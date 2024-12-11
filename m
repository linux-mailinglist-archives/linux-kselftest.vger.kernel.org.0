Return-Path: <linux-kselftest+bounces-23199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA889ED7E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 21:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A15281EEB
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 20:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530B7229664;
	Wed, 11 Dec 2024 20:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p+QIUAOw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DD32288FD
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 20:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950612; cv=none; b=Ce2zSFtMUOh5sNIHyIMxOUwIl4kxQ7kmA9Pmmvp6pTj6kxpXrNnvE/Ng7K4ryB/iWnMPzwMjynzIlDCuwVtbiLGGeaCsd5w7SAKq4JYtPorOrdS9SEJi8aReBonPIltgEqLcvdMXhL+iG8gEJJgqGT74+/XOlN+CJGCmMZw/M7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950612; c=relaxed/simple;
	bh=MdA6jUjSFbi6LXtxa7CFaIjgOlJPpUWrkhpWboRBHcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krBzyiS9ggoikLxiZptCmI1VhtUp4x2vSMU8t907F6294eOUJ+PT0k07TWyLNMhvPqgeFb1k9MLA9l/VnZAzItLbF7QL8j7wl9jCowea0ABoq/t/HYg5uJEjC9V2FkTAGGsuwyBj8qjOTZc3UlCW6FH/EgiTve9F7keuu/U0qSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p+QIUAOw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2155c25e9a4so1905ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 12:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733950610; x=1734555410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k2bEWtlbySt6ThDuoSUVHIUH+ChNKWKXsxj9RWznny0=;
        b=p+QIUAOwrVXUxVBz56vj9DJVnhzzxSj+2hqD757tvsKuuyoSdGnE6taPpNTJwpZ7OC
         YaZP0wRoSJHJHJtsGAJKFM/FOQxYrblDR+4ru3YM1NpNOrl04HnyFhPW5JvG9Llsw4+P
         JEsnjSgHD6f9iKkSxciXcbT9d09nAGJ9sYCu7TY99gdwmy36U2UWvHPz/suRCsNp9XSn
         ocvpjJNtCdfes5WeYf41bjWMX5UN9GGXdASzcLgGXWOlEyz91gjh1gs4xAOnw8tPlmwO
         nPkhxUAGfFPH0nEXmzOFgCWMRY5Sg/8wEgVTutErus5BykTqx5oxXZS+nDuSAy1QBaYG
         WdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733950610; x=1734555410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2bEWtlbySt6ThDuoSUVHIUH+ChNKWKXsxj9RWznny0=;
        b=g3IRMfSySAAmzpBFSh+/ienN3fjxKlXG/5D3lptB7AGj/aV1Fu/uW1DrXa6nGqsJhF
         sfby9VwfJBSulfAi9pHc3PUd2vfqnezMDTqcWV2ZCbyubIPg4l+OXjWSveEDI9CMr9m4
         o1X15XrnScLcPiEhhxPhiGr31oLmOzdz6Na3hKWbSJ0YQ6QC5pmmzdBWKkig9wxMKW7d
         GsZUGAnVRpvxVEhFmJlumUyOB1TotjDIoTTyBU189j5OhK54LHMz8gAwNfbwO2pz5+tV
         x6RU/MMgL+rwuz6OpZpztQr7WKSdRUK97JIcuCONw8hvEjctUrfse+LmY2wuwmADQnkc
         c75w==
X-Forwarded-Encrypted: i=1; AJvYcCUMhZofaGcyCMJDZ/AUqSd4AyrMtc1isjNIBNRAYHq7omKvbjuwjB+cX06TaEJjcmj9u/NaGDX94oHamtsoDwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxrcFyvjeMyO9o2A7lEUXHM6b7ZkNCDcD864tKWwRUVppd3Gyr
	lQ+X+t5sl3dBU+to1FAR9CyW40UFDEcvwTFtohLXYlxEQ5bTm1H4RsCOip+V0A==
X-Gm-Gg: ASbGncuH399LMj+xIApXCbuPEfT5RrQWZOovX92EMEQGMH27K0VTSH6x/AYBRlPRT3L
	WPIWPDJEhcWSSHJCVmQewVfKdI6JFXWtmCRIS/SackAapG0c3gQyAtxbnMHn6hjEcE8NC6Tq4/N
	u9mI8s3A3/qTRciNT/k8UB1NcdgGRqPUvu5nUiydxGbgsMgNHxqnCbtK0lwKPeqiiqEgHycRtaO
	Trb+GuhCTdueGn+o8UmrJI7XkI+BrDBiMVNJMm9cXYP6oHjKg1BMQ==
X-Google-Smtp-Source: AGHT+IFUNUV8Jrq3x7wIFFEJfhzg2GCvPKk4dGIRi3a8yhYwkgT2llKFjahr6PSlf2mmjBrVxBh3yA==
X-Received: by 2002:a17:902:f98f:b0:215:9327:5aed with SMTP id d9443c01a7336-2178e7378a8mr470435ad.20.1733950609623;
        Wed, 11 Dec 2024 12:56:49 -0800 (PST)
Received: from google.com ([2620:15c:2d:3:31a7:de26:ce93:3f1b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8efa162sm107919945ad.125.2024.12.11.12.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:56:49 -0800 (PST)
Date: Wed, 11 Dec 2024 12:56:44 -0800
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Shuah Khan <shuah@kernel.org>, kernel-team@android.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	John Stultz <jstultz@google.com>
Subject: Re: [RFC PATCH v1 1/2] mm/memfd: Add support for F_SEAL_FUTURE_EXEC
 to memfd
Message-ID: <Z1n8jOmH3nxXn7du@google.com>
References: <20241206010930.3871336-1-isaacmanjarres@google.com>
 <20241206010930.3871336-2-isaacmanjarres@google.com>
 <0ff1c9d9-85f0-489e-a3f7-fa4cef5bb7e5@lucifer.local>
 <Z1NjCQgwHo5dwol6@google.com>
 <3a53b154-1e46-45fb-a559-65afa7a8a788@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a53b154-1e46-45fb-a559-65afa7a8a788@lucifer.local>

On Fri, Dec 06, 2024 at 09:14:58PM +0000, Lorenzo Stoakes wrote:
> On Fri, Dec 06, 2024 at 12:48:09PM -0800, Isaac Manjarres wrote:
> > On Fri, Dec 06, 2024 at 06:19:49PM +0000, Lorenzo Stoakes wrote:
> > > On Thu, Dec 05, 2024 at 05:09:22PM -0800, Isaac J. Manjarres wrote:
> > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > index b1b2a24ef82e..c7b96b057fda 100644
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -375,6 +375,17 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
> > > >  		if (!file_mmap_ok(file, inode, pgoff, len))
> > > >  			return -EOVERFLOW;
> > > >
> > >
> > > Not maybe in favour of _where_ in the logic we check this and definitely
> > > not in expanding this do_mmap() stuff much further.
> > >
> > > See comment at bottom though... I have a cunning plan :)
> > >
> > > > +		if (is_exec_sealed(seals)) {
> > >
> > > Are we intentionally disallowing a MAP_PRIVATE memfd's mapping's execution?
> > > I've not tested this scenario so don't know if we somehow disallow this in
> > > another way but note on write checks we only care about shared mappings.
> > >
> > > I mean one could argue that a MAP_PRIVATE situation is the same as copying
> > > the data into an anon buffer and doing what you want with it, here you
> > > could argue the same...
> > >
> > > So probably we should only care about VM_SHARED?
> >
> > Thanks for taking a look at this!
> >
> > I'd originally implemented it for just the VM_SHARED case, but after
> > discussing it with Kalesh, I changed it to disallow executable
> > mappings for both MAP_SHARED and MAP_PRIVATE.
> >
> > Our thought was that write sealing didn't apply in the MAP_PRIVATE case
> > to support COW with MAP_PRIVATE. There's nothing similar to COW with
> > execution, so I decided to prevent it for both cases; it also retains
> > the same behavior as the ashmem driver.
> 
> Hm, yeah I'm not sure that's really justified, I mean what's to stop a
> caller from just mapping their own memory mapping executable, copying the
> data and executing?
> 
That's a fair point. In that case, I think it makes sense to enforce the
seal only when the mapping is shared.

The case I'm trying to address is when a process (A) allocates a memfd
that is meant to be read and written by itself and another process (B).
A shares the buffer with B, but B injects code into the buffer, and
compromises A such that A maps the buffer with PROT_EXEC and runs the
code that B injected into it.

If A used F_SEAL_FUTURE_EXEC prior to sharing the buffer, then it could
reduce the attack surface on itself in this scenario.

> There's also further concerns around execution restriction for instance in
> memfd_add_seals():
> 
> 	/*
> 	 * SEAL_EXEC implys SEAL_WRITE, making W^X from the start.
> 	 */
> 	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
> 		seals |= F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE;
> 
> So you probably want to change this to include F_SEAL_FUTURE_EXEC, and note
Do you mean adding a case where if F_SEAL_FUTURE_EXEC is in the seals,
then we should clear the X bits of the file and use F_SEAL_EXEC as well?

I don't think the case in the if condition should imply F_SEAL_FUTURE_EXEC,
since the file is still executable in this case?

> your proposal interacts negatively with the whole
> MFD_NOEXEC_SCOPE_NOEXEC_ENFORCED mode set in vm.memfd_noeec - any system
> with this set to '2' will literally not allow you to do what you want if
> set to 2.
> 
> See https://origin.kernel.org/doc/html/latest/userspace-api/mfd_noexec.html
Sorry, I didn't follow how this would impact
MFD_NOEXEC_SCOPE_NOEXEC_ENFORCED. Could you please clarify that?

> > Thanks again for reviewing these patches! Happy that I was able to get
> > the gears turning :)
> >
> > I'm really interested in helping with this, so is there any forum you'd
> > like to use for collaborating on this or any way I can help?
> >
> > I'm also more than happy to test out any patches that you'd like!
> 
> Thanks, I'm just going to post to the mailing list, this is the discussion
> forum I'm making use of for this :)
> 
> I will cc- you on my patch and definitely I'd appreciate testing thanks!
> 
> But yeah, to be clear I'm not done with reviewing this, I need more time to
> digest what you're trying to do here, but you definitely need to think
> about the exec limitations.

Thanks for sending out the patch. I took a look and tested it out and it
definitely makes implementing this a lot nicer!

Thanks,
Isaac

