Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA9A75FF73
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 21:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjGXTBu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 15:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjGXTBt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 15:01:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57783188;
        Mon, 24 Jul 2023 12:01:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0D88612FC;
        Mon, 24 Jul 2023 19:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDA5C433C7;
        Mon, 24 Jul 2023 19:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1690225306;
        bh=IVmjp3tZL1zUzIeebpw0YEnIAORXP4cay/HXpSS/roU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p+SYTcxn9Hs60lt294Y81fMLOhz/lQ2y1Yukf6QGu15HmWhrOVzCPYDNUu3beIKoy
         alq96xu1sqzgIgB+Mqi6TR4GcBNNEFSUOXSKAvWu0oyD1sQnl8mTeg6WA8J3xqCR4V
         FzdhgnYQ5Vl1KVr/B/84bHBrpY43BCQ9kr5/ZQAY=
Date:   Mon, 24 Jul 2023 12:01:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/8] selftests/mm fixes for arm64
Message-Id: <20230724120145.b0d985e6f926db587a7debd1@linux-foundation.org>
In-Reply-To: <ef907f64-f7aa-3759-1adc-3fb7e3f3487b@arm.com>
References: <20230724082522.1202616-1-ryan.roberts@arm.com>
        <20230724093804.bbe8bc2a83d4575f17778eb0@linux-foundation.org>
        <ef907f64-f7aa-3759-1adc-3fb7e3f3487b@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 24 Jul 2023 19:49:13 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:

> On 24/07/2023 17:38, Andrew Morton wrote:
> > On Mon, 24 Jul 2023 09:25:14 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:
> > 
> >> This is v3 of my series to clean up mm selftests so that they run correctly on
> >> arm64. See [1] for full explanation.
> > 
> > Please don't do that.  Please maintain the [0/n] description alongside the
> > patchset and resend it each time you resend the series.
> 
> OK understood. Sorry about that. Do you have any docs for the mm submission
> process? If not, please keep pointing issues out and I'll get it right eventually.

A work in progress ;)

> I previously thought that the cover letter was primarily for the email
> recipients and the description on each patch was the part that went into git?
> Clearly I'm wrong, but can't see anything in submitting-patches.rst so guess the
> mm process is a bit different?

I expect all subsystem maintainers would like the [0/N] intro to be
maintained and resent as the patchset evolves.

> > 
> > I could go over and copy-paste [1] into this patchset, but I don't know if it
> > is fully up to date.   I'll leave the patchset intro blank for now - please
> > review/edit [1] and send the result in reply to this email, thanks. 
> 
> I doubt you would want the whole cover letter in git, so here is the relavent intro:

Pasted, thanks.
