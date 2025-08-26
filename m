Return-Path: <linux-kselftest+bounces-40014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AC1B37585
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 01:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A16361B83
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 23:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C338D306D23;
	Tue, 26 Aug 2025 23:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekvOFKnw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AE91F2382;
	Tue, 26 Aug 2025 23:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756250875; cv=none; b=JK+4ZNa89bHv7k7GdaaSpgIFL+lEb3oUJ1gLe7kwl1z8RoIZs3Nwx+UYjaW7GVQIju8Xo1WH/JwyRTz5tMXKz/fI7ic6R5ixVwGx4Kp6wB6hGWLyUH4v3m6GjXTHb0vt0wRdrIjtQhkCIPAsIPVMG3cBTELupU0W30sO4D27s9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756250875; c=relaxed/simple;
	bh=wdIrdmDtaKWvwCJ/h5jxYxaIY80EUwKpqVrqQ89G3v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nTmNuTNAxwxGmEXf6YZqfBAwvrDrQ1CaU5Ou0YI0P2ZMyyDT4YdfCXiVaZ7kbAPQfU9zGDzFWBHtSPiK71QLUzXlhoc11aPH+T3LSygy2Cww9J+OKAfIT42BEgLyWkz2Qb43d3h9csBycU2LAdawwFS0ayzJBPc+9Q9ImaNa+WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekvOFKnw; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b474d0f1d5eso4091357a12.2;
        Tue, 26 Aug 2025 16:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756250874; x=1756855674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CD6yjiZ5YQJ32PGJlfbxDHcsoHAZgjFnPcceDJ4tFUI=;
        b=ekvOFKnwklzT0uiyMg/JAkuSExlp5IIjjpZqPQsVPjzYJeTJCcwHg8crND991BscAE
         JttgLwR0EuOjg9U2gbhaxWhp7V5h5a8/a+18uaEiISDS8OWseCscYqpDqnfGGPWybqeJ
         HC5LbA2hHWjsYKWd1Avevwh9jzWL0YSZ+t/tvpY9CFq/zsHQLkCvX48rjaluXRCDVP5x
         HrfMHar3uJukapHVp4RLX+bFSYv/MU7p+V/AXGU8Rp7EQniNdjJY4sMupHz8tYLZlpFh
         fwnHXrB53MYmj7EHluDMKZQRRGStYzQFJc8eC8EnlN61WNq9NcE6+rm6xUbYnSj2ofTL
         38qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756250874; x=1756855674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CD6yjiZ5YQJ32PGJlfbxDHcsoHAZgjFnPcceDJ4tFUI=;
        b=vKp6IHKKlHb7rub9cTEkaijJjk/ew/A8tjKm3Lri68qEkaSzLWaXYV+0uV8I/h0hR7
         QiZXwin8KRDKT7CxWJV8sMzHfygrVFDv05He7LyVvGYjNfzlEMoyEnBmuR09Fn71u8LA
         /DQ69k0BRDfbGbEAcKLpI8t13XW4RfwBEniuCQ+HNilJCbWmHHOTHtOfUmhZUHp0DPpn
         8yhyb70cD60oNSFEPLziLC7LgvNDNrlYnT2/RT7CybgMJ9CGuXoLdfMT0xVZatFDZLeE
         2KaLtvQReM3sSXoK6qxXh4dFIh+uSnXPPIR5nIlGL13f5fsu6PdYb1F8OnUnfhR+cpeE
         xAew==
X-Forwarded-Encrypted: i=1; AJvYcCVVghGgai0KosR4crvSulKxL7vLpoTOJ7lf88eA0/sgfGZimuDH14RcgUIfiLYm/bjPE6n2FD9dAA+TK+4DpMuU@vger.kernel.org, AJvYcCWSI1XLrmV2IX+CSG9qeS7WPN8OSZov2UzxSsmRRJoU4wmXWi2Dxmr15MvnoXmk/ph2wN5Rnrbful850Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWVTAEPYntGt42cQcA8p1RU7bpzWBmiYNXJLcANtUyRyvJGdDL
	s9hJ4k2QT3OAucrhtxgPHGoXdRr7fgWLkbgK5FNdXM+EzhzW7poHkwTV
X-Gm-Gg: ASbGncuADhE5bMLc1s0aWG44xkiCcayfd1h76wvugAXD8si57zwp/3uuGE1Lpw0kL9b
	t4tY99gCiVHjGgFtTc/TRy55A1ntruuC1X1sQa+hXV9Ue8tsM+0LusCcTLgDIy/O90M+a3tcbzb
	68itR3fwsZxmzhP1x+aHpzJLU05EQgTaEgnOXdglEAqeGsT8sFJgsPUPZjpHZ/x5rA8Aez9qnqZ
	eHVT28XTEEtuv3Agdj5sjfJdyzy5wT8XP0Xko2ALOxTzna3foyGVoaXIoOw3R3abDW0W2ysSokk
	9VpUSm4XQRfeBoPNg0dWXBoPQ9h9eengYc/y5582/peZnLv6zULpArlWmsgJTLSLd2bnHtVTELI
	XpoRUMP2B39QPGKkyXRF8cx2T0cefumZfgWxIJJhS
X-Google-Smtp-Source: AGHT+IFz/KMAhS4Oimu584tu9uMR736OqQJnjQoNKaXTHKg/3q21BZIuq4aoQ7AMNj16dNs+Rbxpmg==
X-Received: by 2002:a17:903:4b03:b0:246:cfc4:9a27 with SMTP id d9443c01a7336-246cfc49fefmr102960175ad.13.1756250873707;
        Tue, 26 Aug 2025 16:27:53 -0700 (PDT)
Received: from [192.168.0.150] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466885efc8sm105526725ad.90.2025.08.26.16.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 16:27:53 -0700 (PDT)
Message-ID: <3b1a2ea1-4456-4f65-91f3-fcf070eeac98@gmail.com>
Date: Wed, 27 Aug 2025 06:27:47 +0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/arm64: Fix grammatical error in string
 literals
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>, Markus.Elfring@web.de,
 broonie@kernel.org
Cc: shuah@kernel.org, will@kernel.org, mark.rutland@arm.com,
 ebiggers@google.com, catalin.marinas@arm.com, martin.petersen@oracle.com,
 ardb@kernel.org, thiago.bauermann@linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
References: <20250826214913.866695-1-zlatistiv@gmail.com>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20250826214913.866695-1-zlatistiv@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/25 04:49, Nikola Z. Ivanov wrote:
> Fix grammatical error in <past tense verb> + <infinitive>
> construct related to memory allocation checks.
> In essence change "Failed to allocated" to "Failed to allocate".
> 

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

