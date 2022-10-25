Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1CA60C7A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 11:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiJYJNv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 05:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiJYJNi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 05:13:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B84A17650D;
        Tue, 25 Oct 2022 02:07:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DC3A11FDAB;
        Tue, 25 Oct 2022 09:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666688823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YetzJ42X/TiFjkjg0wNAE3EFsDAzc7c8MsipxnbCcxE=;
        b=IkqV6NNEd0j9tEUH8n8P5TVYq8QJcf2qkkSZvtymyDkC0UHOtNJyMFPc1+Nz7jmv3G2JWK
        3Y4SbGFuVysX2qUopbLtx8JqMj7S4N8Kred7MqPi7Lalf47QOfVbpe9q7yuK97Ts76YBD3
        0LthdTBMm+u1MkbQEQE/azZglriD4Yk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666688823;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YetzJ42X/TiFjkjg0wNAE3EFsDAzc7c8MsipxnbCcxE=;
        b=bjHzj+RmUQN889rrCKhbHre+JjtU2MXgeAiJQesFc1MOfiqGUlqdHWmNFq1GxdPrI/zTV5
        kzxoeEfEn3/pvFCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4EBD134CA;
        Tue, 25 Oct 2022 09:07:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BGB8JzenV2NbNQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 25 Oct 2022 09:07:03 +0000
Message-ID: <9cfaed63-b72f-3fc8-bdc0-c6d7b09ca782@suse.cz>
Date:   Tue, 25 Oct 2022 11:07:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 3/3] mm: slub: test: Use the kunit_get_current_test()
 function
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        Oliver Glitta <glittao@gmail.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20221025071907.1251820-1-davidgow@google.com>
 <20221025071907.1251820-3-davidgow@google.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221025071907.1251820-3-davidgow@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/25/22 09:19, David Gow wrote:
> Use the newly-added function kunit_get_current_test() instead of
> accessing current->kunit_test directly. This function uses a static key
> to return more quickly when KUnit is enabled, but no tests are actively
> running. There should therefore be a negligible performance impact to
> enabling the slub KUnit tests.
> 
> Other than the performance improvement, this should be a no-op.
> 
> Cc: Oliver Glitta <glittao@gmail.com>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> 
> This is intended as an example use of the new function. Other users
> (such as KASAN) will be updated separately, as there would otherwise be
> conflicts.
> 
> Assuming there are no objections, we'll take this whole series via the
> kselftest/kunit tree.

OK, please do.

Some possible improvements below:

> There was no v1 of this patch. v1 of the series can be found here:
> https://lore.kernel.org/linux-kselftest/20221021072854.333010-1-davidgow@google.com/T/#u
> 
> ---
>  lib/slub_kunit.c | 1 +
>  mm/slub.c        | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
> index 7a0564d7cb7a..8fd19c8301ad 100644
> --- a/lib/slub_kunit.c
> +++ b/lib/slub_kunit.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <kunit/test.h>
> +#include <kunit/test-bug.h>
>  #include <linux/mm.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> diff --git a/mm/slub.c b/mm/slub.c
> index 157527d7101b..15d10d250ef2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -39,6 +39,7 @@
>  #include <linux/memcontrol.h>
>  #include <linux/random.h>
>  #include <kunit/test.h>
> +#include <kunit/test-bug.h>
>  #include <linux/sort.h>
>  
>  #include <linux/debugfs.h>
> @@ -603,10 +604,10 @@ static bool slab_add_kunit_errors(void)
>  {
>  	struct kunit_resource *resource;
>  
> -	if (likely(!current->kunit_test))
> +	if (likely(!kunit_get_current_test()))

Given that kunit_get_current_test() is basically an inline
!static_branch_unlikely(), IMHO the likely() here doesn't add anything and
could be removed?

>  		return false;
>  
> -	resource = kunit_find_named_resource(current->kunit_test, "slab_errors");
> +	resource = kunit_find_named_resource(kunit_get_current_test(), "slab_errors");

We just passed kunit_get_current_test() above so maybe we could just keep
using current->kunit_test here? Seems unnecessary adding another jump label.

>  	if (!resource)
>  		return false;
>  

