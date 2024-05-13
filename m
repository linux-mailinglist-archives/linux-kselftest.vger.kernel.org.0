Return-Path: <linux-kselftest+bounces-10145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F7B8C45D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 19:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2CB01F24D9A
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 17:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4921CFB9;
	Mon, 13 May 2024 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PXQC96iq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443B020310
	for <linux-kselftest@vger.kernel.org>; Mon, 13 May 2024 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620549; cv=none; b=Jb4gmxOOR2UnBaTAlvlgIYOENjQ7DeapfVfoXHaUCBtUlbcOjqFgLzWKtjhoJ8we/NfxAuzTVJkZ+cYy3C9zoQTWJS+uzHhqJJiVC7Oa/CKKaKkeKoUX2dx75OGlV7ZKsDMLwgXllPcIAj/KhXsT620dZa6YFJE3b7/niHuEtMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620549; c=relaxed/simple;
	bh=Kpqsl0XSnFWNY3VT/3iCR1YsNFUYLpITGe1YGMB5gWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K29psEfDfAW81prG7kMglMiGLENdRRWh6ipuUm0iz451AZcwg776aCL8FbejXvxY0HV8OrAGeMp/QbyyQZNZ9MOdJPJGi7cix4fORw4t5AjarQXdTL6AEZQ+OW19l7mg3Epf1SipoSq1bXYWQNSiEp7kzt8m3kjnAP2+O2Oj6vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PXQC96iq; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7e195fd1d8eso40989639f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 May 2024 10:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715620547; x=1716225347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dkhS35s9f4IrzQ+xDWVyzbK3FS+T/wMMOlTPXDBz7SM=;
        b=PXQC96iqmBFhpewiiaLtUIx131w4X7zkSiQZxwfApKEPDJEQEtsPPmCIcvbdbP2wYa
         us10KJPxTokfHPdI9HRhhdpBvIDR2uQo5FP6rhS6lZHpf9YqMIy4B+DsJubBXBC55R1v
         tgI34GZ7lmdKolCGMIlKVzmuaG/JIWgkUJwtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715620547; x=1716225347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkhS35s9f4IrzQ+xDWVyzbK3FS+T/wMMOlTPXDBz7SM=;
        b=TIJOO645JDAjBQi0Pox7ox3WP0JP+fXhiH7+2qKcpxWLmBVrXPb4oZH3f3Wq5f1HjO
         DuD05GtJXEV6Lz7u108WnFDag94p0PBxiYKYHfP7fSRCvKrtjI+xvjy2tjSKNb6vp5x3
         zdiOaIvBR1nEpMCFrJ6OH316TxROPp51RwVy205zl4DpOpdxbgIccggIRW28M3HZCDpX
         UV8KYyo/6okYQfKs5ddQF9UpXAByjnzp6/DYHJBFN2GYF6uPgzd1GLyTir36Lfw5rRaY
         2WEKUWc3ub4i//71TgTMsCLniNTHtWcJSppW5wepUK//YeRj6Pt2CWp/v9rM1KNbVIQU
         y3sw==
X-Forwarded-Encrypted: i=1; AJvYcCVoD0sGIC+/+y1stKa0hy1CIOTo34h25FPtpy1Db2fqGWTOCoJBpV1ELzIdqBH1Oz5vc93CZBxK8b15PUmrG/zgkokg2hX5PNgMZ+IXnPEk
X-Gm-Message-State: AOJu0YxwAe/5IpxHtDlI+rElYmCkZRwi8LEexftwJ5wILI2aVyTnRHzw
	fbgqFLIkfX0ux98vBmEkxlVbb++xR0E9FfV+uRTcAeKkOTO0pGAG0Wm8Wuv8XHo=
X-Google-Smtp-Source: AGHT+IEsUUvesNSzDOZXBVwOpH/mJvxScDlUqihZEzqBcc1/za2BRTRLILpTeNLwc1aaK6xtRTtPOg==
X-Received: by 2002:a6b:5007:0:b0:7de:b4dc:9b8f with SMTP id ca18e2360f4ac-7e1b5238e16mr1143476539f.2.1715620547263;
        Mon, 13 May 2024 10:15:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4893714d92esm2559667173.75.2024.05.13.10.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 10:15:46 -0700 (PDT)
Message-ID: <6016b316-d266-48cf-aca9-127c72f9681b@linuxfoundation.org>
Date: Mon, 13 May 2024 11:15:45 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Kselftest fixes for v6.9
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
 Brendan Higgins <brendanhiggins@google.com>,
 Christian Brauner <brauner@kernel.org>, David Gow <davidgow@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
 Kees Cook <keescook@chromium.org>, Mark Brown <broonie@kernel.org>,
 Ron Economos <re@w6rz.net>, Ronald Warsow <rwarsow@gmx.de>,
 Sasha Levin <sashal@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Shengyu Li <shengyu.li.evgeny@gmail.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Will Drewry <wad@chromium.org>,
 kernel test robot <oliver.sang@intel.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
 shuah <shuah@kernel.org>
References: <20240512105657.931466-1-mic@digikod.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240512105657.931466-1-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/12/24 04:56, Mickaël Salaün wrote:
> Hi Linus,
> 
> Without reply from Shuah, and given the importance of these fixes [1], here is
> a PR to fix Kselftest (broken since v6.9-rc1) for at least KVM, pidfd, and
> Landlock.  I cannot test against all kselftests though.  This has been in
> linux-next since the beginning of this week, and so far only one issue has been
> reported [2] and fixed [3].
> 
> Feel free to take this PR if you see fit.

Thank you - I totally missed the emails about sending these up for 6.9 :(

I see that these are already in Linux 6.9

thanks,
-- Shuah


