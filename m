Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5F16B130E
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 21:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjCHUaE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 15:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjCHU34 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 15:29:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3A1C7098;
        Wed,  8 Mar 2023 12:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dvCkjjYwO17HVXXGgXGIfvRQwtfB+tdv9ar+/qRdD60=; b=mbYG4wipENwBxUMDMPCi6fD1OS
        NXf7fDtDwsknzveTVzfIIOu68tlpxAoRUth8S8IUxso0P4BRdhbYsjzdfV2B27j2R1scEtv067fZM
        l3yNdfSZ4YEDvoHjNqgR+k2Oe64i7DosZbzt6kgJm3ZvEz4G1IuWeDA+8XPr6OT3NXh7p5mabpozu
        XE2UJqSvjN0/tkBjfmEa+GOZE1L0jiRwQr91cAIQECf74yxrA4Gk/pPUf+VqX+ooVYYqEAGCNmpyz
        iZKpgc2Q4WMlMi4NjKn+VOQHdlVcFdIy3JWsjzBjBZej6D+8ECzwrjaSAcDXxXh9UAaODzEsfZoM9
        BpNwGBNQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pa0Q4-006g1H-Tg; Wed, 08 Mar 2023 20:29:52 +0000
Date:   Wed, 8 Mar 2023 12:29:52 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        gregkh@linuxfoundation.org, tiwai@suse.de, tianfei.zhang@intel.com,
        russell.h.weight@intel.com, keescook@chromium.org,
        tweek@google.com, a.manzanares@samsung.com, dave@stgolabs.net,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH 1/2] selftests/kmod: increase the kmod timeout from 45 to
 165
Message-ID: <ZAjwQKwZgT+UcZHq@bombadil.infradead.org>
References: <20230206234344.2433950-1-mcgrof@kernel.org>
 <20230206234344.2433950-2-mcgrof@kernel.org>
 <b094dc23-a96d-93c4-a350-8fb92476f431@linuxfoundation.org>
 <Y/0xx0cedxlRMKpH@bombadil.infradead.org>
 <537d3d3d-9ecc-bdd9-f703-708f6826d1f2@linuxfoundation.org>
 <ZAJrFvIDj98C9SkD@bombadil.infradead.org>
 <9a0e7062-2d16-3743-ffb6-a6b56bfbbd20@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a0e7062-2d16-3743-ffb6-a6b56bfbbd20@linuxfoundation.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 06, 2023 at 09:06:41AM -0700, Shuah Khan wrote:
> On 3/3/23 14:48, Luis Chamberlain wrote:
> > On Fri, Mar 03, 2023 at 01:35:10PM -0700, Shuah Khan wrote:
> > > On 2/27/23 15:42, Luis Chamberlain wrote:
> > > > On Mon, Feb 27, 2023 at 03:32:50PM -0700, Shuah Khan wrote:
> > > > > On 2/6/23 16:43, Luis Chamberlain wrote:
> > > > > > The default sefltests timeout is 45 seconds. If you run the kmod
> > > > > > selftests on your own with say:
> > > > > > 
> > > > > > ./tools/testings/selftests/kmod.sh
> > > > > > 
> > > > > > Then the default timeout won't be in effect.
> > > > > > 
> > > > > > I've never ran kmod selftests using the generic make wrapper
> > > > > > (./tools/testing/selftests/run_kselftest.sh -s) util now
> > > > > > that I have support for it on kdevops [0]. And with that the
> > > > > > test is limitted to the default timeout which we quickly run
> > > > > > into. Bump this up to what I see is required on 8GiB / 8 vcpu
> > > > > > libvirt q35 guest as can be easily created now with kdevops.
> > > > > > 
> > > > > > To run selftests with kdevops:
> > > > > > 
> > > > > > make menuconfig # enable dedicated selftests and kmod test
> > > > > > make
> > > > > > make bringup
> > > > > > make linux
> > > > > > make selftests-kmod
> > > > > > 
> > > > > > This ends up taking about 280 seconds now, give or take add
> > > > > > 50 seconds more more and we end up with 350. Document the
> > > > > > rationale.
> > > > > > 
> > > > > > [0] https://github.com/linux-kdevops/kdevops
> > > > > > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > > > > > ---
> > > > > >     tools/testing/selftests/kmod/settings | 4 ++++
> > > > > >     1 file changed, 4 insertions(+)
> > > > > >     create mode 100644 tools/testing/selftests/kmod/settings
> > > > > > 
> > > > > > diff --git a/tools/testing/selftests/kmod/settings b/tools/testing/selftests/kmod/settings
> > > > > > new file mode 100644
> > > > > > index 000000000000..6fca0f1a4594
> > > > > > --- /dev/null
> > > > > > +++ b/tools/testing/selftests/kmod/settings
> > > > > > @@ -0,0 +1,4 @@
> > > > > > +# measured from a manual run:
> > > > > > +# time ./tools/testing/selftests/kmod/kmod.sh
> > > > > > +# Then add ~50 seconds more gracetime.
> > > > > > +timeout=350
> > > > > 
> > > > > Adding timeouts like this for individual tests increases the overall kselftest
> > > > > run-time. I am not in favor of adding timeouts.
> > > > > 
> > > > > We have to find a better way to do this.
> > > > 
> > > > Well if folks don't have this the test will fail, and so a false
> > > > positive. If the goal is to have a low time timeout for "do not run
> > > > tests past this time and do not fail if we stopped the test" then
> > > > that seems to be likely one way to go and each test may need to be
> > > > modified to not fail fatally in case of a special signal.
> > > > 
> > > 
> > > We are finding more and more that timeout values are requiring
> > > tweaks. I am in favor of coming up a way to exit the test with
> > > a timeout condition.
> > 
> > OK so do we use the existing timeout as a "optional, I don't want my
> > test to take longer than this" or "if this test takes longer than
> > this amount this is a fatal issue"?
> 
> It isn't a fatal issue. So I wouldn't call it one. I would add a
> message saying test timed out.
> 
> One way to handle this is:
> - Add a test run-time option and have user tune it as needed.
> 
> Make the timeout an option so users can set it based on their
> environments.
> 
> > 
> > I ask because right now we can't override it even with an environment
> > variable. If we had such support we can let test runners (like kdevops)
> > use selftests with its own set of qualified / verified timeouts for the
> > VMs it uses.
> > 
> > For instance, Iw ant to soon start asking 0day to enable my kdevops
> > 0-day tests for the subsystems I maintain, but I can't do that yet as
> > the timeout is not correct.
> 
> This test isn't part of the default run, so day has to run this as a
> special case and it would make prefect sense to provide a tunable
> timeout option.

That's the thing, I *want* it to be part of *my runs* for my git trees
on git.kernel.org for modules-testing and modules-next. That allows me
to have 0day run whatever things I need. Long term it will be through
kdevops with just:

make linux
make selftests-kmod
make kmod
make kmod-check

Vincenzo expressed interest to help, I think he may be interested in
helping with this configurable timeout for selftests as some initial
low hanging fruit.

Then on the kdevops front we'd set what we know is right for a typical
libvirt use case for our current default VM target.

  Luis
