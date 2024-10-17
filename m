Return-Path: <linux-kselftest+bounces-19967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 125FC9A2672
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 17:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84F4AB20F42
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 15:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D771DE3DA;
	Thu, 17 Oct 2024 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ibn5A+bP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2C4111AD;
	Thu, 17 Oct 2024 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178585; cv=none; b=ECyUCPs9s016JP5/fhFuSL0aTi94ATsCvoADI/gljSS+pm2NCM6KDe2cf5XWvCahf/dezUSMRHh3dMyu5eH89svdm9h81eE5R1yovPboopAOaGW+iRgw0GDlEBL38vCPyF92bByLNAOKb21Q3agLhTkNQUU5NksUXogLDo/Uwss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178585; c=relaxed/simple;
	bh=AXi5igniqIyyxheg5Sm6cUTvM1gIi0arptG6VmBgsSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOlTyjeFCFZgyh2hTwwloNe2SLhKqwWb0nogHaMChf63p4LSTtITuV5KHxBT2YrBjYYPwyoG9Kt1V0pw4g2LGYMl/Njh4EfjJsJPGvaRPZFm7S+pk+imlgcas8bfoKxlHbiHGQdE81tbZa30mEBu3avFuNB2TvJ9cwnC+dzvfKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ibn5A+bP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20caea61132so9238375ad.2;
        Thu, 17 Oct 2024 08:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729178583; x=1729783383; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y6FZkjAZKlqXCaat751gW9GqgonUGNmyuVtlRf/h9Hw=;
        b=Ibn5A+bPVED3s5v6bojOeiRj5W9mkjCzvHUcQ9MRDGGVfFzvp1AwWSxUt41RWdrKwR
         3Hx6s//VgY2xGOG6g81Hj3TkIG5WpX3SmGsZ9OhFmDS/Mw3CELZlc3RSbMo8Zrpj9/o0
         Hn69FvUAdItGPzG37Gy16y/455Qos7YIHR6L0jk/bGLbfKsXiFs4L4fxuOqiu+1ijqFn
         MLQcQOO1cGA+GbPmsyg60qgn1J8ivBLyPcY26UBY0JugN/fLjIcZw4K/2vRnOgzHPkDe
         TqaASWaNk9uEG7hSC+NYBZ+cF4bJwHZqRStw84NPunLeZm1TPnfKa4OWASXuCUA4iy8G
         MG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729178583; x=1729783383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6FZkjAZKlqXCaat751gW9GqgonUGNmyuVtlRf/h9Hw=;
        b=YULlULmh+8ykbofkpniZD7L2WHd914ngIdZ/BERqgilGyB8GxjYYUfDFe0Cxeappwj
         a33Lc7RhbiUS+D1d78Uy23smAiuGD9VvlngdtMBnO6Vm55N/ZswWZZzgQ7wlB079bcm9
         ov49Jjp3G/ZHZFiISs72lp107abqlKlLE3MwqSbC7MzCVwixgWV2MOPVn+O9ul4zPHfx
         VADMhkn9WnnCVF7iiX/uasNJLJWQZI1tmJ2MzSLcOGQRUc7sUt498ktCXOTqSLhtMGQw
         8AuEzxZ7sSn49HjSrbZDSK8xMgJTnEbL6HKksOs92Te1aTETVyZQF4BYKDUQOjhQQhIp
         rP5g==
X-Forwarded-Encrypted: i=1; AJvYcCUsVWJVaugfUB0nXBf1gcZwMoL1rB5jsICJNSRXnrL7OqulbI2CWT9IsuogMVDEpui8xGhOuXGT@vger.kernel.org, AJvYcCXt/xdg8ztn3nUyKunrFqBbNh3bZW3I5cDKpAKll4MySv6Zz0uadzTXhDKyt4GjcC/5ATNVQV1ZuKSzDy4=@vger.kernel.org, AJvYcCXzljt/1Gk//7S7od1UKrO+dyJ0y6xv7UzrH9uETIQ5UY958zJi6gPQLfq+oGLgYUHS1eX4DzbyeDtxQREa1CoW@vger.kernel.org
X-Gm-Message-State: AOJu0YzVfsX6+f4vUamJ1ZKayhFR5qNr0nmZRHBZ06rImpLeOofiy1bV
	mQsjJj2WD5HfNdej769glF7tMuasycaeucdAFGMTUT/Pzv2pSok=
X-Google-Smtp-Source: AGHT+IExXHPKnYSDWMEgRJP20/f6vWMT7kFHZNvMTyCGgqUUivo4QAww7v47Uv3ylRvVv7SEOiRVFw==
X-Received: by 2002:a17:902:e5c7:b0:20c:7796:5e47 with SMTP id d9443c01a7336-20cbb1a94f3mr355593165ad.4.1729178583110;
        Thu, 17 Oct 2024 08:23:03 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d180361f0sm45666805ad.181.2024.10.17.08.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 08:23:02 -0700 (PDT)
Date: Thu, 17 Oct 2024 08:23:01 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc: davem@davemloft.net, Liam.Howlett@oracle.com, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, jiri@resnulli.us, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, akpm@linux-foundation.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, peili.io@oracle.com
Subject: Re: [PATCH net-next v3 1/3] connector/cn_proc: Add hash table for
 threads
Message-ID: <ZxEr1TOg4ddoAm7y@mini-arch>
References: <20241016220634.1469153-1-anjali.k.kulkarni@oracle.com>
 <20241016220634.1469153-2-anjali.k.kulkarni@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241016220634.1469153-2-anjali.k.kulkarni@oracle.com>

On 10/16, Anjali Kulkarni wrote:
> Add a new type PROC_CN_MCAST_NOTIFY to proc connector API, which allows a
> thread to notify the kernel that is going to exit with a non-zero exit
> code and specify the exit code in it. When thread exits in the kernel,
> it will send this exit code as a proc filter notification to any
> listening process.
> Exiting thread can call this either when it wants to call pthread_exit()
> with non-zero value or from signal handler.
> 
> Add a new file cn_hash.c which implements a hash table storing the exit
> codes of abnormally exiting threads, received by the system call above.
> The key used for the hash table is the pid of the thread, so when the
> thread actually exits, we lookup it's pid in the hash table and retrieve
> the exit code sent by user. If the exit code in struct task is 0, we
> then replace it with the user supplied non-zero exit code.
> 
> cn_hash.c implements the hash table add, delete, lookup operations.
> mutex_lock() and mutex_unlock() operations are used to safeguard the
> integrity of the hash table while adding or deleting elements.
> connector.c has the API calls, called from cn_proc.c, as well as calls
> to allocate, initialize and free the hash table.
> 
> Add a new flag in PF_* flags of task_struct - EXIT_NOTIFY. This flag is
> set when user sends the exit code via PROC_CN_MCAST_NOTIFY. While
> exiting, this flag is checked and the hash table add or delete calls
> are only made if this flag is set.
> 
> A refcount field hrefcnt is added in struct cn_hash_dev, to keep track
> of number of threads which have added an entry in hash table. Before
> freeing the struct cn_hash_dev, this value must be 0.
> This refcnt check is added in case CONFIG_CONNECTOR is compiled as a
> module. In that case, when unloading the module, we need to make sure
> no hash entries are still present in the hdev table.
> 
> Copy the task's name (task->comm) into the exit event notification.
> This will allow applications to filter on the name further using
> userspace filtering like ebpf.
> 
> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> ---
>  drivers/connector/Makefile    |   2 +-
>  drivers/connector/cn_hash.c   | 181 ++++++++++++++++++++++++++++++++++
>  drivers/connector/cn_proc.c   |  62 +++++++++++-
>  drivers/connector/connector.c |  63 +++++++++++-
>  include/linux/connector.h     |  31 ++++++
>  include/linux/sched.h         |   2 +-
>  include/uapi/linux/cn_proc.h  |   5 +-
>  7 files changed, 338 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/connector/cn_hash.c
> 
> diff --git a/drivers/connector/Makefile b/drivers/connector/Makefile
> index 1bf67d3df97d..cb1dcdf067ad 100644
> --- a/drivers/connector/Makefile
> +++ b/drivers/connector/Makefile
> @@ -2,4 +2,4 @@
>  obj-$(CONFIG_CONNECTOR)		+= cn.o
>  obj-$(CONFIG_PROC_EVENTS)	+= cn_proc.o
>  
> -cn-y				+= cn_queue.o connector.o
> +cn-y				+= cn_hash.o cn_queue.o connector.o
> diff --git a/drivers/connector/cn_hash.c b/drivers/connector/cn_hash.c
> new file mode 100644
> index 000000000000..a079e9bcea6d
> --- /dev/null
> +++ b/drivers/connector/cn_hash.c
> @@ -0,0 +1,181 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Author: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> + *
> + * Copyright (c) 2024 Oracle and/or its affiliates.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/connector.h>
> +#include <linux/mutex.h>
> +#include <linux/pid_namespace.h>
> +
> +#include <linux/cn_proc.h>
> +
> +struct cn_hash_dev *cn_hash_alloc_dev(const char *name)
> +{
> +	struct cn_hash_dev *hdev;
> +
> +	hdev = kzalloc(sizeof(*hdev), GFP_KERNEL);
> +	if (!hdev)
> +		return NULL;
> +
> +	snprintf(hdev->name, sizeof(hdev->name), "%s", name);
> +	atomic_set(&hdev->hrefcnt, 0);
> +	mutex_init(&hdev->uexit_hash_lock);
> +	hash_init(hdev->uexit_pid_htable);
> +	return hdev;
> +}
> +
> +void cn_hash_free_dev(struct cn_hash_dev *hdev)
> +{
> +	struct uexit_pid_hnode *hnode;
> +	struct hlist_node *tmp;
> +	int bucket;
> +
> +	pr_debug("%s: Freeing entire hdev %p\n", __func__, hdev);
> +
> +	mutex_lock(&hdev->uexit_hash_lock);
> +	hash_for_each_safe(hdev->uexit_pid_htable, bucket, tmp,
> +			hnode, uexit_pid_hlist) {
> +		hash_del(&hnode->uexit_pid_hlist);
> +		pr_debug("%s: Freeing node for pid %d\n",
> +				__func__, hnode->pid);
> +		kfree(hnode);
> +	}
> +
> +	mutex_unlock(&hdev->uexit_hash_lock);
> +	mutex_destroy(&hdev->uexit_hash_lock);
> +
> +	/*
> +	 * This refcnt check is added in case CONFIG_CONNECTOR is
> +	 * compiled with =m as a module. In that case, when unloading
> +	 * the module, we need to make sure no hash entries are still
> +	 * present in the hdev table.
> +	 */
> +	while (atomic_read(&hdev->hrefcnt)) {
> +		pr_info("Waiting for %s to become free: refcnt=%d\n",
> +				hdev->name, atomic_read(&hdev->hrefcnt));
> +		msleep(1000);
> +	}
> +
> +	kfree(hdev);
> +	hdev = NULL;
> +}
> +
> +static struct uexit_pid_hnode *cn_hash_alloc_elem(__u32 uexit_code, pid_t pid)
> +{
> +	struct uexit_pid_hnode *elem;
> +
> +	elem = kzalloc(sizeof(*elem), GFP_KERNEL);
> +	if (!elem)
> +		return NULL;
> +
> +	INIT_HLIST_NODE(&elem->uexit_pid_hlist);
> +	elem->uexit_code = uexit_code;
> +	elem->pid = pid;
> +	return elem;
> +}
> +
> +static inline void cn_hash_free_elem(struct uexit_pid_hnode *elem)
> +{
> +	kfree(elem);
> +}
> +
> +int cn_hash_add_elem(struct cn_hash_dev *hdev, __u32 uexit_code, pid_t pid)
> +{
> +	struct uexit_pid_hnode *elem, *hnode;
> +
> +	elem = cn_hash_alloc_elem(uexit_code, pid);
> +	if (!elem) {
> +		pr_err("%s: cn_hash_alloc_elem() returned NULL pid %d\n",
> +				__func__, pid);
> +		return -ENOMEM;
> +	}
> +
> +	mutex_lock(&hdev->uexit_hash_lock);
> +	/*
> +	 * Check if an entry for the same pid already exists
> +	 */
> +	hash_for_each_possible(hdev->uexit_pid_htable,
> +				hnode, uexit_pid_hlist, pid) {
> +		if (hnode->pid == pid) {
> +			mutex_unlock(&hdev->uexit_hash_lock);
> +			cn_hash_free_elem(elem);
> +			pr_debug("%s: pid %d already exists in hash table\n",
> +				__func__, pid);
> +			return -EEXIST;
> +		}
> +	}
> +
> +	hash_add(hdev->uexit_pid_htable, &elem->uexit_pid_hlist, pid);
> +	mutex_unlock(&hdev->uexit_hash_lock);
> +
> +	atomic_inc(&hdev->hrefcnt);
> +
> +	pr_debug("%s: After hash_add of pid %d elem %p hrefcnt %d\n",
> +			__func__, pid, elem, atomic_read(&hdev->hrefcnt));
> +	return 0;
> +}
> +
> +int cn_hash_del_get_exval(struct cn_hash_dev *hdev, pid_t pid)
> +{
> +	struct uexit_pid_hnode *hnode;
> +	struct hlist_node *tmp;
> +	int excde;
> +
> +	mutex_lock(&hdev->uexit_hash_lock);
> +	hash_for_each_possible_safe(hdev->uexit_pid_htable,
> +				hnode, tmp, uexit_pid_hlist, pid) {
> +		if (hnode->pid == pid) {
> +			excde = hnode->uexit_code;
> +			hash_del(&hnode->uexit_pid_hlist);
> +			mutex_unlock(&hdev->uexit_hash_lock);
> +			kfree(hnode);
> +			atomic_dec(&hdev->hrefcnt);
> +			pr_debug("%s: After hash_del of pid %d, found exit code %u hrefcnt %d\n",
> +					__func__, pid, excde,
> +					atomic_read(&hdev->hrefcnt));
> +			return excde;
> +		}
> +	}
> +
> +	mutex_unlock(&hdev->uexit_hash_lock);
> +	pr_err("%s: pid %d not found in hash table\n",
> +			__func__, pid);
> +	return -EINVAL;
> +}
> +
> +int cn_hash_get_exval(struct cn_hash_dev *hdev, pid_t pid)
> +{
> +	struct uexit_pid_hnode *hnode;
> +	__u32 excde;
> +
> +	mutex_lock(&hdev->uexit_hash_lock);
> +	hash_for_each_possible(hdev->uexit_pid_htable,
> +				hnode, uexit_pid_hlist, pid) {
> +		if (hnode->pid == pid) {
> +			excde = hnode->uexit_code;
> +			mutex_unlock(&hdev->uexit_hash_lock);
> +			pr_debug("%s: Found exit code %u for pid %d\n",
> +					__func__, excde, pid);
> +			return excde;
> +		}
> +	}
> +
> +	mutex_unlock(&hdev->uexit_hash_lock);
> +	pr_debug("%s: pid %d not found in hash table\n",
> +			__func__, pid);
> +	return -EINVAL;
> +}
> +
> +bool cn_hash_table_empty(struct cn_hash_dev *hdev)
> +{
> +	bool is_empty;
> +
> +	is_empty = hash_empty(hdev->uexit_pid_htable);
> +	pr_debug("Hash table is %s\n", (is_empty ? "empty" : "not empty"));
> +
> +	return is_empty;
> +}
> diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
> index 44b19e696176..0632a70a89a0 100644
> --- a/drivers/connector/cn_proc.c
> +++ b/drivers/connector/cn_proc.c
> @@ -69,6 +69,8 @@ static int cn_filter(struct sock *dsk, struct sk_buff *skb, void *data)
>  	if ((__u32)val == PROC_EVENT_ALL)
>  		return 0;
>  
> +	pr_debug("%s: val %lx, what %x\n", __func__, val, what);
> +
>  	/*
>  	 * Drop packet if we have to report only non-zero exit status
>  	 * (PROC_EVENT_NONZERO_EXIT) and exit status is 0
> @@ -326,9 +328,15 @@ void proc_exit_connector(struct task_struct *task)
>  	struct proc_event *ev;
>  	struct task_struct *parent;
>  	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
> +	int uexit_code;
>  
> -	if (atomic_read(&proc_event_num_listeners) < 1)
> +	if (atomic_read(&proc_event_num_listeners) < 1) {
> +		if (likely(!(task->flags & PF_EXIT_NOTIFY)))
> +			return;
> +
> +		cn_del_get_exval(task->pid);
>  		return;
> +	}
>  
>  	msg = buffer_to_cn_msg(buffer);
>  	ev = (struct proc_event *)msg->data;
> @@ -337,7 +345,26 @@ void proc_exit_connector(struct task_struct *task)
>  	ev->what = PROC_EVENT_EXIT;
>  	ev->event_data.exit.process_pid = task->pid;
>  	ev->event_data.exit.process_tgid = task->tgid;
> -	ev->event_data.exit.exit_code = task->exit_code;
> +	if (unlikely(task->flags & PF_EXIT_NOTIFY)) {
> +		task->flags &= ~PF_EXIT_NOTIFY;
> +
> +		uexit_code = cn_del_get_exval(task->pid);
> +		if (uexit_code <= 0) {
> +			pr_debug("%s: err %d returning task's exit code %u\n",
> +					uexit_code, __func__,
> +					task->exit_code);

The compiler complains about the format string:

In file included from ./include/linux/kernel.h:31,
                 from drivers/connector/cn_proc.c:11:
drivers/connector/cn_proc.c: In function ‘proc_exit_connector’:
drivers/connector/cn_proc.c:353:34: error: format ‘%s’ expects argument of type ‘char *’, but argument 3 has type ‘int’ [-Werror=format=]
  353 |                         pr_debug("%s: err %d returning task's exit code %u\n",
      |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---
pw-bot: cr

