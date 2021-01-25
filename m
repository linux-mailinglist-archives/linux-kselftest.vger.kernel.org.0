Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C75E3047AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Jan 2021 20:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbhAZF6g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Jan 2021 00:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbhAYO3m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Jan 2021 09:29:42 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67873C0617AA
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Jan 2021 06:28:21 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id l23so7259927qtq.13
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Jan 2021 06:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gqrob1newlkQ15lRtU6auZ3RzaABmYXA8xpX2IglXFQ=;
        b=dGX57SKqFdpXq5Em8dpxESukUDK+OYiiN20VisCm8Wi+VFYCGEzLwzJQYwF1wsuX7r
         WjZJwHEvgvYAc4oAicLOOCAwPegzkAoCSLgLXVDWCGsrbRKY+vMoGhqIDIm/qcF3wyoX
         b+hwihpHfWpDuJsB4/bB0oipat6DwE7Oql4xR1XMqYNVs6VvbUXm35h4WKvxzkvcdadX
         kUDDTyr/b3yOo8C+AyPndWjFIf3sK4ivPmbG2qSZvbKM6s6BdVRmMkx02qk4qz5cKkBh
         0E5bdtMqcDbzuKXs/tLLt3dvNzJfdlDzLp1x5LEheVzj+HrgZHJimVBItPJDW19vNXXO
         8y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gqrob1newlkQ15lRtU6auZ3RzaABmYXA8xpX2IglXFQ=;
        b=HkSDS3VGUFWrEovfiznvxeCQzBddIRa7aK6+2gXh6Ea+cgnkivnAwyn2mkBRNGt3M7
         zJTcc1UDkaYzawp+23gvjbM/FfKtombyYRWq8BK7w4Szf9wGlkqej8W5IjFlj9GtX4ZM
         sisPuOaP4p3xoNEdFacSV6Og7sSt0FXtPfCwFVtaYlW3CUPH6aP5CaNlcCEqGNVzg68f
         /00a6isUzktll0PprYrWwNHEY7ANEBvlJj0ZN9wqxx8sLMntCB+RpVC6CzwBfLwVVwVW
         MribGvqeK5lBhRW8NC+ErEMnr4iBD79ig2DiP9qw16QlT/6gnd58wDYF+rmJCHD7bjdz
         /TTQ==
X-Gm-Message-State: AOAM531QqsGp1Ps7XAWli8HU4k4JEFiVrhlwvSly5GIDCu6AUttOOaXQ
        WP/cxvFbCXmSWuYZDQiRc5S3zw==
X-Google-Smtp-Source: ABdhPJzF2m7RRft4yyKJebF8jzkPIF+Jv8HIYEWXVMaMo2dw3cdqZZG9ubwMIkYD4CRazbEmFlt1hg==
X-Received: by 2002:ac8:6edd:: with SMTP id f29mr654427qtv.213.1611584900594;
        Mon, 25 Jan 2021 06:28:20 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id m64sm12086816qkb.90.2021.01.25.06.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 06:28:20 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l42qp-006Vxe-HI; Mon, 25 Jan 2021 10:28:19 -0400
Date:   Mon, 25 Jan 2021 10:28:19 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 08/14] mm/gup: do not migrate zero page
Message-ID: <20210125142819.GU4605@ziepe.ca>
References: <20210120014333.222547-1-pasha.tatashin@soleen.com>
 <20210120014333.222547-9-pasha.tatashin@soleen.com>
 <20210120131400.GF4605@ziepe.ca>
 <CA+CK2bCu-uWWOxS_sPhfgzXTq-cqYFsHK_QFo7F+rStKpJJDRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bCu-uWWOxS_sPhfgzXTq-cqYFsHK_QFo7F+rStKpJJDRA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 20, 2021 at 09:26:41AM -0500, Pavel Tatashin wrote:

> I thought about this, and it would code a little cleaner. But, the
> reason I did not is because zero_page is perfectly pinnable, it is not
> pinnable only when it is in a movable zone (and it should not be in a
> movable zones for other reasons as well), but that is another bug that
> needs to be resolved, and once that bug is resolved this condition can
> be removed from gup migration.

My point is you've defined the zero page to be pinnable no matter what
zone it is in, so is_pinnable(zero_page) == true

Jason
