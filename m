Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4667753F6C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 18:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235790AbjGNQBE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 12:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbjGNQBD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 12:01:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E59030FC;
        Fri, 14 Jul 2023 09:01:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D77E61D58;
        Fri, 14 Jul 2023 16:01:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63688C433C7;
        Fri, 14 Jul 2023 16:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689350461;
        bh=aRHYXj3X2shgH15QT0p9t23uRiYiRIc7KmCsMYGAEGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TXHl+Xp4W8AcHGZHGKOkP00IjSdJkX4IkTO2omMpxJCAqnNu0P3ExDamYeIO5nZBO
         m5zLHe5JueFzfxK4OFsuC+dUczkpmm4c2t47YXj6vXBVAoa/xDRFWAW38umEBLk2TI
         az5sIfB6B7x27J3Z2J1TaY0akthFKMbfm5D4YTs7jvviINgZ/2chTkemWyYW0ROLQZ
         kBquWi0xvzeJ1uDqrsoRTUQOsWsZ3Rc+WP7uM1GwhMu0EEHbcEFV40JPEOuuK3dcSJ
         n4GzmsAptNUJ9z2MZSv3w+6hy0VIRpe7Cuk+lNRQPgXNR6IFLINFBoT1Dtgp3llLtS
         gKkiT5BWtScmQ==
From:   SeongJae Park <sj@kernel.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Shuah Khan" <shuah@kernel.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Mark Brown" <broonie@kernel.org>,
        "John Hubbard" <jhubbard@nvidia.com>,
        "Florent Revest" <revest@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 2/9] selftests/mm: Give scripts execute permission
Date:   Fri, 14 Jul 2023 16:00:58 +0000
Message-Id: <20230714160058.45215-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <7935c31a-6c47-95c8-d6bd-176b81046699@arm.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 14 Jul 2023 10:44:14 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:

> On 13/07/2023 18:32, SeongJae Park wrote:
> > On Thu, 13 Jul 2023 16:39:33 +0200 David Hildenbrand <david@redhat.com> wrote:
> > 
> >> On 13.07.23 15:54, Ryan Roberts wrote:
> >>> When run under run_vmtests.sh, test scripts were failing to run with
> >>> "permission denied" due to the scripts not being executable.
> >>>
> >>> It is also annoying not to be able to directly invoke run_vmtests.sh,
> >>> which is solved by giving also it the execute permission.
> >>>
> >>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>> ---
> >>>   tools/testing/selftests/mm/charge_reserved_hugetlb.sh  | 0
> >>>   tools/testing/selftests/mm/check_config.sh             | 0
> >>>   tools/testing/selftests/mm/hugetlb_reparenting_test.sh | 0
> >>>   tools/testing/selftests/mm/run_vmtests.sh              | 0
> >>>   tools/testing/selftests/mm/test_hmm.sh                 | 0
> >>>   tools/testing/selftests/mm/test_vmalloc.sh             | 0
> >>>   tools/testing/selftests/mm/va_high_addr_switch.sh      | 0
> >>>   tools/testing/selftests/mm/write_hugetlb_memory.sh     | 0
> >>>   8 files changed, 0 insertions(+), 0 deletions(-)
> >>>   mode change 100644 => 100755 tools/testing/selftests/mm/charge_reserved_hugetlb.sh
> >>>   mode change 100644 => 100755 tools/testing/selftests/mm/check_config.sh
> >>>   mode change 100644 => 100755 tools/testing/selftests/mm/hugetlb_reparenting_test.sh
> >>>   mode change 100644 => 100755 tools/testing/selftests/mm/run_vmtests.sh
> >>>   mode change 100644 => 100755 tools/testing/selftests/mm/test_hmm.sh
> >>>   mode change 100644 => 100755 tools/testing/selftests/mm/test_vmalloc.sh
> >>>   mode change 100644 => 100755 tools/testing/selftests/mm/va_high_addr_switch.sh
> >>>   mode change 100644 => 100755 tools/testing/selftests/mm/write_hugetlb_memory.sh
> >>>
> >>> diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
> >>> old mode 100644
> >>> new mode 100755
> >>> diff --git a/tools/testing/selftests/mm/check_config.sh b/tools/testing/selftests/mm/check_config.sh
> >>> old mode 100644
> >>> new mode 100755
> >>> diff --git a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
> >>> old mode 100644
> >>> new mode 100755
> >>> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> >>> old mode 100644
> >>> new mode 100755
> >>> diff --git a/tools/testing/selftests/mm/test_hmm.sh b/tools/testing/selftests/mm/test_hmm.sh
> >>> old mode 100644
> >>> new mode 100755
> >>> diff --git a/tools/testing/selftests/mm/test_vmalloc.sh b/tools/testing/selftests/mm/test_vmalloc.sh
> >>> old mode 100644
> >>> new mode 100755
> >>> diff --git a/tools/testing/selftests/mm/va_high_addr_switch.sh b/tools/testing/selftests/mm/va_high_addr_switch.sh
> >>> old mode 100644
> >>> new mode 100755
> >>> diff --git a/tools/testing/selftests/mm/write_hugetlb_memory.sh b/tools/testing/selftests/mm/write_hugetlb_memory.sh
> >>> old mode 100644
> >>> new mode 100755
> >>
> >> Sounds reasonable to me.
> >>
> >> Probably due to:
> >>
> >> commit baa489fabd01596d5426d6e112b34ba5fb59ab82
> >> Author: SeongJae Park <sj@kernel.org>
> >> Date:   Tue Jan 3 18:07:53 2023 +0000
> >>
> >>      selftests/vm: rename selftests/vm to selftests/mm
> >>      
> >>      Rename selftets/vm to selftests/mm for being more consistent with the
> >>      code, documentation, and tools directories, and won't be confused with
> >>      virtual machines.
> >>
> >>
> >> and indeed, it contains
> >>
> >> diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> >> old mode 100755
> >> new mode 100644
> >> similarity index 100%
> >> rename from tools/testing/selftests/vm/run_vmtests.sh
> >> rename to tools/testing/selftests/mm/run_vmtests.sh
> > 
> > Thank you for tracking this and kindly Cc-ing me!  I'd like to clarify a little
> > bit more, though.  The permission change has made by the commit as you found.
> > Nevertheless, the submitted version[1] of the patch didn't change the
> > permission.  I guess the change was made while managing it via some file
> > permission unsupported patches management tool.
> > 
> > I had a similar issue with DAMON selftest and sent a patch restoring the
> > permission.  Greg suggested me to update the framework instead, to support such
> > management tool[2], so I made it[3].  It recently also merged into 5.15.y for
> > DAMON selftests[4].
> > 
> > I have no strong opinion about whether we need to keep the permission or it's
> > good to have no execute permission since kselftest framework supports it.  I
> > just wanted to clarify the events I've shown.  Please correct me if I missed or
> > wrong something.  Cc-ing Greg, since he might have an opinion.
> 
> Thanks for the detailed explanation. Are you effectively saying this patch will
> turn into a no-op once its been munged through the various patch management
> tools?

Depending on what tool maintainers that will pick this patch is using in what
way, I guess.

> That's disappointing because it's a pain to have to invoke everything
> though bash explicitly. Many other scripts manage to have the correct execute
> permission set (see everything in ./scripts for example).
> 
> Personally I'd rather keep this patch and try rather than proactively do a work
> around.

I don't have a strong opinion here, as mentioned before.  That said, I feel it
would be good to have a clear agreement or explanation about that, since I got
similar situation before[1].

[1] https://lore.kernel.org/damon/20230221175612.131555-1-sj@kernel.org/


Thanks,
SJ

> 
> 
> > 
> > [1] https://lore.kernel.org/all/20230103180754.129637-5-sj@kernel.org/
> > [2] https://lore.kernel.org/mm-commits/YRJisBs9AunccCD4@kroah.com/
> > [3] https://lore.kernel.org/all/20210810164534.25902-1-sj38.park@gmail.com/
> > [4] https://lore.kernel.org/stable/2023042743-cheesy-parasitic-206d@gregkh/
> > 
> > 
> > Thanks,
> > SJ
> > 
> >>
> >>
> >> Reviewed-by: David Hildenbrand <david@redhat.com>
> >>
> >> -- 
> >> Cheers,
> >>
> >> David / dhildenb
> >>
> >>
> >>
> 
> 
