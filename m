Return-Path: <linux-kselftest+bounces-33046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6D7AB7FB5
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 10:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E434A1B68CD1
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 08:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD4D283FD6;
	Thu, 15 May 2025 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SO5sGZoc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B55283FCA
	for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747296280; cv=none; b=Qfe5MGLrEXYYPA+j+ngEcJjwLcvslHddg/5Xb8b4c49g8PX6u4QzQpOvQF4QGVeHbzkxjdxMEq4TrX5ZGIpAWzcf2lVZtGMHDZ4Eo/k8TtUU7ZFjoBe+IdyDqB9OGGWqIymFR+jwzC6Z3PB7buSCO+XOr7ley8JGtXnfFdEKAr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747296280; c=relaxed/simple;
	bh=hFI16IcEibTtzPjWil4RMX0FyQWqasrEVbdYfXZ/6Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Eg036KNXBVqqp0acYLMtJZdL4+7UUEpbrnfsbdCdmyf1WFU/hszPzkMpNZ+sMI4YAbWZf0M/OgvV6cVJ74SYRpIUt6D8n0v5FWRD0VuvNec+jV0KrWo2+PQDK57mz2PSwXnBMDtgzs8HGkbB9qPXuyuUlM/XMmdDclu8WjocZsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SO5sGZoc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747296277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OZnZ930PYjxtmz3mlM23ZtpwvM2PpRU0aXUuxlDGVc8=;
	b=SO5sGZockAzJGt6nPoja+1kog0Rn8Td/m1YIqQiun29u/rCEfz761NaDQIwOWpBb4uTmlj
	N1aRYQLHfc8cSHr/sN8iVVjVl06WtVtbBegjpv2htbwoNvMS1UBGuq+oCfub/vWRQEg8P2
	CDzBqDtuFNN2XMkj4froJbWWQNJi2Uw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-Mk1Y6dwkPwWSiqPOV1huOg-1; Thu, 15 May 2025 04:04:34 -0400
X-MC-Unique: Mk1Y6dwkPwWSiqPOV1huOg-1
X-Mimecast-MFC-AGG-ID: Mk1Y6dwkPwWSiqPOV1huOg_1747296272
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-442dc702850so3811265e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 01:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747296272; x=1747901072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZnZ930PYjxtmz3mlM23ZtpwvM2PpRU0aXUuxlDGVc8=;
        b=b2Q/uf/eNrD3AxHExsAzAFK/VhVn5PEkgVb/dvw+PB+4mvBW/0c9rbPHbE8y2wQg0o
         qPMy3YTpuQNvBknbmiSYY+sGhcI8iFjMdSa+Fg3zpW+tbUb6moyeuGW7JHOWEaFmq5oR
         TAlKpqX1cwvdU48BBSLKFG12ZCVznYjeyhT5h5EGEyPpxMbEFceDeqyMB9fMvvs9/V0d
         bd3yLqixirvsg4RB40c4dlwdmeddLSADrgVMUPvMjlKKULrswXQL+9mg5DQC9flEeNNi
         rpBVVKWtaBtDdg2QKnlqWhqyt/pMMrXIXQVENpVpp/Ke/jm+WIXmwYdxvIU7luHDH9L2
         aEFA==
X-Forwarded-Encrypted: i=1; AJvYcCUhDOh9y39b/bVWqmhM7PfKlkcBjnVJTjclRzMMZLUigxYPmY/AI0J5g+uenQhOyEwqMmKraXOTTfIo0ElKQog=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTmMn9OryT5ire/39+LIxGSFZadf3OdsScTJsUzAfRzJhNCieU
	qEPPL/ZS//YH9wCPKTkCynYV/WiOox9JnGCpIW6zUacUxjl95qk4IUtRaT/vGC9aRbF11YY9OMn
	RrOnv+3zMPcP3WN359MRdGARlU7R2Py6w+Ofuzpd8AnfwMdaWv07UT9CfDRig3br3HA==
X-Gm-Gg: ASbGnctT1ohgLfhwm5P7mwGLpLqsk3tl1uI/Sk3jIstKpd0NTyZubL6AQufkFIJQlhE
	tSK7jtKAqdPLeXBeMBxdl7fnxWPLvKlAlpx3q+tNN9kdaBxIHIjy/uZ06YYURfzyvnAl56oaC5I
	kL+ijOm9QFV+orzdvhsKxdmQ1UQRvUjVCr4iqa7AayF6FJbTzX12fM/Qs7eKQpm7rzh0bfEJCg3
	HOkQKnWMbKmMaUkOD2wpz+RB1LF1rSaDmA27tJbIrd0P2lgvGvYU2A2Rcb7GCjZWBENp0zpWy8X
	tfpBhFxvoHlp/S5JUy4v0pCSyCIP1GxEbYZKPFDln7jastldGzcFKJ4Z5vg=
X-Received: by 2002:a05:600c:1910:b0:43d:160:cd9e with SMTP id 5b1f17b1804b1-442f2107910mr65299395e9.17.1747296271658;
        Thu, 15 May 2025 01:04:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbb5QWq3rrKQDxAI9WDSnTqkDsUuGBTfT23Ixh3TjemUWpIa7C9OKvWJU6E2gkZjfOBK0QPw==
X-Received: by 2002:a05:600c:1910:b0:43d:160:cd9e with SMTP id 5b1f17b1804b1-442f2107910mr65298925e9.17.1747296271240;
        Thu, 15 May 2025 01:04:31 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2440:8010:8dec:ae04:7daa:497f? ([2a0d:3344:2440:8010:8dec:ae04:7daa:497f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35573f32bsm776505f8f.17.2025.05.15.01.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 01:04:30 -0700 (PDT)
Message-ID: <936046df-5ed9-49e5-906f-dec64a63f531@redhat.com>
Date: Thu, 15 May 2025 10:04:28 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 net-next 0/5] DUALPI2 patch
To: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org,
 donald.hunter@gmail.com, xandfury@gmail.com, netdev@vger.kernel.org,
 dave.taht@gmail.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20250509214801.37306-1-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250509214801.37306-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/9/25 11:47 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Hello,
> 
>   Please find the DualPI2 patch v14.
[...]
> 
> For more details of DualPI2, please refer IETF RFC9332 (https://datatracker.ietf.org/doc/html/rfc9332).

A couple of process notes I should have mentioned earlier. The cover
letter should be more descriptive WRT the actual series contents and
goal, beyond the changelog itself.

Each patch should contain individual changelog, to help the reviewers.
At this point you don't need to add individual changelog for past
revisions, but for any eventual later one.

Not worth to repost just for the above, but if a new revision will be
needed, please take care.

/P


