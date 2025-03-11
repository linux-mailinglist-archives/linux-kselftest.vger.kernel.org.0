Return-Path: <linux-kselftest+bounces-28697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF089A5B92D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 07:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2088A7A3F2D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 06:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0381EEA23;
	Tue, 11 Mar 2025 06:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="FPoHkQ99"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1523D1EB19F
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 06:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741674254; cv=none; b=sCTSyBlKfAV1hJlEE2qH+/OaS5sJ0/8mhgAuqZWFe7+Kc6E8s9wXIg1XUWSDvcOM3lCw2GWMPdXbTmChJk0So/Uq6neQO0J+TUdRR66Aq3GSJ1OP544KPwc89a0q+vsa4YRJ/h/i+Zd6nFiyWUBqR2WiqyDWQ2/bO0WKaH1zgDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741674254; c=relaxed/simple;
	bh=DsqDEHlBUwS8fyV8/WMCNPW7k1Q8GQhlh9GKPXRNGBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K34RKOQiBOwNNJDksxadrQaDBXsy+erYQyMsrlePsi0cWr/SQd5U9ASLWa37lzjfUjvOH5ldyR6Ig/Be4FfNgVfL3KpYg7o/1h/N7UlmRz0bbuGLOWX02bGYpHFhmHNNAwxefvthrC065tCAXRdvieZVFWeRTmV6XXnCjrd1jb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=FPoHkQ99; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22349bb8605so92787255ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 23:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741674252; x=1742279052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hcOWo3MpfkZwJWARJhxBJx9ftvSTMuCRJKTKMNfQ2T0=;
        b=FPoHkQ9991pPxzcc1wNC8ql57JSLUfNSGlxHUt/djJvzy6tttksaE1tmYgZn/MSq6x
         lheb9UNZRvv0CS3g7cAZbIkWUi0QW94/r3W7YPyowTp8j1CVIsojnZzWdIfE5IHMgxox
         xpMbh0USTe0mijm9J/kWE+nUQDGnb3RAGZvbVQ3206vnggOSGs/Qmhauaf3cIILDwelF
         EnQfIxlrnuULyyF9yAympiFuc98OYBkyvNvLiHskPcr8sTxahCxq1eYLSb/8H9ie7Pg+
         SCLC4/3BzU04zYQZYRSDg4clysyhLsn6BYahOjjzCdzEjTXvADo3uLgEBD8fikXhi4m1
         vvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741674252; x=1742279052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hcOWo3MpfkZwJWARJhxBJx9ftvSTMuCRJKTKMNfQ2T0=;
        b=R+IaJHjohPCvvwdyxhN4ZszH9fqxbVxI8kmNkv74uuVf+1d+1DNc5CWR9Ivexiyoh5
         pxCZUZ93n3X8RIVppUv3+1gpmt7/0dX5Tcoy6KwTxa9WmdhrIgB6R2cIz4SCfs0FJ9uk
         cDnJngJ0r+TOYD54A2vef+i2CC1Zz8IU4M8LhWVqa1fAQpedIou+O/pdROLDWJZFumnv
         kQjFMLt9YiACTSyb2d7B6ZKpcaS6SOuq3wJNi54P41Lg+QbmVPNSGR2KPIf2FkPuBKy7
         VFYROGJd1wCU9ayFW36og+jnQJlN2X8YA0Gc/cuOA6We7jvQ+r8vQRV80xCj2+ozDM0H
         /oPw==
X-Forwarded-Encrypted: i=1; AJvYcCVFRL9FwwOkKpKZxaR8E8PhvBVZELjxxOKfnlw4mVQ+XA0uTTWre1pz4Reo/RcCbdrWZgh5bPyWDuwrZHcbXps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkYLIXsKvBMcKQUzDlAVV3LNPs22otJnTDb0k8+lbmxRo9sxdb
	qvu9Y+jmt16mN4OvWWBXRedqxpxu7LnqsXWosb14u8aZSIf2d5ZI997+cJqF+4k=
X-Gm-Gg: ASbGncvFOqt+Sl3Q3qIbnCk11pW0ZgM4aYbv0tJ5+l1X5Um9tQGj9X6MMDTxlfRUMPG
	FBQ1F98AQf0iRoWdxtCJoTg570TLSCArPx/F17lW9U7T8d8OySszFJtv2RS7ufA0Tz/SJpWzEj1
	EJYKpxCA7O3fubKmGFS7B1vWGVKLXGJ9m9hAVtUbJoA278/K9Zsimsc0psmYfxN146zqFUUeHhY
	rOAN+YyoGP3E2OqrtTtUm/qK/uNH/EHyGsUmZLQg4OlLgFxsZRvTGe11nijjoklh6LI+lF3KKU6
	ncTZG2jfQKjrHLBudLRWEJGQTJowcz41Fytl/KTqe0UbbiVIooMNcu/SLw==
X-Google-Smtp-Source: AGHT+IGn18ZSOeDi0OtiFl4e+mdyHaJbBZUtxUxoxSL45HZJeEfhcKnA+r8VKFVTyGuyQbzX9uCMeA==
X-Received: by 2002:a05:6a00:1a92:b0:730:d5ca:aee with SMTP id d2e1a72fcca58-736aaae81e6mr21317990b3a.23.1741674252333;
        Mon, 10 Mar 2025 23:24:12 -0700 (PDT)
Received: from [157.82.205.237] ([157.82.205.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736a336010dsm9010979b3a.59.2025.03.10.23.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 23:24:12 -0700 (PDT)
Message-ID: <1dd2417a-3246-44b0-b4ba-feadfd6f794e@daynix.com>
Date: Tue, 11 Mar 2025 15:24:06 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 6/6] vhost/net: Support
 VIRTIO_NET_F_HASH_REPORT
To: Jason Wang <jasowang@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
References: <20250307-rss-v9-0-df76624025eb@daynix.com>
 <20250307-rss-v9-6-df76624025eb@daynix.com>
 <CACGkMEuccQ6ah-aZ3tcW1VRuetEoPA_NaLxLT+9fb0uAab8Agg@mail.gmail.com>
 <2e550452-a716-4c3f-9d5a-3882d2c9912a@daynix.com>
 <CACGkMEu9tynRgTh__3p_vSqOekSirbVgS90rd5dUiJru9oV1eg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEu9tynRgTh__3p_vSqOekSirbVgS90rd5dUiJru9oV1eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/03/11 9:42, Jason Wang wrote:
> On Mon, Mar 10, 2025 at 3:04 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/03/10 13:43, Jason Wang wrote:
>>> On Fri, Mar 7, 2025 at 7:02 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> VIRTIO_NET_F_HASH_REPORT allows to report hash values calculated on the
>>>> host. When VHOST_NET_F_VIRTIO_NET_HDR is employed, it will report no
>>>> hash values (i.e., the hash_report member is always set to
>>>> VIRTIO_NET_HASH_REPORT_NONE). Otherwise, the values reported by the
>>>> underlying socket will be reported.
>>>>
>>>> VIRTIO_NET_F_HASH_REPORT requires VIRTIO_F_VERSION_1.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> Tested-by: Lei Yang <leiyang@redhat.com>
>>>> ---
>>>>    drivers/vhost/net.c | 49 +++++++++++++++++++++++++++++--------------------
>>>>    1 file changed, 29 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>>>> index b9b9e9d40951856d881d77ac74331d914473cd56..16b241b44f89820a42c302f3586ea6bb5e0d4289 100644
>>>> --- a/drivers/vhost/net.c
>>>> +++ b/drivers/vhost/net.c
>>>> @@ -73,6 +73,7 @@ enum {
>>>>           VHOST_NET_FEATURES = VHOST_FEATURES |
>>>>                            (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
>>>>                            (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
>>>> +                        (1ULL << VIRTIO_NET_F_HASH_REPORT) |
>>>>                            (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
>>>>                            (1ULL << VIRTIO_F_RING_RESET)
>>>>    };
>>>> @@ -1097,9 +1098,11 @@ static void handle_rx(struct vhost_net *net)
>>>>                   .msg_controllen = 0,
>>>>                   .msg_flags = MSG_DONTWAIT,
>>>>           };
>>>> -       struct virtio_net_hdr hdr = {
>>>> -               .flags = 0,
>>>> -               .gso_type = VIRTIO_NET_HDR_GSO_NONE
>>>> +       struct virtio_net_hdr_v1_hash hdr = {
>>>> +               .hdr = {
>>>> +                       .flags = 0,
>>>> +                       .gso_type = VIRTIO_NET_HDR_GSO_NONE
>>>> +               }
>>>>           };
>>>>           size_t total_len = 0;
>>>>           int err, mergeable;
>>>> @@ -1110,7 +1113,6 @@ static void handle_rx(struct vhost_net *net)
>>>>           bool set_num_buffers;
>>>>           struct socket *sock;
>>>>           struct iov_iter fixup;
>>>> -       __virtio16 num_buffers;
>>>>           int recv_pkts = 0;
>>>>
>>>>           mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
>>>> @@ -1191,30 +1193,30 @@ static void handle_rx(struct vhost_net *net)
>>>>                           vhost_discard_vq_desc(vq, headcount);
>>>>                           continue;
>>>>                   }
>>>> +               hdr.hdr.num_buffers = cpu_to_vhost16(vq, headcount);
>>>>                   /* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
>>>>                   if (unlikely(vhost_hlen)) {
>>>> -                       if (copy_to_iter(&hdr, sizeof(hdr),
>>>> -                                        &fixup) != sizeof(hdr)) {
>>>> +                       if (copy_to_iter(&hdr, vhost_hlen,
>>>> +                                        &fixup) != vhost_hlen) {
>>>>                                   vq_err(vq, "Unable to write vnet_hdr "
>>>>                                          "at addr %p\n", vq->iov->iov_base);
>>>>                                   goto out;
>>>
>>> Is this an "issue" specific to RSS/HASH? If it's not, we need a separate patch.
>>>
>>> Honestly, I'm not sure if it's too late to fix this.
>>
>> There is nothing wrong with the current implementation.
> 
> Note that I meant the vhost_hlen part, and the current code is tricky.
> 
> The comment said:
> 
> """
> /* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
> """
> 
> So it tries to only offer virtio_net_hdr even if vhost_hlen is the set
> to mrg_rxbuf len.
> 
> And this patch changes this behaviour.

mrg_rxbuf only adds the num_buffers field, which is always set for 
mrg_rxbuf.

The num_buffers was not set for VIRTIO_F_VERSION_1 in the past, but this 
was also fixed with commit a3b9c053d82a ("vhost/net: Set num_buffers for 
virtio 1.0")

So there is no behavioral change for existing features with this patch.

Regards,
Akihiko Odaki

> 
> Thanks
> 
>> The current
>> implementation fills the header with zero except num_buffers, which it
>> fills some real value. This functionality is working fine with
>> VIRTIO_NET_F_MRG_RXBUF and VIRTIO_F_VERSION_1, which change the header size.
>>
>> Now I'm adding VIRTIO_NET_F_HASH_REPORT and it adds the hash_report
>> field, which also needs to be initialized with zero, so I'm making sure
>> vhost_net will also initialize it.
>>
>> Regards,
>> Akihiko Odaki
>>
>>>
>>> Others look fine.
>>>
>>> Thanks
>>>
>>
> 


