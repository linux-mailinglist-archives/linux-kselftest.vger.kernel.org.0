Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313975E60B5
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Sep 2022 13:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbiIVLP1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Sep 2022 07:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiIVLPW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Sep 2022 07:15:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B133FA25;
        Thu, 22 Sep 2022 04:15:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBB80B835E0;
        Thu, 22 Sep 2022 11:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DB1C4347C;
        Thu, 22 Sep 2022 11:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663845305;
        bh=HJLF0sxaaK0zibNfx1kSIE8o0oMxLWdBFj2lY98C4Is=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=meHPgX7O07DcuZq2IoD9HWIbHP7eoS5UilZv6q9TrjGj1n19t3QGF1ETE3tU1X1/A
         m4YpNcgt4ydOBvSoaHoFAWTSFN09F5NpXe1V9W+noau3MsiJJcutaXiIcWy/YZsbSn
         UnREWAMsskqMqYNyVlpxpyx8JKCshTQpXl9uXIII=
Date:   Thu, 22 Sep 2022 13:15:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Gow <davidgow@google.com>
Cc:     cgel.zte@gmail.com, Brendan Higgins <brendan.higgins@linux.dev>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xu Panda <xu.panda@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] kunit: tool: use absolute path for wget
Message-ID: <YyxDtgfeFt4QYVNN@kroah.com>
References: <20220922083610.235936-1-xu.panda@zte.com.cn>
 <CABVgOSkjmuWDVwOW5PQRAtDYJGjHjcc_8Gg4JjhiT41Kez1rcw@mail.gmail.com>
 <Yyw24J7YFVtxsnJ7@kroah.com>
 <CABVgOSmDn8aVz=LEE6HnLTH8FJ0Civ7gsqejVfhnizFiAWF6jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSmDn8aVz=LEE6HnLTH8FJ0Civ7gsqejVfhnizFiAWF6jw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 22, 2022 at 06:50:59PM +0800, David Gow wrote:
> On Thu, Sep 22, 2022 at 6:20 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Sep 22, 2022 at 06:09:28PM +0800, David Gow wrote:
> > > On Thu, Sep 22, 2022 at 4:36 PM <cgel.zte@gmail.com> wrote:
> > > >
> > > > From: Xu Panda <xu.panda@zte.com.cn>
> > > >
> > > > Not using absolute path when invoking wget can lead to serious
> > > > security issues.
> > > >
> > > > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > > > Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> > > > ---
> > >
> > > This seems mostly okay to me -- we'd be abandoning people who have
> > > wget in an unusual location, but I don't think there are many people
> > > who want to run KUnit under RISC-V, have wget in a non-standard
> > > location, and can't acquire the bios file themselves.
> > >
> > > So this is:
> > > Reviewed-by: David Gow <davidgow@google.com>
> >
> > Please no, at this point in time, submissions from this gmail "alias"
> > are going to have to be rejected from the kernel.
> >
> 
> Good to know, thanks.
> 
> This isn't queued anyway, as I think that getting rid of the code to
> download the BIOS (and instead relying on the user's distro to provide
> it) is probably a better solution.s

That's a much better solution, we have authenticated firmware download
paths for BIOS images on Linux now integrated into distros.  Let's use
that infrastructure that is set up for that for this type of thing.

thanks,

greg k-h
