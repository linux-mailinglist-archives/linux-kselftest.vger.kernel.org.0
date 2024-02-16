Return-Path: <linux-kselftest+bounces-4846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58110857947
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 10:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CDBB1C21644
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 09:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88911C293;
	Fri, 16 Feb 2024 09:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HufZPPzj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ACB1C28B;
	Fri, 16 Feb 2024 09:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077017; cv=none; b=fepY1ff2BalL7g7O077CYs4ynjxHHkjHVkvntxzTqL8dAHq0GhK1AT+dsRlE+jhDlNVb+sctfLSZoV7JfJgdIcGADlUP2u/DSSJbIYuo9eY4V5CKD7ePmp5PWkf8qjWPW9fEJH8XzsBCRS2yOx0SVobxT76FqiNAXtiCqbutAIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077017; c=relaxed/simple;
	bh=XKCprlTz0347plqDoKqAZwoHqGS/Pp12Co1OcFZtcqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFTZgqgxuIfxoE2X7Lh6k3gj62A7RlsZ4J9PApGYoZLvoldFQz2grDpN/e/ckv+ZdzFXidNPxYdA82+1Y/lF8VO6vpQ/wZYh0HifygDFr0PwTX/IcrmTPO+Oz1LiOqsZ+e3NMGCGwN595zpnPgYE6R4kpqsxxDJzKngk0Dgbt7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HufZPPzj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B7BC43390;
	Fri, 16 Feb 2024 09:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708077017;
	bh=XKCprlTz0347plqDoKqAZwoHqGS/Pp12Co1OcFZtcqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HufZPPzjo9osR7IHp88TOsioOOI2iusPmafShVqE64mnkt1Nx1Wylvu4QNqbkpe2o
	 04iZlz1zfVI1WMl6LVPJQSiZbr6n9lDTNFd9+Lh97VSBKnzO43jYqdqHu2q9lx+EyK
	 SKqW1CNpu1zhK9SrQbb2EA6+9J6YsdQUXMCBenOZdw3DXqTmucqYJODiS5M8q69H5v
	 DSuO4I6jQ87on7nezZo5HZyyzJv0LNfgrpMfxDasFKMMLCOax+BuDoBVKRrBSCPOkn
	 YRiw1xS4lIiQ+6swcM0UmlGNEkmJc422G1ZvmitB5SOmm30uyZWtSJXZtSg4JQsBBm
	 Do77vMXvomvgA==
Date: Fri, 16 Feb 2024 10:50:10 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v2 02/10] bpf/helpers: introduce sleepable
 timers
Message-ID: <rhdu4st5tfabsdqs27ewhvdlwblhj2re4o56iz3fq3bsuokxxe@gtuqdjffj2hn>
References: <20240214-hid-bpf-sleepable-v2-0-5756b054724d@kernel.org>
 <20240214-hid-bpf-sleepable-v2-2-5756b054724d@kernel.org>
 <mth43jfjhwtatwfo3unefrze62opht3yklleblslyz2adc6p5p@wm3miaqhhtkt>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mth43jfjhwtatwfo3unefrze62opht3yklleblslyz2adc6p5p@wm3miaqhhtkt>

On Feb 15 2024, Benjamin Tissoires wrote:
> On Feb 14 2024, Benjamin Tissoires wrote:
> > They are implemented as a kfunc, which means a little bit of tweaks in
> > the verifier.
> > 
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > 
> > ---
> > 
> > changes in v2 (compared to the one attaches to v1 0/9):
> > - make use of a kfunc
> > - add a (non-used) BPF_F_TIMER_SLEEPABLE
> > - the callback is *not* called, it makes the kernel crashes
> > ---
> >  include/linux/bpf_verifier.h |   2 +
> >  include/uapi/linux/bpf.h     |  12 +++++
> >  kernel/bpf/helpers.c         | 105 ++++++++++++++++++++++++++++++++++++++++---
> >  kernel/bpf/verifier.c        |  72 ++++++++++++++++++++++++++---
> >  4 files changed, 180 insertions(+), 11 deletions(-)
> > 
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 84365e6dd85d..789ef5fec547 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -426,6 +426,7 @@ struct bpf_verifier_state {
> >  	 * while they are still in use.
> >  	 */
> >  	bool used_as_loop_entry;
> > +	bool in_sleepable;
> >  
> >  	/* first and last insn idx of this verifier state */
> >  	u32 first_insn_idx;
> > @@ -626,6 +627,7 @@ struct bpf_subprog_info {
> >  	bool is_async_cb: 1;
> >  	bool is_exception_cb: 1;
> >  	bool args_cached: 1;
> > +	bool is_sleepable: 1;
> >  
> >  	u8 arg_cnt;
> >  	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index d96708380e52..0838597028a9 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -7427,6 +7427,18 @@ enum {
> >  	BPF_F_TIMER_CPU_PIN = (1ULL << 1),
> >  };
> >  
> > +/* Extra flags to control bpf_timer_init() behaviour, in addition to CLOCK_*.
> > + *     - BPF_F_TIMER_SLEEPABLE: Timer will run in a workqueue in a sleepable
> > + *       context.
> > + */
> > +enum {
> > +	/* CLOCK_* are using bits 0 to 3 */
> > +	BPF_F_TIMER_SLEEPABLE = (1ULL << 4),
> > +	__MAX_BPF_F_TIMER_INIT,
> > +};
> > +
> > +#define MAX_BPF_F_TIMER_INIT __MAX_BPF_F_TIMER_INIT
> > +
> >  /* BPF numbers iterator state */
> >  struct bpf_iter_num {
> >  	/* opaque iterator state; having __u64 here allows to preserve correct
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 4db1c658254c..2dbc09ce841a 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1097,9 +1097,11 @@ const struct bpf_func_proto bpf_snprintf_proto = {
> >   */
> >  struct bpf_hrtimer {
> >  	struct hrtimer timer;
> > +	struct work_struct work;
> >  	struct bpf_map *map;
> >  	struct bpf_prog *prog;
> >  	void __rcu *callback_fn;
> > +	void __rcu *sleepable_cb_fn;
> >  	void *value;
> >  };
> >  
> > @@ -1113,18 +1115,59 @@ struct bpf_timer_kern {
> >  	struct bpf_spin_lock lock;
> >  } __attribute__((aligned(8)));
> >  
> > +static void bpf_timer_work_cb(struct work_struct *work)
> > +{
> > +	struct bpf_hrtimer *t = container_of(work, struct bpf_hrtimer, work);
> > +	struct bpf_map *map = t->map;
> > +	void *value = t->value;
> > +	bpf_callback_t callback_fn;
> > +	void *key;
> > +	u32 idx;
> > +
> > +	BTF_TYPE_EMIT(struct bpf_timer);
> > +
> > +	rcu_read_lock();
> > +	callback_fn = rcu_dereference(t->sleepable_cb_fn);
> > +	rcu_read_unlock();
> > +	if (!callback_fn)
> > +		return;
> > +
> > +	/* FIXME: do we need any locking? */
> > +	if (map->map_type == BPF_MAP_TYPE_ARRAY) {
> > +		struct bpf_array *array = container_of(map, struct bpf_array, map);
> > +
> > +		/* compute the key */
> > +		idx = ((char *)value - array->value) / array->elem_size;
> > +		key = &idx;
> > +	} else { /* hash or lru */
> > +		key = value - round_up(map->key_size, 8);
> > +	}
> > +
> > +	/* FIXME: this crashes the system with
> > +	 * BUG: kernel NULL pointer dereference, address: 000000000000000b
> > +	 */
> > +	/* callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0); */
> 
> I've found an interesting side effect here.
> 
> If I uncomment the line above, I get the following dumpstack:
> 
> [    5.375257] BUG: kernel NULL pointer dereference, address: 000000000000000b
> [    5.376587] #PF: supervisor instruction fetch in kernel mode
> [    5.376932] #PF: error_code(0x0010) - not-present page
> [    5.377249] PGD 1016e6067 P4D 1016e6067 PUD 1016e5067 PMD 0 
> [    5.377602] Oops: 0010 [#1] PREEMPT SMP NOPTI
> [    5.377876] CPU: 0 PID: 10 Comm: kworker/0:1 Not tainted 6.8.0-rc2-gd2c1e1837606-dirty #285
> [    5.378378] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-1.fc39 04/01/2014
> [    5.378913] Workqueue: events bpf_timer_work_cb
> [    5.379197] RIP: 0010:0xb
> [    5.379369] Code: Unable to access opcode bytes at 0xffffffffffffffe1.
> [    5.379768] RSP: 0018:ffffa5300005be10 EFLAGS: 00010246
> [    5.380088] RAX: 0000000000000068 RBX: 000000000000000b RCX: 0000000000000000
> [    5.380523] RDX: ffffa530012a5ff0 RSI: ffffa530012a5fe8 RDI: ffff915ec2bad000
> [    5.380947] RBP: ffff915ec2bad000 R08: 0000000000000000 R09: 0000000000000001
> [    5.381368] R10: 0000000000000000 R11: ffffffff9166f820 R12: ffffa530012a5ff0
> [    5.381793] R13: ffffa530012a5fe8 R14: ffff915ec0073005 R15: ffffffff900aea8a
> [    5.382213] FS:  0000000000000000(0000) GS:ffff915efbc00000(0000) knlGS:0000000000000000
> [    5.382691] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    5.383036] CR2: ffffffffffffffe1 CR3: 000000010761e003 CR4: 0000000000770ef0
> [    5.383460] PKRU: 55555554
> [    5.383643] Call Trace:
> [    5.383831]  <TASK>
> [    5.383994]  ? __die+0x23/0x70
> [    5.384228]  ? page_fault_oops+0x181/0x4a0
> [    5.384541]  ? exc_page_fault+0x67/0x1a0
> [    5.384840]  ? asm_exc_page_fault+0x26/0x30
> [    5.385154]  ? process_one_work+0x16a/0x4b0
> [    5.385467]  ? bpf_timer_work_cb+0xfc/0x240
> [    5.385789]  ? process_one_work+0x1d4/0x4b0
> [    5.386101]  ? worker_thread+0x1d5/0x3c0
> [    5.386393]  ? __pfx_worker_thread+0x10/0x10
> [    5.386724]  ? kthread+0xf5/0x130
> [    5.386974]  ? __pfx_kthread+0x10/0x10
> [    5.387255]  ? ret_from_fork+0x31/0x50
> [    5.387537]  ? __pfx_kthread+0x10/0x10
> [    5.387820]  ? ret_from_fork_asm+0x1b/0x30
> [    5.388127]  </TASK>
> 
> And it looks like the callback is properly called, but the fault comes
> after:
> 
> (gdb) list *(process_one_work+0x16a)
> 0xffffffff810aea8a is in process_one_work (kernel/workqueue.c:2606).
> 2601		 * disabled.
> 2602		 */
> 2603		set_work_pool_and_clear_pending(work, pool->id);
> 2604	
> 2605		pwq->stats[PWQ_STAT_STARTED]++;
> 2606		raw_spin_unlock_irq(&pool->lock);
> 2607	
> 2608		lock_map_acquire(&pwq->wq->lockdep_map);
> 2609		lock_map_acquire(&lockdep_map);
> 2610		/*
> 
> And there is no real reason for the spinlock to not be set unless there
> is a memroy corruption.
> 
> And if in my program I call bpf_timer_set_callback() before bpf_timer_set_sleepable_cb()
> like:
> 	bpf_timer_set_callback(timer, timer_cb1);
> 	bpf_timer_set_sleepable_cb(timer, timer_cb1);
> 
> I do not see the corruption in the memory.
> 
> So it seems that when BPF calls the helper, the callback_fn is set in a
> mode that it is not polluting the memory, while when calling the function
> pointer from a kfunc, something is not properly set and there is a
> memory corruption.
> 
> Does that rings any bell?

Sigh... I found the issue, it was in my code: basically push_callback_call()
was never called because I called it from the helper validation call,
not the kfunc one :(

---
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cb1266566b69..58082df468e5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -501,6 +501,7 @@ static bool is_dynptr_ref_function(enum bpf_func_id func_id)
 }
 
 static bool is_sync_callback_calling_kfunc(u32 btf_id);
+static bool is_callback_calling_kfunc(u32 btf_id);
 static bool is_bpf_throw_kfunc(struct bpf_insn *insn);
 
 static bool is_bpf_timer_set_sleepable_cb_kfunc(u32 btf_id);
@@ -9452,7 +9453,7 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	 */
 	env->subprog_info[subprog].is_cb = true;
 	if (bpf_pseudo_kfunc_call(insn) &&
-	    !is_sync_callback_calling_kfunc(insn->imm)) {
+	    !is_callback_calling_kfunc(insn->imm)) {
 		verbose(env, "verifier bug: kfunc %s#%d not marked as callback-calling\n",
 			func_id_name(insn->imm), insn->imm);
 		return -EFAULT;
@@ -10440,10 +10441,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		break;
 	}
 
-	if (is_bpf_timer_set_sleepable_cb_kfunc(func_id))
-		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
-					 set_timer_callback_state);
-
 	if (err)
 		return err;
 
@@ -11370,6 +11367,12 @@ static bool is_bpf_timer_set_sleepable_cb_kfunc(u32 btf_id)
 	return btf_id == special_kfunc_list[KF_bpf_timer_set_sleepable_cb];
 }
 
+static bool is_callback_calling_kfunc(u32 btf_id)
+{
+	return is_sync_callback_calling_kfunc(btf_id) ||
+	       is_bpf_timer_set_sleepable_cb_kfunc(btf_id);
+}
+
 static bool is_rbtree_lock_required_kfunc(u32 btf_id)
 {
 	return is_bpf_rbtree_api_kfunc(btf_id);
@@ -12140,6 +12143,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	if (is_bpf_timer_set_sleepable_cb_kfunc(meta.func_id)) {
+		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+					 set_timer_callback_state);
+		if (err) {
+			verbose(env, "kfunc %s#%d failed callback verification\n",
+				func_name, meta.func_id);
+			return err;
+		}
+	}
+
 	rcu_lock = is_kfunc_bpf_rcu_read_lock(&meta);
 	rcu_unlock = is_kfunc_bpf_rcu_read_unlock(&meta);
 
---

[...]

Cheers,
Benjamin

