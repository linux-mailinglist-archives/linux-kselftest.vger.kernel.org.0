Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D66720B09
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 23:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbjFBVhE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 17:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236351AbjFBVhD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 17:37:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A5B1B5
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 14:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685741774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TsdZlWSOiNT7hzk1rZDtrEHgINd/xV3z9w3UHd3nqCo=;
        b=Ooailrviy5FmEEKL5c5HdLjVw5J2VKEroD+BzfFZizC59BcysmBsUKthwBKJFb0zKJe65C
        MW/HPMLrzAR1vxifZMwcKbHShXCCe7uXUMpvrMWN+sb28z4GcylZUKCgqrjTY6Lgs8EUdh
        EyLGH4JHYX64vXWu6nAMQJnpw3QtAB4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-aKUrFp2EO4mIE-1Thmj6Eg-1; Fri, 02 Jun 2023 17:36:12 -0400
X-MC-Unique: aKUrFp2EO4mIE-1Thmj6Eg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75b175cf0d1so34377285a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 14:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685741772; x=1688333772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsdZlWSOiNT7hzk1rZDtrEHgINd/xV3z9w3UHd3nqCo=;
        b=N+95GQLjamxCgN+LoGbWypJQBHVQYztgs1AmBwzi5IMHmzcOaBSyD7TcFkPSOfWwPp
         7o4G7IQ2s55e9njku7qNKOJbvdARIvNoBElp8fwlyOB9BfGM2Qf96o07SqSHp/bmhAl3
         uAOqRVf6EIRk5IHbr5DaVf3M3KbhjeNcLGaItkM1LKcb1FKaqee+cJWYnqJuD9mAVyt6
         LfwkGuvAtKyDWW3dDTD1lRlJBdEt9rVkPVaoLegldbpWkQeW9ofROTbM35OU+RbmPu/i
         dzu+Z5iiEst6x9W1QCvv8Nv9lUZz+4HLmjGVoe3NlQh5KlHm0ke4vrc2VW9/nzl6YncV
         dI1A==
X-Gm-Message-State: AC+VfDzlHYhPWffhei/1owzmoh4KRu4D2JjfwqTFHjH4BgAiLAqZlugY
        OPzlnRjBdV1UJAQUdPNxSgMFXGLBMlFiPZO8bPN7HIZ20h4ySus8AjVDJPukxoJU5ktxBt9zHcS
        UbAlYB8q48okEsGEXAIl+uCztyF4m
X-Received: by 2002:a05:620a:6608:b0:75b:23a1:69ea with SMTP id qf8-20020a05620a660800b0075b23a169eamr10523160qkn.1.1685741772205;
        Fri, 02 Jun 2023 14:36:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7zN+kXEKS4paUPxaQFfuiTCq13N3O0euEhKoxhaiVsD6Up1SmP5ztugO0BvxX9GHKnG2QRmA==
X-Received: by 2002:a05:620a:6608:b0:75b:23a1:69ea with SMTP id qf8-20020a05620a660800b0075b23a169eamr10523143qkn.1.1685741771939;
        Fri, 02 Jun 2023 14:36:11 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id c1-20020ae9e201000000b0075cd3d61715sm1079251qkc.47.2023.06.02.14.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 14:36:11 -0700 (PDT)
Date:   Fri, 2 Jun 2023 17:36:09 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/12] selftests/mm: fix invocation of tests that are run
 via shell scripts
Message-ID: <ZHpgybHDDAMFsADT@x1n>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-6-jhubbard@nvidia.com>
 <ZHoL8vJPIUzP2RKN@x1n>
 <e31f1411-1986-c25d-af74-05ad73a53c8d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e31f1411-1986-c25d-af74-05ad73a53c8d@nvidia.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 02, 2023 at 12:19:17PM -0700, John Hubbard wrote:
> On 6/2/23 08:34, Peter Xu wrote:
> > On Thu, Jun 01, 2023 at 06:33:51PM -0700, John Hubbard wrote:
> > > We cannot depend upon git to reliably retain the executable bit on shell
> > > scripts, or so I was told several years ago while working on this same
> > > run_vmtests.sh script. And sure enough, things such as test_hmm.sh are
> > > lately failing to run, due to lacking execute permissions.
> > > 
> > > A nice clean way to fix this would have been to use TEST_PROGS instead
> > > of TEST_FILES for the .sh scripts here. That tells the selftest
> > > framework to run these (and emit a warning if the files are not
> > > executable, but still run them anyway).
> > > 
> > > Unfortunately, run_vmtests.sh has its own run_test() routine, which does
> > > *not* do the right thing for shell scripts.
> > > 
> > > Fix this by explicitly adding "bash" to each of the shell script
> > > invocations. Leave fixing the overall approach to another day.
> > 
> > Is it possible someone just doesn't have "bash" at all?  I used to only use
> 
> Well, maybe [1]. But that someone won't be running these tests as-is, because
> the tests explicitly require bash, even before this patch.
> 
> > "sh" without bash installed I think, but that was not on Linux, so I'm not
> > sure how much that applies..
> 
> sh invocations are for when you want to express that this script should
> avoid using bash-specific things, in order to ensure portability to
> other environments.
> 
> But here, the run_vmtests.sh file requires bash already, as per the
> first line:
> 
>     #!/bin/bash
> 
> ...which is ultimately why I decided to use bash, rather than sh here.

That one can be easily override with $XXX run_vmtests.sh, hard-coded "bash"
in Makefiles can't, afaiu.

> 
> > 
> > Maybe use $(SHELL)?  I saw a bunch of usage in the tree too.
> > 
> 
> That's more of a Makefile construct that you are seeing, and only in a
> few odd Makefiles. Recall that in Make, $(SHELL) has the same effect
> that ${SHELL} has in bash/sh, by the way: dereferencing a variable.
> 
> And Make's "$(shell ...)" command is what is normally used to *run* a
> shell command, in the kernel's build system.
> 
> Having said all that, I will take a quick look at what it would take
> to shift over to the selftest framework's run_test() instead, in
> order to avoid this ugly "fix".

Just to mention that I was not talking about $(shell ...), but the
environment var $(SHELL), or "env | grep SHELL".

Please feel free to have a look at tools/perf/arch/x86/Makefile.

Thanks,

-- 
Peter Xu

