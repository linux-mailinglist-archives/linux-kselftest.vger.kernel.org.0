Return-Path: <linux-kselftest+bounces-16397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E48960B87
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 15:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005721C2284D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 13:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E981C4611;
	Tue, 27 Aug 2024 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PUpm4MfD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1821BD015
	for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2024 13:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764366; cv=none; b=oI/+h3v9gDTB8KdZdGS18FeDPq/Im85nZSK7Kpd9YG1II6gn+lkihT3Yc7sVjOI6CVE60SrM4l4/Or2e4q5uybuh/2NdH9dKhE9F5SL1NHmocLJIHk3IaIcmRNiA+uUPTUXldTfHQ5yE1yTypsVTWYV+Dxc5xbJ7wubpDQot9T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764366; c=relaxed/simple;
	bh=rQgRDesIzQklWac5GhvVr+62VbJaDtwUWCUo2+Vke8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LOiLF4EXAABfUI15Zc8e3LLUbf7lx7lwm17y8wuxzeDGyv30fetE2p980+zr8aOC7+S1YoUvB5tqFoiaP2XPGkWcDI/bbrgNzQbC/0da5a435dKBjudWN3N6WK3ZHP/R6E6Jy2924/qXlmNiJq1eDBFWYhGCEGNUxJwWWBXk2+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PUpm4MfD; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20231aa8908so43240845ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2024 06:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724764363; x=1725369163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Tl3rkwR3GbnvJ9cLIypxJvHDjBIdx+vsvF7+3hzGM0=;
        b=PUpm4MfDV1CBf6jFMd6xbgGHyO70En/DsX1xiC+NGe9msh70yqU2uGP/Gn3YjaBhfO
         bcYbc5bChF7aiY2uWmfKNJ3oUjc8sW/L98H6NARgCzd6znyK75n17XmsYWygR7hsflDc
         FW1NcdPRbWD4CuAhQkoYcfUY1QgD01X4y1e0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724764363; x=1725369163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Tl3rkwR3GbnvJ9cLIypxJvHDjBIdx+vsvF7+3hzGM0=;
        b=fNQ4WFlZtdnmppCBFI47NCbpNO4XstI5ZPFyuZsFiZas4+2mKqgBXkWcmXHxzduaQg
         RIwbnQPNnmyAiHq8GD5rEs3K2L4Xh0wfSkJKTH5oyAixqZ3kMhnNs15KZwQMNNjKZ8k0
         FjeqqaB8tSYbGa2IqSdoHS/1P8HS/bmxYL9WARJtwEIFR3Iu2vfk1MhL8G5UslMZ7bZx
         NAZVO/8bsSNYSrknlLSqM/hAi2vuSMJtwAcw/GrADMwb0JBCXhK+k/7ZIXagDNFmdOCN
         LOY/C85tpBSQpP5AFUEMLFsP+JtFOa+gn/5zEuKSRgnT65q9HpxPPkV8t1a54So/ZdUO
         9pgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeipGPrfZIWi28u1Fs09kePFazsWKnSZ3lGrfIQjpZz6Vn1bgO0kX801uYp27dgrttPkD/Z3MFmwuJIwvbyUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+KvsdXkBO5816SaU+UKNZmV1G0u8xR7dNASIrpvmXy+giUyYi
	pyOJxs+4eXElwz717qhyMdvuwt6JJhA3YORQB0De+I9pWoJy3BcgsmnZcCQaR5k=
X-Google-Smtp-Source: AGHT+IHAx1s797kwqvCGuNuI5cLAo0Hep/rE3ZJzRytOFCbJKRUUyMxJ4P5a0TixYSM0XX9xk5JgUw==
X-Received: by 2002:a17:902:dac1:b0:1ff:4967:66b with SMTP id d9443c01a7336-204df4fb9d1mr29261145ad.56.1724764362701;
        Tue, 27 Aug 2024 06:12:42 -0700 (PDT)
Received: from [192.168.121.153] ([218.49.71.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560faddsm83234345ad.231.2024.08.27.06.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 06:12:42 -0700 (PDT)
Message-ID: <f9e2d443-9d20-498a-a2d7-fa2e13fbb3f9@linuxfoundation.org>
Date: Tue, 27 Aug 2024 07:12:35 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/vDSO: support DT_GNU_HASH
To: Xi Ruoyao <xry111@xry111.site>, Fangrui Song <maskray@google.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240815032614.2747224-1-maskray@google.com>
 <29c04b2f2b35588824447f4c91d3c89ed3ed8895.camel@xry111.site>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <29c04b2f2b35588824447f4c91d3c89ed3ed8895.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/24 00:07, Xi Ruoyao wrote:
> On Wed, 2024-08-14 at 20:26 -0700, Fangrui Song wrote:
>> glibc added support for DT_GNU_HASH in 2006 and DT_HASH has been
>> obsoleted for more than one decade in many Linux distributions.
>>
>> Many vDSOs support DT_GNU_HASH. This patch adds selftests support.
>>
>> Signed-off-by: Fangrui Song <maskray@google.com>
>> ---
> 
> Ping.
> 
> Some context: I'd change LoongArch vDSO to use the toolchain default
> instead of forcing DT_HASH (note that LoongArch is launched decades
> after all major distros switched to DT_GNU_HASH), but without the
> selftest support we'll lose test coverage.
> 
> And now ARM64 has already lost test coverage after commit 48f6430505c0.
> 

I am seeing several checkpatch errors - please fix them and send me v2.

thanks,
-- Shuah


