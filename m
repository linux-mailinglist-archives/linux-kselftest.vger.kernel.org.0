Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A34A5E5FB2
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Sep 2022 12:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiIVKUa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Sep 2022 06:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiIVKU2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Sep 2022 06:20:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD78ABD76;
        Thu, 22 Sep 2022 03:20:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71E54612D5;
        Thu, 22 Sep 2022 10:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480A8C433C1;
        Thu, 22 Sep 2022 10:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663842026;
        bh=Tc3FJ+kvPCra3uvSRT0MqM78GUuFNuRgTyRBDiLAt2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WC19bm7yDjv6Fv4q7W2qd50dSl5fONXIiqQ7aLs5DKICZZL/WOedMxdWyY4QdNKA6
         edSWtEYH63uYGoX2MqtJroCZ96MfTte2rEwLJ21lVT6PvBqAIBc+kpTUBQV457oMMK
         ufpc07/tEAsgyMGHiuNbe5VjMb8Zfx00XxDnuZXc=
Date:   Thu, 22 Sep 2022 12:20:16 +0200
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
Message-ID: <Yyw24J7YFVtxsnJ7@kroah.com>
References: <20220922083610.235936-1-xu.panda@zte.com.cn>
 <CABVgOSkjmuWDVwOW5PQRAtDYJGjHjcc_8Gg4JjhiT41Kez1rcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSkjmuWDVwOW5PQRAtDYJGjHjcc_8Gg4JjhiT41Kez1rcw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 22, 2022 at 06:09:28PM +0800, David Gow wrote:
> On Thu, Sep 22, 2022 at 4:36 PM <cgel.zte@gmail.com> wrote:
> >
> > From: Xu Panda <xu.panda@zte.com.cn>
> >
> > Not using absolute path when invoking wget can lead to serious
> > security issues.
> >
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> > ---
> 
> This seems mostly okay to me -- we'd be abandoning people who have
> wget in an unusual location, but I don't think there are many people
> who want to run KUnit under RISC-V, have wget in a non-standard
> location, and can't acquire the bios file themselves.
> 
> So this is:
> Reviewed-by: David Gow <davidgow@google.com>

Please no, at this point in time, submissions from this gmail "alias"
are going to have to be rejected from the kernel.

greg k-h
