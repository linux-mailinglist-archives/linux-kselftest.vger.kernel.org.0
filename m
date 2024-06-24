Return-Path: <linux-kselftest+bounces-12561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86033915032
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 16:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B50CEB20B93
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 14:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F4119AD67;
	Mon, 24 Jun 2024 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0MuKjJB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493C919AA75
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240129; cv=none; b=UQNX+yESuYBynmLogR9+T8J5P+G+xfAlCKNVO2E5FvVC4CLYYSEYoM2FjO7DPJJSWZVCUyyM10fJ1I9sGJsmyjN9Ml6q7AXtgXc9eCJIMTB2Usal5/Bv/TVABt8peie48/WotkzStQmv5F8js5E8T7iy/gPOGsiEP9dIcZdxiAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240129; c=relaxed/simple;
	bh=/fNP9lHtI2TK5RrwMbpkvfnkfdvJsuINBBNwCdflfCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8Rv/px4CtL8CwgoFfOZsGVI1ExS0hHNMl77wJQTwAM65FYE3iEN8lnH9BTFhKtzIu/bkCnzzK+G2YLmXV5X/UjrKQ53Jw/1xAtA3/Hyf2wkvGoI646Ft+l+lRJavm1EH0JWJj6/XlOP7/OTgr1ADbOFNIdCh/I4150zI3pDjC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G0MuKjJB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719240126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2YSFwvfLTs34coaqSsJLjio1esrhhUEBzaPezL3zICw=;
	b=G0MuKjJBn7tWo5mE1ECkgoOR70T7wD1hYHAdXQllXFNJ0kfpe/8XaYpg3O5FYAJ6QD84je
	rie5jjJsvW+upC0Kk81pRTAgu5YgGmsIRbTkSojFVIeX8X9HrORUQDalvkPz/a97fwYObM
	yRwTogLJqf1HalSIQeUpzW/lherd9qM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-dSjvzxhsNIa0rdM45-yBeA-1; Mon, 24 Jun 2024 10:42:04 -0400
X-MC-Unique: dSjvzxhsNIa0rdM45-yBeA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b50790e82bso12660796d6.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 07:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719240124; x=1719844924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YSFwvfLTs34coaqSsJLjio1esrhhUEBzaPezL3zICw=;
        b=VedIcKjccRtrhfJ4rG9nJba+qwfilq5LXUpPvcTwmOA8y9/sADMscts27MB5cBFISW
         LjN5OPPNnkAxufwHVVZKGEL3C18T/+ivf52/4Sc7IoAIguun5Vgi9Djr22CA7jbr7dPc
         HGSUozQILKrify3TarLQ4Am+SDU2+VCWF8X0bs9wuNMGDUfW6pcJH8Lz65J9HyF22U7M
         xQJKcvzNU8jqJQHdWNK4PE4RLHb+3m2aqkxE90jel2/60AIgbl8AWK7VZVRVLyd4QBd7
         yeaIxbzQkTNTVDtvafO6d/+pll1e6cavAoMI+1xNsT8g+2vuuY7BY++3QmwIoUsWH8UV
         vn6g==
X-Forwarded-Encrypted: i=1; AJvYcCWy7hIDNYTxqOu8XvgOdbOw38/hVczwWuHRtrz0GdSHQqhZ8StfUSGaAb4UCUUb2OpinIae4FGZ8VJ8J5Y90t1V88b3UkpoYbHwd29NxSE4
X-Gm-Message-State: AOJu0YxfyXzW0XizfTKIsdm/q/Ux/qMmEMEuXcvAkmvl+r9cOW3YL7ju
	U53+wZRg5n7vPlTOZW7juoT8kVO6G4qGTp/oeTZaDtvkJPK2fzEKO3Pgbwvd6nko0NSqIKtPLGm
	zbX925X0x1kCsZnckr+bt4CiY1YRVU8GbVHi6YS7FfLBQ2j7Wv06f5qTcd7W57NYcXQ==
X-Received: by 2002:ac8:5753:0:b0:441:1de:8ab0 with SMTP id d75a77b69052e-444cf75fffbmr68514021cf.2.1719240124114;
        Mon, 24 Jun 2024 07:42:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGggCmyM4O7AbDKTFNzE+M2A0XkOn8q4QKOyaCtAAJssRP1VcmWE+zk9J/aPMuu0F6mZDXJWw==
X-Received: by 2002:ac8:5753:0:b0:441:1de:8ab0 with SMTP id d75a77b69052e-444cf75fffbmr68513631cf.2.1719240123513;
        Mon, 24 Jun 2024 07:42:03 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2b3689csm42757861cf.20.2024.06.24.07.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 07:42:03 -0700 (PDT)
Date: Mon, 24 Jun 2024 10:42:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Audra Mitchell <audra@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	aarcange@redhat.com, akpm@linux-foundation.org,
	rppt@linux.vnet.ibm.com, shli@fb.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, raquini@redhat.com
Subject: Re: [PATCH v2 3/3] Turn off test_uffdio_wp if
 CONFIG_PTE_MARKER_UFFD_WP is not configured.
Message-ID: <ZnmFuAR7yNG_6zp6@x1n>
References: <20240621181224.3881179-1-audra@redhat.com>
 <20240621181224.3881179-3-audra@redhat.com>
 <ZnXwT_vkyVbIJefN@x1n>
 <Znl6dfM_qbH3hIvH@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Znl6dfM_qbH3hIvH@fedora>

On Mon, Jun 24, 2024 at 09:53:57AM -0400, Audra Mitchell wrote:
> On Fri, Jun 21, 2024 at 05:27:43PM -0400, Peter Xu wrote:
> > On Fri, Jun 21, 2024 at 02:12:24PM -0400, Audra Mitchell wrote:
> > > If CONFIG_PTE_MARKER_UFFD_WP is disabled, then testing with test_uffdio_up
> > 
> > Here you're talking about pte markers, then..
> > 
> > > enables calling uffdio_regsiter with the flag UFFDIO_REGISTER_MODE_WP. The
> > > kernel ensures in vma_can_userfault() that if CONFIG_PTE_MARKER_UFFD_WP
> > > is disabled, only allow the VM_UFFD_WP on anonymous vmas.
> > > 
> > > Signed-off-by: Audra Mitchell <audra@redhat.com>
> > > ---
> > >  tools/testing/selftests/mm/uffd-stress.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> > > index b9b6d858eab8..2601c9dfadd6 100644
> > > --- a/tools/testing/selftests/mm/uffd-stress.c
> > > +++ b/tools/testing/selftests/mm/uffd-stress.c
> > > @@ -419,6 +419,9 @@ static void parse_test_type_arg(const char *raw_type)
> > >  	test_uffdio_wp = test_uffdio_wp &&
> > >  		(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);
> > >  
> > > +	if (test_type != TEST_ANON && !(features & UFFD_FEATURE_WP_UNPOPULATED))
> > > +		test_uffdio_wp = false;
> > 
> > ... here you're checking against wp_unpopulated.  I'm slightly confused.
> > 
> > Are you running this test over shmem/hugetlb when the WP feature isn't
> > supported?
> >
> > I'm wondering whether you're looking for UFFD_FEATURE_WP_HUGETLBFS_SHMEM
> > instead.
> 
> I can confirm, its all really confusing... So in userfaultfd_api, we disable
> three features if CONFIG_PTE_MARKER_UFFD_WP is not enabled- including 
> UFFD_FEATURE_WP_UNPOPULATED:
> 
> #ifndef CONFIG_PTE_MARKER_UFFD_WP
>         uffdio_api.features &= ~UFFD_FEATURE_WP_HUGETLBFS_SHMEM;
>         uffdio_api.features &= ~UFFD_FEATURE_WP_UNPOPULATED;
>         uffdio_api.features &= ~UFFD_FEATURE_WP_ASYNC;
> #endif
> 
> If you run the userfaultfd selftests with the run_vmtests script we get
> several failures stemming from trying to call uffdio_regsiter with the flag 
> UFFDIO_REGISTER_MODE_WP. However, the kernel ensures in vma_can_userfault() 
> that if CONFIG_PTE_MARKER_UFFD_WP is disabled, only allow the VM_UFFD_WP -
> which is set when you pass the UFFDIO_REGISTER_MODE_WP flag - on 
> anonymous vmas.
> 
> In parse_test_type_arg() I added the features check against 
> UFFD_FEATURE_WP_UNPOPULATED as it seemed the most well know feature/flag. I'm 
> more than happy to take any suggestions and adapt them if you have any! 

There're documents for these features in the headers:

	 * UFFD_FEATURE_WP_HUGETLBFS_SHMEM indicates that userfaultfd
	 * write-protection mode is supported on both shmem and hugetlbfs.
	 *
	 * UFFD_FEATURE_WP_UNPOPULATED indicates that userfaultfd
	 * write-protection mode will always apply to unpopulated pages
	 * (i.e. empty ptes).  This will be the default behavior for shmem
	 * & hugetlbfs, so this flag only affects anonymous memory behavior
	 * when userfault write-protection mode is registered.

While in this context ("test_type != TEST_ANON") IIUC the accurate feature
to check is UFFD_FEATURE_WP_HUGETLBFS_SHMEM.

In most kernels they should behave the same indeed, but note that since
UNPOPULATED was introduced later than shmem/hugetlb support, it means on
some kernel the result of checking these two features will be different.

Thanks,

-- 
Peter Xu


