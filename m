Return-Path: <linux-kselftest+bounces-34807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CEFAD6DFD
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 12:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A413AB58F
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 10:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FD6233D9E;
	Thu, 12 Jun 2025 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="2pp8Lf8S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690D021B9D6
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Jun 2025 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724707; cv=none; b=aRNYGyKWuZjqE+OfruxmDRaK/lwnf/7sTfWOrOs0S41yDR+EVIt86rvC19Qtk9Y7if8Q1G2UittCtxdC7FHlyHk5RmiJXz36fT6X2g4p1dqgVFJIlpLjBdckeTUHUARqM7A86PO9e/DhhZfXMMeb6/GbMSBhgLzCSM4SuQdBzrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724707; c=relaxed/simple;
	bh=C0YxdnemTpgCIoRlkdnSMhWfet1GRoKJc45sZbQcRyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+po8FUyz6anCKBvL8o8AgnlA82ljMUNCk2UwbS1LAmBkCSLW9mqOXImBGIrZ7qPXfhjQDlM5yQjD8Yr7kz/E8yr7p5VP/g4q+tmoOM9in8fpzycgdpNGG6a4b2czOa/5XuBTFyb1lbzpQaU+/i1zDdCGjF3Xwp3iR7IZgTFib8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=2pp8Lf8S; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-553246e975fso853377e87.0
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jun 2025 03:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749724704; x=1750329504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7wct2nGyoCqXp2x3vjQbGkRa3XdgPhK3Uo0JALvLVWQ=;
        b=2pp8Lf8SYTSt1sCkDbUdhJtGNHcPT6z6fW9PxmKPGLyPl5KA3VKkcRFv6/8rfAXwxf
         zs/AxO5su9WBrAxjrUwDADM7s6MwatRhkEx/2L3ckuV7GV1JvYeoE5m+ISOL+CPEFr+j
         bqtS9XLecqqhIc14nvP8UUugTSOgm3fQn47ep6e03kKyQj2QPNcCRRr9GcGPskwoQLUd
         nmd1AxPzAFocl0NM1Dt801PWhoCT5gVwJM3RwfymaZFGP5A/eg50hjvUxddPZvGWYDNB
         XIslpB57rKSoyYcvlvOa6WkQwzmbQXxEqNgNWJN6fmVw90EepTD0aODNyiHYdA2JZFYC
         kpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749724704; x=1750329504;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wct2nGyoCqXp2x3vjQbGkRa3XdgPhK3Uo0JALvLVWQ=;
        b=P0mXv4i0W91sRxzWWLgRDNsx7zSQfUstdQWq/wN6hWyk9Izw3zleHIUtSyT4WYdQ7J
         uud2N69EUMMyz18hX1vmsSRjS5vKeLtRuTArQyWB3QLD4esT/YOlmY4m+FyCDDFjNEBq
         05mqXrdKUUqz69VYoJaTSAXISxraAdGFLsnONLwUzwgNBZHBJXCyKgJsIn3ZAeaDmIiw
         aLkhJrnimeYrJwGdnzoTp8dX4YM13AM48lGM5BpZVroRH85W+9hRpJI7H5hkn+egJ1Mu
         9X4sPD8jESvaHAgECQSSf5kIer/t2RxNtBwrpC1S6os4bViwlU/QlfQIfsCmlF5fQ+DX
         gsLw==
X-Forwarded-Encrypted: i=1; AJvYcCXoD1ql4tvXc1OX3IoTo+3VIS7/fl6ej55Q9vnHrgNp6nAo02NuxSHMDCFElBWVMqbiBJN8gb+/FBXlsVvKhj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL/DFwG9wfctgmq/C1seN08zYyQPlcEa6GxU8HlRCZb+m2b9zf
	BH8uzLM2o+yMliFnjsPomLFKzThSnY/nGJh3X7hZP8Y/XVMox4OORX39RmAsJ2RgB3w=
X-Gm-Gg: ASbGncsxxQSxo3z5iR1jG4yLmx7WCNIZuTlDBQjYgzQKVhoEE67kdRmmKraLG4LjeOG
	EsKCvkDFF+xGitaVL2hfeqbLz+tmG3eVRrlsFOvR1NQb9FKh6UtiywegDIHfo8JWTcNeSW3E6m7
	LOnlKQSVU0Kkgj+VVd6nATioWLi96K2erAMZfYR8w6d0mktfHKSl4uRinGJw1CSDVTg2B25gaA8
	6in6T+l4QUn8Tz2e5H96HIfdTFrxlxWVyspfQm6JYW+fMcc7cM9+/EBHUgpJzUVscn+ILwwXQmM
	TQnHVgivmpSmqX/r0jbRv0DxUC68SW6A1iZnv2iFeg+pqJDZSncSWw0wwSBTHW52tb57770Fqad
	ThDXSq7Torg6snzbYoIxaNbufs1GB2mA=
X-Google-Smtp-Source: AGHT+IFW8TIRuuJh3800ncpzKN4iIagGqcN81CLQqAHtsQdPAIFBiChOrzfFfejUhBr9PgNXkAuPrA==
X-Received: by 2002:a05:6512:b01:b0:553:2633:8a65 with SMTP id 2adb3069b0e04-553a5553bc7mr823077e87.30.1749724704461;
        Thu, 12 Jun 2025 03:38:24 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac134eaesm70552e87.63.2025.06.12.03.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 03:38:23 -0700 (PDT)
Message-ID: <180d82c5-582f-4879-947b-649a4495254b@blackwall.org>
Date: Thu, 12 Jun 2025 13:38:22 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 12/14] selftests: net: lib: Add
 ip_link_has_flag()
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
References: <cover.1749499963.git.petrm@nvidia.com>
 <e2fc1734cd9437349e22e16c05fd0f4d06397fb1.1749499963.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <e2fc1734cd9437349e22e16c05fd0f4d06397fb1.1749499963.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 23:50, Petr Machata wrote:
> Add a helper to determine whether a given netdevice has a given flag.
> 
> Rewrite ip_link_is_up() in terms of the new helper.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
> 
> Notes:
> CC: Shuah Khan <shuah@kernel.org>
> CC: linux-kselftest@vger.kernel.org
> 
>   tools/testing/selftests/net/lib.sh | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


