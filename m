Return-Path: <linux-kselftest+bounces-11208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9DC8FB79A
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 17:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572C42828C9
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 15:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE27144313;
	Tue,  4 Jun 2024 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YxOtYfy9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1F6143C7B
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Jun 2024 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515620; cv=none; b=niWCwWetZU39ZpjfLPVUayLFT0toBXlLk/CyMmGqfNMwO3lvA6IPeaQbuksu8bM+BNYrxHy3oRZ6s0iH1JXklW0uAsHDPO0SY7PqdVaX5/jPRYt4/25YffLRSkZiSXLxIpg3M1Hn351qm5ADwNp73ekGX25W9A9rkQHpAC1Nwbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515620; c=relaxed/simple;
	bh=lr2PSSnQhT89h9G86Va6lFxZmi+30HqkLtMjm5chdfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmF1zHpZgAxbU4yfhmNWejOOO2c8LOjw1muPWqBDtdsSIzhRa17timdFCFgjXqwyGLzgCahwlgpi9HABt2vOmWni3yRoQl4mDDV8DXaxVEFHC6uil0fimm5lC3YOSPgg2M5F/1XFRAaJkmFCnfQpoa2glR0KRQq4duHCKPYnJ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YxOtYfy9; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7eb13445630so6864339f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jun 2024 08:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717515618; x=1718120418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6fB5FPvvwrr4NT7PeRI8WmiMb5Wg2ojKwwSpmWCxqT8=;
        b=YxOtYfy9UzI3WJ0Hohjj4eAI03mEwVVQc+qYObMdzNibes08pchVrCJoUxGs5jwFmv
         2yqH3tPI9oSQ4X9YINd5cvCr3Cg+0d+Loz/lICaQsH0HhgxLH+zB76xFHEJeJbVDpjKt
         XOwIsPh6KKK1OSLIWggIY5KQfFfIskx3sn8Xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717515618; x=1718120418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fB5FPvvwrr4NT7PeRI8WmiMb5Wg2ojKwwSpmWCxqT8=;
        b=IcfcoRy8gBn5yR2TK2MVLyjzzEQCUpgI8cYE+mqCLzCW+L70882bzha4fnJIDB9LZc
         RwjxdGcw7OLlLpkcWVN2sBv8zok+qwEsozyefNla+I0exzqBx7Zt+rnrPhVh8ZtHVQqA
         PYoF9bnzIclpuhMgzsEONrnOG9iicS63B/ZdBcCUaKpt2SW+ZINZ6gZDt2KoohV7IWF5
         3UAs6mnLtJd6me5Jpow7lWMInvions1nh/jfXUUNASkngEZbKOknbQ1LFmuzxteKoQzU
         KTpRWBcuAIoI7vvFNcaLYXeTh585/gZZzJ9huL2hOo7GQxB1JLq+gPJfeaGR/K6Nph01
         yn7A==
X-Forwarded-Encrypted: i=1; AJvYcCUQtTRnqWVKgk3l2dh+APiH90asBNt7AvmwfGdtiCTgk9uo7NqhcgfwBPVDErjJZdFH8+v3Iwj3unurUHs7IfkSm0j5gpqLxyAt3XxTJBxc
X-Gm-Message-State: AOJu0YyNFWa75cjFi4sKi2Wbks1yXNIFN64zcGJX5pvgupZ2b9GtUASe
	lKnkBRpUHvfRbp+CR6uQB5ez474IEyRTvRojOcR4FoAtfYcVgFT5vGNyyZUD5RoFN0r2Lbdgm8j
	+
X-Google-Smtp-Source: AGHT+IEsuA1KzjXAGIUmi/gwaj8vFDQCmvfkYKihQMeOVh00VlDkzSx0bCO8bpePXWgcQcxuRdyLIQ==
X-Received: by 2002:a05:6602:2c83:b0:7e1:8829:51f6 with SMTP id ca18e2360f4ac-7eb29fe8544mr339203939f.1.1717515617743;
        Tue, 04 Jun 2024 08:40:17 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b5c41fe2f1sm1219570173.83.2024.06.04.08.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 08:40:17 -0700 (PDT)
Message-ID: <931b7b17-9abe-4e3f-8df1-76c38367b372@linuxfoundation.org>
Date: Tue, 4 Jun 2024 09:40:16 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Kselftest fixes for Linux 6.10-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: shuah <shuah@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <f32f0c51-f11d-421f-95c2-1a9e94be1a32@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <f32f0c51-f11d-421f-95c2-1a9e94be1a32@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/24 09:37, Shuah Khan wrote:
> Hi Linus,
> 
> Please pull this urgent kselftest fixes update for Linux 6.10-rc3.

Sorry for the copy and paste "urgent" - this is a normal fixes PR.

thanks,
-- Shuah

