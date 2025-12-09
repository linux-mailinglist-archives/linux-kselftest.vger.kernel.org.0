Return-Path: <linux-kselftest+bounces-47305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3C5CB054A
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 15:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CF3E3016374
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 14:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483192FE061;
	Tue,  9 Dec 2025 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YI9xfupN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07B272602
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Dec 2025 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765291708; cv=none; b=hgReywQ+ZIAA3a21RqjzMs69Zvb9H7urqG2+W1jQb9TzZExzBv7Ahr/CmFMh3A3yk2aiqVQkU3SCf6PmMpHlMVWSG44rEQXb8Q7y74bA2xfT2H2VKSMWEM58uyW9jPos1wxNdm0/WLzylfcR0jzQJTOhZ8bYnrTbYHRCWyDOK2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765291708; c=relaxed/simple;
	bh=tNDDMglzHZagLUdfNEkHNyHOtmXBIdiz/eXvcMePmKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dppu2fAj36pSPWeff+2+c2pACe7KY+D5QY7co5qZnefKEjVeH2PQMmo5FfIazbc544lIpnd+vqk0AawE88TVvS//WnU1Poy2p73lXSqAaTnxKZf1ncLPF52bdNLX/rim5/w+Nfzh3l9eZMHmPq5VC5NTs+8FUPFp3WJMZY81aM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YI9xfupN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765291705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HJh7H5GiF2qQLzN/OqZxU2ve8RhVtZeC3ROh/2CUAvo=;
	b=YI9xfupN6e3VNc6kSK2EDqfActCCONX74Mjh3BZrEnfF6RM/f0EsQ6R9MFKhsOh43H2wdj
	V2xNDRfM//ceqmTPOEWbWHO8cw5LxowuGbVjefIinqTPF3Z38n/53hnWbdg40XMl+VumW0
	Vi+7dFQsDbVXgLckeTb4h0YH9OrnQ60=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-U8a79uIlOLi4R1dHwdGDSQ-1; Tue,
 09 Dec 2025 09:48:16 -0500
X-MC-Unique: U8a79uIlOLi4R1dHwdGDSQ-1
X-Mimecast-MFC-AGG-ID: U8a79uIlOLi4R1dHwdGDSQ_1765291694
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB8DB1956080;
	Tue,  9 Dec 2025 14:48:13 +0000 (UTC)
Received: from gmail.com (unknown [10.72.112.49])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9843419560AD;
	Tue,  9 Dec 2025 14:48:00 +0000 (UTC)
Date: Tue, 9 Dec 2025 22:47:52 +0800
From: Chunyu Hu <chuhu@redhat.com>
To: Luiz Capitulino <luizcap@redhat.com>
Cc: akpm@linux-foundation.org, david@kernel.org, shuah@kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com
Subject: Re: [PATCH v1 2/3] selftests/mm: allocate 6 hugepages in
 va_high_addr_switch.sh
Message-ID: <aTg2mKHKyq9ibFoU@gmail.com>
References: <20251207122239.3228920-1-chuhu@redhat.com>
 <20251207122239.3228920-2-chuhu@redhat.com>
 <efdd610d-a56f-4f3f-ab5c-9b0da1762ab6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efdd610d-a56f-4f3f-ab5c-9b0da1762ab6@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Dec 08, 2025 at 10:47:19AM -0500, Luiz Capitulino wrote:
> On 2025-12-07 07:22, Chunyu Hu wrote:
> > The va_high_addr_switch test requires 6 hugepages, not 5. If running the
> > test directly by: ./va_high_addr_switch.sh, the test will hit a mmap 'FAIL'
> > caused by not enough hugepages:
> >    ```
> >    mmap(addr_switch_hint - hugepagesize, 2*hugepagesize, MAP_HUGETLB): 0x7f330f800000 - OK
> >    mmap(addr_switch_hint , 2*hugepagesize, MAP_FIXED | MAP_HUGETLB): 0xffffffffffffffff - FAILED
> >    ```
> > The failure can't be hit if run the tests by running 'run_vmtests.sh -t
> > hugevm' because the nr_hugepages is set to 128 at the beginning of
> > run_vmtests.sh and va_high_addr_switch.sh skip the setup of nr_hugepages
> > because already enough.
> > 
> > CC: Luiz Capitulino <luizcap@redhat.com>
> > Fixes: d9d957bd7b61 ("selftests/mm: alloc hugepages in va_high_addr_switch test")
> > Signed-off-by: Chunyu Hu <chuhu@redhat.com>
> > ---
> >   tools/testing/selftests/mm/va_high_addr_switch.sh | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/mm/va_high_addr_switch.sh b/tools/testing/selftests/mm/va_high_addr_switch.sh
> > index f89fe078a8e6..98f3dfab62c5 100755
> > --- a/tools/testing/selftests/mm/va_high_addr_switch.sh
> > +++ b/tools/testing/selftests/mm/va_high_addr_switch.sh
> > @@ -111,8 +111,10 @@ setup_nr_hugepages()
> >   check_test_requirements
> >   save_nr_hugepages
> > -# 4 keep_mapped pages, and one for tmp usage
> > -setup_nr_hugepages 5
> > +# 5 keep_mapped hugepages are reserved in the first testings, and the last test
> > +# requires two hugepages, with one verlaped with the last second test, so one
> > +# extra, totally 6 hugepages
> 
> IMHO, I'd just say "The HugeTLB tests require 6 pages", otherwise the
> fix look good to me.

Thank you for the review. Let me update a v2 to shorten this comment as
your suggested. And change the title to 'require 6 hugepages in
va_high_addr_switch hugetlb test.

> 
> > +setup_nr_hugepages 6
> >   ./va_high_addr_switch --run-hugetlb
> >   retcode=$?
> >   restore_nr_hugepages
> 


