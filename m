Return-Path: <linux-kselftest+bounces-27116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C0CA3E64D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 22:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59751189C1C6
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 21:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEC82641D2;
	Thu, 20 Feb 2025 21:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWGDMEl0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9987D1EB1B9;
	Thu, 20 Feb 2025 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740085509; cv=none; b=spoc7B5tuwK6tiJpLZ8jxjcXKz5PoE3fKfieMZOEevdg1WEtQYPchb4f78U+na5esWr91IuJJy0b+wZZsTC2heOKjXGWX6eCmzOEoHWvyLYImU90wa3zknPK6ts/TuRjvGHWu+pnAJyi35i1yfsm5nXG4BnEhHlPTtME4U+kJhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740085509; c=relaxed/simple;
	bh=yO0vl3vl6r85XRczqqyFXg3rFR9Qwz/DloafjuQ7Igk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijstmmLlgHx2wOdzN9PGhMDXTwrE3c/eTJiCZb3P3Vl8znZx0mNyJcgxQqJguEPqgKS4N1oLp27c3GwGhjpFpCxGoy2noYWOezxFmp/HNMMzkYbBbAy2qBU3h0xrQlMkyDn4Lmq/CmHKCNmpzBTs2EBBkg320McI+0mYaLOaHwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWGDMEl0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220bfdfb3f4so30766855ad.2;
        Thu, 20 Feb 2025 13:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740085508; x=1740690308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2oxhd4XT/zCoDOMejdSRLbrpeHrRuTkeG6alk6G3I8Q=;
        b=YWGDMEl0+OQtxyKbxYp21F/YmYtp/Zc0KG6Te38ozPOhz5k2AM0g/za3luD1GMjYj9
         UrgH3K/levQ7G0t0IQzRxiLKVkjXLhGb7NiO5BliGydZEHn5N/MlBQ8L9AKn9ytzx41T
         7qfrSvt0c4XC51NQ9LUVOazqtuF6rfuS8jZwww+ihdS9DsxH5YGgdJboJRbdJ2GsYK3H
         1vUAVMboCVxvM8qrZWbOGYaJQ8IV+m7NaH0nX97pgZLrim0Dnli+Lz2wnmuU5cUWCpQ7
         pvhPUap224prCDFvZ9Fy44a0Uf57BjwmQLNeEabJw/F8lcxPbyvGlrrPlS9G+2tee31/
         he0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740085508; x=1740690308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oxhd4XT/zCoDOMejdSRLbrpeHrRuTkeG6alk6G3I8Q=;
        b=s56smVaeDoX29iyK1IBcNKXjjOop2VN9rzgUITWt1CogFozMTOXcrXT1jF7Q2+7FV7
         0q8VXMu70GK2D+uibDG1WRdnLeVv0ojPPAoG4/3SxIF+TS/JGyIAajQxkyfxP87IVV8Z
         svyxMcOQdwm3bwVqyNyKqtZZV4uil4mFRiD8B/bllVmR7FTEfR517ezOhhmdcfIXPmV4
         zKd38I2DoIleFpWCFiRyfRUmKxtFYwtZTXeTeipfK5vk35pM9pRk9EuhEbl/z080C6YG
         jnfM4I10D1+LIP8qgeND6IAeWCRczXx1ttXfP02hZzW+Y9Or3YAD6SF/IJsFOJGpzlmS
         W6uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMVVaPywQUMeYbmgmztk5muAFHiGiS2fj9BRqaZzi9qtJApkerMm1d2p2e0QBFtj+jNrXurdiO39k1VFqMxuTn@vger.kernel.org, AJvYcCW3tADVsyDaslwBg9S6cjckf0I62qosL3+VZU+Ox+4eE5HLSaXeaYkOJ/0SgBt53NRXqPOGLkHP56mpA689@vger.kernel.org, AJvYcCWqWy8V1QQV3KOCU6BSIglVdgStaVoNFFzIRlPjjLfR9x+pA9Ksh6BltOHo5lThAIKW2YM0rGMfd2Gq@vger.kernel.org, AJvYcCXZn+zMVHSvzU2KVuLBqLMMPQDRk7dmgQHUNjsWX5e08XBFYNCf4nLrzr5jNa3+WdS7VJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3mKESpTbA22iCZGwAoSZVp8ihBuhM79bMXJdO3L8RsTJ1ec2N
	GeEcFCxnqaZg+LBQtTJwBQ5Iq2y/JwZSNo0uI6jj72HmDqO+C1s=
X-Gm-Gg: ASbGncs5DflP3VAgRyWeFSzLTZW4gF6MwcDxfUr/Dc3OqAhZ6cMyzhkpGA7v81C3fh5
	vxshg7lWNxdHmZWEPqfgP/G6ydJwYxPZieUl+T9cxeF27DHICzbEdY8SW6y/LeZIkiT17AOEvCt
	iYmiCYDMMnCPbXh+dYyzKTYXJBeVGRMAEG3HAbeiHal+8V5e3s5YI018ExLgjRAC1Opgii0bPTQ
	yLoTv9WFF+erhLCTBbAAabIo62krSlfdy5ggbyDbw/TdDv+ihAnxieeD+CPVnQWEQHPomDR/67I
	xPQ4v/Suz4ccyqc=
X-Google-Smtp-Source: AGHT+IGyI5hMvhiDLYNc7OSURvPKm2QVi6I1a+B2WeRwUY5Bk4xeWkg2HE+1oCupSYjRz9XCcRNZHw==
X-Received: by 2002:a17:903:41d0:b0:221:337:4862 with SMTP id d9443c01a7336-2219ff50e97mr9604975ad.15.1740085507661;
        Thu, 20 Feb 2025 13:05:07 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5586141sm126353825ad.227.2025.02.20.13.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 13:05:07 -0800 (PST)
Date: Thu, 20 Feb 2025 13:05:06 -0800
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
Subject: Re: [PATCH net-next v4 8/9] net: check for driver support in netmem
 TX
Message-ID: <Z7eZAo3M06ZnLMve@mini-arch>
References: <20250220020914.895431-1-almasrymina@google.com>
 <20250220020914.895431-9-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220020914.895431-9-almasrymina@google.com>

On 02/20, Mina Almasry wrote:
> We should not enable netmem TX for drivers that don't declare support.
> 
> Check for driver netmem TX support during devmem TX binding and fail if
> the driver does not have the functionality.
> 
> Check for driver support in validate_xmit_skb as well.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

