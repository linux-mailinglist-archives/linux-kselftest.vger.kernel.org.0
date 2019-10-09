Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7584D1749
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2019 20:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbfJISEv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Oct 2019 14:04:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:58610 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728804AbfJISEv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Oct 2019 14:04:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6299AAF98;
        Wed,  9 Oct 2019 18:04:49 +0000 (UTC)
Date:   Wed, 9 Oct 2019 20:04:47 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Richard Palethorpe <richard.palethorpe@suse.com>,
        syzkaller <syzkaller@googlegroups.com>, kernelci@groups.io,
        shuah <shuah@kernel.org>, ltp@lists.linux.it,
        George Kennedy <george.kennedy@oracle.com>,
        Cyril Hrubis <chrubis@suse.com>,
        "open list : KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        automated-testing@yoctoproject.org
Subject: Re: [RFC PATCH] LTP Wrapper for Syzkaller reproducers
Message-ID: <20191009180447.GD15291@rei.lan>
References: <20191009142446.6997-1-rpalethorpe@suse.com>
 <CACT4Y+b0tTAQ0r_2gCVjjRh--Xwv=aLzh6MY=ciXMMrK+cAQsA@mail.gmail.com>
 <20191009145416.GA5014@rei.lan>
 <CACT4Y+ZL8ocQPpwR-_8+0PdF=r3AkFZKvOR==+P0y0GF67w1Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZL8ocQPpwR-_8+0PdF=r3AkFZKvOR==+P0y0GF67w1Vg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi!
> > Indeed, it's removed recursively by the test library.
> 
> :popcorn:
> 
> It took me several years to figure out how to more or less reliably
> remove dirs after the fuzzer ;)
> (no, unlink won't do ;))

I guess that there are things such as immutable file attributes that has
to be cleared and many more. Do you have piece of code somewhere that we
can look into to spare us from reinventing the wheel?

-- 
Cyril Hrubis
chrubis@suse.cz
