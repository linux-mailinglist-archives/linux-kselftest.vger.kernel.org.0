Return-Path: <linux-kselftest+bounces-29596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD1AA6C5FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 23:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295C018955B6
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 22:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6A7231A30;
	Fri, 21 Mar 2025 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMxpGn3o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4701F4183;
	Fri, 21 Mar 2025 22:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742596190; cv=none; b=ie2WTJlC97bsGl6HyvUvK2gAQQQ8a8cirg1huHht8U0812G5xTiieBmHSx8iBlNGdht+U0kGKV7EZ0WiO/NFx7nmT4UrOtU88aZqiXsA/gnOttF4gKw8E90GUP3GD2vsgBd6r1qksz2vs12Awo2O2rw/G3KfiX6aOuK7AnPGvNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742596190; c=relaxed/simple;
	bh=MJnjYRN0LEgZ0tEihdscwvdV0tOUjsMvYyVAybCBfrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/XiFFkjy/J2on3gGe+bmEzMY+rUAiDyin+GN5fFbDA4CCT2WxNxLW44HiipxM97wpErRmwmlgCbgvCVOESPlMIpDGT/xfY6NGx4MdqwgIyz95auFkI1L2C9aN8+ucVWz9n+VQzB5wKSO1pxla8QJ6RcgMTR7dPuTZa/FyttAJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMxpGn3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20994C4CEE3;
	Fri, 21 Mar 2025 22:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742596189;
	bh=MJnjYRN0LEgZ0tEihdscwvdV0tOUjsMvYyVAybCBfrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OMxpGn3onwmLIr77R5VCSx0MSVLUoWdyEI5YyV8/340EtL25+O9CmgCQbs58z7GS6
	 Eu2W/kH7WuBbwSlzUpNTnqOn2sCvwl5ubNzAKZFwE7zALPjs4tmFcNZbzKTr+uK0+d
	 0Y0Nz3fqVRYxtEFgdDwTBp+n9KPviSIVufjk3itXnJFTHj7nEoWPUd+3r7BZ0yE9mx
	 aeBDTwstoJ2uAOP7v/q9l1xzG59uyII/F5Ze/n/QJAbAsecaXZonfujWsFbGwHG/Oi
	 r2YI3b7idxY3BPi6OFHwdjXr8irY4rz/IyRI1TIWoJRsUz4NBtHx+fjoUANRtfaBZd
	 rPFyZxVCiO3NA==
Date: Fri, 21 Mar 2025 22:29:40 +0000
From: sergeh@kernel.org
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jan Stancek <jstancek@redhat.com>, Neal Gompa <neal@gompa.dev>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev, nkapron@google.com, teknoraver@meta.com,
	roberto.sassu@huawei.com, xiyou.wangcong@gmail.com
Subject: Re: [RFC PATCH security-next 1/4] security: Hornet LSM
Message-ID: <Z93oVD96C3Cvc4ps@lei>
References: <20250321164537.16719-1-bboscaccy@linux.microsoft.com>
 <20250321164537.16719-2-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321164537.16719-2-bboscaccy@linux.microsoft.com>

On Fri, Mar 21, 2025 at 09:45:03AM -0700, Blaise Boscaccy wrote:
> This adds the Hornet Linux Security Module which provides signature
> verification of eBPF programs.
> 
> Hornet uses a similar signature verification scheme similar to that of

used 'similar' twice

> kernel modules. A pkcs#7 signature is appended to the end of an
> executable file. During an invocation of bpf_prog_load, the signature
> is fetched from the current task's executable file. That signature is
> used to verify the integrity of the bpf instructions and maps which
> where passed into the kernel. Additionally, Hornet implicitly trusts any

s/where/were

> programs which where loaded from inside kernel rather than userspace,

s/where/were

> which allows BPF_PRELOAD programs along with outputs for BPF_SYSCALL
> programs to run.
> 
> Hornet allows users to continue to maintain an invariant that all code
> running inside of the kernel has been signed and works well with
> light-skeleton based loaders, or any statically generated program that
> doesn't require userspace instruction rewriting.
> 
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  Documentation/admin-guide/LSM/Hornet.rst |  51 +++++
>  crypto/asymmetric_keys/pkcs7_verify.c    |  10 +
>  include/linux/kernel_read_file.h         |   1 +
>  include/linux/verification.h             |   1 +
>  include/uapi/linux/lsm.h                 |   1 +
>  security/Kconfig                         |   3 +-
>  security/Makefile                        |   1 +
>  security/hornet/Kconfig                  |  11 ++
>  security/hornet/Makefile                 |   4 +
>  security/hornet/hornet_lsm.c             | 239 +++++++++++++++++++++++
>  10 files changed, 321 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/admin-guide/LSM/Hornet.rst
>  create mode 100644 security/hornet/Kconfig
>  create mode 100644 security/hornet/Makefile
>  create mode 100644 security/hornet/hornet_lsm.c
> 
> diff --git a/Documentation/admin-guide/LSM/Hornet.rst b/Documentation/admin-guide/LSM/Hornet.rst
> new file mode 100644
> index 0000000000000..fa112412638f1
> --- /dev/null
> +++ b/Documentation/admin-guide/LSM/Hornet.rst
> @@ -0,0 +1,51 @@
> +======
> +Hornet
> +======
> +
> +Hornet is a Linux Security Module that provides signature verification
> +for eBPF programs. This is selectable at build-time with
> +``CONFIG_SECURITY_HORNET``.
> +
> +Overview
> +========
> +
> +Hornet provides signature verification for eBPF programs by utilizing
> +the existing PKCS#7 infrastructure that's used for module signature
> +verification. Hornet works by creating a buffer containing the eBPF
> +program instructions along with its associated maps and checking a
> +signature against that buffer. The signature is appended to the end of
> +the lskel executable file and is extracted at runtime via
> +get_task_exe_file. Hornet works by hooking into the
> +security_bpf_prog_load hook. Load invocations that originate from the
> +kernel (bpf preload, results of bpf_syscall programs, etc.) are
> +allowed to run unconditionally. Calls that originate from userspace
> +require signature verification. If signature verification fails, the
> +program will fail to load.
> +
> +Instruction/Map Ordering
> +========================
> +
> +Hornet supports both sparse-array based maps via map discovery along
> +with the newly added fd_array_cnt API for continuous map arrays. The
> +buffer used for signature verification is assumed to be the
> +instructions followed by all maps used, ordered by their index in
> +fd_array.
> +
> +Tooling
> +=======
> +
> +Some tooling is provided to aid with the development of signed eBPF lskels.
> +
> +extract-skel.sh
> +---------------
> +
> +This simple shell script extracts the instructions and map data used
> +by the light skeleton from the autogenerated header file created by
> +bpftool.
> +
> +sign-ebpf
> +---------
> +
> +sign-ebpf works similarly to the sign-file script with one key
> +difference: it takes a separate input binary used for signature
> +verification and will append the signature to a different output file.
> diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
> index f0d4ff3c20a83..1a5fbb3612188 100644
> --- a/crypto/asymmetric_keys/pkcs7_verify.c
> +++ b/crypto/asymmetric_keys/pkcs7_verify.c
> @@ -428,6 +428,16 @@ int pkcs7_verify(struct pkcs7_message *pkcs7,
>  		}
>  		/* Authattr presence checked in parser */
>  		break;
> +	case VERIFYING_EBPF_SIGNATURE:
> +		if (pkcs7->data_type != OID_data) {
> +			pr_warn("Invalid ebpf sig (not pkcs7-data)\n");
> +			return -EKEYREJECTED;
> +		}
> +		if (pkcs7->have_authattrs) {
> +			pr_warn("Invalid ebpf sig (has authattrs)\n");
> +			return -EKEYREJECTED;
> +		}
> +		break;
>  	case VERIFYING_UNSPECIFIED_SIGNATURE:
>  		if (pkcs7->data_type != OID_data) {
>  			pr_warn("Invalid unspecified sig (not pkcs7-data)\n");
> diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
> index 90451e2e12bd1..7ed9337be5423 100644
> --- a/include/linux/kernel_read_file.h
> +++ b/include/linux/kernel_read_file.h
> @@ -14,6 +14,7 @@
>  	id(KEXEC_INITRAMFS, kexec-initramfs)	\
>  	id(POLICY, security-policy)		\
>  	id(X509_CERTIFICATE, x509-certificate)	\
> +	id(EBPF, ebpf)				\
>  	id(MAX_ID, )
>  
>  #define __fid_enumify(ENUM, dummy) READING_ ## ENUM,
> diff --git a/include/linux/verification.h b/include/linux/verification.h
> index 4f3022d081c31..812be8ad5f744 100644
> --- a/include/linux/verification.h
> +++ b/include/linux/verification.h
> @@ -35,6 +35,7 @@ enum key_being_used_for {
>  	VERIFYING_KEXEC_PE_SIGNATURE,
>  	VERIFYING_KEY_SIGNATURE,
>  	VERIFYING_KEY_SELF_SIGNATURE,
> +	VERIFYING_EBPF_SIGNATURE,
>  	VERIFYING_UNSPECIFIED_SIGNATURE,
>  	NR__KEY_BEING_USED_FOR
>  };
> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> index 938593dfd5daf..2ff9bcdd551e2 100644
> --- a/include/uapi/linux/lsm.h
> +++ b/include/uapi/linux/lsm.h
> @@ -65,6 +65,7 @@ struct lsm_ctx {
>  #define LSM_ID_IMA		111
>  #define LSM_ID_EVM		112
>  #define LSM_ID_IPE		113
> +#define LSM_ID_HORNET		114
>  
>  /*
>   * LSM_ATTR_XXX definitions identify different LSM attributes
> diff --git a/security/Kconfig b/security/Kconfig
> index f10dbf15c2947..0030f0224c7ab 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -230,6 +230,7 @@ source "security/safesetid/Kconfig"
>  source "security/lockdown/Kconfig"
>  source "security/landlock/Kconfig"
>  source "security/ipe/Kconfig"
> +source "security/hornet/Kconfig"
>  
>  source "security/integrity/Kconfig"
>  
> @@ -273,7 +274,7 @@ config LSM
>  	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,ipe,bpf" if DEFAULT_SECURITY_APPARMOR
>  	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,ipe,bpf" if DEFAULT_SECURITY_TOMOYO
>  	default "landlock,lockdown,yama,loadpin,safesetid,ipe,bpf" if DEFAULT_SECURITY_DAC
> -	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,ipe,bpf"
> +	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,ipe,hornet,bpf"
>  	help
>  	  A comma-separated list of LSMs, in initialization order.
>  	  Any LSMs left off this list, except for those with order
> diff --git a/security/Makefile b/security/Makefile
> index 22ff4c8bd8cec..e24bccd951f88 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
>  obj-$(CONFIG_BPF_LSM)			+= bpf/
>  obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
>  obj-$(CONFIG_SECURITY_IPE)		+= ipe/
> +obj-$(CONFIG_SECURITY_HORNET)		+= hornet/
>  
>  # Object integrity file lists
>  obj-$(CONFIG_INTEGRITY)			+= integrity/
> diff --git a/security/hornet/Kconfig b/security/hornet/Kconfig
> new file mode 100644
> index 0000000000000..19406aa237ac6
> --- /dev/null
> +++ b/security/hornet/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config SECURITY_HORNET
> +	bool "Hornet support"
> +	depends on SECURITY
> +	default n
> +	help
> +	  This selects Hornet.
> +	  Further information can be found in
> +	  Documentation/admin-guide/LSM/Hornet.rst.
> +
> +	  If you are unsure how to answer this question, answer N.
> diff --git a/security/hornet/Makefile b/security/hornet/Makefile
> new file mode 100644
> index 0000000000000..79f4657b215fa
> --- /dev/null
> +++ b/security/hornet/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_SECURITY_HORNET) := hornet.o
> +
> +hornet-y := hornet_lsm.o
> diff --git a/security/hornet/hornet_lsm.c b/security/hornet/hornet_lsm.c
> new file mode 100644
> index 0000000000000..3616c68b76fbc
> --- /dev/null
> +++ b/security/hornet/hornet_lsm.c
> @@ -0,0 +1,239 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Hornet Linux Security Module
> + *
> + * Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> + *
> + * Copyright (C) 2025 Microsoft Corporation
> + */
> +
> +#include <linux/lsm_hooks.h>
> +#include <uapi/linux/lsm.h>
> +#include <linux/bpf.h>
> +#include <linux/verification.h>
> +#include <crypto/public_key.h>
> +#include <linux/module_signature.h>
> +#include <crypto/pkcs7.h>
> +#include <linux/bpf_verifier.h>
> +#include <linux/sort.h>
> +
> +#define EBPF_SIG_STRING "~eBPF signature appended~\n"
> +
> +struct hornet_maps {
> +	u32 used_idx[MAX_USED_MAPS];
> +	u32 used_map_cnt;
> +	bpfptr_t fd_array;
> +};
> +
> +static int cmp_idx(const void *a, const void *b)
> +{
> +	return *(const u32 *)a - *(const u32 *)b;
> +}
> +
> +static int add_used_map(struct hornet_maps *maps, int idx)
> +{
> +	int i;
> +
> +	for (i = 0; i < maps->used_map_cnt; i++)
> +		if (maps->used_idx[i] == idx)
> +			return i;
> +
> +	if (maps->used_map_cnt >= MAX_USED_MAPS)
> +		return -E2BIG;
> +
> +	maps->used_idx[maps->used_map_cnt] = idx;
> +	return maps->used_map_cnt++;
> +}
> +
> +static int hornet_find_maps(struct bpf_prog *prog, struct hornet_maps *maps)
> +{
> +	struct bpf_insn *insn = prog->insnsi;
> +	int insn_cnt = prog->len;
> +	int i;
> +	int err;
> +
> +	for (i = 0; i < insn_cnt; i++, insn++) {
> +		if (insn[0].code == (BPF_LD | BPF_IMM | BPF_DW)) {
> +			switch (insn[0].src_reg) {
> +			case BPF_PSEUDO_MAP_IDX_VALUE:
> +			case BPF_PSEUDO_MAP_IDX:
> +				err = add_used_map(maps, insn[0].imm);
> +				if (err < 0)
> +					return err;
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +	}
> +	/* Sort the spare-array indices. This should match the map ordering used during
> +	 * signature generation
> +	 */
> +	sort(maps->used_idx, maps->used_map_cnt, sizeof(*maps->used_idx),
> +	     cmp_idx, NULL);
> +
> +	return 0;
> +}
> +
> +static int hornet_populate_fd_array(struct hornet_maps *maps, u32 fd_array_cnt)
> +{
> +	int i;
> +
> +	if (fd_array_cnt > MAX_USED_MAPS)
> +		return -E2BIG;
> +
> +	for (i = 0; i < fd_array_cnt; i++)
> +		maps->used_idx[i] = i;
> +
> +	maps->used_map_cnt = fd_array_cnt;
> +	return 0;
> +}
> +
> +/* kern_sys_bpf is declared as an EXPORT_SYMBOL in kernel/bpf/syscall.c, however no definition is
> + * provided in any bpf header files. If/when this function has a proper definition provided
> + * somewhere this declaration should be removed
> + */
> +int kern_sys_bpf(int cmd, union bpf_attr *attr, unsigned int size);
> +
> +static int hornet_verify_lskel(struct bpf_prog *prog, struct hornet_maps *maps,
> +			       void *sig, size_t sig_len)
> +{
> +	int fd;
> +	u32 i;
> +	void *buf;
> +	void *new;
> +	size_t buf_sz;
> +	struct bpf_map *map;
> +	int err = 0;
> +	int key = 0;
> +	union bpf_attr attr = {0};
> +
> +	buf = kmalloc_array(prog->len, sizeof(struct bpf_insn), GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +	buf_sz = prog->len * sizeof(struct bpf_insn);
> +	memcpy(buf, prog->insnsi, buf_sz);
> +
> +	for (i = 0; i < maps->used_map_cnt; i++) {
> +		err = copy_from_bpfptr_offset(&fd, maps->fd_array,
> +					      maps->used_idx[i] * sizeof(fd),
> +					      sizeof(fd));
> +		if (err < 0)
> +			continue;
> +		if (fd < 1)
> +			continue;
> +
> +		map = bpf_map_get(fd);
> +		if (IS_ERR(map))
> +			continue;
> +
> +		/* don't allow userspace to change map data used for signature verification */
> +		if (!map->frozen) {
> +			attr.map_fd = fd;
> +			err = kern_sys_bpf(BPF_MAP_FREEZE, &attr, sizeof(attr));
> +			if (err < 0)
> +				goto out;
> +		}
> +
> +		new = krealloc(buf, buf_sz + map->value_size, GFP_KERNEL);
> +		if (!new) {
> +			err = -ENOMEM;
> +			goto out;
> +		}
> +		buf = new;
> +		new = map->ops->map_lookup_elem(map, &key);
> +		if (!new) {
> +			err = -ENOENT;
> +			goto out;
> +		}
> +		memcpy(buf + buf_sz, new, map->value_size);
> +		buf_sz += map->value_size;
> +	}
> +
> +	err = verify_pkcs7_signature(buf, buf_sz, sig, sig_len,
> +				     VERIFY_USE_SECONDARY_KEYRING,
> +				     VERIFYING_EBPF_SIGNATURE,
> +				     NULL, NULL);
> +out:
> +	kfree(buf);
> +	return err;
> +}
> +
> +static int hornet_check_binary(struct bpf_prog *prog, union bpf_attr *attr,
> +			       struct hornet_maps *maps)
> +{
> +	struct file *file = get_task_exe_file(current);
> +	const unsigned long markerlen = sizeof(EBPF_SIG_STRING) - 1;
> +	void *buf = NULL;
> +	size_t sz = 0, sig_len, prog_len, buf_sz;
> +	int err = 0;
> +	struct module_signature sig;
> +
> +	buf_sz = kernel_read_file(file, 0, &buf, INT_MAX, &sz, READING_EBPF);
> +	fput(file);
> +	if (!buf_sz)
> +		return -1;
> +
> +	prog_len = buf_sz;
> +
> +	if (prog_len > markerlen &&
> +	    memcmp(buf + prog_len - markerlen, EBPF_SIG_STRING, markerlen) == 0)
> +		prog_len -= markerlen;
> +
> +	memcpy(&sig, buf + (prog_len - sizeof(sig)), sizeof(sig));
> +	sig_len = be32_to_cpu(sig.sig_len);
> +	prog_len -= sig_len + sizeof(sig);
> +
> +	err = mod_check_sig(&sig, prog->len * sizeof(struct bpf_insn), "ebpf");
> +	if (err)
> +		return err;
> +	return hornet_verify_lskel(prog, maps, buf + prog_len, sig_len);
> +}
> +
> +static int hornet_check_signature(struct bpf_prog *prog, union bpf_attr *attr,
> +				  struct bpf_token *token, bool is_kernel)

It's a little confusing that you are passing is_kernel in here, when the
only caller will always pass in true.  Is there a good reason not to
drop the arg here and pass 'true' in to make_bpfptr().  Of course, then
people will ask why not define an IS_KERNEL to true as passing true to
second argument is cryptic...  Maybe you just can't win here :)

> +{
> +	struct hornet_maps maps = {0};
> +	int err;
> +
> +	/* support both sparse arrays and explicit continuous arrays of map fds */
> +	if (attr->fd_array_cnt)
> +		err = hornet_populate_fd_array(&maps, attr->fd_array_cnt);
> +	else
> +		err = hornet_find_maps(prog, &maps);
> +
> +	if (err < 0)
> +		return err;
> +
> +	maps.fd_array = make_bpfptr(attr->fd_array, is_kernel);
> +	return hornet_check_binary(prog, attr, &maps);
> +}
> +
> +static int hornet_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
> +				struct bpf_token *token, bool is_kernel)
> +{
> +	if (is_kernel)
> +		return 0;
> +	return hornet_check_signature(prog, attr, token, is_kernel);
> +}
> +
> +static struct security_hook_list hornet_hooks[] __ro_after_init = {
> +	LSM_HOOK_INIT(bpf_prog_load, hornet_bpf_prog_load),
> +};
> +
> +static const struct lsm_id hornet_lsmid = {
> +	.name = "hornet",
> +	.id = LSM_ID_HORNET,
> +};
> +
> +static int __init hornet_init(void)
> +{
> +	pr_info("Hornet: eBPF signature verification enabled\n");
> +	security_add_hooks(hornet_hooks, ARRAY_SIZE(hornet_hooks), &hornet_lsmid);
> +	return 0;
> +}
> +
> +DEFINE_LSM(hornet) = {
> +	.name = "hornet",
> +	.init = hornet_init,
> +};
> -- 
> 2.48.1
> 

