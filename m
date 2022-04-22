Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B59D50B0DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Apr 2022 08:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444406AbiDVGxE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Apr 2022 02:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444286AbiDVGxD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Apr 2022 02:53:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D14DEFE;
        Thu, 21 Apr 2022 23:50:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 262BAB82936;
        Fri, 22 Apr 2022 06:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B18CC385A9;
        Fri, 22 Apr 2022 06:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650610208;
        bh=uLWokosRpzj6wCwWK9zR8tAAD/RLyqYvDASb0JGaMrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X9Pxt4sHr6ABCnhp6MDSRuPU95akrwqlDYD6Rce1zMiNwxXVu2EXS0iLTeWgA+1ZS
         PeR684WZNeOudz1tFf9lIf3qpCeo+NSJ8+iO1rAsruh+LbXaU1M99H/xV1pKQ+0xNx
         oJlgLPEX3zgiHrPaI1Wz3/Qy0RUnjT4ZeyJ8XI2Q=
Date:   Fri, 22 Apr 2022 08:50:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nick Terrell <terrelln@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/5] Firmware loader support for ZSTD-compressed files
Message-ID: <YmJQHXNeeIb5X79F@kroah.com>
References: <20220421152908.4718-1-tiwai@suse.de>
 <YmGKxb6XILkRqucZ@bombadil.infradead.org>
 <s5hv8v1tygg.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hv8v1tygg.wl-tiwai@suse.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 22, 2022 at 08:38:07AM +0200, Takashi Iwai wrote:
> On Thu, 21 Apr 2022 18:48:05 +0200,
> Luis Chamberlain wrote:
> > 
> > On Thu, Apr 21, 2022 at 05:29:03PM +0200, Takashi Iwai wrote:
> > > Hi,
> > > 
> > > this is a revised patch set for RFC I posted some time ago (*).
> > > Since the ZSTD usage became much more popular now, it makes sense to
> > > have the consistent (de)compression support in the kernel, also for
> > > the firmware files.  This patch set adds the support for ZSTD-
> > > compressed firmware files as well as the extension of selftests, in
> > > addition to a couple of relevant fixes in selftests.
> > > 
> > > (*) https://lore.kernel.org/r/20210127154939.13288-1-tiwai@suse.de
> > 
> > Russ had posted a set of patches which this likely needs to be
> > rebased on top of. Russ however has to address one kernel splat
> > found by 0day, so I'd expect a new set and then perhaps this can
> > be based on that?
> 
> Sure, it should be fine, as the code change there is quite minimal.
> Let me know if the base branch becomes ready.

Your patches came in before Russ's, so I'll queue them up now first.

thanks,

greg k-h
