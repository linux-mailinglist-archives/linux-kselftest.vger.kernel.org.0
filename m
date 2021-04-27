Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF3836C8F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Apr 2021 17:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238034AbhD0P6C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Apr 2021 11:58:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44122 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236589AbhD0P6C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Apr 2021 11:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619539038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UeRAYJi3jVz2RcJA5cfm9/ZZeziOqivA1BEyk0ctB+8=;
        b=cPw5KuU5YKX57TvUkrq0W/Bm1Zp2yUw19CrCFDBBWUqu0InCoXXYyHPmCB7U4z3hTqjVb/
        jJIDvQMPlki2zShs2iuAJm81/wRHJBrZev6SBDZYVo879CqQPJXgrsugNhkOXGp6U/KjKc
        QYmQkK4MA7xKhhZl65RZhyDexxCjqV0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-xMytMof9Ol-b28DftIWnFg-1; Tue, 27 Apr 2021 11:57:16 -0400
X-MC-Unique: xMytMof9Ol-b28DftIWnFg-1
Received: by mail-qt1-f197.google.com with SMTP id a11-20020ac85b8b0000b02901a69faebe0cso23501885qta.6
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Apr 2021 08:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UeRAYJi3jVz2RcJA5cfm9/ZZeziOqivA1BEyk0ctB+8=;
        b=Ym5IhJgjUKjVEF+CjPkk/rkxhTjeqrFgjLWS1kojmK4y31oEeUwtImq6thfkQztUz2
         acFTF58rORGgnQh3YM2hI5Y4FrSWYcrqvH26BxOXXOlqnRU4TVSNblFEjcA5UrRpvdcZ
         jSAGXekdo2OnNre0wHhuUyRZ+iy+AxkO1QsV1RZvftkThVohYGMbXzIzBbiFl10Lh0or
         hBImhjf8Zl9Paq1rBdflGSJ8VYn2giHdxQfQCCgBbxsfo+3iHBSghF/rjiCepHC5ZPYs
         efwHbn8g5wYUWGKQ7P3lJZOCkq1GEW9Y1Sv0Di6LxtnIzsg2+CU3mkozfJNlgqWOb274
         V1Xg==
X-Gm-Message-State: AOAM530oi5whNRhMIFWJshACRrUTCitDrvw3N1HmtCDqfihDXRQMpo+8
        OgJBkkti29dA1tlF3E2B5De8SO+ghvFQBk1OOc2haZD85kiXsrpCIFs+ao2RGuxUokR943ecD9M
        +hIiyk4DxczGySLI3+g7jl/lOlvF8
X-Received: by 2002:a37:9305:: with SMTP id v5mr23224454qkd.223.1619539036071;
        Tue, 27 Apr 2021 08:57:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwt9C9yyPCKjs/11oWJ2ljp8cgvSKc3nf/K+fOGkHMK5svdKo+b6nP8QjYAWsUrtuDALqrP7A==
X-Received: by 2002:a37:9305:: with SMTP id v5mr23224422qkd.223.1619539035849;
        Tue, 27 Apr 2021 08:57:15 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id h62sm2925543qkf.116.2021.04.27.08.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 08:57:15 -0700 (PDT)
Date:   Tue, 27 Apr 2021 11:57:13 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v4 04/10] userfaultfd/shmem: support minor fault
 registration for shmem
Message-ID: <20210427155713.GC6820@xz-x1>
References: <20210420220804.486803-1-axelrasmussen@google.com>
 <20210420220804.486803-5-axelrasmussen@google.com>
 <alpine.LSU.2.11.2104261920110.2998@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2104261920110.2998@eggly.anvils>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 26, 2021 at 07:23:57PM -0700, Hugh Dickins wrote:
> On Tue, 20 Apr 2021, Axel Rasmussen wrote:
> 
> > This patch allows shmem-backed VMAs to be registered for minor faults.
> > Minor faults are appropriately relayed to userspace in the fault path,
> > for VMAs with the relevant flag.
> > 
> > This commit doesn't hook up the UFFDIO_CONTINUE ioctl for shmem-backed
> > minor faults, though, so userspace doesn't yet have a way to resolve
> > such faults.
> > 
> > Acked-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> 
> And if this "04/10" had been numbered 03/10, I would have said
> Acked-by: Hugh Dickins <hughd@google.com>
> 
> Just read the comment above: "so userspace doesn't yet have a way to
> resolve such faults" - if it doesn't by this stage, we're in trouble.

Right, so merging the two patches might be easier.  Even if we don't merge
them, we'll need to touch up the commit message since at least above paragraph
is not true anymore as we've already have UFFDIO_CONTINUE.  Thanks,

-- 
Peter Xu

