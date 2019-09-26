Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34F42BF35E
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2019 14:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfIZMv6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Sep 2019 08:51:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:39886 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbfIZMv6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Sep 2019 08:51:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A87C0ABCE;
        Thu, 26 Sep 2019 12:51:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 388BDDA8E5; Thu, 26 Sep 2019 14:52:14 +0200 (CEST)
Date:   Thu, 26 Sep 2019 14:52:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc1
Message-ID: <20190926125213.GO2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <be8059f4-8e8f-cd18-0978-a9c861f6396b@linuxfoundation.org>
 <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com>
 <CAKRRn-edxk9Du70A27V=d3Na73fh=fVvGEVsQRGROrQm05YRrA@mail.gmail.com>
 <CAFd5g45ROPm-1SD5cD772gqESaP3D8RbBhSiJXZzbaA+2hFdHA@mail.gmail.com>
 <CAHk-=wgMuNLBhJR_nFHrpViHbz2ErQ-fJV6B9o0+wym+Wk+r0w@mail.gmail.com>
 <20190922112555.GB122003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190922112555.GB122003@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Sep 22, 2019 at 01:25:55PM +0200, Ingo Molnar wrote:
> 
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Fri, Sep 20, 2019 at 9:35 AM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > Sorry about that. I am surprised that none of the other reviewers
> > > brought this up.
> > 
> > I think I'm "special".
> > 
> > There was some other similar change a few years ago, which I
> > absolutely hated because of how it broke autocomplete for me. Very few
> > other people seemed to react to it.
> 
> FWIW, I am obsessively sensitive to autocomplete and overall source code 
> file hieararchy and nomenclature details as well, so it's not just you.
> 
> Beyond the muscle memory aspect, nonsensical naming and inanely flat file 
> hierarchies annoy kernel developers and makes it harder for newbies to 
> understand the kernel source as well.
> 
> The less clutter, the more organization, the better - and there's very 
> few valid technical reasons to add any new files or directories to the 
> top level directory - we should probably *remove* quite a few.
> 
> For example 'firmware/' was recently moved to drivers/firmware/, and in a 
> similar fashion about a third of the remaining 22 directories should 
> probably be moved too:
> 
>   drwxr-xr-x    arch
>   drwxr-xr-x    block
>   drwxr-xr-x    certs           # move to build/certs/ dir
>   drwxr-xr-x    crypto          # move to kernel/crypto/ or security/crypto/

For code with lots of history and active development, moving is quite
counterproductive as it makes tracking a change tedious. Git can follow
the path changes, but that's exactly the step I'd like not to do. That's
similar to pure whitespace cleanup patches that are noise.

The decision for move should be IMO up to the maintainers of the code,
that apparently worked for firmware/ -> drivers/firmware that has been
mentioned.  That's fine.

The muscle memory argument sounds quite weak to me, each of us has some
habits, editor settings and coding style preferences, we will never
agree. That's fine too.

The reason I'd find valid for moving is to reduce confusion when working
with the files, not to promote a "formally correct classification" and
hierarchy of directories that will stand in the way in the daily work.

Though I'm not directly affected by most of the proposed changes, I feel
I should speak up before the file maneuvers reach code I care about.

>  - 'block' could in principle move to drivers/block/core/ but it's fine 
>    at the top level too I think.

Following that principle, we can move mm/ -> drivers/char/memory/ right? :)
