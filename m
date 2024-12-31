Return-Path: <linux-kselftest+bounces-23792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5A19FED7B
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Dec 2024 08:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A043A2976
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Dec 2024 07:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B4D18873E;
	Tue, 31 Dec 2024 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="QsKlaobR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25936EB7D
	for <linux-kselftest@vger.kernel.org>; Tue, 31 Dec 2024 07:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735630939; cv=none; b=feCTtkS5LuBQKIh2sy37Pe4UmrD0VNVujMSFg1MJdARBTZGCWPkAw/KHyjLOkth8fQg9V3OuCLoEJq4wd38XSDtm8x9iVl7L2xDyj6U4+YmjZaLWw0TomTA43zhyhf7fvMtc4r6pg6J3FbXlqD/m6hG0A1r7fZ9ha8P+gCY3qkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735630939; c=relaxed/simple;
	bh=OIIIHvRIxIHxEBMmDuGdkER/XB9yAK9pRHFHJSHH2Nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iu/zFFOZlySwLBusu/l+WqDd7Wot1fDXXBzV4O71VPX8pqIGK/YY5w6IdoSI64CVTwTx5cePAWx3qyqtyy3W7zriHZIrAffAsvYz0/GqHYx19Vrivyw7StHMgGZ1eu0Rt9H22U2ijQfJPdMjSqcTc0IUSP+UX1S5QXLe9UsQf/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=QsKlaobR; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa66ead88b3so1798373666b.0
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Dec 2024 23:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1735630935; x=1736235735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SUQ/117o2pVOfsQwHm9Em7LXO/LveElAMhz4OgmXTrM=;
        b=QsKlaobRqW5WfgOLJhs3QcoRm+6VquQKBWzay6xhNFGXTR/J8tRL5fHdZXwS6n6ssu
         ob4lTP/qIo8breSwvXl5AKNPmLpgSlDU2ndSA41l7rajEVgsfHqMsBgN1xyPchfVwyQZ
         13B07bRIq4h79LY9QxF1/VcRBL3nruIOZTvyAIY7tdmJofoJ7g+6imCdGI/plziHJkTZ
         NLBrso+YDg8dVzCrVtNlIgbUOdZ5yK0jxHYnZ+YvMMPMfricNI6pAonwwKZLBO3glz0s
         Rq5kt+Q2w1oaWyIGj8Vsjz6mlIMbd80sgreGa4+x1wRsnFp48uCOfT1Ifh+rC4ho1/3d
         YR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735630935; x=1736235735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SUQ/117o2pVOfsQwHm9Em7LXO/LveElAMhz4OgmXTrM=;
        b=TOL4veIaH9skBRkw3wK0pJmXoDKWtV5sZOb4DKGpby/DqYmzc/+RgG0SC+lBo4F+SJ
         W3a92moFc040nY4gIe/S+MPvAOQ1Xr2ABy0YnL4xDZvam+g7XU8L0uZ6LdKCuMmSeR9V
         x+DrlMhMo7+5HYsNriN62Aw1895X4V0Z9x9IwbSuG3mO5dKmLrDnKyeIPvcfbCLD5mgD
         tC/gnAoIjXBUc41XXABDid4810dMsIBAEPSSzSEtJU2xViVftBEqeYc8WX9c/uGnJvNe
         0QMm7+imdvjE97GdvGKcgwUzNRCA8gnT6O8TyUjpQti8clqr7dcYZBvYrEmi6yp9gwWJ
         1UsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXnfZyu9Uaz/sUGYvnw5Rwa8DRtFCtpWR2wYtz2yQn3LtMmRPIqdjSP4tjNkPrkkw9x3Wjw2xQJIOOspspj/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd/llquwvilxD6DL5EjIcBJ/Ct6JIB2cFOc5i2yiU+c7rhU98P
	M4uqlzkoMvCxfOh+Jd44jaMHvcnUWGT2BU6gwwiFPGaceo25Fw1a/vS+bboSlDA=
X-Gm-Gg: ASbGnctsVzUs4vUF9FDT301/dd0P1mm79BxXAu4w9HVXElkH8JrDu5WsAbdFxOFVwTh
	KK8oG6cvVBRsG+ntTnPAfM1hve/Tp2U8t4LxxH+JnYl8KURgNXyyVvfz4jEP5M7vnSiK+1WzEHr
	/oSrAYOIySoY3U7tny0kS0R/yDm6g0bsJirmmYjG/okRxvuLQFphiQjI2JX00QcHWLboJ5NefQV
	gc9IZ1Q2Q7GrO3TkUetDdihddVU5DhpX3cZW+g3JMhRfWo/Bdo3kGYTc1lXZOCNHQ==
X-Google-Smtp-Source: AGHT+IHJ3LZn/dw6Q3RdklojRoLZ4JYqxGeF/O2KsycT1HvQOXnJk5lDUSk8vRMOcWtIAvIoEXjYaQ==
X-Received: by 2002:a17:907:7f8e:b0:aa6:995d:9ee8 with SMTP id a640c23a62f3a-aac2702ae5cmr3305806366b.5.1735630935342;
        Mon, 30 Dec 2024 23:42:15 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1000::1001? ([2001:67c:2fbc:1000::1001])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e89490dsm1538233666b.45.2024.12.30.23.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 23:42:14 -0800 (PST)
Message-ID: <97f8ebf1-bdea-4084-aadd-360d02d00d85@openvpn.net>
Date: Tue, 31 Dec 2024 08:42:11 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v16 26/26] testing/selftests: add test tool and
 scripts for ovpn module
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Xiao Liang <shaw.leon@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
 <20241219-b4-ovpn-v16-26-3e3001153683@openvpn.net>
 <20241219200222.4b0365b7@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
In-Reply-To: <20241219200222.4b0365b7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/12/24 05:02, Jakub Kicinski wrote:
> On Thu, 19 Dec 2024 02:42:20 +0100 Antonio Quartulli wrote:
>> +uint64_t nla_get_uint(struct nlattr *attr)
>> +{
>> +	if (nla_len(attr) == sizeof(uint32_t))
>> +		return nla_get_u32(attr);
>> +	else
>> +		return nla_get_u64(attr);
>> +}
> 
> Fedora 41 has: libnl3 3.11.0
> which already defines nla_get_uint()
> 
> ovpn-cli.c:46:10: error: conflicting types for ‘nla_get_uint’; have ‘uint64_t(struct nlattr *)’ {aka ‘long unsigned int(struct nlattr *)’}
>     46 | uint64_t nla_get_uint(struct nlattr *attr)
>        |          ^~~~~~~~~~~~
> In file included from /usr/include/libnl3/netlink/msg.h:11,
>                   from /usr/include/libnl3/netlink/genl/genl.h:10,
>                   from ovpn-cli.c:26:
> /usr/include/libnl3/netlink/attr.h:126:25: note: previous declaration of ‘nla_get_uint’ with type ‘uint64_t(const struct nlattr *)’ {aka ‘long unsigned int(const struct nlattr *)’}
>    126 | extern uint64_t         nla_get_uint(const struct nlattr *);
>        |                         ^~~~~~~~~~~~

dang!
I guess I will just rename this function to avoid the clash for the time 
being.

Thanks.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


