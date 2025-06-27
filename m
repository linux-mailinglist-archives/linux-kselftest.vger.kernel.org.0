Return-Path: <linux-kselftest+bounces-35965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A13AEB715
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 14:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DECB71896D6E
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 12:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD8F29B8D8;
	Fri, 27 Jun 2025 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rKGMALgR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G9O3J7un"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801FD19F461;
	Fri, 27 Jun 2025 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751026009; cv=none; b=SUSbu0KjnNrqkFxhgiiZhXH/28a6OrjkPzwvhU8oZ4nu4f8xw7uxKMQ3GB3cbTvRhKGoWYeE25NI7xEcw83Aj0lzJtf2aZ0P6ePD2gAXYSdBZLBiz4Q3nxerLZNh1hqILMqgWIAAvGP74bTMcE4pZ2SViijnXDAI+jk/WuH/DPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751026009; c=relaxed/simple;
	bh=CTbeAhsX8qRNYRc4ghWc2c+oFJu3EOawafuTlAoXtLE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=YmC0FbTM0InBXtaRrpzKKjFWumNyX2GKLc7r1BSJYNMLHwnGDbKsCt054UyMcBE6LPH4/WeXkg8g/EJa3vwvIRCIc60zUr4zTIv7DaQOyfiiSH0fR4yXgCjN+QubRzlBwIOVlOAp/BhB/xsa9781GuHREkzC9F+ZVNJFrCKbeIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rKGMALgR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G9O3J7un; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751026005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=D2rtJu/0agYh6iy8bRJpc+guEfR/7am4jleUI/L+Wfs=;
	b=rKGMALgRbZw54lIcj14SbtQcZ+19c6Hn/WXAk2OIy7lYKocG7hgIYJ8Yj0jla98f59aGWS
	LVnWqBpwa3OROgWsPbaCVhdn194m+GjkzzC3TNe55m18CX6B08Bwl0afHGImU7cc3JOPAU
	gpLXUCDSJmZ0VICO2KpJWvSfdmOxE5EEXtCi5ANC1V3MvkBqJlSasV8WYVaHtjM85Vh3xg
	QriMnbNuAP855IYpqbCX/QlFUObcr0Gw8cPEZSy9iuBnH+0j46Gxf/ugrf/qU8qPrdvLel
	StJHJmdASEk8No47tEURWzYQ8sIV/E/O2iXqikZpuHeJKkWoCDXAgsUPI7Svgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751026005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=D2rtJu/0agYh6iy8bRJpc+guEfR/7am4jleUI/L+Wfs=;
	b=G9O3J7un+LJz0RAVBxIv/PTNOfuPXUi5JlUG2mLo5OfSjJPl2J4oFD1BCccGavVxSVih9J
	+l619nuCKLMeelAw==
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan
 <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-api@vger.kernel.org, kernel-dev@igalia.com, =?utf-8?Q?Andr=C3=A9?=
 Almeida <andrealmeid@igalia.com>
Subject: Re: [PATCH v5 4/7] futex: Create set_robust_list2
In-Reply-To: <20250626-tonyk-robust_futex-v5-4-179194dbde8f@igalia.com>
Date: Fri, 27 Jun 2025 14:06:44 +0200
Message-ID: <87zfdto0bv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26 2025 at 14:11, Andr=C3=A9 Almeida wrote:
> Create a new robust_list() syscall. The current syscall can't be
> expanded to cover the following use case, so a new one is needed. This
> new syscall allows users to set multiple robust lists per process and to
> have either 32bit or 64bit pointers in the list.
>
> * Interface
>
> This is the proposed interface:

What's proposed about this interface once it hits the tree? Just get rid
of this line completely. The paragraph decribes the interface
implemented by this patch, no?

If you want to make proposals, then do so in a RFC cover letter or
somewhere else.

> 	long set_robust_list2(void *head, int index, unsigned int flags)
>
> `head` is the head of the userspace struct robust_list_head, just as old
> set_robust_list(). It needs to be a void pointer since it can point to a
> normal robust_list_head or a compat_robust_list_head.
>
> `flags` can be used for defining the list type:
>
> 	enum robust_list_type {
> 	 	ROBUST_LIST_32BIT,
> 		ROBUST_LIST_64BIT,
> 	 };
>
> `index` is the index in the internal robust_list's linked list (the
> naming starts to get confusing, I reckon).

Yes

> If `index =3D=3D -1`, that means that user wants to set a new robust_list,
> and the kernel will append it in the end of the list, assign a new
> index and return this index to the user. If `index >=3D 0`, that means
> that user wants to re-set `*head` of an already existing list
> (similarly to what happens when you call set_robust_list() twice with
> different `*head`).

I'm lost in this word salad by now.

> If `index` is out of range, or it points to a non-existing robust_list,
> or if the internal list is full, an error is returned.
>
> Unaligned `head` addresses are refused by the kernel with -EINVAL.
>
> User cannot remove lists.

  A registered list cannot be removed.

But wording aside, I see that a once created list entry cannot be
removed, but it can be set to NULL, which means it is invalidated, no?

> * Implementation
>
> The old syscall's set/get_robust_list() are converted to use the linked

s/old/original/

> list as well. When using only the old syscalls user shouldn't any

user space

also 'shouldn't any difference' does not qualify as a parseable
sentence.

Aside of that this patch doing five things at once is unreviewable.

> difference as the internal code will handle the linked list insertion as
> usual. When mixing old and new interfaces users should be aware that one
> of the elements of the list was created by another syscall and they
> should have special care handling this element index.

That's a guaranteed recipe for disaster.
=20=20
>  #ifdef CONFIG_FUTEX
> +/*
> + * This is an entry of a linked list of robust lists.
> + *
> + * @head: can point to a 64bit list or a 32bit list
> + * @list_type: determine the size of the futex pointers in the list
> + * @index: the index of this entry in the list
> + * @list: linked list element
> + */
> +struct robust_list2_entry {
> +	void __user *head;
> +	enum robust_list2_type list_type;
> +	unsigned int index;
> +	struct list_head list;
> +};

I'm quite sure that I pointed you to

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html

before, no?

> +
>  enum {
>  	FUTEX_STATE_OK,
>  	FUTEX_STATE_EXITING,
> @@ -74,10 +89,11 @@ enum {
>=20=20
>  static inline void futex_init_task(struct task_struct *tsk)
>  {
> -	tsk->robust_list =3D NULL;
> +	tsk->robust_list_index =3D -1;

Can we have proper defines for this instead of '-1'. NULL for a pointer
makes obviously sense as it is well defined, but '-1' is just a number
pulled out of thin air and has no meaning at all.

>  #ifdef CONFIG_COMPAT
> -	tsk->compat_robust_list =3D NULL;
> +	tsk->compat_robust_list_index =3D -1;
>  #endif

> diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
> index 7e2744ec89336a260e89883e95222eda199eeb7f..a8d8d4b1306ba56041046647b=
fb12146cf1ae4cb 100644
> --- a/include/uapi/linux/futex.h
> +++ b/include/uapi/linux/futex.h
> @@ -153,6 +153,16 @@ struct robust_list_head {
>  	struct robust_list __user *list_op_pending;
>  };
>=20=20
> +#define ROBUST_LISTS_PER_TASK 10
> +
> +enum robust_list2_type {
> +	ROBUST_LIST_32BIT,
> +	ROBUST_LIST_64BIT,
> +};
> +
> +#define ROBUST_LIST_TYPE_MASK (ROBUST_LIST_32BIT | ROBUST_LIST_64BIT)

enum is a numerical value and ROBUST_LIST_32BIT is obviously 0.
Defining the mask out if these two values is surely creative and works
by chance, but seriously?

> +long do_set_robust_list2(struct robust_list_head __user *head,
> +			 int index, unsigned int type)

This expects a type defined in an named enum, So why is @type unsigned int?

> +{
> +	struct list_head *list2 =3D &current->robust_list2;
> +	struct robust_list2_entry *prev, *new =3D NULL;
> +
> +	if (index =3D=3D -1) {
> +		if (list_empty(list2)) {
> +			index =3D 0;
> +		} else {
> +			prev =3D list_last_entry(list2, struct robust_list2_entry, list);
> +			index =3D prev->index + 1;
> +		}
> +
> +		if (index >=3D ROBUST_LISTS_PER_TASK)
> +			return -EINVAL;
> +
> +		new =3D kmalloc(sizeof(struct robust_list2_entry), GFP_KERNEL);
> +		if (!new)
> +			return -ENOMEM;
> +
> +		list_add_tail(&new->list, list2);
> +		new->index =3D index;

Right. Make the entry visible _before_ initializing it.

What's worse is that the list operation is done without any form of
serialization against a concurrent invocation of get_robust_list(),
which can operate on a task which is not current. IOW, you created an
inviting unpriviledged security hole.

Aside of that, this list magic is completely overengineered. Why?

  - The amount of lists is limited to 10 for whatever reason as the
    changelog is silent about it.

  - The memory required for storing 10 robust list heads is 10 *
    sizeof(unsigned long), i.e. 80 bytes on a 64bit machine

  - The magic list head and the two index variables for the legacy
    interfaces consume 20 bytes unconditionally in each task struct.

  - Each allocated robust_list2_entry consumes 32 bytes of memory

So the first robust list setup amounts already to a total of 20 + 32 =3D
52 bytes, right? Any subsequent robust list installment exceeds 80 bytes
obviously.

This list handling is just overly complex for absolutely zero
value. Worse, it results in incomprehensible code and bugs like the
above.

It's not rocket science to make this non-obfuscated for both the user
side API and the kernel implementation. Something like this:

enum robust_list_cmd {
	FUTEX_ROBUST_LIST_CMD_CREATE_64,
	FUTEX_ROBUST_LIST_CMD_CREATE_32,
        FUTEX_ROBUST_LIST_CMD_MODIFY_64,
        FUTEX_ROBUST_LIST_CMD_MODIFY_32,
        FUTEX_ROBUST_LIST_CMD_USER_MAX,

        // Kernel internal, rejected for user space
        FUTEX_ROBUST_LIST_SET_NATIVE =3D 128,
        FUTEX_ROBUST_LIST_SET_COMPAT,
};

#define FUTEX_ROBUST_LIST_NATIVE_IDX	0
#define FUTEX_ROBUST_LIST_COMPAT_IDX	1
#define FUTEX_ROBUST_LIST2_IDX		2
#define FUTEX_ROBUST_LIST_MAX_IDX	8

#define FUTEX_ROBUST_LIST_ENTRY_INUSE	0x1UL
#define FUTEX_ROBUST_LIST_ENTRY_64BIT	0x2UL
#define FUTEX_ROBUST_LIST_ENTRY_MASK	(~0x3UL)

static long futex_robust_list_create(uintptr_t head, enum robust_list_cmd c=
md)
{
	uintptr_t entry =3D FUTEX_ROBUST_LIST_ENTRY_VALID;=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20
        uintptr_t *rl =3D current->futex_robust_lists;
	unsigned int index;

        if (!rl) {
                rl =3D kcalloc(ROBUST_LISTS_PER_TASK, sizeof(*rl), ....);
		....
                scoped_guard(mutex, &current->futex_exit_mutex)
                	current->futex_robust_lists =3D rl;
        }

	switch (cmd) {
        case FUTEX_ROBUST_LIST_CREATE_64:
        	if (!IS_ENABLED(CONFIG_64BIT))
                	return -EINVAL;
        	entry |=3D FUTEX_ROBUST_LIST_ENTRY_64BIT;
                fallthrough;
        case FUTEX_ROBUST_LIST_CREATE_32:
        	// Search for a empty slot
		for (index =3D FUTEX_ROBUST_LIST2_IDX; index < FUTEX_ROBUST_LIST_MAX_IDX;=
 index++) {
			if (!rl[index])
                        	break;
		}
                return -ENOSPC;

	case FUTEX_ROBUST_LIST_SET_NATIVE:
        	index =3D FUTEX_ROBUST_LIST_LEGACY_IDX;
        	if (IS_ENABLED(CONFIG_64BIT))
                       	entry |=3D FUTEX_ROBUST_LIST_ENTRY_64BIT;
                break;
	case FUTEX_ROBUST_LIST_SET_COMPAT:
        	if (!IS_ENABLED(CONFIG_64BIT))
                	return -EINVAL;
        	index =3D FUTEX_ROBUST_LIST_COMPAT_IDX;
                break;
        default:
        	return -EINVAL;
        }

        entry |=3D head;=09
        scoped_guard(mutex, &current->futex_exit_mutex)
        	rl[index] =3D entry;
        return index;
}

static long futex_robust_list_modify(uintptr_t head, enum robust_list_cmd c=
md, unsigned int index)
{
        uintptr_t *rl =3D current->futex_robust_lists;
	unsigned long entry;

        if (index >=3D FUTEX_ROBUST_LIST_MAX_IDX)
        	return -EINVAL;

	if (!rl || !rl[index])
        	return -ENOENT;

	entry =3D rl[index];
        switch (cmd) {
        case FUTEX_ROBUST_LIST_MODIFY_32:
		if (entry & FUTEX_ROBUST_LIST_ENTRY_64BIT)
                	return -EINVAL;
                break;
        case FUTEX_ROBUST_LIST_MODIFY_64:
        	if (!IS_ENABLED(CONFIG_64BIT))
                	return -EINVAL;
		if (!(entry & FUTEX_ROBUST_LIST_ENTRY_64BIT))
                	return -EINVAL;
                break;
        default:
        	return -EINVAL;
        }

	entry &=3D FUTEX_ROBUST_LIST_ENTRY_MASK;
        entry |=3D head;=09
        scoped_guard(mutex, &current->futex_exit_mutex)
        	rl[index] =3D entry;
        return index;
}

There is no confusion of index numbers and user space does not have to
care about a situation where an older libc uses the original syscall and
the application itself uses the new API. The two reserved entries are
just worth that.

The per task struct footprint is exactly one pointer for everything and
the allocation of 28 extra bytes for installing it once is definitely
not a problem at all.

get_robust_list() can safely access the array with the mutex held...

See?

> @@ -1414,25 +1476,28 @@ static inline void exit_pi_state_list(struct task=
_struct *curr) { }
>=20=20
>  static void futex_cleanup(struct task_struct *tsk)
>  {
> -#ifdef CONFIG_64BIT
> -	if (unlikely(tsk->robust_list)) {
> -		exit_robust_list64(tsk, tsk->robust_list);
> -		tsk->robust_list =3D NULL;
> -	}
> -#else
> -	if (unlikely(tsk->robust_list)) {
> -		exit_robust_list32(tsk,
> -				  (struct robust_list_head32 __user *) tsk->robust_list);
> -		tsk->robust_list =3D NULL;
> -	}
> -#endif
> +	struct robust_list2_entry *curr, *n;
> +	struct list_head *list2 =3D &tsk->robust_list2;
>=20=20
> -#ifdef CONFIG_COMPAT
> -	if (unlikely(tsk->compat_robust_list)) {
> -		exit_robust_list32(tsk, tsk->compat_robust_list);
> -		tsk->compat_robust_list =3D NULL;
> +	/*
> +	 * Walk through the linked list, parsing robust lists and freeing the
> +	 * allocated lists
> +	 */
> +	if (unlikely(!list_empty(list2))) {
> +		list_for_each_entry_safe(curr, n, list2, list) {
> +			if (curr->head !=3D NULL) {
> +				if (curr->list_type =3D=3D ROBUST_LIST_64BIT)
> +					exit_robust_list64(tsk, curr->head);
> +				else if (curr->list_type =3D=3D ROBUST_LIST_32BIT)
> +					exit_robust_list32(tsk, curr->head);

Unknown type is silently ignored?

> +				curr->head =3D NULL;
> +			}
> +			list_del_init(&curr->list);
> +			kfree(curr);
> +		}
>  	}
> -#endif
> +
> +	tsk->robust_list_index =3D -1;

Also why has this to be crammed into futex_cleanup()? Just because it
can and makes it more unreabable by deep indentation levels?

     if (unlikely(tsk->futex_robust_lists))
        exit_robust_lists(tsk);

and

static void exit_robust_lists(struct task_struct *tsk)
{
	uintptr_t *rl =3D tsk->futex_robust_lists;

        tsk->futex_robust_lists =3D NULL;

	for (unsigned int idx =3D 0; idx < ROBUST_LISTS_PER_TASK; idx++) {
        	uintptr_t entry =3D rl[idx];
=20=20=20=20=20=20=20=20
                if (!(entry & FUTEX_ROBUST_LIST_ENTRY_MASK))
                	continue;

		if (entry & FUTEX_ROBUST_LIST_ENTRY_32BIT) {
			struct robust_list_head32 __user *head;

			entry &=3D FUTEX_ROBUST_LIST_ENTRY_MASK;
                        head =3D (__force struct robust_list_head32 __user =
*)entry;
                 	exit_robust_list32(tsk, head);
                } else {
			struct robust_list_head __user *head;

			entry &=3D FUTEX_ROBUST_LIST_ENTRY_MASK;
                        head =3D (__force struct robust_list_head __user *)=
entry;
                	exit_robust_list64(tsk, head);
	}
        kfree(rl);
}

Is too readable, right?

> +#ifdef CONFIG_64BIT
> +static inline int robust_list_native_type(void)
> +{
> +	return ROBUST_LIST_64BIT;
> +}
> +#else
> +static inline int robust_list_native_type(void)
> +{
> +	return ROBUST_LIST_32BIT;
> +}
> +#endif

More ifdeffery is better

           return IS_ENABLED(CONFIG_64BIT) ? ....;

>  /**
>   * sys_set_robust_list() - Set the robust-futex list head of a task
>   * @head:	pointer to the list-head
> @@ -28,17 +40,63 @@
>  SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
>  		size_t, len)
>  {
> +	unsigned int type =3D robust_list_native_type();

Right. enum returned from an inline as int and then assigned to an
unsigned int for consistency....

> +	int ret;
> +
>  	/*
>  	 * The kernel knows only one size for now:
>  	 */
>  	if (unlikely(len !=3D sizeof(*head)))
>  		return -EINVAL;
>=20=20
> -	current->robust_list =3D head;
> +	ret =3D do_set_robust_list2(head, current->robust_list_index, type);
> +	if (ret < 0)
> +		return ret;
> +
> +	current->robust_list_index =3D ret;

	return futex_robust_list_create((__force uintptr)head, FUTEX_ROBUST_LIST_S=
ET_LEGACY);

>  	return 0;
>  }
>=20=20
> +#define ROBUST_LIST_FLAGS ROBUST_LIST_TYPE_MASK
> +
> +/*
> + * sys_set_robust_list2()
> + *
> + * When index =3D=3D -1, create a new list for user. When index >=3D 0, =
try to find
> + * the corresponding list and re-set the head there.
> + *
> + * Return values:
> + *  >=3D 0: success, index of the robust list
> + *  -EINVAL: invalid flags, invalid index
> + *  -ENOENT: requested index no where to be found
> + *  -ENOMEM: error allocating new list
> + *  -ESRCH: too many allocated lists

-ESRCH really makes no sense. -ENOSPC is what you want, no?

Aside of that, the comment is not valid kernel doc format even if it
pretends to be,

> + */
> +SYSCALL_DEFINE3(set_robust_list2, struct robust_list_head __user *, head,
> +		int, index, unsigned int, flags)
> +{
> +	unsigned int type;
> +
> +	type =3D flags & ROBUST_LIST_TYPE_MASK;
> +
> +	if (index < -1 || index >=3D ROBUST_LISTS_PER_TASK)
> +		return -EINVAL;
> +
> +	if ((flags & ~ROBUST_LIST_FLAGS) !=3D 0)
> +		return -EINVAL;
> +
> +	if (((uintptr_t) head % sizeof(u32)) !=3D 0)
> +		return -EINVAL;

A 64-bit robust list head should be 64-bit aligned, no?

> +#ifndef CONFIG_64BIT

Sigh.

> +	if (type =3D=3D ROBUST_LIST_64BIT)
> +		return -EINVAL;
> +#endif

> +
> +	return do_set_robust_list2(head, index, type);

	uintptr entry =3D (__force uintptr_t)head;
        unsigned int align =3D sizeof(u32);

	switch (cmd) {
        case FUTEX_ROBUST_LIST_CREATE_64:
        	if (!IS_ENABLED(CONFIG_64BIT))
                	return -ENOTSUPP;
		align =3D sizeof(u64);
                fallthrough;
        case FUTEX_ROBUST_LIST_CREATE_32:
        	if (entry % align)
                	return -EINVAL;
       		return futex_robust_list_create(entry, cmd);

        case FUTEX_ROBUST_LIST_MODIFY_64:
        	if (!IS_ENABLED(CONFIG_64BIT))
                	return -ENOTSUPP;
		align =3D sizeof(u64);
                fallthrough;
        case FUTEX_ROBUST_LIST_MODIFY_32:
        	if (entry % align)
                	return -EINVAL;
                return futex_robust_list_modify(entry, cmd, index);
        default:
        	return -EINVAL;

Or something like that.

> +}
> +
>  /**
>   * sys_get_robust_list() - Get the robust-futex list head of a task
>   * @pid:	pid of the process [zero for current task]
> @@ -52,6 +110,7 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
>  	struct robust_list_head __user *head;
>  	unsigned long ret;
>  	struct task_struct *p;
> +	int index;
>=20=20
>  	rcu_read_lock();
>=20=20
> @@ -68,9 +127,11 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
>  	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
>  		goto err_unlock;
>=20=20
> -	head =3D p->robust_list;
> +	index =3D p->robust_list_index;
>  	rcu_read_unlock();
>=20=20
> +	head =3D get_robust_list2(index, p);

Aside of the unprotected list walk, this adds a user exploitable exit
race on top. @p can go away immediately after rcu_read_unlock(), no?

Impressive...

With the above this becomes:

uintptr_t get_robust_list_at(pid_t pid, unsigned int idx)
{
        struct task_struct *p;
	uintptr_t entry;

	scoped_guard(rcu) {
		p =3D !pid ? current : find_task_by_vpid(pid);
		if (!p)
			return -ESRCH;

		if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
                	return -EPERM;
                get_task_struct(p);
	}

        scoped_guard(mutex, &p->futex_exit_mutex) {
        	uintptr_t *rl =3D p->futex_robust_lists;

		entry =3D rl ? rl[idx] : NULL;
		entry &=3D FUTEX_ROBUST_LIST_ENTRY_MASK;
        }

	put_task_struct(p);
        return entry;

get_robust_list()
{
	uintptr_t entry =3D get_robust_list_at(pid, FUTEX_ROBUST_LIST_NATIVE_IDX);
	struct robust_list_head __user *head;

	head =3D (__force struct robust_list_head __user *)entry;
	if (put_user(sizeof(*head), len_ptr))
		return -EFAULT;
	return put_user(head, head_ptr);
}

Or something along those lines. The scoped_guard(rcu) cleanup want's to
be in a preparatory patch.

Also why does this new syscall come without a corresponding
sys_get_robust_list2() implementation? CRIU definitely depends on
get_robust_list(), so it will need get_robust_list2() as well...

> @@ -458,6 +528,7 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
>  	struct robust_list_head32 __user *head;
>  	unsigned long ret;
>  	struct task_struct *p;
> +	int index;
>=20=20
>  	rcu_read_lock();
>=20=20
> @@ -474,9 +545,11 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
>  	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
>  		goto err_unlock;
>=20=20
> -	head =3D p->compat_robust_list;
> +	index =3D p->compat_robust_list_index;
>  	rcu_read_unlock();
>=20=20
> +	head =3D (struct robust_list_head32 __user *) get_robust_list2(index, p=
);
> +

See above....

This all wants to be properly split up into:

     1) Preparatory cleanups

     2) Implementation of the new mechanism without touching the existing
        syscalls.

     3) Conversion of the existing syscalls

Thanks,

        tglx

