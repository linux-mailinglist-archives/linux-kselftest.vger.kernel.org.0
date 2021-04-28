Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552D336DE28
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Apr 2021 19:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239670AbhD1RYd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Apr 2021 13:24:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50712 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231659AbhD1RYc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Apr 2021 13:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619630626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6QmxbNDcfkmoT4snx6gLW6zB0uLTOmzBgWbCGZ43h/M=;
        b=ZzCrrHdOP4mJDOUxSO+4Q35NSCs/UVzEYL0+E6A4nwVXZlJ3jlcbDT7BXrCRtifO+UwYBe
        oUzyQIbHta8wd7OyV16gwsMtsOREU/xhaIFfPvaCeQHes5mm/mb0i8gCVQ0rHTXmzV/i8l
        I7VqYah1c3/+dw0KoR+yIYo+LJG8uTU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-5qYlqyLxOeKMIP0LChir4Q-1; Wed, 28 Apr 2021 13:23:44 -0400
X-MC-Unique: 5qYlqyLxOeKMIP0LChir4Q-1
Received: by mail-qt1-f198.google.com with SMTP id 7-20020ac857070000b02901ba5c36e1b2so16540873qtw.21
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Apr 2021 10:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6QmxbNDcfkmoT4snx6gLW6zB0uLTOmzBgWbCGZ43h/M=;
        b=rQEnfum1ER3UYDrSuyxJj1uOV5MXftOyQQ9/k8DSH7h1DggpgDYNnMrNZQlniPZzXl
         1bJhe1h7jnaLiDdNyvfE8GeoRUjcBPg5f+u8VotQUt60ATpLiXCiyYmhxX5RvhPcBCz/
         lqm6pnOigay/A2H+VbjDqSGColUhOMs0SRy7xpDSVjv27Uz3AkqyDWnY0A+SM5KKfTTr
         02HEtjixfjr8bOsvv3R0+PbPF4MB5GwOFPffRP667i4phy9jEkRjuz+vSaGCOmEARixa
         MgLSu6wEbPEOL+Td+VEnZpWeIsxFC8wumEsS6BIaaA1zwKLiS9ztFfYpVFK3cUcTF0hA
         z82A==
X-Gm-Message-State: AOAM532i4eQmgxzzp4Ort9+2YMHB8T274euR3RfXzDWm+PxQDErlHlRI
        RejX3bOmLk/dipHguNY9ZrZJRD5SL57NnXI74tQXLZ5Gexci9NqseEYKBQH5Rdrfg8sT7I7RCSH
        e0xs7qSjo9RM6t6XhsQncvy8vuXBe
X-Received: by 2002:ae9:f310:: with SMTP id p16mr29914955qkg.123.1619630624371;
        Wed, 28 Apr 2021 10:23:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweTpfhxOs2+FE7b/y38FVRdocxBBDoCy0Saro4x4l/ivnG64cNuM5i6194baTUbY8T8h2pWw==
X-Received: by 2002:ae9:f310:: with SMTP id p16mr29914911qkg.123.1619630624022;
        Wed, 28 Apr 2021 10:23:44 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id 198sm275365qkf.20.2021.04.28.10.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 10:23:43 -0700 (PDT)
Date:   Wed, 28 Apr 2021 13:23:41 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v5 09/10] userfaultfd/selftests: reinitialize test
 context in each test
Message-ID: <20210428172341.GF6584@xz-x1>
References: <20210427225244.4326-1-axelrasmussen@google.com>
 <20210427225244.4326-10-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210427225244.4326-10-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 27, 2021 at 03:52:43PM -0700, Axel Rasmussen wrote:
> Currently, the context (fds, mmap-ed areas, etc.) are global. Each test
> mutates this state in some way, in some cases really "clobbering it"
> (e.g., the events test mremap-ing area_dst over the top of area_src, or
> the minor faults tests overwriting the count_verify values in the test
> areas). We run the tests in a particular order, each test is careful to
> make the right assumptions about its starting state, etc.
> 
> But, this is fragile. It's better for a test's success or failure to not
> depend on what some other prior test case did to the global state.
> 
> To that end, clear and reinitialize the test context at the start of
> each test case, so whatever prior test cases did doesn't affect future
> tests.
> 
> This is particularly relevant to this series because the events test's
> mremap of area_dst screws up assumptions the minor fault test was
> relying on. This wasn't a problem for hugetlb, as we don't mremap in
> that case.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

