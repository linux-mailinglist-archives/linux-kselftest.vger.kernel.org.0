Return-Path: <linux-kselftest+bounces-33519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED343AC15E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 23:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A911C01E19
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 21:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F63255E32;
	Thu, 22 May 2025 21:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fJ+J2BaH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A699E255E2C
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 21:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747949311; cv=none; b=XfzDIVMFzdSICrXeqNkThxvmSCxp8DIwWibCWcCrcSRd1YiWl88PNi+Pvht+un2lkv6riGZlWNrQzgutvREStLmZ2/M4NaMMu9OdeTUune1N3JNokmS+8PCrSvaHCcmTgtTMa89QR3ig3sZglFRUnYv9kkSc0qDeAVf0Z0oWe9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747949311; c=relaxed/simple;
	bh=/3i3XuRZg+WgD4lBkNEg7daHyxIphtAN1whMYN62VPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qeFEjKZGUndoi9hJC1Z7vWmRuwOBKc9gGROymJlP82QR/Cqqlt+aUroQkhOHyyP5ilSVhUTwDquPFHj7f/4v6ejovg6+fs/j7LcyYkudyTbcRzjoW7KyS0b/33iIoSnBp7Y26ZuyqmmCcHqZC2PSuDVVgiIwIbmp8tzER8LC/MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fJ+J2BaH; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3dc6945e109so42853015ab.2
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 14:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747949309; x=1748554109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qkmIHtfMnVb0OkhxNQzMO6VwTacuz37IKDgT32/56vk=;
        b=fJ+J2BaHLi1anKW6089+oFiI+A0K8Zi2dSQOwFYhTAeScowGrwfMIneoFXI75uPEFm
         glcpik0FSRzMRv0a4uiW83dCYT+elzOB641UQAKmHqIL9Dk3kSV7uZTNDuH2pjezenjo
         I2/CY4gUBBI2cjjlCuXDtELY57uzXZaS0fHfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747949309; x=1748554109;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkmIHtfMnVb0OkhxNQzMO6VwTacuz37IKDgT32/56vk=;
        b=qpxiKp5tna2drJm3+GOCmMXLnz9kIoEBJsNw5qLIKtJWy1KI9ewSYkelur3zzlCQJx
         vqzxDD4lprQZJOukC80MQ8hezDPID2YNaM5A1gkdEcUbtOrYAwkXBZujn4I+4iIb2L+4
         5qzP+W3M/vFFkVH1CpvC7qPEn+ofNy36wcsvIyXiWmF+yCygS7AxfFSPSVeIxb2VlE1q
         ZnCBCEd53LWXeRdbiIPc60RRdnW7jEU6msNvZaLHqLlVxTnTvEdTeRHuQkjtiqgV+SfO
         VpnKU/M0FybT+g+aEkU4ydAZ/s0EQHOaRhylM23//XZ//JPmJ0TueKxKCF2yIqOsRIJK
         D0uw==
X-Gm-Message-State: AOJu0Yy6hS053pv4eKj7isLitaTExY5vHeB/NDgzOTODxLhdrIRqykdl
	b50tZV0k/9LuloaW83sG4UIeU7ByrjvEgs+rJUK6jmVC+neyWeIbIyaCvVso9xP3KCA=
X-Gm-Gg: ASbGnctJS+bzJlPtPd2spCWOSEhVNyMS8emRP1pHg4DJXPxLERU3U7TpiMxM82wQOa7
	4R/3FIg8MmQ6HaHUO0EO71zYfNSaUB0lAKZNM8KuFYq26ucu4ogi4gWX8RzcE3dztoKf22lp+g/
	mhuPqfq68Eho5gs4HQLuHG166NdwXKaensf4BymDv69yQXcXfGiDjNNBvfh3+AW487CkQoPNn4Z
	cMLr3NFB8UfeXrJ6Qk7FL0UG/j5YJJvkb6g8z8Xrgaae8ViGCbrmUwD7gXvmJqrH2QPcEMsZ4Zc
	bQ2dIRodMq8LN6s1qjvSCOtPZP1vWzgjpNKYJFszhKxq7AQG1YLp5LBd2vrEBA==
X-Google-Smtp-Source: AGHT+IHyaPHiavUTnU4czHTaa170yh7eUCpbUqQItARmDudC6XGc7IhtFIet5dGLyhekBpGy0GLYdg==
X-Received: by 2002:a05:6e02:1a0c:b0:3dc:79e5:e6a3 with SMTP id e9e14a558f8ab-3dc932480bamr8922555ab.4.1747949308838;
        Thu, 22 May 2025 14:28:28 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc7ffeb8a2sm12969655ab.39.2025.05.22.14.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 14:28:28 -0700 (PDT)
Message-ID: <65743e71-fc2c-4a04-b7f1-b977031a4fb8@linuxfoundation.org>
Date: Thu, 22 May 2025 15:28:27 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: ir_decoder: Convert header comment to proper
 multi-line block
To: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>, shuah@Kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20250513223242.304716-1-Abdelrahmanfekry375@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250513223242.304716-1-Abdelrahmanfekry375@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/25 16:32, Abdelrahman Fekry wrote:
> The test file for the IR decoder used single-line  comments at the top
> to document its purpose and licensing, which is inconsistent with the style
> used throughout the Linux kernel.
> 
> in this patch i converted the file header to a proper multi-line comment block
> (/*) that aligns with standard kernel practices. This improves
> readability, consistency across selftests, and ensures the license and
> documentation are clearly visible in a familiar format.
> 
> No functional changes have been made.
> 
> Signed-off-by: Abdelrahman Fekry <Abdelrahmanfekry375@gmail.com>

Did you run checkpatch on this patch? I am seeing

CHECK: From:/Signed-off-by: email comments mismatch: 'From: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>' != 'Signed-off-by: Abdelrahman Fekry <Abdelrahmanfekry375@gmail.com>'

Fix these as well.

ERROR: trailing whitespace
#136: FILE: tools/testing/selftests/ir/ir_loopback.c:3:
+ * $

ERROR: trailing whitespace
#137: FILE: tools/testing/selftests/ir/ir_loopback.c:4:
+ * Selftest for IR decoder $

Please fix it and send v2.

thanks,
-- Shuah

