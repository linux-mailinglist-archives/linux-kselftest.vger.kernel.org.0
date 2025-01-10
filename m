Return-Path: <linux-kselftest+bounces-24207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A31A08EE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 12:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EBE83A11EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 11:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46DC20ADF6;
	Fri, 10 Jan 2025 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="MwO3UGQ8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA7B205AB5
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736507554; cv=none; b=PhXpyNXN8DNFFKzVui3KRiB7NKgrlbhrEwoV+kDZGxxF00G+FvSK7IiMvE6X/d5fLNUvpZJRQrTe/ZEYAB+lCpNRxbcJmCMHQNaV6A5ybsOvr5vF5j4xAPbK1J8CzsX6Aqcy1Bb2k2TglYy/Wpx8XcuAz26UTvq+rNXH79xb81E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736507554; c=relaxed/simple;
	bh=qXSynCY96TYG7wZ7OASI5Muii12uM+aBd0x+fKz2Q64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fE82IGeDN61HGtSTUi5Nj9IpYJQU/KdKaxt6NAl0Ewh4n36N+UbtF4GXnQa7ywUrNtqOFtGOqQOm2yyhzr6UFlp81VpriavJ/rfd1XlrIKa8Bjiq8UniVTxFd5iGa4hqWQk02S1fzRBJzE/7RBDAM9JuiXCinc5boAxb6RF72K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=MwO3UGQ8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2164b662090so28959635ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 03:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736507552; x=1737112352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fUI/Gf/iNdZ2kON6E6PSrhEkMNvEUQIh/sL8yMhLamQ=;
        b=MwO3UGQ8TvdlcnS1Er/wPY9ota4qi9gGOgTNt7g7S6YG1L9H3gqX0ExQeXxKJnXL7X
         XeAWFpsMp3pjyvWra0SCvqOuqk/80Ss1ztp4HN27fDmWYrpuva407XWMh4/xOAEXA3KJ
         WuOh5DzuQ4gbLE0fUUS7YS/+tghLtkvK+s5eGulTypBG7qqUOlAMyYF9c7Z+TLIAXXwW
         UE9+ude3fE3mDWHLqpT9hK6iDDqMJCmdSPQ2vfvJ015wBRsVUBZDs2Tw0Jz3m2fwhswE
         9BT0HSyyEVIF8eiJ9+cOWEtoHXvBzBFnnCNhJrTMzYH6h9prUzxWAnD2O7WOPlgDTkiH
         UdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736507552; x=1737112352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fUI/Gf/iNdZ2kON6E6PSrhEkMNvEUQIh/sL8yMhLamQ=;
        b=Mcl4AIGYYO50HLfSbvuKsI1AIhfDdg+akf2uAHEdgRHrluEehFhNcK67D3RC1la+ES
         AQzOE4DrpqjcQSISYNsyw/8R1cqn2Brz6YPsi2gMkxoYJRv1CIes587b17nx3OANB2r0
         NlTxTauzAv4pVFAlSxTGjm1gxHQ6h7J437qItX3okS1ocRXWb6k62qPooqZXopX+qEx8
         Sv+Rb9bsQKHM+wmWiKj6fvOkFq0yur7wHx7KgukoTRfgKA0V1YH+V/o7p6ta79t/mLCS
         toX5t+1EOhvzR8fkC8woZ1KjK2Wu4pujUSU6hn83uo8ebMBLtohYp8sQEiN80mhXiTQt
         pvuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk/+iVrFOulhLwg2gHBzoi2cJpV193abgb5rX5fXJm8cluBtbc68hJOajDuyKzNBAHHZv3mF5hgx0ea7wi/lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOqQWp14qCgWJzjwJrdID4uVskbAoIeKD/w1npoZsKaoAPangR
	GXLBwCbj5fxT+sr/ijQ092g80Ml/slhnNcgfAzMyIqjB+PeuAmbR4OzMY/eM4wg=
X-Gm-Gg: ASbGnct4wPFEt/9eJP7y4m9yhwSb4kNT49GJYIJKMJQPE//aN+WO++pruXzrfVPBIMJ
	c/50Bqp+zks3rcVk30z4BxKPAzpa6SlSutpPq5zpGHfTD7npsRww6vEeuPwPn3lzFrjC4PunSkd
	Bb2TKoEzJSyDoS1OpHw4NbM1635R1vs+05MbVS4oc4CV0afrtQJ23Rk6JmN9JPQVSuad1M+nbCv
	LZBKddhtKiUhGoZ8woFFBjcAVhFOdf8Zqx8nmZMUT/FrqZZYRg+3MmRloWtg1f9QLg=
X-Google-Smtp-Source: AGHT+IFsisJKA6JOrR0eUj5WfV8wXSlwG+ErpDxaHPAWov6uHn2OYu5jltHENp4vvgdoL273AAhZWg==
X-Received: by 2002:a05:6a20:244d:b0:1d9:fbc:457c with SMTP id adf61e73a8af0-1e88d0a4770mr18461822637.36.1736507552500;
        Fri, 10 Jan 2025 03:12:32 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4056a2cfsm1373935b3a.51.2025.01.10.03.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 03:12:32 -0800 (PST)
Message-ID: <2e015ee6-8a3b-43fb-b119-e1921139c74b@daynix.com>
Date: Fri, 10 Jan 2025 20:12:25 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tun: Set num_buffers for virtio 1.0
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-3-388d7d5a287a@daynix.com>
 <CACGkMEsm5DCb+n3NYeRjmq3rAANztZz5QmV8rbPNo+cH-=VzDQ@mail.gmail.com>
 <20250110052246-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250110052246-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/01/10 19:23, Michael S. Tsirkin wrote:
> On Fri, Jan 10, 2025 at 11:27:13AM +0800, Jason Wang wrote:
>> On Thu, Jan 9, 2025 at 2:59 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>
>>> The specification says the device MUST set num_buffers to 1 if
>>> VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
>>
>> Have we agreed on how to fix the spec or not?
>>
>> As I replied in the spec patch, if we just remove this "MUST", it
>> looks like we are all fine?
>>
>> Thanks
> 
> We should replace MUST with SHOULD but it is not all fine,
> ignoring SHOULD is a quality of implementation issue.
> 

Should we really replace it? It would mean that a driver conformant with 
the current specification may not be compatible with a device conformant 
with the future specification.

We are going to fix all implementations known to buggy (QEMU and Linux) 
anyway so I think it's just fine to leave that part of specification as is.

