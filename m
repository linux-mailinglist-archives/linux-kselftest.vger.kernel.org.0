Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9431C4D31F2
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 16:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbiCIPl5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 10:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbiCIPl5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 10:41:57 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A567517C40E
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Mar 2022 07:40:58 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d187so2619449pfa.10
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Mar 2022 07:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=awNm7ncYJS5runeS2crmI62S72vDnlHWFXIoD08zsCQ=;
        b=L95s3l8KwvKSoVBp7CenGSpuMYCVVN7GYKixyJEeDlmj6to8MhL0pIcnvDahgNOvxi
         JfjZ0TGsVg8yLTggwW59sBAVvTyJ2+ahvDMzZ1X/cpIaGcZw/Yfu+FTW13ogQdC5gcUx
         WduOO+A0oDbV8KctSwlgphgr4QbcVJIbd4eTAk9QTeMSmzdnIvnMpo4DZt6s3GqCCXWQ
         I9FjVUcItyTicv7V147R87ZLFIeV9kXVghbdYNWZYNmZvi5YRVLgDg/4HmWm3BJp0jeP
         tBfOIvJm8gJ5J9VEv9NMcb8m5DNZx/lSzmLslFTLe9wlqmNqqJUqnt1TS7+FBUg/Et+J
         4D3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=awNm7ncYJS5runeS2crmI62S72vDnlHWFXIoD08zsCQ=;
        b=cynroXJgBT2sHVWQ5yoBeDqa40sG5hDR3gB60MKTfpk49XfsOxEF0hBv1IOosM1/2W
         oz8Vn7Kfh8BSa5jVSKR+vuoWEe65X4cnrEcym6bxhaRe82xPzNzxNyxYV/bIG6ApVHj1
         BmaBBehJPuRiJ09lFip3CpPQWVVtNQuY7i9p0IJoYGfFvof5uTaxVeJsLTYC3ccU/cuq
         QxQfhBt9vjp4H+I0inCiHwranhuhvPkjlGeJ/MSJP4qehivjI7tJXNnbnJ742E+zLKZ+
         2lusp4sHCYRy9uVGyLACdRoNeGSSAHbpBPI+2WbV++TjFnbNBUsRJO14j6YYLZ0+AWBW
         ZXdA==
X-Gm-Message-State: AOAM5307mrEvYsGpKwHyagy+SsmxksKh6n9/4gVBJPV4DZ0X+0hiAd9C
        TXGjmWkssqFQffNnf9yNR8AWlw==
X-Google-Smtp-Source: ABdhPJy0fy+gKxWpiweokALKmNhNvXvpZLPvXf3Aa/Du9Pmy7tGAgvR6HKEPghwWq0MWpSuGrYsfnQ==
X-Received: by 2002:a05:6a00:ac1:b0:4f1:29e4:b3a1 with SMTP id c1-20020a056a000ac100b004f129e4b3a1mr295081pfl.63.1646840457963;
        Wed, 09 Mar 2022 07:40:57 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id o1-20020a637e41000000b003804d0e2c9esm2819543pgn.35.2022.03.09.07.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 07:40:57 -0800 (PST)
Date:   Wed, 9 Mar 2022 15:40:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Jones <drjones@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Yang Weijiang <weijiang.yang@intel.com>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v3 2/6] KVM: x86: add force_intercept_exceptions_mask
Message-ID: <YijKhYNjZpG7EX9y@google.com>
References: <20210811122927.900604-1-mlevitsk@redhat.com>
 <20210811122927.900604-3-mlevitsk@redhat.com>
 <YTECUaPa9kySQxRX@google.com>
 <0cdac80177eea408b7e316bd1fc4c0c5839ba1d4.camel@redhat.com>
 <YifoysEvfnQgq59A@google.com>
 <3221c2385e1148fe0ee77d4717b52726e1db9d8d.camel@redhat.com>
 <a7b27887-ce00-c173-a7e7-8ad3470154f5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7b27887-ce00-c173-a7e7-8ad3470154f5@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 09, 2022, Paolo Bonzini wrote:
> On 3/9/22 13:31, Maxim Levitsky wrote:
> > Question: is it worth it? Since I am very busy with various things, this
> > feature, beeing just small debug help which I used once in a while doesn't
> > get much time from me.
> 
> I agree it's not very much worth.

I don't have a use case, was just trying to find the bottom of my inbox and came
across this thread.
