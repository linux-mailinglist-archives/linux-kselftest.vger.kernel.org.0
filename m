Return-Path: <linux-kselftest+bounces-12485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 870AE912F88
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 23:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B82B61C2222A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 21:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710F817C215;
	Fri, 21 Jun 2024 21:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ACQ7l+Ll"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F266217BB31
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 21:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719005271; cv=none; b=DqTGY/Qz0k464eXyektfv6HbKiQdSOlCFjNXhUJUM3ZQamZ3lRg2DlpCwxzvL8Z1pglV+VtHe7nHNAgcqsyhLdgh4WKiNyM5uQYlOI5shhtOGo8A5T3lfk0720nlxdyG7U7Q6Q+hpjPsWP3Ng6jWwJSSuqkirn21uT0ZXMFQA30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719005271; c=relaxed/simple;
	bh=J7wlojSeCtPdDmzv9T+G0ny3JFaUBw4hVOlldS5Z0pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifsu8ge5PHL6AXuWgNr675IZlMczGnVEJNOmAios79X+rr0qI9gpJ0hLbt6aCuzxjmTXYsbJQsoop38cinFY5rIjiQVehF6WflcSQadJr8PXRLAM00XMHhrnJ7TN0Th8vqAPWw+7QpjGknpWhNsPBrM2jFkRXtmxarVmKQmFU1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ACQ7l+Ll; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719005268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IQ0xDPDL6YPvh4aLolM37qH0KjXqVwO7jVCuyxbPwL0=;
	b=ACQ7l+LlFzMeTzoRwmbfRXMuBTV6b06tztLfi7DgO64CI0IULW98GnNb9VFAWVAG2Wx/ng
	7Tew30Ag1jcjI66ByyYmZ95j5ZucJN0l0gMu1F7ZQDg/XSjuQnwwOIojyRQEoKhgFBSyTh
	qYGIr2Z23A45jG9M+QQg/AILj+ZY5us=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-ysnNRg0sNp-SdYW33qQT7Q-1; Fri, 21 Jun 2024 17:27:47 -0400
X-MC-Unique: ysnNRg0sNp-SdYW33qQT7Q-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4ecfc49d4b1so24301e0c.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 14:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719005267; x=1719610067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQ0xDPDL6YPvh4aLolM37qH0KjXqVwO7jVCuyxbPwL0=;
        b=K61VkDrP/cbUUfR8IyGR596D/WqUtqhyLspvpsxTvZ4Zd2BKwFLLmjshElELrFIIkk
         Vt2jUg+5/qyP917ioGJfYKtHVQmkkyklNHtG7JQEzoKg7TxGjE8kQ2yK+bK0p6g+5mPi
         07pwrbVD2Yt1AEbIWNBukMZYx4T8b1CKgPYhYEci2Ghs8t5GIzpVGJmZ7cBcXpNW+83F
         ZbEHnc0/yF4m0h6hczukGuLDee6gGv1YofPPJfFP1uUhu5GoHrTkrr5/P+8yfaKYn5mk
         P6Jy0isudNTuAZaxw6RkF79W5WRiWtiB2kwjUqjyHXcUrVgt9sUya1NiT6/wmDJq/hfv
         8fCA==
X-Forwarded-Encrypted: i=1; AJvYcCW+/eCJj4Dv0SO/Phwn7a0xdCBy4yOmfaFnKmt/hABRU7OXcpB6758g64D2WeWhJFzDmcj0xvyHC9foOfN5tabVVAUN8QDWovEUQAt8Wlh/
X-Gm-Message-State: AOJu0YyejfocLW5ET2ltpk3UgeOJbaYVUBuH2+ZIeiiY0PK+Z5BkxgtV
	ls4Jg69dYdfUilbcuZ/5qLpITPtT0SjciQ1l5Vq3q15D//lxbof9l/Anm8Pm+QKP9itB30vtDs0
	sYhEUNNHtDE+eDPvQ1mjW4k786SC5tfAj2WCaIzGSZWVaGDqFnhpO2S1CNsj6dwUX8A==
X-Received: by 2002:a05:6102:38c8:b0:48c:40d5:42e3 with SMTP id ada2fe7eead31-48f1309dfb6mr10014217137.2.1719005266907;
        Fri, 21 Jun 2024 14:27:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzupZ6agYxyv1aCWC7ddqvrHfUJj/wIVHn0qwNGlrsJjIRvL0WGKAYxaQoaDL6E1YUniP5lA==
X-Received: by 2002:a05:6102:38c8:b0:48c:40d5:42e3 with SMTP id ada2fe7eead31-48f1309dfb6mr10014198137.2.1719005266409;
        Fri, 21 Jun 2024 14:27:46 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce89be42sm117046185a.10.2024.06.21.14.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 14:27:45 -0700 (PDT)
Date: Fri, 21 Jun 2024 17:27:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Audra Mitchell <audra@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	aarcange@redhat.com, akpm@linux-foundation.org,
	rppt@linux.vnet.ibm.com, shli@fb.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, raquini@redhat.com
Subject: Re: [PATCH v2 3/3] Turn off test_uffdio_wp if
 CONFIG_PTE_MARKER_UFFD_WP is not configured.
Message-ID: <ZnXwT_vkyVbIJefN@x1n>
References: <20240621181224.3881179-1-audra@redhat.com>
 <20240621181224.3881179-3-audra@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240621181224.3881179-3-audra@redhat.com>

On Fri, Jun 21, 2024 at 02:12:24PM -0400, Audra Mitchell wrote:
> If CONFIG_PTE_MARKER_UFFD_WP is disabled, then testing with test_uffdio_up

Here you're talking about pte markers, then..

> enables calling uffdio_regsiter with the flag UFFDIO_REGISTER_MODE_WP. The
> kernel ensures in vma_can_userfault() that if CONFIG_PTE_MARKER_UFFD_WP
> is disabled, only allow the VM_UFFD_WP on anonymous vmas.
> 
> Signed-off-by: Audra Mitchell <audra@redhat.com>
> ---
>  tools/testing/selftests/mm/uffd-stress.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> index b9b6d858eab8..2601c9dfadd6 100644
> --- a/tools/testing/selftests/mm/uffd-stress.c
> +++ b/tools/testing/selftests/mm/uffd-stress.c
> @@ -419,6 +419,9 @@ static void parse_test_type_arg(const char *raw_type)
>  	test_uffdio_wp = test_uffdio_wp &&
>  		(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);
>  
> +	if (test_type != TEST_ANON && !(features & UFFD_FEATURE_WP_UNPOPULATED))
> +		test_uffdio_wp = false;

... here you're checking against wp_unpopulated.  I'm slightly confused.

Are you running this test over shmem/hugetlb when the WP feature isn't
supported?

I'm wondering whether you're looking for UFFD_FEATURE_WP_HUGETLBFS_SHMEM
instead.

Thanks,

> +
>  	close(uffd);
>  	uffd = -1;
>  }
> -- 
> 2.44.0
> 

-- 
Peter Xu


