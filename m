Return-Path: <linux-kselftest+bounces-30762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B019A88D52
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 22:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B536A3B5299
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 20:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662451E520D;
	Mon, 14 Apr 2025 20:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qjXuU6AB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E12E1624CE;
	Mon, 14 Apr 2025 20:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744663609; cv=none; b=UwVTFcb62ULWde+DXKXbDRPbQ3kUh/DGggVJlIF2dbEY4jyrgeGbA0HRfooqcNDxJ4RG2LWYgpcaoWB5Pbc3+cpcVduuD+fh0Y6iljCOQ9WePr65YFPn9Fr4UpYtxPKm/c0L0fWAlGx3kRJn2e4rmOaSoP0ojTOI1U1iBJNNqXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744663609; c=relaxed/simple;
	bh=swUAc50daEtFf7DA0WVyC/laYjSUv1+bSAEF4s5HlRI=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WGV4gouru5VCYaliMsHep+W3et4a7hfWmblujqK1Dhmy3Gjc1izquLMLARh/lzHodj1GDGrOar2tgfECTeE2A48MdIfevYqGzBebOcaVNqZ43hruFsPyWPJ1BdvBX9TSMlLSPsdaGB2TIsV/6o+tXUyAYoke/DkYNpB11j6Y9S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qjXuU6AB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 60923210C42A;
	Mon, 14 Apr 2025 13:46:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 60923210C42A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744663607;
	bh=Wr54ktj2RvZmhcjZy8uOTgLbn/jq3tS7dZjeGpQb/nw=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=qjXuU6ABun9uxsNQhI/clJhmrp/6vVlTdbfk4qxK2v2nxeh5OqP37fiPZdEnFDqkY
	 kOUugcOpq+GLETdIYWgPGFGQQivn630G04emB62z69Z3RXNRCfGMMIaRGFuoTSBVBc
	 QVY1IKkm1oN0ZGNYmSp2AqT1aoqcUZBDPqGCfaZw=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Paul Moore <paul@paul-moore.com>, Jonathan Corbet <corbet@lwn.net>,
 David Howells <dhowells@redhat.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan
 <shuah@kernel.org>, =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?utf-8?Q?G=C3=BCnther?= Noack
 <gnoack@google.com>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Jan Stancek <jstancek@redhat.com>,
 Neal Gompa <neal@gompa.dev>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, llvm@lists.linux.dev, nkapron@google.com,
 teknoraver@meta.com, roberto.sassu@huawei.com, xiyou.wangcong@gmail.com
Subject: Re: [PATCH v2 1/4] security: Hornet LSM
In-Reply-To: <d3ad9a7bb9eb68a3ae5dd18bf091825d@paul-moore.com>
References: <20250404215527.1563146-2-bboscaccy@linux.microsoft.com>
 <d3ad9a7bb9eb68a3ae5dd18bf091825d@paul-moore.com>
Date: Mon, 14 Apr 2025 13:46:33 -0700
Message-ID: <87ikn6jwt2.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paul Moore <paul@paul-moore.com> writes:

> On Apr  4, 2025 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
>> 
>> This adds the Hornet Linux Security Module which provides signature
>> verification of eBPF programs. This allows users to continue to
>> maintain an invariant that all code running inside of the kernel has
>> been signed.
>> 
>> The primary target for signature verification is light-skeleton based
>> eBPF programs which was introduced here:
>> https://lore.kernel.org/bpf/20220209054315.73833-1-alexei.starovoitov@gmail.com/
>> 
>> eBPF programs, before loading, undergo a complex set of operations
>> which transform pseudo-values within the immediate operands of
>> instructions into concrete values based on the running
>> system. Typically, this is done by libbpf in
>> userspace. Light-skeletons were introduced in order to support
>> preloading of bpf programs and user-mode-drivers by removing the
>> dependency on libbpf and userspace-based operations.
>> 
>> Userpace modifications, which may change every time a program gets
>> loaded or runs on a slightly different kernel, break known signature
>> verification algorithms. A method is needed for passing unadulterated
>> binary buffers into the kernel in-order to use existing signature
>> verification algorithms. Light-skeleton loaders with their support of
>> only in-kernel relocations fit that constraint.
>> 
>> Hornet employs a signature verification scheme similar to that of
>> kernel modules. A signature is appended to the end of an
>> executable file. During an invocation of the BPF_PROG_LOAD subcommand,
>> a signature is extracted from the current task's executable file. That
>> signature is used to verify the integrity of the bpf instructions and
>> maps which were passed into the kernel. Additionally, Hornet
>> implicitly trusts any programs which were loaded from inside kernel
>> rather than userspace, which allows BPF_PRELOAD programs along with
>> outputs for BPF_SYSCALL programs to run.
>> 
>> The validation check consists of checking a PKCS#7 formatted signature
>> against a data buffer containing the raw instructions of an eBPF
>> program, followed by the initial values of any maps used by the
>> program. Maps are frozen before signature verification checking to
>> stop TOCTOU attacks.
>> 
>> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
>> ---
>>  Documentation/admin-guide/LSM/Hornet.rst |  55 ++++++
>>  Documentation/admin-guide/LSM/index.rst  |   1 +
>>  MAINTAINERS                              |   9 +
>>  crypto/asymmetric_keys/pkcs7_verify.c    |  10 +
>>  include/linux/kernel_read_file.h         |   1 +
>>  include/linux/verification.h             |   1 +
>>  include/uapi/linux/lsm.h                 |   1 +
>>  security/Kconfig                         |   3 +-
>>  security/Makefile                        |   1 +
>>  security/hornet/Kconfig                  |  11 ++
>>  security/hornet/Makefile                 |   4 +
>>  security/hornet/hornet_lsm.c             | 239 +++++++++++++++++++++++
>>  12 files changed, 335 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/admin-guide/LSM/Hornet.rst
>>  create mode 100644 security/hornet/Kconfig
>>  create mode 100644 security/hornet/Makefile
>>  create mode 100644 security/hornet/hornet_lsm.c
>
> ...
>
>> diff --git a/security/hornet/hornet_lsm.c b/security/hornet/hornet_lsm.c
>> new file mode 100644
>> index 000000000000..d9e36764f968
>> --- /dev/null
>> +++ b/security/hornet/hornet_lsm.c
>
> ...
>
>> +/* kern_sys_bpf is declared as an EXPORT_SYMBOL in kernel/bpf/syscall.c, however no definition is
>> + * provided in any bpf header files. If/when this function has a proper definition provided
>> + * somewhere this declaration should be removed
>> + */
>> +int kern_sys_bpf(int cmd, union bpf_attr *attr, unsigned int size);
>
> I believe the maximum generally accepted line length is now up to 100
> characters, but I remain a big fan of the ol' 80 character terminal
> width and would encourage you to stick to that if possible.  However,
> you're the one who is signing on for maintenence of Hornet, not me, so
> if you love those >80 char lines, you do you :)
>
> I also understand why you are doing the kern_sys_bpf() declaration here,
> but once this lands in Linus' tree I would encourage you to try moving
> the declaration into a kernel-wide BPF header where it really belongs.
>
>> +static int hornet_check_binary(struct bpf_prog *prog, union bpf_attr *attr,
>> +			       struct hornet_maps *maps)
>> +{
>> +	struct file *file = get_task_exe_file(current);
>> +	const unsigned long markerlen = sizeof(EBPF_SIG_STRING) - 1;
>> +	void *buf = NULL;
>> +	size_t sz = 0, sig_len, prog_len, buf_sz;
>> +	int err = 0;
>> +	struct module_signature sig;
>> +>> +	buf_sz = kernel_read_file(file, 0, &buf, INT_MAX, &sz, READING_EBPF);
>> +	fput(file);
>> +	if (!buf_sz)
>> +		return -1;
>
> I'm pretty sure I asked you about this already off-list, but I can't
> remember the answer so I'm going to bring this up again :)
>
> This file read makes me a bit nervous about a mismatch between the
> program copy operation done in the main BPF code and the copy we do
> here in kernel_read_file().  Is there not some way to build up the
> buffer with the BPF program from the attr passed into this function
> (e.g. attr.insns?)?
>

There is. That would require modifying the BPF_PROG_LOAD subcommand
along with modifying the skeletobn generator to use it. I don't know if
there is enough buy-in from the ebpf developers to do that
currently. Tacking the signature to the end of of the light-skeleton
binary allows Hornet to operate without modifying the bpf subsystem and
is very similar to how module signing currently works. Modules have the
advantage of having a working in-kernel loader, which makes all of this
a non-issue with modules.

> If there is some clever reason why all of this isn't an issue, it might
> be a good idea to put a small comment above the kernel_read_file()
> explaining why it is both safe and good.
>

Will do. I don't see this being an issue. In practice it's not much
different than auth schemes that use a separate passkey. The
instructions and maps are passed into the kernel during BPF_PROG_LOAD
via a syscall, they aren't copied from the binary. The only part that
gets copied during kernel_read_file() is the signature. If there was a
mismatch between what was on-disk and what was passed in via the
syscall, the signature verification would fail.  As long as a signature
can be found somewhere for the loader program and map, that signature is
valid, and that program and map can't be modified by the user after the
signature is checked, it means that someone trusted signed that blob at
some point in time and only signed blobs are going to run.  It shouldn't
matter from a math standpoint where that signature physically lives, be
it in a binary image, a buffer in a syscall or even an additional map.

>> +	prog_len = buf_sz;
>> +
>> +	if (prog_len > markerlen &&
>> +	    memcmp(buf + prog_len - markerlen, EBPF_SIG_STRING, markerlen) == 0)
>> +		prog_len -= markerlen;
>> +
>> +	memcpy(&sig, buf + (prog_len - sizeof(sig)), sizeof(sig));
>> +	sig_len = be32_to_cpu(sig.sig_len);
>> +	prog_len -= sig_len + sizeof(sig);
>> +
>> +	err = mod_check_sig(&sig, prog->len * sizeof(struct bpf_insn), "ebpf");
>> +	if (err)
>> +		return err;
>> +	return hornet_verify_lskel(prog, maps, buf + prog_len, sig_len);
>> +}
>
> --

> paul-moore.com

