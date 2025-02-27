Return-Path: <linux-kselftest+bounces-27800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63210A48A2E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 21:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FAF8188F92B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 20:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7F426FDBA;
	Thu, 27 Feb 2025 20:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAKj4lyA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1EF1AF0C9;
	Thu, 27 Feb 2025 20:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740689842; cv=none; b=oN/fOjS/uM4KDPDxaEsyRqDqLRMIO5t3Qfu874K6Z7Cn88rYYIk7MAm/s/2Iu3PgEPGEEyRbt802LP3LcxVxAPG9P+eo/IjrqFCqvOdbx6RivinaRrykGHlDAPswiCYWPdMBfQ5MyrWXyVL121B2tayIwfga9ODMBTofwQqxHkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740689842; c=relaxed/simple;
	bh=WETLlt6omqPXV2KLrdLSdBoe5L//2lLKp5zjDgYIFVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hr8RseXACkUzfPCYW9n+VPnuhvAfc6pAhhN3qGv5VJLazBoRHQbHnkQmHPHl50BTcewee3JK7A9Zd2JA3+QXGczW2vp7FsS67bHxpk5Vivsx85HRmfCbHLZBoLmpGKUU2dj/yw7c3byHgQApMAOonfJ/A4h7XavaNVNuBJQoxM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAKj4lyA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2234daaf269so38456635ad.3;
        Thu, 27 Feb 2025 12:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740689840; x=1741294640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T1JO3e+QHevCg59+ZmfEUzPgv3IgoTrdZwhSZpSiJuQ=;
        b=RAKj4lyATEhAxowoDzRzMTR7pTD4aQNHCakFL4ZTz2+tmQlZpeGwwBnfNdLYoD6URS
         YozA4/9nEQdLgV1E53boL6JyCQYAf9tCVfHiaZgYMHgKSDVBvL5Jb0FgV/jG4QlLr9px
         qr03r+FylkWS0Z/T2EohH4crpEXWsKMFdi3YLSED7DSGLb29lsiVzboTbCPjgA/1C2mo
         LHufbwDSG1+iYUqVexls7m2IJ9AzfafAR9FPWqwSa2tsDEfUgzJQsVDMcDcsjYDtKVbV
         tAzTJMs8PN/jpwb/oT+r/v+knLCqUSbY8w+bG5DnCQxw2RyitAcz2kdIx1gPfrua9uTt
         8oLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740689840; x=1741294640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1JO3e+QHevCg59+ZmfEUzPgv3IgoTrdZwhSZpSiJuQ=;
        b=xU/uTCx0czNceMGzdg+oG7HjSIebN3t3t0r0GHJZq6bwqstQpB0a6rEvJsrAfkPGHZ
         aHeCZeEzkdTd3i5x9uuPL9o9qYj+VIRjv7I/2NW8B4JioWpIbpZoWFVz7g/IOxearKzc
         Y4i/efx3kU0fcfgQPCPuYCXHSOy5tUQbyuf8xDose2TkWRRIVHOGb+FJro+4wHY5EubK
         5KP2IRs7OHKA4tmwjKS3lSPWrdFlNjKaRPfUcb9gz4PYHeLUJ3+bJmcE+gktMmZrVPPP
         jtFHsPVCgWako7TfUUytd0My8l5nqfNA8+3S2ttH8TmhpupZCdgUsszINqD8g/f+EqZC
         K8vg==
X-Forwarded-Encrypted: i=1; AJvYcCUdMpVniOVkTmcbaqzelQBxbvkq4h83Xj8lrAdMiZY5ArIUbFfIMmA1/28Sqaex9snBNe6+KIaz67qUvPLa@vger.kernel.org, AJvYcCUy0LLy7xDU7cJHTKEuhiuiv1TTBTksgcbAacB14wi1ILccO/pbi68BHo4f5hm+cH7ynlntXLuc@vger.kernel.org, AJvYcCVlRfQcGIvcwDzVRq8STkO0pU0vlRxB4fRXyAD3kBLhMZWYRIuxbB32/sra8M/fCM0WlZBE9vm70LLm2vPyRQIb@vger.kernel.org, AJvYcCVr7fl9zhii/js8C0D3Rpvql/HYtMvXlZ/usdqFiaUjP3WQHIJnemg5YRzzQpUbrTIgUzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy54s1YHN2e6r9y0Sj8ZdaD1nz+Ckw88UIBCK4mIMRfnjgLXh1C
	54sr0WKM/q0i5aH18dvDrryB0phsc7WJPNr4sPMAQlIX67MNZOZ7
X-Gm-Gg: ASbGncsuhyjBa4hIcBqvIbWKB1uhR3nbvDPPj+Cvd72i+nqNrntfrdVGOzePRCcbw1W
	QKAJwvpWZsZCKkWRqKTiiKauKQca/Isrmvmh7L9RglQaAUvcDd9ihnxp5BLZaIAB4rg2WisL3Uv
	dR18sRzL8CDgZXAufwiFlrZDj5LdQzy24LcaDXUGxTVKNswBqucnCT3sfvh2XLrjWHRdKaltasE
	eMUP5gMzNyK+sK7gryswpgGrWDS2gN1c1KBbrleJkhmuXxoxOlsMlml/5SC4rdFecKVR8HmpjSp
	O4f9D3aPua66U4/5BaynHn8T
X-Google-Smtp-Source: AGHT+IG5tP/v9M8GFdg+P85S4xVexxykjdMhOzU4N2lwZtfUNFfRo9lvThSz2x7aSYdfRtQqlpTghQ==
X-Received: by 2002:a17:902:f547:b0:216:2bd7:1c4a with SMTP id d9443c01a7336-223690e1b20mr10723225ad.26.1740689840131;
        Thu, 27 Feb 2025 12:57:20 -0800 (PST)
Received: from gmail.com ([98.97.44.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d5247sm19775925ad.26.2025.02.27.12.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 12:57:19 -0800 (PST)
Date: Thu, 27 Feb 2025 12:57:15 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, cong.wang@bytedance.com,
	jakub@cloudflare.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
	shuah@kernel.org, mhal@rbox.co, sgarzare@redhat.com,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	mrpre@163.com,
	syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next v1 1/3] bpf, sockmap: avoid using sk_socket
 after free
Message-ID: <20250227205641.n2zpm5yetkoopvcz@gmail.com>
References: <20250226132242.52663-1-jiayuan.chen@linux.dev>
 <20250226132242.52663-2-jiayuan.chen@linux.dev>
 <Z8DA8TqMEYNziiT9@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8DA8TqMEYNziiT9@pop-os.localdomain>

On 2025-02-27 11:45:53, Cong Wang wrote:
> On Wed, Feb 26, 2025 at 09:22:40PM +0800, Jiayuan Chen wrote:
> > Use RCU lock to protect sk_socket, preventing concurrent close and release
> > by another thread.
> > 
> > Because TCP/UDP are already within a relatively large critical section:
> > '''
> > ip_local_deliver_finish
> >   rcu_read_lock
> >   ip_protocol_deliver_rcu
> >       tcp_rcv/udp_rcv
> >   rcu_read_unlock
> > '''
> > 
> > Adding rcu_read_{un}lock() at the entrance and exit of sk_data_ready
> > will not increase performance overhead.
> > 
> > Reported-by: syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/bpf/6734c033.050a0220.2a2fcc.0015.GAE@google.com/
> > Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> 
> sock_def_readable() already acquires RCU read lock anyway.
> 
> Reviewed-by: Cong Wang <xiyou.wangcong@gmail.com>

Thanks.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

