Return-Path: <linux-kselftest+bounces-21218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26F59B7C75
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 15:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE471C20C1C
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 14:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932831A0B00;
	Thu, 31 Oct 2024 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcHIgDM7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF97F1A0730;
	Thu, 31 Oct 2024 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383815; cv=none; b=uczM8OLmgiWsOjAc+n2gxywZlV0VR2XlKMM+sbv4Bx+HVLiVtEWWJfNb2O6zakBE5bBZd5fJcJesqz81ROp7YEfIAln58kFkZbc2Za4OJIBLwUgxQFIloNJM+Rqlr6K5TJMM4BqAjHEtlHMNHcjyWx1VsLjGuGeilhS7ktveQlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383815; c=relaxed/simple;
	bh=ZOirEjwoVyKsr9B7zI9+5sVH12vbyRc/ixY45nVUD1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lK/LvVwoAQE/XOL285UuNkBFHIiLpqqkWW7XUued6rWFSmkz270+E91Z29RSVmI1ZoXErkgSzpjOzNdFECMfgIglCZc6xgCzoyySzDq7tsGhS1pTIgK6TPcFhv2xI9G12XsLsvjmbW9sC8qcYbi13ThCAenHlHur9rAbCcwOKKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcHIgDM7; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-83ab94452a7so39173639f.3;
        Thu, 31 Oct 2024 07:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730383813; x=1730988613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fGapzIuvflb8DMomsECaOF4DzIXKNMU6ZtxGVo61eig=;
        b=BcHIgDM7dgDAv1C5NmCD9T77R/XAkryMFsv9/uRdYsAIzB453NsAjOymdkajBw7h1B
         MdPQnpum7APv5Zw23SV2kNfnI+9udoSu5iuI4bb+o5YY6vY5E5wFC1LxnN3jv0puhIb8
         JdyJMfxT0FRTCdwc4dRX6FC334eWmS2sNwvP5qD9xLrwqiFXw85rxAoLBoGGJnxOnYVJ
         kXRW08m9kiLUeLe4KNirnhCCONx8Gt7j5eZUvatFldPVk7AzKJeuWP4ED18WG5fs+PxO
         nZTaCf7MCIzDR/0d85eHkTlmOZm4Rm4hYNemr3eO4bXKv9Lw6AA8u7QPRu+XxEmFntdh
         7WCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730383813; x=1730988613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fGapzIuvflb8DMomsECaOF4DzIXKNMU6ZtxGVo61eig=;
        b=UDiDFla4rKGKpoaFx2H7u7ZXnKibvJITf0iuwptDn808w0FSafM+ZV3keoAPWdWBSt
         ExI1+7j44eUK3f+Fp1vY/AuWxmpEUs0R8RNmEZlCBLA9n1XbWdm/ycDwS6M+a4utjsnZ
         Ype/CeZREDR0yy4vcBTfv8BM2xyd+ZnS/e4vYHzMbUKo5OX0NqPZOk+aeD4+QsMC4Uni
         gHzmq9C1Alx4F2WplkzsPew9hbkhzuamEQrCi8b9yrR7ch6csrFXxQG1vuHpjlWJT7uW
         6a2JttX4Cka4zRJ3WXxYXVQvLVAvI7u8520XYPhxc0wjvImUgnHDDQAYHWobSsSuS53n
         IUgg==
X-Forwarded-Encrypted: i=1; AJvYcCW8Cjo7rWSRNcGYYR1IuzbuWRd8JPjp4ezbzzgm2VPL0k8AKzZmMXgrHxvOjTbZD4wwcY8mMdg21q2a4Rw=@vger.kernel.org, AJvYcCX3rZ6GdGv/m2ylUgUMBjrBQ85Pf9qsRhiMQwd0n6us8ogZHobdVCSbcPSQViTxW0p/5uV6golxaIytROkKb6r7@vger.kernel.org, AJvYcCXSn8dYOAoutDcARoMYze6sAIRiUuEI/ujZy8/qOSR5F1VzLlmqajiI3toMdrys5m8ms2M8VsGu@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx0DiVKBD/s3XBdxkrsXNm0SYbpP5yYMkwx/PQlcLZM834GrDk
	Y4H1sqEiq1naXtit0106wUC9pB0KQIMnLFzSvNz5ST5dCfl/yV3I
X-Google-Smtp-Source: AGHT+IGbgq1ksw8UcbLciUbszieiqw3+Qq2pAxekHHQzxo6i2O9Z7UYOH19oJAPum3hUsEqsFoqrDA==
X-Received: by 2002:a05:6602:1507:b0:82c:d67d:aa91 with SMTP id ca18e2360f4ac-83b566cc65dmr936862939f.1.1730383812577;
        Thu, 31 Oct 2024 07:10:12 -0700 (PDT)
Received: from ?IPV6:2601:284:8200:b700:1848:120e:c56:3740? ([2601:284:8200:b700:1848:120e:c56:3740])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4de04887facsm311707173.26.2024.10.31.07.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 07:10:11 -0700 (PDT)
Message-ID: <7ae73a73-fba4-4692-97df-1a88ccc5f576@gmail.com>
Date: Thu, 31 Oct 2024 08:10:10 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6] ipv6: Fix soft lockups in fib6_select_path under
 high next hop churn
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>,
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
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <0dc8c829-23f0-4904-8017-fc98c079f0ab@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/24 4:13 AM, Paolo Abeni wrote:
> Given the issue is long-standing, and the fix is somewhat invasive, I
> suggest steering this patch on net-next.
> 


FWIW, I think net-next is best.


