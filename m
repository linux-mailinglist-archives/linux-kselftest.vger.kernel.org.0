Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417925B6B01
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Sep 2022 11:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiIMJon (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Sep 2022 05:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiIMJoh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Sep 2022 05:44:37 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651661158
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Sep 2022 02:44:32 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c198so11190730pfc.13
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Sep 2022 02:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ZmfmFbMYmaq0ZyQMdMN01+8jHfJN0luS93tqSO/DBY4=;
        b=kjd/plfmNvrnSBexSRLrDTrVGwbFvpmKW/pCZ9ip9X3RoMI0PIUIt+BX7cJtWwzy+T
         N6FzGmRSYRbga2Hfey2bwFqsTNtkZ3PtoRAzL2bq20SSTD099hzZZR2HKnkQsBLhs0Xr
         pGrlRrtmyHjhWXepdyNQlVL4TclSL5+7o2GRqb1mg8L5MJsCX5BMltQxX5lleEImYIJG
         jQwSkPAv/SNPTmNOeqDc8HSrQIrmjdhIBFOXM2UC3nT0BG/Yq8OC3tiPvYTDIPnEEAq/
         hZzpJnQ3ur8fgAox4BiTLBYLUW/hY8W89cnaJk+CshU7bSYsyWnaw+0JSUVdBrg1EVXA
         8W2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZmfmFbMYmaq0ZyQMdMN01+8jHfJN0luS93tqSO/DBY4=;
        b=Arxet/PBiRznxG0kXHhpHG1D8kdWiLkEZjC9pZ5ZOezoF9/pYRIi2bFHrvlICCb8Gt
         KoZRu8HA0eZiM2pvOv9IHMdWt9oNlmTDuOiNfAsuj82nnu8fWiaYI8apjbr7S0YviWMt
         dIGsCkk12+yIvSSwjAbatdQ6WzCc6Pi6Ru2o7HjA4kUzQxAiXfgJfnhdGVYGNccRib0c
         /GxZ0HaUdI44e/5qsTeYKuZa42wB5DFOcv+E6VVHjcStSMRQdTZ3YCggthpZBCDY1EEb
         8tCXCEfg9OkxTYlNRlBHoMiBzWKX9GtNh7t8EHLWFCHNd5IT9nHjqdhsn0QVMEJEQz4q
         bSyA==
X-Gm-Message-State: ACgBeo0xSQTQk3yCswzmbu23n9m9KO0+M9XFjABbDpKZMxXdqbCKOgRz
        bxSkrjuWHA3OHCrbqp13Vng3sg==
X-Google-Smtp-Source: AA6agR7eB/++IWh7o7ceymNTd594u7FaPNMIjNiPIe8nwYUseP7bj+TI+2SkDa9U94pgy3+68+fu7Q==
X-Received: by 2002:a05:6a00:1892:b0:540:acee:29e8 with SMTP id x18-20020a056a00189200b00540acee29e8mr24802369pfh.1.1663062271855;
        Tue, 13 Sep 2022 02:44:31 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id e14-20020a63db0e000000b0042c2def703asm7191167pgg.22.2022.09.13.02.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 02:44:31 -0700 (PDT)
Date:   Tue, 13 Sep 2022 09:44:27 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>,
        Elena Reshetova <elena.reshetova@intel.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <YyBQ+wzPtGwwRB/U@google.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <ff5c5b97-acdf-9745-ebe5-c6609dd6322e@google.com>
 <20220818132421.6xmjqduempmxnnu2@box>
 <c6ccbb96-5849-2e2f-3b49-4ea711af525d@google.com>
 <20220820002700.6yflrxklmpsavdzi@box.shutemov.name>
 <c194262b-b634-4baf-abf0-dc727e8f1d7@google.com>
 <20220831142439.65q2gi4g2d2z4ofh@box.shutemov.name>
 <20220908011037.ez2cdorthqxkerwk@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908011037.ez2cdorthqxkerwk@box.shutemov.name>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 08, 2022, Kirill A. Shutemov wrote:
> On Wed, Aug 31, 2022 at 05:24:39PM +0300, Kirill A . Shutemov wrote:
> > On Sat, Aug 20, 2022 at 10:15:32PM -0700, Hugh Dickins wrote:
> > > > I will try next week to rework it as shim to top of shmem. Does it work
> > > > for you?
> > > 
> > > Yes, please do, thanks.  It's a compromise between us: the initial TDX
> > > case has no justification to use shmem at all, but doing it that way
> > > will help you with some of the infrastructure, and will probably be
> > > easiest for KVM to extend to other more relaxed fd cases later.
> > 
> > Okay, below is my take on the shim approach.
> > 
> > I don't hate how it turned out. It is easier to understand without
> > callback exchange thing.
> > 
> > The only caveat is I had to introduce external lock to protect against
> > race between lookup and truncate.

As before, I think this lock is unnecessary.  Or at least it's unnessary to hold
the lock across get/put.  The ->invalidate() call will ensure that the pfn is
never actually used if get() races with truncation.

Switching topics, what actually prevents mmapp() on the shim?  I tried to follow,
but I don't know these areas well enough.
