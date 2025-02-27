Return-Path: <linux-kselftest+bounces-27796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9D0A4892F
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 20:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB7251886AD2
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 19:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA94526F477;
	Thu, 27 Feb 2025 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZYKCxR9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780AB1B0425;
	Thu, 27 Feb 2025 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740685556; cv=none; b=gtL39guBAFAQfKknjvE96q6HeORevlQeihXaOz7YaUBJi4gheJQtWsigVDUM/+T+HRZ3sZ382PsbczBrjLqwzKv8zOr5hJFFWcU9GjZovxYkYwrtCAjyftcyzk9fqC7Ywm3vw2FaXQXotZ90nrAPU9PRukRt+3hS5+A9rgfe/fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740685556; c=relaxed/simple;
	bh=fxGI2P73JAE1BbX3qBIJnpU9JmGHhCzRhZk02qu+4IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8x2QFtGXF6gv4onJP0bGMSVXjgH4uezMNcwSoFoR6MBti2vPrYYX9V9kDdNgWHV8mkqqkDv5GQdhpMmdD467Vz7sWP27OE0JlgVlLex0y01Blwp5qtQ+iWcUH1ROPsNWfDts2/rCGq8V2sgRnDKEEdG4mDTh9fXLQPkf1Y2p0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZYKCxR9; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2feb9076cdcso800968a91.0;
        Thu, 27 Feb 2025 11:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740685555; x=1741290355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hKrLEfNlUSucizGljfgxzp9FYBz9EtVzZ87+jjh5zyk=;
        b=FZYKCxR9GNIKjczjfyNiHlyTbC84ol4Zqe35r0U3q+D1qvBTX0/7rmHjJsrtAcdU8D
         jEwoElUmbpPuEVqdvTJwz+stdlGpp91RfXfsYx1skiVJtW8uhkrUxiFNlNQ6qrOkoFth
         rQ89ItD38s9KxC0tRyj659a72anxse4ZAcgBczwqIuu/pbm7sSmVeVh2dfEKsIk/mkUH
         jtXR6yupIee91OUxtMGmWg1scxaRYBQ/lZpe/KjwKIQcXpjERS8x5N0uXja7Hnhn+kYb
         F9AJKM7NzealZrKJrCbVu9GX4U0U3692sc8j5X5PzH2BAg9QFpJzwd/EF8HjAFEf49rh
         ip7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740685555; x=1741290355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKrLEfNlUSucizGljfgxzp9FYBz9EtVzZ87+jjh5zyk=;
        b=IQjd7ZRW9iL6NY2z9pMDOb85dshLtdNJTSm4LQv10BsvpBNK/ujCrNPtLc2b/iCGLe
         KqdJkeNG4Zrp3xgE9kS7J/xAKw2y8DrHm1AC950YstfdM/+JPj1Otiq3vcRt9eOaHmsK
         XFXFWkkEsTn70Ua7z50/1KLE1ENmqeev4jrzslde30brHD76czbhi/ExT4LQ/ax2H/om
         o3YZ1og70GSPTgV+yYwjBo+8G+i7UmqKU820pH0/7Kk7lri9c+9K/7xM2hvmAPQKJRX9
         NOJHa7Lztl8KYAQhWL6x2BnUicmnuKMZ0hEhwfd+FDwE2amGvhMFGWvNeW1S2frrbOCt
         YIGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmF0Fq6clBV/OawBhLHUa4exARTwES/zoTRLtPT0qo0KC35dh2ojFTCH6PLYW8QAaqSsdUWnb1zrhlx2LO@vger.kernel.org, AJvYcCWV5iTzy8MnuZMBPf9npTu4Olp6BqHBYdNOclRcMNT11nNkENJAe5n09R2uVKyDogaPzNGB7Rw1@vger.kernel.org, AJvYcCWdkmo5sv6g3gQgW5UrF4tB5fJ7O89+b1nkd/wouOFBaTuOedTn+ARpr1nnAxPV0aqLgsJiv5fkj1BdpWFnko/t@vger.kernel.org, AJvYcCXzhCux8Yq9WoKbdxL/dcK8SjkpgemuU2o43LOWb36JYmBKbZCd/G8AjoJ5P/1p2OfY5SI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiQtW1GZ+19RkfkZGnVvObFrogdMiamf2IUrrXUoU5xx0emZZ4
	+96jKb+PmCeekHyfqcphXwRO6cMLcckWeQWBVOBMbkHbIsBpgcWY
X-Gm-Gg: ASbGncujawuASmenntDJqX4UbqoTnSYIWxAbZ3hZ7gvTz2lW8+ScPrf55Y8VpSmRGyB
	0Q/c0vFQGnBiOLxtjCQEOQOzYawoV8PccNKAeR825NB19dCs+tYu+hygc5pCz5xx9bWmZHRbelt
	+eo2adWDUSpt6RIFZLabJUjJLg/quNjWnrWbygR2twHy0RJTpZGXFUGKzDI/uqo+H8cYDhHlGRo
	dWOM2CwGjNiHtz9zigvoWduGjonrLaC79nfidfQIeoyS2PLoj8O2fUAprWKiM1ymhz4G0eIpAAw
	+5ay8NtVyR0phm62EJrCVABYk0ShMA==
X-Google-Smtp-Source: AGHT+IF7KxgGQER56mHtTQNtxws1vcj+rbNToYaT+m7ci3YVeU2HRn/oym63rVGGHm8Fgqe9vgWxNg==
X-Received: by 2002:a17:90b:1804:b0:2fe:8c22:48b0 with SMTP id 98e67ed59e1d1-2febab7876amr909701a91.15.1740685554682;
        Thu, 27 Feb 2025 11:45:54 -0800 (PST)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350529edasm18978725ad.230.2025.02.27.11.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 11:45:54 -0800 (PST)
Date: Thu, 27 Feb 2025 11:45:53 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: cong.wang@bytedance.com, john.fastabend@gmail.com, jakub@cloudflare.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, andrii@kernel.org,
	eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, mhal@rbox.co,
	sgarzare@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	mrpre@163.com,
	syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next v1 1/3] bpf, sockmap: avoid using sk_socket
 after free
Message-ID: <Z8DA8TqMEYNziiT9@pop-os.localdomain>
References: <20250226132242.52663-1-jiayuan.chen@linux.dev>
 <20250226132242.52663-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226132242.52663-2-jiayuan.chen@linux.dev>

On Wed, Feb 26, 2025 at 09:22:40PM +0800, Jiayuan Chen wrote:
> Use RCU lock to protect sk_socket, preventing concurrent close and release
> by another thread.
> 
> Because TCP/UDP are already within a relatively large critical section:
> '''
> ip_local_deliver_finish
>   rcu_read_lock
>   ip_protocol_deliver_rcu
>       tcp_rcv/udp_rcv
>   rcu_read_unlock
> '''
> 
> Adding rcu_read_{un}lock() at the entrance and exit of sk_data_ready
> will not increase performance overhead.
> 
> Reported-by: syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/bpf/6734c033.050a0220.2a2fcc.0015.GAE@google.com/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

sock_def_readable() already acquires RCU read lock anyway.

Reviewed-by: Cong Wang <xiyou.wangcong@gmail.com>

Thanks!

