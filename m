Return-Path: <linux-kselftest+bounces-46019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B08C71368
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 23:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6CFC534887A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 22:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1992D2398;
	Wed, 19 Nov 2025 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CvrFfAgF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5C230C353
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 22:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763589693; cv=none; b=PNZQG5eX2Y64VDgL4fPcK/QkGKOb3yTihsPw7t78cXWatTrG77iV+pOCAHMZex8b5DmjxD0ALOvSgxhqXAWc6Sy5eujmm3H8FQoD3D3Q4wGjXE76txJD2G5fefRXBSOs6Yxnx5S9jST0dkygFZgyxArqclaFb0vFFjz04VLYY+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763589693; c=relaxed/simple;
	bh=sTNM+eetDMLzbtcPH15QRyjwnHthvPaDJDP7T+PXblM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+eQrqlOrunPlIeazyVGzNvzserTgqSvaep5s4oNcmro96RnaBEcrJbEwM37/KAOL2Mxqqqs14/O+WWT5YlxE+4PpB+PPM6l88mBb2Zh/o67eZN10ClxeSbYb3ZCfCxrBc7k+lPJWHi5uu5NvbjNgn8eC96tXV9GZxG2bYyJ3hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CvrFfAgF; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-94903ea3766so8258939f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 14:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1763589690; x=1764194490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7GN49LcihNJnWa0tgk2hlbtspHwfpuAFqeIds4vxqiA=;
        b=CvrFfAgF5P27JWqzgxI02cgmjngUtdZ49MulFgKyd3jtKBdoLsddngcDqgIY4Ksrmn
         wGPIbJWsGZ6wh2cY9iqG1zJVtES4sG+9Kmxs1Q1JbPC6sEPChJRh0KHzfln6nD/3sPKc
         5yPgWzcn942ERxhIabn4BJQIBBRUpE26Mu/H0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763589690; x=1764194490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7GN49LcihNJnWa0tgk2hlbtspHwfpuAFqeIds4vxqiA=;
        b=UEPOy1q+TPck7PgEyjB5hrH4MWgGBsYNK3K1uahW979JB3icOgEY9N4jsM1v1QyZpZ
         fQDAybErVHbbjck1hvWBOQP+yUrrUvML6JeTvkNTZpEQh9Gi2AWPj4mTS5nD+ck7PuOw
         rI8BCOlxG9oJivxV9lQ9v4nWuQVpT3ZBXh0cVOXzogYjzT7NBgCUFmt67Arndg2T3w4L
         AhcbekL/pR/BWrUWXFPmVNSVU6LWZ2hOPEWdf+b07gkIopPUkR/mDDPCGUNzmvHIue9A
         vc6NUkCIy5mPISSTf7lcn2kqUdIvQL09dKqhDveF8FPGixwB1PSMKjNUetw+UIQSqfPF
         OekQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvZq52TmVkRFkDiY/DwD890Pu4rCojNKZ1UBIkszgz+zyBOerLctkaJNJlyqbuXCgSrywZ85kTZMLRwgkkBU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDzF1qC7PBtAdYM3mn2/1q0XhxVBGF4YKppy3FXLgfFb3prX73
	gO7Zov2phqV+cu1nzaVyh6sUpxv5P5IkNSPUcnJ8r1yNh+IL131biTHSWji3U6f6NEY=
X-Gm-Gg: ASbGncsfzknCMaANEJXJtW7l64T3QWJ6T8S8uDtazRKvbOvtdvwbQOTcd7cP8KO6dzl
	AzPp0//0rqvDMg52lz/BFv49eXBnc++JUiNwLoZRsLS9948Q/mlB/UnQswBDAmJBAfQ84vrQTNp
	DaBMK1MUJ1YK/mCZcJpEK8r1wlVqIXztBGGaZHK4Q50O4GE4Zio5m0nCRpXYio5XlxPvRyF9Glk
	NLD0+hygAxSehzjLDW+1UypxPQ5tquGDfv6RuGTu0AMO8WWFwa+jzPPfPlrLs63iFvMaiQ/pM3A
	hg9RhQy1BOkLT5zlbvfmhjtEzZi8qYYHeZRs5Za2lN2hgxYR92xo6JrkiAVTcHB2Ve/IUNvj38n
	aX3qln5LM+j0rGP308R+E3M7KT/XNzTG3rZIaktqlABOZo20abI1T+LdNNXLuif7na11fKgkNpR
	XVkn5QnP0fMkTfJF43KydAXHh2aNCkl2LjXIp82HOzt1pd
X-Google-Smtp-Source: AGHT+IFTYmi0TaiIruPAD2rhSBWx11UXKJJX+It5AR6pod5m2drICz0clb+z4wjxNh6cCM0jB/HWhg==
X-Received: by 2002:a05:6602:6c1a:b0:948:a3ca:15c1 with SMTP id ca18e2360f4ac-94938a1b82bmr63975139f.3.1763589690176;
        Wed, 19 Nov 2025 14:01:30 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94938651ce7sm23675539f.10.2025.11.19.14.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 14:01:28 -0800 (PST)
Message-ID: <74d8f1bc-e2e0-4c14-b0b2-b1d9380a5b95@linuxfoundation.org>
Date: Wed, 19 Nov 2025 15:01:27 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3] selftests/run_kselftest.sh: exit with error if
 tests fail
To: Brendan Jackman <jackmanb@google.com>, Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251111-b4-ksft-error-on-fail-v3-1-0951a51135f6@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251111-b4-ksft-error-on-fail-v3-1-0951a51135f6@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/25 10:36, Brendan Jackman wrote:
> Parsing KTAP is quite an inconvenience, but most of the time the thing
> you really want to know is "did anything fail"?
> 
> Let's give the user the his information without them needing
> to parse anything.
> 
> Because of the use of subshells and namespaces, this needs to be
> communicated via a file. Just write arbitrary data into the file and
> treat non-empty content as a signal that something failed.
> 
> In case any user depends on the current behaviour, such as running this
> from a script with `set -e` and parsing the result for failures
> afterwards, add a flag they can set to get the old behaviour, namely
> --no-error-on-fail.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Applied to linux-kselftest next for Linux 6.19-rc1

thanks,
-- Shuah

