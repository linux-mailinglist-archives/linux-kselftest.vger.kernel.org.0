Return-Path: <linux-kselftest+bounces-18366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B1F9865C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 19:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4431C2447B
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 17:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D5A12B176;
	Wed, 25 Sep 2024 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SPqRoFay"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AB98288F
	for <linux-kselftest@vger.kernel.org>; Wed, 25 Sep 2024 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727285958; cv=none; b=cWW3ThAP7kohDcXPA7PbvKsPlRUalrpj29cOsbKnwpNXMMoJ327qoH8dy5Icy8F5tr+G6CFxveSyjtvIEkroSsRBZBMne5YZnx7eLJRaOlPtTB98hpoutFR7UUbWHM4PcIa9vXZHvBVgzLxXsOQET+R8WqqPtQPGbe9Ugxidqgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727285958; c=relaxed/simple;
	bh=f5oF0n0Wz/lUkRAQBBnEg8gLjaISAI4VjaTMonM+/o0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iipYsiawHNZJODcZLXTO+0cf6TyBS730LMdJCfnZ4SgzRNd1WF/fMHTa5CFMUa86b8Gs+VroQj2Ir3H3up4WklKRULPNE/GcF2mirCYAwgAPxWljes+22wCS0akq2RcajwYzy+hOYmjm4ZEUQ3uOpzs1ZV5x4QecyuwG9yF5CR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SPqRoFay; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-39f54079599so605435ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Sep 2024 10:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727285956; x=1727890756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KgGueKRixu9ZnQQScLwMQqezoak3dfmeyQsXQ2YDbSM=;
        b=SPqRoFayTCu1EaYJJZHHWPLjRGcX6zM17x7dapMqrKpp0fb2CmMUhw5FpqGqYpaCrE
         Vii364i2dIcttyHDc9Yzs9tZmjofA5PkvdlOrVxV/HKpFohut0A47qf2c7KXiFLZt+9L
         QnqFhmVVMWL/I7pU5vDp+c0MZpSyXfH+S2PE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727285956; x=1727890756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KgGueKRixu9ZnQQScLwMQqezoak3dfmeyQsXQ2YDbSM=;
        b=OoAWYv41SQlcqNXl40O1tlr4T+Pno8+yChr8h/ficsfdgbrEj60Btc3ZRXQkB3uHa9
         eFeeuMtH1vxRakT5JSQqfl4GGgslWHeBcDglBimsLOuboymTZyM/S0PjIlE8cg+Nl97L
         ogrl5VJPd7MUyBIW9xdu4zLAhjij93Q1igtvgL9avsdWb3yt6OvU4jzQioGG9aLL9KZE
         yh72x4aGHfi2nz4ONsqGWdQaDQKgJssTZRVDsvkx5i73eqh0CulPbiOGz00Zvbxj6oD7
         jUwtwwbHdysK3J+aSY1ui5ezN6pf/IBmxALIsTrjxobsqEKrHROFATP1AW2lPJooqsmO
         8pPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaJEyhZ4MGlilRsYMs62DF+zeSo3LIi7sSrSw2FtuEvA8yBNz5W0SciCEbOjN2sARNeiS0aRuPtENV7CiamsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycq9lu+lKERev3NFWuNXJM73IYZBdtfK0dK9fMEuX3nUfDFXep
	+Se5seY+d4u+mYMJm2G41fCzviv5HtOjXuoQ6uQ/GMtbUY50xMHiIHDKobQkNqQ=
X-Google-Smtp-Source: AGHT+IGnl1pfRruM1HkbfEQSAAN/qBj7jRZF6p29u1V71EYrrXf5i6Ra4bM2ngNTx1led/Ivx9L6pg==
X-Received: by 2002:a05:6e02:1c21:b0:39f:325f:78e6 with SMTP id e9e14a558f8ab-3a2767e058fmr3541685ab.0.1727285956068;
        Wed, 25 Sep 2024 10:39:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a1a5713b0bsm12141285ab.53.2024.09.25.10.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 10:39:15 -0700 (PDT)
Message-ID: <5b44612e-7526-416d-b9f5-d2e7d0896f05@linuxfoundation.org>
Date: Wed, 25 Sep 2024 11:39:14 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clone3: clone3_cap_checkpoint_restore: remove unused
 MAX_PID_NS_LEVEL macro
To: Christian Brauner <brauner@kernel.org>,
 Ba Jing <bajing@cmss.chinamobile.com>
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240903033628.10306-1-bajing@cmss.chinamobile.com>
 <20240925-dackel-chatbot-0a01df1e0d6e@brauner>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240925-dackel-chatbot-0a01df1e0d6e@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/24 02:34, Christian Brauner wrote:
> On Tue, Sep 03, 2024 at 11:36:28AM GMT, Ba Jing wrote:
>> The macro MAX_PID_NS_LEVEL is never referenced in the code, so remove it.
>>
>> Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
>> ---
> 
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Quick note to say that I will apply the patch after the
merge window closes.

thanks,
-- Shuah

