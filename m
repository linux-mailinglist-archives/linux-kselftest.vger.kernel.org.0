Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D5772DF55
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 12:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241601AbjFMKYt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 06:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241915AbjFMKY1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 06:24:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB8D1FC3;
        Tue, 13 Jun 2023 03:23:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C7406347B;
        Tue, 13 Jun 2023 10:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8ADC4339B;
        Tue, 13 Jun 2023 10:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686651824;
        bh=wJubVzqmPotnRKfDseTWfTVIJKeVzQ5R2525+A6LYno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ParxHeN2HcwjlI1cxi8Vg5s0dVCHH3jTCAIPymrNaqBpSUOAVJPEpB0zGu6ko6Jrm
         MPbjK8ZqHHESMGqHdsXm8QQFcqJM7CqapkBAPJKPJYlocJRUtxZQLjxMhoLtaeNcq2
         lH9UPqxBK78RVXoB5GD1PCmfdhVwLCPpw3PvwpvA=
Date:   Tue, 13 Jun 2023 12:23:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michal Sekletar <msekleta@redhat.com>
Cc:     jirislaby@kernel.org, arozansk@redhat.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH v2 1/2] tty: tty_io: update timestamps on all device nodes
Message-ID: <2023061325-alibi-grappling-c764@gregkh>
References: <c91c458e-58d0-f13a-9adb-a48a19f82107@kernel.org>
 <20230608101616.44152-1-msekleta@redhat.com>
 <2023060816-quicken-around-d619@gregkh>
 <CALVzVJas7g8PrTavpQ01J4vpKtqNP7fYznMMXYEM4K5XbbXRhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALVzVJas7g8PrTavpQ01J4vpKtqNP7fYznMMXYEM4K5XbbXRhg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 08, 2023 at 07:52:54PM +0200, Michal Sekletar wrote:
> On Thu, Jun 8, 2023 at 1:51 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > So how are you protecting this from being an information leak like we
> > have had in the past where you could monitor how many characters were
> > being sent to the tty through a proc file?  Seems like now you can just
> > monitor any tty node in the system and get the same information, while
> > today you can only do it for the tty devices you have permissions for,
> > right?
> 
> Hi Greg,
> 
> I am not protecting against it in any way, but proposed changes are only
> about timestamp updates which still happen in at least 8 seconds intervals
> so exact timing of read/writes to tty can't be inferred. Frankly, I may
> have misunderstood something. It would be great if you could mention a bit
> more details about CVE you had in mind.

Ah, I missed that this is in 8 second increments, nevermind then!

thanks,

greg k-h
