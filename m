Return-Path: <linux-kselftest+bounces-20889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF709B40B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 04:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD211C21FEF
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 03:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215F216F84F;
	Tue, 29 Oct 2024 03:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2GV0qbY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0784198A0F
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 03:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730170813; cv=none; b=ZeB8E7AItPcB8Nk0vjr4WQ9i/XDUlXhu+f0Jf3ZErYIQc1xRxy/XyEJJ1rAkfj/k1Iw7n5Gq7EFtt8F07wDup5vJmdgB8BE4Y21r+d/7R/rCihq56m3IjPZIrbpI0f82XGRmhUVNtruS4wuGs6PRetbtLAtf2im4nVmoLLxBWSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730170813; c=relaxed/simple;
	bh=VyTJt0xPH4N8n02lC7V7N8uV5NqqDi7U2Mnpgj43mds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQSYMVsD5kSjLoWHivIQsp/yWqDHsGVg+Nbdy2chiT8c2rtITD36GLb/OyAwGqTzV//PRpzDgNJbhYxZ3S/PjTJsXGKP+5GArlED7fpGVd02HL4zWDxdd6Gk1A3qSwr0mHCw5uBNYySxFmfGywWxX0fIhBOpfwEfq+7OvCOblNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2GV0qbY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730170808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XM3NDn8/RrcDaH2dNFMKJrRw9os6K2fG5KwyMJ9szmk=;
	b=A2GV0qbYZwtpKny/fYiEZSL3Yx39OGK3Lu4PrN8Lcg7PZMAjVmfRYoy8r8JYdXBWLRG3Yd
	TCkX/2b+vQdl8o1PCajCKwB1QzMkC1PWQ8k6/5tUtHAAycprrKsOwO62nB+mwM4WQreUdb
	PvWunb//G6/19vbKS0LRgOru3QRpTAo=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-Yrxkyw8cObOkrAsk3Gjvsw-1; Mon, 28 Oct 2024 23:00:04 -0400
X-MC-Unique: Yrxkyw8cObOkrAsk3Gjvsw-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3ae3c2cacso47854685ab.2
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 20:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730170803; x=1730775603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XM3NDn8/RrcDaH2dNFMKJrRw9os6K2fG5KwyMJ9szmk=;
        b=m86+1Hr9dPaUVh/2aczzFIThgkZCllUay/KTE6MqGqIl9J9vdMifhPRhYJDPg3q1CB
         A9L5eQX3iXqCRnwKTFC1LL9aXAFpsoF6CgewUfnx4F+/hKN33DoswKE3i55UJlscsDRy
         kIGDjf0Kdff2mXZRw7O1eLqDpE5CMEBr4v1FqzG1gv/9QE9yo3zYwj1COPx0M0F9HIdN
         dwlCzw4fiUMXZszxR2XjNjVqwrKRGI8Vn9+9dc85JxdZbH0ncr1+Y3TaRQZlBo6L/g1N
         q83ddqpOUTQDmS5YrBYRq/iUiQ6mE5am5EIk8z7DfUtbhkjp68rKribbigYy/oh9sICI
         oqFA==
X-Forwarded-Encrypted: i=1; AJvYcCVzLoXjAhWZmvseei5GlLC40o6jO8grYnZTP0I6HQfl6H8/tf+y8XenMGXGSBSG5dpmQH+SXLQWPWDkUsdHf1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrW08LAmWmpw55tKZR73+g9mYSYmSCEEtyDE/aDZURddotDcLW
	34+JjOVbQygBkeJJ4WBgn0JLnmgDvnO1Ktaac7YKmDQMwy+nvOGeHM0yQmweM3ArsTW3vD66Aen
	13JKdid+JA/ZZiuPsUWnaghVUduwMnR39aeoCtrI30PctWCLOr8FJbpDHSotuMnAG/g==
X-Received: by 2002:a05:6e02:1c0d:b0:3a4:e8cc:2a89 with SMTP id e9e14a558f8ab-3a4ed2a9d71mr95089635ab.10.1730170802629;
        Mon, 28 Oct 2024 20:00:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHJe1SOujsJgAA42pQ3L9xxLdE1LSrArTcwDuo+h5DT5bavlNuHR/AF4+9mUBERX5gv6wGYQ==
X-Received: by 2002:a05:6e02:1c0d:b0:3a4:e8cc:2a89 with SMTP id e9e14a558f8ab-3a4ed2a9d71mr95089355ab.10.1730170802234;
        Mon, 28 Oct 2024 20:00:02 -0700 (PDT)
Received: from [10.0.0.71] ([65.128.110.20])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a4e6df5919sm19338285ab.41.2024.10.28.20.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 20:00:01 -0700 (PDT)
Message-ID: <bbbbaa42-444f-4973-b749-7c56b937ae5f@redhat.com>
Date: Mon, 28 Oct 2024 22:00:00 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tracing: Fix tracefs gid mount option
To: Kalesh Singh <kaleshsingh@google.com>, dhowells@redhat.com,
 rostedt@goodmis.org, mhiramat@kernel.org
Cc: surenb@google.com, jyescas@google.com, kernel-team@android.com,
 android-mm@google.com, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, Ali Zahraee <ahzahraee@gmail.com>,
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241028214550.2099923-1-kaleshsingh@google.com>
 <20241028214550.2099923-4-kaleshsingh@google.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20241028214550.2099923-4-kaleshsingh@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/24 4:43 PM, Kalesh Singh wrote:
> Commit 78ff64081949 ("vfs: Convert tracefs to use the new mount API")
> tracefs to use the new mount APIs caused mounting with the gid=<gid>
> option to not take effect.

Or any other mount options. I'm sure this isn't unique to gid, right?
So, might want to fix the commit title.

> The tracefs superblock can be updated from multiple paths:
>     - on fs_initcall() to init_trace_printk_function_export()
>     - form a work queue to initialize eventfs
>       tracer_init_tracefs_work_func()
>     - fsconfig() syscall to mount of remount sysfs
> 
> The tracefs super block root inode gets created early on in
> init_trace_printk_function_export().
> 
> With the new mount API tracefs effectively uses get_tree_single() instead
> of the old API mount_single().
> 
> Previously, mount_single() ensured that the options are alway applied to
> the superblock root inode:
>     (1) If the root inode didn't exist, called fill_super() to create it
>         and apply the options.
>     (2) If the root inode exists, called reconfigure_single() which
>         effectively called tracefs_apply_options() to parse and apply
>         options to the subperblock's fs_info and inode and remount
>         eventfs (if necessary)
> 
> On the other hand, get_tree_single() effectively calls vfs_get_super()
> which:
>     (3) If the root inode doesn't exists calls fill_super() to create it
>         and apply the options.
>     (4) If the root inode already exists, updates the fs_context root
>         with the superblock's root inode.

I'm honestly a little lost here, but given the differences between mount_single()
and get_tree_single() - are other get_tree_single() users similarly broken?

Should get_tree_single() just be calling reconfigure_single() internally like
mount_single() did? The comment in reconfigure_single() confuses me.

> (4) above is always the case for tracefs mounts, since the super block's
> root inode will already be created by init_trace_printk_function_export().

this reminds me a little of 

commit a6097180d884ddab769fb25588ea8598589c218c
Author: NeilBrown <neilb@suse.de>
Date:   Mon Jan 17 09:07:26 2022 +1100

    devtmpfs regression fix: reconfigure on each mount

> This means that the gid mount option gets ignored:
>     - Since it isn't applied to the super block's root inode, it doesn't
>       get inherited by the children.
>     - Since eventfs is initialized from form a separate work queue and
>       before call to mount with the options, and it doesn't get remounted
>       for mount.
> 
> Ensure that the mount options are applied to the super block and eventfs
> is remounted to respect the new mount options.
> 
> [1] https://lore.kernel.org/r/536e99d3-345c-448b-adee-a21389d7ab4b@redhat.com/
> 
> Fixes: 78ff64081949 ("vfs: Convert tracefs to use the new mount API")
> Cc: David Howells <dhowells@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>  fs/tracefs/inode.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 1748dff58c3b..cfc614c638da 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -392,6 +392,9 @@ static int tracefs_reconfigure(struct fs_context *fc)
>  	struct tracefs_fs_info *sb_opts = sb->s_fs_info;
>  	struct tracefs_fs_info *new_opts = fc->s_fs_info;
>  
> +	if (!new_opts)
> +		return 0;

Can this really happen?

> +
>  	sync_filesystem(sb);
>  	/* structure copy of new mount options to sb */
>  	*sb_opts = *new_opts;

FWIW doing this as a structure copy was probably a terrible choice on my part. :(

> @@ -478,14 +481,17 @@ static int tracefs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_op = &tracefs_super_operations;
>  	sb->s_d_op = &tracefs_dentry_operations;
>  
> -	tracefs_apply_options(sb, false);
> -
>  	return 0;
>  }
>  
>  static int tracefs_get_tree(struct fs_context *fc)
>  {
> -	return get_tree_single(fc, tracefs_fill_super);
> +	int err = get_tree_single(fc, tracefs_fill_super);
> +
> +	if (err)
> +		return err;
> +
> +	return tracefs_reconfigure(fc);
>  }
>  
>  static void tracefs_free_fc(struct fs_context *fc)


