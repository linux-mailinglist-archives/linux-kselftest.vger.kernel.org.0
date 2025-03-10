Return-Path: <linux-kselftest+bounces-28583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3305DA58C74
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 08:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D1A3A8A82
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 07:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4604B1D63DA;
	Mon, 10 Mar 2025 07:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="QZRBYT7/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB921D47A6
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 07:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741590292; cv=none; b=IM87L1ep+cdwNJQgURfCR+Q668MC1SRSVrXWGArCAtlkrBFHFUSXm2o9dywbT1/0OvdMmFuw3kM/r6CO3f5RBxCZQdbuOmWXJGsPSKTHh2K/i9rdRloLRTsrwGj0sQhiOjNA9oIPsOZlrO7J4VkxLK+cLgO7vVewMFwYZw7LiRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741590292; c=relaxed/simple;
	bh=eSw/Sz1ql/4UPcLEbJRVUH0uYPxF2xmC0A18fnAZuI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MSqpOhT2N8/d+A9+Vec/CzF6+nB/RawEwO9dGWk6YOUebFFkNrCsxKS0XIcPuodljRpZKjQnj7lZ+4K9ya3uMrHeeNla1DbZ8zzZllayd0xlemyagvBYO3w6Wpg6hu2/JfiBHOXrhJj8V1RzjnUeRp9QKyygv+cNxNEPT7QjXIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=QZRBYT7/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223594b3c6dso66819385ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 00:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741590288; x=1742195088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z4zUjmNxjokxBeO8EjZH90AMO+cgLdiVs95Lgo++StE=;
        b=QZRBYT7/pUx1N5WjjIh58q+/IinjLV3aq0UR9zGCTNxVna0gfBnE9gUO8W4GuVM9KA
         aXu0TGNLBTvShFK8ky5kFa+mBCVnbzcSPm6vG9pdeZNO3EyOZ4DBu0fksbpXqnIhuwNL
         xEsrLyqVKi+jnkBwXgx5FsdLc7LEKJkinZtQGEHh9kZd3bkFzQI+gKlwnuQEg5BQkvkX
         HxCDTgg0yUZJOLlF8ic1Bi2VoU4YMXRfO9wYbI5HdOdHcSk6mPFQ+UqIAtysplhtjrP8
         XVw77g1RD0BBt3zcQosaTS1XIvITQ01qguj0TkwT+IoPolx2Hr1pDl6gbOH9qtQMrkr2
         DbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741590288; x=1742195088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4zUjmNxjokxBeO8EjZH90AMO+cgLdiVs95Lgo++StE=;
        b=kI3nzha6wC8SiXfgj2F1GM/P7nek64LzqOBr6EjOO+qCZcFXt86EbF24wKLeDKngbv
         uYB+uGV/c6OG/NULzoeQq4/yg1FVGWhh+V4UgTrLI6+Ao2uKZZLmoYRZLFtSWu7MaFwK
         CNA3OzlzC58/qNAiou5YTEn4FkC1Blvbfhc66p+X+iJGKF1i8/bFO/X31YvMQAbFm1ll
         kVQ3bCxRi6I+6VRXmJbbg7671ym27/wY+gWdT+i9ycgXQnuO7uib29tGrgvkOi8GZyog
         hzFkl38PTd1VciZZlAhN+NnYkMUQvA/uGYzcyPdNWXBCwZmbtkkxU2pwsoDDKP8I1F1E
         m+dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUI2/D0IspipF87vjGCmIRyJhcbbj/IRSLiMFVVtxQjMWLWgUtdVZbjptNAPLa7Lk1HvxVqX0ikq/a1H8ZepA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPEW5HzvE9FhXyMv2bqnfNInZGrhM0mwOkmdp/zqGgh10AtNC7
	R0m84I9HAsCgtJ80e8ivEcIamDfjTVUjtZRPMCVPt+6S3rfgw+hqMjjHDlRHOms=
X-Gm-Gg: ASbGncuCNh9FDMcwqcyPiuRIscdRwGa8O8nclvrUo9W6Wn6UgUC15irbvIt9L8k3BnB
	iqEO+PBQ3mI9cdiAXk0KAv5Kbv1LYuSRyFd7n0uVF2vigYxB+ZtQ4Ct33PB7w/iOAqh6qd4phcv
	uSZPguv+QgMIMO/xCb8RBrU9r1bDJ4LW3ZyDFsF1PO2mXZqV3azNTcvkyqQpon1jE2cQpepAJge
	1ljFR5aFyttMriMfHcAx0LCP+6P2LizRI95YkZzArhYFaQcQBTrxFzc3OQdh+6Dvark1y781SNs
	Od58xXoB7MqTuKPAWYitg72RtAodXpEmo78ySWoD27lL2ddnEIB7HvPBfg==
X-Google-Smtp-Source: AGHT+IFkDjhIOqYcqagzT94jgytjjwhSIQTT2o6zqPzPIQtmCm+lioqyAyJhjHPUINzm2ba//BDswA==
X-Received: by 2002:a17:902:ea07:b0:224:a79:5fe4 with SMTP id d9443c01a7336-2242888681cmr196310675ad.2.1741590288383;
        Mon, 10 Mar 2025 00:04:48 -0700 (PDT)
Received: from [157.82.205.237] ([157.82.205.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f93esm70081685ad.142.2025.03.10.00.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 00:04:48 -0700 (PDT)
Message-ID: <2e550452-a716-4c3f-9d5a-3882d2c9912a@daynix.com>
Date: Mon, 10 Mar 2025 16:04:43 +0900
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEuccQ6ah-aZ3tcW1VRuetEoPA_NaLxLT+9fb0uAab8Agg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/03/10 13:43, Jason Wang wrote:
> On Fri, Mar 7, 2025 at 7:02 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> VIRTIO_NET_F_HASH_REPORT allows to report hash values calculated on the
>> host. When VHOST_NET_F_VIRTIO_NET_HDR is employed, it will report no
>> hash values (i.e., the hash_report member is always set to
>> VIRTIO_NET_HASH_REPORT_NONE). Otherwise, the values reported by the
>> underlying socket will be reported.
>>
>> VIRTIO_NET_F_HASH_REPORT requires VIRTIO_F_VERSION_1.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Tested-by: Lei Yang <leiyang@redhat.com>
>> ---
>>   drivers/vhost/net.c | 49 +++++++++++++++++++++++++++++--------------------
>>   1 file changed, 29 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>> index b9b9e9d40951856d881d77ac74331d914473cd56..16b241b44f89820a42c302f3586ea6bb5e0d4289 100644
>> --- a/drivers/vhost/net.c
>> +++ b/drivers/vhost/net.c
>> @@ -73,6 +73,7 @@ enum {
>>          VHOST_NET_FEATURES = VHOST_FEATURES |
>>                           (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
>>                           (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
>> +                        (1ULL << VIRTIO_NET_F_HASH_REPORT) |
>>                           (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
>>                           (1ULL << VIRTIO_F_RING_RESET)
>>   };
>> @@ -1097,9 +1098,11 @@ static void handle_rx(struct vhost_net *net)
>>                  .msg_controllen = 0,
>>                  .msg_flags = MSG_DONTWAIT,
>>          };
>> -       struct virtio_net_hdr hdr = {
>> -               .flags = 0,
>> -               .gso_type = VIRTIO_NET_HDR_GSO_NONE
>> +       struct virtio_net_hdr_v1_hash hdr = {
>> +               .hdr = {
>> +                       .flags = 0,
>> +                       .gso_type = VIRTIO_NET_HDR_GSO_NONE
>> +               }
>>          };
>>          size_t total_len = 0;
>>          int err, mergeable;
>> @@ -1110,7 +1113,6 @@ static void handle_rx(struct vhost_net *net)
>>          bool set_num_buffers;
>>          struct socket *sock;
>>          struct iov_iter fixup;
>> -       __virtio16 num_buffers;
>>          int recv_pkts = 0;
>>
>>          mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
>> @@ -1191,30 +1193,30 @@ static void handle_rx(struct vhost_net *net)
>>                          vhost_discard_vq_desc(vq, headcount);
>>                          continue;
>>                  }
>> +               hdr.hdr.num_buffers = cpu_to_vhost16(vq, headcount);
>>                  /* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
>>                  if (unlikely(vhost_hlen)) {
>> -                       if (copy_to_iter(&hdr, sizeof(hdr),
>> -                                        &fixup) != sizeof(hdr)) {
>> +                       if (copy_to_iter(&hdr, vhost_hlen,
>> +                                        &fixup) != vhost_hlen) {
>>                                  vq_err(vq, "Unable to write vnet_hdr "
>>                                         "at addr %p\n", vq->iov->iov_base);
>>                                  goto out;
> 
> Is this an "issue" specific to RSS/HASH? If it's not, we need a separate patch.
> 
> Honestly, I'm not sure if it's too late to fix this.

There is nothing wrong with the current implementation. The current 
implementation fills the header with zero except num_buffers, which it 
fills some real value. This functionality is working fine with 
VIRTIO_NET_F_MRG_RXBUF and VIRTIO_F_VERSION_1, which change the header size.

Now I'm adding VIRTIO_NET_F_HASH_REPORT and it adds the hash_report 
field, which also needs to be initialized with zero, so I'm making sure 
vhost_net will also initialize it.

Regards,
Akihiko Odaki

> 
> Others look fine.
> 
> Thanks
> 


