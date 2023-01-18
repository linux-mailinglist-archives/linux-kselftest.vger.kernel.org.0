Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE0E6727C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 20:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjARTDZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Jan 2023 14:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjARTCv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Jan 2023 14:02:51 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE110460B8
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Jan 2023 11:02:27 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id a184so26972899pfa.9
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Jan 2023 11:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b825RCkPe9bzZBqdZrMTvxvQ+I94xpwDEKGzhZdcdLw=;
        b=DHoq6KQUy/Y0sTsoDrv/RkndfxpcNoZM72c1kPdUUXoNaiTHjlDer0KQ5pgAhDmEKM
         bmLI/oVl+xSlxuaMkMZgTX4P1JvL5YLnRKMp4UeYAt2txKGRwnYHCWV2x/QKoXjdSsV0
         96cpPSnA5GU1z6k822mA5PJfJNBBfpYV4KvZqhiRmKQ+qw1RZNsNiYoT93gxBzmpUwjC
         xegFPZKqsIpr7jRVifkkiG0SpDahnbK0GqjY7uejLfgubaFMvscCRh2yH8wpczpoLdsj
         5kwyQNBZyJ9JaaDc0IU0li2mYF+EGgIDGvzZZ6SLo99lB5oHm+la0qBCVelrW5rP66LE
         5ofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b825RCkPe9bzZBqdZrMTvxvQ+I94xpwDEKGzhZdcdLw=;
        b=1YphLNazhB6EdhA5TvYBJ/ZeGH7WpOaTTa9tEvhjHX1p/OlnCCnf1vCCM8J7sOOKFm
         qv7NSbB+DVFAJoAnCe5hlbUIkceauTxBHoGWY8pOH7fItnenRdaT4EhSpo7HXzEHmfZ6
         +URJ9Lxf7/0yXqXXWGawd4NmLzMV3RN6b8ykoUCFLsvJ31v8ddZzBRWigOoaGGOQpPYt
         te1YXFBYuR9y42MgPi7y1vBDfQy+wOXVTIUFLm7cJiLmChk4b4pPN7Wv7WPaTo+ac4lx
         sAaUVM6RA+IfJKxQqC2SGF2M4UncYK1Y51Zy7SvCAoESyD6v28jSv3Tgt16+swPhSYqu
         A5hQ==
X-Gm-Message-State: AFqh2kpxkAwhLLUivb2ixIMCAoOuCu3BgP6Pk3a2pnj35osZbqJIoEGL
        V9IlK/dH8MKxOKZP8OAGgR5HIQ==
X-Google-Smtp-Source: AMrXdXuOCbaxVxjkbNCzZhNegUERim5sEF1cAOq/Nil8D+OmDDSIqAG5+czr7cNvCt+Mv4V98Wx8Ag==
X-Received: by 2002:aa7:9041:0:b0:58b:cb1b:978f with SMTP id n1-20020aa79041000000b0058bcb1b978fmr1517329pfo.1.1674068547178;
        Wed, 18 Jan 2023 11:02:27 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id p189-20020a625bc6000000b00580cc63dce8sm20286991pfb.77.2023.01.18.11.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 11:02:26 -0800 (PST)
Date:   Wed, 18 Jan 2023 19:02:22 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        David Matlack <dmatlack@google.com>,
        Wei Wang <wei.w.wang@intel.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: selftests: Fix initialization of GDT limit
Message-ID: <Y8hCPishKunO64HT@google.com>
References: <20230114161557.499685-1-ackerleytng@google.com>
 <20230114161557.499685-2-ackerleytng@google.com>
 <Y8g0Zv0IjLEBw5qO@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8g0Zv0IjLEBw5qO@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 18, 2023, Sean Christopherson wrote:
> On Sat, Jan 14, 2023, Ackerley Tng wrote:
> > Subtract 1 to initialize GDT limit according to spec.
> 
> Nit, make changelogs standalone, i.e. don't make me read the code just to
> understand the changelog.  "Subtract 1" is meaningless without seeing the
> existing code.  The changelog doesn't need to be a play-by-play, e.g. describing
> the change as "inclusive vs. exclusive" is also fine, the important thing is that
> readers can gain a basic understanding of the change without needing to read code.
> 
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > ---
> >  tools/testing/selftests/kvm/lib/x86_64/processor.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > index acfa1d01e7df..33ca7f5232a4 100644
> > --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > @@ -502,7 +502,12 @@ static void kvm_setup_gdt(struct kvm_vm *vm, struct kvm_dtable *dt)
> >  		vm->gdt = __vm_vaddr_alloc_page(vm, MEM_REGION_DATA);
> >  
> >  	dt->base = vm->gdt;
> > -	dt->limit = getpagesize();
> > +
> > +	/*
> > +	 * Intel SDM Volume 3, 3.5.1:
> 
> As a general rule, especially in code comments, never reference manual sections
> by their index/numbers, there's a 99% chance the comment will be stale within a
> few years.
> 
> Quoting manuals is ok, because if the quote because stale then that in and of
> itself is an interesting datapoint.  If referencing a specific section is the
> easiest way to convey something, then use then name of the section, as that's less
> likely to be arbitrarily change.
> 
> In this case, I'd just omit the comment entirely.  We have to assume readers have
> a minimum level of knowledge, and IMO this is firmly below (above?) the threshold.

No need to post a v2, I'll fold this patch into a larger cleanup of the descriptor
table code.

Thanks!
