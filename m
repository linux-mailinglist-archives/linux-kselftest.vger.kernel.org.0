Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DD9722FC3
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 21:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjFETZh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 15:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjFETZg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 15:25:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C46A7
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 12:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685993095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JoPaSgBjJj58dV7BGiXU3uSF8sQlJSVxH8VXpwcoLMw=;
        b=UhWLSPi6ymb0BfI1e/oPQpi709q1fMiyXU1ZD9pwjiiUff3CA/Gk3diykROF1XjdDtIyx3
        3LqxRxy8qCS+YfcHrP0joC56bLzC4Lp7Yw7/m19mZv5d9t5Oppn4mvOh+64fm8GDdcZbcs
        Z5EU08R40J95SNG5E6YnHR7X9znsVPs=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-4HwM4mXxOZyL_s3SbO9B8w-1; Mon, 05 Jun 2023 15:24:53 -0400
X-MC-Unique: 4HwM4mXxOZyL_s3SbO9B8w-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-39a661c98f5so201398b6e.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jun 2023 12:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685993093; x=1688585093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoPaSgBjJj58dV7BGiXU3uSF8sQlJSVxH8VXpwcoLMw=;
        b=DJj5LvNraRFnnkKcgaaMlh2cPh++bmVPlBzHXAUqT0Kt4PsTrmhVQmAcnUihgPQIhg
         TA6CB3j4SpMHRIXCW/FNgWc5TUDflDOzcec/AdHO12LxaRvN3AhxjHI3My99bTCHeoyZ
         idC4jN+rnnCOmf630cRswygquWifLf+hQ7I/17lanyoSI+NCRBiEqB1mkv7SdbZ7Az1C
         FyNa9rl38OHt6Cj1JoRLWRjEPWUv8xzral6b8K4Qrmmmc+Sjm15q6laQyGOxFOZXnmhH
         /YonGVxnMkdtiPbtzxYnfF5+knKnrCNHRegpI0xIhokdl7zxyfNbIqYf7xPF2mPC4F+B
         avaQ==
X-Gm-Message-State: AC+VfDzpIdedG9aZa1isKc4OGJEC04oIw/f/HiuIlRAog5vb5OVDDQqF
        yGuYkZXKYHBkTX45xk4Be7FwhiuYL2bgnVSqobpS/DpFqvhQeaSfzwZyUjb3o1HI1/C5x1835wy
        mnklOjbkFOp2cNlwEFTs7ztbXrb9h
X-Received: by 2002:aca:a996:0:b0:39a:a954:27c4 with SMTP id s144-20020acaa996000000b0039aa95427c4mr2884849oie.3.1685993093194;
        Mon, 05 Jun 2023 12:24:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Mfdj34eQ1b4i+fRAgLjlkKw0kQ8EH2tf7A1gWHk0CuRloljMcckNNyN5sTy89XgfAwILYMw==
X-Received: by 2002:aca:a996:0:b0:39a:a954:27c4 with SMTP id s144-20020acaa996000000b0039aa95427c4mr2884838oie.3.1685993092878;
        Mon, 05 Jun 2023 12:24:52 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id m13-20020a05621402ad00b00623839cba8csm4828284qvv.44.2023.06.05.12.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 12:24:52 -0700 (PDT)
Date:   Mon, 5 Jun 2023 15:24:50 -0400
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
Message-ID: <ZH42gkoHIsgMbvHn@x1n>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
 <20230603021558.95299-11-jhubbard@nvidia.com>
 <ZH4GUODwj9L9paey@x1n>
 <64e21a2c-1bbe-4ab6-e67a-29b2d1d1978e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64e21a2c-1bbe-4ab6-e67a-29b2d1d1978e@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 05, 2023 at 12:09:56PM -0700, John Hubbard wrote:
> On 6/5/23 08:59, Peter Xu wrote:
> ...
> > > -$(OUTPUT)/uffd-stress: uffd-common.c
> > > -$(OUTPUT)/uffd-unit-tests: uffd-common.c
> > > +$(OUTPUT)/uffd-stress:          uffd-common.c
> > > +$(OUTPUT)/uffd-unit-tests:      uffd-common.c
> > > +$(OUTPUT)/hugepage-mremap:      uffd-common.c
> > > +$(OUTPUT)/write_to_hugetlbfs:   uffd-common.c
> > > +$(OUTPUT)/ksm_functional_tests: uffd-common.c
> > 
> > Sorry, John, I still cannot follow..
> > 
> > As I said before uffd-common.[ch] was for uffd stress/unit tests.  I
> > confess my fault to not have named it uffd-test-common.[ch] already.
> 
> Actually, given that there is nothing *except* test code in this
> directory, I think your original choice of file names is just right.
> 
> > 
> > I think it's fine to keep uffd_*() helpers in vm_util.[ch] for now, until
> > it grows.  Just like if one day we'll have a pagemap.c test we don't
> > necessary need to move pagemap_*() helpers from vm_utils.[ch] into
> > pagemap.[ch].  It just keeps common test helpers.
> > 
> > Can we avoid linking those into other tests in whatever way?  Maybe
> > renaming it to uffd-test-common.[ch] may be cleaner?
> > 
> 
> It sounds like you are suggesting this:
> 
> $(OUTPUT)/uffd-stress:          uffd-common.c uffd-test-common.c
> $(OUTPUT)/uffd-unit-tests:      uffd-common.c uffd-test-common.c
> $(OUTPUT)/hugepage-mremap:      uffd-test-common.c
> $(OUTPUT)/write_to_hugetlbfs:   uffd-test-common.c
> $(OUTPUT)/ksm_functional_tests: uffd-test-common.c
> 
> ...approximately. Do I have that correct? I can arrange it that way
> if you feel it's a better end result. (And it's better than leaving
> uffd*() helpers in vm_utils, imho.)

Yes, as long as we don't link (especially) the uffd test specific globals
into non-uffd test programs I'll have no issue.  Thanks.

-- 
Peter Xu

