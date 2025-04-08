Return-Path: <linux-kselftest+bounces-30349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57395A7FDB5
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 13:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18E74222A1
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 10:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A2B26A095;
	Tue,  8 Apr 2025 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJC3bxiD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FAF26A0A2
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Apr 2025 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109834; cv=none; b=FGFcqrlHXp1ThGQAj2TeivDX7+nzjYeVY1ZNvMcoIPY+eos7rmGANw//MO7sKa2DoQrQUGLRonlN2kuE25wATQlxb4BSpjWcm6Fr1T1FWVMhYG/67W703TjrLhX6XmNQfSQ3x1wxvXOO72cO9m+ecBEyNYJruuwJPwtbmMfpKw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109834; c=relaxed/simple;
	bh=o93kT3HUr6PSKVXUdV14Bgz9/0yB1U6VVEQHCXqgg2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mxTLo/96hm9x5lrtT92/MqtNo96uNasMT7Q27U0NkqG8sxYNj9oYfN5JQMrLwUfSZo0LE/bzjBDT4LJ91F/wVjE1XMXMDMVkbYOamX+0M14A4j3uc3YmjIPnEHj/567WJ9IXXgwygGu7Ge1utJKhu76Fpo7e7XzmlMEz+gxtx5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TJC3bxiD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744109831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WiB8QLkLLCMptXLpQ+Fs8eV4CmtpBvO8mQtuoLcCE5Q=;
	b=TJC3bxiD4i1szKlMsr5BktZwJPY2cXpGA8Q3ubUAzyv/uGDP+QCRsQ6q7fRFhkBVLB4WzC
	qUVNhBMA4XZOFSiR/SIvfbHOcds39RxlDwD0F/n+ZsZIBpCGpp3agpDeiKP4d3JxLVueEC
	l0fno4S9suemCtgHkKlAG5kzLjPZs7o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-yQQYJQP9OC6UeW0m3_MlhA-1; Tue, 08 Apr 2025 06:57:10 -0400
X-MC-Unique: yQQYJQP9OC6UeW0m3_MlhA-1
X-Mimecast-MFC-AGG-ID: yQQYJQP9OC6UeW0m3_MlhA_1744109829
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d734da1a3so28268185e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Apr 2025 03:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744109829; x=1744714629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WiB8QLkLLCMptXLpQ+Fs8eV4CmtpBvO8mQtuoLcCE5Q=;
        b=emjMmKa6teChdLYUKEcdYbinOP4nhBI8LxQSlXMeCKxcOfnFQSr6aa1nJLYJc+X2tt
         0DWp1qdvLqLleqcbtRnXWetPKWQSy+76w1UJ5LBWq0tVrJmjoR3OHV6+Y+4tEe3rFbUc
         93U5iv9U2FFpw+t/N7ZM8tGjcz+q7xllsh4eTNypH+T0n4GwwGsGo1O4WdG04N2TnYj3
         UVCeSc8sybjX+6oTCnGEczaGA8/MkVD1R6YsqjxbbJXG8Ao8Xt2wTOLvhe4qQE9OqnAr
         KRpfLG346OYmDW7I1GddEOKl2kVrJd7ohcg6vJ8WrnDNmxRjnMjaQnDxHNxJXBDxrzlI
         tzVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVde6PTBIqeUrck5JFCZ8NJ+Jra/1OP4Zk31Wi/cBlAfilGdQ9pXdMtHDmoWBzDIxILvtfzzqyHeLvl3sb4NTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDKEsptC7pM1dFtdDgLvgcvI2DY2wo5n5fXP75EsDg5oniDGIc
	IN+ySKuSdr17hBugdU+f8y4ZH1xgI36w7cCgFEITZqPsG2aoOl6MnbUtA+gXFJ0Hfo2i4cBeJ/K
	QpdGKAJlJRnbCBeeBxifeyQO6FLBgOs792WFVK9fj4n5OMWl6P4B5BJje3+285jIg9A==
X-Gm-Gg: ASbGncu6lBCY3eQsqlt5rJZfPibWDHRSE3V1eIP2k6nzIZoDzryHARHEY3qWzm+T9++
	7QBUmDdClNh4Jhdq5E4iMwRr6PHVEO5lMXw/RAgGQ9gPyttMu22m5C25nLnWNdH0thqA4+Juq/8
	F5u8T2RATCHUtjySRAvDkiRL6m5WnXFfiD2ztIepxf1fKbFHA6ZVSTle0gqPLhKRThdsvRiwlGJ
	Ar17bthCBVhMSTTZukU/ToBa9hZ+WH1POBDeBuywEGxgj9bXenn+SucY/2+qWxAoBwQQJVUr6JB
	+sj1luNm4kLIHOp0WuWJtnJirH7tTfe9GfEOpGXAKgI=
X-Received: by 2002:a05:600c:3b94:b0:43d:649:4e50 with SMTP id 5b1f17b1804b1-43f0ab8c6d2mr41519695e9.13.1744109829420;
        Tue, 08 Apr 2025 03:57:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHucF/g2LzNPlKjjAwHyVa6MKKp0vRxRscl5LXt0EXHIloC4uTn5GNaY61HCGJgRWXZ/jCvhA==
X-Received: by 2002:a05:600c:3b94:b0:43d:649:4e50 with SMTP id 5b1f17b1804b1-43f0ab8c6d2mr41519505e9.13.1744109829064;
        Tue, 08 Apr 2025 03:57:09 -0700 (PDT)
Received: from [192.168.88.253] (146-241-84-24.dyn.eolo.it. [146.241.84.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b6321sm14290396f8f.44.2025.04.08.03.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 03:57:08 -0700 (PDT)
Message-ID: <c4b1219d-a42d-4339-93aa-89987cc6ad2f@redhat.com>
Date: Tue, 8 Apr 2025 12:57:07 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: mptcp: add comment for getaddrinfo
To: zhenwei pi <pizhenwei@bytedance.com>, Geliang Tang <geliang@kernel.org>,
 linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Cc: matttbe@kernel.org, martineau@kernel.org, viktor.soderqvist@est.tech,
 zhenwei pi <zhenwei.pi@linux.dev>
References: <20250407085122.1203489-1-pizhenwei@bytedance.com>
 <ae367fb7158e2f1c284a4acaea86f96a7a95b0c4.camel@kernel.org>
 <0de20ab7-9f1c-4a13-a8d2-295f94161c4e@bytedance.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <0de20ab7-9f1c-4a13-a8d2-295f94161c4e@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/8/25 5:09 AM, zhenwei pi wrote:
> On 4/8/25 09:43, Geliang Tang wrote:
>> On Mon, 2025-04-07 at 16:51 +0800, zhenwei pi wrote:
>>> mptcp_connect.c is a startup tutorial of MPTCP programming, however
>>> there is a lack of ai_protocol(IPPROTO_MPTCP) usage. Add comment for
>>> getaddrinfo MPTCP support.
>>>
>>> Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
>>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>>> ---
>>>   tools/testing/selftests/net/mptcp/mptcp_connect.c | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>>> b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>>> index c83a8b47bbdf..6b9031273964 100644
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>>> @@ -179,6 +179,18 @@ static void xgetnameinfo(const struct sockaddr
>>> *addr, socklen_t addrlen,
>>>   	}
>>>   }
>>>   
>>> +/* There is a lack of MPTCP support from glibc, these code leads
>>> error:
>>> + *	struct addrinfo hints = {
>>> + *		.ai_protocol = IPPROTO_MPTCP,
>>> + *		...
>>> + *	};
>>> + *	err = getaddrinfo(node, service, &hints, res);
>>> + *	...
>>> + * So using IPPROTO_TCP to resolve, and use TCP/MPTCP to create
>>> socket.
>>> + *
>>> + * glibc starts to support MPTCP since v2.42.
>>> + * Link:
>>> https://sourceware.org/git/?p=glibc.git;a=commit;h=a8e9022e0f82
>>
>> Thanks for adding getaddrinfo mptcp support to glibc. I think we should
>> not only add a comment for getaddrinfo mptcp here, but also add an
>> example of using it in mptcp_connect.c. I will work with you to
>> implement this example in v2.

While at that, please also clean-up the tag area: only a single SoB is
required. If you submit using a different mail address WRT the SoB tag,
you should add a 'From: ' header. See
Documentation/process/submitting-patches.rst for the details.

Thanks,

Paolo


