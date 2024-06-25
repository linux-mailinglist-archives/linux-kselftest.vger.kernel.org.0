Return-Path: <linux-kselftest+bounces-12755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C2091750E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 01:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63596B222A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 23:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB33E17F513;
	Tue, 25 Jun 2024 23:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jhx0FuWv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224B117F4FE
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 23:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719359722; cv=none; b=qh9p0hWw7KdLdBIkBzkUI1TzfDcEe1D2pqsUGdZsQFIm3qbFo6C8DQpuonDAEAXVgYy5FvgZp+udbb/sbQOsVuy3xNKPnGWEmaXHTpC/hp6jfeVv0BqGj/F38hdMUkXJcYrSr2ELIHboCNOr2CmzF1p3MJA3gPt5IQJGnFfbEpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719359722; c=relaxed/simple;
	bh=krO4Bk2vIQHWJwLs8mW87UwC7KXFTsvPy0EbDIVPu3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZZhFM+w+orfKIDrVtduZ7ytNakt475q760gP134fQ+B5qoJFP1gmG4d1SYzYqWRv10tlWesBCGc+zZHBn6hjCGQ0rjykDx9IBc7oPykDtMDy7up7O4o1aY6tZN9QNB+gVAiMFX+gRfm3aEnNUQkJT05wxsLs6ZuqUEgg9GBmy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jhx0FuWv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719359720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=30MprqR9jKeSlYWvSkx3JBbBoLzb8YQKJ6HRn0CFdGo=;
	b=Jhx0FuWvWnprOTNyymSMjDslkQNyWk85/nA+twVGBCWbCdJQpUXp4fkIHzkZ/b6s5ZCd7h
	6nSIFU+zG9Yx7EMAquzVZbMs3S2AnxTktv1s+r5eSNuvaI4ujsjqJitvx1fI+7nCQs9wV1
	XhKQXcF9LcvsSvIEL+r+PlJZlLTyLZU=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-DmSnhsurNC2ZfQojhrxIaw-1; Tue, 25 Jun 2024 19:55:18 -0400
X-MC-Unique: DmSnhsurNC2ZfQojhrxIaw-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3d1ca308617so1066361b6e.2
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 16:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719359718; x=1719964518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30MprqR9jKeSlYWvSkx3JBbBoLzb8YQKJ6HRn0CFdGo=;
        b=F8ikT0XUyTFz+miNCyCcxvtHki3yRUwXOIbBHpS7ucF3KoTAcGxdG5kW3AgoN0IjNw
         iDInaqbpqc+kB3hF24wwkzLAPa8/ql5N7Xgwe+ESlrw2E7ROOvIVI5LZM6woO1i+Gngk
         7evvW4Fi74yXdIP4g0Tvb+PtFa/zBQsR7Y/6aZ0+qsdBBLfYzJqRPPnIn2AV2ftpbqMS
         4dbYfVh9NrXj3dJrHmPBhmv42Yy/9djpSWVaMZq7dRGtJe1v2NHbfAS7491KkFzOtP7s
         +HQLsHXu6LzjXWqseUNpolHGRcd/Hbx32St8+ui4i0RBnTLkGuK3yAgExLx6qVx+rrML
         im0w==
X-Forwarded-Encrypted: i=1; AJvYcCUdUB5qQffh1fGJPxnciQFMOeLFFgMjKTdjRCfm7rCFTDdC+p/RLAZsQEDrgSjYpEEJBtMi0LieDQuspkab8v1wYBmrm+Y1YKOZe+5Kx/Bw
X-Gm-Message-State: AOJu0YwwtKy76y+GJV7hZCJXpVZ5q5ullcEICiDiRToranJX+zeEiKKJ
	5YeBlTjmmxtMG/HXZgGlaBm9Ao5CC8VcYTZmlZgyIx8GttzLL9JKd/fRpoF0uFNJxwgUp1Zkhjq
	Zob3dV0/+J8ksV44rjwtSZTUXkyfwIW5FqrKuC+f8oA+o9prpzCspiEItzPRijWFBDQ==
X-Received: by 2002:a05:6808:10d0:b0:3d2:1b8a:be58 with SMTP id 5614622812f47-3d53ecf3880mr15046271b6e.3.1719359717812;
        Tue, 25 Jun 2024 16:55:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlf/FwRDBkisWWdxUhp5HLyrRnE/m8oDfhxzRCIqhtKcbQ1/6uO9ya2nFcAESOd4bBmfb1vg==
X-Received: by 2002:a05:6808:10d0:b0:3d2:1b8a:be58 with SMTP id 5614622812f47-3d53ecf3880mr15046235b6e.3.1719359717110;
        Tue, 25 Jun 2024 16:55:17 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce91f16esm452957085a.77.2024.06.25.16.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 16:55:16 -0700 (PDT)
Date: Tue, 25 Jun 2024 19:55:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Audra Mitchell <audra@redhat.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, aarcange@redhat.com,
	rppt@linux.vnet.ibm.com, shli@fb.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, raquini@redhat.com
Subject: Re: [PATCH v2 3/3] Turn off test_uffdio_wp if
 CONFIG_PTE_MARKER_UFFD_WP is not configured.
Message-ID: <ZntY4jIojSrjoW1M@x1n>
References: <20240621181224.3881179-1-audra@redhat.com>
 <20240621181224.3881179-3-audra@redhat.com>
 <ZnXwT_vkyVbIJefN@x1n>
 <Znl6dfM_qbH3hIvH@fedora>
 <ZnmFuAR7yNG_6zp6@x1n>
 <20240625160558.e1650f874ab039e4d6c2b650@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240625160558.e1650f874ab039e4d6c2b650@linux-foundation.org>

On Tue, Jun 25, 2024 at 04:05:58PM -0700, Andrew Morton wrote:
> On Mon, 24 Jun 2024 10:42:00 -0400 Peter Xu <peterx@redhat.com> wrote:
> 
> > >         uffdio_api.features &= ~UFFD_FEATURE_WP_HUGETLBFS_SHMEM;
> > >         uffdio_api.features &= ~UFFD_FEATURE_WP_UNPOPULATED;
> > >         uffdio_api.features &= ~UFFD_FEATURE_WP_ASYNC;
> > > #endif
> > > 
> > > If you run the userfaultfd selftests with the run_vmtests script we get
> > > several failures stemming from trying to call uffdio_regsiter with the flag 
> > > UFFDIO_REGISTER_MODE_WP. However, the kernel ensures in vma_can_userfault() 
> > > that if CONFIG_PTE_MARKER_UFFD_WP is disabled, only allow the VM_UFFD_WP -
> > > which is set when you pass the UFFDIO_REGISTER_MODE_WP flag - on 
> > > anonymous vmas.
> > > 
> > > In parse_test_type_arg() I added the features check against 
> > > UFFD_FEATURE_WP_UNPOPULATED as it seemed the most well know feature/flag. I'm 
> > > more than happy to take any suggestions and adapt them if you have any! 
> > 
> > There're documents for these features in the headers:
> > 
> > 	 * UFFD_FEATURE_WP_HUGETLBFS_SHMEM indicates that userfaultfd
> > 	 * write-protection mode is supported on both shmem and hugetlbfs.
> > 	 *
> > 	 * UFFD_FEATURE_WP_UNPOPULATED indicates that userfaultfd
> > 	 * write-protection mode will always apply to unpopulated pages
> > 	 * (i.e. empty ptes).  This will be the default behavior for shmem
> > 	 * & hugetlbfs, so this flag only affects anonymous memory behavior
> > 	 * when userfault write-protection mode is registered.
> > 
> > While in this context ("test_type != TEST_ANON") IIUC the accurate feature
> > to check is UFFD_FEATURE_WP_HUGETLBFS_SHMEM.
> > 
> > In most kernels they should behave the same indeed, but note that since
> > UNPOPULATED was introduced later than shmem/hugetlb support, it means on
> > some kernel the result of checking these two features will be different.
> 
> I'm unsure what to do with this series.  Peter, your review comments
> are unclear - do you request updates?

Yes, or some clarification from Audra would also work.

What I was trying to say is here I think the code should check against
UFFD_FEATURE_WP_HUGETLBFS_SHMEM instead.

Thanks,

-- 
Peter Xu


