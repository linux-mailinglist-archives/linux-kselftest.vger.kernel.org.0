Return-Path: <linux-kselftest+bounces-43574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD974BF33B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 21:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D60918C2FAB
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 19:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55FD32F770;
	Mon, 20 Oct 2025 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/XWckUa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3F22DAFC7
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760988944; cv=none; b=iNyh5/7eSHgJ6OV7geasvJgiXzhVZbPpiqk+aJgvgD7LvYE6ruUt6KLwYIHDCBEwcsLoIz9ZYh/zr3PVNr7x4yrK6QavSJbgNbRqH54uC/6e0N/AjQblhjFZyGWJQgOUYDEd/k+TNCUR6kjWMxvtdRIk4RYu1x7YYheoHnf+t+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760988944; c=relaxed/simple;
	bh=TstNcT24iidk65qQwuHBm8MLWpw+Rgs03+06matpxa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewL8rMBuXZpi54HRy3vprDS0fCjq6QUZ4ot1N3eWbmXcj2nHqpdHH2QHOE1UpHLKxEZwc3XYLO3VGbgMUc2gHtFjkmIPWC+WknMT8l2ToMJK1dh52NfcbGYl+M6ZiAP6jvtM4oFl9Nc5c3Bp7J5Yj8UBnkg4/trl8y8GpDEI7DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/XWckUa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760988941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IZ4KHrVXGbKOyfWQ4VuLHo93xGYeDh1z6yDjQj1rykE=;
	b=U/XWckUan8Y4NRNee+WrFmcITFLpMz1xChjjjSwOfyMd1j5wJD1OmR9DhgR3CNYg8j6ltY
	IepoyMyCmlfGe//X17Z5oSUsuWjY/tjIt7fd17Cbvmwrf9ma+KI4HWS/jYhgvl2xZxkZsc
	mHRZGXi6O7qw+C5v4Mp6TED6nAUCZWQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-KcWXAj8IPTWLXHKxw_tO_Q-1; Mon, 20 Oct 2025 15:35:40 -0400
X-MC-Unique: KcWXAj8IPTWLXHKxw_tO_Q-1
X-Mimecast-MFC-AGG-ID: KcWXAj8IPTWLXHKxw_tO_Q_1760988939
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47107fcb257so70843265e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 12:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760988939; x=1761593739;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZ4KHrVXGbKOyfWQ4VuLHo93xGYeDh1z6yDjQj1rykE=;
        b=qUV440sEq/3qWemh2gcQuQO6IKjnya95/T5ZEH/Gm3sEVTlFHbFjoAofmvckZmBMbq
         RnAmPF7KriUAGHTIEohRiSQg6oiAZm6oz+p+N6uZW21cQaVila0UCnNdf0JjV7XrvVwE
         3Kh0son1P8P5gKpNquaDr/JDBc0O9WOzZ6a5Uqrx7/4lbxlu3TKwx6Jz949aMhfjNZDw
         WA7W1P6nDqF6tbHeJ4ucdeJXBF6LcOR6Hngk2BHisTqDZZ0yjXcUu4jirwFLwJtKySMW
         dLaw7NVc+N9p06w4BygwDcwR7kBvdb9gEDHeoDN7FoRAOkodmlsOTs761M2u1seHcAWT
         oUCA==
X-Forwarded-Encrypted: i=1; AJvYcCWPUAUUJLeEaAMlOUR3bq8cuHMUcfpGV46eX1F1TVSA895RbVzKicLqFj1+kq23st6K3TVIIftsoL4IT+S7OZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOpcF8R0Mx9yYkGgyU6OyLY38IWW0hE4Jd3U4AAEA6VdiUNiRD
	VCq4dYRHCoX5BEb3O9vWM1xaiBO2pmaHL9VO/TDD+ldk0itDzM5X7GroX7FMWQCS2mBs/torFaV
	5nBExxXLlEr6z0SgK9H24yp2M8jmROlSt+FxDECN8KlzIL3Hd4N6ap38ZVgEtHsQCHYN6/A==
X-Gm-Gg: ASbGncsFCgnEpIajRUtKziiw/1+4Zgsd9LvVwlAtHQtmJZdSPdctmr4N2/4xCsC0TU+
	xLn7EgcjtPNE2gkrY2D4e9KgG1u3HkAQdnkMBfHlyRnQrm4278xeqzVvlf4iHGE+Te/zelqD0DG
	f0Rhbpvv1AOLnj9BtwdL7ccx1L83WoOOcKJgmXZYGxFlSDvxEvLbHXlpRHQkkMuzAa+6qkWlh9g
	97Gic4tme8hPJO5vdHRFU1ifISB/4triFSbTKBy8fgAWqHZKIc/2lsOQ252chAgSGJWRd2PFofO
	DLqy4WWsPHSQ59+jPsP1Oxm0L6nUeDCTzwVKLo4aTP6V85i1mykY+cF85pPeEA8rpxgeWUkVivn
	TqOUyKpy7X9O0jOStaRDZCT23vEZ1jtVFSJh9wFcqISIp76pjPewBwjyzbfmwi0p950KiFUyfFg
	URDLnwP3sPhQQWvYxxnrHAvYiZ2Z0=
X-Received: by 2002:a05:600c:528e:b0:471:7a:7905 with SMTP id 5b1f17b1804b1-4711791cba1mr138573225e9.34.1760988939344;
        Mon, 20 Oct 2025 12:35:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUD1Q58X1dirbdln4YyEHe+ZrBTn2g3MQBkfJH1bO18P6uDwJ35vA6zo0kQDMsN8QQTSSzUg==
X-Received: by 2002:a05:600c:528e:b0:471:7a:7905 with SMTP id 5b1f17b1804b1-4711791cba1mr138573155e9.34.1760988938928;
        Mon, 20 Oct 2025 12:35:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00cdf6csm16661954f8f.43.2025.10.20.12.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:35:38 -0700 (PDT)
Message-ID: <85166a8a-ad54-42d0-a09f-43e0044cf4f4@redhat.com>
Date: Mon, 20 Oct 2025 21:35:37 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 PATCH 1/3] Documentation: add guidelines for writing
 testable code specifications
To: Jonathan Corbet <corbet@lwn.net>, Gabriele Paoloni <gpaoloni@redhat.com>,
 shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 gregkh@linuxfoundation.org
Cc: linux-mm@kvack.org, safety-architecture@lists.elisa.tech,
 acarmina@redhat.com, kstewart@linuxfoundation.org, chuckwolber@gmail.com
References: <20250910170000.6475-1-gpaoloni@redhat.com>
 <20250910170000.6475-2-gpaoloni@redhat.com> <878qifgxbj.fsf@trenco.lwn.net>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <878qifgxbj.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> +------------
>> +The Documentation/doc-guide/kernel-doc.rst chapter describes how to document the code using the kernel-doc format, however it does not specify the criteria to be followed for writing testable specifications; i.e. specifications that can be used to for the semantic description of low level requirements.
> 
> Please, for any future versions, stick to the 80-column limit; this is
> especially important for text files that you want humans to read.
> 
> As a nit, you don't need to start by saying what other documents don't
> do, just describe the purpose of *this* document.
> 
> More substantially ... I got a way into this document before realizing
> that you were describing an addition to the format of kerneldoc
> comments.  That would be good to make clear from the outset.
> 
> What I still don't really understand is what is the *purpose* of this
> formalized text?  What will be consuming it?  You're asking for a fair
> amount of effort to write and maintain these descriptions; what's in it
> for the people who do that work?

I might be wrong, but sounds to me like someone intends to feed this to 
AI to generate tests or code.

In that case, no thanks.

I'm pretty sure we don't want this.

-- 
Cheers

David / dhildenb


