Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B546B678D
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Mar 2023 16:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCLPhr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Mar 2023 11:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjCLPhq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Mar 2023 11:37:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C623843441;
        Sun, 12 Mar 2023 08:37:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3DFC5CE0B11;
        Sun, 12 Mar 2023 15:37:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A7DC433EF;
        Sun, 12 Mar 2023 15:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678635461;
        bh=R1AumEUR0bc6e6nMbU15hmjqwiC8LvwLAyZqPz0mE0U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W/0MwonhwuYJslF0MxV5sr6QvoeUmcoCR/F03L2q1FNbcozZDvTMWPOCerg6k1Sjx
         b2Fqd/TvWbEBvXCyVGfFGM2NWQXdSZ5E122LadxT+TTouRN2eBsZEVqJ+7kOsB97bJ
         ekO9KUdqnhgxpvqEBYc3ZdZuJOfNxroy9CqHds5/RNUfQZu6vhFd0vOCdVOCcz1Mjz
         hr9W4NBMFmMgEKzF3xqV5TNsRsnWCGgXtGaZE+RFZYLED7beFTvoS5bELjQaetjnog
         +/RgQWWhsISiRg6ZQYRGHv+jrnNYGy87z9obJEiTttGVA2iZ8wAvIlIALz9RU2JNCo
         ZbipuVX/Dcpcg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=wait-a-minute.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1pbNlT-00H1EO-BT;
        Sun, 12 Mar 2023 15:37:39 +0000
Date:   Sun, 12 Mar 2023 15:37:39 +0000
Message-ID: <87v8j63rr0.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Add coverage of MTE system registers
In-Reply-To: <ZA3jISc0DH+7swbI@sirena.org.uk>
References: <20230308-kvm-arm64-test-mte-regs-v1-1-f92a377e486f@kernel.org>
        <87edpu5klk.wl-maz@kernel.org>
        <ZA3jISc0DH+7swbI@sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: broonie@kernel.org, oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, pbonzini@redhat.com, shuah@kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, 12 Mar 2023 14:35:13 +0000,
Mark Brown <broonie@kernel.org> wrote:
> 
> On Sun, Mar 12, 2023 at 10:29:11AM +0000, Marc Zyngier wrote:
> > Mark Brown <broonie@kernel.org> wrote:
> 
> > >  static struct vcpu_config *vcpu_configs[] = {
> > >  	&vregs_config,
> > > @@ -1131,5 +1163,6 @@ static struct vcpu_config *vcpu_configs[] = {
> > >  	&sve_pmu_config,
> > >  	&pauth_config,
> > >  	&pauth_pmu_config,
> > > +	&mte_config,
> > >  };
> > >  static int vcpu_configs_n = ARRAY_SIZE(vcpu_configs);
> 
> > Is there any reason why we sidestep the combinations of MTE with PAuth
> > and PMU? I know this leads to an exponential set growth, but this is
> > the very purpose of this test, and we found bugs related to this in
> > the past.
> 
> The test is already not bothering with the combinations of SVE
> and pointer auth, it appeared that the intent of the test was
> only to test specific combinations.  From what's there it looks
> more like there's something with PMU interacting specially with
> things (it's all X and X+PMU) that needs coverage.  I couldn't
> see anything between it and MTE, though I nearly added a MTE+PMU
> combination just for the sake of it.  It's one of those areas
> where it's hard to determine if there's an intent behind the
> implementation choices made or if they're just whatever someone
> happened to write and not particularly important or desired.

It *is* desired. We've had cases of flags being reset at the wrong
time and leading to issues that would be detected by this test. The
PMU stuff is indeed one example, but similar things could happen
between SVE+MTE, for example.

> 
> > A good first step would be to be able to build these combinations
> > dynamically, and only then add new sublists to the mix.
> 
> That would certainly be a good idea, if we were heading in that
> direction I'd also expect negative tests checking that for
> example pointer authentication registers don't appear when that's
> not enabled.  I'm not sure that it's worth blocking all new
> coverage for that though, there is still value in having a bit of
> basic coverage even if not all the combinations are covered yet.

Then where is the incentive to get it fixed? People will just keep
piling stuff, and the coverage will increasingly become worse.

We have to do it as some point, and now is as good a time as any.

	M.

-- 
Without deviation from the norm, progress is not possible.
