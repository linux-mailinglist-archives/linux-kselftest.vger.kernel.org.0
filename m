Return-Path: <linux-kselftest+bounces-44941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049ABC3A759
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 12:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B83E53AAE00
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 11:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A4E2F363B;
	Thu,  6 Nov 2025 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMgrM2SV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWAkx2MJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E81280035
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426909; cv=none; b=ZcLHvVEQpX1mMCwnP5yamBTBf7vNYEIva451B9/BMPaF0m2v3xO2b35MS7RJYtct7VdfO51a8Mr6qd6ZoSA9soK+q+eucE/D5t/eQ9JQOrkSDbBLo4z6ei0nEcUzppb8zvj7sgGzjODkfLhEfo+JQV9XmGLWU6LfbT0jy31yt+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426909; c=relaxed/simple;
	bh=Dei5euvfk6aFAQ/MRNBfMjoeeHQCZRrQl8W9D/WrzU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aLUdwy2WhVXSSKW6h/bDV+Y9ElZYIXay4DrYB36RfGXxwO/9z1RC3LaQAqeSmsyLSEmtY+ptJ64HgStTOJnh0hyF5t3ksMsBrR4hOJfYfFu8IWi/10KBJ20Mar4cS42IchOif04yo93GggLRJAddYjTYwW2NUhHnU5uyvY37QEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hMgrM2SV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aWAkx2MJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762426905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07X1DhUV2EUqxrRz0+TYJuq8bAIzOYbawmg2oVbO75k=;
	b=hMgrM2SVTyYYtjr4kDwtLfhUjjgg9QL72p8oYzGyjLkK262It4LYS5141P6N+MM9pLxXpN
	W3kW21BY8T7vWAWx0IRAdyzINI6wNF68mS+YgPW4ZTLmcVclosXken/t1rhR1YmQRwd1ih
	BjEfXZsSZ4OUvwIsGT7VtoevEjP3HMU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-yyRR9T7vPgKGFxPLY6LW-A-1; Thu, 06 Nov 2025 06:01:44 -0500
X-MC-Unique: yyRR9T7vPgKGFxPLY6LW-A-1
X-Mimecast-MFC-AGG-ID: yyRR9T7vPgKGFxPLY6LW-A_1762426904
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e47d14dceso3727445e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 03:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762426903; x=1763031703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=07X1DhUV2EUqxrRz0+TYJuq8bAIzOYbawmg2oVbO75k=;
        b=aWAkx2MJD0eCUyqTGZpxYU9hbFMcHcZ/vdNxbM+shEexTREhXuDjf9M4BnJFNYNrbg
         9nmxrPbO7lu7oLPyhXVM91baJP5UTHGOw5Kjr6j1qYQMi3IruoTexZO/bcbeGPB2U+rx
         K3jexjeasZcYiMozF07n+GQ0yaWMDHxWxrrl6BYYcE2CzbvazGpiAgeuMoDnyWlDGxSN
         5CRKkZpkCWYQd7FKxxJH+YqzqNuvmLoBIMasKxOZi1ZdHN/ZObfaVZ3FMHR2jNW/XG0X
         OdZ0bKEMxa7RNQSNu5v3LYrRhexsJ4Amjg0fmdZDAKEHK4bw9ErvztjUX1zizh4UGhSe
         XhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762426903; x=1763031703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=07X1DhUV2EUqxrRz0+TYJuq8bAIzOYbawmg2oVbO75k=;
        b=cAeEFHxSsSTQ/fzjwLmpLqJej4jM1e2vNvm+6/mZSy3CPksqD5WwDhUoGdZxqtCmnN
         y7CdEoAAAMCEykRpd4FiCZ1c+ymrWiG0y/SS9HROeY8/GZMib/z4D+3RQY+bzz5CKhJY
         alms4XzQinX2SGI1rOItezBQQUILwTSgYrsseF3qxJ3YheylzW0Gjx+3uRi2bzipC+3X
         sCvjcZxQ6PYe07TQaYDNOvDuNi9Dx0w1gc79Gq8tNrJ2q/lc0RBLmHxLaPu4U0clQ+HK
         CkRqmthBaeb6EKoueAvsem/rYRtRFNWWpg9cttZ4c/CF0TgUIRh0lr26QxssUkSVGDK+
         sfRw==
X-Forwarded-Encrypted: i=1; AJvYcCX4VpSl6rNHtAgiJVBV4BVczm3S1vmdm8T5gwmf1ts4sSEcjIR97ydGFMilGreIGaDywfEuIC+qf847b28xwUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKe9DwTOb9IXDy3U6b/cJSkccpw3aMxYDzWjTBIYXuwhHt/JSk
	/FJ0Vc4aqWJNEWEo8kp0mOeIodqLgvKq5Wb07mc98X+TX2KVREXFrGThDH4ukYGNt5L7sHN+sJJ
	TBUMm5r4zB/lisZJVN+J5irHWnRq6JaBYp3ZcPd0LuchdsoiwhgJqaa9+P5E9PsTFVsAzSQ==
X-Gm-Gg: ASbGncvtJEis4wNgUDK8AwjvLAi9DE3bbw0UAwySfjlVloh2+Faifg1DR69D7w00LYo
	3gjE96Ck81huaeCsdqsLBUEnRgaxjbIUdXwHA41Phn2r8wDGcSTS4+h/m/ZJyDfoNxogTVMgeT2
	cvvctzhD/ngutoGhvz6b95dNkzqu9HHucmT7cyW/gjTw9+QzEES/+sS7bTCjSJrddBWdM73AZmK
	gi63TTATlSTaFakx/L3tTN0qlqxSTP3OrWlZ7iWZHXzCgpEhUJO3alx4iF8xDAdGusd8OGWv+yx
	cVCaIADFlGX1IpJ7K4GUYietKTo0b98FjTDp5jbjAZIxZ4jPgZjMoyR7UOquAo5ovXwhNYNHFLG
	QPA==
X-Received: by 2002:a05:600c:46ce:b0:471:1774:3003 with SMTP id 5b1f17b1804b1-4775ce14b52mr58027575e9.29.1762426903196;
        Thu, 06 Nov 2025 03:01:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG430xjOAqRIvEcdMviVraV1j6ItaKaJ77q7yFj/XLjJ3thQ0llyl6gKxWQm4UuWaaKlMnvwg==
X-Received: by 2002:a05:600c:46ce:b0:471:1774:3003 with SMTP id 5b1f17b1804b1-4775ce14b52mr58027105e9.29.1762426902622;
        Thu, 06 Nov 2025 03:01:42 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eead98d2sm2648165f8f.38.2025.11.06.03.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:01:42 -0800 (PST)
Message-ID: <8ad4ca21-5b81-415b-b16c-6cc4b668921c@redhat.com>
Date: Thu, 6 Nov 2025 12:01:39 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 02/14] gro: flushing when CWR is set
 negatively affects AccECN
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
 <20251030143435.13003-3-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251030143435.13003-3-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Ilpo Järvinen <ij@kernel.org>
> 
> As AccECN may keep CWR bit asserted due to different
> interpretation of the bit, flushing with GRO because of
> CWR may effectively disable GRO until AccECN counter
> field changes such that CWR-bit becomes 0.
> 
> There is no harm done from not immediately forwarding the
> CWR'ed segment with RFC3168 ECN.
> 
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Please provide a test/update the existing one to cover this case or move
to a later series. Possibly both :)

/P


