Return-Path: <linux-kselftest+bounces-7669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C648A0619
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 04:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F45284734
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 02:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B36B13B28B;
	Thu, 11 Apr 2024 02:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNvZNRq/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8737A53E22;
	Thu, 11 Apr 2024 02:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712803529; cv=none; b=uJxxt1sHgZxFgfMmbQ/xZDukK6/N0RI9nihB/qJpXLb/Suf0n1HIC3S5qRk7zeQqrLHKOvq5pS6fC5nU+hj8aYnzUQGuJJWwx7ND0iUPquOm/aAWc2jKQa3ncUhI6UPSLi0sNpfmD7rm9yP6twQNhy2mb+XFGZ18OazOOXSdOQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712803529; c=relaxed/simple;
	bh=+Q3fMGVJ5Auo+ZqlhaXslfkWUbmvVi4JYwAQ0KMidmo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=OHtV7bd5MuZfeHF5KcWmfz+cmk6td6pY89gKJI20zc9FNS7H1vNXo4v6t1Z/T0DJHs9qYFhdEe+PPskeLlfYR7o8q6nmQhxgQfJYWoGa1qqRiOAL6LxRtwmjTTFQiSWqkp6kdRfIiay8q/YuWqKX2PYsjd/B48h5WJpeHwLWmaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNvZNRq/; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-69935d567a0so46059666d6.1;
        Wed, 10 Apr 2024 19:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712803526; x=1713408326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hborihv/NRdk8er5DQxCvr7JB3ly0Bpf/Tn+hw3gev0=;
        b=KNvZNRq/twmH1t/sgpK54LFeVW358uOqSXn5mhTMk5MqTJqVaS7lFcRV8q1EthBoq9
         PlEBkEH7x7p47WGew7aYXu/KM0bK8C+0OI1uoru7sYyq5k4puXldOHD9SVoRVYUs/0WS
         bLKpGz/hjQO/HxEYqA5K4ov5NT0Ck4we1MQZ3Az8WvurSIC1WjxgsG7oqqH4MKYMJAXL
         EHrP3pTam8HmPYZb2SkgAOl1LIsO2IRv4rLGRrftz84B/zROEkXQVRwfv2WZIxh8p2BA
         bRptdY4ir/7f+cUFmQ9UOZVuBayeojZvflrGunfoDx0CituG4awxYKDQtefl5dPl7S39
         GKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712803526; x=1713408326;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hborihv/NRdk8er5DQxCvr7JB3ly0Bpf/Tn+hw3gev0=;
        b=Xj6hg6i2AyUZbUuBBrSSHAeOeI2RQV4cdfd0Lz9tHASWiIozRN+32kmfHCr1mMERWm
         HhMW8JHs1zR0nkmTX49zCxGiNy4Cx4hNPLrH3PIhdqNNtl3postS4STfnXYhNY448QAZ
         s7DAGcLB/0oBLvuIkd+SPCZUrj5IOAJeDst40c8U8eTpKaaN3+UqbOw7xNVVQV5Ubbre
         oDLkfWkQMcKLJHjuuVJK98mzOV6TeMwefIxrR+8NDIx17hWzyXVuMdXoaI0oWyZFftKX
         La1Ve3vk4I2/YIFyxj4onzXTMSemLsS/XejLH+Rxu9W6omDHS/qMLu6FqMWguKas3SzJ
         0MgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhPEGrTFPbY/QUEXnWZrSi+aAn3+9+0IPEDiHQbiszyySQRgAuVRPsebudrzcFVrDkPCsEX4c12uhQujFYkWwgz4kO/yIly9JpTXym7KxZCCenLYjp3nPDyLZtntPf9ZYdVQc3L5A1hwXJnALJXB5HKlJfBgvo10OH8M15sMvKTrDaNnIx
X-Gm-Message-State: AOJu0YxZ6CNvcxLkLMsxlx/Fwrr3rUQhbBHak0joMN04OQzDeY21U9GD
	j0lscy5p9sVApDqurG32SMPAgusU4OmrsrlAx8YJZACIjtsDiahq
X-Google-Smtp-Source: AGHT+IE30z2nqARkaXY4lVAbYzq2d/7NDBqV02dSfZLtc6fJquwTFCVqZsdox3AyDGWvU54VwqNA3Q==
X-Received: by 2002:a05:6214:e67:b0:698:6ce5:aaf5 with SMTP id jz7-20020a0562140e6700b006986ce5aaf5mr4920376qvb.40.1712803526292;
        Wed, 10 Apr 2024 19:45:26 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id dw8-20020a0562140a0800b00699279e042fsm347912qvb.70.2024.04.10.19.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 19:45:26 -0700 (PDT)
Date: Wed, 10 Apr 2024 22:45:25 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 shuah@kernel.org, 
 dsahern@kernel.org, 
 aduyck@mirantis.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Message-ID: <66174ec5bbd29_2d6bc629481@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240410153423.107381-6-richardbgobert@gmail.com>
References: <20240410153423.107381-1-richardbgobert@gmail.com>
 <20240410153423.107381-6-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v6 5/6] net: gro: move L3 flush checks to
 tcp_gro_receive and udp_gro_receive_segment
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
> iph->id, ...) against all packets in a loop. These flush checks are used
> currently only in tcp flows in GRO.
> 
> These checks need to be done only once in tcp_gro_receive and only against
> the found p skb, since they only affect flush and not same_flow.

I don't quite understand where the performance improvements arise.
As inet_gro_receive will skip any p that does not match:

      if (!NAPI_GRO_CB(p)->same_flow)
              continue;

      iph2 = (struct iphdr *)(p->data + off);
      /* The above works because, with the exception of the top
       * (inner most) layer, we only aggregate pkts with the same
       * hdr length so all the hdrs we'll need to verify will start
       * at the same offset.
       */
      if ((iph->protocol ^ iph2->protocol) |
          ((__force u32)iph->saddr ^ (__force u32)iph2->saddr) |
          ((__force u32)iph->daddr ^ (__force u32)iph2->daddr)) {
              NAPI_GRO_CB(p)->same_flow = 0;
              continue;
      }

So these checks are already only performed against a p that matches.
 
> Leveraging the previous commit in the series, in which correct network
> header offsets are saved for both outer and inner network headers -
> allowing these checks to be done only once, in tcp_gro_receive. As a

Comments should be updated to reflect both TCP and L4 UDP. Can
generalize to transport callbacks.

> result, NAPI_GRO_CB(p)->flush is not used at all. In addition, flush_id
> checks are more declarative and contained in inet_gro_flush, thus removing
> the need for flush_id in napi_gro_cb.
> 
> This results in less parsing code for UDP flows and non-loop flush tests
> for TCP flows.

This moves network layer tests out of the network layer callbacks into
helpers called from the transport layer callback. And then the helper
has to look up the network layer header and demultiplex the protocol
again:

    +		if (((struct iphdr *)nh)->version == 6)
    +			flush |= ipv6_gro_flush(nh, nh2);
    +		else
    +			flush |= inet_gro_flush(nh, nh2, p, i != encap_mark);

That just seems a bit roundabout.

