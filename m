Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5707319351D
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 01:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgCZAtu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Mar 2020 20:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727539AbgCZAtu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Mar 2020 20:49:50 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A59420714;
        Thu, 26 Mar 2020 00:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585183789;
        bh=7rLc8IKWjDGZOPL02QzrS+USTRjwCLbUdZevHtKiRDU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U/lPbhw/wVpEepyJvRrV+BsjnRnkD3OL+HDw5AJY0m3j4bd+hIA1AksaF3Cz/MKPq
         53pofo7EM+cl1gDbjO6U9JmV/2kI89t27d2J/W794Zeo5fQ5JW6Bhtejl8yZrs3e/Z
         WGZzsRDhacmTiCCFecCn8fQjpvhn1sMyeaZ0IUJA=
Date:   Wed, 25 Mar 2020 17:49:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Eric B Munson <emunson@akamai.com>
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
Message-Id: <20200325174949.95d8a9de61c6a30a7e0f4582@linux-foundation.org>
In-Reply-To: <20200324154910.GM23364@optiplex-lnx>
References: <CALvZod7LiMiK1JtfdvvU3W36cGSUKhhKf6dMZpsNZv6nMiJ5=g@mail.gmail.com>
        <20200323075208.GC7524@dhcp22.suse.cz>
        <20200323144240.GB23364@optiplex-lnx>
        <20200323145106.GM7524@dhcp22.suse.cz>
        <20200323150259.GD23364@optiplex-lnx>
        <20200323151256.GP7524@dhcp22.suse.cz>
        <20200323154159.GF23364@optiplex-lnx>
        <20200323155111.GQ7524@dhcp22.suse.cz>
        <20200323155449.GG23364@optiplex-lnx>
        <20200324154218.GS19542@dhcp22.suse.cz>
        <20200324154910.GM23364@optiplex-lnx>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 24 Mar 2020 11:49:10 -0400 Rafael Aquini <aquini@redhat.com> wrote:

> Thanks Michal!
> 
>  
> Acked-by: Rafael Aquini <aquini@redhat.com>

I'll add
Fixes: 9c4e6b1a7027f ("mm, mlock, vmscan: no more skipping pagevecs")
and cc:stable to this.  Any kernel which has 9c4e6b1a7027f will benefit
from this change.

We're getting quite late in the cycle now so I think I'll hold off
merging this up until post-5.7-rc1.  It will still get into the stable
trees, but a bit later.
