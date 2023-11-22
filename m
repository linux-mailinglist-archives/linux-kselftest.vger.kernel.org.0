Return-Path: <linux-kselftest+bounces-460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80657F51E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 21:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 324C6B20D3D
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 20:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B84D846B;
	Wed, 22 Nov 2023 20:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="eERjgB3s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78881112
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Nov 2023 12:51:47 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cf56e28465so1480865ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Nov 2023 12:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1700686307; x=1701291107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QDYyRLoiycUaY49QoLf26F930m6gNVp1RU3PlgGtl7M=;
        b=eERjgB3sh2hm3upFresTqzAHyiUxEGuZZ62OrpJkl095cpFA1GYlAE53MC6PsvAsV8
         6Ut0z2EsXM57RdECbRVT28bCZDG4UXCKcpVHQUhB/hYiRSouQ65gxmHp1nnJolRJLtwy
         MO8cBR42HRqBYTMseGGfpfyjUVnUZk+Ci90GLmOJaKbM7zpzCJ5IGXv1VlGRLTgGmttl
         sKSwefTFaYH55NOgeDF96nVKzXwWMfRBUZn2oO7Zd/c9714f1/pdRSbfKYeVyvOwBcos
         dgNBKY7DeJ+yn0GwXNTq6mXZQVzlmcAdqQldobbq9nem2zHtvkRo2OKJkvpS/4zZjDaX
         prLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700686307; x=1701291107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDYyRLoiycUaY49QoLf26F930m6gNVp1RU3PlgGtl7M=;
        b=aY/nwld8FgjuJnTll51ErQKj5XViHFRFsc0yA5V3p3x6X816ZuqNMvN3S0Nmd2Dcwc
         +2jg1s8EOxlyy69fIy7EVOh6FDUcnQu+O6dXalZYk86eXhJiSQAeRZyI9cyRRv5HsXKG
         AEiuwKhRrlSfCJNJrfQbWmMQYhtXhN3gmFhLq6lo4k274FfwOgDT+2rLd0J38NqeA/kf
         t9FtSI7Tu0NwRYMonhBQFOghPAMLszeomeKdMaOhyfzK5FsYGxhAxWJyh00EObxhSEif
         SczC/lv+asmL7QH+OgwKonFmz8VIp/E6znuIZYpFtBLk3hOG9DRzBOjIP9oFBFm/IeaX
         x9mw==
X-Gm-Message-State: AOJu0Yzba1npMdmZdJ1JksBsl26cyfdNNdoq26bzvcYX44PLRKZKJxre
	GOv6+wvGIHzDW/L1wFWHHHGVFA==
X-Google-Smtp-Source: AGHT+IE6oL5OBU3IwVHKwsZfJXYmwuWE0TSV4peQofShC5i+2wEn3Ehzw2AsBZVt3VWIgqiavzxf1g==
X-Received: by 2002:a17:902:8649:b0:1cc:e823:c8cc with SMTP id y9-20020a170902864900b001cce823c8ccmr3253781plt.41.1700686306783;
        Wed, 22 Nov 2023 12:51:46 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id z3-20020a170902ee0300b001cc2ebd2c2csm100557plb.256.2023.11.22.12.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 12:51:46 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1r5uCF-00G9zk-1o;
	Thu, 23 Nov 2023 07:51:43 +1100
Date: Thu, 23 Nov 2023 07:51:43 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Chandan Babu R <chandanbabu@kernel.org>, workflows@vger.kernel.org,
	Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
	David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	Veronika Kabatova <vkabatov@redhat.com>,
	CKI <cki-project@redhat.com>, kernelci@lists.linux.dev,
	Chandan Babu R <chandanrlinux@gmail.com>
Subject: Re: [PATCH 2/3] MAINTAINERS: Require kvm-xfstests smoke for ext4
Message-ID: <ZV5p32opqhX+wtfY@dread.disaster.area>
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231115175146.9848-3-Nikolai.Kondrashov@redhat.com>
 <20231115185808.GD36211@frogsfrogsfrogs>
 <87v8a096cr.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20231119225437.GA292450@mit.edu>
 <cd2d6ed9-7047-4090-ab44-16540f503087@redhat.com>
 <20231122161746.GM36211@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122161746.GM36211@frogsfrogsfrogs>

On Wed, Nov 22, 2023 at 08:17:46AM -0800, Darrick J. Wong wrote:
> On Wed, Nov 22, 2023 at 04:44:58PM +0200, Nikolai Kondrashov wrote:
> > On 11/20/23 00:54, Theodore Ts'o wrote:
> > > So as for *me*, I'm going to point people at:
> > > 
> > > https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
> > 
> > ...
> > 
> > > (And note that I keep the xfstests-bld repo's on kernel.org and
> > > github.com both uptodate, and I prefer using the using the github.com
> > > URL because it's easier for the new developer to read and understand
> > > it.)
> > 
> > I already queued a switch to the kernel.org URL, which Darrick has suggested.
> > I'll drop it now, but you guys would have to figure it out between yourselves,
> > which one you want :D
> > 
> > Personally, I agree that the one on GitHub is more reader-friendly, FWIW.
> 
> For xfstests-bld links, I'm ok with whichever domain Ted wants.
> 
> > > And similarly, just because the V: line might say, "kvm-xfstests
> > > smoke", someone could certainly use kdevops if they wanted to.  So
> > > perhaps we need to be a bit clearer about what we expect the V: line
> > > to mean?
> > 
> > I tried to handle some of that with the "subsets", so that you can run a wider
> > test suite and still pass the Tested-with: check. I think this has to be
> > balanced between allowing all the possible ways to run the tests and a
> > reasonable way to certify the commit was tested automatically.
> > 
> > E.g. name the test "xfstests", and list all the ways it can be executed, thus
> > communicating that it should still say "Tested-with: xfstests" regardless of
> > the way. And if there is a smaller required subset, name it just "xfstests
> > smoke" and list all the ways it can be run, including the simplest
> > "kvm-xfstests smoke", but accept just "Tested-with: xfstests-smoke".
> > 
> > I'm likely getting things wrong, but I hope you get what I'm trying to say.
> 
> Not entirely -- for drive-by contributions and obvious bugfixes, a quick
> "V: xfstests-bld: kvm-xfstests smoke" / "V: fstests: ./check -g smoke"
> run is probably sufficient.

For trivial drive-by contributions and obvious bug fixes, I think
this is an unnecessary burden on these potential contributors. If
it's trivial, then there's little burden on the reviewer/maintainer
to actually test it, whilst there is significant burden on the
one-off contributor to set up an entirely new, unfamiliar testing
environment just to fix something trivial.

If you want every patch tested, the follow the lead of the btrfs
developers: set up a CI mechanism on github and ask people to submit
changes there first and then provide a link to the successful test
completion ticket with the patch submission.

> (Insofar as n00bs running ./check isn't sufficient, but that's something
> that fstests needs to solve...)
> 
> For nontrivial code tidying, the author really ought to run the whole
> test suite.  It's still an open question as to whether xfs tidying
> should run the full fuzz suite too, since that increases the runtime
> from overnightish to a week.

Yes, the auto group tests should be run before non-trivial patch
sets are submitted. That is the entire premise of the the auto group
existing - it's the set of regression tests we expect to pass for
any change.

However, the full on disk format fuzz tests should not be required
to be run. Asking people to run tests that take a week for general
cleanups and code quality improvements is just crazy talk - the
cost-benefit equation is all out of whack here, especially if the
changes have no interaction with the on-disk format at all.

IMO, extensive fuzz testing is something that should be done
post-integration - requiring individual developers to run
tests that take at least a week to run before they can submit a
patchset for review/inclusion is an excessive burden, and we don't
need every developer to run such tests every time they do something
even slightly non-trivial.

It is the job of the release manager to co-ordinate with the testing
resources to run extensive, long running tests after code has been
integrated into the tree. Forcing individual developers to run this
sort of testing just isn't an efficient use of resources....

> For /new features/, the developer(s) ought to come up with a testing
> plan and run that by the community.  Eventually those will merge into
> fstests or ktest or wherever.

That's how it already works, isn't it?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

