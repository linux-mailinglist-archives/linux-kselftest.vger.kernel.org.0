Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E82C6DA620
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Apr 2023 01:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjDFXaE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 19:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjDFXaD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 19:30:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A019EC5;
        Thu,  6 Apr 2023 16:29:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FFF26498D;
        Thu,  6 Apr 2023 23:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C76C433D2;
        Thu,  6 Apr 2023 23:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680823798;
        bh=qDIlNriYIeS492HkC/yOLQLD8cyeiSLOgIcNJoMa84k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UFwip8/hNEYfi28GVP5NGN6Q4UQK1bbuIXgHii34OS4tBhjOISMQG42LkdSssjw4j
         jv58Vi79dzbgX0Fd5QxH5lXD6O2iX6aMpgOX9tPxsxSnGL/yLT74sl4InM5nXKD8xf
         fRYWzvlLHAGI1zNjF1tVVBxDAcDqVfRYihUJeANA=
Date:   Thu, 6 Apr 2023 16:29:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, hannes@cmpxchg.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v5 1/3] mm: add new api to enable ksm per process
Message-Id: <20230406162957.57fa69a46691a97d4600f444@linux-foundation.org>
In-Reply-To: <20230406165339.1017597-2-shr@devkernel.io>
References: <20230406165339.1017597-1-shr@devkernel.io>
        <20230406165339.1017597-2-shr@devkernel.io>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu,  6 Apr 2023 09:53:37 -0700 Stefan Roesch <shr@devkernel.io> wrote:

> So far KSM can only be enabled by calling madvise for memory regions.  To
> be able to use KSM for more workloads, KSM needs to have the ability to be
> enabled / disabled at the process / cgroup level.
> 
> ...
>
> @@ -53,6 +62,18 @@ void folio_migrate_ksm(struct folio *newfolio, struct folio *folio);
>  
>  #else  /* !CONFIG_KSM */
>  
> +static inline int ksm_add_mm(struct mm_struct *mm)
> +{
> +}

The compiler doesn't like the lack of a return value.

I queued up a patch to simply delete the above function - seems that
ksm_add_mm() has no callers if CONFIG_KSM=n.

The same might be true of the ksm_add_vma()...ksm_exit() stubs also,
Perhaps some kind soul could take a look at whether we can simply clean
those out.

