Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE6337A3FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 May 2021 11:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhEKJs7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 May 2021 05:48:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230434AbhEKJs7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 May 2021 05:48:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8D7F61621;
        Tue, 11 May 2021 09:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620726473;
        bh=xYgRdmVqmN+Qwy470JI7HiWW0iQYsCOHangiosFnU/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YISHGm7jPoPIEH8aOWfK0E3VYmra2q6AcdXhV3HdCs9bReM8puaPPfBOmfNimhjO5
         5TP5fSjuQHjADaB0Czo6gtkPtKC0VPW+rr0oZkJuRThHK7lZztwQhn0DbeawxT/Q17
         Uy/9ky4+JTExTXKTZ+DRNwil8q53v+HV7leHf+GvvfHfYqppACOl/GvTwjxm426w+K
         dNqfFZhswZjRKF4MWgy86qovtvTb1AGKv6asmT1tWG6cSaV2/1FnRLoBM64lxq2yne
         veV3V+ULtk6DVX2PZ353KOLm9FPE9tGuKhiPj5vtZuUcg915O8s3/jdG9K0pW92Xv4
         bGIzTf7iaQjPA==
Date:   Tue, 11 May 2021 12:47:45 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH resend v2 3/5] MAINTAINERS: add
 tools/testing/selftests/vm/ to MEMORY MANAGEMENT
Message-ID: <YJpSwfKo4PSb14U6@kernel.org>
References: <20210511081534.3507-1-david@redhat.com>
 <20210511081534.3507-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511081534.3507-4-david@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 11, 2021 at 10:15:32AM +0200, David Hildenbrand wrote:
> MEMORY MANAGEMENT seems to be a good fit.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9450e052f1b1..cd267d218e08 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11566,6 +11566,7 @@ F:	include/linux/mm.h
>  F:	include/linux/mmzone.h
>  F:	include/linux/vmalloc.h
>  F:	mm/
> +F:	tools/testing/selftests/vm/
>  
>  MEMORY TECHNOLOGY DEVICES (MTD)
>  M:	Miquel Raynal <miquel.raynal@bootlin.com>
> -- 
> 2.30.2
> 
> 

-- 
Sincerely yours,
Mike.
