Return-Path: <linux-kselftest+bounces-19968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8F69A267B
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 17:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440D51F233B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 15:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977ED1DED62;
	Thu, 17 Oct 2024 15:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZcJeAxb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC65111AD;
	Thu, 17 Oct 2024 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178670; cv=none; b=VS2uJgYw6qBRm9KRB5eiLhlJdKGnF+K7D6NScnhTlnJqf7sDnL6AXHkcISlsLZFT2cyG0EgvkN+48xtvSjwzo+DRC+A9y0RkZF703KKTAVyYgTFlf7oYgfYViu0pcuCdhHCyMNlG4w1LMG8JMu+I/H0GZ/2ktS2CR8CI9OlbyNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178670; c=relaxed/simple;
	bh=2aE8sAK15kiuKLWja11GZFI+BaD4QSlGT1HCclnxJpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZZvSe3stAUN0iHETmgNX+Wi7lJHDAW31Om8RJucAuQim1dV8dPZ2ueKNwm7WeJyAmQ+NDyGQohDh//Ev0hhArarfjhXF8E+StVrcSNzXsVgAtbWGtYRFETq6dUrGruK17V0+0l59S7kcXpNThfZY5PCxSXnzqYg1nAF7q33WUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZcJeAxb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c803787abso8942505ad.0;
        Thu, 17 Oct 2024 08:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729178668; x=1729783468; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0FHD75GalKyAWsOlY0lzEYZ0c+gNWFLIcnffq4615GY=;
        b=dZcJeAxb1/1o3jxTr4vGyJUKeepvocoIRE2fP/Zj6hMBTD3J91/HqshoAj7qZHaKTP
         sZXECWw22MBulU+5vtwENgsNVVzOfcd/UInYChUrXfoq86aWTBAcMHlfRyIVTcB4wq+R
         /kSrb97atND9sM0P7MmarRsP/F3cPeWJR5Vw9NhGPEElE19RxMxfNo9a6iZejZJrpjIh
         Izjb6k46NgYtgEAfkjZg+h+YMIoVQRLJp1uwxiMyt11OYGqsKK5R1NvViy0xPuQFG98d
         g0p1zG+dkkg0mnydAzAYpOUs2oCIFhGJNdFHN+EnmH8/Gscj+TWnf3VR27hfdlsTXYUe
         BXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729178668; x=1729783468;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FHD75GalKyAWsOlY0lzEYZ0c+gNWFLIcnffq4615GY=;
        b=uAKE2xD+EKFDaLdoZqNQxVcyPPqyn1MgHIp0g//w24U0l3tkOu9ym4AuuMNRkn1LIi
         ogxFYxprhaO7gxpT0YWkdG4VaqkPjZXmjUdVCsWL52wVBNDmT0LvQSI6W1UcO5CSypF7
         GtNuNCYIWbaDbzYXA+p9x3pyJAKzDJCj2sgwhKAIRtqIMygutLSLB7Z3aJE2oBqQqoLi
         F2+/XjvQlMAsuIhEkeuveLrjf5TB30omx8f5mjFYx4/fFVTKV12l3UNrJ5BYFmLM+sUI
         w/Sj8a059mUd+qvtH/FlLgoc4IRKYkVLnahc4nN+VKx+30o+9+KboTPUeig5vYw+LEf1
         +a3A==
X-Forwarded-Encrypted: i=1; AJvYcCVDI4VRALzy+74dzeU7HipB7epc6P+bH/VIF1W97NbSoOLiHjgaetuC1VTTAzcQXfkJ270jETXtTE3CBMA=@vger.kernel.org, AJvYcCW0l4USzSYIQXJwYHLSjRYUI9Qcd6/ttssFI3irO4irv8SuCcHcDrWOE2KRYnpuudyqObM1xA4a@vger.kernel.org, AJvYcCW1C53T4hqp1AmAa75Zu/vEQN04qU8k5EnseNWb9gmx78EL4tifCTBXOW8RUrfMz3gGr3p3nwjQPn7vEumReZ2o@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx0ZkjQN1r18qMtK3xZ21cspmpFu2cyz/qipsnIRgX1txM1cxW
	kmWdaetWahKskGuArFc0EVoM3t/DbgOg4mpyGb2eI6B2Jg+mvJo=
X-Google-Smtp-Source: AGHT+IGdn2IgXZX1OzAW2irnul4MWh8XTV3/3Y3QYaHR8fsJzCjycOG/1b/oij7q74l4u2mXBfPYGg==
X-Received: by 2002:a17:902:e543:b0:20b:a73b:3f5 with SMTP id d9443c01a7336-20d4791289cmr54856915ad.14.1729178667879;
        Thu, 17 Oct 2024 08:24:27 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1805d070sm45270215ad.282.2024.10.17.08.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 08:24:26 -0700 (PDT)
Date: Thu, 17 Oct 2024 08:24:26 -0700
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
Subject: Re: [PATCH net-next v4 1/3] connector/cn_proc: Add hash table for
 threads
Message-ID: <ZxEsKmvJKe8Z3QUs@mini-arch>
References: <20241017002652.1474358-1-anjali.k.kulkarni@oracle.com>
 <20241017002652.1474358-2-anjali.k.kulkarni@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017002652.1474358-2-anjali.k.kulkarni@oracle.com>

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

(I might have commented on the older revision, but same issue here)

In file included from ./include/linux/kernel.h:31,
                 from drivers/connector/cn_proc.c:11:
drivers/connector/cn_proc.c: In function ‘proc_exit_connector’:
drivers/connector/cn_proc.c:353:34: error: format ‘%s’ expects argument of type ‘char *’, but argument 3 has type ‘int’ [-Werror=format=]
  353 |                         pr_debug("%s: err %d returning task's exit code %u\n",
      |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---
pw-bot: cr

