Return-Path: <linux-kselftest+bounces-29964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 054CBA76FC9
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 22:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 082CA7A2C16
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 20:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40AA21B9FC;
	Mon, 31 Mar 2025 20:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="d28vV6/y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D832216E24;
	Mon, 31 Mar 2025 20:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454647; cv=none; b=ACPIdPR4fhGFOqtrFlSbyvgegUTlA8G63EVCFYDmc348cMS1wnl/CeH17XZiRMOVPhCuwKekWyfDksahv8hpMBmkXm/QmShL2AKNr1eAbuztvVuJL4daef4NvHOEiIhdm7GhBK7KB2D8QKekk49R8IdqGrqgNgNlEGnz5zvLiXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454647; c=relaxed/simple;
	bh=10bv2ci8Gq6q+ywpbgUZb11BTLKgedTDu+zcEPWmeN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=msjov1frB92gd2WoBbWubIY9zHA29Y3AZ5refKJgx2KaoN3zFXv4dxBuScXXWY/Iw6iRq4nwxnUALtvKmgSDDOck1LEN/V5kdMjc/7ge0U4BYpGP9inMjGeQ+Yidl/PjW5eJn482MvwizzHNoR9h4ovsvVrIzA1FcNja57z7JbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=d28vV6/y; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4D2A1210237A;
	Mon, 31 Mar 2025 13:57:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4D2A1210237A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743454645;
	bh=5XsgAWUoFJ8EmLqO+z62iuJCHz41nTI4m6vFV/nAFDg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=d28vV6/yHuGZDGRY+KhqOML58EhHOZvrywvgHDZb0obC9gbdEWtd1vkSN7MEHX4P2
	 e9a2D4VWMXQWHWQ2FoVJfkcWg1HevVpml0wySPWlEGN/IQiIxN2AtXipKVvyu9vvC9
	 c0uwH1dLc9NLCkUNPgqOf5hVIXGc82dBCH4f5l54=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
 <davem@davemloft.net>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Masahiro Yamada
 <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas
 Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>, =?utf-8?Q?Mick?=
 =?utf-8?Q?a=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Nick
 Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Jan Stancek <jstancek@redhat.com>,
 Neal Gompa <neal@gompa.dev>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, llvm@lists.linux.dev, nkapron@google.com,
 teknoraver@meta.com, roberto.sassu@huawei.com, xiyou.wangcong@gmail.com
Subject: Re: [RFC PATCH security-next 0/4] Introducing Hornet LSM
In-Reply-To: <Z97xvUul1ObkmulE@kernel.org>
References: <20250321164537.16719-1-bboscaccy@linux.microsoft.com>
 <Z97xvUul1ObkmulE@kernel.org>
Date: Mon, 31 Mar 2025 13:57:15 -0700
Message-ID: <871puc7wb8.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jarkko Sakkinen <jarkko@kernel.org> writes:

Hi Jarkko,

Thanks for the comments. Paul did a very nice job providing some
background info, allow me to provide some additional data.

> On Fri, Mar 21, 2025 at 09:45:02AM -0700, Blaise Boscaccy wrote:
>> This patch series introduces the Hornet LSM.
>> 
>> Hornet takes a simple approach to light-skeleton-based eBPF signature
>
> Can you define "light-skeleton-based" before using the term.
>
> This is the first time in my life when I hear about it.
>

Sure. Here is the patchset where this stuff got introduced if you are
curious.
https://lore.kernel.org/bpf/20220209054315.73833-1-alexei.starovoitov@gmail.com/

eBPF has similar requirements to that of modules when it comes to
loading: find kallysym addresses, fix up elf relocations, some
struct field offset handing stuff called CO-RE (compile-one
run-anywhere), and some other miscellaneous bookkeeping.  During eBPF
program compilation, pseudo-values get written to the immedate operands
of instructions.  During loading, those pseudo-values get rewritten with
concrete addresses or data applicable to the currently running system,
e.g. a kallsym address or a fd for a map. This needs to happen before
the instructions for a bpf program are loaded into the kernel via the
bpf() syscall.

Unlike modules, an in-kernel loader unfortunately doesn't
exist. Typically, the instruction rewriting is done dynamically in
userspace via libbpf (or the rust/go/python loader). What skeletons do
is generate a script of required instruction-rewriting operations which
then gets played back at load-time against a hard-coded blob of raw
instruction data. This removes the need to distribute source-code or
object files.

There are two flavors of skeletons, normal skeletons, and light
skeletons. Normal skeletons utilize relocation logic that lives in
libbpf, and the relocations/instruction rewriting happen in userspace.
The second flavor, light skeletons, uses a small eBPF program that
contains the relocation lookup logic. As it's running in in the kernel,
it unpacks the target program, peforms the instruction rewriting, and
loads the target program. Light skeletons are currently utilized for
some drivers, and BPF_PRELOAD functionionality since they can operate
without userspace.

Light skeletons were recommended on various mailing list discussions as
the preffered path to performing signature verification. There are some
PoCs floating around that used light-skeletons in concert with
fs-verity/IMA and eBPF LSMs. We took a slightly different approach to
Hornet, by utilizing the existing PCKS#7 signing scheme that is used for
kernel modules.

>> verification. Signature data can be easily generated for the binary
>
> s/easily//
>
> Useless word having no measure.
>

Ack, thanks.


>> data that is generated via bpftool gen -L. This signature can be
>
> I have no idea what that command does.
>
> "Signature data can be generated for the binary data as follows:
>
> bpftool gen -L
>
> <explanation>"
>
> Here you'd need to answer to couple of unknowns:
>
> 1. What is in exact terms "signature data"?

That is a PKCS#7 signature of a data buffer containing the raw
instructions of an eBPF program, followed by the initial values of any
maps used by the program. 

> 2. What does "bpftool gen -L" do?
>

eBPF programs often have 2 parts. An orchestrator/loader program that
provides load -> attach/run -> i/o -> teardown logic and the in-kernel
program.

That command is used to generate a skeleton which can be used by the
orchestrator prgoram. Skeletons get generated as a C header file, that
contains various autogenerated functions that open and load bpf programs
as decribed above. That header file ends up being included in a
userspace orchestrator program or possibly a kernel module.

> This feedback maps to other examples too in the cover letter.
>
> BR, Jarkko


I'll rework this with some definitions of the eBPF subsystem jargon
along with your suggestions.

-blaise

