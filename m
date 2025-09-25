Return-Path: <linux-kselftest+bounces-42273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DD1B9DE3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 09:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3003826D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 07:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E2E2E5B0E;
	Thu, 25 Sep 2025 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uf2tRVHz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705A2242D99
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 07:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758786270; cv=none; b=rbjX0D+WmjptaMwGAr632b/TkjxVS5nphPb+X1Lu2tE/7yICp97LROTikYQFvLHdJHPOjt3LuECsso+jVUUjG2TM7QIOC0Ip4cMmAMzKM3f8KxgSoFDCf2nnHxugLwl7Cv7VUFn7RPbYWMW65PraCPijz43cGTzPtjV8frNK9yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758786270; c=relaxed/simple;
	bh=ugLehOMIQJ+Et15CIYTCGD2MzcB90KpcWiFwRf+O/xI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AFPq4jpqd27tH8i/fN31SH1tPWGU3y81MlxDiQFOR+mdSy33tOCGt1M6Fr6DSXFXZHxgGOEBKLt+64k8nWXOyw2oM7dA5FHyJ4zWFFWKVaplYgDg3MXqAzqXhOISCcTIdulfqzirNs+ZeRXN6N2n3nr6X1uPFV0xVMblHIiJtL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uf2tRVHz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758786267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEtIyjQBQWhfMNa18kEW2ePRbLcIzRH3NXOv/vzbj6M=;
	b=Uf2tRVHzVz5Vi98CCrtmAis0WlsJfO7MmL8ybjjSsJEXWmCgF6ck+vgeNNAvegP6iaaYye
	ASPFARFzBiAxh8x/9PoV0PMz+pprXQYJei9ixR6S0JBoJXqBttWv12352HfA2L8LUhSgtH
	fiEt8r+LfaS1Dmym/k2jyysVFxNbY8o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671--q0SI39tOLquO8fP6mrmDw-1; Thu, 25 Sep 2025 03:44:25 -0400
X-MC-Unique: -q0SI39tOLquO8fP6mrmDw-1
X-Mimecast-MFC-AGG-ID: -q0SI39tOLquO8fP6mrmDw_1758786265
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e36686ca1so2477305e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 00:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758786264; x=1759391064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eEtIyjQBQWhfMNa18kEW2ePRbLcIzRH3NXOv/vzbj6M=;
        b=Cc3L6bkKs47MAmB3gxR7sHO+x1EPo8iW7PPx9owZM9sZLfo/P+rmQ7oIEs2eftqazX
         MpbiQRJ0vnbWbY2Iv79DaDhdHhyPBLVKK8k6VIcSYm9sD4ztkD+/W+i9o66edak0Bc0C
         U1vPQIJ4dadjaPUc4w2upomLv/nqHiQMV62MO04nZs0PNJnExOd6QL7gYmUnZQ1qzuBu
         jp4UpIB7OFe+hZO4ZeaT//kulYMAvCa28ColHeB0AHw3C+t7/pGIbrQpoQbnCehZkT12
         4c82gd/DdpCJ9ho7DGeTjQr5x5NakGfm6D2rEXGT4z8sdetvOhWjMME2LzIVsoXI0fDt
         5CIg==
X-Forwarded-Encrypted: i=1; AJvYcCVG7Ttv7j67NIon/6fh8aqIF7Ayxg2B0l9P3Hg2JJwewnnPr17yKBfXZSC6+FusUlFsYzjF252ofcWVOuMz1zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaptMKbJ7wQ/o5m0EbcNCns35qAi3nSvF8AROFvrVSFiX8wn90
	Jh7mP8zINYVbgmtXSeA+w9vtvsmO4+h/9LjRHGHFslnaOmo/1H1zOIhYMOMDQ/0C4Amre4EEwSt
	A5ujJj+3yVV00bcp3emNW1Rrp4tMw/JPwvzlcDPGdS/zt+zsdwv9Y6Jyv6cknkKSS+hmvlw==
X-Gm-Gg: ASbGnctroZo3B0wzhre1aDhWM/Cw/hRj706qz/7g84U1JoEOP2XqT2ir97EzBUMh1GE
	2gydyaIK9OWb4rXk88Y8s4fspMvAvXwvnRt3TKjUPT34aD2iEBeiZW91rNZkNKlcoyZ08vNfYfd
	NMb1rn99i3gQGaZLqxWwiowGUVHH0dOFe8xgJl4kDJ/UapJdgkIgkAXQ/RJis/BYFJQqkOWAAeM
	UtBYvKoxkAZ+2cmY2SQAiXRgUDo2CdoSE+ZjyYWUrzWM91JKbwGJYfFP8yZakzSaFNRPV1uV8qg
	TK+jOG+uUW81kIMgMfNPg9Hk2e7aTnnxy0DX7nuMNCTeaZlwGJJlvT+mHjgUKeLStZStjs6oXGA
	WxD/im88Un0mS
X-Received: by 2002:a05:600c:8484:b0:46e:1abc:1811 with SMTP id 5b1f17b1804b1-46e329f653emr17736605e9.27.1758786264609;
        Thu, 25 Sep 2025 00:44:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt7+vuVFRubxJxrOllWmSQM91xay34blZgLFJjzErhlGB9fkTHJc47Tm6tJsYcxZXKKZ/Mjg==
X-Received: by 2002:a05:600c:8484:b0:46e:1abc:1811 with SMTP id 5b1f17b1804b1-46e329f653emr17736175e9.27.1758786264164;
        Thu, 25 Sep 2025 00:44:24 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33baa625sm21917375e9.7.2025.09.25.00.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 00:44:23 -0700 (PDT)
Message-ID: <ce0f60b5-858e-4d88-904f-5f77bbe82643@redhat.com>
Date: Thu, 25 Sep 2025 09:44:21 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 03/14] tcp: accecn: Add ece_delta to
 rate_sample
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>,
 "dsahern@kernel.org" <dsahern@kernel.org>,
 "kuniyu@amazon.com" <kuniyu@amazon.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "dave.taht@gmail.com" <dave.taht@gmail.com>,
 "jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "ast@fiberby.net" <ast@fiberby.net>,
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
 "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
 <ncardwell@google.com>,
 "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
 "g.white@cablelabs.com" <g.white@cablelabs.com>,
 "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
 "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
 "cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at"
 <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
 <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Cc: "Olivier Tilmans (Nokia)" <olivier.tilmans@nokia.com>
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
 <20250918162133.111922-4-chia-yu.chang@nokia-bell-labs.com>
 <161c09cc-9982-4046-9aa0-d0ec194daba0@redhat.com>
 <PAXPR07MB7984DC6C693DAED54AC14161A31FA@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <PAXPR07MB7984DC6C693DAED54AC14161A31FA@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/25/25 9:40 AM, Chia-Yu Chang (Nokia) wrote:
>> -----Original Message-----
>> From: Paolo Abeni <pabeni@redhat.com> 
>> Sent: Tuesday, September 23, 2025 11:48 AM
>> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; edumazet@google.com; linux-doc@vger.kernel.org; corbet@lwn.net; horms@kernel.org; dsahern@kernel.org; kuniyu@amazon.com; bpf@vger.kernel.org; netdev@vger.kernel.org; dave.taht@gmail.com; jhs@mojatatu.com; kuba@kernel.org; stephen@networkplumber.org; xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@davemloft.net; andrew+netdev@lunn.ch; donald.hunter@gmail.com; ast@fiberby.net; liuhangbin@gmail.com; shuah@kernel.org; linux-kselftest@vger.kernel.org; ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_goel@apple.com
>> Cc: Olivier Tilmans (Nokia) <olivier.tilmans@nokia.com>
>> Subject: Re: [PATCH v2 net-next 03/14] tcp: accecn: Add ece_delta to rate_sample
>>
>>
>> CAUTION: This is an external email. Please be very careful when clicking links or opening attachments. See the URL nok.it/ext for additional information.
>>
>>
>>
>> On 9/18/25 6:21 PM, chia-yu.chang@nokia-bell-labs.com wrote:
>>> From: Ilpo Järvinen <ij@kernel.org>
>>>
>>> Include echoed CE count into rate_sample. Replace local ecn_count 
>>> variable with it.
>>
>> Why? skimming over the next few patches it's not clear to me which is the goal here.
>>
>> Expanding the commit message would help, thanks!
>>
>> Paolo
> 
> Hi Paolo,
> 
> Sorry for my late reply.
> Here, ece_delata will be used in the next patch series by tcp_prague (or other congestion control algorithm) that support Prague requirement to adjust the congestion window accordingly.
> I will elaborate more on the patch notes, or you think this shall stay in the tcp_prague patch series?

I think the latter would be the better option.

Thanks,

Paolo


