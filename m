Return-Path: <linux-kselftest+bounces-9422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BAD8BB3C0
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 21:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D598D1C2399C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 19:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165A8157A5A;
	Fri,  3 May 2024 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bnHUGaJV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9785D155320
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714763580; cv=none; b=G6YyeXx0jjRnFNfZU/WZYyHKBspPCNGcN9JthS5/X/SAjem2RXpDonANvEUhdouL1SmzyaiNaTUBd6D2NihBbhfuWOMTNPKo25ijHPzvQdpOdp3da1iXwfAjZbsZ91eHbXF374bG9fYx2ePDUu+DMoyDoIaRl4bVqbI9+4w8LM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714763580; c=relaxed/simple;
	bh=IKLI/Q78RF9vVx/YNe7wLdlLEK7x6bEXRB/vPUdT3wY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=on2KTKa/8v+8LqTlnX5lGuhkptqCHNXffk7Y/KSMKUP/yWZ46XbyPm6GYTscYJssLfqm/ArcgA2nFtwvdmqyRn9YFpo2RILPuvR3vgVZS9q7Y7+7N9+Yb2OHgfghmjFskgW2Ixz+mP9joLsX5l4Mgk6PVCfohmpflMKTWMIcbXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bnHUGaJV; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7decb824727so95439f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 03 May 2024 12:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714763578; x=1715368378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oRFjxSyK4Qq5KgEaM3tSc2tgl3ftVperAuW9pNscAzY=;
        b=bnHUGaJVArx1zjnPAlmtMbJ5EWx0tlMBSikRG0iuwjx43AsFkgAedIu4K/ircfIrhS
         jmxy61DK+oCLTONNDU2hpkmcqsDE/DPvtaGIQNDmLxjHX1+VHZ7MvPVr6kb3KURU82Pz
         OXxwdF4vuXNEuPglkGWcoLC0pS6RhRY4KlDv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714763578; x=1715368378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRFjxSyK4Qq5KgEaM3tSc2tgl3ftVperAuW9pNscAzY=;
        b=wxBx+RBBM6OUJpS7f508Kq5l27ONVOewAqL+UYAUhK8M/8+ThQyC2YVEFQqHE9DHwy
         GMVm/gzdtylo8dc3PsFPMrM38vYCSt6hPAIpeUXaXC0kMxf/XIUNMTM6SJN3V2C+ew03
         1/UbzlB+LpmY19iRIKtoLBT8V3BbwChJcrGqZawb2Tdv9RbGi80hPE8DGWPcB4jDenqF
         cNOooQbcdiH34pJZfVLChBF3MlZxoGF7ehMKj3/A1eFPXGrjuBTu7ohnsX98RitBEJZU
         XXCoUgBsMJk3BEC6jEccymwITFG1ku1uxm559smc/zAj+NYumkP7NOEeieIV6bk3CJJj
         eLow==
X-Forwarded-Encrypted: i=1; AJvYcCUNr5yYKdetb2zpnjMeWNPryGlXxd8GnG7RnNigl4TCEU7AZD/XzGRtUZi1Af+it0vciZxSQ6zJkZqb/Ie4jnLQIDSnc0sO7nbKiS+vSftI
X-Gm-Message-State: AOJu0YytKk7eXFs5lgeWTl/Fwx6L8inir+JR+Ja4X59b2petWTdUtbL/
	viOKXZFWmSiUF4FAXEgjBwpEZmRefVeiOY1iEFbhgOCkE48LBVsKXDwK3Do7eF8=
X-Google-Smtp-Source: AGHT+IFeCr1sXlKuk6y/+HaEO2vkq/lW4xsCt4vEoT13BLeE623tRhqnA0qvoG5XspHJUW7YimhDEg==
X-Received: by 2002:a5d:860e:0:b0:7d9:eeb8:ddeb with SMTP id f14-20020a5d860e000000b007d9eeb8ddebmr3581267iol.2.1714763577683;
        Fri, 03 May 2024 12:12:57 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id g6-20020a056602150600b007deeb2d7c4csm786391iow.12.2024.05.03.12.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 12:12:57 -0700 (PDT)
Message-ID: <5bdb08a2-0740-4ea0-be24-a948332d60ac@linuxfoundation.org>
Date: Fri, 3 May 2024 13:12:56 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 5/5] ring-buffer/selftest: Add ring-buffer mapping
 test
To: Vincent Donnefort <vdonnefort@google.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com,
 rdunlap@infradead.org, rppt@kernel.org, david@redhat.com,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240430111354.637356-1-vdonnefort@google.com>
 <20240430111354.637356-6-vdonnefort@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240430111354.637356-6-vdonnefort@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 05:13, Vincent Donnefort wrote:
> This test maps a ring-buffer and validate the meta-page after reset and
> after emitting few events.
> 

Changelog needs to be imperative - refer to the following:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Update the change log and describe what the test does and include
test output.

If the test requires root privileges - make sure add a check to skip
when a normal use runs the test.

The rest looks good.

thanks,
-- Shuah

