Return-Path: <linux-kselftest+bounces-25504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B341A24791
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 08:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18BB73A43B6
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 07:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C37D1369AE;
	Sat,  1 Feb 2025 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="PjMpia/v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F9E2B9A9;
	Sat,  1 Feb 2025 07:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738395775; cv=pass; b=BsZstDZt+i7IjXMZuYNETplk88Cx0tkm/J9tYr19tH7EGekCtAET3BKrInSElFi/YN7X8/7EBUkMaZjpRgWExHT1aH8wMZBtAZpCxDMenW6lIwSC+tcBDgRpz+BaJXZLl3BBBvkY27iqAU31ty1NMvxi55yPMWP0ZNPZ8ehP6P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738395775; c=relaxed/simple;
	bh=PHOPVwnqYW4RAVoAd1OAGy78FLHlJaiUTin9zJkj5kI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PTuSx5dhW/QStgTDDCIXD89kFT+ZPB3ikL4aoxa9DvaxHtJe558TFOLS1xtDNUuZY2FD1w3uE2hjvrkpaU8QiLZKlCVDy0Y+2YoIhFa8SUa6ZBfzdJOV2PNmDpi5pXjUZmxOmBzOkAQNFXc/xh6XAnomtd74idI8WDygYT5fdyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=PjMpia/v; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1738395755; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fnhtczJxfrullL1L0M2O5tVnX5aYmJoqPIqGaOEc2+ngT7LN3515fbaDT/OWFdIWk8drkrjQHjimE5i8LkTEURWZlrhyWCVe4mHob7c7lonao0HpS/V40HzE6xX8b94iHW0ePXFeH6P2io0TZ4wFixJPAUksA+CFE8hYi+ReaLc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738395755; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CLZpf6rLwx+y6XYMMSXn85igrf6sEjyPZMUtVYwyThE=; 
	b=TkW8wXB4zHB8iObuuCAUp5TgO44xn1rpkQNPMN0AJHt2H4Xk3JoUsetatO2QXPti1KcUZpZxw2mFFqxtUXsq7oINheiR4TIrfklrfcCho1M+bPZtiXUnuVrn2zZ0VX0ffG4juXQ5q+hG5qgEddxt/VpwtcMvqfYjF7lNthhgRIw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738395755;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=CLZpf6rLwx+y6XYMMSXn85igrf6sEjyPZMUtVYwyThE=;
	b=PjMpia/vELd4fiEUbx1qLHup05g6ekUMhmoUqu+HnTnZBvxnhpQzYfb8XM6U0+8D
	nWFLTDk5JWkjmufhgWBprHBR33ME6y9kjE60GksFLTHR3+o/rVu6zCyGen4IivWncl0
	kWtUxNZWR3ID7JIwZiFRJDqGeb8m3MvpMfDI+cWs=
Received: by mx.zohomail.com with SMTPS id 1738395751055390.58881136718696;
	Fri, 31 Jan 2025 23:42:31 -0800 (PST)
Message-ID: <0a769233-8cdf-4bee-ba6a-3b69767b7d43@collabora.com>
Date: Sat, 1 Feb 2025 12:43:03 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel@collabora.com
Subject: Re: [PATCH 01/16] selftests/mm: remove argc and argv unused
 parameters
To: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>
References: <20250109173842.1142376-1-usama.anjum@collabora.com>
 <20250109173842.1142376-2-usama.anjum@collabora.com>
 <202501090941.5289E7444B@keescook>
 <843bf743-4005-47bc-9e39-8ea49255b152@collabora.com>
 <202501090949.793D9A0@keescook>
 <20250109161246.f43a69773b5459e5200d3f45@linux-foundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20250109161246.f43a69773b5459e5200d3f45@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 1/10/25 5:12 AM, Andrew Morton wrote:
> On Thu, 9 Jan 2025 09:50:45 -0800 Kees Cook <kees@kernel.org> wrote:
> 
>> On Thu, Jan 09, 2025 at 10:48:52PM +0500, Muhammad Usama Anjum wrote:
>>> For the all other case, why should we keep argv/argc and mark them unused
>>> as well when they aren't being used?
>>
>> I'm fine either way, but my personal code style instinct is to keep the
>> "standard" main declaration with argc/argv present. But it's mostly
>> aesthetic.
>>
>> And if you think use of kselftest.h isn't universal, then perhaps we can
>> avoid the macro, but it does seem nicer and more "normal" feeling for
>> the rest of kernel development.
>>
> 
> Agreed.  __attribute__((unused)) is a bit of a mouthful and isn't what
> the kernel developer's eye expects to see.  
In the next version, I'll add a macro and use that.

-- 
BR,
Muhammad Usama Anjum

