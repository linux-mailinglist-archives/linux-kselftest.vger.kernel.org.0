Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F84D2FD6EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jan 2021 18:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbhATOIY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jan 2021 09:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731680AbhATNXG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jan 2021 08:23:06 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6159C061575
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jan 2021 05:22:25 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 19so25233819qkm.8
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jan 2021 05:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TxOJ2i1obQZTYWUjOO4AH/QKsmg0DUJ9EGaechEIo20=;
        b=IvzX1RMAtfsiwGFzzn5FfORQgcXPhllACg7D+ANj7TlWPd5qMsoyPmKGn1XhVA8NwM
         tafb4+W9ckHIwIC2JBfwYCAPgXVbUIzt+6pL2UDYN50uqUst7fkRN9pWNY9xSsstQzUA
         bb1vo+9Prb3OaiUP7mgZO7sGWE3g0yX548ApY/8loBpncFwLJA4OaUHs+Xei5i/ul45A
         Poyg8uDGFCtY7vtgdHVF74Rvl9Rq59pDg4A1B9F/2weKRBdIUNb8ORuYNQnaTBdjr5Y+
         abTearQ0KBLILW07vILaeT4ncQ5ARwtQ3rEQoueKnAru9qTf91hl1CGFQlLXQ2yJXPYo
         ZxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TxOJ2i1obQZTYWUjOO4AH/QKsmg0DUJ9EGaechEIo20=;
        b=gyRD0ZpUv0/NiTxDN0w3sDb63molMskHhgLgvC+Lr3FkimK63eR5FPIZtp5UrwUHJj
         6PCojyu2fV+ZI9LLXKrDUZWgbTFhNwbcRz8azp1QuqgQcwZnKlvM5+tEYSkQX/x2ymNY
         ZIBnWTNxMk+0KNgm/L9ImGzdy/ynP7Tr5dqtpuBbsoVKuQuuyT/8hRvnFPxxA1f3szZE
         geZi3XnTHf89vp82o9lzY1FreejTMkHPvWWXX6rjmsUSF4DsbILUIZU4dSWN+0ksM7ia
         OtrTq9Xr4tWsCv+spSiyXTH3X9nY9NEvdSEYYxDjrppBX26T5VP3AVbb5mmhU8tDMQKA
         yLVw==
X-Gm-Message-State: AOAM530PACgfvrab5PU51Q0o2CGzHhveUdioe1HmgP+ydN/v1U/JjQKA
        3fNN6JSBJjltuczs78rOpXrNNA==
X-Google-Smtp-Source: ABdhPJxVh5jUl4y5I89LvXDP0n+KjibmY3MDSvd+QOMJtVbYZtAlkbEyk4UcJVKl2qWGnRtxmq5muA==
X-Received: by 2002:a05:620a:125c:: with SMTP id a28mr9451371qkl.112.1611148945095;
        Wed, 20 Jan 2021 05:22:25 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id r190sm1313094qka.54.2021.01.20.05.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 05:22:24 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l2DRH-004Tyo-Ee; Wed, 20 Jan 2021 09:22:23 -0400
Date:   Wed, 20 Jan 2021 09:22:23 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        sashal@kernel.org, tyhicks@linux.microsoft.com,
        iamjoonsoo.kim@lge.com, mike.kravetz@oracle.com,
        rostedt@goodmis.org, mingo@redhat.com, peterz@infradead.org,
        mgorman@suse.de, willy@infradead.org, rientjes@google.com,
        jhubbard@nvidia.com, linux-doc@vger.kernel.org,
        ira.weiny@intel.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 10/14] memory-hotplug.rst: add a note about
 ZONE_MOVABLE and page pinning
Message-ID: <20210120132223.GH4605@ziepe.ca>
References: <20210120014333.222547-1-pasha.tatashin@soleen.com>
 <20210120014333.222547-11-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120014333.222547-11-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 19, 2021 at 08:43:29PM -0500, Pavel Tatashin wrote:
> +.. note::
> +   Techniques that rely on long-term pinnings of memory (especially, RDMA and
> +   vfio) are fundamentally problematic with ZONE_MOVABLE and, therefore, memory
> +   hot remove. Pinned pages cannot reside on ZONE_MOVABLE, to guarantee that
> +   memory can still get hot removed - be aware that pinning can fail even if
> +   there is plenty of free memory in ZONE_MOVABLE. In addition, using
> +   ZONE_MOVABLE might make page pinning more expensive, because pages have to be
> +   migrated off that zone first.

Just to point out, if anyone is using RDMA/etc with hotplug memory,
this series is likekly going to be a major regression for those users.

Jason
