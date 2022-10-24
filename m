Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D2160BE2B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 01:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiJXXHU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Oct 2022 19:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiJXXHC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Oct 2022 19:07:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDF45A815;
        Mon, 24 Oct 2022 14:28:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 506E86136E;
        Mon, 24 Oct 2022 13:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E71C433D7;
        Mon, 24 Oct 2022 13:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666619595;
        bh=eQhpkWuxYO6xU1NVTJ5iMfsh38Ej4102Y8qOohSGKQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jP2if4R4CABPqOwD8Pfhi1AYLkGQTfZA5g6iSAZFd1Zv7tfuz3e4/6hctCWKdcYgS
         8Gn0cTiJ27vXC0S9Vy2MpBrHVfyU+dFMns1bfTlaTtFAZZlYqmZoUkKk/3/axEcmEW
         VH5aGrWnc2tNRPQ5v4TLoCyDkKBJMTBm1YSBYKDI=
Date:   Mon, 24 Oct 2022 15:54:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v15 2/3] virt: Add TDX guest driver
Message-ID: <Y1aY/4SWwuDENigJ@kroah.com>
References: <20221020045828.2354731-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20221020045828.2354731-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Y1De4IyAB6n2qs4V@kroah.com>
 <34ef18d6-69f8-853a-d1ba-7023822e17ff@linux.intel.com>
 <Y1Iimg0WItgIGq6/@kroah.com>
 <c09184e3-ac15-b230-6dea-d6718f6f0ab0@linux.intel.com>
 <CAAq0SU=w-upGGstmQgTh63zGqLZnEy1OpF+9FwAjSWMuyYyXTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAq0SU=w-upGGstmQgTh63zGqLZnEy1OpF+9FwAjSWMuyYyXTg@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 24, 2022 at 09:57:53AM -0300, Wander Lairson Costa wrote:
> On Sun, Oct 23, 2022 at 1:13 PM Sathyanarayanan Kuppuswamy
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >
> >
> >
> > On 10/20/22 9:39 PM, Greg Kroah-Hartman wrote:
> > >>> You are allowing userspace to spam the kernel logs, please do not do
> > >>> that.
> > >> Added it to help userspace understand the reason for the failure (only for
> > >> the cases like request param issues and TDCALL failure). Boris recommended
> > >> adding it in the previous review.
> > > Again, you just created a vector for userspace to spam the kernel log.
> > > No kernel driver should ever do that.
> > >
> >
> > Brois, any comments? Do you also agree?
> >
> 
> Maybe dev_err_once() does the job?

That does not make any sense when the userspace input can be different
each time.

This is just yet-another-ioctl, there's nothing special about it.
Return an error for invalid input and don't log anything.  Worst case,
make it a dev_dbg() call if you really really really want to see it.

thanks,

greg k-h
