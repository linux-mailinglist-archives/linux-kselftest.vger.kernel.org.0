Return-Path: <linux-kselftest+bounces-12559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E587914F37
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 15:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9D61C2284A
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 13:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948921411E1;
	Mon, 24 Jun 2024 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nq/aKoJa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12811411EF
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719237255; cv=none; b=jGgSK2EtLg4LJEFToHNxNDS1SBGtzUNqxQW0AZ8PPRgW57IRcm5baTRt3HyTPoooJCZ7I5iZ2rhvYOcbVM4mMFwbqATF20MUtzXZo+sjeGGpYFyGdlUEdjd9XDXES3zpX1But9BjszBnhrCz3mPZ26cOMxgZYEJQQH1lLoC4zWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719237255; c=relaxed/simple;
	bh=O5+IgKLm1vEoEvrobEa1GxPlnjCw72AcGZptrcBydQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvMeCGykqOtubhO1NUQXhfgD5jdtoQM6rSlak/oCBJaQtsNBxeqg2BvHndYS0SQ7n7e/X7IwzIs5FrZr5imL+189BsvjL8CS6tQ5vaWinURNUCtHjzCj7LItvI9dpV02TPAcheNNq63eo8yTnY1GZ6Z4D3ujz1MqR/rcUDDIKsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nq/aKoJa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719237252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B77pEoc7buh1Ruqfn82dEw1pJ+gpFKLmMx1Y4IU5wno=;
	b=Nq/aKoJauJI52GY2s3VVCY28psSPAfkKtxOgwlMdS+AIoPSwtoi8S7UnTcGrsZ8qC3kyN+
	81KEUwbAcApAjcs9Xz1YJ+8L1OkG2lcIUXgyplbaSX2wXOLVeyY9lbrKEFkYHCTc4yiJug
	aULZkYgIeTL4IfIr6c//cvX+M7kLenc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-QFm1hXAgNv-oKoLZs_M4Hw-1; Mon,
 24 Jun 2024 09:54:09 -0400
X-MC-Unique: QFm1hXAgNv-oKoLZs_M4Hw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFFF5195609F;
	Mon, 24 Jun 2024 13:54:02 +0000 (UTC)
Received: from fedora (unknown [10.22.33.154])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C6813000219;
	Mon, 24 Jun 2024 13:53:59 +0000 (UTC)
Date: Mon, 24 Jun 2024 09:53:57 -0400
From: Audra Mitchell <audra@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	aarcange@redhat.com, akpm@linux-foundation.org,
	rppt@linux.vnet.ibm.com, shli@fb.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, raquini@redhat.com
Subject: Re: [PATCH v2 3/3] Turn off test_uffdio_wp if
 CONFIG_PTE_MARKER_UFFD_WP is not configured.
Message-ID: <Znl6dfM_qbH3hIvH@fedora>
References: <20240621181224.3881179-1-audra@redhat.com>
 <20240621181224.3881179-3-audra@redhat.com>
 <ZnXwT_vkyVbIJefN@x1n>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnXwT_vkyVbIJefN@x1n>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Jun 21, 2024 at 05:27:43PM -0400, Peter Xu wrote:
> On Fri, Jun 21, 2024 at 02:12:24PM -0400, Audra Mitchell wrote:
> > If CONFIG_PTE_MARKER_UFFD_WP is disabled, then testing with test_uffdio_up
> 
> Here you're talking about pte markers, then..
> 
> > enables calling uffdio_regsiter with the flag UFFDIO_REGISTER_MODE_WP. The
> > kernel ensures in vma_can_userfault() that if CONFIG_PTE_MARKER_UFFD_WP
> > is disabled, only allow the VM_UFFD_WP on anonymous vmas.
> > 
> > Signed-off-by: Audra Mitchell <audra@redhat.com>
> > ---
> >  tools/testing/selftests/mm/uffd-stress.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> > index b9b6d858eab8..2601c9dfadd6 100644
> > --- a/tools/testing/selftests/mm/uffd-stress.c
> > +++ b/tools/testing/selftests/mm/uffd-stress.c
> > @@ -419,6 +419,9 @@ static void parse_test_type_arg(const char *raw_type)
> >  	test_uffdio_wp = test_uffdio_wp &&
> >  		(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);
> >  
> > +	if (test_type != TEST_ANON && !(features & UFFD_FEATURE_WP_UNPOPULATED))
> > +		test_uffdio_wp = false;
> 
> ... here you're checking against wp_unpopulated.  I'm slightly confused.
> 
> Are you running this test over shmem/hugetlb when the WP feature isn't
> supported?
>
> I'm wondering whether you're looking for UFFD_FEATURE_WP_HUGETLBFS_SHMEM
> instead.

I can confirm, its all really confusing... So in userfaultfd_api, we disable
three features if CONFIG_PTE_MARKER_UFFD_WP is not enabled- including 
UFFD_FEATURE_WP_UNPOPULATED:

#ifndef CONFIG_PTE_MARKER_UFFD_WP
        uffdio_api.features &= ~UFFD_FEATURE_WP_HUGETLBFS_SHMEM;
        uffdio_api.features &= ~UFFD_FEATURE_WP_UNPOPULATED;
        uffdio_api.features &= ~UFFD_FEATURE_WP_ASYNC;
#endif

If you run the userfaultfd selftests with the run_vmtests script we get
several failures stemming from trying to call uffdio_regsiter with the flag 
UFFDIO_REGISTER_MODE_WP. However, the kernel ensures in vma_can_userfault() 
that if CONFIG_PTE_MARKER_UFFD_WP is disabled, only allow the VM_UFFD_WP -
which is set when you pass the UFFDIO_REGISTER_MODE_WP flag - on 
anonymous vmas.

In parse_test_type_arg() I added the features check against 
UFFD_FEATURE_WP_UNPOPULATED as it seemed the most well know feature/flag. I'm 
more than happy to take any suggestions and adapt them if you have any! 

Thanks in advance and happy Monday!

-- Audra


 
> Thanks,
> 
> > +
> >  	close(uffd);
> >  	uffd = -1;
> >  }
> > -- 
> > 2.44.0
> > 
> 
> -- 
> Peter Xu
> 


