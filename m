Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712116DFB5F
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 18:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjDLQaB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 12:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjDLQaA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 12:30:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F96661B4;
        Wed, 12 Apr 2023 09:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DMugHngF26X9J73pdOFhX5/uRQoQERWtuaCobuWkV3A=; b=qfbn5Y6zf2s0LCgXwzQnajfSAr
        Fnl+FDI9vl3UiVdR3QZ6wkIZzEvPb4drappMvcRaU/nXjAbXWqWvPv+Wf3DBeDUFjXi6Y+93ah0vb
        UWkf6OCrB6qWF0mZdNsyeRDyTM5KF5mv7m9Vlf3HhszriHCSgCC3/n5kF4IkI1USHiIk5WGJHKQxa
        3BToevWoMZfqZx3rAx8M5M/1LqoXbLZmXfjzddyittAELBTH032QT/9KIqjVRjTIha0NqjF44IOj4
        f+PnW226rfdWId12RnNp7pTgmo1q0TNnDiV4fN+SIdZThcagkWn4wxAikKExFMIhzRb5m7unNJ/zn
        BxRdX5gQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pmdLm-0071m1-GL; Wed, 12 Apr 2023 16:29:38 +0000
Date:   Wed, 12 Apr 2023 17:29:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v6 1/3] mm: add new api to enable ksm per process
Message-ID: <ZDbccpmPVU5RRPws@casper.infradead.org>
References: <20230412031648.2206875-1-shr@devkernel.io>
 <20230412031648.2206875-2-shr@devkernel.io>
 <ZDawF5FDjgYuEHSX@casper.infradead.org>
 <qvqwfs9513mn.fsf@devbig1114.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qvqwfs9513mn.fsf@devbig1114.prn1.facebook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 12, 2023 at 09:08:11AM -0700, Stefan Roesch wrote:
> 
> Matthew Wilcox <willy@infradead.org> writes:
> 
> > On Tue, Apr 11, 2023 at 08:16:46PM -0700, Stefan Roesch wrote:
> >>  	case PR_SET_VMA:
> >>  		error = prctl_set_vma(arg2, arg3, arg4, arg5);
> >>  		break;
> >> +#ifdef CONFIG_KSM
> >> +	case PR_SET_MEMORY_MERGE:
> >> +		if (mmap_write_lock_killable(me->mm))
> >> +			return -EINTR;
> >> +
> >> +		if (arg2) {
> >> +			int err = ksm_add_mm(me->mm);
> >> +
> >> +			if (!err)
> >> +				ksm_add_vmas(me->mm);
> >
> > in the last version of this patch, you reported the error.  Now you
> > swallow the error.  I have no idea which is correct, but you've
> > changed the behaviour without explaining it, so I assume it's wrong.
> >
> 
> I don't see how the error is swallowed in the arg2 case. If there is
> an error ksm_add_vmas is not executedd and at the end of the function
> the error is returned. Am I missing something?

You said 'int err' which declares a new variable.  If you want it
reported, just use 'error = ksm_add_mm(me->mm);'.
