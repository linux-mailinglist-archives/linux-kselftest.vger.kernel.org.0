Return-Path: <linux-kselftest+bounces-4054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8387847CE9
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 00:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8C01C234E8
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 23:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6C612C7EF;
	Fri,  2 Feb 2024 23:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oti5Grmb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1D1126F2E;
	Fri,  2 Feb 2024 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706915351; cv=none; b=RY/cVo60Sf2Y2iHg0xmQHW/6f4QxcvXdC7JlWs2htcRikVL4Y1mU2j3jP95bnPBjDi3P2Ru1yW6nIvpzX0/mpsXJ8KFUfc3bVHdPtxOrppLSCDYtUjtzQ1RfSb8qBfOiciJ/+BJdrCC38pI2PmyEYkt3W4LNQ88WZj2ZYaVKKpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706915351; c=relaxed/simple;
	bh=Wo7+jDfk5sZHf8MlrGXUXrmEpHHugcRqmAit0yROqao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAk5EXHev6d39bB0XVN6DpaLApfwzIgpZk4fKpGuQhiAWLmGQqgNCUlr0MlKDKv9/AZaZPwvIo8/S1/2u3aq+QKykL91aZAiWKe3X7EeRvJj3KX8PLzJSIUOHKwzt6EfJwZdRPyulMbiLx8WqUN9gvXgWwAmxnx7w4VhAq6YOtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oti5Grmb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d73066880eso22707665ad.3;
        Fri, 02 Feb 2024 15:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706915349; x=1707520149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ns/bvPkKWqK4cT5hwWAJS7KQis8SRbW6Visd6BLTiUI=;
        b=Oti5Grmb+FX3pffdtZQhqx/Tdi7NzpBBggod79wgb9rLNDFh/ZhoWUKAX6bKD/InbI
         VtrsuECkASUfC7nwkKwB6DTR5f2CKqYw3iN44mSfTjY8UYOX3lXqtRY/ZQw2yoSC4CzH
         znsNzQC+unksr8nEFMtHPGAbOAcU/ogQ3eE8OupkZn3f8VIU1HlX5UjsM1akkKVyUCF9
         M2HpPPq0LYRwRXQ/7MrX812nQkLH6moptx+83fn8OGnaSuM4eSprJsKhXkFvWKyVdkU8
         xG14TBQah2G/jpSTx2whi0E/qrWb9hChs09fE8RxEdtm1UxtoPa144Ur9RnGqe0RJpa3
         UdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706915349; x=1707520149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ns/bvPkKWqK4cT5hwWAJS7KQis8SRbW6Visd6BLTiUI=;
        b=IIyZAwUD6hrnLwWowj7TCQj3ka+HjAeIK1BCcIjbDWYspeqktsVDEAFXmDtKa5uFJC
         BfCMMUNp9HdM4McEsB5CkNelkz/C89/ev3psbiNZmjBmVON8cgKZvxT4Gg0GPoLkXpu4
         q3fdlkZ33B9IXd/joT4SWZ42hihXJfwmgpODzps5KIKgy4JkCeHxtcZrGbmdm716A5G3
         4/T13wrMQOdlnV7BkQmiaegKNCZysGdtw+OQCa5PozphDv1jivUj4LibfsV5I7A5BLDG
         lCx9KmjTT0Zr5MdSNYA2FTWE2cfb9FgLMDZTw/tcpt+0IFmhosbklTJfIlV0edZ7ra6L
         c71g==
X-Gm-Message-State: AOJu0YyzvhhN1H8eWGv1JoHVz9PSFJXNLlGu0t8lOJJgLWVS1nIwJi+E
	3QncgSz2tyI8x2uCv2P+Wah4qxyUHacPmBwCxwTFws+SznUIcKbC
X-Google-Smtp-Source: AGHT+IFxxTOrsdYhKRWr9e6jHbv8TCklGcEQIE8BSnW/BV4FuD23/hWYjE901pv5pKGyJLGFlLZjBQ==
X-Received: by 2002:a17:902:b194:b0:1d5:c08e:52eb with SMTP id s20-20020a170902b19400b001d5c08e52ebmr8168069plr.65.1706915348583;
        Fri, 02 Feb 2024 15:09:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXh8AopKfi/YqWmfKiAwlQ/PCijITod0oFhPh7EZgbe4IqqVCTYplEzVZLk725jsEN7/jjrF3+q6jwqjZIAWgtFJwhn9qmdKmzSh1WTQWyzKIR3Vu1RR9VOQ/mVdMEOrdQtYnhjryw1mdCQexA9JgKi6G6x/jm8n0qLhDny1Uyh9vw8IV8OyRb46UVpGGduitQ9ram54QIx/Q4+QDflTEF+IDMbGP6LDutZoBqdGyGeIDaHWDuGJjeQGgpi3kWxY6Mxokz3ztlOAqOGqeQDd+PFxUQapdW8eUtWM9krlaYdDID3UIGv6Ao+xrLQWDCxkdxkdWrDdbxlfq5IiqlrLk7HA0UnJpJ4jkFfgWd75iHDEi8ZdxAD0XE06DRBlvejpEon3X1Owg03SqEYrAL6rJdyOqiuNnhveN6rok4raRhfJSFqktdoCqF5aru6yMErGbiCNxd0+0aDnqt1T1XYbEGqcirlu5DKCtQ6o6ulW7Vylya1gXBRqZMMo8UuNV9ealWnc8Uf9Vfw1XOhHZ4j41gYSibJO6X/qQ9m3wUuH/DVujlBkGxKAkVqWMc+Wc4KsIxm/EtloqOHI0LTPMMffFTsW5xMa5t9igm/5IU1NvJ0UaL1KXIbvnzxQdLod4WO3cP7eM+SLAzmpsRCYZ37BA3OS0HH2DSw/vYCAqccICCfyklhIqIq0wBZrEXbqubqWvBOtecAaQ==
Received: from surya ([70.134.61.176])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902d48900b001d9557f6c04sm2086428plg.267.2024.02.02.15.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 15:09:08 -0800 (PST)
Date: Fri, 2 Feb 2024 15:09:05 -0800
From: Manu Bretelle <chantr4@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: linux-trace-kernel@vger.kernel.org, coreteam@netfilter.org,
	bpf@vger.kernel.org, linux-input@vger.kernel.org,
	cgroups@vger.kernel.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	fsverity@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netfilter-devel@vger.kernel.org, alexei.starovoitov@gmail.com,
	olsajiri@gmail.com, quentin@isovalent.com, alan.maguire@oracle.com,
	memxor@gmail.com, vmalik@redhat.com
Subject: Re: [PATCH bpf-next v4 0/3] Annotate kfuncs in .BTF_ids section
Message-ID: <Zb12EZt0BAKOPBk/@surya>
References: <cover.1706491398.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1706491398.git.dxu@dxuuu.xyz>

On Sun, Jan 28, 2024 at 06:24:05PM -0700, Daniel Xu wrote:
> === Description ===
> 
> This is a bpf-treewide change that annotates all kfuncs as such inside
> .BTF_ids. This annotation eventually allows us to automatically generate
> kfunc prototypes from bpftool.
> 
> We store this metadata inside a yet-unused flags field inside struct
> btf_id_set8 (thanks Kumar!). pahole will be taught where to look.
> 
> More details about the full chain of events are available in commit 3's
> description.
> 
> The accompanying pahole and bpftool changes can be viewed
> here on these "frozen" branches [0][1].
> 
> [0]: https://github.com/danobi/pahole/tree/kfunc_btf-v3-mailed
> [1]: https://github.com/danobi/linux/tree/kfunc_bpftool-mailed


I hit a similar issue to [0] on master
943b043aeecc ("selftests/bpf: Fix bench runner SIGSEGV")
 when cross-compiling on x86_64 (LE) to s390x (BE).
I do have CONFIG_DEBUG_INFO_BTF enable and the issue would not trigger if
I disabled CONFIG_DEBUG_INFO_BTF (and with the fix mentioned in [0]).

What seems to happen is that `tools/resolve_btfids` is ran in the context of the
host endianess and if I printk before the WARN_ON:
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ef380e546952..a9ed7a1a4936 100644
  --- a/kernel/bpf/btf.c
  +++ b/kernel/bpf/btf.c
  @@ -8128,6 +8128,7 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
           * WARN() for initcall registrations that do not check errors.
           */
          if (!(kset->set->flags & BTF_SET8_KFUNCS)) {
  +        printk("Flag 0x%08X, expected 0x%08X\n", kset->set->flags, BTF_SET8_KFUNCS);
                  WARN_ON(!kset->owner);
                  return -EINVAL;
          }

the boot logs would show:
  Flag 0x01000000, expected 0x00000001

The issue did not happen prior to
6f3189f38a3e ("bpf: treewide: Annotate BPF kfuncs in BTF")
has only 0 was written before.

It seems [1] will be addressing cross-compilation, but it did not fix it as is
by just applying on top of master, so probably some of the changes will also need
to be ported to `tools/include/linux/btf_ids.h`?

A hacky workaround to cross-compilation I have is to apply:

  diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
  index 4b8079f294f6..b706e7ab066f 100644
  --- a/tools/bpf/resolve_btfids/Makefile
  +++ b/tools/bpf/resolve_btfids/Makefile
  @@ -22,10 +22,10 @@ HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)
                    CROSS_COMPILE="" EXTRA_CFLAGS="$(HOSTCFLAGS)"
   RM      ?= rm
  -HOSTCC  ?= gcc
  -HOSTLD  ?= ld
  -HOSTAR  ?= ar
  -CROSS_COMPILE =
  +HOSTCC  = $(CC)
  +HOSTLD  = $(LD)
  +HOSTAR  = $(AR)
  +#CROSS_COMPILE =
   OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
  @@ -56,16 +56,16 @@ $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
   $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
          $(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(SUBCMD_OUT) \
  -                   DESTDIR=$(SUBCMD_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
  +                   DESTDIR=$(SUBCMD_DESTDIR) prefix= subdir= \
                      $(abspath $@) install_headers
   $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUT)
          $(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(LIBBPF_OUT)    \
  -                   DESTDIR=$(LIBBPF_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
  +                   DESTDIR=$(LIBBPF_DESTDIR) prefix= subdir= \
                      $(abspath $@) install_headers
  -LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
  -LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
  +LIBELF_FLAGS := $(shell $(PKG_CONFIG) libelf --cflags 2>/dev/null)
  +LIBELF_LIBS  := $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
   HOSTCFLAGS_resolve_btfids += -g \
             -I$(srctree)/tools/include \
  @@ -84,7 +84,7 @@ $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
   $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
          $(call msg,LINK,$@)
  -       $(Q)$(HOSTCC) $(BINARY_IN) $(KBUILD_HOSTLDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDOBJ) $(LIBS)
  +       $(Q)$(CC) $(BINARY_IN) $(KBUILD_HOSTLDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDOBJ) $(LIBS)
   clean_objects := $(wildcard $(OUTPUT)/*.o                \
                               $(OUTPUT)/.*.o.cmd           \
  diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
  index a38a3001527c..5cd193c04448 100644
  --- a/tools/testing/selftests/bpf/Makefile
  +++ b/tools/testing/selftests/bpf/Makefile
  @@ -171,7 +171,7 @@ INCLUDE_DIR := $(SCRATCH_DIR)/include
   BPFOBJ := $(BUILD_DIR)/libbpf/libbpf.a
   ifneq ($(CROSS_COMPILE),)
   HOST_BUILD_DIR         := $(BUILD_DIR)/host
  -HOST_SCRATCH_DIR       := $(OUTPUT)/host-tools
  +HOST_SCRATCH_DIR       := $(SCRATCH_DIR)
   HOST_INCLUDE_DIR       := $(HOST_SCRATCH_DIR)/include
   else
   HOST_BUILD_DIR         := $(BUILD_DIR)

This causes `resolve_btfids` to be compiled in the target endianess and gets
magically run provided that the hosts has `qemu-s390x-static` and a functional
binfmt_misc [2] on the host, but having this using host architecture per [1]
is likely better.

Here are steps to reproduce the issue on Ubuntu 23.10 and assuming
danobi/vmtest [3] is installed:

  XPLATFORM="s390x"
  XARCH="s390"
  # Set up repo for s390x
  cat <<EOF >> /etc/apt/sources.list.d/s390x.list
  deb [arch=s390x] http://ports.ubuntu.com/ubuntu-ports  mantic main restricted
  deb [arch=s390x] http://ports.ubuntu.com/ubuntu-ports  mantic-updates main restricted
  EOF
  sudo dpkg --add-architecture s390x
  
  apt install qemu-system-s390x qemu-user-static g{cc,++}-"${XARCH}-linux-gnu" {libelf-dev,libssl-dev,pkgconf}:s390x
  
  KBUILD_OUTPUT_DIR="/tmp/kbuild-${XPLATFORM}"
  mkdir "${KBUILD_OUTPUT_DIR}"
  cat tools/testing/selftests/bpf/config{,.vm,.${XPLATFORM}} > ${KBUILD_OUTPUT_DIR}/.config
  
  make ARCH="${XARCH}" CROSS_COMPILE="${XPLATFORM}-linux-gnu-" O="${KBUILD_OUTPUT_DIR}"  -j$((4 * $(nproc))) olddefconfig
  make ARCH="${XARCH}" CROSS_COMPILE="${XPLATFORM}-linux-gnu-" O="${KBUILD_OUTPUT_DIR}"  -j$((4 * $(nproc))) all
  
  # No need for a s390x ubuntu 23.10 rootfs, we only care about booting the kernel
  vmtest -k "${KBUILD_OUTPUT_DIR}/arch/s390/boot/bzImage" -a s390x "uname -m" | cat


For the chroot route, see [4].

[0] https://lore.kernel.org/linux-kernel/20240201155339.2b5936be@canb.auug.org.au/T/
[1] https://lore.kernel.org/bpf/cover.1706717857.git.vmalik@redhat.com/
[2] https://en.wikipedia.org/wiki/Binfmt_misc
[3] https://github.com/danobi/vmtest
[4] https://chantra.github.io/bpfcitools/bpf-cross-compile.html

Manu

> 
> === Changelog ===
> 
> Changes from v3:
> * Rebase to bpf-next and add missing annotation on new kfunc
> 
> Changes from v2:
> * Only WARN() for vmlinux kfuncs
> 
> Changes from v1:
> * Move WARN_ON() up a call level
> * Also return error when kfunc set is not properly tagged
> * Use BTF_KFUNCS_START/END instead of flags
> * Rename BTF_SET8_KFUNC to BTF_SET8_KFUNCS
> 
> Daniel Xu (3):
>   bpf: btf: Support flags for BTF_SET8 sets
>   bpf: btf: Add BTF_KFUNCS_START/END macro pair
>   bpf: treewide: Annotate BPF kfuncs in BTF
> 
>  Documentation/bpf/kfuncs.rst                  |  8 +++----
>  drivers/hid/bpf/hid_bpf_dispatch.c            |  8 +++----
>  fs/verity/measure.c                           |  4 ++--
>  include/linux/btf_ids.h                       | 21 +++++++++++++++----
>  kernel/bpf/btf.c                              |  8 +++++++
>  kernel/bpf/cpumask.c                          |  4 ++--
>  kernel/bpf/helpers.c                          |  8 +++----
>  kernel/bpf/map_iter.c                         |  4 ++--
>  kernel/cgroup/rstat.c                         |  4 ++--
>  kernel/trace/bpf_trace.c                      |  8 +++----
>  net/bpf/test_run.c                            |  8 +++----
>  net/core/filter.c                             | 20 +++++++++---------
>  net/core/xdp.c                                |  4 ++--
>  net/ipv4/bpf_tcp_ca.c                         |  4 ++--
>  net/ipv4/fou_bpf.c                            |  4 ++--
>  net/ipv4/tcp_bbr.c                            |  4 ++--
>  net/ipv4/tcp_cubic.c                          |  4 ++--
>  net/ipv4/tcp_dctcp.c                          |  4 ++--
>  net/netfilter/nf_conntrack_bpf.c              |  4 ++--
>  net/netfilter/nf_nat_bpf.c                    |  4 ++--
>  net/xfrm/xfrm_interface_bpf.c                 |  4 ++--
>  net/xfrm/xfrm_state_bpf.c                     |  4 ++--
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  8 +++----
>  23 files changed, 87 insertions(+), 66 deletions(-)
> 
> -- 
> 2.42.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

