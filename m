Return-Path: <linux-kselftest+bounces-12344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB9F910D34
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 18:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11551281EF8
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 16:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F891B47AF;
	Thu, 20 Jun 2024 16:36:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1071AF6B5;
	Thu, 20 Jun 2024 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901408; cv=none; b=UfCyrUk8sLKthRizpaK4Yp++95c1tMZYyzq/G28qqaeDKbQFsv2SI0OXcOFnqWlSqe89VQrRjjU/Q9p1+sZHmk7bHLIP8ChbBfhZoxNJjhsWguV25YxYbYosiXKyisBljOnipLEQM1MU3jxX3Qn0uAQC6R1r4Jy85ODDzO80yFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901408; c=relaxed/simple;
	bh=/FB2RUdre/ZjOda/nl0rOq4y08iAj3AOWo2+O5PRaVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRLKFzGoyAIvBpHn1fZjkHEIJEAkYvfJ8K//ioDp6qhn/4NWrd1tkF3iQIWDeww/h7md7hmkLkzCn1qYnmonXwQYH+NZc2mrUycG/VaQgmWX6qrlNwKnfhZvTdVBhZcjAHIpyF7+2Ho6j6mdbA5GnHor0KpJP5sykLCNXKuzXkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 45KGWaQr029678;
	Thu, 20 Jun 2024 11:32:36 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 45KGWYJi029676;
	Thu, 20 Jun 2024 11:32:34 -0500
Date: Thu, 20 Jun 2024 11:32:34 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Paul Moore <paul@paul-moore.com>, corbet@lwn.net, jmorris@namei.org,
        serge@hallyn.com, akpm@linux-foundation.org, shuah@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        mic@digikod.net, linux-security-module@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        linux-integrity@vger.kernel.org, wufan@linux.microsoft.com,
        pbrobinson@gmail.com, zbyszek@in.waw.pl, hch@lst.de,
        mjg59@srcf.ucam.org, pmatilai@redhat.com, jannh@google.com,
        dhowells@redhat.com, jikos@kernel.org, mkoutny@suse.com,
        ppavlu@suse.com, petr.vorel@gmail.com, mzerqung@0pointer.de,
        kgold@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v4 00/14] security: digest_cache LSM
Message-ID: <20240620163234.GA27816@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com> <CAHC9VhTs8p1nTUXXea2JmF0FCEU6w39gwQRMtwACqM=+EBj1jw@mail.gmail.com> <7cf03a6ba8dbf212623aab2dea3dac39482e8695.camel@huaweicloud.com> <CAHC9VhSCw6RweTs6whAu4v6t4n7gxUWJtjmzY-UXrdzW0H+YJA@mail.gmail.com> <520d2dc2ff0091335a280a877fa9eb004af14309.camel@huaweicloud.com> <CAHC9VhRD1kBwqtkF+_cxCUCeNPp+0PAiNP-rG06me6gRQyYcyg@mail.gmail.com> <2b335bdd5c20878e0366dcf6b62d14f73c2251de.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b335bdd5c20878e0366dcf6b62d14f73c2251de.camel@huaweicloud.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 20 Jun 2024 11:32:36 -0500 (CDT)

On Wed, Jun 19, 2024 at 06:37:49PM +0200, Roberto Sassu wrote:

Good morning Roberto, I hope your week is going well, greetings to
everyone copied else as well.

> On Wed, 2024-06-19 at 12:34 -0400, Paul Moore wrote:
> > On Wed, Jun 19, 2024 at 11:55???AM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > On Wed, 2024-06-19 at 11:49 -0400, Paul Moore wrote:
> > > > On Wed, Jun 19, 2024 at 3:59???AM Roberto Sassu
> > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > On Tue, 2024-06-18 at 19:20 -0400, Paul Moore wrote:
> > > > > > On Mon, Apr 15, 2024 at 10:25???AM Roberto Sassu
> > > > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > > > 
> > > > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > > 
> > > > > > > Integrity detection and protection has long been a desirable feature, to
> > > > > > > reach a large user base and mitigate the risk of flaws in the software
> > > > > > > and attacks.
> > > > > > > 
> > > > > > > However, while solutions exist, they struggle to reach the large user
> > > > > > > base, due to requiring higher than desired constraints on performance,
> > > > > > > flexibility and configurability, that only security conscious people are
> > > > > > > willing to accept.
> > > > > > > 
> > > > > > > This is where the new digest_cache LSM comes into play, it offers
> > > > > > > additional support for new and existing integrity solutions, to make
> > > > > > > them faster and easier to deploy.
> > > > > > > 
> > > > > > > The full documentation with the motivation and the solution details can be
> > > > > > > found in patch 14.
> > > > > > > 
> > > > > > > The IMA integration patch set will be introduced separately. Also a PoC
> > > > > > > based on the current version of IPE can be provided.
> > > > > > 
> > > > > > I'm not sure we want to implement a cache as a LSM.  I'm sure it would
> > > > > > work, but historically LSMs have provided some form of access control,
> > > > > > measurement, or other traditional security service.  A digest cache,
> > > > > > while potentially useful for a variety of security related
> > > > > > applications, is not a security service by itself, it is simply a file
> > > > > > digest storage mechanism.
> > > > > 
> > > > > Uhm, currently the digest_cache LSM is heavily based on the LSM
> > > > > infrastructure:
> > > > 
> > > > I understand that, but as I said previously, I don't believe that we
> > > > want to support a LSM which exists solely to provide a file digest
> > > > cache.  LSMs should be based around the idea of some type of access
> > > > control, security monitoring, etc.
> > > > 
> > > > Including a file digest cache in IMA, or implementing it as a
> > > > standalone piece of kernel functionality, are still options.  If you
> > > > want to pursue this, I would suggest that including the digest cache
> > > > as part of IMA would be the easier of the two options; if it proves to
> > > > be generally useful outside of IMA, it can always be abstracted out to
> > > > a general kernel module/subsystem.
> > > 
> > > Ok. I thought about IPE and eBPF as potential users. But if you think
> > > that adding as part of IMA would be easier, I could try to pursue that.
> > 
> > It isn't clear to me how this would interact with IPE and/or eBPF, but
> > if you believe there is value there I would encourage you to work with
> > those subsystem maintainers.  If the consensus is that a general file
> > digest cache is useful then you should pursue the digest cache as a
> > kernel subsystem, just not a LSM.

> Making it a kernel subsystem would likely mean replicating what the LSM
> infrastructure is doing, inode (security) blob and being notified about
> file/directory changes.
> 
> I guess I will go for the IMA route...

This thread brings up an issue that we have been thinking about but
has been on the back burner.

Roberto, I'm assuming you have seen our TSEM submissions go by.  Our
V4 release will be immediately after the Fourth of July holiday week
here in the states.

Since TSEM implements a generic security modeling framework for the
kernel, it ends up implementing a superset of IMA functionality.  That
required us to implement our own file digest generation and cacheing
infrastructure.

Given the trajectory that things are on with respect to security,
there is only going to be more demand for file digests and their
associated cacheing.  Doesn't seem like it makes a lot of sense to
have multiple teams replicating what is largely the same
functionality.

If your group would have interest, we would certainly be willing to
entertain conversations on how we could collaborate to brew up
something that would be of mutual benefit to everyone who has a need
for this type of infrastructure.

As you noted, consumers of the BPF LSM would also be a clear candidate
for generic infrastructure.  One of the issues blocking a BPF based
integrity implementation is that BPF itself is not going to be able
generate digests on its own.  So it would seem to make sense to have
whatever gets built have a kfunc accessible API.  Plenty of other
additional warts on that front as well but getting access to digests
is the necessary starting point.

Given what we have seen with IMA's challenge with respect to overlayfs
issues and file versioning issues in general, it would seem to be of
profit to have all these issues addressed uniformally and in one
place.

Since virtually everything that is accessing this infrastructure is
going to be an LSM, we would envision API's out of a common
infrastructure, invoked by the event handlers of the various LSM's
interested in integrity information, driving the cache generation and
maintenance.  That would seem to have all of the benefits of being
implemented by the LSM infrastructure without necessarily being an
'LSM' in and of itself.

We assume that everyone would want to maintain the O(1) lookup
characteristics of what the LSM inode blob mechanism provides.  We
would presume that a common cacheing architecture would return a
pointer to the structure that the digest cache maintains describing
the various digests associated with the contents of a file, as there
will be a need for multiple digest support, when an LSM hands the
cache an inode referencing a file.  An LSM could then place that
pointer in its own inode blob for future reference.

Either that, probably better, stick a pointer into the inode structure
itself that references it's digest cache object and it would get
populated by the first event that opens the associated file.

> Roberto

So an open invitation to anyone that would want to discuss
requirements around a common implementation.

Have a good weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

