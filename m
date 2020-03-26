Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5EC19480C
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 20:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgCZT6L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Mar 2020 15:58:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727446AbgCZT6L (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Mar 2020 15:58:11 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5784D206E6;
        Thu, 26 Mar 2020 19:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585252690;
        bh=Iy1Vo9XDp/0w9tjBUq/6qFzyHr6inT+v6uL1ZbBtUtk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uMpnCJ5tcvu2lcbi9CrLyaFTqKO8nrKkLodw/67tQDB4pUcH1IUlEbljKZgJj/2Pk
         FuhR9hX/G2PewXCK81qSP/9ZNj1s0HHUH6nT4vYnJ74R4ne0m5SkPmpm9+Q3EvodUb
         xaH56cb6xSHmcHIyH2Y6gUx2FeM/JXExhebkYQU4=
Date:   Thu, 26 Mar 2020 12:58:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Rafael Aquini <aquini@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Eric B Munson <emunson@akamai.com>
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
Message-Id: <20200326125809.64d92920bcd481cf15207855@linux-foundation.org>
In-Reply-To: <20200326064909.GB27965@dhcp22.suse.cz>
References: <20200323144240.GB23364@optiplex-lnx>
        <20200323145106.GM7524@dhcp22.suse.cz>
        <20200323150259.GD23364@optiplex-lnx>
        <20200323151256.GP7524@dhcp22.suse.cz>
        <20200323154159.GF23364@optiplex-lnx>
        <20200323155111.GQ7524@dhcp22.suse.cz>
        <20200323155449.GG23364@optiplex-lnx>
        <20200324154218.GS19542@dhcp22.suse.cz>
        <20200324154910.GM23364@optiplex-lnx>
        <20200325174949.95d8a9de61c6a30a7e0f4582@linux-foundation.org>
        <20200326064909.GB27965@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 26 Mar 2020 07:49:09 +0100 Michal Hocko <mhocko@kernel.org> wrote:

> On Wed 25-03-20 17:49:49, Andrew Morton wrote:
> > On Tue, 24 Mar 2020 11:49:10 -0400 Rafael Aquini <aquini@redhat.com> wrote:
> > 
> > > Thanks Michal!
> > > 
> > >  
> > > Acked-by: Rafael Aquini <aquini@redhat.com>
> > 
> > I'll add
> > Fixes: 9c4e6b1a7027f ("mm, mlock, vmscan: no more skipping pagevecs")
> 
> Wouldn't be this misleading? It would suggest that this commit is
> somehow incorrect. I would consider b3b0d09c7a23 ("selftests: vm: add
> tests for lock on fault") to be a better fit.

Yes, it's a bit misleading.

Or maybe not.  b3b0d09c7a23 was merged in 2015 and worked OK (afaik)
until 9c4e6b1a7027f came along in 2020.  So arguably, 2020's
9c4e6b1a7027f was correct but incomplete, since it failed to repair the
impact upon the test code.

I don't think that kernels prior to 2020's 9c4e6b1a7027f require this
change(?), so we only need to backport this into 5.6.x, which is what
my proposed Fixes: and cc:stable expresses.

> > and cc:stable to this.  Any kernel which has 9c4e6b1a7027f will benefit
> > from this change.
> 
> OK, makes sense with
> Cc: stable # with 9c4e6b1a7027f applied
>  
> > We're getting quite late in the cycle now so I think I'll hold off
> > merging this up until post-5.7-rc1.  It will still get into the stable
> > trees, but a bit later.
> 
> No problem. Nothing really urget. Coincidentaly we've just had a report
> from our partner about this very specific test failure for our
> enterprise kernel as well.

I assume that your kernel has 2020's 9c4e6b1a7027f?

> I will just backport the patch as it seems
> nobody really objects to it.

