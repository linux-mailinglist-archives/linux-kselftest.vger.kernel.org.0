Return-Path: <linux-kselftest+bounces-25110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B23A1B954
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 16:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A70B27A6D37
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 15:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBC2155726;
	Fri, 24 Jan 2025 15:28:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1868F15530F;
	Fri, 24 Jan 2025 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737732515; cv=none; b=Szv/uu42A0Nwh7qdCocxqT2MMBeligsy7qyDwUexz3iafa+EU/3KDEZ1gZJgXjSquBNKu1dYt03+uP1oqIVTevLUSZbVujm73JMKZCZRyjSSxTdth8Q3sIjl2ux8Ozxt51DCFQ+xqndPv7tedm5EFflqjBEIKiv4/eMEufIuQsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737732515; c=relaxed/simple;
	bh=Kdt1Amu9IODypCEthw9qXZvk1K8Bgka3jNdPNAQgiAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kn2z7MxI1s8zajN6r6Z65EjVt9SaWaUsVSeyIND1o8MJ1qdDyyeDR4XeEvkzO7rT9eVQjoDjH890PnEsBpoPXUOd9keAy24czEYMlZrBe05V9sBCLZus6PhdihUgdpBW/5gG4V63QIWaqOBePc5LKuahObAiUa6mVEu2ctRP9QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d88c355e0dso4327990a12.0;
        Fri, 24 Jan 2025 07:28:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737732512; x=1738337312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5X1YXwR0EWpUwO1zmmq6GeCx+3YJvupssE2rYXIizgU=;
        b=TmH8gbdwhEzbssu7GBhOqxxggvKwPcM16cJpP2CN6gjvuKYhGpfk7IosHaJqmy7owt
         go3IFCIwR5MdRPqmLevzGJr9fJizwowFk3bMALBYzH+mSFgfr2uWQsmO2lW2Cybd50y0
         s/GV1cq4ff4waWu6C8zXjekWCTPlnWaCAdMjlXkpNeM3fRXi8n/ZpA6T/1y7CfMLC0k2
         zZxLOJ7Us4GaVt5ooyzLEmfqAjA9wWLybQMPBYwKNTmM9Izp9LPHHUh/qJi5zCPUioUf
         ZV984g59kMuXRkCdmrsF8bV4yjqfHTafgyB5kH+S3HVSuE0P0fu7DXXVDsenHxP2TwjG
         MqJw==
X-Forwarded-Encrypted: i=1; AJvYcCUhZh3ibN+BApDKHGqxml9Tre55MG6iM8CTxrp32fQdo1ZYr1JEK6eVOGgMvsh5LQwO+AUWIVHlyiuKhrOI@vger.kernel.org, AJvYcCUheb1qN++uEeog5zpy2BPzBFZ1AdB37XH/00WIjq5glG5XhE6cM0cY6WW/LC95LQrpTQ7EtuKh3Uo=@vger.kernel.org, AJvYcCUxjSm9nDKed8O0C7muKGpAsrBtxp+ZcUNF6vomkxqHtutxXTlR9Kwxg0ij2M98LzeXav1VwT17hFHYy3MwL4v8@vger.kernel.org, AJvYcCWB52hzwI5pPIxvN338lTMS9DEr7k/ankLD2DJOQMmjGeXGhW+PReYsuHjucwkuJVmNKkVm+AN2@vger.kernel.org
X-Gm-Message-State: AOJu0YyBn6Hj5nLPNKUwN07Jyy4h+pQHPmSmoGbDwKLy5AniTj7sCEC2
	BGZ8ak8L8PupGTzkwZ3H5kWqToTB4/5jcTnv7w83lkhbud0NpWas
X-Gm-Gg: ASbGncvZslBnEodUNooxHsPFeq+FK6T3tHiLfUPqkkp8QWIzBimptd89J1i0K0K3AnX
	0huKTcQ1NesyJWZkfRluMIJa0gFFhE3d5qFzTKPvRtOtKZradbRe+OJlRvzS5VvC2QM59AgN6l8
	qAvgjxnWm5WqVH4yEkzGRu1LTu96ao1gpZF7QvNvcqWWkqs++kZbZKNudwWsjZGtDUm4NpvW/2X
	jkE1ykugVnkIjvPYXnODNf+UJwM9DGXToIg/XcgdlOFwYC0fbez+ItOTxNfMFrtD2QmkSfU
X-Google-Smtp-Source: AGHT+IFe/WTVivGHlCaX4JbjiwomSZTCHZ+uWJH+TyMRkJT50oE+w6fQBy36WSHwlKpbBFQ0Vxc7yg==
X-Received: by 2002:a17:906:4fc7:b0:aa6:6c08:dc79 with SMTP id a640c23a62f3a-ab38b42d8f9mr3045664966b.35.1737732512178;
        Fri, 24 Jan 2025 07:28:32 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc186d8ac6sm1261487a12.77.2025.01.24.07.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 07:28:30 -0800 (PST)
Date: Fri, 24 Jan 2025 07:28:28 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@meta.com,
	max@kutsevol.com, thepacketgeek@gmail.com
Subject: Re: [PATCH net-next v2 3/5] netconsole: add support for sysdata and
 CPU population
Message-ID: <20250124-red-crab-of-mastery-23bc19@leitao>
References: <20250115-netcon_cpu-v2-0-95971b44dc56@debian.org>
 <20250115-netcon_cpu-v2-3-95971b44dc56@debian.org>
 <20250116174405.20a0e20b@kernel.org>
 <20250117-terrestrial-clam-of-satiation-cf312f@leitao>
 <20250117183520.11d93f4d@kernel.org>
 <20250120-rational-bullfrog-of-tornado-2cd6f4@leitao>
 <20250120110653.693fd5ec@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120110653.693fd5ec@kernel.org>

Hello Jakub,

On Mon, Jan 20, 2025 at 11:06:53AM -0800, Jakub Kicinski wrote:
> >
> > The only way to do it properly is having a extra buffer where we
> > have `cpu=42` and copy 5 bytes from there, and then copy the last one in
> > the next iteration. I am not sure we can do it in one shot.
> 
> FWIW to simplify reasoning about the length I thought we could take the
> worst case, assume we'll need len(cpu=) + log10(nr_cpu_ids) of space.

We can do that, but, we are going to come back to this discussion again
as soon we expand sysdata. For instance, I have plans to expand it to
have task_struct->comm, release, etc.

For that, we need to know the length of the struct ahead of time

> > 1) Average messages size will become bigger. Thus, memcpy will be needed
> > one way or another.
> > 
> > 2) Unless we can come up with a smart solution, this solution will be
> > harder to reason about.
> > 
> > If you want to invest more time in this direction, I am more than happy
> > to create a PoC, so we can discuss more concretely. 
> 
> I don't feel super strongly about this. But hacking around is always
> good to get a sense of how hairy the implementation ends up being.
> 
> 
> To rephrase my concern is that we have some data as static on the
> stack, some dynamically appended at the send_*() stage, now we're
> adding a third way of handling things. Perhaps the simplest way to
> make me happy would be to move the bufs which are currently static 
> into nt.

I've hacked it, and I think I addressed most of these concerns. This is
how the new RFC is:

1) moved the buffer to netconsole_target. no more static buffer.
2) created a function called prepare_extradata(), which will handle
   sysdata and userdata.
	2.1) to be fair, userdata is already in the temporary buffer
	  (extradata_complete) since it doesn't change frequently, only
	  when configfs helpers are called. We can parse configfs nodes
	  to generate it in runtime, but, this will be unnecessary.

3) prepare_extradata() is called once at the send path.

I've just sent an RFC (v3) with the full changes, let's see if it
improves your concerns.

https://lore.kernel.org/all/20250124-netcon_cpu-v3-0-12a0d286ba1d@debian.org/

Again, thanks for reviewing this change,
--breno

