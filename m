Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 811C3153AB9
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2020 23:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgBEWJy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Feb 2020 17:09:54 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51957 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727149AbgBEWJy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Feb 2020 17:09:54 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4DF8822036;
        Wed,  5 Feb 2020 17:09:53 -0500 (EST)
Received: from imap35 ([10.202.2.85])
  by compute6.internal (MEProxy); Wed, 05 Feb 2020 17:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=M/jRGgKo4zp3k5w+VbcBz7y+FHTFvxz
        lvCB1Sg9XZ7s=; b=P/LxswuAAv4rSvtTEe2vOi4iuBApSHXz6H1/5L+CEKtfQIG
        upN33ES5DpkwAnUs/sct4vqttabtZvCMv5d0pVMaovzpStZOG1IihfsJ1U6vLzTN
        5hvXcoD6sc9I5A9uYyLsCUv4E+FzStJHEAGSXI3F7PcppLp310W9alprE0JoXUYs
        5IL2kyHBNzZEdcc2IIQHXjo/QNFERe7CZ5hRhfWRC5mRovWsgkrsD4k3DdxAl1VE
        vBdT3gV0OXMmc8o6PmVCY9FVnHdfFDQ0A2naV/6tixKqnHhtBLEgySfWrvJFxAds
        p9MJd26QiVObLKf9UXQEZVV5D9kgZ5PEL2fAEug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=M/jRGg
        Ko4zp3k5w+VbcBz7y+FHTFvxzlvCB1Sg9XZ7s=; b=IgUSUobQw4o1ESW51VA1x/
        f8+oWbDKDAP5szXHsZrFXL0N95HVhEOxWRsg9prGckIwgHGF1AHZZ1TExlOkb1X5
        TY+HJzzSj2rMJdKuUkuckeLrkL7l4wwVaaWJKcb/udvo8FmLjA1U3cG8RTPon9fe
        lxk6/MM0dtvFvu0EW3c3Im6S8WHhnx0hU0ydKGavau66K4sXulgb03Fz+3ZNFY1k
        umhcntAafqv4f2yh+SW8AopYx4AUVogOvjOlc0wvvdUYtt0FspNXJdPgNENAp8R5
        gX4gEuZNQOylhTn2hc1lLKD3Sz18CPzHisE48jx4I8DUOCehevVpKJxYpEROMkNg
        ==
X-ME-Sender: <xms:MT07XukQLY_FD_Ft6hTMWfMyvtXshpao7ERZrxDmIn7Nn1CqczJfKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrhedugdduhedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnegfrhhlucfvnfffucdluddtmdenucfj
    ughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedftfhushhsvg
    hllhcuvehurhhrvgihfdcuoehruhhstghurhesrhhushhsvghllhdrtggtqeenucffohhm
    rghinhepghhoohhglhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprhhushgtuhhrsehruhhsshgvlhhlrdgttg
X-ME-Proxy: <xmx:MT07XsMfUNZre-Cv5x47_N9vgIQ_-aF6xnumnuHVEIfckHm8h3BKiQ>
    <xmx:MT07XhW4EOf83YjSpooWTlUEEKIK5G_j1l9DV8xFIEYHrVUhZcft9A>
    <xmx:MT07XltlfyPKkWJYi6bzaMrZKQADjnNtkRWR8uHVrBSZWZ-xmLBskw>
    <xmx:MT07XiwQvSRyt9O06QU3-Yq82d9PrVmwpNhgmRBE8to1s4M-4BIVJw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D4C3A14C00D4; Wed,  5 Feb 2020 17:09:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-802-g7a41c81-fmstable-20200203v1
Mime-Version: 1.0
Message-Id: <009fe3f5-7b27-46c4-90a7-ff97cbd8c931@www.fastmail.com>
In-Reply-To: <CAFd5g45eys-JoaW-sgnkjwysehe4oxUL1THNifc7+v1xkgSRww@mail.gmail.com>
References: <CAFd5g448555=dKFQMbjJ6G=tvtfF5oJgTtTgGx+38Ls3VqHo5g@mail.gmail.com>
 <20200205021428.8007-1-sj38.park@gmail.com>
 <CABVgOSmFAZN3KRYkHVg5bb-m-UorB7+9=f9vAqW2ECABzpa9zQ@mail.gmail.com>
 <CAFd5g45eys-JoaW-sgnkjwysehe4oxUL1THNifc7+v1xkgSRww@mail.gmail.com>
Date:   Thu, 06 Feb 2020 09:09:31 +1100
From:   "Russell Currey" <ruscur@russell.cc>
To:     "Brendan Higgins" <brendanhiggins@google.com>,
        "David Gow" <davidgow@google.com>
Cc:     "SeongJae Park" <sj38.park@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "KUnit Development" <kunit-dev@googlegroups.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "SeongJae Park" <sjpark@amazon.de>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Bjorn Helgaas" <bhelgaas@google.com>
Subject: =?UTF-8?Q?Re:_[PATCH]_kunit/kunit=5Fkernel:_Rebuild_.config_if_.kunitcon?=
 =?UTF-8?Q?fig_is_modified?=
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 6, 2020, at 7:00 AM, Brendan Higgins wrote:
> On Wed, Feb 5, 2020 at 9:58 AM David Gow <davidgow@google.com> wrote:
> >
> > One thing we'd like to do with kunit_tool is to make its functionality
> > a bit more independent: in particular, allowing the configuration,
> > running the kernel, and parsing the results to be done independently.
> >
> > If that's the case, it may make sense for "kunit.py run" or similar to
> > not do anything with the .config, and to relegate that to a separate
> > "configuration" step, which would allow someone to modify the
> > configuration themselves (e.g., using make menuconfig) and re-run the
> > tests, but also allow the config to be explicitly regenerated when
> > helpful.
> >
> > Exactly what that'd end up looking like (and to what extent we'd still
> > want to support a single command that'd do both) are still up in the
> > air: but I think a general "separation of concerns" like this is
> > probably the right path forward for kunit_tool.
> 
> You and I have talked about splitting up kunit_tool's functionality
> before. I agree with the idea.
> 
> I imagine it that we would have
> 
> - configuration
> - running tests
> - dmesg/TAP parsing
> 
> as separate runnable scripts. I think that would make it a lot easier
> for people with various test bed setups to reuse our code in their
> test harness.
> 
> Nevertheless, I think it would also be nice to have, as Ted has
> previously suggested, a short easy to remember one line command that
> just works; it is easily said, and much harder to do, but I think it
> is at odds with the separation of functionality. I guess one solution
> might just be to have these three separate tools, and then the classic
> kunit.py script that combines the functionalities in a single step, or
> as Ted suggested we could have some sort of default "make kunit"
> command or something like that. I am not really sure what is best
> here.
> 
> It doesn't address the problem of separation of functionality in
> anyway, but one way we could achieve the idea of having a command that
> just works, is by putting a line in MAINTAINERS file entries that have
> a command that a maintainer expects a submitter to run before sending
> a patch to LKML. That might at least make it possible to hack together
> a single line KUnit command for every relevant MAINTAINERS entry.
> (Obviously there is no reason we have to do this particular idea just
> for KUnit. We could do this for other tests as well.) Russel, I think
> this was your idea at LCA?

Hi Brendan, it wasn't me, it was someone in the audience during questions in my
testing talk.  I don't recall who.

They were suggesting a script like get_maintainers - i.e. get_tests - that for a
given file/patch/commit it gives you a suggested set of tests, whether that's
KUnit you can run there and then, or selftests you can run once it's booted,
or maybe external test suites that are relevant.

A single line in MAINTAINERS would probably sell that specific idea short,
but it's possibly the easiest and quickest way to get something going that
people would use.

- Russell

> 
> > On Tue, Feb 4, 2020 at 6:14 PM SeongJae Park <sj38.park@gmail.com> wrote:
> > >
> > > On Tue, 4 Feb 2020 16:46:06 -0800 Brendan Higgins <brendanhiggins@google.com> wrote:
> > >
> > > > Sorry for the delay.
> > > >
> > > > On Mon, Jan 27, 2020 at 10:03 PM SeongJae Park <sj38.park@gmail.com> wrote:
> > > > >
> > > > > On Mon, 27 Jan 2020 16:02:48 -0800 Brendan Higgins <brendanhiggins@google.com> wrote:
> > > > >
> > > > > > On Sat, Jan 25, 2020 at 5:59 PM <sj38.park@gmail.com> wrote:
> > > > > > >
> > > > > > > From: SeongJae Park <sjpark@amazon.de>
> > > > > > >
> > > > > > > Deletions of configs in the '.kunitconfig' is not applied because kunit
> > > > > > > rebuilds '.config' only if the '.config' is not a subset of the
> > > > > > > '.kunitconfig'. To allow the deletions to applied, this commit modifies
> > > > > > > the '.config' rebuild condition to addtionally check the modified times
> > > > > > > of those files.
> > > > > >
> > > > > > The reason it only checks that .kunitconfig is a subset of .config is
> > > > > > because we don't want the .kunitconfig to remove options just because
> > > > > > it doesn't recognize them.
> > > > > >
> > > > > > It runs `make ARCH=um olddefconfig` on the .config that it generates
> > > > > > from the .kunitconfig, and most of the time that means you will get a
> > > > > > .config with lots of things in it that aren't in the .kunitconfig.
> > > > > > Consequently, nothing should ever be deleted from the .config just
> > > > > > because it was deleted in the .kunitconfig (unless, of course, you
> > > > > > change a =y to a =n or # ... is not set), so I don't see what this
> > > > > > change would do.
> > > > > >
> > > > > > Can you maybe provide an example?
> > > > >
> > > > > Sorry for my insufficient explanation. I added a kunit test
> > > > > (SYSCTL_KUNIT_TEST) to '.kunitconfig', ran the added test, and then removed it
> > > > > from the file. However, '.config' is not generated again due to the condition
> > > > > and therefore the test still runs.
> > > > >
> > > > > For more detail:
> > > > >
> > > > > $ ./tools/testing/kunit/kunit.py run --defconfig --build_dir ../kunit.out/
> > > > > $ echo "CONFIG_SYSCTL_KUNIT_TEST=y" >> ../kunit.out/.kunitconfig
> > > > > $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
> > > > > $ sed -i '4d' ../kunit.out/.kunitconfig
> > > > > $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
> > > > >
> > > > > The 2nd line command adds sysctl kunit test and the 3rd line shows it runs the
> > > > > added test as expected. Because the default kunit config contains only 3
> > > > > lines, The 4th line command removes the sysctl kunit test from the
> > > > > .kunitconfig. However, the 5th line still run the test.
> > > > >
> > > > > This patch is for such cases. Of course, this might make more false positives
> > > > > but I believe it would not be a big problem because .config generation takes no
> > > > > long time. If I missed something, please let me know.
> > > >
> > > > I think I understand.
> > > >
> > > > It is intentional - currently - that KUnit doesn't generate a new
> > > > .config with every invocation. The reason is basically to support
> > > > interaction with other methods of generating .configs. Consider that
> > > > you might want to use make menuconfig to turn something on. It is a
> > > > pretty handy interface if you work on vastly different parts of the
> > > > kernel. Or maybe you have a defconfig that you always use for some
> > > > platform, I think it is easier to run
> > > >
> > > > make foo_config; tools/testing/kunit/kunit.py run
> > > >
> > > > Then having to maintain both your defconfig and a .kunitconfig which
> > > > is a superset of the defconfig.
> > > >
> > > > Your change would make it so that you have to have a .kunitconfig for
> > > > every test environment that you care about, and you could not as
> > > > easily take advantage of menuconfig.
> > >
> > > Thank you for this kind answer. Now I understood the intention and agree with
> > > that. :)
> > >
> > > >
> > > > I think what we do now is a bit janky, and the use cases I mentioned
> > > > are not super well supported. So I am sympathetic to what you are
> > > > trying to do, maybe we could have a config option for it?
> > > >
> > > > I think Ted and Bjorn might have opinions on this; they had some
> > > > related opinions in the past.
> > >
> > > I'm ok with current state, but if related discussions continue and my opinion
> > > is required, I will join in.
> > >
> > >
> > > Thanks,
> > > SeongJae Park
> > >
> > > >
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20200205021428.8007-1-sj38.park%40gmail.com.
>
