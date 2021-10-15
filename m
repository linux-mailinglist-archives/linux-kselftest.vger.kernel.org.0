Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2513D42FC27
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Oct 2021 21:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238479AbhJOTb1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Oct 2021 15:31:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235265AbhJOTbW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Oct 2021 15:31:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB9A461151;
        Fri, 15 Oct 2021 19:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1634326156;
        bh=3JS/1kbwClvIz4bw9kp2a/P9fTD2/8UbJaeK5lJxnkE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DsnBwVbi/py5VyDgLutJnKvgeqNbFgDvx0Zz4vICvFjeLGosgjY4Ycv+xb7CRY8Sr
         AMAD0Rjun8jZyoTyj+OTinSaI029/rK6FHalqQJkQ/RiEOTLVWUCRxfnTJU9DXo8dw
         Hxb+Z6cuMsUwa2c7cyJKBOdFFPQupnhIBj7roG6s=
Date:   Fri, 15 Oct 2021 12:29:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "George G. Davis" <george_davis@mentor.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        "George G. Davis" <davis.george@siemens.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>
Subject: Re: [RFC][PATCH] selftests/vm/transhuge-stress: fix ram size thinko
Message-Id: <20211015122912.d42e5a8c41d623b544f7dd38@linux-foundation.org>
In-Reply-To: <41be8425-761b-fa55-40c5-687b397e8ad2@linuxfoundation.org>
References: <20210825135843.29052-1-george_davis@mentor.com>
        <41be8425-761b-fa55-40c5-687b397e8ad2@linuxfoundation.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 15 Oct 2021 09:38:24 -0600 Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 8/25/21 7:58 AM, George G. Davis wrote:
> > From: "George G. Davis" <davis.george@siemens.com>
> > 
> > When executing transhuge-stress with an argument to specify the virtual
> > memory size for testing, the ram size is reported as 0, e.g.
> > 
> > transhuge-stress 384
> > thp-mmap: allocate 192 transhuge pages, using 384 MiB virtual memory and 0 MiB of ram
> > thp-mmap: 0.184 s/loop, 0.957 ms/page,   2090.265 MiB/s  192 succeed,    0 failed
> > 
> > This appears to be due to a thinko in commit 0085d61fe05e
> > ("selftests/vm/transhuge-stress: stress test for memory compaction"),
> > where, at a guess, the intent was to base "xyz MiB of ram" on `ram`
> > size. Here are results after using `ram` size:
> > 
> > thp-mmap: allocate 192 transhuge pages, using 384 MiB virtual memory and 14 MiB of ram
> > 
> > Fixes: 0085d61fe05e ("selftests/vm/transhuge-stress: stress test for memory compaction")
> > Signed-off-by: George G. Davis <davis.george@siemens.com>
> > ---
> >   tools/testing/selftests/vm/transhuge-stress.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/vm/transhuge-stress.c b/tools/testing/selftests/vm/transhuge-stress.c
> > index fd7f1b4a96f9..5e4c036f6ad3 100644
> > --- a/tools/testing/selftests/vm/transhuge-stress.c
> > +++ b/tools/testing/selftests/vm/transhuge-stress.c
> > @@ -79,7 +79,7 @@ int main(int argc, char **argv)
> >   
> >   	warnx("allocate %zd transhuge pages, using %zd MiB virtual memory"
> >   	      " and %zd MiB of ram", len >> HPAGE_SHIFT, len >> 20,
> > -	      len >> (20 + HPAGE_SHIFT - PAGE_SHIFT - 1));
> > +	      ram >> (20 + HPAGE_SHIFT - PAGE_SHIFT - 1));
> >   
> >   	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
> >   	if (pagemap_fd < 0)
> > 
> 
> Sorry for the delay on this. The change looks good to me.

Konstantin, coould you please take a look?

> Andrew! Would you like me to take this through kselftest tree?

Is OK thanks - I'll add it to my mm/thp pile.
