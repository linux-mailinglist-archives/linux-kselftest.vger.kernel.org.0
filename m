Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CB1725227
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 04:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240444AbjFGCnB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 22:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbjFGCm6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 22:42:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A6210D2;
        Tue,  6 Jun 2023 19:42:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF727639EC;
        Wed,  7 Jun 2023 02:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB98BC433EF;
        Wed,  7 Jun 2023 02:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686105776;
        bh=HPX7TTyNLy9QYOmc7IjiU6+RwLEOPn30MEW3zhLSVew=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ubl2ySokBAZpXZwrtyG/EsPwhz9RPRnQArXZM1uSLVtRQErDCIvCbrOlqlQwiZJuP
         pvnpnlZM8Fymg8yhxYliosgbG7NmiKRNuWadMn+zpFbJJsQ6OsLL+4wc8Mu5PpiXv0
         oOm9Q5g9thm7ySWqbMML8TYWZ0QyZSIF2UjCxWlM=
Date:   Tue, 6 Jun 2023 19:42:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Peter Xu <peterx@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v1 2/3] selftests/mm: gup_longterm: new functional test
 for FOLL_LONGTERM
Message-Id: <20230606194254.5e26642b28dfbd0e198d24e8@linux-foundation.org>
In-Reply-To: <e099e2c1-322c-0a64-0f5b-5da621fedca1@redhat.com>
References: <20230519102723.185721-1-david@redhat.com>
        <20230519102723.185721-3-david@redhat.com>
        <ea3548ae-de27-fb67-5b2a-34aca006005c@nvidia.com>
        <e099e2c1-322c-0a64-0f5b-5da621fedca1@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 6 Jun 2023 09:10:22 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 06.06.23 08:23, John Hubbard wrote:
> > On 5/19/23 03:27, David Hildenbrand wrote:
> > ...
> >> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> >> index 23af4633f0f4..95acb099315e 100644
> >> --- a/tools/testing/selftests/mm/Makefile
> >> +++ b/tools/testing/selftests/mm/Makefile
> >> @@ -34,6 +34,7 @@ LDLIBS = -lrt -lpthread
> >>   
> >>   TEST_GEN_PROGS = cow
> >>   TEST_GEN_PROGS += compaction_test
> >> +TEST_GEN_PROGS += gup_longterm
> > 
> > Hi David,
> > 
> > Peter Xu just pointed out that we need a .gitignore entry for
> > gup_longterm [1]. That logically belongs in this patch, I think.
> 
> Yes, although I don't care if it's in a follow-up patch (we're talking 
> testcases after all).
> 
> @Andrew can you include that hunk in that patch or do you want a resend?

I added this:

From: Andrew Morton <akpm@linux-foundation.org>
Subject: selftests-mm-gup_longterm-new-functional-test-for-foll_longterm-fix
Date: Tue Jun  6 07:41:28 PM PDT 2023

update .gitignore for gup_longterm, per Peter

Cc: David Hildenbrand <david@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 tools/testing/selftests/mm/.gitignore |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/testing/selftests/mm/.gitignore~selftests-mm-gup_longterm-new-functional-test-for-foll_longterm-fix
+++ a/tools/testing/selftests/mm/.gitignore
@@ -39,3 +39,4 @@ local_config.h
 local_config.mk
 ksm_functional_tests
 mdwe_test
+gup_longterm
_

