Return-Path: <linux-kselftest+bounces-19264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5EE995953
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 23:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF171F24465
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 21:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB3D212D2F;
	Tue,  8 Oct 2024 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DeIu8jTP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897E0213ED0
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Oct 2024 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728423423; cv=none; b=f2aTg0Uadylc3cq6WS1c+0KqLAW4N4kou1p+Li9rL9Phq5aT20+jh7MLY6mbOdR07TBvXNMjgN3KBffhr+J0+F/K/12ufgZkaWNmWSp0DXa6DBY314QHLHbnzmp9tWMBN7JdJ3SdgWZByc07bsW1Vako0oW3jNaQyKVJFULnWgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728423423; c=relaxed/simple;
	bh=ucYK309EEswYsRICzmxprkIn2sOLS5JuQjJ/cOcP3o0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=TTMWT/YEGlGtUZnriOhiu9RU2LMXf/29Kym0AzktRdsYloRDiyohpiGAHmVySxf1xQXEOdi+21cX2Mg96h0j1ueK+Kudj2hw62CP0qwiBoVyJ9zkmS3eHKYxk1Qw84FDGzHdaZHIdSVsRbpNPPhaROF+6Cy03y6HRIKJLqXERgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DeIu8jTP; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a340f9dd8aso34253165ab.2
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2024 14:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728423421; x=1729028221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LQnoE/AZ0+1wl89vpTtboQjVAVFnD4W/xtBJbrzWDcI=;
        b=DeIu8jTPpgB27xLhyZPnlwMHV0/OXUCF6VQLb/khHeaouvg0AVLnwO9MhN6IpAKfac
         +ngck02HeXo+lIyS3Hy6xox50cGXmU8bchPvP4aGKx+g0DzsdX4o77Isy9FWODPX76sB
         6TUAozwZnL9D6jFfy/uQ4QRGrpFT6pqUbP8ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728423421; x=1729028221;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQnoE/AZ0+1wl89vpTtboQjVAVFnD4W/xtBJbrzWDcI=;
        b=XvIS3pakWA6HRYh5NpHasKHfdQh2v+aUOvJYe4EQYhvcCTfo8QCQn9dwpVXX3BzrhD
         fqbhQ0iKQuiQbYoHmyd6ofCz/QJGg6e8yfLcYIOY2BJ3aQaKLDbXHvhE7g3YDQRR5oIi
         2RwgtglelqDejQ04ErhozAYgUNCwaIHCt/0eBl/2LBxOBON1+HrAvyBZnK8VVL/DCnTW
         0tc103VUDh2Big5K3XHUV5oAv+1MNZU3EkU5NQnmpavbiD51Qkev8rwy4N8Y0GLwsqDw
         ZbTO2tYM2dv/+1vMoPz3AdNu2dRZoU+RMMleVzUcXci9NWd4PMlsSM9SZ4u7TKMzBctP
         V/vA==
X-Forwarded-Encrypted: i=1; AJvYcCVB+EJcZOLum+/N2dwQbWpMEd/OV+xZhmHPIG+Tgn2vSWaZw4HoMlefVaNNQ5DY2WG3/831xYenhbpcNuhq988=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx5l+yE5I7BM36z3blqyLDrJZairspnTeKFM18y2NJwFuB9TXO
	FkQ7qV59v0LpRMFWAxcqDb1rAuhOfHWdeT8Eq6BP6jHL48IgRPt2GxkMoHBfubc=
X-Google-Smtp-Source: AGHT+IGLxltTyk/qpXmgpkdT8tiOQhpagQUYO3fePT5QOcHJeOv4FGTQ+B3aE1DpSNiE+8XEhMeO5g==
X-Received: by 2002:a05:6e02:1fce:b0:3a3:3e17:994e with SMTP id e9e14a558f8ab-3a397cfc554mr3337265ab.9.1728423420753;
        Tue, 08 Oct 2024 14:37:00 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db6ebf250asm1829524173.100.2024.10.08.14.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 14:37:00 -0700 (PDT)
Message-ID: <b4f071fc-f6ca-4929-92ca-5f137a654d8c@linuxfoundation.org>
Date: Tue, 8 Oct 2024 15:36:59 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kselftest v3 1/3] selftests: vDSO: unconditionally build
 chacha test
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kselftest@vger.kernel.org,
 greg@kroah.com
References: <6d8c0894-f3c4-42ff-9794-03d675142a7c@linuxfoundation.org>
 <20241007214558.2590492-1-Jason@zx2c4.com>
Content-Language: en-US
Cc: Shuah Khan <skhan@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241007214558.2590492-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/24 15:45, Jason A. Donenfeld wrote:
> Rather than using symlinks to find the vgetrandom-chacha.S file for each
> arch, store this in a file that uses the compiler to determine
> architecture, and then make use of weak symbols to skip the test on
> architectures that don't provide the code.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---

Thank you.

Applied all three patches to linux-kselftest fixes and will
include them in my next pull request for rc3.

thanks,
-- Shuah


