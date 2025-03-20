Return-Path: <linux-kselftest+bounces-29473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05C2A69D05
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 01:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6792F888841
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 00:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF81EC5;
	Thu, 20 Mar 2025 00:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLlYOU9J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EFA191;
	Thu, 20 Mar 2025 00:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742429180; cv=none; b=As0M1LQktixPzZWB2f0OkFRmKqpFLQkjCUlIyoRMerY8fQH/4qHqiTCJcXGLiGNG3R9Oobi5U6Jx076Yu56JZFscZ4GQZDNvPa8TmfqjbXtp8M8kl28F9LSiluESVyGLjmC0GlKcYjw1niEaZzbn9BvgXj7awj8GCBczwmiqgSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742429180; c=relaxed/simple;
	bh=BO+//tcXorx2kbUfYowaXvsu4SDU++zC1eH8TyB6buM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgRnSsi8OGfyNWYKFn42dyYGJWb5cuoIAM8DJDtzndW+DUH9HJbAfR82AD6Qa8bp+p0kV8jOCrJBy9/cEehRMtxdYCJp+OD0nKRe1136bfRdVB/QFamLIl4ySd8fRb3ZGMrOMO+HqoDUVmQzlwzmEPbWf9+iIQwLwwPaQSo7PTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLlYOU9J; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2255003f4c6so2025525ad.0;
        Wed, 19 Mar 2025 17:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742429178; x=1743033978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i67nHSXMn9wyesYVZ73ubzS5KypW1HRAz0KQwH13Rm0=;
        b=OLlYOU9J9XriKEAb1kXq3MV7uemWz44X/P+d9MS2IVNeu3mTTzbDC5DxeGgvc1CbfS
         UhEGJIkDFcfYdmjhTI/59VphgHxxU1J8v760LtT2VQh6PTRzJg82sJm789uMXn+sJozY
         v7/0vd0Om7JPKIruiC9gngCQsGWL3n01BowLhewtKFZ6ZjlNKDhgH586q9zsKTyiFn8s
         rjvI6etZ7NTZJbUs7Fh8cPWJgxuKpvqomWcoBmI+Je0W6fHOeVd5DNWv1I8tL4t4NhmV
         WYjzzQis3azkHLpQOKBDLiiEgDXOvFWI0H5HTOAORXrXDteAB5NR6+yy05Hed8hzWwOD
         wg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742429178; x=1743033978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i67nHSXMn9wyesYVZ73ubzS5KypW1HRAz0KQwH13Rm0=;
        b=VXyC4sYrV9WWNa5ssHdv2kPoyUcrq4DOh+P5loHB8LeMfmGoo60vp9ZKjYzj8DYPEF
         o5CCCnpEtr3/JNQvAvw+YNeI7pps1IIoD9lazx2gcsXRpcvyKWwrPWLfwbhLWnl5teL0
         NC8nz4Qb1vaDn51DR7Ruu0zhDFFwYubuEF+0XSD3MDR70F4KgNZbURLVR3sKppqraakG
         ImjFRSZDc0e/koEo5CtjZECAHXn9zUuwVgI2XJssltIlBNl9JliF+oluUFFVnJ3/TcfZ
         IO2WQGSo5rxBj9shvwDox8CRDkYxpDAuxb+9umKJyJKSz9N/BLB1boWAqlBnSIjZ1Ghd
         bCyg==
X-Forwarded-Encrypted: i=1; AJvYcCUt1J/48KIrDNIICEE2MI3AxPmrczFBKlE9FHVJIY78LgqxJXQSgfw8jOjrXpMgQV8APCG63ElL@vger.kernel.org, AJvYcCVKJJH4E8m+6GHLF/eySqM3NuiCfJVjI51gIcMwwvC4PqGmoR09MMoZFg4oZobFMI4fYkeyJBS6SRgbo+cPqnTG@vger.kernel.org, AJvYcCVPlcDHX2rYnfPbljLZEfyVzjyqPtrGovB26bPefpouBtjPrRyxxMPVvmAFw6oZ/pmMl3vrP1+SdYYGYfYT@vger.kernel.org, AJvYcCW0pae/rLXPU1tHlSyZWiWl5H+K/mM3urzT3TmUPyYTgMplunVNzdjNlxqc0e+sbEPUZug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkqiUXQZOoPRL/OZIo9KcimFPRr13fBCHiiismBrymRi5lcwzz
	baucdXxi8A1g9kk+6uMXHjZN6dQGWqUkYEJrP+BMx0hZrEubI6OU
X-Gm-Gg: ASbGncumkx3om8W2gFUjnINjyTZ+bnhLTSViqgKt+B3+cfGcFWLh3gTA73fm79FYqJF
	3Qww3O6YeysU5MVApkl35JyR9IVyfeSvEhg3ysOEgE+7LD0qyiu1d1ChSTPmK4eep+EN/Dvc7b5
	yzwduKULeCcbYv1fwkvRTaSxbufrtEctwN+ONv5mAC/HxzYKDqhzCg/eXiTwE4ycRnCWeoQWoOJ
	M82fwlvCchgGHxyoiyQ+2Qu/44wMsxR4e/QCOsCCfu1Os/Z848ulF4I+KWg1/jsEDW9vX/ytikj
	kwigckVBXbo7CZmrdUrskrsleosZ6cHSZ1qHtqRjnPgvzJuk
X-Google-Smtp-Source: AGHT+IEqQiEdBN18NzeCzATzPCdMYX7OSqKrz7WWXs+VpGIlSI/RD/m5riIAffmbr4BZka1MHDXYYw==
X-Received: by 2002:a05:6a21:3a4a:b0:1ee:dcd3:80d7 with SMTP id adf61e73a8af0-1fbe862d8ddmr9179408637.0.1742429178363;
        Wed, 19 Mar 2025 17:06:18 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9e2f45sm11619719a12.29.2025.03.19.17.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 17:06:17 -0700 (PDT)
Date: Wed, 19 Mar 2025 17:06:17 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
	mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, shuah@kernel.org, mhal@rbox.co,
	sgarzare@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/3] bpf, sockmap: avoid using sk_socket
 after free when sending
Message-ID: <Z9tb+Y+w/gcqSnCo@pop-os.localdomain>
References: <20250317092257.68760-1-jiayuan.chen@linux.dev>
 <20250317092257.68760-2-jiayuan.chen@linux.dev>
 <Z9tNAhMV1Y5znONo@pop-os.localdomain>
 <48068a86ea99dffe1e7849fb544eac1746364afb@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48068a86ea99dffe1e7849fb544eac1746364afb@linux.dev>

On Wed, Mar 19, 2025 at 11:36:13PM +0000, Jiayuan Chen wrote:
> 2025/3/20 07:02, "Cong Wang" <xiyou.wangcong@gmail.com> wrote:
> 
> > 
> > On Mon, Mar 17, 2025 at 05:22:54PM +0800, Jiayuan Chen wrote:
> > 
> > > 
> > > The sk->sk_socket is not locked or referenced, and during the call to
> > > 
> > 
> > Hm? We should have a reference in socket map, whether directly or
> > 
> > indirectly, right? When we add a socket to a socket map, we do call
> > 
> > sock_map_psock_get_checked() to obtain a reference.
> > 
> 
> Yes, but we remove psock from sockmap when sock_map_close() was called
> '''
> sock_map_close
> 	lock_sock(sk);
> 	rcu_read_lock();
> 	psock = sk_psock(sk);
>         // here we remove psock and the reference of psock become 0
> 	sock_map_remove_links(sk, psock)

sk_psock_drop() also calls cancel_delayed_work_sync(&psock->work),
althrough in yet another work. Is this also a contribution to this bug?

>         psock = sk_psock_get(sk);
>         if (unlikely(!psock))
>             goto no_psock;     <=== jmp to no_psock
>         rcu_read_unlock();
>         release_sock(sk);
>         cancel_delayed_work_sync(&psock->work); <== no chance to run cancel
> '''
> 

I have to say sock_map_close() becomes harder and harder to understand
now. And I am feeling we may have more bugs since we have two flying
work's here: psock->rwork and psock->work.

Thanks.

