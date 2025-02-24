Return-Path: <linux-kselftest+bounces-27370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F939A42A13
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 18:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 198DA7A9C37
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 17:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C3A2641E8;
	Mon, 24 Feb 2025 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVNK6mYo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D0A241672;
	Mon, 24 Feb 2025 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418716; cv=none; b=jx4UkXDDSuqqcS4t9eQNmghXiKsTheYBtKBW4j6ETRFuuLpXRERdmWi1cn1S5RcAfsM5m3g0liYqHEGahgZizIdEHsG9uH6OlLV5WTc0W6Gca5UScrpuX4zgj7kFrJA5EgAh6OcBm5RjgxEY5wjwpdcblcUvfOeRQ/eN3ljd9Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418716; c=relaxed/simple;
	bh=6WDWAvw45opfe01BXQoV2J9T4wPwlIJFh7kOtE0s2h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSAdVv8czAxJ8PsgChdkjs3/e5w9oxNxHsTbpsMiKWaYkfIKJ9gaZPV5uD78HRk1Al+yjVcoW3QtKXcauCR1MKGqx1waA4e3Wgzf6glDrRQY4ZIhS/mig2SdrMusEaDJxHImpa84omSTkiwjevP121H9wpPbCpuUSdxfmoLl/Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVNK6mYo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22114b800f7so92976915ad.2;
        Mon, 24 Feb 2025 09:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740418714; x=1741023514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UX4AozQfD/+Q4V/98VBsuhZOuZnT8f3wxe/fXFwxJI4=;
        b=iVNK6mYorVZzauYVlIHk8GzKlnDk5Jsk3YDog+Zw1dvhbyLMsBaSAntmIAAOazF6UM
         thF1SxQBtRGP83ZS09ZlPwkedfallZZNqA0bNp6hGGXbE/LvbuPrxqW96Vs5dRFMm6+T
         Y3UK+ToD3QWW2kk/5J7eoBdn17aY6+1dZVsthjIY3s0T36nIyNowBKqz9Zt0PjOluQ0J
         +Kdada0LjmasYMCO5I8vhMGnGRcY2Kji+OEgsF4DeaBuSkUFQUasCFlPbKOeIoo/caYr
         gEgaQ8+ijvVqKtCqPY8eh4t5xACpDR3wM8SghYYBkMV47Ydrh73/n6l8KfP7IyB9jT2Y
         TTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740418714; x=1741023514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UX4AozQfD/+Q4V/98VBsuhZOuZnT8f3wxe/fXFwxJI4=;
        b=upeX4eWudrjU8HjXUmoZO45kaax2q5Na16N4SV7nBW/E3W5+mvaRqiQCy+9uGmqgdV
         zC5xU5uVpLiCnLEMQ140QTC4pFGisRJfudK96jq7NaKqHeaMiP660CL5chRMX6/PnIat
         recSKu6P1wKGJDa4jJLGthXZR1/ZcxfOHHfca2TSwDhWKMIA30jPHP5C5vuhRlscHWTK
         4b2GwFPToSkif3mjiin4bIXcoJONAm2dPhAqokoLp0I9Qlz0am30mhQoO2Axx7ftNy/4
         FvZ66jzh91c6sU9xITFS6i03LksxYPLVF3ErJ7uZwAuWQRMK5fqNr+iVhBeQ623Dulfl
         p3vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMTuUY9+jLFL3LU24FE6atnt+qosKRHYMOnzsAEBJ4HyClSQ/KinQwFzlBg72SPJnIxjs=@vger.kernel.org, AJvYcCXlYyCK2KI6vk14djAGGDu4f1PydaL28sBN4DhV23j8W5fl+TNCT6Nk4BMbmQbELnPTciQo3Lc+qptCOpJr@vger.kernel.org, AJvYcCXq2sAu+6XRbje0rni/rTyBL4o5CMB/V1BAESs0c8RH1zjByke68sJeJkxfk8uSTikpc3ndlWiMFo0EXZY8cobU@vger.kernel.org, AJvYcCXsCltWgBoPWLe7/kNccPBXTdWcJePv836BGXDfExukRymhQ3PJOMqgpdLjbFnivht9pXz8jznr4LAP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7heTDBaTQNtCYFbDwi5XMswPGje96tOaOu65XUn12n/i1XY1E
	68Nnt1pmZ7RLWOZZLwnY3eeCl0LxM8T1yzw0s6PCJc3UC21yyI4=
X-Gm-Gg: ASbGncv/12qfVcR7eNsixkmnXlAzDDmZXeEaaneGwqEo4md+OVJ2zN9ZNqZUjifPqSq
	FWtTsawAUOUPjSlIvp/gMNdyKd8N8dfb6k/MnQlQbU3m2U0v4QXzpEsgoB3AtUf+V55fHKBtw5/
	7L0sOZk2hxZNUaLO4QAtq9IS9VIVVg2pttkDZJnA1OZs+j9jCGIc2gDx4UiaBpp2RUJsxQ8B2za
	1fcKl+ccjFbzYcOXNzt4A5LGKTW/D5HBkUSNmyDgkFHh5TdoNdAbj0O/W55f5KgF1eg1QIpuaEf
	W9S3pgLWQM4rg07LrzgjsOEa8w==
X-Google-Smtp-Source: AGHT+IEOY3jvw3d20B761rhLccrQlmDTz3/D4N2sGGq3MNqiiZ11e3nLJ+fNVmPINvJS8+U0KTPG+Q==
X-Received: by 2002:a17:902:f550:b0:220:e63c:5b13 with SMTP id d9443c01a7336-2219fff4ef2mr211596935ad.46.1740418713456;
        Mon, 24 Feb 2025 09:38:33 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d534afadsm185575355ad.26.2025.02.24.09.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 09:38:32 -0800 (PST)
Date: Mon, 24 Feb 2025 09:38:32 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jeroen de Borst <jeroendb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [PATCH net-next v5 3/9] net: devmem: Implement TX path
Message-ID: <Z7yumPB749GdF26X@mini-arch>
References: <20250222191517.743530-1-almasrymina@google.com>
 <20250222191517.743530-4-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250222191517.743530-4-almasrymina@google.com>

On 02/22, Mina Almasry wrote:
> Augment dmabuf binding to be able to handle TX. Additional to all the RX
> binding, we also create tx_vec needed for the TX path.
> 
> Provide API for sendmsg to be able to send dmabufs bound to this device:
> 
> - Provide a new dmabuf_tx_cmsg which includes the dmabuf to send from.
> - MSG_ZEROCOPY with SCM_DEVMEM_DMABUF cmsg indicates send from dma-buf.
> 
> Devmem is uncopyable, so piggyback off the existing MSG_ZEROCOPY
> implementation, while disabling instances where MSG_ZEROCOPY falls back
> to copying.
> 
> We additionally pipe the binding down to the new
> zerocopy_fill_skb_from_devmem which fills a TX skb with net_iov netmems
> instead of the traditional page netmems.
> 
> We also special case skb_frag_dma_map to return the dma-address of these
> dmabuf net_iovs instead of attempting to map pages.
> 
> Based on work by Stanislav Fomichev <sdf@fomichev.me>. A lot of the meat
> of the implementation came from devmem TCP RFC v1[1], which included the
> TX path, but Stan did all the rebasing on top of netmem/net_iov.
> 
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

(assuming Eric/Willem will also take a look at this)

