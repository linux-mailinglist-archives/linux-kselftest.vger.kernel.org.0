Return-Path: <linux-kselftest+bounces-44961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA35C3AE36
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 13:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41CAB3AF68C
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 12:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5398032A3D9;
	Thu,  6 Nov 2025 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2Gdrxow";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oaSAs03v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D5E32862C
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762431851; cv=none; b=A8pJzt7bLOqzDhjHmyXMnpXzG+a1q7OVj2oBO/5vvBmwoLPr3hpX+KWiLfeShcDFWBLV89Nj1Ea5L5v179B3cHc3hnLMGLrOnrKJjPA6Q3dKWoUhY7Liex1ApGDs51Cz0sSr9uJPyr1pOI6aAJel4YY6GPUUJLYRnwCgNI4YpBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762431851; c=relaxed/simple;
	bh=o1vSXAcrCj76/svE7xlpH+YTEefut52cxJb9TUDaq3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pAaz23ftq9tru7VFM0jaYooLxxROKmmbUWXrmsF05DQoPT/zHXUL0Y73P73UcdGHxjjR4n377n+pGLjiU5BWbOL2rZZiqMsbTpK9XykUiDuDE90mrmqshx9cspIPYNdJmkAya9huFM0ajpXOwS1og5GzZ9DuT/sAOZAVWZNdLSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L2Gdrxow; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oaSAs03v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762431848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YTLje7Sai+HUgQsyq0B8i2JUuncjGz92w5jtAQaGYio=;
	b=L2Gdrxowz8FJ5gmsz6wq5G6oghOxAvtjR7b6LOPsFckdPpVG8H3tNX90NEcAKWq6rMdKUU
	FkHrJfLr3l2yUqnKBNE2Qa4pLSSCv3TrGh8lRyALCZSV8s44rZsyoNfaEJ+q3R3jMPG8fA
	MzJY8WQbw0BUr0I0fNtWippiNlTK3Ic=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-Gm02_d9BM7CPlAkjo-r7WQ-1; Thu, 06 Nov 2025 07:24:07 -0500
X-MC-Unique: Gm02_d9BM7CPlAkjo-r7WQ-1
X-Mimecast-MFC-AGG-ID: Gm02_d9BM7CPlAkjo-r7WQ_1762431846
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4773e108333so5668865e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 04:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762431846; x=1763036646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YTLje7Sai+HUgQsyq0B8i2JUuncjGz92w5jtAQaGYio=;
        b=oaSAs03vppGtt4NjOUySTHlBlWAxeCTguZF3a5hv1W5aS2NDb4CJGWukDrXOeKmigv
         ZY5sbGn7TBp8m2uGM/klWNY2VsD1NA5+5SEkgj29D9YJ/D4gvvI+SnN5eTm08fThNQs5
         S2wmh88fBDGM1ajzdmCm6stjOxKoVoNKVPJojG2NGgi+xVWKtVRQhq9PjE9GpO4HgEkW
         eM1lKO37TXFOysCrzrBDbUKhCZYHfYCQCsMxmshN2byuoFf41LbaDzpLx4cWatzoCx2b
         h/cpJkFixls757CJ0vHgrCtR9AJ/cduBWEa+08CkGK1tSQJ44mVuygBha/tKorypWwAP
         81Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762431846; x=1763036646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTLje7Sai+HUgQsyq0B8i2JUuncjGz92w5jtAQaGYio=;
        b=ZAvFucF+ZBpr7HQCe46gtyBTaRjGAl0CvJfCKASXxifJdPD/OlPWluuGMcpTv3rzN4
         ft8D0vb9+YQLqeF4LIAA1QV+3GlarLhQEFA1Jc5Yi9lQsEcdvk5Jiw+bpdTHh1DyYtdx
         YmNkcqq1opmNzLOaHg6fcRQjdk9sYIZy/L1G8C0HNxcqnHgM6Zkh3LFmatiTHAldJ4vq
         a6dA/qAK6vjdXttkH7sTDKgfJetyTJrOVWNckJ1f9U9W7f4TxdyFBww6e+WwDOTZ/uKM
         aVF2UJgYoASHQkA9oTFX8n02yk4xn/kkSMRdOZo4BdPC2CLV1LILeyKptZDXPb2eodpO
         nLmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbFs1RfDqGuL++Bk1Id6v5GThBvpUz0DH0j++gskaxlcV1xO209B2JBE2iDPGxE1wUoSKWUukKS+8JsvmOEIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuTlh4S7ESx+sqAcsEiaayeeqj6BUlGbr/BWjXp0NIFvD7Z2s5
	YytLaSOdNIjf36MSnvItp88+yCHe8XsAnQ7dOXJHVfoxbDvMrMY101dVL1HyJQ80fx1GR8jx6+8
	+FZ8WxQFO3P7BAEJHZGehxQL/pf4UQ7D9QgMBhJvkEfDLEuP2VryBbW21u3GyQAHtyi+hMQ==
X-Gm-Gg: ASbGncuU1PO5yTofEpC2Au0wfvZvKFCb3Vpls03GNregT51O1ksunqivH8lLfGSeb7Z
	PbUK0W7d+WRGsv7LqQxhKJGi1QFD4hH6U4eo1Nwf3GwlF2nBmA0iuZ4W/WbYlfMMuLNsL2Ms6BF
	J0HrdINmpY5bNEAY+FTv+wk1SpUz/90HGoxCNPDosP5wklrXSIA8M0X1ZjQDOYh3rIYhKJJzeVQ
	d123WnKi3GP+3WiSwNUluSNLRM/YSPa71kMM/wI3JlKAyDn6xqiUbXnkv+SsB66M6QlGIv0Kwrm
	LUe/fYuanKuygXCI6dWC6uaZPqaPfS0dQGv7oWFFGOpUzd+y4AL2ZVb2C41Ux8VuePaRs5oq7jM
	tLA==
X-Received: by 2002:a05:600c:699a:b0:46e:32f7:98fc with SMTP id 5b1f17b1804b1-4775cdf46b2mr73654605e9.21.1762431846285;
        Thu, 06 Nov 2025 04:24:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBVUstGGCwY+Bs6EsP+xx23F1DrrQvHLQGW8QZbc/NDaKICSp0/bfepFDCHZNSbOr1NrfhcQ==
X-Received: by 2002:a05:600c:699a:b0:46e:32f7:98fc with SMTP id 5b1f17b1804b1-4775cdf46b2mr73654055e9.21.1762431845870;
        Thu, 06 Nov 2025 04:24:05 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce211d8sm109065745e9.11.2025.11.06.04.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 04:24:05 -0800 (PST)
Message-ID: <2caefd47-52d9-40be-8589-cd92917f1bcd@redhat.com>
Date: Thu, 6 Nov 2025 13:24:03 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 14/14] tcp: accecn: enable AccECN
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-15-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251030143435.13003-15-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Enable Accurate ECN negotiation and request for incoming and
> outgoing connection by setting sysctl_tcp_ecn:
> 
> +==============+===========================================+
> |              |  Highest ECN variant (Accurate ECN, ECN,  |
> |   tcp_ecn    |  or no ECN) to be negotiated & requested  |
> |              +---------------------+---------------------+
> |              | Incoming connection | Outgoing connection |
> +==============+=====================+=====================+
> |      0       |        No ECN       |        No ECN       |
> |      1       |         ECN         |         ECN         |
> |      2       |         ECN         |        No ECN       |
> +--------------+---------------------+---------------------+
> |      3       |     Accurate ECN    |     Accurate ECN    |
> |      4       |     Accurate ECN    |         ECN         |
> |      5       |     Accurate ECN    |        No ECN       |
> +==============+=====================+=====================+
> 
> Refer Documentation/networking/ip-sysctl.rst for more details.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


