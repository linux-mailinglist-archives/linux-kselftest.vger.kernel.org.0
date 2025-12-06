Return-Path: <linux-kselftest+bounces-47227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C81E6CAACC6
	for <lists+linux-kselftest@lfdr.de>; Sat, 06 Dec 2025 20:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5C88305DCEC
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Dec 2025 19:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E7C308F09;
	Sat,  6 Dec 2025 19:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCoY0PYB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D083306B3E
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Dec 2025 19:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765048129; cv=none; b=OJ31El03mT0Ox0wlzZ0CDJdJYkSqSNj69T5lPJESybHS/ip9cDOx9pdp9aXT42U7mJQDyx3otVabYKmUnLEsnHMiX/GPaK+5iQAivEL8P23HaqRAaIhQdgtpHJWlHHn4l5l3YliyFOzPKQwnM+1vUsoZNRKQNVQQHHEISTklMoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765048129; c=relaxed/simple;
	bh=8rPLUiSMR6jNqrMWDI98SoRQ6npj211eN0e+rCVU5VA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=uIbvvY9245ZmJLHGN2QxAdJgOeVQ8FHT1+g6gYxzdZIeZbaOd/D1P7Ls1UKFUtqrENt8aDXZxd57I1wtQnF/BNnc7VirPnA+XZRxWMnbJwylD+HPIilyWElbFEpwkFlfLEZdXyrELpx13x3t9kIVt4GrHx4sGVNtc8y5ByLXK3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCoY0PYB; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-bfe88eeaa65so368264a12.1
        for <linux-kselftest@vger.kernel.org>; Sat, 06 Dec 2025 11:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765048124; x=1765652924; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ACAohf4F25nEnHvOaICZ6leuXhQFymhleOh1uLhJ+M8=;
        b=BCoY0PYBmazmp9QG2mWxEq1Q/C+aT2PzQJKmrDFW4rThW+CnS9XHHYq8H0f6UlAgcy
         vv5Nhur2T/vZ6vlvkTvcb9QjZBpTHaSX6K530eMUxNKmWbT323Gslz8Q8E963bpzN+/w
         15Sm1sE9B6XcT2r3gLzXIo6vNBspyzeleI2rEaWN62XEfAJavDIwzEjnE/7l/HG0TFGi
         O9a0ZfEtlnPIFs4HI8e3ojTskXdME0fSMOYFvBBtSQccwz9dayPEhoReBE6IoVbhafyR
         r9kc/qKPUoCknosgpEvF9qyL2lMM4S6rGElHY376ruZM452E5GZxNYHiQK9gD1awD08K
         zGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765048124; x=1765652924;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACAohf4F25nEnHvOaICZ6leuXhQFymhleOh1uLhJ+M8=;
        b=jrHKpPlqyWYZgXddkmxSRSJ2XQTN98YKC2GpDBoRSczXy+tQ/0ZOTC9aegY24MuJ2g
         QGc1Fip0+870vwJGkiCAzI0OSbdN/SUL20dW8VYTPCBuKtfYKUDQ8pfj1hsQU45L4Bnq
         Er/3l3ntvMe+nnRbQKvw1C8BTueEghmQ/fBD5rfOwnAq10FZql+71K+/RRuGqONPbmQ5
         96qDqUiCW/u/NdaIpE/qtwfR+JD7aHxdh7lNJWmoQf3540j1VclPF/GPqST+97Uj7S6a
         89ZmDlkD+fbBKb116vqIyjoyhFCY2m71oDx0SN+H4wgSH3b20/KtlbtcDThXxMcSo/NE
         J/og==
X-Gm-Message-State: AOJu0YwvQkjM09ac2dZ8nzE7BvWMns0doxkhTWBUdGs3nCsCZh6ttRYI
	u19ur4H90qkXCnSqrC16z7bYGZz+uOBSZBvphoEKO7TdbcFvgwl2DyB5Q+t7hQ==
X-Gm-Gg: ASbGncvikyB3j5ogbi0VugeMiAh5Vnj9TrzMM6EndvQ27l6aLv2jsXU9/ukEQpZ21F9
	dUFBOiladpJFZXj3TgN7dJi5bTizchTx+EfYc+SfcKG8FcgLPiEJUjVP1/sDiJs5iHmL9Z4zRrt
	vpJ8CUPtjONL/yPmgJ7q0E9cXtv2KfM6Y7K8k7IEbfzaBf9T4IfMeumOlzfCpBSnV6i5f8z8i+z
	sGeuv8DvTI3LF5BsKurtyViycBHe5XEM0grrOlVBIGX+BomQ9Yvyp9OrU8dyYGKNGM0HV3y1aDo
	/WsI8ywlkfaWUkEwvfs/pp9CM1B0Xx//x3ZZNE4D9deG/VjHvCzFpCMLnF8BdpXwyoXnh81gNIU
	A2Zf7AZ/97lCc6OZLuNaIWRwwqu3Yp4BkPa1xRDjzVeTcc0KTGEKPP/O1G44mGdRCKroxT7iHO+
	CZayBhvz7zbG/KVt+eBFelvhDFiPsHRjii08VHj10Z/vnIoLmUSFMWVcLXOKU=
X-Google-Smtp-Source: AGHT+IFrFWd/gTRtsjXBGBndwPXCoBebk14hFYa0ZGlvefHvMvmx1FizWyoerJQx0ug4pNe/03DBzg==
X-Received: by 2002:a05:7022:6894:b0:119:e56c:18b8 with SMTP id a92af1059eb24-11e032bd772mr2560460c88.32.1765048124195;
        Sat, 06 Dec 2025 11:08:44 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7552defsm33003622c88.2.2025.12.06.11.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Dec 2025 11:08:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b757d8c1-9819-40b2-a37e-754d9b586199@roeck-us.net>
Date: Sat, 6 Dec 2025 11:08:42 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Supporting glibc v2.35 and older in kernel selftests
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

the kernel selftests do not currently support glibc v2.35 and older.
This is primarily because glibc v2.36 added support for syscall API
functions such as fsopen, move_mount, fsmount, open_tree, and fsconfig,
and those API functions are now used in several tests.
As result, glibc v2.35 and older are no longer supported, at least not
for affected tests.

Historically the selftest framework implemented such functions with
wrappers named sys_<syscall>. This means that sys_<syscall> and <syscall>
functions are now used in parallel.

I see a number of possibilities to solve the problem.

1) Do nothing. Document somewhere that glibc v2.35 and older is not
    supported by the kernel selftests.
2) Document that glibc v2.35 and older is not supported, drop
    all wrappers implementing the sys_<syscall> functions, and rename
    the calling code to <syscall>.
3) Rename all calls to sys_<syscall> to <syscall> and modify the
    wrapper code to only implement those functions for glibc v2.35 and
    older.
4) Add defines to the existing wrapper code to also define <syscall>
    in addition to sys_<syscall>, and leave the code otherwise alone.

What would be the preferred solution ? My personal preference would be 3),
followed by 4).

Thanks,
Guenter


