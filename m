Return-Path: <linux-kselftest+bounces-6139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DE38771DD
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Mar 2024 16:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534AF1F21706
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Mar 2024 15:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FC944C60;
	Sat,  9 Mar 2024 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNYvBbKv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAE0446D2;
	Sat,  9 Mar 2024 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709997222; cv=none; b=Z+XHAkZAeEBYXPSdwaagXb+Ipghx4+s0H0DxSP4IPImYsUQbUZ/U8Q+r27ddDdoe3HVp2OJk5XdUKY5TnuLAQzFpNP09AoMNr2W/ahWSyNKIgocpaurGXkkj5ROTCaJ1U6RKvU33DatHNHfN8orhbWWgPqrxZtURNGaoqQIpGFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709997222; c=relaxed/simple;
	bh=mj0NPIc9fBRiahH650Pss85rj/DambmNJceX2Qi26js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rUu0QYN0zewHQ5T0eW1oGA+RuWjFQC+5XWPBGx4Uu58sxZgL242IYM+UsAmldikksjTeivrwqoAhOq5YxuLW+l9fVAHnM7KCFhyuRdv8Ix96gxVtIc9bauextWQj8hDclEWobyYn6IXYGcSRvYbaunnKKXb3zIa6fItGdehiOsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNYvBbKv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412f67bc6d0so12798525e9.3;
        Sat, 09 Mar 2024 07:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709997219; x=1710602019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nqaCXrKkbqaRO5VSVsw+kFR9jdWnCYq3NGM9vlwLk4s=;
        b=WNYvBbKvoareTdoVMyfAPVm74QteJN1oFDGlUOqitl8+PV3XyCQlmST7JJA9ezOehC
         fA+OH6fS2a7hZjg2kluTptLrLWBlYj2wBTXwEMsyhvBvoke/c5Eaq4pLAqwUHltTZsDp
         QWHR+dOhmCKYV8c8Hr1QNrLU+c/8l03RufAfhxzj5kw4UcWUNjQnYX3oODq7kKd0IPSH
         35f0XKAVuhbwVYquSKQlqebulsT06uY5xnS8Xe1mBtcdJs8VCMju/iuZ9h3peFnM7/Gk
         bcoaM/bKeW8c2PXkG/IMi4zxE4Ru4RBIPsCEXfrCqbZTSavosQZdfa6u4OB2QgNzFmWV
         707Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709997219; x=1710602019;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nqaCXrKkbqaRO5VSVsw+kFR9jdWnCYq3NGM9vlwLk4s=;
        b=M+gbOEF92H1WGl3OzNCqaZM2j7hAvn9yC+NcNc/gQykMAt0csHqRTpqZWzAsl3/wHk
         0aNlS0Pa689KQYYoz3qlfEiuCB2rJfsnMOj/meZYz4UeoSte4nf1icS+A6iG2MoUksRr
         ZWErXQa2zRSo6APhuxPEY3VfzJhfQIolKhtvf8LwFtGu287ENyZouzJQ0BzhuNid64q9
         l8eN6H+XsGCBFvewtNVa5cOSfNWFuQq9D+Rk1pvCvg89P6yuSZMp6+3FQF8F/8ZJ0pm8
         xiuvMXjjAs23LK08Xu5jrnZNEv1BGWBw9SbGP8TxvByESZ5WvhT/s1UFA6Wmmq5Uvytj
         8rpA==
X-Forwarded-Encrypted: i=1; AJvYcCUzyr8zslfo7K+6yVC1f3NFBROptt0VVDvFAD1KY3ViVh8B1e/t6jNgIhZlVKKnDu50jLZlCEkEz9d7XQjDGYBIMYhgwsBgM7W3catBS+u4bV5EUuMpKLLD1/AgYt9RseWD0L+jD11wS2DVEox/aLRxuNCtU2dekD96c8apEoFwR18bhu9R
X-Gm-Message-State: AOJu0Yzq0I7kQWa2VY/h3tUXRSq9XlS16269jc4SXPoQ1eZBx1nzTXYF
	jaqEmUpDUS01zqCtvxjRrr86wO3bC9VwDRgGrR5OuYoX4l6uxV+5
X-Google-Smtp-Source: AGHT+IF7vWQHcsedtOCKa4oZJH1KTNQScrKA+4MQ/KRuLfIKq62I7/shNlaYgFLyNWJMqlzXerN9TA==
X-Received: by 2002:a05:600c:1e19:b0:413:239a:2685 with SMTP id ay25-20020a05600c1e1900b00413239a2685mr615253wmb.38.1709997218700;
        Sat, 09 Mar 2024 07:13:38 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c470900b0041312e8ef2bsm2813627wmo.26.2024.03.09.07.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 07:13:38 -0800 (PST)
Message-ID: <1d4726dd-cc62-4966-90c1-68ea3f0905c4@gmail.com>
Date: Sat, 9 Mar 2024 16:13:24 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 3/4] net: gro: set inner_network_header in
 receive phase
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemdebruijn.kernel@gmail.com, dsahern@kernel.org, shuah@kernel.org,
 idosch@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <2ce1600b-e733-448b-91ac-9d0ae2b866a4@gmail.com>
 <2076d2ff-cd17-4ab0-b1db-4875d96bf9a6@gmail.com>
 <CANn89iKq755tvJ1BZFXG5aX2YNd9AycbKu57taxi8gaSWn5Syw@mail.gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <CANn89iKq755tvJ1BZFXG5aX2YNd9AycbKu57taxi8gaSWn5Syw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Eric Dumazet wrote:
> On Thu, Mar 7, 2024 at 2:28 PM Richard Gobert <richardbgobert@gmail.com> wrote:
>>
>> This patch sets network_header and inner_network_header to their respective
>> values during the receive phase of GRO. This allows us to use
>> inner_network_header later on in GRO. network_header is already set in
>> dev_gro_receive and under encapsulation inner_network_header is set.
>>
> 
>> +static inline int skb_gro_network_offset(const struct sk_buff *skb)
>> +{
>> +       const u32 mask = NAPI_GRO_CB(skb)->encap_mark - 1;
>> +
>> +       return (skb_network_offset(skb) & mask) | (skb_inner_network_offset(skb) & ~mask);
> 
> Presumably this is not needed.
> 
>> +}
>> +
>>  static inline void *skb_gro_network_header(const struct sk_buff *skb)
>>  {
>> +       const int offset = skb_gro_network_offset(skb);
>> +
>>         if (skb_gro_may_pull(skb, skb_gro_offset(skb)))
>> -               return skb_gro_header_fast(skb, skb_network_offset(skb));
>> +               return skb_gro_header_fast(skb, offset);
>>
>> -       return skb_network_header(skb);
>> +       return skb->data + offset;
>>  }
> 
> I would instead add a new offset parameter to this function.
> 
> Again, ideally GRO should work without touching any skb->{offset}.
> 
> GRO stack should maintain the offsets it needs in its own storage
> (stack parameter, or other storage if needed)
> 
> Upper stack can not trust any of these skb fields, otherwise we would
> have some troubles with napi_reuse_skb()

Inner and outer network headers are needed for commit #4, I will store them
in the CB.

Moreover I will work on another patch series, that changes GRO receive phase
to use stack params as you suggested. (prev offset, and I will also work on a
version with data_offset too).

