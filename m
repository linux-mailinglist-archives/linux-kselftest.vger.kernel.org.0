Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4D5774045
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 19:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjHHRBj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 13:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbjHHRBA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 13:01:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EAA8685;
        Tue,  8 Aug 2023 09:00:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85C99623A0;
        Tue,  8 Aug 2023 07:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607DBC433C8;
        Tue,  8 Aug 2023 07:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691480120;
        bh=2X/NGOteLx4UL3AZkQJT72BA3+ipWBqs7JqK5Lor0b8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Su9ocHgjU00cWfZv6OLYZoas6jUlRqbWOEtcbT1kZAr/ElT/82cIeISg8oVmdK5fL
         j8w/eEwG/vrvr4fk9sP8HvryDnGXUuXUcABLYP68xSlz7J6p8mli5w2jy6aQjoIFiC
         80rf2TYDsg8WV2Ye4sT6LmGwDeF+MX56LM7BaMnA=
Date:   Tue, 8 Aug 2023 09:35:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v3 4.14 1/1] test_firmware: fix the memory leaks with the
 reqs buffer
Message-ID: <2023080817-why-shawl-8ac1@gregkh>
References: <20230804170017.92671-1-mirsad.todorovac@alu.unizg.hr>
 <2023080705-poet-nickname-5e08@gregkh>
 <a9e443c7-c7b5-63ce-08d9-5604ac545bf6@alu.unizg.hr>
 <2023080802-moonrise-cascade-a4c0@gregkh>
 <1269af66-bd86-0fab-e4ec-968f14371279@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1269af66-bd86-0fab-e4ec-968f14371279@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 08, 2023 at 08:24:43AM +0200, Mirsad Todorovac wrote:
> On 8/8/23 06:28, Greg Kroah-Hartman wrote:
> > On Mon, Aug 07, 2023 at 08:28:04PM +0200, Mirsad Todorovac wrote:
> > > On 8/7/23 11:15, Greg Kroah-Hartman wrote:
> > > > On Fri, Aug 04, 2023 at 07:00:18PM +0200, Mirsad Todorovac wrote:
> > > > > [ commit be37bed754ed90b2655382f93f9724b3c1aae847 upstream ]
> > > > > 
> > > > > Dan Carpenter spotted that test_fw_config->reqs will be leaked if
> > > > > trigger_batched_requests_store() is called two or more times.
> > > > > The same appears with trigger_batched_requests_async_store().
> > > > > 
> > > > > This bug wasn't triggered by the tests, but observed by Dan's visual
> > > > > inspection of the code.
> > > > > 
> > > > > The recommended workaround was to return -EBUSY if test_fw_config->reqs
> > > > > is already allocated.
> > > > > 
> > > > > Fixes: c92316bf8e94 ("test_firmware: add batched firmware tests")
> > > > > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Cc: Russ Weight <russell.h.weight@intel.com>
> > > > > Cc: Tianfei Zhang <tianfei.zhang@intel.com>
> > > > > Cc: Shuah Khan <shuah@kernel.org>
> > > > > Cc: Colin Ian King <colin.i.king@gmail.com>
> > > > > Cc: Randy Dunlap <rdunlap@infradead.org>
> > > > > Cc: linux-kselftest@vger.kernel.org
> > > > > Cc: stable@vger.kernel.org # v4.14
> > > > > Suggested-by: Dan Carpenter <error27@gmail.com>
> > > > > Suggested-by: Takashi Iwai <tiwai@suse.de>
> > > > > Link: https://lore.kernel.org/r/20230509084746.48259-2-mirsad.todorovac@alu.unizg.hr
> > > > > Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> > > > > 
> > > > > [ This fix is applied against the 4.14 stable branch. There are no changes to the ]
> > > > > [ fix in code when compared to the upstread, only the reformatting for backport.  ]
> > > > 
> > > > Thanks for all of these, now queued up.
> > > 
> > > No problem, I should have done it right the first time to reduce your load.
> > > 
> > > I really believe that backporting bug fix patches is important because many systems
> > > cannot upgrade because of the legacy apps and hardware, to state the obvious.
> > 
> > What "legacy apps" rely on a specific kernel version?
> 
> Hi, Mr. Greg,
> 
> Actually, in our particular case, it was the Eprints that required old mysql on Debian stretch
> rather than MariaDB that came with Buster. So, the release required particular kernel version (4.9).

So what happens when this kernel becomes end-of-life?

> Of course, we can upgrade to any mainline kernel, but that is no longer a tested distro kernel,
> and faults would be blamed on me entirely. Plus the overhead of regular patching ...

You should be doing regular patching for any LTS kernel as well, right?
Same for testing, there should not be any difference in testing any
kernel update be it on a LTS branch, or between major versions.

anyway, good luck!

greg k-h
