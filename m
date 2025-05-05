Return-Path: <linux-kselftest+bounces-32414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6BBAA9A87
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 19:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98AE97AB32F
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8E026C391;
	Mon,  5 May 2025 17:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kOvVcZpQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C733217C98;
	Mon,  5 May 2025 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466209; cv=none; b=gkdzIXxMmHH/iFY11c/1tHzGeiK1CgGKWpdn6RqBZt3La/0bpSY7o073uLbs4+4N1gmDYGbrvqJ/tmPTEAcBiuBVmgirKwfxVixuqXmboOPCaM4WgddEMI6KpjqlNJPcw4xT8bfMBDAP38BPiiTziYMYlSEtk2FrV+hOVTZBWC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466209; c=relaxed/simple;
	bh=R+GwlfGZoPlwh3YnWX8HPEVZTkofAG51fiG2PtNEH88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zn56ai+URqSKDxhppg1FKTtIfObTBWCuNCvpzMtYwTETffr1K7Ds+xQsOLOcdLkfR9JYUhxoOm2QAZRtu3BQNDNevBiYq4nVKVJ+zxNa19wFaBqdIv9G1V5igVuQbuXR9P2JOdSOnc62dAjT9vjNlh7H1hheZrPXLT7kphS5OGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kOvVcZpQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [40.78.12.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id E0D5F2115DC3;
	Mon,  5 May 2025 10:30:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E0D5F2115DC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746466207;
	bh=L5eUFsHvaH45uDsjDJjMZQptT9OSECb9z18nACTP45M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kOvVcZpQ3T9sSH7pJ/HqSNP3wky0HxKFyWnu3+U7tjF1uLifCwAjeQCk7o7kn4hxM
	 TFP3TzAMaTUbH/qAfIWuql1lE8KMJwB3+zRXEdgn3Dflf/I2scqy3aWQzbYogVDthy
	 x3GkXKAcpGXd74KgoFzFnVhX8w1D1WUABHFiQ5dY=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: KP Singh <kpsingh@kernel.org>
Cc: James.Bottomley@hansenpartnership.com, bpf@vger.kernel.org,
 code@tyhicks.com, corbet@lwn.net, davem@davemloft.net,
 dhowells@redhat.com, gnoack@google.com, herbert@gondor.apana.org.au,
 jarkko@kernel.org, jmorris@namei.org, jstancek@redhat.com,
 justinstitt@google.com, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-security-module@vger.kernel.org,
 llvm@lists.linux.dev, masahiroy@kernel.org, mic@digikod.net,
 morbo@google.com, nathan@kernel.org, neal@gompa.dev,
 nick.desaulniers+lkml@gmail.com, nicolas@fjasle.eu, nkapron@google.com,
 paul@paul-moore.com, roberto.sassu@huawei.com, serge@hallyn.com,
 shuah@kernel.org, teknoraver@meta.com, xiyou.wangcong@gmail.com, KP Singh
 <kpsingh@kernel.org>
Subject: Re: [PATCH v3 0/4] Introducing Hornet LSM
In-Reply-To: <20250502210034.284051-1-kpsingh@kernel.org>
References: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
 <20250502210034.284051-1-kpsingh@kernel.org>
Date: Mon, 05 May 2025 10:30:03 -0700
Message-ID: <87o6w7ge3o.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

KP Singh <kpsingh@kernel.org> writes:

[...]

> Now if you really care about the use-case and want to work with the maintainers
> and implement signing for the community, here's how we think it should be done:
>
> * The core signing logic and the tooling stays in BPF, something that the users
>   are already using. No new tooling.
> * The policy decision on the effect of signing can be built into various
>   existing LSMs. I don't think we need a new LSM for it.
> * A simple UAPI (emphasis on UAPI!) change to union bpf_attr in uapi/bpf.h in
>   the BPF_PROG_LOAD command:
>
> __aligned_u64 signature; 
> __u32 signature_size;

I think having some actual details on the various parties' requirements
here would be helpful. KP, I do look forward to seeing your design;
however, having code signing proposals where the capabilities are
dictated from above and any dissent is dismissed as "you're doing it
wrong" isn't going to be helpful to anyone that needs to use this in
practice.

Also, I don't think anyone actually cares, at least I don't, who calls
verify_pkcs7_signature or whatnot. Verifying signed binary blobs with a
private key is a solved problem and isn't really interesting.

Our requirements for code signing are just an extension of secure boot
and module signing logic:

* Prove all code running in ring zero has been signed
* Not trivially defeatable by root
* Ultimately, no trusted userspace components
* Secure from and not vulnerable to TOCTOU attacks
* Shouldn't be overly vulnerable to supply-chain attacks
* The signature checking logic and control paths should be human-readable
* Work easily and be backportable to stable kernels
* There should be a simple kconfig option to turn this on or off
* This solution needs to be in the mainline kernel

Hornet was implemented to meet those requirements, living in the LSM
subsystem, written in C. As of today, one cannot accomplish those
requirements via BPF-LSM, which is why C was chosen.

One can easily realize there is absolutely no way to have a single
one-size-fits-all signing solution for everything listed in
https://ebpf.io/applications/.

If you want to go the UAPI route, I would wholeheartedly recommend
making it extensible and having this data be available to the policy
LSMs.

enum bpf_signature_type {
  /* x509 signature check against program instructions only */
  BPF_SIGNATURE_PROG_ONLY = 0,
  /* x509 combined signature check against program instructions and used maps */
  BPF_SIGNATURE_PROG_USED_MAPS = 1,
  /* more of these to be determined via usage */ 
  ...
};

_aligned_u64 signature; 
__u32 signature_size;
__u32 signature_type;

The other option for solving this in the general is in-kernel
loaders. That's gotten pushback as well. 

-blaise






