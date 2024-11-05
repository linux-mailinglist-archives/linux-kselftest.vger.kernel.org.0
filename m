Return-Path: <linux-kselftest+bounces-21450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E28099BC9E4
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 11:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744DF1F21CDC
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 10:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683A71D1E92;
	Tue,  5 Nov 2024 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJfSa/WY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99BC1CDA3E
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Nov 2024 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730801044; cv=none; b=s6TCkA/ULqY+2/icjfFf886ld/5/CIDyu3nUSESc5iTVskO1Jxi3XFP64LMJ4Rabtu+WqabnU2rnYY9Hyo1SWnI4FXZcvUTsaBM8udvfXfTcvAIrkcfQ9ffZxRlne8gIZ5SARBxU3EXz+74y7M7Pp3t0nxc6iAB3A9FFrGYRiZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730801044; c=relaxed/simple;
	bh=h+lVlv4v4kFhN60Y7uN6+mlTtYtzZfrbtQ0cnBBKEdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B2pSVrnpZys9f7c4dhKl+RpSe3sJ/9HSW5Vve6C+8vXnbqg6u3T130EuBNohNs59W0ikOCcv/h74egbvvwmyWl2zpn0W/n4vYcQRy2S5d4FWkQ+H1/XMYJhgrTQeBqw+RG0EbFZ+Qpnb36rHIEpm8trSAEbUXyC2MZnal0yb844=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJfSa/WY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730801041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8fTSKKdEnBx5rNtqdwW2TR8ocPd2sPuXo5XqxbGsjrE=;
	b=jJfSa/WYQvrE6bpHQNEl3J/5atSGVme+zTLu11uP9PePlGQF2RdT6+pKtFhllLHCdHenHD
	wbagcRHbg+CstPbNVTma9v5JNtLmPdiaqutNeLoGaQEtFnYlFYOGo4jx+FkziQFWDA889y
	I5kxZPh6C4sYz0qzzatotNIjnsRavQc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-KW2hEIW4NqSxf6Qjfh5ClQ-1; Tue, 05 Nov 2024 05:03:59 -0500
X-MC-Unique: KW2hEIW4NqSxf6Qjfh5ClQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d537292d7so3569356f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Nov 2024 02:03:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730801038; x=1731405838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8fTSKKdEnBx5rNtqdwW2TR8ocPd2sPuXo5XqxbGsjrE=;
        b=YQxxaSeXcACM2iXEodkcFAZAeph8yLf37rW4jI4Wx13zraPoFIB5w/WWiBHtfbK+2K
         4ZocLCl7KU4dGTF1RSPQ+pye9LeijVL6WvEVEbPO1MQj2GPbgJgtIyrXqHN9Yme+h6/J
         c+fJY3u0k7hRtaZz7NNTkfbuWllKI13Z9gDa6qL/C6n758Fhed/BS5ul3n+s5HmpZynY
         YuCZGca9TBcT04aHHPj9/0CPdh7uoLiibFjj1nqwVLfUUj93Jpabr6pUnZ7Lv7SiQsGl
         wxXkVrYqLaanJErYYPuEWOSfb8JnOQmE46oBjDdYWSDWqzxFV4H9twTyKqVz0Pg0go1M
         HFlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4wexcyk9DcPaoy2zHQzplwOQ+4Flgsc6GMS49RR841emgB6ruUWQnnqo1lIV+rSLYW3yrcguG1oGNtBHAaXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD5ttB309GSXYRWp5118FKrssSnW3KXtUSJo3b8MmKjS1Bh9tM
	WnYg08m7lFkrctXBQLW4a71pUHcS0iJuttq2JWTXVNdvK/nYi/q8NWaLvGsUY+8baJEiLO/J5bd
	IuYMIWpIp6wAL8FdGCh6PPtzTrtKSkauraBgki+nMyK4rXY0vQCnhQOtkTYYTRbQc7Q==
X-Received: by 2002:a5d:6d0e:0:b0:37d:612c:5e43 with SMTP id ffacd0b85a97d-381c79737c7mr17614314f8f.0.1730801038373;
        Tue, 05 Nov 2024 02:03:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5+ZA7Cgp9oNVpemsCU9kPyu7wz//Ai6PjAUKnrwmGHPvQU4tJd+dwYLWosUIaPd5NLGFBIQ==
X-Received: by 2002:a5d:6d0e:0:b0:37d:612c:5e43 with SMTP id ffacd0b85a97d-381c79737c7mr17614283f8f.0.1730801037971;
        Tue, 05 Nov 2024 02:03:57 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7b80sm15833061f8f.10.2024.11.05.02.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 02:03:57 -0800 (PST)
Message-ID: <3664acbd-6468-4ec0-946b-f6d8494e4a75@redhat.com>
Date: Tue, 5 Nov 2024 11:03:56 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6] ipv6: Fix soft lockups in fib6_select_path under
 high next hop churn
To: David Ahern <dsahern@gmail.com>,
 Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>,
 netdev@vger.kernel.org
Cc: adrian.oliver@menlosecurity.com, Adrian Oliver <kernel@aoliver.ca>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Ido Schimmel <idosch@idosch.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241025073003.2079945-1-omid.ehtemamhaghighi@menlosecurity.com>
 <0dc8c829-23f0-4904-8017-fc98c079f0ab@redhat.com>
 <7ae73a73-fba4-4692-97df-1a88ccc5f576@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <7ae73a73-fba4-4692-97df-1a88ccc5f576@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/24 15:10, David Ahern wrote:
> On 10/31/24 4:13 AM, Paolo Abeni wrote:
>> Given the issue is long-standing, and the fix is somewhat invasive, I
>> suggest steering this patch on net-next.
> 
> FWIW, I think net-next is best.

Should I count the above as a formal ack? :-P

FWIW, I went through the patch as thoroughly as I could and LGTM, but it
does not apply (anymore?) to net-next.

@Omid: could you please rebase it on top of net-next and resend (with a
proper net-next tag)?

Thanks!

Paolo


