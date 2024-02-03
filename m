Return-Path: <linux-kselftest+bounces-4067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A07E4847E34
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 02:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C58B1F2A16C
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 01:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B3423C9;
	Sat,  3 Feb 2024 01:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="MFj+jqKB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T9nM7Hgl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843125232;
	Sat,  3 Feb 2024 01:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706924087; cv=none; b=fTLflSK3BNzRjl82ZCltFuHpshr4DX5LoA5pUFIkNPYSh2MHUGbVrwBhEoWaIq9vBBp3hamlf99jGbp0VmcHfqbnHvtc0ZGO6d5OVvE1SnX5XQh0gC/gIcnRa8NLnshzOxgGl05cvQxCHesgxkpeinkLd9PUxogxTJHjjHO/3IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706924087; c=relaxed/simple;
	bh=X0Ojwdr7D0Pc16RpTgvTbb5pPVX5ib05jZoeLOX6oAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0BMwMeOW6pT3Ayq8KGupckDNnUeKstZmyyewGsWmAfAqEVByXWp0ht9orWQrSCmEnuk/3MlSpwlRCSNxUUqF1BZfS0P7CC1+CpI/4gKPGwHTi8VJD6ziW+R5+LXeEZuiqJ3KkL82eH3Izo7tRHzwpE3j1Qw0LMQixeGQiYcaFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=MFj+jqKB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T9nM7Hgl; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 68EE95C0050;
	Fri,  2 Feb 2024 20:34:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 02 Feb 2024 20:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706924083; x=1707010483; bh=NnnIMmc9MZ
	3IASFiC5hqBjgW0tly7YEQAd6Bpm7OEMI=; b=MFj+jqKBnhouCKmuAELuyDh+rJ
	jjWg9fl6r38OJwM0JajDa19hxTMqhi96t3TnnPaYGdfmgNWhYY3LsvK10Ukp3II7
	YNUGkCfMkfhY/kT4TFXH2vcmxai3Y1BBxFe38eq/IlAUxeRT7gMDdb75kIfdZqYM
	veuS70k5okuJnl2gi5hvk1jZORe2UnrADy7GQA0g2LrfO6Rnx0q0OqTZb8SszW5f
	fclWJVdCzlx1cBeSRwcZn0og3LYu0jPbegzVLQwrKvHMQU4nHoZ52fx822mhBhei
	9jZrUJMlIwmznZImKPxo1m6+ZbYzLPJ7uzN01xOEN7fJpbzmXKtJxdYuRcvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706924083; x=1707010483; bh=NnnIMmc9MZ3IASFiC5hqBjgW0tly
	7YEQAd6Bpm7OEMI=; b=T9nM7Hgled/XXm0WO8ytjfKSfgvTMNqwCAdHrZCKieNE
	ZdTXViyMt3xFNfdTQClCr8YvYCWDxTGW10izkQcRraa5Fqv/9KazkyXYKQbb4ArD
	pQS3a3ngwFZKj3eIFu3j050thBZaZRjrueMX/vOJ9eA/zbRUA6+7WH2TGSYencPK
	Vrj3dXNYtrUc56bqd4iSkyaEWlVtijxpzM6u0IE/lSDQXOk+eEquQljN5OwShxVi
	438zZyXh+dLUiBclUWI/EAkOIXP4aIrfgzGn6OQryQNzJuGl9If6JihcfdnPDBpZ
	19JVKlpfjZQrZZ1LCdmnA5qubEMUh5Kku68u/9kdxQ==
X-ME-Sender: <xms:Mpi9ZZ_HORM30B-rZD9-PypTMISUhuaWob6e5Wr0Gy6zQmE3lAR-Fg>
    <xme:Mpi9Zdv0fEmt8gWlYrSjAyqq1te_2_HCGned0HkOJ7RZc4xfuZILeij_wuZrNxxWv
    arBz5iyY-q5FXHEfg>
X-ME-Received: <xmr:Mpi9ZXBbdSkULMNSJ7-MNs28J3bgwT1SfJ5sK7gPjUiarKu_M-KZPWdpC-GAyptHOz-WH8xm8IpOwJbTCimuziKtGzvuclg1y4Lhooc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduhedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlvdefmdenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepieffjedujeehtdduhe
    ffgeeiveehleevffdvudethfdugedtleduhffhhfejfffgnecuffhomhgrihhnpehgihht
    hhhusgdrtghomhdpjhgvmhgrrhgthhdrnhgvthenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:M5i9Zdf6QcdOMMRg-j-oLkZ4PFYKCR7jHEcrxzNZru59PuTTDVbMiQ>
    <xmx:M5i9ZeO77Ara2IObUaPffrjYy0QFmjbxP1SobyzzVW4sr3vvWnWagg>
    <xmx:M5i9ZfmNxOeGwxBxjy5unm-E-9gBhW7ppyYukJwATDjRczPVMGUlFQ>
    <xmx:M5i9ZZFLO67t1PQsu3Ogmj-PHiCAuqCf6Ncak8C10MmIgpjIZlhIMw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 20:34:41 -0500 (EST)
Date: Fri, 2 Feb 2024 18:34:40 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Manu Bretelle <chantr4@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, coreteam@netfilter.org, 
	bpf@vger.kernel.org, linux-input@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	netfilter-devel@vger.kernel.org, alexei.starovoitov@gmail.com, olsajiri@gmail.com, 
	quentin@isovalent.com, alan.maguire@oracle.com, memxor@gmail.com, vmalik@redhat.com
Subject: Re: [PATCH bpf-next v4 0/3] Annotate kfuncs in .BTF_ids section
Message-ID: <fq7iecmqkibtexsbgvv5gyu5nva6ig7gcww56oskk2rvmoxfno@uohfy2x57tch>
References: <cover.1706491398.git.dxu@dxuuu.xyz>
 <Zb12EZt0BAKOPBk/@surya>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zb12EZt0BAKOPBk/@surya>

Hi Manu,

On Fri, Feb 02, 2024 at 03:09:05PM -0800, Manu Bretelle wrote:
> On Sun, Jan 28, 2024 at 06:24:05PM -0700, Daniel Xu wrote:
> > === Description ===
> > 
> > This is a bpf-treewide change that annotates all kfuncs as such inside
> > .BTF_ids. This annotation eventually allows us to automatically generate
> > kfunc prototypes from bpftool.
> > 
> > We store this metadata inside a yet-unused flags field inside struct
> > btf_id_set8 (thanks Kumar!). pahole will be taught where to look.
> > 
> > More details about the full chain of events are available in commit 3's
> > description.
> > 
> > The accompanying pahole and bpftool changes can be viewed
> > here on these "frozen" branches [0][1].
> > 
> > [0]: https://github.com/danobi/pahole/tree/kfunc_btf-v3-mailed
> > [1]: https://github.com/danobi/linux/tree/kfunc_bpftool-mailed
> 
> 
> I hit a similar issue to [0] on master
> 943b043aeecc ("selftests/bpf: Fix bench runner SIGSEGV")
>  when cross-compiling on x86_64 (LE) to s390x (BE).
> I do have CONFIG_DEBUG_INFO_BTF enable and the issue would not trigger if
> I disabled CONFIG_DEBUG_INFO_BTF (and with the fix mentioned in [0]).
> 
> What seems to happen is that `tools/resolve_btfids` is ran in the context of the
> host endianess and if I printk before the WARN_ON:
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index ef380e546952..a9ed7a1a4936 100644
>   --- a/kernel/bpf/btf.c
>   +++ b/kernel/bpf/btf.c
>   @@ -8128,6 +8128,7 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
>            * WARN() for initcall registrations that do not check errors.
>            */
>           if (!(kset->set->flags & BTF_SET8_KFUNCS)) {
>   +        printk("Flag 0x%08X, expected 0x%08X\n", kset->set->flags, BTF_SET8_KFUNCS);
>                   WARN_ON(!kset->owner);
>                   return -EINVAL;
>           }
> 
> the boot logs would show:
>   Flag 0x01000000, expected 0x00000001
> 
> The issue did not happen prior to
> 6f3189f38a3e ("bpf: treewide: Annotate BPF kfuncs in BTF")
> has only 0 was written before.
> 
> It seems [1] will be addressing cross-compilation, but it did not fix it as is
> by just applying on top of master, so probably some of the changes will also need
> to be ported to `tools/include/linux/btf_ids.h`?
> 
> A hacky workaround to cross-compilation I have is to apply:
> 
>   diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
>   index 4b8079f294f6..b706e7ab066f 100644
>   --- a/tools/bpf/resolve_btfids/Makefile
>   +++ b/tools/bpf/resolve_btfids/Makefile
>   @@ -22,10 +22,10 @@ HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)
>                     CROSS_COMPILE="" EXTRA_CFLAGS="$(HOSTCFLAGS)"
>    RM      ?= rm
>   -HOSTCC  ?= gcc
>   -HOSTLD  ?= ld
>   -HOSTAR  ?= ar
>   -CROSS_COMPILE =
>   +HOSTCC  = $(CC)
>   +HOSTLD  = $(LD)
>   +HOSTAR  = $(AR)
>   +#CROSS_COMPILE =
>    OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
>   @@ -56,16 +56,16 @@ $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
>    $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
>           $(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(SUBCMD_OUT) \
>   -                   DESTDIR=$(SUBCMD_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
>   +                   DESTDIR=$(SUBCMD_DESTDIR) prefix= subdir= \
>                       $(abspath $@) install_headers
>    $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUT)
>           $(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(LIBBPF_OUT)    \
>   -                   DESTDIR=$(LIBBPF_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
>   +                   DESTDIR=$(LIBBPF_DESTDIR) prefix= subdir= \
>                       $(abspath $@) install_headers
>   -LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
>   -LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
>   +LIBELF_FLAGS := $(shell $(PKG_CONFIG) libelf --cflags 2>/dev/null)
>   +LIBELF_LIBS  := $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
>    HOSTCFLAGS_resolve_btfids += -g \
>              -I$(srctree)/tools/include \
>   @@ -84,7 +84,7 @@ $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
>    $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
>           $(call msg,LINK,$@)
>   -       $(Q)$(HOSTCC) $(BINARY_IN) $(KBUILD_HOSTLDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDOBJ) $(LIBS)
>   +       $(Q)$(CC) $(BINARY_IN) $(KBUILD_HOSTLDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDOBJ) $(LIBS)
>    clean_objects := $(wildcard $(OUTPUT)/*.o                \
>                                $(OUTPUT)/.*.o.cmd           \
>   diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>   index a38a3001527c..5cd193c04448 100644
>   --- a/tools/testing/selftests/bpf/Makefile
>   +++ b/tools/testing/selftests/bpf/Makefile
>   @@ -171,7 +171,7 @@ INCLUDE_DIR := $(SCRATCH_DIR)/include
>    BPFOBJ := $(BUILD_DIR)/libbpf/libbpf.a
>    ifneq ($(CROSS_COMPILE),)
>    HOST_BUILD_DIR         := $(BUILD_DIR)/host
>   -HOST_SCRATCH_DIR       := $(OUTPUT)/host-tools
>   +HOST_SCRATCH_DIR       := $(SCRATCH_DIR)
>    HOST_INCLUDE_DIR       := $(HOST_SCRATCH_DIR)/include
>    else
>    HOST_BUILD_DIR         := $(BUILD_DIR)
> 
> This causes `resolve_btfids` to be compiled in the target endianess and gets
> magically run provided that the hosts has `qemu-s390x-static` and a functional
> binfmt_misc [2] on the host, but having this using host architecture per [1]
> is likely better.

This is kinda surprising to me. I don't recall seeing any code inside
resolve_btfids that touches the set8 flags field -- only the ids in the
flexible array member. Would be interested to see what the value of the
set8 flags field is before resolve_btfids is run.

I'm a bit busy until Sunday afternoon but I'll try to take a look around
then. Might be a good opportunity to play with poke [0].

Thanks,
Daniel


[0]: http://www.jemarch.net/poke

