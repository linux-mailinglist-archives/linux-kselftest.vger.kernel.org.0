Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED72368C706
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 20:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjBFTta (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 14:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjBFTta (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 14:49:30 -0500
X-Greylist: delayed 9610 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Feb 2023 11:49:28 PST
Received: from out-95.mta0.migadu.com (out-95.mta0.migadu.com [IPv6:2001:41d0:1004:224b::5f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4A424119
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Feb 2023 11:49:28 -0800 (PST)
Date:   Mon, 6 Feb 2023 19:49:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675712965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eE5y7KFp1wd1MeVmYVGZn0fpjFrmo4GGrmTq6cDBY5c=;
        b=vKcW3ipuJCGN+k+eCjH0TntuFx6caxzWhEiSfSpZXXLGTvchIZpN7/REJp+2QmHkW6djhs
        oJv4nlwVpdaL6mlTmn4TJHA+IxFygHc1muN+oCrG5yERThMZOuRztClFBU+h7t2fwguyfI
        0tAxULUD9yv8rC8Xnewf9lqgPaWV/O0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org
Subject: Re: [PATCH] KVM: selftests: Enable USERFAULTFD
Message-ID: <Y+FZvpxO62F9d2Ui@linux.dev>
References: <20230202-kvm-selftest-userfaultfd-v1-1-8186ac5a33a5@kernel.org>
 <Y+E0MuGJ+hE3zslT@google.com>
 <Y+FDtDWnG2k0wqlv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+FDtDWnG2k0wqlv@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 06, 2023 at 06:15:16PM +0000, Sean Christopherson wrote:
> On Mon, Feb 06, 2023, Oliver Upton wrote:
> > +cc x86, riscv as they're also affected.
> > 
> > On Thu, Feb 02, 2023 at 09:01:36PM +0000, Mark Brown wrote:
> > > The page_fault_test KVM selftest requires userfaultfd but the config
> > > fragment for the KVM selftests does not enable it, meaning that those tests
> > > are skipped in CI systems that rely on appropriate settings in the config
> > > fragments except on S/390 which happens to have it in defconfig. Enable
> > > the option in the config fragment so that the tests get run.
> 
> What do CI systems do for HugeTLB and THP?  Those are the other config options I
> can think of where there are very interesting interactions from a KVM perspective,
> but where KVM doesn't have a strict dependency on the feature.
> 
> E.g. x86_64_defconfig selects CONFIG_HUGETLBFS=y, but I don't see anything for THP,
> and AFAICT TRANSPARENT_HUGEPAGE is default=n.

Looks like arm64 defconfig enables THP and hugetlb. Regardless, I think
it would be valuable if our Kconfig fragment expressed the options that
buy us additional code coverage.

--
Thanks,
Oliver
