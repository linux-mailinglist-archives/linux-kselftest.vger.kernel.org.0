Return-Path: <linux-kselftest+bounces-22576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5947C9DAC7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 18:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDC4DB21C3D
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 17:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9308B1FF7C6;
	Wed, 27 Nov 2024 17:32:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17583A41;
	Wed, 27 Nov 2024 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728745; cv=none; b=AAuoRrx7IjFQaLFTsgEn54sKbAgilpsPrl6OI9atmP7YqW9St9pMvvTG55nyt5ymprDWWwTjG2U0bXN+mhghtIZaWBfzAaSahf/DifvpkPCyutwl07v5Z9X2PVHpc5DcAFBiUC/5NKWy1Ow6Ikub6D1UZ8btYsT/YiVC6alcXoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728745; c=relaxed/simple;
	bh=2UqC7ofISMc/ShaD/y+NPwjn/miRNC6CwUla/sbT3xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgNUAVrDuM65UfODP1WYxZUOZiaZgoxTa7DwMGYEXYgpVwl3p8VY0TitANvgyWGyZwXNMABh44n6lrB4dNB0vTnVRE194ord5OegRDSSrAuPsgQztVeXnXRj8fGovCJ1cs3mOSGqtE0cbR2eBw1BTN+Zhw43FrFzkPSfm3K0l4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 4ARHUrYb001848;
	Wed, 27 Nov 2024 11:30:53 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 4ARHUgi2001842;
	Wed, 27 Nov 2024 11:30:42 -0600
Date: Wed, 27 Nov 2024 11:30:42 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        corbet@lwn.net, mcgrof@kernel.org, petr.pavlu@suse.com,
        samitolvanen@google.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org,
        wufan@linux.microsoft.com, pbrobinson@gmail.com, zbyszek@in.waw.pl,
        hch@lst.de, mjg59@srcf.ucam.org, pmatilai@redhat.com, jannh@google.com,
        dhowells@redhat.com, jikos@kernel.org, mkoutny@suse.com,
        ppavlu@suse.com, petr.vorel@gmail.com, mzerqung@0pointer.de,
        kgold@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v6 00/15] integrity: Introduce the Integrity Digest Cache
Message-ID: <20241127173042.GA1649@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 27 Nov 2024 11:30:53 -0600 (CST)

On Tue, Nov 19, 2024 at 11:49:07AM +0100, Roberto Sassu wrote:

Hi Roberto, I hope the week is going well for you.

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
> 
> For example, IMA measurement requires the target platform to collect
> integrity measurements, and to protect them with the TPM, which introduces
> a noticeable overhead (up to 10x slower in a microbenchmark) on frequently
> used system calls, like the open().
> 
> IMA Appraisal currently requires individual files to be signed and
> verified, and Linux distributions to rebuild all packages to include file
> signatures (this approach has been adopted from Fedora 39+). Like a TPM,
> also signature verification introduces a significant overhead, especially
> if it is used to check the integrity of many files.
> 
> This is where the new Integrity Digest Cache comes into play, it offers
> additional support for new and existing integrity solutions, to make
> them faster and easier to deploy.
> 
> The Integrity Digest Cache can help IMA to reduce the number of TPM
> operations and to make them happen in a deterministic way. If IMA knows
> that a file comes from a Linux distribution, it can measure files in a
> different way: measure the list of digests coming from the distribution
> (e.g. RPM package headers), and subsequently measure a file if it is not
> found in that list.
> 
> The performance improvement comes at the cost of IMA not reporting which
> files from installed packages were accessed, and in which temporal
> sequence. This approach might not be suitable for all use cases.
> 
> The Integrity Digest Cache can also help IMA for appraisal. IMA can simply
> lookup the calculated digest of an accessed file in the list of digests
> extracted from package headers, after verifying the header signature. It is
> sufficient to verify only one signature for all files in the package, as
> opposed to verifying a signature for each file.

Roberto, a big picture question for you, our apologies if we
completely misunderstand your patch series.

The performance benefit comes from the fact that the kernel doesn't
have to read a file and calculate the cryptographic digest when the
file is accessed.  The 'trusted' digest value comes from a signed list
of digests that a packaging entity provides and the kernel validates.
So there is an integrity guarantee that the supplied digests were the
same as when the package was built.

Is there a guarantee implemented, that we missed, that the on-disk
file actually has the digest value that was initially generated by the
packaging entity when the file is accessed operationally?

Secondly, and in a related issue, what happens in a container
environment when a pathname is accessed that is actually a different
file but with the same effective pathname as a file that is in the
vendor validated digest list?

Once again, apologies, if we completely misinterpret the issues
involved.

Have a good remainder of the week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

