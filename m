Return-Path: <linux-kselftest+bounces-34709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D9FAD561F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF61172B2F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE06283141;
	Wed, 11 Jun 2025 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvcvQhpl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C07281372
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646610; cv=none; b=NMaDzfOJYagbDaMFwVgi0s0W7AB497YnGfr6GVYznLZ3pKHXZI26MirC50d8PwtBMeEGgOk61cOw8euYpMjssY0ekmJ47WbAq9q34oCUB/GuOOl/3HyBcooW0BqprvLMLCII33DYL4e08BC6nEmASoCtTuixxn3DNasAHgVa8uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646610; c=relaxed/simple;
	bh=8buD8yDg3TR0fx8Q7bXACvJc4a/CvqRbB7CH+Pikfmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sy3aTlrYPHhD9rFEhJMrnOkjpsBg0MRNGYfP+XYH9HhuwcnmHasU8IdfRkNRxfMFbmpBihE0BRYskWJa2VUBZZ9lvwZD3SxJqJxCKP6E+y8HO/Ry5Bzo7pLYP9ztDAEpyoO1yqKZT/hE62U4hbWGAET851+94geWNMgnTDr6Ci0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QvcvQhpl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749646607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A5Kas9xwQ+OPm3yoVaGIsnzULAQTcfMhc6nbP8S9fvE=;
	b=QvcvQhplfihYlpgq4DVTicbMK50f+BQ2JmqC0nyS5vYk9jeMUf7l+0xXeijP7khPt6adrL
	bPknNRf2j63k92IiTG5FBFy9JGcU6INKbq+2Em52kupa6sbIU0JEPiq4FdwM//2A7NmfVh
	XxeGUHzCp8XMZ3WGdpt1VnqIWk3CY3o=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-9-J9hVdIOZaWZPTTSb3WOg-1; Wed, 11 Jun 2025 08:56:46 -0400
X-MC-Unique: 9-J9hVdIOZaWZPTTSb3WOg-1
X-Mimecast-MFC-AGG-ID: 9-J9hVdIOZaWZPTTSb3WOg_1749646606
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6faca0f2677so186794366d6.1
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 05:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749646606; x=1750251406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5Kas9xwQ+OPm3yoVaGIsnzULAQTcfMhc6nbP8S9fvE=;
        b=Xno3cv5w/tZktFPcpPwGOcGYc8Th6KUdyKK9P9e4rxmBiKwWfKITl1Fu0YnHyxDQ3f
         IEW840gd4E8FCCYUNPkWwY7mppV7/03hh1fNAWqVrmCVRN9ltkPcxRozp/MGf3nIeFuM
         iKg8Y14V7K/b79HeI8R5t/1YsnpUksZtjrJRnjBeIaB1Fsso0U9b9T7ZguwejJdB4m8w
         flxdhLJqVfctsgVoauHcvB8meeGSNU/rs96xzshfNsWc7jjYFPcOat+t7y1DI0uuCF6h
         KCGLM64Gt/1MuDMFAiuCrKiCDq49Nk6dgTIXIPaFnlij9FucNxlumA3fC/yPEY0D3pEr
         OWvA==
X-Forwarded-Encrypted: i=1; AJvYcCXRoMqP+JbHNCZgubJpPjb9feFrh4YGzdv6T7DW8QztT+FRCX/p0oN3LlTPxxPL6eExSZsqYkRCWFRI97cM+14=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPVZMQPmgM2GwUjVv9Ly/JvB/+W0zzPU4fyUE6jszGeS+zxc9f
	hezpeuap/+hHj/LjQjt7fxdkn7kiCp7URuQ6RvMhKElW2FCJZ8xJIPf/i1VgphFOpqv4Lsv1SSp
	pyC5fxXFT/Od56ztgtS+NATX27K1iQDL3vbdwyDN+yjO+1VwM6SjVfqpIJYkB89ufn1dT0Q==
X-Gm-Gg: ASbGncvO/e3M2vj8kvEaeLwmTbo+DYqwee0+NavEnyLa56tuflY8qtJDuaxT4KRM3BA
	CWeqUsFhc2rDA2bFJADOkBXGJo5Ip2lWe0IFSOUvpnVa9VZjINrtIqOUOSSBXeVLXSDeZsVsSN/
	GT+rrEpC0/bHm7IRm546i/EX/jkGXa8EvkGGp2OhVXY5hquF4IdomcDtNxVVAWdBkJ2MorTzFEQ
	4w9QG0X+gLVfd76Qb7f9yqOOIJI+K5oS90MHIjd9cWx2Sy6Mho0gOKvQbvjY8qWqozlh6hBcC4s
	iDStk8KRyjGQnw==
X-Received: by 2002:ad4:5de3:0:b0:6ea:d033:2846 with SMTP id 6a1803df08f44-6fb2d150f50mr46124756d6.25.1749646605464;
        Wed, 11 Jun 2025 05:56:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ3II3J1nqirG0Y1l89AqC5v1uU5YGX748p4ie8CqW4+N2aTm8LOyMY61BMCGc48dang2fKg==
X-Received: by 2002:ad4:5de3:0:b0:6ea:d033:2846 with SMTP id 6a1803df08f44-6fb2d150f50mr46124046d6.25.1749646604859;
        Wed, 11 Jun 2025 05:56:44 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09ab8a0esm82314846d6.25.2025.06.11.05.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 05:56:44 -0700 (PDT)
Date: Wed, 11 Jun 2025 08:56:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: akpm@linux-foundation.org, pbonzini@redhat.com, shuah@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, muchun.song@linux.dev,
	hughd@google.com, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	jannh@google.com, ryan.roberts@arm.com, david@redhat.com,
	jthoughton@google.com, graf@amazon.de, jgowans@amazon.com,
	roypat@amazon.co.uk, derekmn@amazon.com, nsaenz@amazon.es,
	xmarcalx@amazon.com
Subject: Re: [PATCH v3 1/6] mm: userfaultfd: generic continue for non
 hugetlbfs
Message-ID: <aEl9CNGLY0Sil7nq@x1.local>
References: <20250404154352.23078-1-kalyazin@amazon.com>
 <20250404154352.23078-2-kalyazin@amazon.com>
 <aEiwHjl4tsUt98sh@x1.local>
 <36d96316-fd9b-4755-bb35-d1a2cea7bb7e@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36d96316-fd9b-4755-bb35-d1a2cea7bb7e@amazon.com>

On Wed, Jun 11, 2025 at 01:09:32PM +0100, Nikita Kalyazin wrote:
> 
> 
> On 10/06/2025 23:22, Peter Xu wrote:
> > On Fri, Apr 04, 2025 at 03:43:47PM +0000, Nikita Kalyazin wrote:
> > > Remove shmem-specific code from UFFDIO_CONTINUE implementation for
> > > non-huge pages by calling vm_ops->fault().  A new VMF flag,
> > > FAULT_FLAG_USERFAULT_CONTINUE, is introduced to avoid recursive call to
> > > handle_userfault().
> > 
> > It's not clear yet on why this is needed to be generalized out of the blue.
> > 
> > Some mentioning of guest_memfd use case might help for other reviewers, or
> > some mention of the need to introduce userfaultfd support in kernel
> > modules.
> 
> Hi Peter,
> 
> Sounds fair, thank you.
> 
> > > 
> > > Suggested-by: James Houghton <jthoughton@google.com>
> > > Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> > > ---
> > >   include/linux/mm_types.h |  4 ++++
> > >   mm/hugetlb.c             |  2 +-
> > >   mm/shmem.c               |  9 ++++++---
> > >   mm/userfaultfd.c         | 37 +++++++++++++++++++++++++++----------
> > >   4 files changed, 38 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > index 0234f14f2aa6..2f26ee9742bf 100644
> > > --- a/include/linux/mm_types.h
> > > +++ b/include/linux/mm_types.h
> > > @@ -1429,6 +1429,9 @@ enum tlb_flush_reason {
> > >    * @FAULT_FLAG_ORIG_PTE_VALID: whether the fault has vmf->orig_pte cached.
> > >    *                        We should only access orig_pte if this flag set.
> > >    * @FAULT_FLAG_VMA_LOCK: The fault is handled under VMA lock.
> > > + * @FAULT_FLAG_USERFAULT_CONTINUE: The fault handler must not call userfaultfd
> > > + *                                 minor handler as it is being called by the
> > > + *                                 userfaultfd code itself.
> > 
> > We probably shouldn't leak the "CONTINUE" concept to mm core if possible,
> > as it's not easy to follow when without userfault minor context.  It might
> > be better to use generic terms like NO_USERFAULT.
> 
> Yes, I agree, can name it more generically.
> 
> > Said that, I wonder if we'll need to add a vm_ops anyway in the latter
> > patch, whether we can also avoid reusing fault() but instead resolve the
> > page faults using the vm_ops hook too.  That might be helpful because then
> > we can avoid this new FAULT_FLAG_* that is totally not useful to
> > non-userfault users, meanwhile we also don't need to hand-cook the vm_fault
> > struct below just to suite the current fault() interfacing.
> 
> I'm not sure I fully understand that.  Calling fault() op helps us reuse the
> FS specifics when resolving the fault.  I get that the new op can imply the
> userfault flag so the flag doesn't need to be exposed to mm, but doing so
> will bring duplication of the logic within FSes between this new op and the
> fault(), unless we attempt to factor common parts out.  For example, for
> shmem_get_folio_gfp(), we would still need to find a way to suppress the
> call to handle_userfault() when shmem_get_folio_gfp() is called from the new
> op.  Is that what you're proposing?

Yes it is what I was proposing.  shmem_get_folio_gfp() always has that
handling when vmf==NULL, then vma==NULL and userfault will be skipped.

So what I was thinking is one vm_ops.userfaultfd_request(req), where req
can be:

  (1) UFFD_REQ_GET_SUPPORTED: this should, for existing RAM-FSes return
      both MISSING/WP/MINOR.  Here WP should mean sync-wp tracking, async
      was so far by default almost supported everywhere except
      VM_DROPPABLE. For guest-memfd in the future, we can return MINOR only
      as of now (even if I think it shouldn't be hard to support the rest
      two..).

  (2) UFFD_REQ_FAULT_RESOLVE: this should play the fault() role but well
      defined to suite userfault's need on fault resolutions.  It likely
      doesn't need vmf as the parameter, but likely (when anon isn't taking
      into account, after all anon have vm_ops==NULL..) the inode and
      offsets, perhaps some flag would be needed to identify MISSING or
      MINOR faults, for example.

Maybe some more.

I was even thinking whether we could merge hugetlb into the picture too on
generalize its fault resolutions.  Hugetlb was always special, maye this is
a chance too to make it generalized, but it doesn't need to happen in one
shot even if it could work.  We could start with shmem.

So this does sound like slightly involved, and I'm not yet 100% sure this
will work, but likely.  If you want, I can take a stab at this this week or
next just to see whether it'll work in general.  I also don't expect this
to depend on guest-memfd at all - it can be alone a refactoring making
userfault module-ready.

Thanks,

-- 
Peter Xu


