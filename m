Return-Path: <linux-kselftest+bounces-5081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2770E85CB49
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 23:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4DC1F22AC0
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 22:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C94154443;
	Tue, 20 Feb 2024 22:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gj1c8hCc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C0D154425
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 22:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469956; cv=none; b=kpFyXd3Iwd+WMN9S5AA44TR6xWDXMEgkTODcV9taHvxj0m1YLUod2yJQYZW8K1IusOPB1bXUPNLdxAjrkdqB6AfH1sILAIUhSzI5byJGpI8n4B/AfAJ9u9TmrGK4IcWavQOFZFL/KDP3Ap+li2heBcsXberXun1go7OjV9uWcxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469956; c=relaxed/simple;
	bh=r0q7C3BTXQWVoAF7et7PmO58LjUv8JMMw/dJkBUXwvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KBTXPEz5V/E3aCGiLHp5ABZVkREByn1wQoOcQZY5wfZObNsN+amrNnS7mpJik3Ndq1NxAbgHI2gZcAZua29bxYMBfZ52brRUhhldFfj7fRHbrtanIPsNFJlms6GNOtQmiK2jcXeGWQkF8M7drHIBQRYbyth+AGFV8/CMwr3McUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gj1c8hCc; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso93587039f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 14:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708469953; x=1709074753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8K9aXU3q/65GO6Sm64RSpJezMgpW/RCj7oX3cxUfRkg=;
        b=Gj1c8hCcYSd4okPF+vUnyV3bJ5FryzBylMcTH5n6+MGQiBOxOc5VTjkpqZ+ex1Vido
         3AtQ4Kxvgt7naVBRIagjV+wMsve3jGBnMHsYEUHhUClCGshddZSvK77PD+Y0NJpn8s6t
         d0ntAoMmVCHB4qfFwbnniFSXMuKyzVHxhIf/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708469953; x=1709074753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8K9aXU3q/65GO6Sm64RSpJezMgpW/RCj7oX3cxUfRkg=;
        b=IYZ/srp/OuQfYL+tefMDYk7HWE3F/WQtBQMyBUcbDbeXdJuOr5sS5OAjkD9ej2STYo
         yaEvopyrD8dBymmZoQyLdg8djdo4NPS6nSSWBIrvlVfMWI2o+KONjY/1tuX8XZlwL/ni
         xuRaaE2+N/Kp7+otSZz7SzUycv8U31rBtphkCUT+6SClIr1Qd2cHNSVj6HCzRGKAXFqH
         SXD+1BRQfkLR0Iu8bmM9MsmBWOuqjgPEUQd7rJoH/wE82bmt6K08GQEmO5LAbwSudWfk
         kUqx4K9rOZ5m51G9C51+l7SWBrTb93XcucJgSdcYWKBPtUqy00KsPwjvilhW0FZ/In7h
         uC/w==
X-Forwarded-Encrypted: i=1; AJvYcCUioQ6uupHU15Mg8MCf01TlL+/CrMMLTWo+mORPWnVR0iHwelouIv+4hTrBEVWLk2kUZhqjPgoM3kKP+1fWxA+rRGwmd5MY54uNVv3BAgvW
X-Gm-Message-State: AOJu0YyxduS9iUOkjjnwJWojYXMhDpPGiGFcz6mSPqYxjMWT7ES65UJo
	ZqpdBMzCJJ4moMLIxbJxaEMVtoIDcRrdH2hvB9F/X+VI/a+8Ru6r12nwznyf/DE=
X-Google-Smtp-Source: AGHT+IHZpeFeP6L7Ans4kMahbW2XFNoZzvvWR3gSQCybe4GM0oe5Uc1SPG4SLL1RTSnn2zX+eOQezw==
X-Received: by 2002:a05:6602:2cd6:b0:7c4:9e06:b9c8 with SMTP id j22-20020a0566022cd600b007c49e06b9c8mr15482650iow.2.1708469953307;
        Tue, 20 Feb 2024 14:59:13 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id b7-20020a5edc07000000b007c45ab3dc34sm2483821iok.29.2024.02.20.14.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 14:59:12 -0800 (PST)
Message-ID: <cbd29a01-d8db-4052-9d95-1e5357b0c10a@linuxfoundation.org>
Date: Tue, 20 Feb 2024 15:59:11 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: Move KTAP bash helpers to selftests common
 folder
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Laura Nao <laura.nao@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240102141528.169947-1-laura.nao@collabora.com>
 <5b14aa28-a239-4204-a8ce-8d37f19b724b@notapiano>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <5b14aa28-a239-4204-a8ce-8d37f19b724b@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/12/24 08:01, Nícolas F. R. A. Prado wrote:
> On Tue, Jan 02, 2024 at 03:15:28PM +0100, Laura Nao wrote:
>> Move bash helpers for outputting in KTAP format to the common selftests
>> folder. This allows kselftests other than the dt one to source the file
>> and make use of the helper functions.
>> Define pass, fail and skip codes in the same file too.
>>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>> ---
> 
> Hi Shuah, any thoughts on this patch?
> 
> It's gotten Rob's ack, so I take this will be merged through your tree.
> 
> Thanks,
> Nícolas

Applied to next for Linux 6.9-rc1

thanks,
-- Shuah

