Return-Path: <linux-kselftest+bounces-37410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2402FB070A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 10:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A163ACEFA
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 08:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311852EE988;
	Wed, 16 Jul 2025 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gdkUh3/I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2B52EE984
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654824; cv=none; b=Uer7HyM4DFgSAlyQoYN1npapaX6LpIVbukMDOQsQnXw/IK+KJJ6qqskkZjT4FhADxIj1LzAuY1DjoYceOBYKCh56VGhXlkTJPAe7B2tWfnYz6Ph4EVD+r5C/5huEp/18R7SwrjeOuAhspflSBb47BCUckzj5pVMPfu7HGUKMo84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654824; c=relaxed/simple;
	bh=PO/hVtAFUJcvYOoFA5Lsz2XawUBmB+drYH34Ga9YmFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tbxPYDbVKuAn/XM/eyMX1dz/3hctfnm6/7BtsJAB9AfJRk4J011tJKc9aB/G4A9hVK8MyLPROC6Oh2ZNitY+EC4+oq6CltOT2RElpF4ktG5TM0ive24F6PjZaV6lEAAaofTYCCdnVt2lmQRo6fh7g9yRMzuIsp+5WlGrjwqkiJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gdkUh3/I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752654820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1/mMMz9r3dZS5fLhT7uV9k7AsWyXJpRGJaGcTiHmpis=;
	b=gdkUh3/IuqZpgh99DSDeG+f3CF5NQoyzxIv0PJ5/2vJNcQZHqKznHZlSnR2q8oUH+SXg+Q
	PKn/hdNsCo5+TEvcmBWGM62QkIGEJCrTcETqBEaTH8sY0VsFJiOzvoErTRRqTuan1LyNB2
	Vv5mFQuguSWjrCe3MRFtn4eL2Iz1DwM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-gx8qBlFeOjSLpgW6uToJEw-1; Wed, 16 Jul 2025 04:33:39 -0400
X-MC-Unique: gx8qBlFeOjSLpgW6uToJEw-1
X-Mimecast-MFC-AGG-ID: gx8qBlFeOjSLpgW6uToJEw_1752654816
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f8fd1847so2470444f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 01:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752654816; x=1753259616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1/mMMz9r3dZS5fLhT7uV9k7AsWyXJpRGJaGcTiHmpis=;
        b=ZODIC23VJp1mfgQLtM5DG6o4ynpkCNfDsq57gKeO3iNniJPK4U8N/zgYd2n9IpY2Nu
         P1PldTwEXb220V1P6TdY6ei/ICaR6FGLSYuO392vDz0uHqK3xw3xKc032HcBmLZTJdaV
         tLyqm2yljcvl5QgsJ34QxVAzDyIKfYOUthJaGmv0k2ADYXUftBlN1F+o8HDGCTn4iQ65
         1F+rSHzZkd9CcXlUdl8dnz2tb/BQK7jI/pcfBO2bXUNy/mBShpVVbzOd7V6tvtkBwoHu
         1s3Z2E8ISio6bbSqatyYElV4NN36pBpznI0EhMf075ji7Pp9vp9IkWO8IPP04JAl7erx
         qKGw==
X-Forwarded-Encrypted: i=1; AJvYcCVFiaBUR9dBJb9gVj6uI6nirWZlal8TnnS1vAezxirjMLLTzTQKqkm0i5tCYWsw5i7BSaCW3VYjA/60xoBEu9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA4KdCedSnFpA96Sxs8yDdbmPodZKxPI/mZ6sJ8+SSMJ9s2fhq
	W+P7z4wB6D99VzGVHfBPbH1wRk1N7PQKGuohzKQYZ4rHXO6wYVesDDQExBQOUSvJmFPromh79up
	GCThlEbnT93ZmXGqKducXIm+dxZ38AosJ/ZZnBTAKQRYlPf7Sj77Vlo61N+RDrU7ZmuE6GQ==
X-Gm-Gg: ASbGncvC/VVEdTEVIf0ICo8LC6WOXAiNZgGaE5/gA6i5al24xycDbOk2/Kb23PVi1fM
	q8Z0g/gOiz0iUufMsIkw0zD8VwUb4yDwJ50iSfFMssk7WnALY7RaZ/H6y9JzOBH7vi5lc4oGYYm
	qCTSqSB8D2AZYpaXbi/E27gwLrf1ZFYUJ+PNCBjLAZOVFuGwhqyYEEd94JJRXwEI5BGI80eaYtM
	y1bAiMRIvhCutiY0dWi5NdHFBkW0J/fl8hQQHBsdNeVadqglZA5HSVk5KzF/vN14+AymSKoaBf3
	lJBPgJtDHSyjJegoPSD27R6wbKoSl9Edmp2qDRKdCMUETo9CZiDMmO6BY5Ixp87z4PAmefO/u8i
	NnmUkNxuYHgk=
X-Received: by 2002:a05:6000:2101:b0:3a5:67d5:a400 with SMTP id ffacd0b85a97d-3b60dd7ad32mr1289770f8f.33.1752654816274;
        Wed, 16 Jul 2025 01:33:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9yD8/Rt4+/VGcbyULapP54i40HRfZLKuicTBEq7LAucDsT5xtqNB3H6FZ/JdSK6n94pjh2w==
X-Received: by 2002:a05:6000:2101:b0:3a5:67d5:a400 with SMTP id ffacd0b85a97d-3b60dd7ad32mr1289729f8f.33.1752654815741;
        Wed, 16 Jul 2025 01:33:35 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e886286sm13769075e9.26.2025.07.16.01.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 01:33:35 -0700 (PDT)
Message-ID: <514ca303-149a-4f7e-a473-31051fb7162b@redhat.com>
Date: Wed, 16 Jul 2025 10:33:33 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 net-next 12/15] tcp: accecn: AccECN option send
 control
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
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
 <20250704085345.46530-13-chia-yu.chang@nokia-bell-labs.com>
 <b2c0653e-077f-4609-922e-777f1d868dd0@redhat.com>
 <PAXPR07MB7984D6FA40FF000E51F694F3A357A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <PAXPR07MB7984D6FA40FF000E51F694F3A357A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/25 5:14 PM, Chia-Yu Chang (Nokia) wrote:
>> On 7/4/25 10:53 AM, chia-yu.chang@nokia-bell-labs.com wrote:
>>> @@ -285,9 +297,33 @@ static inline void 
>>> tcp_ecn_received_counters(struct sock *sk,
>>>
>>>               if (len > 0) {
>>>                       u8 minlen = 
>>> tcp_ecnfield_to_accecn_optfield(ecnfield);
>>> +                     u32 oldbytes = tp->received_ecn_bytes[ecnfield - 
>>> + 1];
>>> +
>>>                       tp->received_ecn_bytes[ecnfield - 1] += len;
>>>                       tp->accecn_minlen = max_t(u8, tp->accecn_minlen,
>>>                                                 minlen);
>>> +
>>> +                     /* Demand AccECN option at least every 2^22 bytes to
>>> +                      * avoid overflowing the ECN byte counters.
>>> +                      */
>>> +                     if ((tp->received_ecn_bytes[ecnfield - 1] ^ oldbytes) &
>>> +                         ~((1 << 22) - 1)) {
>>
>> I don't understand the above statement, I don't think it yield the result expected according to the above comment.
> 
> Hi Paolo,
> 
> I was thinking to change it into GENMASK_U32() and comments like below.
> 
> It is intended to send AccECN option at least once per 2^22-byte increase in the counter.

Ok, I see it now. Please mention explicitly the above in the comment and
test just the 22 bit.

/P


