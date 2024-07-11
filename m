Return-Path: <linux-kselftest+bounces-13617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4544B92EFA7
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 21:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C4C1C21001
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 19:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BFB16EB79;
	Thu, 11 Jul 2024 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Feq61t24"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB051C14
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720726239; cv=none; b=GLupKssrKOps7MzRZkS8tBVHluHe/7qnUktNGsS3vs8WCqRknyLW4TPdng/OtkflrCqj/CW82sTCQ9A2JD/YiOm/8E0Zaafw7vLfpkzsejlOsm75zVJ9TsyDQ10tmIj6Yy63dFbozxDF7dkM22ZOeN78wu1pseH54CH0WJRURRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720726239; c=relaxed/simple;
	bh=jIq9DB4+HfVVvk3niKjex6l7F/Vrr+uaMChFa8uTTmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gIBqc4YeRpWG0U9a0KXH1JnzywQKSalHBtCyIaY2u/YfrLkmN/HA6DwizZ/BDga4nxWr1M9+T7bBgNgn2D9EGSgKfvWUURY1P1Gpd50CKtLid4TQKBnEVZjT398BoCkM9F9pXzp1+R6v8xJh149aHTiBnkU3HK9EOsLbD/vmRvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Feq61t24; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-38252b3a90eso748065ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 12:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720726235; x=1721331035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jIq9DB4+HfVVvk3niKjex6l7F/Vrr+uaMChFa8uTTmA=;
        b=Feq61t24WTab4I8n5jOVQA6xUi/85OMzabYwywzU+El922r++Bi85Hy+g0ko9Dt9Zd
         ICrGVxt1yuFK7kqDldNGOWgKrFHGyNYxgDIrZiJwhIfRGIdtf+4p+Y0DnZ6P1R7DlZi4
         mJoUD52LiK5yj+cgZ2lY9b4TQ4bBqOlUL8vQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720726235; x=1721331035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIq9DB4+HfVVvk3niKjex6l7F/Vrr+uaMChFa8uTTmA=;
        b=MNbyJ4SkS5+nmVoU2Nn7KGWvb8wG39h4oRiGBJWqlwF4CRildXQs5OmphreGdxBUA0
         vB9RWyNZuQiSU+5/LDLU9iSeq2h7JvQUUuX/OlpG8tP92TnXwIJKmz6v/GiLiF6Mb9J4
         0Wi/WmbmL18z5PXBMiDNt2tvz/N4gOr+pACUcAjoHALW2jTHGnBmplhirQ1mefZ4q1VK
         6/Z85M9QQY/AaJRI0w9dJsmdFi3K6IvTQNhGnNb80LhRiE6KULGVYUBBL2Vb/v63CdCc
         rRVJf2UOvmJFXWwaI545RwMpe5mv/F0Mn3G3fj5dppjfRQ95N7oGAwuTsZdjISyBT9V/
         nuLA==
X-Forwarded-Encrypted: i=1; AJvYcCUS6v9eD0m3lTZeue7PPzSVNaBMiQA0lEQKFij3Uhjiy6fZDukphBX8bFAUqjDXGSRkorqD4GLkTJmy+olz27iMPJbeNp5u+NiDRKhXV7p0
X-Gm-Message-State: AOJu0YwQVq4Jy7WS1ZNkJDwaFW0sDaJ4E4YqUfMwdDc5JBL9YRwQoJTX
	oXRSM/MrqRz4yrZvgRo0woXeqLqZSpWyKdL3oGtxNaFYSldQnM6fyzUH54g+UCgLW3HX2e9IiYv
	2
X-Google-Smtp-Source: AGHT+IEuugBUOtbPCwdOAl0sTv1M6tMnWa1RAQa6RETYXBN+nLRRupftab2+A8OSzisRPDSDiUOOgg==
X-Received: by 2002:a05:6602:8d1:b0:7f9:90c5:4107 with SMTP id ca18e2360f4ac-806e190589dmr373773739f.1.1720726235641;
        Thu, 11 Jul 2024 12:30:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7ffea7571cdsm204809539f.32.2024.07.11.12.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 12:30:35 -0700 (PDT)
Message-ID: <fffc4793-e2ff-4e90-96b0-b37e02848bec@linuxfoundation.org>
Date: Thu, 11 Jul 2024 13:30:34 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] add tests to verify IFS (In Field Scan) driver
 functionality
To: "Joseph, Jithu" <jithu.joseph@intel.com>,
 Pengfei Xu <pengfei.xu@intel.com>, shuah@kernel.org,
 linux-kselftest <linux-kselftest@vger.kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ashok.raj@intel.com,
 sathyanarayanan.kuppuswamy@intel.com, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1717137348.git.pengfei.xu@intel.com>
 <097e26f1-bf30-43ab-a65b-25a3062f92d5@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <097e26f1-bf30-43ab-a65b-25a3062f92d5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 19:42, Joseph, Jithu wrote:
> Acked-by: Jithu Joseph<jithu.joseph@intel.com>

Applied to linux-kselftest next for Linux 6.11-rc1.

thanks,
-- Shuah

