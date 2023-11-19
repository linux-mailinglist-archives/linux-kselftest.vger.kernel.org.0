Return-Path: <linux-kselftest+bounces-280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AEF7F0980
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Nov 2023 23:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF131C203BC
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Nov 2023 22:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDDE12B9F;
	Sun, 19 Nov 2023 22:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="hsz1c0Sf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C729E12D
	for <linux-kselftest@vger.kernel.org>; Sun, 19 Nov 2023 14:55:44 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-82-21.bstnma.fios.verizon.net [173.48.82.21])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3AJMsbEL032072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Nov 2023 17:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1700434481; bh=cvxrKU06XMRJ5gQInDe4mgPA1QhjOCnI1DlVNYsLak4=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=hsz1c0SfTpW0jGCJSgUBydQcigyA4uiF4VnwsEb2Pjt9fcdThq6w6aQB2j5kC/SkR
	 F6Dqjy+j2/baYG40e1rQI416xnYe3WZ4b9t+8/SqkU5F4VUNxCNAFfVsAaxONzW9u6
	 HJP5/2ZtdZ+RpZPiiuCjzMiysG4hNIoZ61eem6D51qrYsjqekgMFA121jK73B6u+bS
	 vaoC0J+hsCdFKtMLrefsb80Npts0LrMD8QmS+Dtx/ltZKmSP7e2nLNxo203NAJ0OUE
	 6AFuv6Aii6fs8u9DPTRi2t9RDpM3XVftBibZ6CVdZG9TwM14rUslJZnXTVo4LdJ0Pz
	 yEYAsEIxXfgiw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id A1D9815C02B0; Sun, 19 Nov 2023 17:54:37 -0500 (EST)
Date: Sun, 19 Nov 2023 17:54:37 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
        Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>,
        workflows@vger.kernel.org, Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, David Gow <davidgow@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Veronika Kabatova <vkabatov@redhat.com>, CKI <cki-project@redhat.com>,
        kernelci@lists.linux.dev, Chandan Babu R <chandanrlinux@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/3] MAINTAINERS: Require kvm-xfstests smoke for ext4
Message-ID: <20231119225437.GA292450@mit.edu>
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231115175146.9848-3-Nikolai.Kondrashov@redhat.com>
 <20231115185808.GD36211@frogsfrogsfrogs>
 <87v8a096cr.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8a096cr.fsf@debian-BULLSEYE-live-builder-AMD64>

On Fri, Nov 17, 2023 at 12:39:56PM +0530, Chandan Babu R wrote:
> IMHO, For XFS, The value of "V" field should refer to xfstests rather than a
> framework built around xfstests. This is because xfstests project contains the
> actual tests and also we could have several frameworks (e.g. Kdevops) for
> running xfstests.

For ext4, what I plan to do is to start requiring, in a soon-to-be
written:

	Documentation/process/maintainer-ext4.rst

that *all* patches (exempting spelling/grammer nits which only touch
comments and result in zero changes in the compiled .o file) will
require running the xfstests smoke test.  The prooblem is that for
newbie patch submitters, and for "drive-by" patches from, say, mm
developers, installing and configuring xfstests, and then figuring out
how to set up all of the config files, and/or environments variables,
before you get to running "./check -g smoke"P, is really f**king hard.

As far as other test frameworks are concerned, I suggest that you ask
a new college grad that your company has just hired, or a new intern,
or a new GSOC or Outreachy intern, to apply a patch to the upstream
linux tree --- given only the framework's documentation, and with
***no*** help from anyone who knows how to use the framework.  Just
sit on your hands, and try as best you can to keep your mouth
shut.... and wait.

I spent a lot of work to make the instructures here:

  https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md

easy enough that it meets this critera.  What should be in the V:
field for the MAINTAINERS field is less clear to me, because it's not
clear whether we want it to be Dead Stupid Easy for anyone capable of
creating a kernel patch can figure out how to run the tests.

My personal opinion is that for someone who running through the Kernel
Newbies' My First Kernel patch, to say, doing something trivial such
as changing "(a < b) ? a : b" to "min(a,b)" and then being able
compile kernel, and then be able to say, "it builds, ship it", and
then following the kernel documentation to send a patch upstream ---
the documentation and procedure necessary to do something better than
"it builds, ship it!" by that Kernel Newbie.

It's also my considered opinion that neither bare, upstream xfstests,
*nor* kdevops meets this criteria.  For example, kdevops may claim
that you only need a few commands:

     "make menuconfig"
     "make"
     "make bringup"
     "make linux"
     "make fstests"
     "make fstests-baseline"
     "make fstests-results"

... but to be honest, I never got past the 2nd step before *I* got
massively confused and decided there was better things to do with my
time.  First, the "make menuconfig" requires that you answer a whole
bunch of questions, and it's not clear how you are supposed to answer
them all.  Secondly "make" issues a huge number of cmomands, and then
fails because I didn't run them as root.  But I won't download random
git repositories and "make" as root.  It goes against the grain.  And
so after trying to figure out what it did, and whether or not it was
safe, I ultimetly gave up on it.

For upstream xfstests, ask a New College Grad fresh hire, or intern,
to read xfstests's README file, and ask them to set up xfstests,
without help.  Go ahead, I'll wait....

No doubt for someone who is willing to make a huge investment in time
to become a file system developer specializing in that subsystem, you
will eventually be able to figure it out.  And in the case of kdevops,
eventually I'd could set up my own VM, and install a kernel compile
toolchian, and all of kdevops's prequisits, and then run "make" and
"make linux" in that VM.  But that's a lot more than just "four
commands".

So as for *me*, I'm going to point people at:

https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md

because I've simplified a lot of things, up to and including have
kvm-xfstests automatically download the test appliance VM image from
kernel.org if necessary.  When it lists the handful of commands that
need to be run, it includes downloading all of the prequisit packages,
and there are no complex menu configuration steps, and doesn't require
running random make processes of Makefile and Makefile fragments as
root.

(And note that I keep the xfstests-bld repo's on kernel.org and
github.com both uptodate, and I prefer using the using the github.com
URL because it's easier for the new developer to read and understand
it.)

Ultimately, at least for my planned
Documentation/process/maintainer-ext4.rst, before I could make running
a smoke test mandatory, I needed to make sure that the quickstart
documentation for kvm-xfstests be made as simple and as fool-proof as
possible.  That was extremely important to me from a personal point
of view.

As far as what should go into Documentation/process/tests.rst, for
"kvm-xfstests smoke" this may depend on whether other file system
maintainers want to adopt something which is similarly simple for
first-time developers to run.

Also, I would assert that the proposed V: line in the Maintainer's
file does not mean that this is the only way to test the patch.  It is
just the minimal amount of testing that should be done, and using the
simplest test procedure that we would expect a non-subsystem developer
to be able to use.  It certainly wouldn't be the only way to run a
satisfactory amount of pre-submit testing.

For example, *I* wouldn't be using "kvm-xfstests smoke".  I'd be using
something like "gce-xfstests smoke", although that requires a bit more
setup.  Or I might do a much more substantive amount of testing, such
as "gce-xfstests ltm -c ext4/all -g auto".

Or I might establish a watch on a branch, via: "gce-xfstests ltm -c
ext4/all -g auto --repo https://github.com/tytso/ext4.git --watch
test", and then just push commits to the test branch.

And similarly, just because the V: line might say, "kvm-xfstests
smoke", someone could certainly use kdevops if they wanted to.  So
perhaps we need to be a bit clearer about what we expect the V: line
to mean?

Along these lines, we should perhaps be a bit more thoughtful about
the intended audience for Documentation/process/tests.rst.  I
personally wouldn't try ask first-time kernel developers to look at
the xfstests group files, because that's just way too complicated for
them.

And I had *assumed* that Documentation/process/tests.rst was not
primarily intended for sophistiocated file system developers who
wouldn't be afraid to start looking at the many ways that xfstests
could be configured.  But we should perhaps be a bit more explicit
about who the intended audience would be for a certain set up
Documentation files, since that will make it easier for us to come to
consensus about how that particular piece of documentation would be
worded.

As E.B. White (author of the book "The Elements of Style" was reputed
to have once said, "Always write with deep sympathy for the reader".
Which means we need to understand who the reader is, and to try to
walk in their shoes, first.

Cheers,

					- Ted

