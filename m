Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5DF35E776
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Apr 2021 22:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhDMUQC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Apr 2021 16:16:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36510 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230308AbhDMUQA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Apr 2021 16:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618344940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z6jLMxHXDVRiXYyQcd5eAsrnA6ok/2H8Sdo63BFQ8u4=;
        b=Hu1HFIJU3N6/ztfyD7uoYVioIZNcujtcYKYSeBM4T+A35w0t5cfU+TcPOvh9PvnrOvewbH
        auQV3KwZUY2Dc5xGEriGzRkWS/XJ63zUiDO0sl28q0fVhK05HFt02KQr0ap/dOqipYo2uv
        yNHASmCWd6ouZEF3aoNgk67eQJgCf8w=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-UssUAihkO-WV0F79fdzRBw-1; Tue, 13 Apr 2021 16:15:38 -0400
X-MC-Unique: UssUAihkO-WV0F79fdzRBw-1
Received: by mail-qv1-f71.google.com with SMTP id p2so10729267qvi.6
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Apr 2021 13:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z6jLMxHXDVRiXYyQcd5eAsrnA6ok/2H8Sdo63BFQ8u4=;
        b=IRnbLygLbjXB43U3Yf460vQfn3IAg1omr/yyTm5Uh/TYVSvUjbvbGMcwXysUTFj3Ks
         tXR6T7bKf8tXEDmac+pQXMylKP7ECZbYQLsPvABvWTs7DVYvHPh1IoBTqiQ/kOkZp1rs
         vjvs9wa7mHReWy2dM6XNaEdyiJuaVzcNTDk+OmTzp8dBKflay1VKGVsSpCI5mYgApmKF
         MefqVQ5gbEL9BXzk/2cfSqLZdhjCgrpqdg5Fb1YTFB/pxPlgjwDyxFqv0U0DLHmAad2J
         Qn5m0W88xc/+J9SwsYEo7+09TSsVmJyBxg+AXmHrcvRHU6qCBFFanx1PP/SNXG5qC+zl
         dHUw==
X-Gm-Message-State: AOAM530b/QMtH1cEhuoRPuAv/WK12nzzN/O1nyIvVE7fl0XgasX0jyAi
        jwx7i2l3G8w/MEDX3xA+COpLffpqrTCc0C5qA8wO8B5/bIvn0gD2KZfCkLi3aAO3E0NIvWCMQtp
        wQJQas18EOgqCcl9mkqJWYM/jqhDQ
X-Received: by 2002:ae9:f503:: with SMTP id o3mr32222750qkg.331.1618344938278;
        Tue, 13 Apr 2021 13:15:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzk0HNq0oDNyEr5ELMzeUTmw4uMriVRz0Eo5dEdf+xlarAnuXBL2LazN2KzuwaIREXFINZXmw==
X-Received: by 2002:ae9:f503:: with SMTP id o3mr32222721qkg.331.1618344937981;
        Tue, 13 Apr 2021 13:15:37 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id l16sm11024953qkg.91.2021.04.13.13.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 13:15:37 -0700 (PDT)
Date:   Tue, 13 Apr 2021 16:15:35 -0400
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
Subject: Re: [PATCH v2 7/9] userfaultfd/selftests: reinitialize test context
 in each test
Message-ID: <20210413201535.GD4440@xz-x1>
References: <20210413051721.2896915-1-axelrasmussen@google.com>
 <20210413051721.2896915-8-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210413051721.2896915-8-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 12, 2021 at 10:17:19PM -0700, Axel Rasmussen wrote:
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
> ---
>  tools/testing/selftests/vm/userfaultfd.c | 221 +++++++++++++----------
>  1 file changed, 127 insertions(+), 94 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 1f65c4ab7994..0ff01f437a39 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -89,7 +89,8 @@ static int shm_fd;
>  static int huge_fd;
>  static char *huge_fd_off0;
>  static unsigned long long *count_verify;
> -static int uffd, uffd_flags, finished, *pipefd;
> +static int uffd = -1;
> +static int uffd_flags, finished, *pipefd;
>  static char *area_src, *area_src_alias, *area_dst, *area_dst_alias;
>  static char *zeropage;
>  pthread_attr_t attr;
> @@ -342,6 +343,121 @@ static struct uffd_test_ops hugetlb_uffd_test_ops = {
>  
>  static struct uffd_test_ops *uffd_test_ops;
>  
> +static int userfaultfd_open(uint64_t *features)
> +{
> +	struct uffdio_api uffdio_api;
> +
> +	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);

Keep UFFD_USER_MODE_ONLY?

[...]

> @@ -961,10 +1045,9 @@ static int userfaultfd_zeropage_test(void)
>  	printf("testing UFFDIO_ZEROPAGE: ");
>  	fflush(stdout);
>  
> -	uffd_test_ops->release_pages(area_dst);
> -
> -	if (userfaultfd_open(0))
> +	if (uffd_test_ctx_clear() || uffd_test_ctx_init(0))
>  		return 1;

Would it look even nicer to init() at the entry of each test, and clear() after
finish one test?

> +
>  	uffdio_register.range.start = (unsigned long) area_dst;
>  	uffdio_register.range.len = nr_pages * page_size;
>  	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;

The rest looks good to me.  Thanks,

-- 
Peter Xu

