Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D943881C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 May 2021 22:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhERU6n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 May 2021 16:58:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41487 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352293AbhERU6m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 May 2021 16:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621371443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=os9Jf6J1kMn1gZUBBCbgzerMPhCA2LxWWK/nSdgqiLA=;
        b=Rt0+fMjPC5aO2x8G/Yv06XfwTK2hOVPS/rljR7ySGDUw6QElRIHglaEGX8KKFC5Ub7ita3
        eOindROV6nCnKX0cNzEmW7FXYXjRr5WjggZxLQjltZsdiAWe1GuBYw4Btx9AojEqawUkzm
        g7BcFkYMvHPbQCQKBdwMh3VPW8pTQME=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-RK46-ikJO9OlEiQBDeG4QQ-1; Tue, 18 May 2021 16:57:21 -0400
X-MC-Unique: RK46-ikJO9OlEiQBDeG4QQ-1
Received: by mail-qv1-f70.google.com with SMTP id i14-20020a0cf10e0000b02901eeced6480dso6912415qvl.4
        for <linux-kselftest@vger.kernel.org>; Tue, 18 May 2021 13:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=os9Jf6J1kMn1gZUBBCbgzerMPhCA2LxWWK/nSdgqiLA=;
        b=biluo/U3eW8ljj7vOcnR+lZVQvvVZUEsnGOuaqqw7hdoA30QZaMvfsTcITuJnHYv6H
         uDjKO8vX/SiHzTdMxGs9bEEhNsDv/22Yq/siujIw8eDwqJbVq52OOi6SU6wstpvnAIJt
         vQOkvfAFMwyAoXsYF/xJyt3aZU/SoPCtdkIN+NNbyUjREvk92T8PmDmyDj4VmjO68Yv1
         V1drvt+7UAt2IBg86n7xk3Uyy32B5lKOci2E96vMFgUrS49lN6qnFQy1HE6mHCH9lkI9
         QHnppgCemdHrF1L07Lx+hETfqHhEexT49hvaeWPjRAEAwq10tI3ytdpaYguwcMaNAsT4
         Xscw==
X-Gm-Message-State: AOAM533JjmiuSoBZdJ5HhzUzysKQFPNSR/UGCn8YfGDo4+UzSufIoyS9
        SuOTbBeP6VFf668hqfMld0PLMbbsxwuz3o52VmbulHiqRC9pbWeAxaRO58PdwOp1ZC5NfDm1dY0
        aXqt6+7+SXVy50ew0gfXBIZlehUhh
X-Received: by 2002:a0c:fd44:: with SMTP id j4mr8481450qvs.12.1621371441455;
        Tue, 18 May 2021 13:57:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPbtPTS7GA1DjU4twlKSNhyrANpoU7alV6mW8IiMGHJyAqzzJ6TCOkFpMmZKf7mBAGJ5Mb2g==
X-Received: by 2002:a0c:fd44:: with SMTP id j4mr8481084qvs.12.1621371437207;
        Tue, 18 May 2021 13:57:17 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id 64sm2637797qkn.87.2021.05.18.13.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 13:57:16 -0700 (PDT)
Date:   Tue, 18 May 2021 16:57:14 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
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
Message-ID: <YKQqKrl+/cQ1utrb@t490s>
References: <20210427225244.4326-1-axelrasmussen@google.com>
 <20210427225244.4326-10-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="D6+R1HeMtL7GYPqG"
Content-Disposition: inline
In-Reply-To: <20210427225244.4326-10-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--D6+R1HeMtL7GYPqG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

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

Hi, Andrew,

There's a conflict on the uffd test case with v5.13-rc1-mmots-2021-05-13-17-23
between this patch and the uffd pagemap series, so I think we may need to queue
another fixup patch (to be squashed into this patch of Axel's) which is
attached.

Thanks,

-- 
Peter Xu

--D6+R1HeMtL7GYPqG
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-fixup-userfaultfd-selftests-reinitialize-test-contex.patch"

From 745402175cc5670475df8e6c6bd03b6268f4175d Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 18 May 2021 16:50:36 -0400
Subject: [PATCH] fixup! userfaultfd/selftests: reinitialize test context in
 each test

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index c4150b4fbd17..f78816130c7f 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -1326,7 +1326,7 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 	/* Flush so it doesn't flush twice in parent/child later */
 	fflush(stdout);
 
-	uffd_test_ops->release_pages(area_dst);
+	uffd_test_ctx_init(0);
 
 	if (test_pgsize > page_size) {
 		/* This is a thp test */
@@ -1338,9 +1338,6 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 			err("madvise(MADV_NOHUGEPAGE) failed");
 	}
 
-	if (userfaultfd_open(0))
-		err("userfaultfd_open");
-
 	uffdio_register.range.start = (unsigned long) area_dst;
 	uffdio_register.range.len = nr_pages * page_size;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_WP;
@@ -1383,7 +1380,6 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 	pagemap_check_wp(value, false);
 
 	close(pagemap_fd);
-	close(uffd);
 	printf("done\n");
 }
 
-- 
2.31.1


--D6+R1HeMtL7GYPqG--

