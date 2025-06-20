Return-Path: <linux-kselftest+bounces-35406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF789AE143C
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 08:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F8B3A312B
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 06:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EED22422B;
	Fri, 20 Jun 2025 06:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hls2bosp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AC72040BF
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 06:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750402307; cv=none; b=YJXMTvWNmJv7fVWXavl5BS7EbjlaKdSWdI1euEB2wiFbUe5wOQk6K0iyofJbryomRbm4IGZgI/uvXvRjSFyFWeAWD88jgamvCTX3m9jYqV0aubKcExFCoMEMXuDjRF2Boytiz19xiMHu95K3VXhLLfxC6v0j1xm4mpOB/R9vtgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750402307; c=relaxed/simple;
	bh=BnSXezCzb70mrzCDwRenvVQ1YA1/sh9RGYZ4O1/yyHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1f16GDU3I2etsxvSxvEsEJPrPUybGTWGBdDbGtdW6HsneJ7R2XUmX5unCF8xs+avGbdPSRIFheTSWqpc/h5RgBeNgn7IwEla/Wr382SIp5G3l6MUsmFQ55A/ql0xgpla4FLXGjy9I8WzotOrjyzx3XIQ382+PnPf8EKieVBbUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hls2bosp; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-acb5ec407b1so248702466b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Jun 2025 23:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750402303; x=1751007103; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MzuCQhj04F7EsQPLz/pJI7rgwfA3iOfw6Jfbk2TjFXg=;
        b=Hls2bospF3hrZNdkrCPka3OnEWm9rnmd09Db1XodoKkDVV3FCQxSedLxz6/Wm6m6Gq
         OIlLX0+M19JkerOQoLuhztYAGSnGZg65ZDBUMtK5NJZ2Gnwg/HcSegwommq98YFygr8V
         D4mF6CDDEvG2lYins5Y5ped7vxXkCRyOccE4uGdfco8IMNQEqKWRweIBJ4ckBZsw8+eF
         D0UaOq/h1hZRGDY1a3b2XmINCWrnGSxYoUBE2aLmkmioXfYXwhTDSHaW69JUL92G91iE
         HAJjMvKtPFT1a1L5uYQEpJlvDUIVFhgFE6puCZOgoqGI0j5F2UUgH/O281NEFLw/OmEj
         YJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750402303; x=1751007103;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzuCQhj04F7EsQPLz/pJI7rgwfA3iOfw6Jfbk2TjFXg=;
        b=ZzMUf1KNMD2NuZUQ4vMcYh8dDAKrMu5YAsS/Mwd+so6spC277LjMYn5z+VxQ4zHsny
         0pjDh3oLgMhppVT4/0sbiao9CnjUojO2FClpzrFKJBIuRrT38FHw91QfN0v+ADFxXqhY
         5xuajToB/5KZ/zI9kplRfIpPxTWLAOxXD4vE1c0X42R4ziCLAXUlH3rF7WLjpOl8NtM2
         51AqdZg7sgM5cQscgm56L9g/5IYQYhJKcdlyO+U+THrgE+SpGn+t4Bqw7FZ1AnjRWFs0
         EHGbuvNBFoBiq1J9tDaTb1IS69LktKO5oVf28xent4wofjNLzQgK3YPYE6jQwkMO5Dfk
         jR1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuhaC8mEgjgaZ9ttCNHLI498dZT5Hlu7wZpI6tcHXtXGPmLQgXg6kAPoi+2JKdtvTNskKApG3METKz/eE9Bmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWB6E29XXmcQoGmoe3cGk4zNljjRFgdhjsfHZ2U9ykG7p7Vrql
	EYpPz8LV6+8PEP9psA2S5g1+fbvqnZhSSfiRTYncbLTmE9rhtXnZA0K6
X-Gm-Gg: ASbGnctekgWM+oDeKcl/Lqc2nDYfsROVULlKHdiPA+E+wQ8Z+fcQgyXwXlPbG275w+R
	pC3U2decZLlELskJyZwqSpP4k0fAqz/Go/p9Ok6j9Bhoj1Xchhe2jNV851M84fmY6i6CqECMwqj
	k2vBfW0/CzFZvj4ANFeskdxorbUTO48qBXDjiYOvmlbx47MnhULxYn2PFZnftXX/ifRW35zph7y
	kXz/xV2R8FMoQMJh/k37m5CpdIh1D0M1RVQreUV3YWScEEfqKeLSwgxGk6FWAj8yig3Tw+8Bfw+
	U2ace3IFMfjFxd/7PXdXMta8MFwOQMnL+YqE3iSYK9D/sG8bpJvhluF+FqZcyQ==
X-Google-Smtp-Source: AGHT+IGky/EgvfTynrdqEbuVbMho4lhI9hx/JuRvwM+Bjq1tNRzCyheanmU0+f+VzlLQXlRG9a4B5A==
X-Received: by 2002:a17:907:3e98:b0:adb:2bee:53c9 with SMTP id a640c23a62f3a-ae057927b19mr157760766b.3.1750402303151;
        Thu, 19 Jun 2025 23:51:43 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae054209ac4sm109068766b.169.2025.06.19.23.51.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jun 2025 23:51:42 -0700 (PDT)
Date: Fri, 20 Jun 2025 06:51:42 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Wei Yang <richard.weiyang@gmail.com>, kees@kernel.org,
	luto@amacapital.net, wad@chromium.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, usama.anjum@collabora.com
Subject: Re: [Patch v2 2/2] selftests: harness: Add kselftest harness
 selftest with variant
Message-ID: <20250620065142.7tnb4g5hd3k5mbqk@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250620032815.14543-1-richard.weiyang@gmail.com>
 <20250620032815.14543-3-richard.weiyang@gmail.com>
 <20250620080701-f81dc6cb-a1ca-4bef-9d96-1d692a320a50@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250620080701-f81dc6cb-a1ca-4bef-9d96-1d692a320a50@linutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Jun 20, 2025 at 08:07:46AM +0200, Thomas Weiﬂschuh wrote:
>On Fri, Jun 20, 2025 at 03:28:15AM +0000, Wei Yang wrote:
>> Each fixture could support variant. Add fixture with variant to verify
>> the behavior, so we can validate for further change.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
>
>Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
>

Thanks

>> ---
>> v2:
>>   * remove testpid
>>   * print value in teardown and test itself
>> ---
>>  .../kselftest_harness/harness-selftest.c      | 30 +++++++++++++++++++
>>  .../harness-selftest.expected                 | 20 ++++++++++---
>>  2 files changed, 46 insertions(+), 4 deletions(-)
>
><snip>

-- 
Wei Yang
Help you, Help me

