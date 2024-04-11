Return-Path: <linux-kselftest+bounces-7728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A368A209B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 23:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2537FB230E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 21:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C88117C72;
	Thu, 11 Apr 2024 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nyyylwaz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907293A8FF
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712869405; cv=none; b=bDzT3i31j/xLcto1d+vGN1MH2LEgUH27Dwtw3oZzyru0CZ9J4LL55O3CWfhr8cXbSVeUBT8NgOgwQZhTdhiwyVi0KP+1neTPIOTvs2Zzjq9/q3Y2aqjIGhjISqLF31NQprHBoAx3htoNzTl8pt9/QJRQvxhsv0QnKAspV1MkHTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712869405; c=relaxed/simple;
	bh=cStBAu9ZM4K010J4PEkSQ5RzVRGtWYK6r22iftBsmp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sVNf925UFC+IzRSknQfJCie30RoMvW8X9Fmxg6DapQp2Lx/zBotvkDlq1LWiiZ8YHvfySljeBSGgUkKoo3jPbRbVFhpDSBsZHzgdnkkfJWu73EZi9XQCettAebC5/EHnRV/rqsa0ZijznIzveq22BkEXf/l8Qlyuqm5QOQAq9nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nyyylwaz; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7cb9dd46babso2427739f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 14:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712869404; x=1713474204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XkXziOZcmJPH9DNxVUuT0LSvem2MocbN93rqFY23cGU=;
        b=Nyyylwaz4riSJ2tQ21lwjBWh0PcTdoBUTZ6Nha9UcWBoABFCkbKIRjVIg/cEXo+6rf
         UItFmW7sl44YWM360UmNYh3DXh4QgP7zQLjzDO79pAXqk0TYNuoyt6byT4YqIgbnitYi
         V6Hcntl3094b06yvF8sQuB8LnMpZ9TMqT/XXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712869404; x=1713474204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XkXziOZcmJPH9DNxVUuT0LSvem2MocbN93rqFY23cGU=;
        b=Y2lr3xuntabO4QaKKdUG7AEorSkI9eqKhysYcQNvMbhPxrqFBZehiaNKvz4AqYB6Ky
         2HNcZqAOw1M/iz0xeoNEwQU69ZRhIaoDuZet9+GGt6yRGehecPMRLRkGjocff2oGG2Ev
         mxG7e7pC9r172x1oNPEd3kjQLW6n8NABHI1tbDehzvMHjjeEO11ICMwRzI6orncBYZOq
         tFbvx1CSJOafcaFxT9jmlZdv6Ud7fIXNWN9SvzztjcqXe2OFE/2vwUj8bSjZSg6oZD1+
         SooVi+6diF1qlcD5seskkPw3VsbgXJTeGvEqHWWsHPb+4dJ5UCcPCEl1EuESz7nrVO1Y
         4Qbw==
X-Forwarded-Encrypted: i=1; AJvYcCVpVkibso0XlsMRBd1+26b2b4nrUf0wP2vM3jSUtssG2WeHBLMs2HBAd+aHdagVGkiC4LNCcA9AAO3tT967xSWjmZct0tzKc9ppRhXwUxdp
X-Gm-Message-State: AOJu0YxmUObdIyoPmcRqQOhTJkvh07BKjIPKW8s7Aqb4nzVibTzTEj42
	vw59ScCoShRk3/j2+oy3WMYYrvZYTK5Me2pRI3VP0yicxNMANd9DuD45SRuioJQ=
X-Google-Smtp-Source: AGHT+IH+SIjacB44Z2pTqGb+ewSPjLIOUQiuNIQihVZqvUDNwsuJRnB4hUTSv14qa8VHpfYHaF3LwA==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr985974iob.0.1712869403597;
        Thu, 11 Apr 2024 14:03:23 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id i17-20020a0566022c9100b007d02d49bc80sm607756iow.50.2024.04.11.14.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 14:03:23 -0700 (PDT)
Message-ID: <c70a1402-4664-4200-94a5-239c7bc37392@linuxfoundation.org>
Date: Thu, 11 Apr 2024 15:03:22 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/clone3: Check that the child exited cleanly
To: Mark Brown <broonie@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240409-kselftest-clone3-signal-v1-1-bbe49156171d@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240409-kselftest-clone3-signal-v1-1-bbe49156171d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/24 14:39, Mark Brown wrote:
> When the child exits during the clone3() selftest we use WEXITSTATUS() to
> get the exit status from the process without first checking WIFEXITED() to
> see if the result will be valid. This can lead to incorrect results, for
> example if the child exits due to signal. Add a WIFEXTED() check and report
> any non-standard exit as a failure, using EXIT_FAILURE as the exit status
> for call_clone3() since we otherwise report 0 or negative errnos.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/clone3/clone3.c | 5 +++++
>   1 file changed, 5 insertions(+)

Applied to linux-kselftest next for Linux 6.10-rc1.

thanks,
-- Shuah


