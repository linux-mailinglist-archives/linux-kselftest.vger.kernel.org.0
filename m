Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A8658E15F
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Aug 2022 22:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiHIUyJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Aug 2022 16:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiHIUxm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Aug 2022 16:53:42 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EBD15FDB
        for <linux-kselftest@vger.kernel.org>; Tue,  9 Aug 2022 13:53:41 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id x10so12442237plb.3
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Aug 2022 13:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=pJblVN/EwDKnGoYTvY52rorYjnKswwmvjLRNuq3g3VE=;
        b=GbUPKddyRcffK7GnxZeqqcUioCOBYjZYcND1JWvpTTanaun1D9fGTvEAbdn125PW6m
         JLjs5YyKKh7edLtHVT0tHekB/pNop76ht7souklms4QnoaKiHs8glUoRTRM+Mfo8T9Wd
         Q8JXLAja5U0d1nkYehhAvAfuKo06DjcO+uoxCK8jXyV1FA9g3aXQEBfaTLKZJ6FVL/Mt
         NMgBfRYESMHWHpBAQGqe86ARj9HVA94d7TsUE/YkyfA1kBd8DX8QSHykjK5j4xexTJPv
         k3mNOu14Dx9T3iSZbwK0WM2QonrbFR+wdYL0qCqooRcYs3zUHOlu/GhNspIACNbPZ6x3
         ZDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=pJblVN/EwDKnGoYTvY52rorYjnKswwmvjLRNuq3g3VE=;
        b=S0MpgB9h0JWTrn/NfVWet8L6Ke8bWTKyhmInCLCQP68YZrRIUU7VIVg94v+cDJm+Hh
         WjuQ92MDjOOo57NHUMnOY3OoJ2N/iMhY/IqSjps69bLR4HjTLkQoPy3+XgiouNOFOF3k
         xO74U8Ej7NJ+twS2Au9B1cBf5oSUcmVjjvk7XqBb9yq4ljhaPzyqfr8fv1+MslFFMS2d
         I1eKltGsh2a3Ov5TJN1ICwgIjHYGC6gNv1N/pO38/bOmI9V5PsVDjgYR2SEhsm91O0Tm
         7tJheMmhNgr5HpwEsh/eDGezyiICiXJC02Po7NWd1FAxjFxFesxy5+5W1mVj3JrxHgfT
         3Ulg==
X-Gm-Message-State: ACgBeo3xJ3pyBGZeUxNGnnPzOFCZ44aEJnmKzP1JviZCy4UXDd9nc5AQ
        pT9Mnog+KQr/tBTBntbO3U/5MQ==
X-Google-Smtp-Source: AA6agR5zPiBVnYt1kAUuxrAkMt0LXjWgm1wd+WLRJjf0RsoJ/oyZpNSqLwA3FNlryMJpO0oPIuNAIg==
X-Received: by 2002:a17:902:eb8a:b0:16d:c75a:c40b with SMTP id q10-20020a170902eb8a00b0016dc75ac40bmr25435222plg.102.1660078420716;
        Tue, 09 Aug 2022 13:53:40 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e5c800b00170a359eb0esm5711482plf.63.2022.08.09.13.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 13:53:40 -0700 (PDT)
Date:   Tue, 9 Aug 2022 20:53:36 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     Florian Weimer <fweimer@redhat.com>, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com, maz@kernel.org,
        oliver.upton@linux.dev, andrew.jones@linux.dev,
        mathieu.desnoyers@efficios.com, yihyu@redhat.com,
        shan.gavin@gmail.com
Subject: Re: [PATCH 2/2] KVM: selftests: Use getcpu() instead of
 sched_getcpu() in rseq_test
Message-ID: <YvLJUEOcxaZKW0y1@google.com>
References: <20220809060627.115847-1-gshan@redhat.com>
 <20220809060627.115847-3-gshan@redhat.com>
 <87y1vxncv1.fsf@oldenburg.str.redhat.com>
 <87mtcdnaxe.fsf@oldenburg.str.redhat.com>
 <ea2ef1a2-0fd8-448b-d7ca-254603518823@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea2ef1a2-0fd8-448b-d7ca-254603518823@redhat.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 09, 2022, Gavin Shan wrote:
> On 8/9/22 5:17 PM, Florian Weimer wrote:
> > * Florian Weimer:
> > 
> > > * Gavin Shan:
> > > 
> > > > sched_getcpu() is glibc dependent and it can simply return the CPU
> > > > ID from the registered rseq information, as Florian Weimer pointed.
> > > > In this case, it's pointless to compare the return value from
> > > > sched_getcpu() and that fetched from the registered rseq information.
> > > > 
> > > > Fix the issue by replacing sched_getcpu() with getcpu(), as Florian
> > > > suggested. The comments are modified accordingly.
> > > 
> > > Note that getcpu was added in glibc 2.29, so perhaps you need to perform
> > > a direct system call?
> > 
> > One more thing: syscall(__NR_getcpu) also has the advantage that it
> > wouldn't have to be changed again if node IDs become available via rseq
> > and getcpu is implemented using that.
> > 
> > Thanks,
> > Florian
> > 
> 
> Thanks, Florian. It makes sense to me to use syscall(__NR_getcpu) in
> next revision. Thanks for your quick review :)

+1, and definitely add a comment to prevent future "cleanup".
