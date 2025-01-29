Return-Path: <linux-kselftest+bounces-25382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D17BA22303
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 18:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EBC83A55B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 17:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944411E0B82;
	Wed, 29 Jan 2025 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="kYZqUmTd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C4F1DF991
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 17:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738172060; cv=none; b=eMiOjPpXF11UHYjP5yrYq9yJH6J6aAuvcOiClaMYig5KdXis5wo+OUxnMgyNAoxAeFEm8ukmOe2aJt82GZgUwDecRLE8dUamh05Lg57jijVKCtBVpm9vJdDLJVrca41wj+hpB62Rp6C81XMlj89TvSlY7i6QBDJMt3QYQBxSxcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738172060; c=relaxed/simple;
	bh=zGljS/9FhfUb47+VGIh8ikTRIRMMgOhXhmPgPUZSEIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HF4mucosrc6EMCkCWLvN7O2MaZo2hKhZUiLSVmkAvwv05yfOaJmsgRNSoZ3gvtAW7D3KQ3sPEjdJUNbcRKjfDfNxdPKvr4UpL8OY/qFUkW2z6+7UdILOB5aor58xZ33unxxn6+MpzW3wLCVeXIaCK51NNttmdvjJ2k79U5tmGbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=kYZqUmTd; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dd1b895541so3422426d6.0
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 09:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738172058; x=1738776858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GoQDpS1qfePfDFzhVnadb3EAh/sAqIsSZHWqGtMfdWk=;
        b=kYZqUmTdziQYxynReb2cOavmQh9Jbl2OPXXLWAvTm018EAB5qFGONw5033h0NrQ6Wj
         FXzIO/y3Oq4mCBQdTi7sGutH/TecQgxbOpfIMmom7EFgQtNYt8qNgpzNX/0vWXFVHDgt
         f95BWMSqFtTfLlUo/DxgNQuJc+bUBUo7flIb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738172058; x=1738776858;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GoQDpS1qfePfDFzhVnadb3EAh/sAqIsSZHWqGtMfdWk=;
        b=BTPtzRYg2ekrtJEi2jnmn558qxQl2CV09X/Qv2exWaV314DbQU43cMxqOMJsKOV2gX
         VCrbGXw306+El0ikJt263psBQbnS/bH9j3lGGHCuhHUMwz+/foemReS/6q9RxWdkRUuy
         /316ZGgqFkw6hjaqONHLKJW07nL5BjHvL90+m6qx2MgQxcCPD9+/QJP+VmfitwEYoyrC
         M97HxTJU7hVgsPXNPTudk2xKjkGvum4HLKczGMdnV0J2BGfPzxpMHb+9OnjAfh1o7S+z
         b9gDaVH54B6zNqfmc1OOHnOIfpGsd1QKn3ggaCJpYfB50ZiR7CGad/0Fevjw4Otg6wU/
         A7DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw2Qie8OLApIKCuzEf2F53Vyh2pVdnEWP2fa+NxQd14JSIDw4XOOR/KUlyCbV2S5B8LeCi9nLf+V9k/NhEW6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKEyQ4gv4F8Aahh3NsmzeIRJCFB0McA8BozUCuCIJzREiiiI1J
	B2X3qgchcJjvlr9xU0c6DqKioTFs9IjdsajiaSN9w0oW/kMO8UwbFt/7Dw/m03Q=
X-Gm-Gg: ASbGncuKzO2ey5fTjVGB5d6yn+Nlg1qAu02rNqby3bBxbY3hSMHmRew1EPVJDRW4Kvu
	VLpqRjn/wbBBWJ/AVEtDXVhA1mowxqHOycXq0dA1W6H+MCBGuIeYDayj/Jf7jbxIFs8xxtMBGW7
	Tvi39NgqQuNAuoUf7qzRHjTV3vmiyugZ5DGLMv66/C+MF+vc2zzGPcm2YvzoxWYfhhyHGsLziLc
	ABmWQ8KzIPIoty3JIMKCiLMcb+VWO4KFj+uZa6GGg70kMXIxHV8pQeU+ZZO465hm5FCu7pVykr8
	RA1DfWXvH5inEIr2xgu9uQT4HpRjaJZB/zke9Drr2aCPEUxXAyoxbA==
X-Google-Smtp-Source: AGHT+IF4BBG8e6/7GOvUoRvTwqooHavsdcNd1DktR9rvgjZFPh+v5/6zznBp3CHsRrcIltj/YWsCgg==
X-Received: by 2002:a05:6214:1307:b0:6d4:e0a:230e with SMTP id 6a1803df08f44-6e243bbba57mr62866726d6.16.1738172057768;
        Wed, 29 Jan 2025 09:34:17 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e20525aabcsm56814206d6.58.2025.01.29.09.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 09:34:17 -0800 (PST)
Date: Wed, 29 Jan 2025 12:34:15 -0500
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: sridhar.samudrala@intel.com, Alexei Starovoitov <ast@kernel.org>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Mina Almasry <almasrymina@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC net-next 0/2] netdevgenl: Add an xsk attribute to queues
Message-ID: <Z5pml3Hn3m3Km7Yk@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	sridhar.samudrala@intel.com, Alexei Starovoitov <ast@kernel.org>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Mina Almasry <almasrymina@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20250129172431.65773-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129172431.65773-1-jdamato@fastly.com>

On Wed, Jan 29, 2025 at 05:24:23PM +0000, Joe Damato wrote:
> Greetings:
> 
> This is an attempt to followup on something Jakub asked me about [1],
> adding an xsk attribute to queues and more clearly documenting which
> queues are linked to NAPIs...
> 
> But:
> 
> 1. I couldn't pick a good "thing" to expose as "xsk", so I chose 0 or 1.
>    Happy to take suggestions on what might be better to expose for the
>    xsk queue attribute.
> 
> 2. I create a silly C helper program to create an XDP socket in order to
>    add a new test to queues.py. I'm not particularly good at python
>    programming, so there's probably a better way to do this. Notably,
>    python does not seem to have a socket.AF_XDP, so I needed the C
>    helper to make a socket and bind it to a queue to perform the test.
> 
> Tested this on my mlx5 machine and the test seems to pass.

I should have been slightly more specific, I ran queues.py two ways:

1. By setting NETIF= to my mlx5 NIC
2. By just running queues.py (without NETIF) set (which I presume
   uses netdevsim)

The test passes in both cases.

