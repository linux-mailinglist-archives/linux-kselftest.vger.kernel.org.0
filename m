Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02CD5F1A79
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Oct 2022 09:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJAHIz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Oct 2022 03:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJAHIy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Oct 2022 03:08:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34A615D87E;
        Sat,  1 Oct 2022 00:08:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39DB360AB1;
        Sat,  1 Oct 2022 07:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F125C433D6;
        Sat,  1 Oct 2022 07:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664608132;
        bh=yrdpc3zOz610hbWbcjsXGTPsefElcjqcTSQmWfPauWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hp1+w8xyuS/6X2DgCelkCjIVwXwNrtQAoQjneGB4eQao2sUAQY8Eeldhz9bJDqCCp
         LP4vYRSsDuh0Vln180Lt3AKk1k3Ie4WwzAxS7akJPyvYiq8Vpm9zXzKZmLI/A5mUpD
         ON/M6UVqjVPqkovwEonn2LkUow6qMo41uRCmS9CA=
Date:   Sat, 1 Oct 2022 09:09:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     tglx@linutronix.de, akpm@linux-foundation.org, shuah@kernel.org,
        joe@perches.com, keescook@chromium.org, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/2] SPDX: add copyleft-next-0.3.1
Message-ID: <YzfnqTlEbx5K7ehQ@kroah.com>
References: <20220914060147.1934064-1-mcgrof@kernel.org>
 <YzdMWr84Z8mgbfWS@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzdMWr84Z8mgbfWS@bombadil.infradead.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 30, 2022 at 01:06:50PM -0700, Luis Chamberlain wrote:
> On Tue, Sep 13, 2022 at 11:01:45PM -0700, Luis Chamberlain wrote:
> > As suggested by Thomas Gleixner, I'm following up to move on with
> > the SPDX tag needed for copyleft-next-0.3.1. I've split this out
> > from the test_sysfs selftest so to separate review from that.
> > 
> > Changes on this v10:
> > 
> >   o embraced paragraph from Thomas Gleixner which helps explain why             
> >     the OR operator in the SPDX license name
> >   o dropped the GPL-2.0 and GPL-2.0+ tags as suggested by Thomas Gleixner
> >     as these are outdated (still valid) in the SPDX spec
> >   o trimmed the Cc list to remove the test_sysfs / block layer / fs folks as
> >     the test_sysfs stuff is now dropped from consideration in this series
> > 
> > The last series was at v9 but it also had the test_sysfs and its
> > changes, its history can be found here:
> > 
> > https://lore.kernel.org/all/20211029184500.2821444-1-mcgrof@kernel.org/
> > 
> > Luis Chamberlain (2):
> >   LICENSES: Add the copyleft-next-0.3.1 license
> >   testing: use the copyleft-next-0.3.1 SPDX tag
> 
> *poke*

I was waiting for someone else to review this before considering it...
