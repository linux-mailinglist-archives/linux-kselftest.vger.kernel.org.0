Return-Path: <linux-kselftest+bounces-46208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA362C78950
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 11:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 7D79F2D7BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 10:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21335346772;
	Fri, 21 Nov 2025 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="gzIqciAj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB733338918
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763722595; cv=none; b=muZfXC0sn8gTj+aBBQSmyF336eGLu2QUoPppFkrY1kgVQ4VNlY7pZsIG0Q0uR+5vXSU/p+zd96L67W5AG7xlr62XXAD0CDAA4gMW8iGiim3CHWjSdaL9GTeWXsNL2cDKezRTeglLc8190w2rImnE44nQ7nshoKHcdSMKnWQQh3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763722595; c=relaxed/simple;
	bh=2AJ/1GSmQksetn+BMiMiEJuDmPHGDBntt2UbOIs1azs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9bUqXnwBKTKJiHOSGEbv0hQlr1QJu+a6b9Ct7xgUjNbiyunhU3TYEzic/kQPAH1GJN7yQmyz4SXqtO9/7uw+eO0oNp2CZZ3UmK1a8aeVfVGhP2BfwJ/OjJxGrB1mvhWbpSkL4eXiif8pgQreAYq44VDR6DbXJB9jpMhT0vm1Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=gzIqciAj; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64166a57f3bso2919175a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 02:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1763722591; x=1764327391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P//Wm4lYmYe2NXo70RM8HR66HjWu4DiEiy4uHI2HTIg=;
        b=gzIqciAjl2pCqLatD2i0itBmVjwjnBmX8mpjil2qs8fXn+4/AXiOyb6qLHfAo7vfVF
         P30bpUuJjK5VBbB5YeV3zSMeR6XBDgz/mLUVKEI7GDxsbyUzoB2qK6Psc2c3Tkw8wLyZ
         sdm3sKVPhbaC2xZgBp90kp0htw2Nk2D8hNPYz/KGeaQI+JYbWZftqLSYBnDPNjnP1wl/
         e2lrP/trnCeoBQyZjqyrZuSErsKTUZDo/uJWrW19jz3CA7UmnV4VCaQ315Pb9pbEiKjY
         P/bWSuiDUWNlBv45/VL2TT7k/qiv9FZUlvl/xJa6CyCujYXkwoo5iHqghIbTe3pT5O7e
         bHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763722591; x=1764327391;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P//Wm4lYmYe2NXo70RM8HR66HjWu4DiEiy4uHI2HTIg=;
        b=Y+BxhCHYSOZe4ICzhbes7nHob2NoycnX043BDI5CrbOZlLEyRlA4B3XSm2mmZa0U5G
         j/blPQkUNyXuDkZrfwKzmZPn/32vSmMwg+CaBr5pZ2RvjskeizUqg0EWPxaRUkXWvvkh
         kmfGxDkqVLlQx4DDYeRds/1g8aPTHuxoELqBi46UaY5KKO5Z2M9fQwnjPirY4TxFuwcj
         FvwbcsLp3d/vpnsWS0Ng0Ax/OoFP2dsd9LnjVSz6BTEB3mr2E6W1fDA2nE+eOKB0t2Tf
         y64jeRQfZO+PUGPPogGcupebdSg1cGard0rhfb/ALpoCVTywhSNTzYL1uAKOkYwdmz5+
         0HvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3SP9A3EToLsnDAs17evs7fjZDFD+4CJmP/On/QjccvNNDLomrV8Qu6k2ZYYmB+fBHo91yW61hRowF5jHyUEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLuFuUr2NkuskWL1zLOnht601MB/DH2Vz8B9dJrSRT+Cmh3wID
	pZ9Oovw6euiQComwDNZdAhqGMGDnafqZ7PTxAQMex1cJTm3iQ/jhYUI9JeufDu1ZHRYiwyiLKUQ
	/9MXWzIbHZtPEGdKXAyJtuOtGg+NECpRXj1iAiA/DAPTfzMRzE1PpNzhIY7osFEY=
X-Gm-Gg: ASbGncvSLXs9QKaNx1jW+/c1mLBYaZwqTF2cXgtg0rq9TfJ9byQwf++cHFP9xaO7Idn
	eFYoHEDUjU9hs7a4D0DkuE7k4coCklefzxAw+MYiPDUdeh39ZRMhJbV3k1dJesMJH4Uklje9/uP
	oxg98L/x7JMv4oZ0D8yb48aAXjbpuY7m975DSnMCimdUy4pwBqwycy4VFgLa+ieW5NRIQtfMrao
	eY1gRYSVhJPY2n2cskxva4mwYuQFFI1zezm2zUFtFsLDcX4RfpKwZbgZUFGsEssWv0z/3LzUxAt
	9EtR3d/0wA98Z0s/bE/4u395u6jnwZLCTucFyDvnI4ebUT48tcLfSfmotE4uNFwD4FJkgEu3rta
	OumrE6p5VP05yzCq2uXzcWGvxaaQ3XU/cYy83pZ4RCQH0K8pu3LsdlaD8yOQc9m8VWO4VSkaMEN
	thTc0Z9d/ocuCduPJPlvn69/6GucRqCq93tMK2T6qxa7NhJRxDYA==
X-Google-Smtp-Source: AGHT+IHlv2Qu20FDUlxa+R9aFr0uHdh8aR0rjq/DU86F3C7QUQxdHUbK438q04auWjtUAYthu033UA==
X-Received: by 2002:a17:906:dc89:b0:b73:6b85:1a9a with SMTP id a640c23a62f3a-b7671591ebemr182097366b.21.1763722590971;
        Fri, 21 Nov 2025 02:56:30 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:d094:6d8b:cd60:2f1d? ([2001:67c:2fbc:1:d094:6d8b:cd60:2f1d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd4e51sm430988966b.42.2025.11.21.02.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 02:56:30 -0800 (PST)
Message-ID: <767e0c63-a674-4f03-a893-2b6a456d1dc0@openvpn.net>
Date: Fri, 21 Nov 2025 11:56:28 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 02/13] selftests: ovpn: add notification parsing
 and matching
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Jakub Kicinski <kuba@kernel.org>, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
References: <20251121002044.16071-1-antonio@openvpn.net>
 <20251121002044.16071-3-antonio@openvpn.net>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20251121002044.16071-3-antonio@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/11/2025 01:20, Antonio Quartulli wrote:
> From: Ralf Lici <ralf@mandelbit.com>
> 
> To verify that netlink notifications are correctly emitted and contain
> the expected fields, this commit uses the tools/net/ynl/pyynl/cli.py
> script to create multicast listeners. These listeners record the
> captured notifications to a JSON file, which is later compared to the
> expected output.
> 
> Since this change introduces additional dependencies (jq, pyyaml,
> jsonschema), the tests are configured to check for their presence and
> conditionally skip the notification check if they are missing.
> 
> Signed-off-by: Ralf Lici <ralf@mandelbit.com>
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>

Note: this patch should come after 05/13 - this is why it fails in pw.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


