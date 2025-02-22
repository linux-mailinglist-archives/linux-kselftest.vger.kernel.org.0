Return-Path: <linux-kselftest+bounces-27248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F31A40400
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 01:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75280702FDE
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 00:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4A82BD10;
	Sat, 22 Feb 2025 00:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVd9VW4q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6FC22331;
	Sat, 22 Feb 2025 00:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740183652; cv=none; b=n57InmfucUd/UyX+Y8V9+nVCrjs9UfxscuWPFa+oH7GMnidOiI25km+lWGWVl/PqnDFW7/sIzqPSVD/ZEFnTVdWQ9kIbDYkrWTN28bgQDwbk/22ASAeGcUY2q95EWKGp7qCBc+z/6n1LnhaWlWUzc72lCeIWYNe8g+amb0iOcrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740183652; c=relaxed/simple;
	bh=Jpld/wsaMvDtefkVSAfetn//7dDE7ynrwiVJdhUy0CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBwAmLEbdFbeHm4n3wyjzoY04XvPXrtrI0LPaUqfPw8kUbB0QusbJYAg9e01CzKHpWBSU6fj7Eij18kcObolk66d0s6fpWeMYAIK7hDNX40YVdBmycuNaW4Erhym54Ft5H45iEM8qkp0euVGLCpHjDcu2hCWX3ufIUEsB+2vj+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVd9VW4q; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21c2f1b610dso77025025ad.0;
        Fri, 21 Feb 2025 16:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740183651; x=1740788451; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=baX1epNayrlQi72ddzJtpU1XVAnuAk4Noe2u7Id9cIE=;
        b=IVd9VW4qckoCoRtyJP96L2CxvuGJybieb4zsOuVuHC8AV9lHeoX8WJkWtj9B2vUaQG
         d4q+YyNWYUTR5CZ8HPNE2LOZBxNPCClD34mG6Necfv7gq3u2EI7gvTM4sCnZqdPZ1pBr
         +WxoWC+yRI0TvjvHTxrr7mFXwrLRrLVGkaQ4+ywWzbJF68+6y2aL4jt40awRR/4Vz9R0
         PKGLZDM9iJrkk8i/QZQcEeexEHh7YOf4G0i7tmV0nFidhvrbhk6k++ivDcK/VSnl8OfS
         wz3trSWPQJfATkPkD8pMi9pdVi+HuDeCml0AIkBWlD0jiWtIuw1Y/t3jChGShvv/+mAe
         ih9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740183651; x=1740788451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=baX1epNayrlQi72ddzJtpU1XVAnuAk4Noe2u7Id9cIE=;
        b=wP4bDhiDo1tS4+QZIrKWP7SufWRsg5eGDgHQA+H0e6Hx1e1jVWrvm73jmrU2qTC2Vx
         onmhFzX4X3xqvW2GF0ZGkPfsE/HDyVFTON99dbzMxSnuBkN2rCWeQw2oMGCjHL4qC2Zg
         w5LH8SY9r9LKSMuBQ2S8AZQ2ZJv/1lEDptO3ywlm0jLlEQnKddeeJ682otQtymC7j2sX
         faJDoQjfrztkqsLPcLAhlzkg0WQkGxfQsJ1rRu0dwkUqlEXsZiiVvQKXuRbvp4msVSzI
         e/RAeuFgcTrv1MroDtJC0fymeGhk6ZXR0NOAMgYJlyyYkdFUPmxh1weYR6H4n+FDGUdj
         /y8A==
X-Forwarded-Encrypted: i=1; AJvYcCU3TNGt/4ugwmd3+iAYx1rRy3NVxpu4Z2P409Dm2I8wx+hErmHeC48AFagAjBonDHY679BEnvdgfGLBGkct@vger.kernel.org, AJvYcCVlRMvqzd+V1f9qGWjm27Kdj+uUbMlq4SRsAlgKWmI4McsV6qgIjLGX1HVCbRNjR06Snts=@vger.kernel.org, AJvYcCWUmSJ1uPvWlAPZjOGbPTgsbkCbTu+kmWudIcLP9BOxD7bisummFwGzAGOAuij5ZQZczB6ODa/DnlS7@vger.kernel.org, AJvYcCXsrSwEGXpGZWeVihzF+H2JmcvV3Xe9xeZi44aD+QJr9vNomTRwxKCapJ6dBCQafg1WS4L2tJcpdZjZhvNUUzNj@vger.kernel.org
X-Gm-Message-State: AOJu0YwTAbgjpLsQZ8t3k42k1LyjdXqdnxwelchOYW8wApdAFGpe2g9z
	Gtt9Be8+dKe3CpLwHiJ541qC7qd3KH7VxkGoVFeZyVlKLx1sdok=
X-Gm-Gg: ASbGncsRyPQ/o4FBpONBkW4ze4mI93Hx0Fiboz5X5avm6jhBN6M1q+wonFypyA7Z0C3
	9A7h6mjxXT+hApasR+8YNLWU++eCsrh+P/yRf9to6Ufubc/hfa49M5mIsbvrp0xtSNqbOsbiqik
	4TtVHvChr/WfCA11qocm1fPlGeXunuCajCzC4K7Xdi58GSxLBOBDJgwkhumbpsIzGRrDuIpv+c8
	rDrpq7De8BYA4uONHkTuy0y9d7uM24/v8MJjKzDUVGbMx5+Pm9hWMt5n4brZ50xGmM00M0OZTBo
	2iFklSJV/O/q5teJW0WqX2O+9A==
X-Google-Smtp-Source: AGHT+IFrCX359QmoPl+1WWab5kh2KoJ8H2vJqfNJp4uKVLxMtCxfKGr/wOCTqr8fdP4NEXKxJS3a3A==
X-Received: by 2002:a17:902:ea11:b0:216:55a1:35a with SMTP id d9443c01a7336-2219ff61e5cmr69980445ad.30.1740183650542;
        Fri, 21 Feb 2025 16:20:50 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d545d051sm141438035ad.108.2025.02.21.16.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 16:20:50 -0800 (PST)
Date: Fri, 21 Feb 2025 16:20:49 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v4 9/9] selftests: ncdevmem: Implement devmem
 TCP TX
Message-ID: <Z7kYYXixRws7Kk-q@mini-arch>
References: <20250220020914.895431-1-almasrymina@google.com>
 <20250220020914.895431-10-almasrymina@google.com>
 <Z7eKHlA0rCF2Wgxb@mini-arch>
 <CAHS8izPA2eQ251-whnsT7ghG01c0e=tERL4Cwg1tBr+ZfVNHpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPA2eQ251-whnsT7ghG01c0e=tERL4Cwg1tBr+ZfVNHpA@mail.gmail.com>

On 02/21, Mina Almasry wrote:
> Hi Stan,
> 
> Thank you very much for testing. I was wondering/worried that there
> will be some churn in getting the test working on both our setups.
> It's not unheard of I think because your ncdevmem changes had to go
> through a couple of iterations to work for our slightly different
> setups, but do bear with me. Thanks!
> 
> On Thu, Feb 20, 2025 at 12:01 PM Stanislav Fomichev
> <stfomichev@gmail.com> wrote:
> > > @@ -25,18 +25,36 @@ def check_rx(cfg) -> None:
> > >      require_devmem(cfg)
> > >
> > >      port = rand_port()
> > > -    listen_cmd = f"./ncdevmem -l -f {cfg.ifname} -s {cfg.v6} -p {port}"
> > > +    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.v6} -p {port}"
> > >
> > >      with bkg(listen_cmd) as socat:
> > >          wait_port_listen(port)
> > > -        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:[{cfg.v6}]:{port}", host=cfg.remote, shell=True)
> > > +        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:{cfg.v6}:{port},bind={cfg.remote_v6}:{port}", host=cfg.remote, shell=True)
> >
> > IPv6 address need to be wrapped into [], so has to be at least:
> >         socat -u - TCP6:[{cfg.v6}]:{port},bind=[{cfg.remote_v6}]:{port}
> >
> 
> Yeah, I will need to propagate the ncdevmem ipv4 support to devmem.py
> in the future, but unnecessary for this series. Will do.
> 
> > But not sure why we care here about bind address here, let the kernel
> > figure out the routing.
> >
> 
> I will need to add this in the future to support my 5-tuple flow
> steering setup in the future, but it is indeed unnecessary for this
> series. Additionally the bind in the check_tx test is unnecessary,
> removed there as well. Lets see if it works for you.

Hmm, true that it's not needed in check_tx as well. Let's drop from
check_tx and introduce when you need it? (but up to you really,
was just wondering why change rx side..)

