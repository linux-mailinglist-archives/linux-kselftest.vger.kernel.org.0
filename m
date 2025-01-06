Return-Path: <linux-kselftest+bounces-23937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BA0A02025
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 09:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6423A065F
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 08:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57A61D6DD8;
	Mon,  6 Jan 2025 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kOdvWxdy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A007635951
	for <linux-kselftest@vger.kernel.org>; Mon,  6 Jan 2025 08:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736150436; cv=none; b=JnySuYh3Au1Oi+/7fTNV7hJHqmgOdxubagOK+t4Nf3dB0a7V/ZQ8SqveDW0zl9ihwPs/9XErqxeQM5uPbUZcxJ8V/eBO9wjGSwcoHLhS/d+SHDX/5XJrHRFMweSICad63xnUTGwXo1679xeDBKKrs3ZG6FkSf5PqfL9XlIKbjCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736150436; c=relaxed/simple;
	bh=gAeGZSMYLcfFd5eqUoBDFOPuKLVGcg+e5EHxtXnZZu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mr/0xYGA7gqlyD79A0zOIOXZzKYFNk6/6I76cEm9jKo/W943TSE2R7jLwwfkJPTGvrZHkLjB3zZKOCXwBZjJsiFVosWYas06dK4YRJG6sWJHkt/kPaBaokpiVZ+mCsVZlTr3AKNh94XIv5FJ3t7KEceb9rJkqD+hkew4FSmS60E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kOdvWxdy; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4b11a110e4eso4010308137.1
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Jan 2025 00:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736150433; x=1736755233; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gAeGZSMYLcfFd5eqUoBDFOPuKLVGcg+e5EHxtXnZZu8=;
        b=kOdvWxdy1Z6Um6zLeFxoNh/LjC6mjoOMHzR/VsaJFDSVn+mV7yV7V8t7emP1y5duVJ
         871ns+v3Fm/8RnDAJeWJwZP5jg7mCSJGTId1MWQJtDIT4cSqRLNoNBlWlJ/GijuejYqE
         OaW3335Tf7L/kDHXJCuoEBMd3eynC2RwQbYLRPQ0umLPMlzklbE9gHsyv2TLVZi2mqid
         bjWX/CZCYL2QOm1+6C4uqHU1PkjyU/+kIk7TabxheythgE7VAp3YHcP2MTQ+VDoUoYj+
         DccltpbCqZf6i4eFavvNlD1AZQRMCcTwL1vXzSMp+HpuvuNj9dH+IjM+NVn8IZ1koqOh
         Oa8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736150433; x=1736755233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAeGZSMYLcfFd5eqUoBDFOPuKLVGcg+e5EHxtXnZZu8=;
        b=YW4LomUWHbZ4oUG12iWcrxC44tZKp+g/WasWfPhPXZBicZXK2GTpobowDX0NVmOlF9
         5IlTKEfh7LG54t5e90DsYl+Sc9TY8z7ytDMRinjrOG+l0FydSK8Mh5cZZrDZuAmKQLDJ
         AxYmHqulJ5R0YHp2oUVl7Mhl3T/6XqgQ8Giv0RIHosS2N828VTeBq+2EPsnTN4GE80bQ
         Rah2kwc6AHsGwhp1jxiDTL44wNpbgqcBEmdTD86RKVLWSorWu7UUj1T9zFg14Kj1L7ys
         CUq8QrVQfWs0HnNmtkaR0SrLRudMzh5OJun1O1OEF5unblFqm2dNFQSVLCARk0g112+p
         7ZJA==
X-Forwarded-Encrypted: i=1; AJvYcCVbO8JX77u561WL+z69EY+hpOjZJ+g6+q5xpWXswPT0EmV0Xqu9CxDWzbd21OyLiS1978XezQTfmZc0B/09hgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8banKDYM+z7d1wLiZ2HHVXTLdbroxPFYb4Xih9q4ZOISehs/T
	JDW/DypZ5Xb+U1xW2SxY3uv2XiH7xsny3nmaQsTIFbx2yWtxpysIEmFjF2pAr4f7F6po/Zek4TX
	h66nQHQVmhDlT9wnIxjiqszs7mpJa0rgO7tUQUg==
X-Gm-Gg: ASbGncuLDxW9au+LsGLTcjbqOLhDv0YRtAWX2m3Dtxn5JgTJyLujyi/s4XC8qEJrR0h
	9YtnuaWJmgEMpdXAQvUVoqxT4Su61lFvsxJW8iecTiQDU3i6pqt0l/mfVjykdOIUw02JxEhg=
X-Google-Smtp-Source: AGHT+IF5t6laefY9FyQIJEGUL/QYXkcea0huSM4/6LBPfIz34f6n9nzyrb6muxxEy23kpCDaKLmwJ/A/+aq0k6O/iLM=
X-Received: by 2002:a05:6102:548a:b0:4b1:1a9d:ecbc with SMTP id
 ada2fe7eead31-4b2cc45723emr46810675137.20.1736150433281; Mon, 06 Jan 2025
 00:00:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvM96LS63Wa1+5Md9w0V0JZgBW+f50kzx9RjRCYj3aDkA@mail.gmail.com>
 <Z3qVp1m8zKiMrtnd@lappy>
In-Reply-To: <Z3qVp1m8zKiMrtnd@lappy>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 6 Jan 2025 13:30:20 +0530
Message-ID: <CA+G9fYs=_-GD74k8pGCnA0uA0b1w3Ahxr+r7Bx75gYF2h13qow@mail.gmail.com>
Subject: Re: rust/kernel/lib.rs:17:12 : warning: the feature `new_uninit` has
 been stable since 1.82.0 and no longer requires an attribute to enable
To: Sasha Levin <sashal@kernel.org>
Cc: open list <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Jan 2025 at 19:52, Sasha Levin <sashal@kernel.org> wrote:
>
> I'm sorry, this is my bad: I haven't realized anyone else will be
> looking at these results...
>
> Naresh, I'm cheating and using this tree to bisect the issue you've
> originally reported in
> https://lore.kernel.org/all/CA+G9fYvcBvbabg+m7brKfpGCGZUcK+KHHTFX7hFvW6GmN2XF0g@mail.gmail.com/
> .

Thanks for providing the details of the issue that you are bisecting.

> It seems we can't get traction to get it fixes, so I'm trying to make
> forward progress.
>
> Please ignore linus-next for the next day or two :)

Alright !

- Naresh

