Return-Path: <linux-kselftest+bounces-3818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1157843B04
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 10:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A8A297545
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 09:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DC064CC8;
	Wed, 31 Jan 2024 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRuDgrFZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EFC219E1;
	Wed, 31 Jan 2024 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706693081; cv=none; b=dS+HLOmrDLK8EHYD6wzXu6fCc2S+kwHF1mv2XOEMBQKxVlFSRFEqfjMl0jQRLOAssStm50BsRRz/Y0mvkxWAkVtD25AP2d505EO4wtHtf3ezTVREbCqirp3S6JnlAqsJpRxBZBg7EBZ+QjLCq4WiJhXwYH4pyvy+wjUVa8uuAnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706693081; c=relaxed/simple;
	bh=KZFKqBLWZ1/kLuDL+SxUSF6Ixjp5trUfQs8QKv8pp9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcPcieLiDv5+nG49V1wwNut/p7TgkL591uFZ61tha2MeGN4AHHOUF2EuG3sx7MaG6yHvJRjKCx76XdsmV1qNXvpFih4fcnRFr+BV2Qs3aNHzKmlSe5OxqFyjEDrx8im9Z6EBj9I6n+duSMTiGB3/wQ/VKYF7B+uzv+r9OasVZ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRuDgrFZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305FBC433C7;
	Wed, 31 Jan 2024 09:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706693080;
	bh=KZFKqBLWZ1/kLuDL+SxUSF6Ixjp5trUfQs8QKv8pp9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CRuDgrFZuEJe9O3YEWQKOh0MS18gVF1MhChG7RKi6R9wq5/CflXq3nRfyRDXmnVfu
	 006rCGPmXQOTt1fqDQ4e6TZGLGQxB7a8PbQTAfRI24yGrVglO+YDuNnXQs4oYmZ0GU
	 spZ/lSD0TaEW76zrekHH9P0m2WMqcaPCWdg5/VEwhjDNW5pu/Z1/Pj+Z6ShSgkzXbK
	 5R8UH4zv4nfkyQAnLqaBTIzwcXME4vY2Y4Hcl59MsR/UMGUt5CnPTGzQa7eN/Fenb3
	 4A+Dfgd3oFCKtsZnX2XrfzrMU144TcyYvh5Qos8wqaUJPdBOjV6YVAf+DpzAOw//QA
	 wmbhiLnGVEOyg==
Date: Wed, 31 Jan 2024 10:24:27 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: mhiramat@kernel.org, daniel@iogearbox.net, edumazet@google.com, 
	fw@strlen.de, hannes@cmpxchg.org, tytso@mit.edu, ast@kernel.org, 
	eddyz87@gmail.com, kuba@kernel.org, tj@kernel.org, steffen.klassert@secunet.com, 
	yonghong.song@linux.dev, hawk@kernel.org, rostedt@goodmis.org, john.fastabend@gmail.com, 
	pablo@netfilter.org, pabeni@redhat.com, jikos@kernel.org, davem@davemloft.net, 
	alexandre.torgue@foss.st.com, Herbert Xu <herbert@gondor.apana.org.au>, song@kernel.org, 
	dsahern@kernel.org, mcoquelin.stm32@gmail.com, corbet@lwn.net, 
	lizefan.x@bytedance.com, andrii@kernel.org, martin.lau@linux.dev, 
	benjamin.tissoires@redhat.com, ebiggers@kernel.org, kadlec@netfilter.org, shuah@kernel.org, 
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, quentin@isovalent.com, 
	alan.maguire@oracle.com, memxor@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, mathieu.desnoyers@efficios.com, mykolal@fb.com, 
	bpf@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, fsverity@lists.linux.dev, cgroups@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, linux-kselftest@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH bpf-next v4 3/3] bpf: treewide: Annotate BPF kfuncs in BTF
Message-ID: <nkiotuubdtzmux4asu674iwacf4yqwekadrwbaggdpv5minima@lye4zetvluqz>
References: <cover.1706491398.git.dxu@dxuuu.xyz>
 <e55150ceecbf0a5d961e608941165c0bee7bc943.1706491398.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e55150ceecbf0a5d961e608941165c0bee7bc943.1706491398.git.dxu@dxuuu.xyz>

On Jan 28 2024, Daniel Xu wrote:
> This commit marks kfuncs as such inside the .BTF_ids section. The upshot
> of these annotations is that we'll be able to automatically generate
> kfunc prototypes for downstream users. The process is as follows:
> 
> 1. In source, use BTF_KFUNCS_START/END macro pair to mark kfuncs
> 2. During build, pahole injects into BTF a "bpf_kfunc" BTF_DECL_TAG for
>    each function inside BTF_KFUNCS sets
> 3. At runtime, vmlinux or module BTF is made available in sysfs
> 4. At runtime, bpftool (or similar) can look at provided BTF and
>    generate appropriate prototypes for functions with "bpf_kfunc" tag
> 
> To ensure future kfunc are similarly tagged, we now also return error
> inside kfunc registration for untagged kfuncs. For vmlinux kfuncs,
> we also WARN(), as initcall machinery does not handle errors.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  Documentation/bpf/kfuncs.rst                  |  8 ++++----
>  drivers/hid/bpf/hid_bpf_dispatch.c            |  8 ++++----

For the HID changes (they shouldn't conflict with our current branch):
Acked-by: Benjamin Tissoires <bentiss@kernel.org>

Cheers,
Benjamin

>  fs/verity/measure.c                           |  4 ++--
>  kernel/bpf/btf.c                              |  8 ++++++++
>  kernel/bpf/cpumask.c                          |  4 ++--
>  kernel/bpf/helpers.c                          |  8 ++++----
>  kernel/bpf/map_iter.c                         |  4 ++--
>  kernel/cgroup/rstat.c                         |  4 ++--
>  kernel/trace/bpf_trace.c                      |  8 ++++----
>  net/bpf/test_run.c                            |  8 ++++----
>  net/core/filter.c                             | 20 +++++++++----------
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
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  8 ++++----
>  22 files changed, 70 insertions(+), 62 deletions(-)
> 
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 7985c6615f3c..a8f5782bd833 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -177,10 +177,10 @@ In addition to kfuncs' arguments, verifier may need more information about the
>  type of kfunc(s) being registered with the BPF subsystem. To do so, we define
>  flags on a set of kfuncs as follows::
>  
> -        BTF_SET8_START(bpf_task_set)
> +        BTF_KFUNCS_START(bpf_task_set)
>          BTF_ID_FLAGS(func, bpf_get_task_pid, KF_ACQUIRE | KF_RET_NULL)
>          BTF_ID_FLAGS(func, bpf_put_pid, KF_RELEASE)
> -        BTF_SET8_END(bpf_task_set)
> +        BTF_KFUNCS_END(bpf_task_set)
>  
>  This set encodes the BTF ID of each kfunc listed above, and encodes the flags
>  along with it. Ofcourse, it is also allowed to specify no flags.
> @@ -347,10 +347,10 @@ Once the kfunc is prepared for use, the final step to making it visible is
>  registering it with the BPF subsystem. Registration is done per BPF program
>  type. An example is shown below::
>  
> -        BTF_SET8_START(bpf_task_set)
> +        BTF_KFUNCS_START(bpf_task_set)
>          BTF_ID_FLAGS(func, bpf_get_task_pid, KF_ACQUIRE | KF_RET_NULL)
>          BTF_ID_FLAGS(func, bpf_put_pid, KF_RELEASE)
> -        BTF_SET8_END(bpf_task_set)
> +        BTF_KFUNCS_END(bpf_task_set)
>  
>          static const struct btf_kfunc_id_set bpf_task_kfunc_set = {
>                  .owner = THIS_MODULE,
> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
> index d9ef45fcaeab..02c441aaa217 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -172,9 +172,9 @@ hid_bpf_get_data(struct hid_bpf_ctx *ctx, unsigned int offset, const size_t rdwr
>   * The following set contains all functions we agree BPF programs
>   * can use.
>   */
> -BTF_SET8_START(hid_bpf_kfunc_ids)
> +BTF_KFUNCS_START(hid_bpf_kfunc_ids)
>  BTF_ID_FLAGS(func, hid_bpf_get_data, KF_RET_NULL)
> -BTF_SET8_END(hid_bpf_kfunc_ids)
> +BTF_KFUNCS_END(hid_bpf_kfunc_ids)
>  
>  static const struct btf_kfunc_id_set hid_bpf_kfunc_set = {
>  	.owner = THIS_MODULE,
> @@ -440,12 +440,12 @@ static const struct btf_kfunc_id_set hid_bpf_fmodret_set = {
>  };
>  
>  /* for syscall HID-BPF */
> -BTF_SET8_START(hid_bpf_syscall_kfunc_ids)
> +BTF_KFUNCS_START(hid_bpf_syscall_kfunc_ids)
>  BTF_ID_FLAGS(func, hid_bpf_attach_prog)
>  BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE)
>  BTF_ID_FLAGS(func, hid_bpf_hw_request)
> -BTF_SET8_END(hid_bpf_syscall_kfunc_ids)
> +BTF_KFUNCS_END(hid_bpf_syscall_kfunc_ids)
>  
>  static const struct btf_kfunc_id_set hid_bpf_syscall_kfunc_set = {
>  	.owner = THIS_MODULE,
> diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> index bf7a5f4cccaf..3969d54158d1 100644
> --- a/fs/verity/measure.c
> +++ b/fs/verity/measure.c
> @@ -159,9 +159,9 @@ __bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_dynptr_ker
>  
>  __bpf_kfunc_end_defs();
>  
> -BTF_SET8_START(fsverity_set_ids)
> +BTF_KFUNCS_START(fsverity_set_ids)
>  BTF_ID_FLAGS(func, bpf_get_fsverity_digest, KF_TRUSTED_ARGS)
> -BTF_SET8_END(fsverity_set_ids)
> +BTF_KFUNCS_END(fsverity_set_ids)
>  
>  static int bpf_get_fsverity_digest_filter(const struct bpf_prog *prog, u32 kfunc_id)
>  {
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index edef96ceffa3..bc446f37530c 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8041,6 +8041,14 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
>  {
>  	enum btf_kfunc_hook hook;
>  
> +	/* All kfuncs need to be tagged as such in BTF.
> +	 * WARN() for initcall registrations that do not check errors.
> +	 */
> +	if (!(kset->set->flags & BTF_SET8_KFUNCS)) {
> +		WARN_ON(!kset->owner);
> +		return -EINVAL;
> +	}
> +
>  	hook = bpf_prog_type_to_kfunc_hook(prog_type);
>  	return __register_btf_kfunc_id_set(hook, kset);
>  }
> diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> index 2e73533a3811..dad0fb1c8e87 100644
> --- a/kernel/bpf/cpumask.c
> +++ b/kernel/bpf/cpumask.c
> @@ -424,7 +424,7 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpumask *cpumask)
>  
>  __bpf_kfunc_end_defs();
>  
> -BTF_SET8_START(cpumask_kfunc_btf_ids)
> +BTF_KFUNCS_START(cpumask_kfunc_btf_ids)
>  BTF_ID_FLAGS(func, bpf_cpumask_create, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_cpumask_release, KF_RELEASE)
>  BTF_ID_FLAGS(func, bpf_cpumask_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
> @@ -450,7 +450,7 @@ BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
>  BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
>  BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
>  BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
> -BTF_SET8_END(cpumask_kfunc_btf_ids)
> +BTF_KFUNCS_END(cpumask_kfunc_btf_ids)
>  
>  static const struct btf_kfunc_id_set cpumask_kfunc_set = {
>  	.owner = THIS_MODULE,
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index bcb951a2ecf4..4db1c658254c 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2544,7 +2544,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>  
>  __bpf_kfunc_end_defs();
>  
> -BTF_SET8_START(generic_btf_ids)
> +BTF_KFUNCS_START(generic_btf_ids)
>  #ifdef CONFIG_KEXEC_CORE
>  BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
>  #endif
> @@ -2573,7 +2573,7 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
>  #endif
>  BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_throw)
> -BTF_SET8_END(generic_btf_ids)
> +BTF_KFUNCS_END(generic_btf_ids)
>  
>  static const struct btf_kfunc_id_set generic_kfunc_set = {
>  	.owner = THIS_MODULE,
> @@ -2589,7 +2589,7 @@ BTF_ID(struct, cgroup)
>  BTF_ID(func, bpf_cgroup_release_dtor)
>  #endif
>  
> -BTF_SET8_START(common_btf_ids)
> +BTF_KFUNCS_START(common_btf_ids)
>  BTF_ID_FLAGS(func, bpf_cast_to_kern_ctx)
>  BTF_ID_FLAGS(func, bpf_rdonly_cast)
>  BTF_ID_FLAGS(func, bpf_rcu_read_lock)
> @@ -2618,7 +2618,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>  BTF_ID_FLAGS(func, bpf_dynptr_size)
>  BTF_ID_FLAGS(func, bpf_dynptr_clone)
> -BTF_SET8_END(common_btf_ids)
> +BTF_KFUNCS_END(common_btf_ids)
>  
>  static const struct btf_kfunc_id_set common_kfunc_set = {
>  	.owner = THIS_MODULE,
> diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
> index 6abd7c5df4b3..9575314f40a6 100644
> --- a/kernel/bpf/map_iter.c
> +++ b/kernel/bpf/map_iter.c
> @@ -213,9 +213,9 @@ __bpf_kfunc s64 bpf_map_sum_elem_count(const struct bpf_map *map)
>  
>  __bpf_kfunc_end_defs();
>  
> -BTF_SET8_START(bpf_map_iter_kfunc_ids)
> +BTF_KFUNCS_START(bpf_map_iter_kfunc_ids)
>  BTF_ID_FLAGS(func, bpf_map_sum_elem_count, KF_TRUSTED_ARGS)
> -BTF_SET8_END(bpf_map_iter_kfunc_ids)
> +BTF_KFUNCS_END(bpf_map_iter_kfunc_ids)
>  
>  static const struct btf_kfunc_id_set bpf_map_iter_kfunc_set = {
>  	.owner = THIS_MODULE,
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index a8350d2d63e6..07e2284bb499 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -562,10 +562,10 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
>  }
>  
>  /* Add bpf kfuncs for cgroup_rstat_updated() and cgroup_rstat_flush() */
> -BTF_SET8_START(bpf_rstat_kfunc_ids)
> +BTF_KFUNCS_START(bpf_rstat_kfunc_ids)
>  BTF_ID_FLAGS(func, cgroup_rstat_updated)
>  BTF_ID_FLAGS(func, cgroup_rstat_flush, KF_SLEEPABLE)
> -BTF_SET8_END(bpf_rstat_kfunc_ids)
> +BTF_KFUNCS_END(bpf_rstat_kfunc_ids)
>  
>  static const struct btf_kfunc_id_set bpf_rstat_kfunc_set = {
>  	.owner          = THIS_MODULE,
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 64fdaf79d113..241ddf5e3895 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1412,14 +1412,14 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
>  
>  __bpf_kfunc_end_defs();
>  
> -BTF_SET8_START(key_sig_kfunc_set)
> +BTF_KFUNCS_START(key_sig_kfunc_set)
>  BTF_ID_FLAGS(func, bpf_lookup_user_key, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_lookup_system_key, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_key_put, KF_RELEASE)
>  #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
>  BTF_ID_FLAGS(func, bpf_verify_pkcs7_signature, KF_SLEEPABLE)
>  #endif
> -BTF_SET8_END(key_sig_kfunc_set)
> +BTF_KFUNCS_END(key_sig_kfunc_set)
>  
>  static const struct btf_kfunc_id_set bpf_key_sig_kfunc_set = {
>  	.owner = THIS_MODULE,
> @@ -1475,9 +1475,9 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
>  
>  __bpf_kfunc_end_defs();
>  
> -BTF_SET8_START(fs_kfunc_set_ids)
> +BTF_KFUNCS_START(fs_kfunc_set_ids)
>  BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
> -BTF_SET8_END(fs_kfunc_set_ids)
> +BTF_KFUNCS_END(fs_kfunc_set_ids)
>  
>  static int bpf_get_file_xattr_filter(const struct bpf_prog *prog, u32 kfunc_id)
>  {
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index dfd919374017..5535f9adc658 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -617,21 +617,21 @@ CFI_NOSEAL(bpf_kfunc_call_memb_release_dtor);
>  
>  __bpf_kfunc_end_defs();
>  
> -BTF_SET8_START(bpf_test_modify_return_ids)
> +BTF_KFUNCS_START(bpf_test_modify_return_ids)
>  BTF_ID_FLAGS(func, bpf_modify_return_test)
>  BTF_ID_FLAGS(func, bpf_modify_return_test2)
>  BTF_ID_FLAGS(func, bpf_fentry_test1, KF_SLEEPABLE)
> -BTF_SET8_END(bpf_test_modify_return_ids)
> +BTF_KFUNCS_END(bpf_test_modify_return_ids)
>  
>  static const struct btf_kfunc_id_set bpf_test_modify_return_set = {
>  	.owner = THIS_MODULE,
>  	.set   = &bpf_test_modify_return_ids,
>  };
>  
> -BTF_SET8_START(test_sk_check_kfunc_ids)
> +BTF_KFUNCS_START(test_sk_check_kfunc_ids)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_release, KF_RELEASE)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_memb_release, KF_RELEASE)
> -BTF_SET8_END(test_sk_check_kfunc_ids)
> +BTF_KFUNCS_END(test_sk_check_kfunc_ids)
>  
>  static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
>  			   u32 size, u32 headroom, u32 tailroom)
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 358870408a51..524adf1fa6d0 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11982,21 +11982,21 @@ int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
>  	return 0;
>  }
>  
> -BTF_SET8_START(bpf_kfunc_check_set_skb)
> +BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
>  BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
> -BTF_SET8_END(bpf_kfunc_check_set_skb)
> +BTF_KFUNCS_END(bpf_kfunc_check_set_skb)
>  
> -BTF_SET8_START(bpf_kfunc_check_set_xdp)
> +BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
>  BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
> -BTF_SET8_END(bpf_kfunc_check_set_xdp)
> +BTF_KFUNCS_END(bpf_kfunc_check_set_xdp)
>  
> -BTF_SET8_START(bpf_kfunc_check_set_sock_addr)
> +BTF_KFUNCS_START(bpf_kfunc_check_set_sock_addr)
>  BTF_ID_FLAGS(func, bpf_sock_addr_set_sun_path)
> -BTF_SET8_END(bpf_kfunc_check_set_sock_addr)
> +BTF_KFUNCS_END(bpf_kfunc_check_set_sock_addr)
>  
> -BTF_SET8_START(bpf_kfunc_check_set_tcp_reqsk)
> +BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk)
>  BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk, KF_TRUSTED_ARGS)
> -BTF_SET8_END(bpf_kfunc_check_set_tcp_reqsk)
> +BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
>  
>  static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
>  	.owner = THIS_MODULE,
> @@ -12075,9 +12075,9 @@ __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
>  
>  __bpf_kfunc_end_defs();
>  
> -BTF_SET8_START(bpf_sk_iter_kfunc_ids)
> +BTF_KFUNCS_START(bpf_sk_iter_kfunc_ids)
>  BTF_ID_FLAGS(func, bpf_sock_destroy, KF_TRUSTED_ARGS)
> -BTF_SET8_END(bpf_sk_iter_kfunc_ids)
> +BTF_KFUNCS_END(bpf_sk_iter_kfunc_ids)
>  
>  static int tracing_iter_filter(const struct bpf_prog *prog, u32 kfunc_id)
>  {
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 4869c1c2d8f3..034fb80f3fbe 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -771,11 +771,11 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
>  
>  __bpf_kfunc_end_defs();
>  
> -BTF_SET8_START(xdp_metadata_kfunc_ids)
> +BTF_KFUNCS_START(xdp_metadata_kfunc_ids)
>  #define XDP_METADATA_KFUNC(_, __, name, ___) BTF_ID_FLAGS(func, name, KF_TRUSTED_ARGS)
>  XDP_METADATA_KFUNC_xxx
>  #undef XDP_METADATA_KFUNC
> -BTF_SET8_END(xdp_metadata_kfunc_ids)
> +BTF_KFUNCS_END(xdp_metadata_kfunc_ids)
>  
>  static const struct btf_kfunc_id_set xdp_metadata_kfunc_set = {
>  	.owner = THIS_MODULE,
> diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
> index 834edc18463a..7f518ea5f4ac 100644
> --- a/net/ipv4/bpf_tcp_ca.c
> +++ b/net/ipv4/bpf_tcp_ca.c
> @@ -201,13 +201,13 @@ bpf_tcp_ca_get_func_proto(enum bpf_func_id func_id,
>  	}
>  }
>  
> -BTF_SET8_START(bpf_tcp_ca_check_kfunc_ids)
> +BTF_KFUNCS_START(bpf_tcp_ca_check_kfunc_ids)
>  BTF_ID_FLAGS(func, tcp_reno_ssthresh)
>  BTF_ID_FLAGS(func, tcp_reno_cong_avoid)
>  BTF_ID_FLAGS(func, tcp_reno_undo_cwnd)
>  BTF_ID_FLAGS(func, tcp_slow_start)
>  BTF_ID_FLAGS(func, tcp_cong_avoid_ai)
> -BTF_SET8_END(bpf_tcp_ca_check_kfunc_ids)
> +BTF_KFUNCS_END(bpf_tcp_ca_check_kfunc_ids)
>  
>  static const struct btf_kfunc_id_set bpf_tcp_ca_kfunc_set = {
>  	.owner = THIS_MODULE,
> diff --git a/net/ipv4/fou_bpf.c b/net/ipv4/fou_bpf.c
> index 4da03bf45c9b..06e5572f296f 100644
> --- a/net/ipv4/fou_bpf.c
> +++ b/net/ipv4/fou_bpf.c
> @@ -100,10 +100,10 @@ __bpf_kfunc int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
>  
>  __bpf_kfunc_end_defs();
>  
> -BTF_SET8_START(fou_kfunc_set)
> +BTF_KFUNCS_START(fou_kfunc_set)
>  BTF_ID_FLAGS(func, bpf_skb_set_fou_encap)
>  BTF_ID_FLAGS(func, bpf_skb_get_fou_encap)
> -BTF_SET8_END(fou_kfunc_set)
> +BTF_KFUNCS_END(fou_kfunc_set)
>  
>  static const struct btf_kfunc_id_set fou_bpf_kfunc_set = {
>  	.owner = THIS_MODULE,
> diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
> index 22358032dd48..05dc2d05bc7c 100644
> --- a/net/ipv4/tcp_bbr.c
> +++ b/net/ipv4/tcp_bbr.c
> @@ -1155,7 +1155,7 @@ static struct tcp_congestion_ops tcp_bbr_cong_ops __read_mostly = {
>  	.set_state	= bbr_set_state,
>  };
>  
> -BTF_SET8_START(tcp_bbr_check_kfunc_ids)
> +BTF_KFUNCS_START(tcp_bbr_check_kfunc_ids)
>  #ifdef CONFIG_X86
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  BTF_ID_FLAGS(func, bbr_init)
> @@ -1168,7 +1168,7 @@ BTF_ID_FLAGS(func, bbr_min_tso_segs)
>  BTF_ID_FLAGS(func, bbr_set_state)
>  #endif
>  #endif
> -BTF_SET8_END(tcp_bbr_check_kfunc_ids)
> +BTF_KFUNCS_END(tcp_bbr_check_kfunc_ids)
>  
>  static const struct btf_kfunc_id_set tcp_bbr_kfunc_set = {
>  	.owner = THIS_MODULE,
> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> index 0fd78ecb67e7..44869ea089e3 100644
> --- a/net/ipv4/tcp_cubic.c
> +++ b/net/ipv4/tcp_cubic.c
> @@ -485,7 +485,7 @@ static struct tcp_congestion_ops cubictcp __read_mostly = {
>  	.name		= "cubic",
>  };
>  
> -BTF_SET8_START(tcp_cubic_check_kfunc_ids)
> +BTF_KFUNCS_START(tcp_cubic_check_kfunc_ids)
>  #ifdef CONFIG_X86
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  BTF_ID_FLAGS(func, cubictcp_init)
> @@ -496,7 +496,7 @@ BTF_ID_FLAGS(func, cubictcp_cwnd_event)
>  BTF_ID_FLAGS(func, cubictcp_acked)
>  #endif
>  #endif
> -BTF_SET8_END(tcp_cubic_check_kfunc_ids)
> +BTF_KFUNCS_END(tcp_cubic_check_kfunc_ids)
>  
>  static const struct btf_kfunc_id_set tcp_cubic_kfunc_set = {
>  	.owner = THIS_MODULE,
> diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
> index bb23bb5b387a..e33fbe4933e4 100644
> --- a/net/ipv4/tcp_dctcp.c
> +++ b/net/ipv4/tcp_dctcp.c
> @@ -260,7 +260,7 @@ static struct tcp_congestion_ops dctcp_reno __read_mostly = {
>  	.name		= "dctcp-reno",
>  };
>  
> -BTF_SET8_START(tcp_dctcp_check_kfunc_ids)
> +BTF_KFUNCS_START(tcp_dctcp_check_kfunc_ids)
>  #ifdef CONFIG_X86
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  BTF_ID_FLAGS(func, dctcp_init)
> @@ -271,7 +271,7 @@ BTF_ID_FLAGS(func, dctcp_cwnd_undo)
>  BTF_ID_FLAGS(func, dctcp_state)
>  #endif
>  #endif
> -BTF_SET8_END(tcp_dctcp_check_kfunc_ids)
> +BTF_KFUNCS_END(tcp_dctcp_check_kfunc_ids)
>  
>  static const struct btf_kfunc_id_set tcp_dctcp_kfunc_set = {
>  	.owner = THIS_MODULE,
> diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
> index 475358ec8212..d2492d050fe6 100644
> --- a/net/netfilter/nf_conntrack_bpf.c
> +++ b/net/netfilter/nf_conntrack_bpf.c
> @@ -467,7 +467,7 @@ __bpf_kfunc int bpf_ct_change_status(struct nf_conn *nfct, u32 status)
>  
>  __bpf_kfunc_end_defs();
>  
> -BTF_SET8_START(nf_ct_kfunc_set)
> +BTF_KFUNCS_START(nf_ct_kfunc_set)
>  BTF_ID_FLAGS(func, bpf_xdp_ct_alloc, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_xdp_ct_lookup, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_skb_ct_alloc, KF_ACQUIRE | KF_RET_NULL)
> @@ -478,7 +478,7 @@ BTF_ID_FLAGS(func, bpf_ct_set_timeout, KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, bpf_ct_change_timeout, KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, bpf_ct_set_status, KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, bpf_ct_change_status, KF_TRUSTED_ARGS)
> -BTF_SET8_END(nf_ct_kfunc_set)
> +BTF_KFUNCS_END(nf_ct_kfunc_set)
>  
>  static const struct btf_kfunc_id_set nf_conntrack_kfunc_set = {
>  	.owner = THIS_MODULE,
> diff --git a/net/netfilter/nf_nat_bpf.c b/net/netfilter/nf_nat_bpf.c
> index 6e3b2f58855f..481be15609b1 100644
> --- a/net/netfilter/nf_nat_bpf.c
> +++ b/net/netfilter/nf_nat_bpf.c
> @@ -54,9 +54,9 @@ __bpf_kfunc int bpf_ct_set_nat_info(struct nf_conn___init *nfct,
>  
>  __bpf_kfunc_end_defs();
>  
> -BTF_SET8_START(nf_nat_kfunc_set)
> +BTF_KFUNCS_START(nf_nat_kfunc_set)
>  BTF_ID_FLAGS(func, bpf_ct_set_nat_info, KF_TRUSTED_ARGS)
> -BTF_SET8_END(nf_nat_kfunc_set)
> +BTF_KFUNCS_END(nf_nat_kfunc_set)
>  
>  static const struct btf_kfunc_id_set nf_bpf_nat_kfunc_set = {
>  	.owner = THIS_MODULE,
> diff --git a/net/xfrm/xfrm_interface_bpf.c b/net/xfrm/xfrm_interface_bpf.c
> index 7d5e920141e9..5ea15037ebd1 100644
> --- a/net/xfrm/xfrm_interface_bpf.c
> +++ b/net/xfrm/xfrm_interface_bpf.c
> @@ -93,10 +93,10 @@ __bpf_kfunc int bpf_skb_set_xfrm_info(struct __sk_buff *skb_ctx, const struct bp
>  
>  __bpf_kfunc_end_defs();
>  
> -BTF_SET8_START(xfrm_ifc_kfunc_set)
> +BTF_KFUNCS_START(xfrm_ifc_kfunc_set)
>  BTF_ID_FLAGS(func, bpf_skb_get_xfrm_info)
>  BTF_ID_FLAGS(func, bpf_skb_set_xfrm_info)
> -BTF_SET8_END(xfrm_ifc_kfunc_set)
> +BTF_KFUNCS_END(xfrm_ifc_kfunc_set)
>  
>  static const struct btf_kfunc_id_set xfrm_interface_kfunc_set = {
>  	.owner = THIS_MODULE,
> diff --git a/net/xfrm/xfrm_state_bpf.c b/net/xfrm/xfrm_state_bpf.c
> index 9e20d4a377f7..2248eda741f8 100644
> --- a/net/xfrm/xfrm_state_bpf.c
> +++ b/net/xfrm/xfrm_state_bpf.c
> @@ -117,10 +117,10 @@ __bpf_kfunc void bpf_xdp_xfrm_state_release(struct xfrm_state *x)
>  
>  __bpf_kfunc_end_defs();
>  
> -BTF_SET8_START(xfrm_state_kfunc_set)
> +BTF_KFUNCS_START(xfrm_state_kfunc_set)
>  BTF_ID_FLAGS(func, bpf_xdp_get_xfrm_state, KF_RET_NULL | KF_ACQUIRE)
>  BTF_ID_FLAGS(func, bpf_xdp_xfrm_state_release, KF_RELEASE)
> -BTF_SET8_END(xfrm_state_kfunc_set)
> +BTF_KFUNCS_END(xfrm_state_kfunc_set)
>  
>  static const struct btf_kfunc_id_set xfrm_state_xdp_kfunc_set = {
>  	.owner = THIS_MODULE,
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 8befaf17d454..53f73fc86baa 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -343,12 +343,12 @@ static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init = {
>  	.write = bpf_testmod_test_write,
>  };
>  
> -BTF_SET8_START(bpf_testmod_common_kfunc_ids)
> +BTF_KFUNCS_START(bpf_testmod_common_kfunc_ids)
>  BTF_ID_FLAGS(func, bpf_iter_testmod_seq_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_testmod_seq_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_kfunc_common_test)
> -BTF_SET8_END(bpf_testmod_common_kfunc_ids)
> +BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
>  
>  static const struct btf_kfunc_id_set bpf_testmod_common_kfunc_set = {
>  	.owner = THIS_MODULE,
> @@ -494,7 +494,7 @@ __bpf_kfunc static u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused
>  	return arg;
>  }
>  
> -BTF_SET8_START(bpf_testmod_check_kfunc_ids)
> +BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
>  BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
> @@ -520,7 +520,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_TRUSTED_ARGS | KF_RCU)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
> -BTF_SET8_END(bpf_testmod_check_kfunc_ids)
> +BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
>  
>  static int bpf_testmod_ops_init(struct btf *btf)
>  {
> -- 
> 2.42.1
> 

