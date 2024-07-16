Return-Path: <linux-kselftest+bounces-13818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C1293340F
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 00:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A401F23DF3
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 22:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AA46F2F8;
	Tue, 16 Jul 2024 22:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HQdn3nir"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A580E1DFDE
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2024 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721167283; cv=none; b=Vtwwy+/piOMTY6mzgCh6/zcaelw0+FV1Zw/seoS+J/7c+dpG+45+OnqpeNqRTk9g5YSU1DOZr1ZJx7y4iBSfhLSZgQfQp3K8zb0L2e4GVatP9VjjH+6F0n64VnQkg3YBLL/fzJkBzaOTpUnlPao+jEsGpagXHxDCLeT51nzGzk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721167283; c=relaxed/simple;
	bh=HLsso6sPpwAqcJD+ovzh5+MRcgBp2g+CSGjySevHyUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLg537SuBAlBfU2RmXjE/WmlpnSMy5AW+NopEFAvYX4qqfGOBMZKBUHe6hfzNtL3Bj6w5SsujoL3/UcibXFEmbCZd+Q9WHI/wU5H0h1YVfm06DLWJr7jKM4mt+ybQ+BDdZ+s5m59AGJbrFe376doXmJIBVUinvsCfJtyxj7ta5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HQdn3nir; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8084f783737so734839f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2024 15:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721167281; x=1721772081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x5PSRoU/ZGPblxfU6VHJxaVA+2xtD5DSTjqNF2ZXUTU=;
        b=HQdn3nirBSjN4dma3Uhtk5G4O6gEFR/HHrolN1wM7M+AuqqXrVBVhmIZtys3bRGBN6
         TitX0qWAyPYsC/laPb9Mw4nORHaF2XanmblZ26O4LVyvHGxoYq+hNg8x9+KQlyjKYtEM
         ccMrl+QbWPuqYCeiltqAtM/LlgIokphiJMEkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721167281; x=1721772081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5PSRoU/ZGPblxfU6VHJxaVA+2xtD5DSTjqNF2ZXUTU=;
        b=AgzjoDW0WxNZhEOsmR9AMn6LRnq5nDOukziLled4KaEiwzm9pPRuaw2JHd4I0+fU0b
         mbSev1Ld4R9XS3lNRqSO57zZA8vWXzvHaN0gj9THCwv4iZtxaFZJJjvg6f5y02O29Su5
         beCv11xNnnjncWTNdwB3lzUTaXOcYxpKgwnA/M0Zqh8U0yi7u9mJz+VfV0JZUJBJjU4M
         8HHVClwnx9Y3itfrUk40C6ONHX1RDP12QpbT05ai4T4IOKe3j3sE1OZmJRvchjaRFUAD
         aNPNpcD/qMSqVF0SDughQQtcUldjqeWmYWAh3SSXvc9PMTFvOoke1KAsRp5EUjcHvVPc
         i8hA==
X-Forwarded-Encrypted: i=1; AJvYcCV1ioSxxEmOV8aiXQSxxEljGWLx0v0aMuc6cEgf+8N+EMuB299LdAGT8a52FbxNG2rv3wQof5d6pkZY3MvQ8B4qwUANYCzZtLgPqY4W3dLg
X-Gm-Message-State: AOJu0YxUjfjL8cvHWdA6ylacCrnRzQhdU0glWe5d3wEc6ioL44ZKf5HN
	Qfs4wuOHPw4JlFu4SCKY+pawfGJfP5kg0kVYCwPdbOoUzkUqi8W/j7FpR/6Xov4=
X-Google-Smtp-Source: AGHT+IHcHBUREm0r2e2Ncbofi5LeKrZTXUCyGAPYMl85VtPnN8mq+O9egmVzjIyLGJqKAfAKB1BY9A==
X-Received: by 2002:a5e:c916:0:b0:80a:4582:be31 with SMTP id ca18e2360f4ac-816c5698730mr48773639f.3.1721167280736;
        Tue, 16 Jul 2024 15:01:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-816c18b9397sm18021739f.17.2024.07.16.15.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 15:01:20 -0700 (PDT)
Message-ID: <11c8d108-8635-4c57-b76a-8dc4a9c908af@linuxfoundation.org>
Date: Tue, 16 Jul 2024 16:01:19 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests: x86: vdso_restorer: Return correct exit
 statuses
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, "Chang S . Bae" <chang.seok.bae@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240712073045.110014-1-usama.anjum@collabora.com>
 <20240712073045.110014-2-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240712073045.110014-2-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/12/24 01:30, Muhammad Usama Anjum wrote:
> Return correct exit status, KSFT_SKIP if the pre-conditions aren't met.
> Return KSFT_FAIL if error occurs. Use ksft_finished() which will
> compmare the total planned tests with passed tests to return the exit
> value.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Same comment - here. Include before and after output to show
how this change improves the report.

thanks,
-- Shuah


