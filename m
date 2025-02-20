Return-Path: <linux-kselftest+bounces-27107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4BBA3E51E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 20:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E2119C3FFB
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 19:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70A22641C3;
	Thu, 20 Feb 2025 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fo8Smy6I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4403C2638A3;
	Thu, 20 Feb 2025 19:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080055; cv=none; b=T39WJNNkUPZ6Tr5grbKtg6Kkqxo1qBg0W3KKjlKmDWun00+H9+xIWqBttzC8AuUMylV6GPlsNTOwpFKwpfSQJrzg+I5uxYBFbkIAXDqselJh4q3CTwLsWXSgAJy9uDH5wsWBCo6njlWzTVNOw5tpCgOG91eoYZ5wzQsiMA31KV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080055; c=relaxed/simple;
	bh=lLvSCfGzR1G+5sP88MJmJoxG3MsULk9EywePmaCSpPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixZkP6kjQ9mqY9+gd9kvWRuJiBHYI035rGJpa1Wl4asJbP3fLs7FUygmz89v+yEI+pexAVeJbqhAPMdyDcTyhCrYcBxO00x6D1bHL7jerzTE/RDGFuv9jW68WHgZmxj0XVScjWkC5cgxy7bdjeOKhv/g1UbyQ/8CIjrXC3zFEas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fo8Smy6I; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fc042c9290so2256968a91.0;
        Thu, 20 Feb 2025 11:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740080043; x=1740684843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTiSUkoMecG9RlHxgT6mcfjx4A34996Guxh4H1K/phg=;
        b=fo8Smy6Iuc/abaQfBRgopj6QuLwQ94TnGkjkgZAxZuHqftzKqkuMB028lQquqsCjcc
         I4Kj4/YceLJ9W564uYkMCwVYDsx7Rrm+bFQe/wplg4r5Bno7YZsDrqcVq4TTloTAPCfN
         hbOIupyTOUzAA/Lf+WtP7OThLSCbwdVcfKAq/mNGxWE/EC04M087bSCSV7cCEIW1ztIg
         d3+4FGnmtomfQfefKAs1DxDmVpcYlVMJm2FB6btoKiv6/ofH12YXvAi/Y1sVkHbLozIC
         wxW1EE2OFrgZ23/Nrq5mPRSTQBXkbVTUHmMpOlX4vkDb3KKJOV9SGGQcWMcxooEO/fsu
         SVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740080043; x=1740684843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTiSUkoMecG9RlHxgT6mcfjx4A34996Guxh4H1K/phg=;
        b=IOMOCkxMS3VFBNA+2gyIEvplWeT/S3MAjC4TWW9San1XDMwyYvgG50yY1KHVB98GVG
         usZ/3zT/1qMMzANBurg4iru9i5YzhEqXbNO+RB73nrdNaTDTDyrYFJ7qQLYKcxnxd6rL
         DNRi1uRgqk7Pm7m+Rn+hCxVUmOUigRIZoPSP3xlBYdB1M9NXVvr32Ib7zYexVBIVwfid
         lB9UenpskrZZTpBeY/smSWQofHCM2tjdj0dPSGiRliO7YfQSt2n3Gweb5ethjRBbZFgx
         7fL5jpaSU8HuyU+8F1I++txF/xv1jVEI4FumQn3pEFoowYZHjD5w55EsxhWgzC4xk9HF
         3+IQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1JpjdpaslVRiJsarplTHNVc3sgDgAhlG1BBp6Uq+FogDdipPNnIEGn82YHU0ypjZzdKaMyVnqxaPKZV8W@vger.kernel.org, AJvYcCUbsxRstSKUJXqI8MthpB+ATY4Ec2qK4Uw/k/aBLGjCfwzyGseX3vJ+UTXMD0bTWI4K5DK/X4toaJ40TYrs3/tU@vger.kernel.org, AJvYcCXJRnjq6y3FLUGsuJmu/m3N6+ZBXKkmwIkeVUTiG6c/bZADlEWqBtNkgupKxPcI5j8a2kEvwjremx+C@vger.kernel.org, AJvYcCXiy2SvlbB5FdQG4IQVzA2rmim8M5cKfOOvjXrSda+uwDOWJAVDzZYDEAhcYrZOBu+bUhs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx53pRu+6tVd1637Mh/I2UXMKNvUXFtxxIm0ZD9bGiuUkzl+dWA
	2BSdlhh/R0mGt/IPBbCCauHT9Mrl7whUN70foUoIjSwpvVwQpgM=
X-Gm-Gg: ASbGncuokvM/rJa5d8Dg3BCXqrfcHQPeKQ0yAsCCf7FTNKjMgB+HiLJFVZyPOf5Y+Ut
	ysSKzJHXIm/md8/rEPQo/YijEiddxfcBqi35miitU4th5EOtVaRHTLVGde2G7BrBWHkc/NQkm5u
	OlUPvpdzsKXALVWofrg3rOvDZPFL+Y+8ZJnYnsbGtiN6AcU+l9vn8lGFR/XFM1q6g+q1jHdM0s9
	4BlkjaZ4Gd4OBgEj11z722yZXdHHEGBdAi/cRrkhLSk73yL8u6YUlzhStiQU2ZLJwDqEsxi+rCc
	JatCOP5a8ezAh84=
X-Google-Smtp-Source: AGHT+IHodAJTRfe1tv7kfQiCPKc2cGyPrUaPKRCuDC1rwACb5ZM8W6rjPG0qmP5bRg2hTlH0FYozsg==
X-Received: by 2002:a17:90b:35ce:b0:2ee:cded:9ac7 with SMTP id 98e67ed59e1d1-2fce78ad9ddmr594804a91.20.1740080043522;
        Thu, 20 Feb 2025 11:34:03 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d53494c0sm124354095ad.6.2025.02.20.11.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:34:03 -0800 (PST)
Date: Thu, 20 Feb 2025 11:34:02 -0800
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
Subject: Re: [PATCH net-next v4 1/9] net: add get_netmem/put_netmem support
Message-ID: <Z7eDqnkwmpTW5963@mini-arch>
References: <20250220020914.895431-1-almasrymina@google.com>
 <20250220020914.895431-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220020914.895431-2-almasrymina@google.com>

On 02/20, Mina Almasry wrote:
> Currently net_iovs support only pp ref counts, and do not support a
> page ref equivalent.
> 
> This is fine for the RX path as net_iovs are used exclusively with the
> pp and only pp refcounting is needed there. The TX path however does not
> use pp ref counts, thus, support for get_page/put_page equivalent is
> needed for netmem.
> 
> Support get_netmem/put_netmem. Check the type of the netmem before
> passing it to page or net_iov specific code to obtain a page ref
> equivalent.
> 
> For dmabuf net_iovs, we obtain a ref on the underlying binding. This
> ensures the entire binding doesn't disappear until all the net_iovs have
> been put_netmem'ed. We do not need to track the refcount of individual
> dmabuf net_iovs as we don't allocate/free them from a pool similar to
> what the buddy allocator does for pages.
> 
> This code is written to be extensible by other net_iov implementers.
> get_netmem/put_netmem will check the type of the netmem and route it to
> the correct helper:
> 
> pages -> [get|put]_page()
> dmabuf net_iovs -> net_devmem_[get|put]_net_iov()
> new net_iovs ->	new helpers
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

I remember you wanted to have more fine grained refcnt, but starting
with this is good enough for me.

