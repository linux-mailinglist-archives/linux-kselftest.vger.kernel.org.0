Return-Path: <linux-kselftest+bounces-32315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDB2AA8D1F
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 09:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB7F81893C0F
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 07:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279331DE4CA;
	Mon,  5 May 2025 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXS1gEJj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5921C1DDC00
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746430666; cv=none; b=d5c/AXKCDkSt2wrA+kFqDfgFax50J+OW9qJlqzH+nPFePNT5uLeoTIf/sJ10Vr2GFpos/n9aTzxmUfVpF2iehXAL/PwXkuq33c7BfNn8VbNK01Hw0p8Fa2a/1uJf+Ge6iAVFckboSIwb6jk09sISHgLGiUOBuF65RTE4xOpUJr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746430666; c=relaxed/simple;
	bh=wA86OvXvQW2Wk0ySWN1S8dAXgWbBM9cP3A1cI9Z6u5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m72coO+j73HYXg00lXh0yCszN8OC1pRV+2h5uVk6S40mPDsfpG8Ls9msOwzhb2KQBB+mw60D3uqGbRqzZDE8zaby3tarjz3FLN5obuwsdBbxXNBYB79MG39V1fnzRzQT6P0tqYlfe4bk4OOCFa+f3ic5/IP/AirYmL1txKYz9AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RXS1gEJj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746430663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EbQ8Ebd7T0AIaFrJMEa7u08GAGQmcdkDS4quExidCGE=;
	b=RXS1gEJjdqJJjGzcdwYJC26o/62iUqfvjeNzD0P09hsGQ8xP1mAu1tHihp28JtdxUA7Wlq
	AytQ41x0vbVX0KSMavJrspJ+P9wklVr7Ro4fRhKTl5Eees8KMC50r4Mklp5F1uo033RQTB
	lH41B+4gTsbSMmd3cpGwRZUp27I86xk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-wizYRzZDNfiABezCxDMlAw-1; Mon, 05 May 2025 03:37:42 -0400
X-MC-Unique: wizYRzZDNfiABezCxDMlAw-1
X-Mimecast-MFC-AGG-ID: wizYRzZDNfiABezCxDMlAw_1746430661
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-391315098b2so1151998f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 05 May 2025 00:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746430661; x=1747035461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EbQ8Ebd7T0AIaFrJMEa7u08GAGQmcdkDS4quExidCGE=;
        b=seHm4PMu3xkjjuFUfnNcn58VI6zLBB1DwJ8NzXM04E/E32reDC6/FtSTwr0R3ZNhrX
         CfPiXxwD7QY3EGrXY253x7E0C9A3M07LBvfMyJwlDIxeM21GC0HJCQI2qISKyenXsL/D
         RLw0j3EJ7bDH7HbDqHwAI5xoqyRjyAKGgHdi2CFhHJRBXL/763eXmNe5UecChr2FB9NV
         Ut71S7Q4AV13AEvKPWWZMtvVY1E20y3uQgBIwJhv66rNy/6p4xm+T01TvlVt34mEH3uW
         lo/DxOKXLs6qW9mTdm24hNTNpMqUTcSaYLuASVWbWmOYshBtOxnPEyulFu8/MfJa28Gj
         MiqA==
X-Forwarded-Encrypted: i=1; AJvYcCX8WJHfrf3T5/KNQul8mQ5ZQp7MPj9z/mmfCEkJagSLYHD8LV6MQil3RolNTM/gY1iJtj//b0CGGb3Q7TDGREI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKbDjPZYhSyqu4bxh89mrJygPMEwJ96Uod6z9zOmztmbhdJYHf
	7cHEryjfWF4TrHN+eUheM2guaaaR9bLaGB6Za7F91ET4vM4EBDFZCemZAewvXJfKs9+aMWeKPCj
	DBNyd38FKjj90HK3ZDlnez9f2zbr9LjfHRlMk2tsf87hF0lWn+MUmqhxA9aOrXA2tWA==
X-Gm-Gg: ASbGnct7X59hUiQllpZ1MGnKOnsuSQeD98KSwvtQECbo813Gm60jDua7E0o7bCJ1EGs
	SWVArHrjYYs0tKzNxRUyKLVUZDa/Dted0Q4FdAJ8+TFHMx1nf7o9IzOseEKxqJq1F58Ect9YIUX
	Tqi9yFQ9PP+pQwUHV6h0ZITYoSkDpjMLgKBWK4Q6chOjPSmTlQlW1oCWhvJj7F0TK8EnuI2IjBZ
	AP0lmJ9+Qi9k9EksSndXvDi6YKLKZCobWVqaRMM8lfI12RyXQye1tLwBUGiGPqx1vObFIlq06ca
	NNcPeCeM3VIKvOWRwEfg0IptIiNZMoHuojligPcwX10uk/cHogAGHMuvXOA=
X-Received: by 2002:a5d:6711:0:b0:3a0:a0f5:1b02 with SMTP id ffacd0b85a97d-3a0a0f51bcdmr2980353f8f.25.1746430661024;
        Mon, 05 May 2025 00:37:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXPgUBS6oLYKFEGfiQb4hNjm4EqETq0WQb6mbrzb4uGVHXyVmTL98k94ybGGle6pM8Sc5r1w==
X-Received: by 2002:a5d:6711:0:b0:3a0:a0f5:1b02 with SMTP id ffacd0b85a97d-3a0a0f51bcdmr2980306f8f.25.1746430660573;
        Mon, 05 May 2025 00:37:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2706:e010:b099:aac6:4e70:6198? ([2a0d:3344:2706:e010:b099:aac6:4e70:6198])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b172a8sm9666263f8f.91.2025.05.05.00.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 00:37:40 -0700 (PDT)
Message-ID: <1710b0e0-ec7a-4d79-89ad-ad9d0cf58f5c@redhat.com>
Date: Mon, 5 May 2025 09:37:37 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 4/9] net: devmem: Implement TX path
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, io-uring@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jeroen de Borst <jeroendb@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn
 <willemb@google.com>, Jens Axboe <axboe@kernel.dk>,
 Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>
References: <20250429032645.363766-1-almasrymina@google.com>
 <20250429032645.363766-5-almasrymina@google.com>
 <53433089-7beb-46cf-ae8a-6c58cd909e31@redhat.com>
 <fd7f21d9-3f45-4f68-85cb-dd160a0a95ca@redhat.com>
 <CAHS8izPr_yt+PtG5Q++Ub=D4J=H7nP0S_7rOP9G7W=i2Zeau3g@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAHS8izPr_yt+PtG5Q++Ub=D4J=H7nP0S_7rOP9G7W=i2Zeau3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/2/25 9:25 PM, Mina Almasry wrote:
> On Fri, May 2, 2025 at 4:51 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 5/2/25 1:47 PM, Paolo Abeni wrote:
>>> On 4/29/25 5:26 AM, Mina Almasry wrote:
>>>> Augment dmabuf binding to be able to handle TX. Additional to all the RX
>>>> binding, we also create tx_vec needed for the TX path.
>>>>
>>>> Provide API for sendmsg to be able to send dmabufs bound to this device:
>>>>
>>>> - Provide a new dmabuf_tx_cmsg which includes the dmabuf to send from.
>>>> - MSG_ZEROCOPY with SCM_DEVMEM_DMABUF cmsg indicates send from dma-buf.
>>>>
>>>> Devmem is uncopyable, so piggyback off the existing MSG_ZEROCOPY
>>>> implementation, while disabling instances where MSG_ZEROCOPY falls back
>>>> to copying.
>>>>
>>>> We additionally pipe the binding down to the new
>>>> zerocopy_fill_skb_from_devmem which fills a TX skb with net_iov netmems
>>>> instead of the traditional page netmems.
>>>>
>>>> We also special case skb_frag_dma_map to return the dma-address of these
>>>> dmabuf net_iovs instead of attempting to map pages.
>>>>
>>>> The TX path may release the dmabuf in a context where we cannot wait.
>>>> This happens when the user unbinds a TX dmabuf while there are still
>>>> references to its netmems in the TX path. In that case, the netmems will
>>>> be put_netmem'd from a context where we can't unmap the dmabuf, Resolve
>>>> this by making __net_devmem_dmabuf_binding_free schedule_work'd.
>>>>
>>>> Based on work by Stanislav Fomichev <sdf@fomichev.me>. A lot of the meat
>>>> of the implementation came from devmem TCP RFC v1[1], which included the
>>>> TX path, but Stan did all the rebasing on top of netmem/net_iov.
>>>>
>>>> Cc: Stanislav Fomichev <sdf@fomichev.me>
>>>> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
>>>> Signed-off-by: Mina Almasry <almasrymina@google.com>
>>>> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
>>>
>>> I'm sorry for the late feedback. A bunch of things I did not notice
>>> before...
>>
>> The rest LGTM,
> 
> Does this imply I should attach your Reviewed-by or Acked-by on follow
> up submissions if any? I'm happy either way, just checking.

Should any other revision be required, please add my acked-by tag to all
the patch except 4/9.

Thanks,

Paolo


