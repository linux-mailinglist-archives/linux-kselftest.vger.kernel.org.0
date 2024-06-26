Return-Path: <linux-kselftest+bounces-12811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3980C91835D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 15:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89001F22E7D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 13:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A27B18411F;
	Wed, 26 Jun 2024 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hfyZaCQu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B210C1684A1
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719410009; cv=none; b=rss+HLhIDcHDRWrFATA8CNSeXE6oPNC+gmZJyd/vZGCzVE4aK4SmQu31Kj6cSjFIQYwwxhMvGLtxED//JYD5W5anSpZDfXfRs0xESDm+4BmWzoV4m5nMUisGCEUagJKDWGlQLIqVeqSkmUxgQHCXFSlOkxCf+VY9tC97vypJCtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719410009; c=relaxed/simple;
	bh=A2o+l3NuRNw2a+iRKsLea/VZp78l6U646vGfevTxLB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIbVa/FZY4Ur2AZMwUqog4vla/KmEG13ti35u+sE+7N+Z2I1WOQEMrPEOD9SOFVQuSJzYJDPWQ5Wiui1sWIvOf/kuJyBNrDukyKwlqRTkaieqrCp+xxVDTeRvFj5A1ckAdAMW9sOrD26+JTWsq3joSQGB3UhsS2Rt9KPHNxQRPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hfyZaCQu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719410006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6L/CySx21VlY9lkKLs/UvRv4ham7l6zFWPjNK0vJEd8=;
	b=hfyZaCQu31XxNRucNB75BPsNsZ4pHuvL1XPzD+fAxuG4XHG0kgjGH0h3JcVosqderAyiiP
	FTbwhijcSTKJP76Yg8HDJpAoAhvLb6v21Pvo+N3NxqUD4n04FmN9KKBPv6hcP+qXZJwD8t
	hWToBiERPMkhZGzyNzJL5RePO3VEDbQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-D1OoD8lSNdW3Vw3LFm7U4Q-1; Wed, 26 Jun 2024 09:53:25 -0400
X-MC-Unique: D1OoD8lSNdW3Vw3LFm7U4Q-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4401522c6bdso16948111cf.3
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2024 06:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719410005; x=1720014805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6L/CySx21VlY9lkKLs/UvRv4ham7l6zFWPjNK0vJEd8=;
        b=OBwjaPiMIGyH5r27iTIaHkOMoxC/seS5pTocbbwDiswl007Lk0KBe6z+MLjZoG2GR0
         V9UsWLZ7JjRidTDh32cXv8ns9Mj3Ybh13ZMDYLXhP59G5qjopTEU7KMel3aP+9NXft5M
         HHupHJ48LWXY8l9A85zvdUZ54OGR6MQLajnN2n6h5ijuFrIlm9ZZKM+Rr1oZxRWvyQG8
         4ldii10cFEip9rI/YZl3krlw4K3WCB0XltrhS19T+ZxCgolTmMJ6Mg+y0WdBqBBbsYN3
         7QnH3I1hravOWx7QCIh35vPo5+6/ReL4rlMDNy1Pud/dc4oyECNkAin5l2SiwIWgLykD
         sHTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpFNySO5B3tZMi9qhpMeJefUjEavtZRxjYg016kVKkpW5i3l3+QwIKMYmciMARahPp11Emo8gBAS2zIpurBd5bxsC4TuWnGNUYqOBr9Frw
X-Gm-Message-State: AOJu0YxiBirNFq8I2zok75w8eBqk649uCVGWE7I0nuYpSQVxHytXf/AS
	kP9g/CgjWvqRf+DOfyRCGfbUIpjlOC2jyAcQut4Nk6yiiLBxpSx/WpmcYlJ3EBOv7pLQLcr3Vka
	ArEtX02X3znX5xF67nPec0do1kkGUHjxl4EM7O2alFgupmDCz57NPbZGzHRY8/f301g==
X-Received: by 2002:a05:620a:29c5:b0:79d:53d0:95af with SMTP id af79cd13be357-79d53d098f6mr146859685a.2.1719410004607;
        Wed, 26 Jun 2024 06:53:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfg5gp8Vxw/erpGLqvLxIwWQrtznQgrqGbKZUsqsdxrw8Gui1u4uAwFXpio7u+OhtBKCeLlg==
X-Received: by 2002:a05:620a:29c5:b0:79d:53d0:95af with SMTP id af79cd13be357-79d53d098f6mr146856185a.2.1719410003910;
        Wed, 26 Jun 2024 06:53:23 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79c082c7433sm137223985a.53.2024.06.26.06.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:53:23 -0700 (PDT)
Date: Wed, 26 Jun 2024 09:53:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Audra Mitchell <audra@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	aarcange@redhat.com, akpm@linux-foundation.org,
	rppt@linux.vnet.ibm.com, shli@fb.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, raquini@redhat.com,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 3/3] Turn off test_uffdio_wp if
 CONFIG_PTE_MARKER_UFFD_WP is not configured.
Message-ID: <ZnwdUJmo7-7tjcB3@x1n>
References: <20240626130513.120193-1-audra@redhat.com>
 <20240626130513.120193-3-audra@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240626130513.120193-3-audra@redhat.com>

On Wed, Jun 26, 2024 at 09:05:13AM -0400, Audra Mitchell wrote:
> If CONFIG_PTE_MARKER_UFFD_WP is disabled, then we turn off three features
> in userfaultfd_api (UFFD_FEATURE_WP_HUGETLBFS_SHMEM,
> UFFD_FEATURE_WP_UNPOPULATED, and UFFD_FEATURE_WP_ASYNC). Currently this
> test always will call uffdio_regsiter with the flag
> UFFDIO_REGISTER_MODE_WP. However, the kernel ensures in vma_can_userfault
> that if the feature UFFD_FEATURE_WP_HUGETLBFS_SHMEM is disabled, only
> allow the VM_UFFD_WP on anonymous vmas, meaning our call to
> uffdio_regsiter will fail. We still want to be able to run the test even
> if we have CONFIG_PTE_MARKER_UFFD_WP disabled, so check to see if the
> feature UFFD_FEATURE_WP_HUGETLBFS_SHMEM has been turned off in the test
> and if so, disable us from calling uffdio_regsiter with the flag
> UFFDIO_REGISTER_MODE_WP.
> 
> Signed-off-by: Audra Mitchell <audra@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  tools/testing/selftests/mm/uffd-stress.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> index b9b6d858eab8..3266ae885f75 100644
> --- a/tools/testing/selftests/mm/uffd-stress.c
> +++ b/tools/testing/selftests/mm/uffd-stress.c
> @@ -419,6 +419,9 @@ static void parse_test_type_arg(const char *raw_type)
>  	test_uffdio_wp = test_uffdio_wp &&
>  		(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);
>  
> +	if (test_type != TEST_ANON && !(features & UFFD_FEATURE_WP_HUGETLBFS_SHMEM))
> +		test_uffdio_wp = false;
> +
>  	close(uffd);
>  	uffd = -1;
>  }
> -- 
> 2.44.0
> 

-- 
Peter Xu


