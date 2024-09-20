Return-Path: <linux-kselftest+bounces-18163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D566497D47D
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 13:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978B2283FEB
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 11:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0930313D24C;
	Fri, 20 Sep 2024 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JRsjGAzw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD147DA76
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2024 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726830052; cv=none; b=koI6HckaVx1ZiNIDg0UJel4JAuFLd1t9U34//VvlV8d2PbND8p9VkT4S4gG5r6mGHyqx9o50Byzx2W8bbLIR3n5PGT1M9Hlf3eSPU2IIWQVWYU8WvO4yC3m0mF9Z2FNyaZhnON1JUbCUfbwUqhhLDkbb6mnSYfQpidl7DN2NyjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726830052; c=relaxed/simple;
	bh=g0N37I9LGHoCW/EB/MezaKfvsqnxjfpMPi0l3+HRHb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bam5kwX6K3uh7wOUCJv0WTbE1dUgSbeijqs2CFdIIxjuRbK17sfzW7qaZjyxbW7iwVwSYLTDk/dp+MRyEsno0+zB6kXV0CAUHFRIXrc4A9WyDW2SPbMd1Zy9RtpCmkiVi+xUTvGKMpbjAlPNGbAcAIhpC+E7ZY83dTboGzFJVbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JRsjGAzw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726830050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pmGGA2GDyqcrfQAaYVDcSgQwWgpfnNZKHmHkpAEFn1c=;
	b=JRsjGAzwJe/1VX3c4pZXzOdWmhzH4OHvxZitXfx1k1pEgJIPmHD3OmxM2QKjb2jRJKyDE+
	h5IdKHk1PKtM9r3Qh3HFEp/Q/xuRmN5auvdjyHMZ/3itORaGREQJXaJy6dD3YCHsNwhZTx
	trze3xaM5wrjaGchdO6fvkbtloRe54w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-onnAB8xDPL6vPHO9OYIQEA-1; Fri,
 20 Sep 2024 07:00:47 -0400
X-MC-Unique: onnAB8xDPL6vPHO9OYIQEA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6EF7B19300E4;
	Fri, 20 Sep 2024 11:00:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.115])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B592D195605A;
	Fri, 20 Sep 2024 11:00:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 20 Sep 2024 13:00:32 +0200 (CEST)
Date: Fri, 20 Sep 2024 13:00:23 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc: davem@davemloft.net, Liam.Howlett@Oracle.com, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, akpm@linux-foundation.org,
	axboe@kernel.dk, brauner@kernel.org, mhocko@suse.com,
	alexjlzheng@tencent.com, willy@infradead.org,
	michael.christie@oracle.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, peili.io@oracle.com,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH net-next 1/2] connector/cn_proc: Handle threads for proc
 connector
Message-ID: <20240920110022.GA15795@redhat.com>
References: <20240920000933.185090-1-anjali.k.kulkarni@oracle.com>
 <20240920000933.185090-2-anjali.k.kulkarni@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920000933.185090-2-anjali.k.kulkarni@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 09/19, Anjali Kulkarni wrote:
>
> @@ -413,6 +416,10 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
>  	if (msg->len == sizeof(*pinput)) {
>  		pinput = (struct proc_input *)msg->data;
>  		mc_op = pinput->mcast_op;
> +		if (mc_op == PROC_CN_MCAST_NOTIFY) {
> +			current->exit_code = pinput->uexit_code;
> +			return;

...

> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -821,6 +821,7 @@ void __noreturn do_exit(long code)
>  {
>  	struct task_struct *tsk = current;
>  	int group_dead;
> +	__u32 uexit_code;
>  
>  	WARN_ON(irqs_disabled());
>  
> @@ -863,6 +864,8 @@ void __noreturn do_exit(long code)
>  		tty_audit_exit();
>  	audit_free(tsk);
>  
> +	uexit_code = tsk->exit_code;

I don't think you can use task_struct->exit_code. If this task is ptraced,
it can be changed/cleared in, say, ptrace_stop() after PROC_CN_MCAST_NOTIFY.

Oleg.


