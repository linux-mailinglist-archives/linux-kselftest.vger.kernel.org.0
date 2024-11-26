Return-Path: <linux-kselftest+bounces-22521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69669D8FA7
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 02:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2D4168EBE
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 01:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD09522F;
	Tue, 26 Nov 2024 01:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeqbcH9W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3DD4C8E;
	Tue, 26 Nov 2024 01:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732583114; cv=none; b=kJxpRVjwC36kQE1wp+QodtBwvBnrVpb22Lv/KN0L843daooqJN9c5RX2Qz5ZrqjEbq0HYDRt504EMnoFpI0jzqG3MImxBwQjl14C01d8nvjUZ4ehiY3i+fXXcsMTLxLZv2UU2XyvuO3PURkhee+TDZ9jWv9ldh61PU7DdOTwZfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732583114; c=relaxed/simple;
	bh=D6XCk+88Cl57iCwF9kJrgVUmXfBbYF9iDc0694XJtwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPnWt8Acomv3GI0MWemBqet5+zrttRRTeTGWxaqRkBU8C4mBbu1d5uejU/EnW+BU9VhhpFtRQ36aXyR74k8AcNYXJ6VOqwEiSTAVToJC0Zr/KRkIbV0iTXwe4rZH+CK1eOF55AAgee/LVvffmE4SIXqu6/sV5f9zeR7eaCx9qD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeqbcH9W; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3822ec43fb0so3935979f8f.3;
        Mon, 25 Nov 2024 17:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732583111; x=1733187911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IoN7Sx44hjV5ughbOaSKUX8TLg62XQxIepf4R9Z1nO0=;
        b=GeqbcH9WMwGpOWvHfXBFtb1pAUzt/Yir77hPLVb0FTvLoqpBmYz4SRxwgZbbjQqh94
         2cCSiVdbbhHoo/j7zwDc1TCz9ASix82F5DZmrUu5Uj9Pzh1v2zvAGGaO2HgcOqGlN6k3
         +kvi0tnPQlF8sBajgca2QzaalsP4I+rZ8UwGD431i+BNKEaH+K19zSJtoT0+82M91Wc+
         eb4+/HKxTy6j0etc+hIPExoXqDzavvXfAoZG3J8sKaGQF7qbYUec4ExB8FUi5bhBYFJp
         T8CfL5vJ6b2ZIqy4a1YIYWw8HOBIPPD9gDAm4uZ3kYZZOLACnkMaHAKXHSV1ZFfOVQ/7
         6H5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732583111; x=1733187911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IoN7Sx44hjV5ughbOaSKUX8TLg62XQxIepf4R9Z1nO0=;
        b=C+a/RmVoAKiMa8G6zUs2ZHYBoU1ZrTJyQD8IovDfc68o4tWL2n0K6h+EZ7+WYbpcLW
         4ojabzJHcGXF8tOUuG4MPf7GlFC2kz7Xsy3nt8Dafe0BUTjhk6hgK71+jRoyShR02Za2
         U/cBwpY1Sl3tQEfTNJHYaVamXwiGckLGzlDAlDva+vO9gZKMEcaKIQOVURCTIXIzn8oY
         O5ZRrPKVR/IEda58yNw1IPOqGbt5x0s4XEcX5bCnoHOIHFTMy785E5HO09HWHzjeLGGY
         GyKF0I/mraXBFW+nBxG9EVuVmtUn1TpxGaS1I5vhY441cvwh34THUmWgUJJmbaceoIQ1
         vUXA==
X-Forwarded-Encrypted: i=1; AJvYcCUvZcGnriqI1swsJqrVrPVAEt8nrzLVntajJPNYlP3yetWDLE6J3kW+yzm27JBDO30uovkZRZFaFfWWK2FJ3lnB@vger.kernel.org, AJvYcCWbutJrpv4j52JYML2EyOAUlRJbpwXtSspDmOJzG5Fot5DD/fJp9kiqp3ng9BHo3mwH7I4Trauh@vger.kernel.org, AJvYcCXFyIRW0I74T96fM7RRaS/5dLqeIVe1Q5vTY9DuTSuaVrlr70t6EZiElG9A96nNkpXDLoY4ry09dlXDskg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8slMUdckpnZjh+61RnIqVAx1IrlLQqNJUqD3GAPWieahvEsDK
	pRZMo3VTceQGlEnlpITY3+HlPZeI0dMMQmTNr2YKnvGKynQIzcO9
X-Gm-Gg: ASbGncvti45qt22CDdxc/pIubZxe4YcwYP5N/ljEPGL1WgU0wmJLpawFiufPDEGuJDn
	tXdr0qJHRxqP6W8Ik0b6R8DTYIR7/O0KUK9H6uwGsfC+QLmm05tnfT2U3w/40eF/OLjTl5W+eEf
	6kIie661ae45Jlae88vGVLPFYt3snELSQFCaXshiMt+fAG29RrOxVfwpbEDsAqrsCWYeWcu6DQ8
	ou1LUJ/EImap+CegBnrpJzUXTT1fkdts0s93S+N4LocmxYvqOU=
X-Google-Smtp-Source: AGHT+IGQ01vD5AyAqv9h+nf+MyeOhWDAa7+GJSqzlH/dtWbUqZ/5hNXgjHqFopHTQ6/s1A38NVfVkw==
X-Received: by 2002:a05:6000:1a8e:b0:382:4a35:aafa with SMTP id ffacd0b85a97d-38260b672a1mr10555204f8f.23.1732583111286;
        Mon, 25 Nov 2024 17:05:11 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc38afsm11759983f8f.67.2024.11.25.17.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 17:05:10 -0800 (PST)
Message-ID: <cf89c31c-7c49-4cd3-a69e-e56207c318de@gmail.com>
Date: Tue, 26 Nov 2024 03:05:47 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 12/23] ovpn: implement TCP transport
To: Antonio Quartulli <antonio@openvpn.net>,
 Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-12-de4698c73a25@openvpn.net> <ZyOhe3yKTiqCF2TH@hog>
 <3df02a8f-72c7-4db9-bb46-a6529082b328@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <3df02a8f-72c7-4db9-bb46-a6529082b328@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Antonio,

the question was addressed to Sabrina, but since I've already touched 
this topic in the another patch, let me put my 2c here.

On 16.11.2024 02:33, Antonio Quartulli wrote:
> On 31/10/2024 16:25, Sabrina Dubroca wrote:
>> 2024-10-29, 11:47:25 +0100, Antonio Quartulli wrote:
>>> +static void ovpn_socket_release_work(struct work_struct *work)
>>> +{
>>> +    struct ovpn_socket *sock = container_of(work, struct 
>>> ovpn_socket, work);
>>> +
>>> +    ovpn_socket_detach(sock->sock);
>>> +    kfree_rcu(sock, rcu);
>>> +}
>>> +
>>> +static void ovpn_socket_schedule_release(struct ovpn_socket *sock)
>>> +{
>>> +    INIT_WORK(&sock->work, ovpn_socket_release_work);
>>> +    schedule_work(&sock->work);
>>
>> How does module unloading know that it has to wait for this work to
>> complete? Will ovpn_cleanup get stuck until some refcount gets
>> released by this work?
> 
> No, we have no such mechanism.
> Any idea how other modules do?
> 
> Actually this makes me wonder how module unloading coordinates with the 
> code being executed. Unload may happen at any time - how do we prevent 
> killing the code in the middle of something (regardless of scheduled 
> workers)?

Right question! There is a workqueue flushing API intended for 
synchronization with work(s) execution.

Here, the system workqueue was used, so technically a 
flush_scheduled_work() call somewhere in the module_exit handler would 
be enough.

On another hand, flushing the system workqueue considered a not so good 
practice. It's recommended to use a local workqueue. You can find a good 
example of switching from the system to a local workqueue in 
cc271ab86606 ("wwan_hwsim: Avoid flush_scheduled_work() usage").


And if the workqueue is definitely empty at a time of module unloading, 
e.g. due to flushing on netdev removing, there no requirement to flush 
it again.

--
Sergey

