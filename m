Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE8170FB52
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 18:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjEXQFT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 12:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238753AbjEXQFB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 12:05:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1A7E49;
        Wed, 24 May 2023 09:04:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8C13617B0;
        Wed, 24 May 2023 16:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FE9C4339B;
        Wed, 24 May 2023 16:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684944242;
        bh=AvLEpqq/Dfm1IZH9Fj2SEDUypWc1N9U5UTURKsOgFXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nlzXFI5cSYkrBMMbmjohePIfZJEJ1wyXXh8nVwQWYHkk8no4B3DZgv+dD2ve05da8
         pekgyIFhR2BvsiTbttuSUbf8SlIpeOJURyDpYVVmKCeDTjGGj1QtMuuAiz4KNIBzI1
         smXEPshQji5C5rb14OqzMaF7TjOIJRvLXVEh+RS0=
Date:   Wed, 24 May 2023 17:03:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lorenz Bauer <lmb@isovalent.com>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        shuah@kernel.org, yhs@fb.com, eddyz87@gmail.com, sdf@google.com,
        error27@gmail.com, iii@linux.ibm.com, memxor@gmail.com,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.2 08/30] selftests/bpf: check that modifier
 resolves after pointer
Message-ID: <2023052435-xbox-dislike-0ab2@gregkh>
References: <20230320005258.1428043-1-sashal@kernel.org>
 <20230320005258.1428043-8-sashal@kernel.org>
 <CAN+4W8g6AcQQWe7rrBVOFYoqeQA-1VbUP_W7DPS3q0k-czOLfg@mail.gmail.com>
 <ZBiAPngOtzSwDhFz@kroah.com>
 <CAN+4W8jAyJTdFL=tgp3wCpYAjGOs5ggo6vyOg8PbaW+tJP8TKA@mail.gmail.com>
 <CAN+4W8j5qe6p3YV90g-E0VhV7AmYyAvt0z50dfDSombbGghkww@mail.gmail.com>
 <2023041100-oblong-enamel-5893@gregkh>
 <CAN+4W8hmSgbb-wO4da4A=6B4y0oSjvUTTVia_0PpUXShP4NX4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN+4W8hmSgbb-wO4da4A=6B4y0oSjvUTTVia_0PpUXShP4NX4Q@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 24, 2023 at 12:03:43PM +0100, Lorenz Bauer wrote:
> On Tue, Apr 11, 2023 at 4:14 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > I didn't see anything to do here.
> >
> > And selftests should NOT be broken on stable releases, if so, something
> > is wrong as no other subsystem has that happen.
> 
> Sorry for the long delay in replying, I update the kernels we use for
> CI only infrequently. Here is an example of the build failure I'm
> seeing, from kernel.org 5.10 LTS:
> 
> In file included from
> /work/build/5.10.180/tools/testing/selftests/bpf/verifier/tests.h:59,
>                  from test_verifier.c:355:
> /work/build/5.10.180/tools/testing/selftests/bpf/verifier/ref_tracking.c:935:3:
> error: 'struct bpf_test' has no member named 'fixup_map_ringbuf'; did
> you mean 'fixup_map_in_map'?
>   935 |  .fixup_map_ringbuf = { 11 },
>       |   ^~~~~~~~~~~~~~~~~
>       |   fixup_map_in_map
> 
> This is just doing make -C tools/testing/selftests/bpf after compiling a kernel.

Great, any specific commits that fix this issue would be appreciated to
be pointed at so we can apply them.

thanks,

greg k-h
