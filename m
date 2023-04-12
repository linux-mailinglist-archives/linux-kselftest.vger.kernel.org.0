Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659B36DF6DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 15:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjDLNU4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 09:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjDLNUz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 09:20:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABCE49C6;
        Wed, 12 Apr 2023 06:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bZzC89xBqHZIexKBrKT7HoQWF++KmQXNtlFaFL5/dGo=; b=Bhkm3OkIjTuzwz0FHS4ccrZ729
        X+9ouvRCNj4+hh725FT0ZbIz83h7MSRBsjviLga0fOC3Gi+/58AqWhmWZ4HLkPfZ+zAgEZ30Lt4bQ
        5V+tN6aiK87yw+UP4uKd/Xq8wkzGRB0jIPqd5tGcDb4yab66OsS8DDx7Czir6FBfOOWk8S06ajcM5
        h/z9LKAO8jjk/51kYdA/se3GfD7Yk/PjRWg6haY9qLY18En+I4/m8ayilmZiDJYoX1ByFTi0Xn8RY
        3yDCAtGg2tzKYmCqiX1lNjTfRKtVviFDpUIKFzx6bS+z6KQUiKzDlq/2qX5BqM66NQfurHTi82G3h
        +jF0Jqiw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pmaOd-006tdK-Rk; Wed, 12 Apr 2023 13:20:23 +0000
Date:   Wed, 12 Apr 2023 14:20:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v6 1/3] mm: add new api to enable ksm per process
Message-ID: <ZDawF5FDjgYuEHSX@casper.infradead.org>
References: <20230412031648.2206875-1-shr@devkernel.io>
 <20230412031648.2206875-2-shr@devkernel.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412031648.2206875-2-shr@devkernel.io>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 11, 2023 at 08:16:46PM -0700, Stefan Roesch wrote:
>  	case PR_SET_VMA:
>  		error = prctl_set_vma(arg2, arg3, arg4, arg5);
>  		break;
> +#ifdef CONFIG_KSM
> +	case PR_SET_MEMORY_MERGE:
> +		if (mmap_write_lock_killable(me->mm))
> +			return -EINTR;
> +
> +		if (arg2) {
> +			int err = ksm_add_mm(me->mm);
> +
> +			if (!err)
> +				ksm_add_vmas(me->mm);

in the last version of this patch, you reported the error.  Now you
swallow the error.  I have no idea which is correct, but you've
changed the behaviour without explaining it, so I assume it's wrong.

> +		} else {
> +			clear_bit(MMF_VM_MERGE_ANY, &me->mm->flags);
> +		}
> +		mmap_write_unlock(me->mm);
> +		break;
> +	case PR_GET_MEMORY_MERGE:
> +		if (arg2 || arg3 || arg4 || arg5)
> +			return -EINVAL;
> +
> +		error = !!test_bit(MMF_VM_MERGE_ANY, &me->mm->flags);
> +		break;

Why do we need a GET?  Just for symmetry, or is there an actual need for
it?

