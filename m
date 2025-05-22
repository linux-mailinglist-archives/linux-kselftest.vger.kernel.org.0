Return-Path: <linux-kselftest+bounces-33520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5B7AC15EC
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 23:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33672504078
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 21:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEBB2561DC;
	Thu, 22 May 2025 21:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TI2FVpyq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66AF2561C7
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 21:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747949685; cv=none; b=OIZyUo5YIhHDhzKW5wgn4sPcNoOSeKgRGaR+K+r+LF6T5d/VgSe2rGl0/9bY7pmrKkk+hieFeWWh8pUqdBe/Ecd9+C+jww0tUPUevkYr+5MArXIpbLDbeQ2Df5p9QJ86W7TdHBuSuVV7IUX7sq4d1DeoIS74wIMZOEeOjilUNoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747949685; c=relaxed/simple;
	bh=iRQUTgCIeubytT0qtFvRjqRz5zs34jvhAMACa9briho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HN4bvPHBxIlozk2aaDXor2v/Pt2VYiCZQjdIO8ffgXgi3XQKOy2/phXOGoOD1uLDE/ZBE/8fafc/CIKw0hcCm38EyXH+3lIh/yD9oEJ5X1gmf+1K45ULS7gsoStwPIaxK2lMIhsjTpTzFlVkZOCf9F+LJlNvQ2ESbWAgZn1hVtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TI2FVpyq; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85dac9729c3so820565439f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 14:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747949683; x=1748554483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iRQUTgCIeubytT0qtFvRjqRz5zs34jvhAMACa9briho=;
        b=TI2FVpyqDSqgLMKq8oTkz4Kg6klAwcwc8azd87h38LVkUznJDTokZOFCls/bdFWJ5p
         dHwZocQM2hVhvk57iEwI2h++XlYn1SzYFY+lvITFG+JE5ki7eiahPXHPAJzdv/A6qpsr
         ndmFzA8juEFVcn7MqOj7YZ0/xEuLeiBml2m2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747949683; x=1748554483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iRQUTgCIeubytT0qtFvRjqRz5zs34jvhAMACa9briho=;
        b=ftIqNfAdtq0ENFVtvoTT17QWOz7kdIPQsGtbeZun3LraA8a6FGvY7bejhkssZffQqX
         uI5oZxziM/0bpDwVgjfGvw7NQG10bAYTImoJAULz8vfEcat+YyjN5q5zMUvhJwhA8KyB
         HgjvtDtDJ+U0gIzMSIuCT9XXYRORP7ZoUsCCE3PsDzsWoMoeZgrcSkJ0l8l2c0oepibw
         cLeT257/CAc6JD0uzutY2Ewgr9Nu/4960lmjR+GjkYbIsQ74DwjJ7sLLYY7AZxnppnd7
         AFZNZw5FeMfTSmobDdqCOIlqZHxx6cgowf6frgkcqnbv0wvF2bR6c09NCBYP+cANBPEy
         4h4g==
X-Forwarded-Encrypted: i=1; AJvYcCWTu6Xo26QOoqL3FWUFcn1YGBkv1hp61LN3NiXUAzTKY5dWPa3EsZ5RATD9sA0QJ8pLXcrRDVqdok4lFlsI3JA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOmWC3OEmrZih6Vpfz5ZhyTOjWqP9V2mrHuBBbGYwYsZFA+XGk
	aflLHjQtJ4Rt7mDQ6PHmeRp90XUpFUWMk6KlYfb+axbPZFdbKAq9OVDmMFVqEBwOfo4=
X-Gm-Gg: ASbGncu0cbTVCbFXYgOloJiH6SKA5cjzO9DTnKoS0ZtgMlYkas/u8+RenatrBA1RZpi
	AXcylMsjIyllhed5m5/mkPpurcWibFYNY1BwSg+B6M4ePqpa2J+uYKgAIBjpprwdNSVfdu6Ge+s
	wxdgHea3Y+4KLhZXNWzu8gyNZ0PieoO/n1uNrFXmroFSms2mSk+86tmFzYTfyzqp8SolJL9m1xz
	LHZY7lfa3tRm8cj2stwRlZaRr7oLGDNrLNQLe2VJzNjEi0QJjqUKe5UVyOTroqg5YRQyjxmLI+V
	HrqAYM355Za0iav2yuUoiCM1J5hBXSFdSlgm6YJe/ZkLPRBr690pOtUUkRgzkQ==
X-Google-Smtp-Source: AGHT+IFOP2EK9yyZB7cTqFwEeuUmHdSfOrY/lJgHKzpzyGNmW3X83mfZIE6QNHvPYOhd2PwPrc1cKQ==
X-Received: by 2002:a05:6602:7284:b0:86a:26c8:4ba0 with SMTP id ca18e2360f4ac-86a26c84ca2mr3518244939f.8.1747949682930;
        Thu, 22 May 2025 14:34:42 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc4afb56sm3342642173.117.2025.05.22.14.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 14:34:42 -0700 (PDT)
Message-ID: <7e386efb-8f7b-4bc0-9ccf-784ddbdcce78@linuxfoundation.org>
Date: Thu, 22 May 2025 15:34:41 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: fix "memebers" typo in
 filesystems/mount-notify
To: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Cc: linux-kernel-mentees@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250513144816.72566-1-hendrik.hamerlinck@hammernet.be>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250513144816.72566-1-hendrik.hamerlinck@hammernet.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/25 08:48, Hendrik Hamerlinck wrote:
> Corrects a spelling mistake "memebers" instead of "members" in
> tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c

Change the shortlog to indicate test clearly. Check a few logs
for this file for examples. Here is how the correct format looks
like:

selftests: filesystems: fix "memebers" typo in mount-notify

SZend v2 with this correction.

thanks,
-- Shuah

