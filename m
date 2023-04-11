Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8766DE757
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 00:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjDKWf1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 18:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDKWf0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 18:35:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27DBE66;
        Tue, 11 Apr 2023 15:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mOKj0sEUbMW81iFF7BRNN9qJS2IsOHAMM37QMSPbQxY=; b=trljD5An7/m416tJi0yAZXbq8z
        zjJMpYJVtqv4fZBIASEZly7rmCqIDeC6XfO6JHesXL53KE9rpV7wcq5/J8T8gRpgbiC0z0XKYPtA6
        X5GJTKvRT0y8MMyeBIIVwg2791RwuLvPIwn2+eG0Zjqa0B+814VQ/ZpgwH1Zl3yKke2yW6KZz8W47
        QwB63ZwCIo+D1+bnNnJ5xif2IB0Id9EyDZwV+2/0uGoKtxbESj+jIv3xdGeXTRj4LS9UEl37Q131L
        KevgMrv+RAKWlpvZb9rU0hO1VSqT2bLfrACJRVKNZcyKqYxoJt4XFzstQ2/ZEZT3AQDiwF4MseLiw
        09sL4pSA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pmMZv-006JZh-QU; Tue, 11 Apr 2023 22:35:07 +0000
Date:   Tue, 11 Apr 2023 23:35:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v5 1/3] mm: add new api to enable ksm per process
Message-ID: <ZDXgmx0xD8ch/Iu5@casper.infradead.org>
References: <20230406165339.1017597-1-shr@devkernel.io>
 <20230406165339.1017597-2-shr@devkernel.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406165339.1017597-2-shr@devkernel.io>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 06, 2023 at 09:53:37AM -0700, Stefan Roesch wrote:
> +	case PR_SET_MEMORY_MERGE:
> +		if (mmap_write_lock_killable(me->mm))
> +			return -EINTR;
> +
> +		if (arg2) {
> +			int err = ksm_add_mm(me->mm);
> +			if (err)
> +				return err;

You'll return to userspace with the mutex held, no?
