Return-Path: <linux-kselftest+bounces-12335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C67910982
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 17:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA762B21A72
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 15:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7B61B0111;
	Thu, 20 Jun 2024 15:15:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE481AF6AA;
	Thu, 20 Jun 2024 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718896505; cv=none; b=dv+OjOInUdc2s1dznZPkkZn9BrQmjF4cKULMSxIdAz47EbwsGSb0Z5EDPvJift1GlsV7pFjbfHNXIX8bw2rNzjXxm7x6FFyRPoVEyTDD+OtB96NuC/V6103L4wLrrO87mpLn26++Q4DWXQhI+1SC5JfKeZsgnN7CcK+UutpJemA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718896505; c=relaxed/simple;
	bh=B+ANxAr5I5iCOeavRB0jI50wfQL2dL1ZXhcF7hJaeXA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=npfehlmsGrSKtXBVAyspnxjuKnUYLuiqsFwjgyFPu7GiR+ijnG8/8A1yGAeb1J2OpFEiBoukgyYurSstsygVHxwhjv6MCpq9MORamzZzmqZD9Z7gqGxUs1JgyHdEcFBdoPWyNO0bZtxasMNDjrj1sCHc48W28mDuYRSvMKTcBkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4W4k3T5t3mz9v7Jj;
	Thu, 20 Jun 2024 22:52:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 50AA214010C;
	Thu, 20 Jun 2024 23:14:53 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwB3_zlXR3RmAzTNAA--.2719S2;
	Thu, 20 Jun 2024 16:14:52 +0100 (CET)
Message-ID: <c96db3ab0aec6586b6d55c3055e7eb9fea6bf4e3.camel@huaweicloud.com>
Subject: Re: [PATCH v4 00/14] security: digest_cache LSM
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>
Cc: corbet@lwn.net, jmorris@namei.org, serge@hallyn.com, 
 akpm@linux-foundation.org, shuah@kernel.org, mcoquelin.stm32@gmail.com, 
 alexandre.torgue@foss.st.com, mic@digikod.net, 
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
 linux-integrity@vger.kernel.org, wufan@linux.microsoft.com,
 pbrobinson@gmail.com,  zbyszek@in.waw.pl, hch@lst.de, mjg59@srcf.ucam.org,
 pmatilai@redhat.com,  jannh@google.com, dhowells@redhat.com,
 jikos@kernel.org, mkoutny@suse.com,  ppavlu@suse.com, petr.vorel@gmail.com,
 mzerqung@0pointer.de, kgold@linux.ibm.com,  Roberto Sassu
 <roberto.sassu@huawei.com>
Date: Thu, 20 Jun 2024 17:14:28 +0200
In-Reply-To: <CAHC9VhQp1wsm+2d6Dhj1gQNSD0z_Hgj0cFrVf1=Zs94LmgfK0A@mail.gmail.com>
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
	 <CAHC9VhTs8p1nTUXXea2JmF0FCEU6w39gwQRMtwACqM=+EBj1jw@mail.gmail.com>
	 <7cf03a6ba8dbf212623aab2dea3dac39482e8695.camel@huaweicloud.com>
	 <CAHC9VhSCw6RweTs6whAu4v6t4n7gxUWJtjmzY-UXrdzW0H+YJA@mail.gmail.com>
	 <520d2dc2ff0091335a280a877fa9eb004af14309.camel@huaweicloud.com>
	 <CAHC9VhRD1kBwqtkF+_cxCUCeNPp+0PAiNP-rG06me6gRQyYcyg@mail.gmail.com>
	 <2b335bdd5c20878e0366dcf6b62d14f73c2251de.camel@huaweicloud.com>
	 <CAHC9VhSOMLH69+q_wt2W+N9SK92KGp5n4YgzpsXMcO2u7YyaTg@mail.gmail.com>
	 <e9114733eedff99233b1711b2b05ab85b7c19ca9.camel@huaweicloud.com>
	 <CAHC9VhQp1wsm+2d6Dhj1gQNSD0z_Hgj0cFrVf1=Zs94LmgfK0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwB3_zlXR3RmAzTNAA--.2719S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF18uFyDJF15AF1xZw1UZFb_yoW5Xw17pa
	9rCF1Ykr4vqryfCwn2v3W7Z3WFvrZ8tF17Wwn8Xry5Cryq9r1Ikw1I9F4UuFWDXrn5u3Wa
	yF42vFya9rn8uaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAABF1jj595mQACsJ

On Thu, 2024-06-20 at 10:48 -0400, Paul Moore wrote:
> On Thu, Jun 20, 2024 at 5:12=E2=80=AFAM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Wed, 2024-06-19 at 14:43 -0400, Paul Moore wrote:
> > > On Wed, Jun 19, 2024 at 12:38=E2=80=AFPM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > >=20
> > > > Making it a kernel subsystem would likely mean replicating what the=
 LSM
> > > > infrastructure is doing, inode (security) blob and being notified a=
bout
> > > > file/directory changes.
> > >=20
> > > Just because the LSM framework can be used for something, perhaps it
> > > even makes the implementation easier, it doesn't mean the framework
> > > should be used for everything.
> >=20
> > It is supporting 3 LSMs: IMA, IPE and BPF LSM.
> >=20
> > That makes it a clear target for the security subsystem, and as you
> > suggested to start for IMA, if other kernel subsystems require them, we
> > can make it as an independent subsystem.
>=20
> Have you discussed the file digest cache functionality with either the
> IPE or BPF LSM maintainers?  While digest_cache may support these

Well, yes. I was in a discussion since long time ago with Deven and
Fan. The digest_cache LSM is listed in the Use Case section of the IPE
cover letter:

https://lore.kernel.org/linux-integrity/1716583609-21790-1-git-send-email-w=
ufan@linux.microsoft.com/

I also developed an IPE module back in the DIGLIM days:

https://lore.kernel.org/linux-integrity/a16a628b9e21433198c490500a987121@hu=
awei.com/

As for eBPF, I just need to make the digest_cache LSM API callable by
eBPF programs, very likely not requiring any change on the eBPF
infrastructure itself. As an example of the modification needed, you
could have a look at:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/ker=
nel/trace/bpf_trace.c?h=3Dv6.10-rc4#n1381


Once the digest_cache LSM API is exposed in eBPF, you could write a
simple file integrity check (taken from my DIGLIM eBPF), not tested:

SEC("lsm.s/bprm_creds_for_exec")
int BPF_PROG(exec, struct linux_binprm *bprm)
{
	u8 digest[MAX_DIGEST_SIZE] =3D { 0 };
	digest_cache_found_t found;
	struct digest_cache;
	int algo;

	algo =3D bpf_ima_file_hash(bprm->file, digest, sizeof(digest));
	if (algo < 0)
		return -EPERM;

	digest_cache =3D bpf_digest_cache_get(bprm->file->f_path.dentry);
	if (!digest_cache)
		return -EPERM;

	found =3D bpf_digest_cache_lookup(bprm->file->f_path.dentry,
					digest_cache, digest, algo);

	bpf_digest_cache_put(digest_cache);
	return found ? 0 : -EPERM;
}

Roberto

> LSMs, I don't recall seeing any comments from the other LSM
> developers; if you are going to advocate for this as something outside
> of IMA, it would be good to see a show of support for the other LSMs.
>=20


