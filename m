Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A63644968
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Dec 2022 17:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbiLFQgn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Dec 2022 11:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbiLFQgO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Dec 2022 11:36:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2271DB2;
        Tue,  6 Dec 2022 08:35:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51C1FB81AB2;
        Tue,  6 Dec 2022 16:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425BBC433D6;
        Tue,  6 Dec 2022 16:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670344532;
        bh=xLPfb9uCpOGAMWazbtHia2mg57Cvx5Vy+jhdYipW07Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PYt4F+B6zxS4blgAEKoWiYg7l3jca0OPluig0ko3yvCJEICgp9uHUMKVfQ+H1hrNu
         QP74wZEjlBTLdO6+wWL2tm28BVWMHF/mKUDSK6kQ2Q9xdQUcW/rGgavWKKU326bChP
         Tt9KveMsw9qXnuDJVTCGwTZ+vyRKDJV0X5STADsU=
Date:   Tue, 6 Dec 2022 17:35:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jeff Xu <jeffxu@google.com>
Cc:     jeffxu@chromium.org, skhan@linuxfoundation.org,
        keescook@chromium.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 3/6] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
Message-ID: <Y49vUQKRVyquazJ2@kroah.com>
References: <20221206152358.1966099-1-jeffxu@google.com>
 <20221206152358.1966099-4-jeffxu@google.com>
 <Y49oIR6/ULTqlcwL@kroah.com>
 <CALmYWFvaEg84DYtjQtoQqsvaboX7mRS5dOqz8OJ0EYJTOCp4kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALmYWFvaEg84DYtjQtoQqsvaboX7mRS5dOqz8OJ0EYJTOCp4kg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 06, 2022 at 08:26:30AM -0800, Jeff Xu wrote:
> On Tue, Dec 6, 2022 at 8:04 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Dec 06, 2022 at 03:23:55PM +0000, jeffxu@chromium.org wrote:
> > > --- a/kernel/pid_namespace.c
> > > +++ b/kernel/pid_namespace.c
> > > @@ -110,6 +110,11 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
> > >       ns->ucounts = ucounts;
> > >       ns->pid_allocated = PIDNS_ADDING;
> > >
> > > +#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
> > > +     ns->memfd_noexec_scope =
> > > +             task_active_pid_ns(current)->memfd_noexec_scope;
> > > +#endif
> >
> > .c files should never have #if in them.  Can't you put this in a .h file
> > properly so that this does not get really messy over time?
> >
> >
> Thanks for reviewing.
> It seems to me that checking for CONFIG_XXX is  common in c code in
> kernel/ path.

Maybe, but please don't make it any worse if at all possible.  It's
tough to maintain code like that.

> Do you have a sample code pattern (link/function) that I can follow?

Any of the zillions of #if statements in .h files :)

thanks,

greg k-h
