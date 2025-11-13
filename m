Return-Path: <linux-kselftest+bounces-45584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6921C59EA8
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 21:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1AEB4E2A60
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 20:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3DE30DD2E;
	Thu, 13 Nov 2025 20:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="BIPMdFC2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BE22C2357
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763064692; cv=none; b=F5NKTSuVQoacKPNApVwVcz55qN23gtYYovGJYEvRqT9nQIEg6Zmw2sl+UBbVSXZVuo5OqjRF38g9by4g7036a2oxLE16LCFUw7WPeO9gV7HMQbTLIWhb2gJFHFI2h9RhdiOQU7Epgu4EVHAQ6DXd4bPEj6f+1ez83YIGmoHmsaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763064692; c=relaxed/simple;
	bh=/TZXfWM1vK0QtiZfDBIqVdwlimM7302iuymWn54DGus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKztb/IRvyRQRN3ZM6F7nuvus24aC+6wDPIwgmdly+7gRkxlCn0a21887U9vgrf5i1EPE6YfXS0esV7woGzbkLLLvkqNvpNLWyyMjymPErF4WjnGSxEaQljQcz6olwBMNyAUmte9qlMhNGOMahqJoD2CcEDTXEF4md7FJZFnKUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=BIPMdFC2; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640d0ec9651so2124100a12.3
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 12:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763064689; x=1763669489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g1QxTrWXodWBMomxAbAxFA1n4YHk0BckspM2UrA+wSw=;
        b=BIPMdFC2cgy162iTa3LuY/0qKXDe8umOPxEq0vnvt0fdkQMVQ2GrQAxoiQ9SLTJzLn
         Bu9QAx83aklTdv8PWCRl/WRVtxAeKycgGW4XimzYhYzfOu9ESfBO/jQnZ7MWFzxDzx31
         5jbYDHPja01qHt0mVlSfO8C3uUqt3y/1NUZxFEZ3CPz4b/GaPcj/kG6R/rxKhdXt0/ej
         rxwnZlL+Mb3Uuo43xEvqURfpOeNs9Ft5+CH9ypMDJCFteFVAhfayHBQp6C283o8U66oR
         xOcUAvDX53mWWsjrbJcU9fIDyK3VWk/fr3AA7dZuI3MoJwb1fQNLFkxMj9d0LiM7IaXQ
         2BgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763064689; x=1763669489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1QxTrWXodWBMomxAbAxFA1n4YHk0BckspM2UrA+wSw=;
        b=IcpiNfCznjrZ3APpR0iwXJClOqpFhdpZEcfbOQo2i6x8rbNIwjKUdbCPuTg0WpPmFi
         vB7HVjr2+dOISuiLFMM7uEvA45DsYJjr7prjRqRyf7tR4CkSoCOwVnxk/gsWq9eRhvxK
         LarawEkAU7FGfm6rmiwfvYZD0vx5B4rJP2WY+svXqgqUsUY2rcG0Hw6dMGWlGpnW6086
         TGeK8xhdIbooiwKtfl08HFvGLmnH0SGaPfLHCAHIGWaid0ReMMcnOpTPeB1sROGWEFo9
         pdRH++3dRsqHScQWdWZFvuG/TcFAW8XbqVyGEftoJyCJB9fTp0xsPChynmKY+fwe0IWQ
         Q9xw==
X-Forwarded-Encrypted: i=1; AJvYcCUH/wIMKV6vKyPfpHPXCh9BJZnRunuuust7DflZb2hxsBcysKNsGf1QJFTRntsDgLNWEKzTua0Q6M9Qt2ZvJc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmx0KqhxeDy0jTPkJL5H/6dfZmyz3VWutTwJ4HXjuf87l+OSfQ
	nTjCZ13DTIIoRIhj0pru1knrZz6xNPrdC7mnal3I9iKfPzj8EGxuGt6g/I8jXaKwv/jyBx7q181
	iyPZXnvCJUN5IpolzaCFOwbEEP3V4X7SwTUpq1o3qbg==
X-Gm-Gg: ASbGncsWBJca2cjkhFIpzLBA+/buJnbuByMWBgqhCIQ9RoVeXTKn9JeS6+E18Ku4vbw
	Lo3gcjXa3CcYhyWr7wH1wMq6S/rRdhXNgz978pDfeBPt9Zhg3709FyYeH2lo5O4S1xzWx5bVJyA
	8eMXeLbI37c9fc/HlJ7hzQOfoIiZt1MTbr5+uY3+0l/w86pRi3VfNaQl1y/LH5tEM72t9DiLneS
	AQH88P5m1ACPTXbJYpopSPPn5kdOZIaSnJtesWPI4fiGkWY/zgHysOFEw==
X-Google-Smtp-Source: AGHT+IFqOOzcW34Qt5BtLWZl2weqcPZ4vSKaEdo/r8Kg1aP22Cs7VB3g26OtE+gc5XTlHx+GtBN4rDcQMAuYp8I/OQ4=
X-Received: by 2002:a05:6402:4543:b0:640:ebca:e680 with SMTP id
 4fb4d7f45d1cf-64350ec0940mr319721a12.37.1763064689030; Thu, 13 Nov 2025
 12:11:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
 <20251101142325.1326536-2-pasha.tatashin@soleen.com> <d7651272-f979-4972-ae41-bab2faa8473a@linux.dev>
 <CA+CK2bDSvtuwrrXGOC07Rj42yGFHWR4Sse7Q5z1z8f1ZFHWQ2Q@mail.gmail.com>
 <CA+CK2bC_+repP-q183hjAuYYB2-Yx7fr_U3zr2cxysAWx5hzpg@mail.gmail.com>
 <029090cf-9a4d-4f79-b857-04c3ada83323@linux.dev> <CA+CK2bByYPJXSNOh6R3swqFrGsS02m3Dfh=ZU7YhNjNX6siyqg@mail.gmail.com>
 <442fa82e-16ef-4bde-84eb-743450222468@linux.dev> <mafs0qzu69gei.fsf@kernel.org>
 <CA+CK2bBEe16x0em1gRxQD3jhfV9t3QA2vx5ifk2pKb_WEoMTeg@mail.gmail.com>
 <0735e1ef-2b65-4a54-b4d5-964fb875cd09@linux.dev> <CA+CK2bBnnGyQ-N8-XS3W3tnSRwvFbstOdo0oDSdkF70KP1AVxw@mail.gmail.com>
 <9e144e21-a5e7-4c12-b8b0-07172787ab37@linux.dev>
In-Reply-To: <9e144e21-a5e7-4c12-b8b0-07172787ab37@linux.dev>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 13 Nov 2025 15:10:52 -0500
X-Gm-Features: AWmQ_blSG7On0GhlPsFoQI0cU4BjzgyhDv68bXpGIzhq4rnHTQGnsGUkDO_x7mo
Message-ID: <CA+CK2bBQxB7ihmhBa76vJbdD988B+8PBrV4arDSNqjv_VB4DVw@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] kho: make debugfs interface optional
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Cc: Pratyush Yadav <pratyush@kernel.org>, akpm@linux-foundation.org, brauner@kernel.org, 
	corbet@lwn.net, graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

>   set -e
>
> -kexec -l -s --reuse-cmdline /boot/bzImage
> +kexec -l -s --reuse-cmdline /boot/bzImage --initrd
> /boot/initramfs-`uname -r`.img

Thank you for your suggestion, in the next version, I am going to add
initramfs optionally, I am thinking to update script to something like
this:

#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
set -e

# Use $KERNEL and $INITRAMFS to pass custom Kernel and optional initramfs

KERNEL="${KERNEL:-/boot/bzImage}"
set -- -l -s --reuse-cmdline "$KERNEL"

INITRAMFS="${INITRAMFS:-/boot/initramfs}"
if [ -f "$INITRAMFS" ]; then
    set -- "$@" --initrd="$INITRAMFS"
fi

kexec "$@"
kexec -e

