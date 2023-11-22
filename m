Return-Path: <linux-kselftest+bounces-449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E516D7F4C21
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 17:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217FD1C20905
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 16:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93374F217;
	Wed, 22 Nov 2023 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpXvkImM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867684E62A;
	Wed, 22 Nov 2023 16:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021C0C433C8;
	Wed, 22 Nov 2023 16:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700669867;
	bh=UpD4e/I8Zz6b/VWIxbOcqcLscbNyirrOzlgTEYRycgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VpXvkImMUFw0QQSx6yQ5lwTpAvlrk38ZOZQM2pchOZmATZeJ1ETiKj7XhxfnpKEIk
	 Miw3smY3Nkols8NqOw2AFvixI5sZGpmDRUVpiUU9IEk44y3dRLbeaSr2saZsYek5Ce
	 +ZVzhaVpFj3zSfUNVgrhhi+0CfBM66IX8kXZnBfDd2vPsiiBCJtr6YmUYTlEEfbWCc
	 8THK4MPORrjh5iiehTDtsw7QpM3AlFY0RjFOV3FcW77C5wP3GKv871AF9+X2mGISDU
	 T/GrvMOgdy0FQJQAnf3eboqDthGncFk2uekzglYtRWE4Sv36crAnX8rG3eOJJMbZUf
	 XluNde0t5kzBw==
Date: Wed, 22 Nov 2023 08:17:46 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Chandan Babu R <chandanbabu@kernel.org>,
	workflows@vger.kernel.org, Joe Perches <joe@perches.com>,
	Andy Whitcroft <apw@canonical.com>, David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	Veronika Kabatova <vkabatov@redhat.com>,
	CKI <cki-project@redhat.com>, kernelci@lists.linux.dev,
	Chandan Babu R <chandanrlinux@gmail.com>,
	Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/3] MAINTAINERS: Require kvm-xfstests smoke for ext4
Message-ID: <20231122161746.GM36211@frogsfrogsfrogs>
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231115175146.9848-3-Nikolai.Kondrashov@redhat.com>
 <20231115185808.GD36211@frogsfrogsfrogs>
 <87v8a096cr.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20231119225437.GA292450@mit.edu>
 <cd2d6ed9-7047-4090-ab44-16540f503087@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd2d6ed9-7047-4090-ab44-16540f503087@redhat.com>

On Wed, Nov 22, 2023 at 04:44:58PM +0200, Nikolai Kondrashov wrote:
> On 11/20/23 00:54, Theodore Ts'o wrote:
> > So as for *me*, I'm going to point people at:
> > 
> > https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
> 
> ...
> 
> > (And note that I keep the xfstests-bld repo's on kernel.org and
> > github.com both uptodate, and I prefer using the using the github.com
> > URL because it's easier for the new developer to read and understand
> > it.)
> 
> I already queued a switch to the kernel.org URL, which Darrick has suggested.
> I'll drop it now, but you guys would have to figure it out between yourselves,
> which one you want :D
> 
> Personally, I agree that the one on GitHub is more reader-friendly, FWIW.

For xfstests-bld links, I'm ok with whichever domain Ted wants.

> > And similarly, just because the V: line might say, "kvm-xfstests
> > smoke", someone could certainly use kdevops if they wanted to.  So
> > perhaps we need to be a bit clearer about what we expect the V: line
> > to mean?
> 
> I tried to handle some of that with the "subsets", so that you can run a wider
> test suite and still pass the Tested-with: check. I think this has to be
> balanced between allowing all the possible ways to run the tests and a
> reasonable way to certify the commit was tested automatically.
> 
> E.g. name the test "xfstests", and list all the ways it can be executed, thus
> communicating that it should still say "Tested-with: xfstests" regardless of
> the way. And if there is a smaller required subset, name it just "xfstests
> smoke" and list all the ways it can be run, including the simplest
> "kvm-xfstests smoke", but accept just "Tested-with: xfstests-smoke".
> 
> I'm likely getting things wrong, but I hope you get what I'm trying to say.

Not entirely -- for drive-by contributions and obvious bugfixes, a quick
"V: xfstests-bld: kvm-xfstests smoke" / "V: fstests: ./check -g smoke"
run is probably sufficient.

(Insofar as n00bs running ./check isn't sufficient, but that's something
that fstests needs to solve...)

For nontrivial code tidying, the author really ought to run the whole
test suite.  It's still an open question as to whether xfs tidying
should run the full fuzz suite too, since that increases the runtime
from overnightish to a week.

For /new features/, the developer(s) ought to come up with a testing
plan and run that by the community.  Eventually those will merge into
fstests or ktest or wherever.

--D

> > Along these lines, we should perhaps be a bit more thoughtful about
> > the intended audience for Documentation/process/tests.rst.  I
> > personally wouldn't try ask first-time kernel developers to look at
> > the xfstests group files, because that's just way too complicated for
> > them.
> > 
> > And I had *assumed* that Documentation/process/tests.rst was not
> > primarily intended for sophistiocated file system developers who
> > wouldn't be afraid to start looking at the many ways that xfstests
> > could be configured.  But we should perhaps be a bit more explicit
> > about who the intended audience would be for a certain set up
> > Documentation files, since that will make it easier for us to come to
> > consensus about how that particular piece of documentation would be
> > worded.
> > 
> > As E.B. White (author of the book "The Elements of Style" was reputed
> > to have once said, "Always write with deep sympathy for the reader".
> > Which means we need to understand who the reader is, and to try to
> > walk in their shoes, first.
> 
> Amen to that! Apart from the newbies and just people working on other
> subsystems, we should also remember to be kinder to ourselves and keep our own
> tools easier to use. So perhaps just say "newbies should be able to follow
> tests.rst", and enjoy it :D
> 
> Ultimately, I think the (admittedly elusive) target should be the ability to
> just plop a command line into every V: entry, running something from the tree
> itself. Meanwhile, we would need the stepping stone of tests.rst, or something
> like that, to walk people through whatever setup is required.
> 
> I'll see how we can accommodate the commands in the V: directly, though.
> 
> Nick
> 

