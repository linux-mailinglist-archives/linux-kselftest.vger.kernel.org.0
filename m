Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF927B4E95
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Oct 2023 11:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbjJBJDx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Oct 2023 05:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbjJBJDs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Oct 2023 05:03:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B410CCC7;
        Mon,  2 Oct 2023 01:58:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E7EC433C8;
        Mon,  2 Oct 2023 08:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696237090;
        bh=8abm9OAu+6R2eeXjvqzEvTzOpfgxvqtX2BvAOig38Qc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R3iroP1fgcPCfVuj+LKeoTyHLNnOW1uVwQiT1WrjNYg+BWp/TPOvIaG7m1vjEea9n
         f1i0I0RO0TojNIyE2LzamXcwGlHYmuYAZSVRpu9dFBN8Nd2OWywNdtZBxplEoB3n9k
         3vAAbta8hvhd0hnSSJwqg0kwzk5vjWWX98klWb5Q=
Date:   Mon, 2 Oct 2023 10:58:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhinav <singhabhinav9051571833@gmail.com>
Cc:     shuah@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] Added missing TARGETS in kselftest top level Makefile
Message-ID: <2023100251-recycled-purist-1ea5@gregkh>
References: <2023100135-stiffen-depress-8121@gregkh>
 <20231002072735.1566009-1-singhabhinav9051571833@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002072735.1566009-1-singhabhinav9051571833@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 02, 2023 at 12:57:35PM +0530, Abhinav wrote:
> Some tests like dma, ia64, etc. were not present in top level of
> selftest Makefile, so when someone ran 'make run_tests' they would miss
> these tests. This patches adds those left out tests.
> 
> Signed-off-by: Abhinav <singhabhinav9051571833@gmail.com>
> ---
>  tools/testing/selftests/Makefile | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
