Return-Path: <linux-kselftest+bounces-448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 245A47F4C1A
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 17:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB1C2812DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 16:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3F74C3DB;
	Wed, 22 Nov 2023 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="O5s/kfEe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81FD9A
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Nov 2023 08:16:42 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-82-21.bstnma.fios.verizon.net [173.48.82.21])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3AMGG29u017187
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Nov 2023 11:16:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1700669765; bh=Zpb9IO78HYak/yA/A/sCEkZ+iTdybo48cvv0F+iRIyc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=O5s/kfEe6iZVGWcJpy+nieIJ0eCSmxEhPoA5/vVEjXCLbfRVyAzfHuYFpfF8Xl5lZ
	 ZYSP+vR8l00tHjankBxCelKnekfYNOtrXR+/PYNBUjmgBdDXlSE00I3PtV8b8dpfe+
	 5dV558qZa1JuWIhgF1amPqpPHDHb5D3xye4nWkatceZMpY4Kx069erIZRkssbOAlbL
	 wktwhbL6605KCzVmOHRmHXXTO6Sc7CWjr9l7PTKKNivaxg2yrDpsZdjBe5iIwp8vgC
	 vbv2DeBX5FMPLYRlJmb7LfaadmOfydd9fWh9Krm8KzttsdjU6e73GgOJIW8z8I06pY
	 PMEYlyPmnqJ0g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 39EC015C02B0; Wed, 22 Nov 2023 11:16:02 -0500 (EST)
Date: Wed, 22 Nov 2023 11:16:02 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Mark Brown <broonie@kernel.org>
Cc: Ricardo =?iso-8859-1?Q?Ca=F1uelo?= <ricardo.canuelo@collabora.com>,
        Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>,
        workflows@vger.kernel.org, joe@perches.com, apw@canonical.com,
        davidgow@google.com, rostedt@goodmis.org, skhan@linuxfoundation.org,
        djwong@kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, vkabatov@redhat.com,
        cki-project@redhat.com, kernelci@lists.linux.dev
Subject: Re: [PATCH 1/3] MAINTAINERS: Introduce V: field for required tests
Message-ID: <20231122161602.GA337285@mit.edu>
References: <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com>
 <87sf50imba.fsf@collabora.com>
 <20231120205131.GA291888@mit.edu>
 <92c2f89d-f8a6-4260-b10d-671011cf1f70@sirena.org.uk>
 <20231121060450.GB335601@mit.edu>
 <5d69e9ef-e60c-4eb9-b067-5b44488dd8c9@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d69e9ef-e60c-4eb9-b067-5b44488dd8c9@sirena.org.uk>

On Tue, Nov 21, 2023 at 01:27:44PM +0000, Mark Brown wrote:
> > (I don't need to see all of the tests that passes; it's the test
> > failures or the test flakes that are significant.)
> 
> The listing of tests does get a bit more complex when you mix in running
> on different platforms.

Yeah, that's part of the aggregation reports problem.  Given a
particular test, say, generic/475, I'd love to see a summary of which
file system config (e.g., ext4/4k, ext4/1k) and which architectures a
particular test is failing or which is flaky.  Right now, I do this
manually using a combination of a mutt mail reader (the test summaries
are e-mailed to me), and emacs....

> I think if we get tooling in place so that people can just run a script,
> add a flag to their tools or whatever to ingest results from the
> standard testsuites the barrier to reporting becomes sufficiently low
> that it's more of a "why not?" type thing.

Sure, I'm happy to add something like that to my test runners:
kvm-xfstests, gce-xfstests, and android-xfstests.  Then anyone who
uses my test runner infrastructure would get uploading for free.  We
might need to debate whether I enable uploading as something which is
enabled by default or not (I can imagine some people won't wanting to
upload information to a public site, lest it leak information about an
upcoming mobile handset :-), but that's a minor point.

Personally, I'm not going to have time to look into this for a while,
but... patches welcome.  Or even something that takes a junit xml
file, and uploads it to the kcidb.  If someone can make something like
that available, I should be able to take it the rest of the way.

Cheers,

						- Ted

