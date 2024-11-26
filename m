Return-Path: <linux-kselftest+bounces-22529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCB09D9586
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 11:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3FA2850DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 10:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2856D1D27BB;
	Tue, 26 Nov 2024 10:25:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268A71C3F36;
	Tue, 26 Nov 2024 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732616744; cv=none; b=Xkro9t02LHIegy2/BLd9pfZQXIkXXQDbDj0Hr8UUddbmVtyS8F9oQt8qBuOpsCiIIvUtm2r/Hd4IvLyOcZsTJPtT6brA2QDE8kNRCP+bciwa57QxjSXc11bXn/H7/ephCGtFBKWSls1IoOyVSErWMmvDrxtD2c2XMQvdaAeWLko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732616744; c=relaxed/simple;
	bh=fs0tdLUjiZ9ilJD7V6bohMscAEWEo6Ye5zBOhSJnsXo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=go49S8vMWABrDI9oytGoA5uWk65IbhpPJaFtWWNwU+yCaIzpaXIbozhnMPrA+Ppjo4m1H46uyhRXRnmHl65EMGMV7I1nZeVuQ7iR7p83WqVUollvY5sAWJgSk5sqBn6xmWo+n+5t419WfMLlAQdUTfNgFTguA5uDaWz7P/qGtrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XyJ8F1xc4z9v7Vg;
	Tue, 26 Nov 2024 18:04:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id F337E1407AB;
	Tue, 26 Nov 2024 18:25:30 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCnwH8HokVnxjpVAg--.1157S2;
	Tue, 26 Nov 2024 11:25:30 +0100 (CET)
Message-ID: <d428a5d926d695ebec170e98463f7501a1b00793.camel@huaweicloud.com>
Subject: Re: [PATCH v6 07/15] digest_cache: Allow registration of digest
 list parsers
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com,  corbet@lwn.net, petr.pavlu@suse.com,
 samitolvanen@google.com, da.gomez@samsung.com,  akpm@linux-foundation.org,
 paul@paul-moore.com, jmorris@namei.org,  serge@hallyn.com,
 shuah@kernel.org, mcoquelin.stm32@gmail.com,  alexandre.torgue@foss.st.com,
 linux-integrity@vger.kernel.org,  linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-api@vger.kernel.org,
 linux-modules@vger.kernel.org,  linux-security-module@vger.kernel.org,
 linux-kselftest@vger.kernel.org,  wufan@linux.microsoft.com,
 pbrobinson@gmail.com, zbyszek@in.waw.pl, hch@lst.de,  mjg59@srcf.ucam.org,
 pmatilai@redhat.com, jannh@google.com, dhowells@redhat.com, 
 jikos@kernel.org, mkoutny@suse.com, ppavlu@suse.com, petr.vorel@gmail.com, 
 mzerqung@0pointer.de, kgold@linux.ibm.com, Roberto Sassu
 <roberto.sassu@huawei.com>
Date: Tue, 26 Nov 2024 11:25:07 +0100
In-Reply-To: <Z0UN9ub0iztWvgLi@bombadil.infradead.org>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
	 <20241119104922.2772571-8-roberto.sassu@huaweicloud.com>
	 <Z0UN9ub0iztWvgLi@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCnwH8HokVnxjpVAg--.1157S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw18KrWxCr48Jw4fWF17Jrb_yoWrZF4xpF
	4Ykw15KF4vyr1rCayxAa1I93yF9393XrW5WFn5JryrZr4Y9F4Svw1IgF43u3WUGr4DKF1a
	grs0g343tryDZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4U
	JwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	EksDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQATBGdFMjUCtgAAsH

On Mon, 2024-11-25 at 15:53 -0800, Luis Chamberlain wrote:
> On Tue, Nov 19, 2024 at 11:49:14AM +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > Introduce load_parser() to load a kernel module containing a
> > parser for the requested digest list format (compressed kernel modules =
are
> > supported). Kernel modules are searched in the
> > /lib/modules/<kernel ver>/security/integrity/digest_cache directory.
> >=20
> > load_parser() calls ksys_finit_module() to load a kernel module directl=
y
> > from the kernel. request_module() cannot be used at this point, since t=
he
> > reference digests of modprobe and the linked libraries (required for IM=
A
> > appraisal) might not be yet available, resulting in modprobe execution
> > being denied.
>=20
> You are doing a full solution implementation of loading modules in-kernel=
.
> Appraisals of modules is just part of the boot process, some module
> loading may need firmware to loading to get some functinality to work
> for example some firmware to get a network device up or a GPU driver.
> So module loading alone is not the only thing which may require
> IMA appraisal, and this solution only addresses modules. There are other
> things which may be needed other than firmware, eBPF programs are
> another example.

Firmware, eBPF programs and so on are supposed to be verified with
digest lists (or alternative methods, such as file signatures), once
the required digest list parsers are loaded.

The parser is an exceptional case, because user space cannot be
executed at this point. Once the parsers are loaded, verification of
everything else proceeds as normal. Fortunately, in most cases kernel
modules are signed, so digest lists are not required to verify them.

> It sounds more like you want to provide or extend LSM hooks fit your
> architecture and make kernel_read_file() LSM hooks optionally use it to
> fit this model.

As far as the LSM infrastructure is concerned, I'm not adding new LSM
hooks, nor extending/modifying the existing ones. The operations the
Integrity Digest Cache is doing match the usage expectation by LSM (net
denying access, as discussed with Paul Moore).

The Integrity Digest Cache is supposed to be used as a supporting tool
for other LSMs to do regular access control based on file data and
metadata integrity. In doing that, it still needs the LSM
infrastructure to notify about filesystem changes, and to store
additional information in the inode and file descriptor security blobs.

The kernel_post_read_file LSM hook should be implemented by another LSM
to verify the integrity of a digest list, when the Integrity Digest
Cache calls kernel_read_file() to read that digest list. That LSM is
also responsible to provide the result of the integrity verification to
the Integrity Digest Cache, so that the latter can give this
information back to whoever wants to do a digest lookup from that
digest list and also wants to know whether or not the digest list was
authentic.

> Because this is just for a *phase* in boot, which you've caught because
> a catch-22 situaton, where you didn't have your parsers loaded. Which is
> just a reflection that you hit that snag. It doesn't prove all snags
> will be caught yet.

Yes, that didn't happen earlier, since all the parsers were compiled
built-in in the kernel. The Integrity Digest Cache already has a
deadlock avoidance mechanism for digest lists.

Supporting kernel modules opened the road for new deadlocks, since one
can ask a digest list to verify a kernel module, but that digest list
requires the same kernel module. That is why the in-kernel mechanism is
100% reliable, because the Integrity Digest Cache marks the file
descriptors it opens, and can recognize them, when those file
descriptors are passed back to it by other LSMs (e.g. through the
kernel_post_read_file LSM hook).

> And you only want to rely on this .. in-kernel loading solution only
> early on boot, is there a way to change this over to enable regular
> operation later?

User space can voluntarily load new digest list parsers, but the
Integrity Digest Cache cannot rely on it to be done. Also, using
request_module() does not seem a good idea, since it wouldn't allow the
Integrity Digest Cache to mark the file descriptor of kernel modules,
and thus the Integrity Digest Cache could not determine whether or not
a deadlock is happening.

Thanks

Roberto


