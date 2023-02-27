Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F92A6A4ED3
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 23:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjB0WoP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 17:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjB0WoG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 17:44:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF4FDBC1;
        Mon, 27 Feb 2023 14:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2e4LOLQwFxhDgGoXmiL7+U4YyT78y3H+UWPeZs33bwQ=; b=rjNviUim7sg9Zj9XO/LNgcGiY9
        2uZu5WYDay3SvE4O1bC0Sw9LZWKuoTJzRtSQE8/+Wbb6D3kcN4PgDJFL725btb61JyyC/+K/AzphF
        FEwgutMOHjmJmK/FNKrXdp7VOXmsxNV0uBIPYg5RL5bny6z6W1ELLV9sfUde0wZRG3Mfjj6Jxumul
        Hh1r6z1CKUirlBGVIh/iGr37RDLHXFRAr4LflScXutkRNNJBJL60L+UaGaLIGaXPe2G9ipmfKZF4L
        ajru3FQFcZllB0+TdqvaxCe6OoVfbwqm4623UjdTAsQJx0213SDsk/DNKLaVOOfuXkdKsp9zM/uwn
        1VsVMEwQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWmCF-00BVMN-Cs; Mon, 27 Feb 2023 22:42:15 +0000
Date:   Mon, 27 Feb 2023 14:42:15 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        gregkh@linuxfoundation.org, tiwai@suse.de, tianfei.zhang@intel.com,
        russell.h.weight@intel.com, keescook@chromium.org,
        tweek@google.com, a.manzanares@samsung.com, dave@stgolabs.net,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/kmod: increase the kmod timeout from 45 to
 165
Message-ID: <Y/0xx0cedxlRMKpH@bombadil.infradead.org>
References: <20230206234344.2433950-1-mcgrof@kernel.org>
 <20230206234344.2433950-2-mcgrof@kernel.org>
 <b094dc23-a96d-93c4-a350-8fb92476f431@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b094dc23-a96d-93c4-a350-8fb92476f431@linuxfoundation.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 27, 2023 at 03:32:50PM -0700, Shuah Khan wrote:
> On 2/6/23 16:43, Luis Chamberlain wrote:
> > The default sefltests timeout is 45 seconds. If you run the kmod
> > selftests on your own with say:
> > 
> > ./tools/testings/selftests/kmod.sh
> > 
> > Then the default timeout won't be in effect.
> > 
> > I've never ran kmod selftests using the generic make wrapper
> > (./tools/testing/selftests/run_kselftest.sh -s) util now
> > that I have support for it on kdevops [0]. And with that the
> > test is limitted to the default timeout which we quickly run
> > into. Bump this up to what I see is required on 8GiB / 8 vcpu
> > libvirt q35 guest as can be easily created now with kdevops.
> > 
> > To run selftests with kdevops:
> > 
> > make menuconfig # enable dedicated selftests and kmod test
> > make
> > make bringup
> > make linux
> > make selftests-kmod
> > 
> > This ends up taking about 280 seconds now, give or take add
> > 50 seconds more more and we end up with 350. Document the
> > rationale.
> > 
> > [0] https://github.com/linux-kdevops/kdevops
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >   tools/testing/selftests/kmod/settings | 4 ++++
> >   1 file changed, 4 insertions(+)
> >   create mode 100644 tools/testing/selftests/kmod/settings
> > 
> > diff --git a/tools/testing/selftests/kmod/settings b/tools/testing/selftests/kmod/settings
> > new file mode 100644
> > index 000000000000..6fca0f1a4594
> > --- /dev/null
> > +++ b/tools/testing/selftests/kmod/settings
> > @@ -0,0 +1,4 @@
> > +# measured from a manual run:
> > +# time ./tools/testing/selftests/kmod/kmod.sh
> > +# Then add ~50 seconds more gracetime.
> > +timeout=350
> 
> Adding timeouts like this for individual tests increases the overall kselftest
> run-time. I am not in favor of adding timeouts.
> 
> We have to find a better way to do this.

Well if folks don't have this the test will fail, and so a false
positive. If the goal is to have a low time timeout for "do not run
tests past this time and do not fail if we stopped the test" then
that seems to be likely one way to go and each test may need to be
modified to not fail fatally in case of a special signal.

  Luis
