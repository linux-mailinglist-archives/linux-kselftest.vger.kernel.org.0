Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE8B722C0A
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 18:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjFEQAG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 12:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjFEQAE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 12:00:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4193E6
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 08:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685980758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uyrUBvno+IrPZ60v5iivP0nADI9OfEfqOQHaF03JrSU=;
        b=AKwcYDAdXV7UtOQWtUERY12QcbJx5JMj+HRIhemi+c1nsbiZPXkJ+aUNDBjorK2+g98g0q
        RZK/+RYEFpUZcYvTDYzQWdXM/AbLf+PKS+orWMjNXOOAMf3vnzCg1aNe4DUTBQZ+nSXGqU
        PpM/35JhwifuIB8/NP+xqnzPley2GXM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-jBar9X35OQ2-juq4uDmeFw-1; Mon, 05 Jun 2023 11:59:15 -0400
X-MC-Unique: jBar9X35OQ2-juq4uDmeFw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-75e681229c5so28912385a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jun 2023 08:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685980754; x=1688572754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyrUBvno+IrPZ60v5iivP0nADI9OfEfqOQHaF03JrSU=;
        b=B8jpLIKrLusSsWsfep+01fDTEwAVICnFJZiVTX/rhT6lu6hC/1OaaRU/sJ3FjnqKVd
         v8CDVsG4bwL1L3RXzwZcYxXB654T6TgBVFoXoj7vif1nJC8Wq9gb88WwvuaXld+vDIz+
         IXI4DFhrqtuD4aTsaV/BRTFPdhZSHe+keCUZRna56RTQ6o3ERXth4L0HDpuBClv0d0Io
         u2ZBuLHNUuJoQYvhuHvaP8yVyNOLNETEnUj2temlYZXVWL8e1Mr7y+8Li0Ws0t6qeUFV
         GHE1fpwQm7A6OMidt4gKpr5iX0YEx2ciDKcFa1PbKU0ukaenbUNmglWyPvGVqVrZMjUT
         vgqQ==
X-Gm-Message-State: AC+VfDxQ0lh8yAegHEFsp9xRUeLC3mqB6zQ+flm96gzt8k+zRgDx6eQj
        GKFTRDvmJ/Y+61Ryejb6pbNi6g6b0FSNnz2bVGZPIhozGs4dQ5BF0FojKHj7UkvuwM7pBtFByu3
        miYFB6NQ+nHb1Q7ZrPOWWfT4Bb25z
X-Received: by 2002:a05:620a:6608:b0:75b:23a1:69ea with SMTP id qf8-20020a05620a660800b0075b23a169eamr17118186qkn.1.1685980754753;
        Mon, 05 Jun 2023 08:59:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4u2+bK77PigXhIkywwGskxKN4kJD78qerpTAlhUp/q1Xk3ttTydW7uzcrZWORTJnS71145Xw==
X-Received: by 2002:a05:620a:6608:b0:75b:23a1:69ea with SMTP id qf8-20020a05620a660800b0075b23a169eamr17118171qkn.1.1685980754533;
        Mon, 05 Jun 2023 08:59:14 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id p18-20020ae9f312000000b0075cad1e5907sm4308021qkg.7.2023.06.05.08.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 08:59:13 -0700 (PDT)
Date:   Mon, 5 Jun 2023 11:59:12 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/11] selftests/mm: move uffd* routines from
 vm_util.c to uffd-common.c
Message-ID: <ZH4GUODwj9L9paey@x1n>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
 <20230603021558.95299-11-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230603021558.95299-11-jhubbard@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 02, 2023 at 07:15:57PM -0700, John Hubbard wrote:
> Move the uffd*() routines to their natural home. Note that
> ksm_functional_tests.c also depend, intentionally (due to a recent
> commit [1]), upon uffd-common.[ch].
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  tools/testing/selftests/mm/Makefile           |   7 +-
>  tools/testing/selftests/mm/hugepage-mremap.c  |   2 +-
>  .../selftests/mm/ksm_functional_tests.c       |   2 +-
>  tools/testing/selftests/mm/uffd-common.c      | 105 ++++++++++++++++++
>  tools/testing/selftests/mm/uffd-common.h      |  12 +-
>  tools/testing/selftests/mm/vm_util.c          | 104 -----------------
>  tools/testing/selftests/mm/vm_util.h          |  10 --
>  7 files changed, 122 insertions(+), 120 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 23af4633f0f4..a15572758954 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -109,8 +109,11 @@ include ../lib.mk
>  
>  $(TEST_GEN_PROGS): vm_util.c
>  
> -$(OUTPUT)/uffd-stress: uffd-common.c
> -$(OUTPUT)/uffd-unit-tests: uffd-common.c
> +$(OUTPUT)/uffd-stress:          uffd-common.c
> +$(OUTPUT)/uffd-unit-tests:      uffd-common.c
> +$(OUTPUT)/hugepage-mremap:      uffd-common.c
> +$(OUTPUT)/write_to_hugetlbfs:   uffd-common.c
> +$(OUTPUT)/ksm_functional_tests: uffd-common.c

Sorry, John, I still cannot follow..

As I said before uffd-common.[ch] was for uffd stress/unit tests.  I
confess my fault to not have named it uffd-test-common.[ch] already.

I think it's fine to keep uffd_*() helpers in vm_util.[ch] for now, until
it grows.  Just like if one day we'll have a pagemap.c test we don't
necessary need to move pagemap_*() helpers from vm_utils.[ch] into
pagemap.[ch].  It just keeps common test helpers.

Can we avoid linking those into other tests in whatever way?  Maybe
renaming it to uffd-test-common.[ch] may be cleaner?

-- 
Peter Xu

