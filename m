Return-Path: <linux-kselftest+bounces-18038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1238F979F7F
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 12:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDABE284F83
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 10:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2558A154444;
	Mon, 16 Sep 2024 10:36:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC7E15445E;
	Mon, 16 Sep 2024 10:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726483010; cv=none; b=tpV1/h/hnn/WZgiaykUL/lqHKvDY/il2vwEBR5oTz8c3QQa3ed3/wqQDEKIZqMOh3lKOkBjc9EaFqJ56Y0BQEL5y5IEgnzavIjC2+8XMnnEcddjqTMZhzgkI2XnqHvTL+ChBHA1yMvJiGadqg+r1H4RIXwKcAkaQOcQLPjM/1qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726483010; c=relaxed/simple;
	bh=OQzx1VY3FA53WmYJxavNHFf3H1NYy38Zj5pmYpMWFGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFlLS2XakK9Af6Np703XWd63O64MN62RmpTdB5Ia3+ZlAI6u1RtWFYEcnv6+ahzYtnkekZbvJRp6HZ5X5TZQHlQCX60+CZb1eIB2w4ZHspB9BL803N3928sg4KaH39fLivBrnV4GtB/BKHNHtZmIIulCvJFixHFeYcXLGEaedvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 48GA5wMY005315;
	Mon, 16 Sep 2024 05:05:58 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 48GA5plc005314;
	Mon, 16 Sep 2024 05:05:51 -0500
Date: Mon, 16 Sep 2024 05:05:51 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        corbet@lwn.net, akpm@linux-foundation.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, wufan@linux.microsoft.com,
        pbrobinson@gmail.com, zbyszek@in.waw.pl, hch@lst.de,
        mjg59@srcf.ucam.org, pmatilai@redhat.com, jannh@google.com,
        dhowells@redhat.com, jikos@kernel.org, mkoutny@suse.com,
        ppavlu@suse.com, petr.vorel@gmail.com, mzerqung@0pointer.de,
        kgold@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v5 00/14] integrity: Introduce the Integrity Digest Cache
Message-ID: <20240916100551.GA5059@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240905150543.3766895-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905150543.3766895-1-roberto.sassu@huaweicloud.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Mon, 16 Sep 2024 05:05:58 -0500 (CDT)

On Thu, Sep 05, 2024 at 05:05:29PM +0200, Roberto Sassu wrote:

Good morning, I hope the week is starting well for everyone

Apologies for the delay in getting these thoughts out, scrambling to
catch up on my e-mail backlog.

I looped Linus in, secondary to the conversations surrounding the PGP
verification infrastructure in the kernel, given that the primary use
case at this time appears to be the digest cache and his concerns
regarding that use.

Our proposed TSEM LSM, most recent submission here:

https://lore.kernel.org/linux-security-module/20240826103728.3378-1-greg@enjellic.com/T/#t

Is a superset of IMA functionality and depends heavily on file
checksums, hence our interest and reflections in your efforts with
this.

> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Integrity detection and protection has long been a desirable feature, to
> reach a large user base and mitigate the risk of flaws in the software
> and attacks.
> 
> However, while solutions exist, they struggle to reach a large user base,
> due to requiring higher than desired constraints on performance,
> flexibility and configurability, that only security conscious people are
> willing to accept.

No argument here, inherent in better and more effective security
architectures is better useability, pure and simple.

> For example, IMA measurement requires the target platform to collect
> integrity measurements, and to protect them with the TPM, which
> introduces a noticeable overhead (up to 10x slower in a
> microbenchmark) on frequently used system calls, like the open().

The future for trusted systems will not be in TPM's, as unpopular a
notion as that may be in some circles.  They represent a design from a
quarter century ago that struggles to have relevance with our current
system architectures.

If a TPM is present, TSEM will extend the security coefficients for
the root modeling namespace into a PCR to establish a root of trust
that the rest of the trust orchestration system can be built on.  Ours
is a worst case scenario beyond IMA since there is a coefficient
generated for each LSM call that is being modeled.

We had to go to asynchronous updates through an ordered workqueue in
order to have something less than abysmal performance, even with
vTPM's running in a Xen hypervisor domain.  This is without the
current performance impacts being discussed with respect to HMAC based
TPM session authentication.

> IMA Appraisal currently requires individual files to be signed and
> verified, and Linux distributions to rebuild all packages to include
> file signatures (this approach has been adopted from Fedora
> 39+). Like a TPM, also signature verification introduces a
> significant overhead, especially if it is used to check the
> integrity of many files.
>
> This is where the new Integrity Digest Cache comes into play, it
> offers additional support for new and existing integrity solutions,
> to make them faster and easier to deploy.
>
> The Integrity Digest Cache can help IMA to reduce the number of TPM
> operations and to make them happen in a deterministic way. If IMA
> knows that a file comes from a Linux distribution, it can measure
> files in a different way: measure the list of digests coming from
> the distribution (e.g. RPM package headers), and subsequently
> measure a file if it is not found in that list.
>
> The performance improvement comes at the cost of IMA not reporting
> which files from installed packages were accessed, and in which
> temporal sequence. This approach might not be suitable for all use
> cases.

That, in and of itself, is certainly not the end of the world.

With TSEM we offer the notion of the 'state' of a security namespace,
which is the extension sum of the security coefficients after they
have been sorted in natural (big-endian) hash order.  In this model
you know what files have been accessed but you do not have a statement
on temporal ordering of access.

Given scheduling artifacts, let alone the almost absolute ubiquity of
multi-core, the simple TPM/TCG linear extension model seems to
struggle with respect to any relevancy as a security metric.

> The Integrity Digest Cache can also help IMA for appraisal. IMA can simply
> lookup the calculated digest of an accessed file in the list of digests
> extracted from package headers, after verifying the header signature. It is
> sufficient to verify only one signature for all files in the package, as
> opposed to verifying a signature for each file.
> 
> The same approach can be followed by other LSMs, such as Integrity Policy
> Enforcement (IPE), and BPF LSM.

As we've noted above, TSEM would also be a potential consumer, which
is why we wanted to seek clarifications on the architecture.

We've reviewed the patch set and the documentation, and will freely
admit that we may still misunderstand all of this, but it would seem
that the architecture, as it stands, would be subject to Time Of
Measurement Time Of Use (TOMTOU) challenges.

The Time Of Measurement will be when the distribution generates an
RPM, or equivalent construct, ie. .deb, and signs the digest list with
their packaging key.  What is elusive to us is how can their be an
expectation that the file, on medium, when accessed (Time Of Use),
matches the digest of the file that was signed by the distribution?

At a minimum, there would seem to be a need to have the kernel read
and validate the on medium checksum of the file, as the in-kernel RPM
parser reads each signature from the package list.  At that point, as
long as the kernel is running, the digest cache will represent a valid
statement on the cryptographic checksum of a file held in the digest
cache, as your patch series seem to have invalidation support well in
hand.

After a system reboot, it would seem to be that all bets are off, and
from a security perspective, there would be a need to re-verify that
the on medium file checksums match those from a signed digest list.
IMA has the ability to do protection against offline modification but
you are then back to a possibly expensive operation on each file
access.

We see in the thread on PGP infrastructure in the kernel you make the
following statement:

"If the calculated digest of a file being accessed matches one
extracted from the RPM header, access is granted otherwise it is
denied."

Which would seem to imply that you do compute the on-medium checksum
of each file and verify it against a reference value from the RPM
header, but it isn't clear where that happens in the patch series.
The only kernel based file read operation we could find is what
appears to be a call to read the digest list files.

IMA already has the concept of a digest cache, as does TSEM.  If you
need to read a file in order to match its medium based checksum
against the value from a package list, in order to avoid a TOMTOU
condition, it is unclear how one gains a performance improvement.
Unless of course the objective is to prime the digest cache at boot so
that all subsequent integrity verifications are answered from cache
rather than by computing the checksum at file access time.

In the thread on PGP access you indicate that all of this needs to be
in the kernel in order to be tamper proof.  FWIW, the kernel has the
ability to know if kernel + userspace should be trusted at any given
time, that is one of the security statements that we seek to offer
with TSEM.

If the kernel can make a judgement, that in a limited execution
context, such as system boot and initialization, that userspace has
not acted in an untrusted manner, it can punt verification and parsing
of RPM headers and priming of something like the digest cache to
userspace.

Again, apologies if we misunderstand the architecture, any
clarifications would be appreciated.

Have a good week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

