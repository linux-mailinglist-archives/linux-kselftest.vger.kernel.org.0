Return-Path: <linux-kselftest+bounces-22931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F37339E7A29
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 21:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33D1164CA9
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 20:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5871F3D3A;
	Fri,  6 Dec 2024 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vyqdb1ET"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B781C54B9
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Dec 2024 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733518096; cv=none; b=eoItWT7Q0y/HR3e+F1HQHnRGBgtrAF6zUPirVDJsmJFFPKdAocCGpbNQHu8/Y3wFxuVmasfJ8qQyj4c1LK/vbrHDWkO5zX+8bXfr3gcW95wZsiIyhPmWafebwjQdbwgRoLVdNFppEKFHB9GYCVoWirtVIzipN9g+iDK58xGYDQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733518096; c=relaxed/simple;
	bh=LI4N/Y3VihpSbBIWMspZRnUMLF6cUlqIpiSctY5HWb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZiJ66xgcDmLfw/u1mkE93Pg8iIAZr77HsBn46UmM0c31sdhk+vKrYQHybRs8VnXtuaFCqBROk0dZaPpFT+RUTC1toMnjEo64Ef437Mk+ugLgL1QjYi2Khtbf5NQjTn1raNLovY3My1WZRsleoY5u3Dafmv3s1xpCA3Rdw2MFW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vyqdb1ET; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21625b4f978so28385ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Dec 2024 12:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733518094; x=1734122894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0fOhJQgbWZQ80jDiX7GHnsujPHU3MBTZQhNqik9LVNw=;
        b=vyqdb1ET8DiJsC4Fa+uPcpmgz8spOcDdL8YQg2wiQfkUjPv18IkXfw9K1BNh9CdDLv
         UyQkSuFvj0yUHDnPfPFp04l58fi3E7LhK+GbWin/eNNn5ww9xlt7k5ILegfD/Q9h9Af/
         QqiQVZnGrW1vibh2afaD9B0H4/u+TyisPU5w2JZ/fiwfpA50dqDNiaOGE8TzPuaWYJDf
         NNawcawy2O726FpBgwbdIh3F1F6zBsxwwcDRh0zK8tIRkbJzyp+OHwWOcB+jfxcuOAqq
         mbTaXiQb8nVVtxZpthhi3sAt7HHRa6GoDKvPx8g2V9d4x8sRecNHyb7fLVAMSOFSM4gd
         7DUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733518094; x=1734122894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fOhJQgbWZQ80jDiX7GHnsujPHU3MBTZQhNqik9LVNw=;
        b=DkhRLJaDuLkbqtVjHsQHHhLuZzt5ewWxYjfSEYVmnDxKlCOs+b1RRroBMm6GgaFz0Y
         2mgMxlrMawRVZXfTLz4rD0pQoQRxchzBS4i8OkmCk7gYpKbnxVKqF9PuwszBmNWt5lgv
         NxF4uMoVyv8KoW4S3iZ0iSW7ihhy4vMVUaOvySasSbpHDcBvPbuI4xW7npc69UJKx++u
         ZfwNVvBH+vNLXzooLLZk7k+dBCXEH6s+Toq7bBSHpdxRlEPNxjaIl91qvOJM7ovoju5W
         OgmGGgwoMc96v5KwNKRlOyqximF3k7FNEBo60xWwK2zvx13Ok5LWprmznMCynJSTd9DM
         OfRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAiz7DTdLuI7ekGYIMJFfoB6yTbls2kC7yUw+Uv6g96TB9zrdiYCfUwKA/WnaxqYqGnzFoMiRgNeDLE1NelmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5SBvtON+cb1KdKXT5RT5v8tdPfRSOZuDCCjt6Xl1CuxRA7zGW
	Xjx9rFWNEFd0Xo3/CkcCSJH3zgC74tM6DtTrs248uOlGBFEEGGN4w+0OQ4uHFg==
X-Gm-Gg: ASbGncviucOKian7B2uQMfH57ipPs2p6DVPp/lIC8WOWsAgkdo0ax7mQUygNae5QZFC
	2U+gC0rcIfZ1lWLfNHIiZ29jEHZvpnttV3M67VkT2gjIjUWWozxgq2fdsTz2g8TKUQyqg6Rzg9i
	v5yeml67HCwfiYwuw9s2hD7Gf9egUldsGPybecJpSmrflWYqE4+7qUV3DMx/9iHTaedLnvLIFLg
	MueGq7JtCGjLcLXiue5L0LD1LHOmTghVGWLxlH2+KaDDTsuTw==
X-Google-Smtp-Source: AGHT+IGdvvFO8AqI8xisd9ogpnZo5Wa1deBjCsmxcE8SMTmX0XgZ1ut0QcYHjXAgifFdtr7D72jJVQ==
X-Received: by 2002:a17:902:ef10:b0:215:b464:340d with SMTP id d9443c01a7336-2162ad9684dmr316095ad.21.1733518094377;
        Fri, 06 Dec 2024 12:48:14 -0800 (PST)
Received: from google.com ([2620:15c:2d:3:7caa:6c4:e72a:a87d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156e1e20sm3464231a12.32.2024.12.06.12.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 12:48:13 -0800 (PST)
Date: Fri, 6 Dec 2024 12:48:09 -0800
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
Message-ID: <Z1NjCQgwHo5dwol6@google.com>
References: <20241206010930.3871336-1-isaacmanjarres@google.com>
 <20241206010930.3871336-2-isaacmanjarres@google.com>
 <0ff1c9d9-85f0-489e-a3f7-fa4cef5bb7e5@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ff1c9d9-85f0-489e-a3f7-fa4cef5bb7e5@lucifer.local>

On Fri, Dec 06, 2024 at 06:19:49PM +0000, Lorenzo Stoakes wrote:
> On Thu, Dec 05, 2024 at 05:09:22PM -0800, Isaac J. Manjarres wrote:
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index b1b2a24ef82e..c7b96b057fda 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -375,6 +375,17 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
> >  		if (!file_mmap_ok(file, inode, pgoff, len))
> >  			return -EOVERFLOW;
> >
> 
> Not maybe in favour of _where_ in the logic we check this and definitely
> not in expanding this do_mmap() stuff much further.
> 
> See comment at bottom though... I have a cunning plan :)
> 
> > +		if (is_exec_sealed(seals)) {
> 
> Are we intentionally disallowing a MAP_PRIVATE memfd's mapping's execution?
> I've not tested this scenario so don't know if we somehow disallow this in
> another way but note on write checks we only care about shared mappings.
> 
> I mean one could argue that a MAP_PRIVATE situation is the same as copying
> the data into an anon buffer and doing what you want with it, here you
> could argue the same...
> 
> So probably we should only care about VM_SHARED?

Thanks for taking a look at this!

I'd originally implemented it for just the VM_SHARED case, but after
discussing it with Kalesh, I changed it to disallow executable
mappings for both MAP_SHARED and MAP_PRIVATE.

Our thought was that write sealing didn't apply in the MAP_PRIVATE case
to support COW with MAP_PRIVATE. There's nothing similar to COW with
execution, so I decided to prevent it for both cases; it also retains
the same behavior as the ashmem driver.

> > +			/* No new executable mappings if the file is exec sealed. */
> > +			if (prot & PROT_EXEC)
> 
> Seems strange to reference a prot flag rather than vma flag, we should have
> that set up by now.

That makes sense. I can change this to check for VM_EXEC in v2 of this
series.
> > +				return -EACCES;
> > +			/*
> > +			 * Prevent an initially non-executable mapping from
> > +			 * later becoming executable via mprotect().
> > +			 */
> > +			vm_flags &= ~VM_MAYEXEC;
> > +		}
> > +
> 
> You know, I'm in two minds about this... I explicitly moved logic to
> do_mmap() in [0] to workaround a chicken-and-egg scenario with having
> accidentally undone the ability to mmap() read-only F_WRITE_SEALed
> mappings, which meant I 'may as well' move the 'future proofing' clearing
> of VM_MAYWRITE for F_SEAL_FUTURE_WRITE too.
> 
> But now I feel that the use of shmem_mmap() and hugetlbfs_file_mmap() to do
> _any_ of this is pretty odious in general, we may as well do it all
> upfront.
> 
> [0]:https://lore.kernel.org/all/cover.1732804776.git.lorenzo.stoakes@oracle.com/

I agree. I really like the idea of handling the future proofing and
error checking in one place. It makes understanding how these seals
work a lot easier, and has the added benefit of only worrying about
the check once rather than having to duplicate it in both shmem_mmap() and
hugetlbfs_file_mmap().

> >  		flags_mask = LEGACY_MAP_MASK;
> >  		if (file->f_op->fop_flags & FOP_MMAP_SYNC)
> >  			flags_mask |= MAP_SYNC;
> > --
> > 2.47.0.338.g60cca15819-goog
> >
> 
> So actually - overall - could you hold off a bit on this until I've had a
> think and can perhaps send a patch that refactors this?
> 
> Then your patch can build on top of that one and we can handle this all in
> one place and sanely :)
> 
> Sorry you've kicked off thought processes here and that's often a dangerous
> thing :P
Thanks again for reviewing these patches! Happy that I was able to get
the gears turning :)

I'm really interested in helping with this, so is there any forum you'd
like to use for collaborating on this or any way I can help?

I'm also more than happy to test out any patches that you'd like!

Thanks,
Isaac

