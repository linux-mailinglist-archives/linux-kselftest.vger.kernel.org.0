Return-Path: <linux-kselftest+bounces-41119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DC8B51541
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 13:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17DB160C11
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 11:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CC9274668;
	Wed, 10 Sep 2025 11:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ5PQ1l/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD6925A355;
	Wed, 10 Sep 2025 11:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502980; cv=none; b=c/QXowCy22ykHk1mg9vV8dv+4yvZZaavdKsImyQyz+egF5wWES68FAF/Bi9ziE+3C7bIdVfeNHsRbUrMx7MsDo+xIv4HLV5xNIzSflnHGPHUdPCDQUhcO0L80LnQXeJEJJEkxokAE3c4gjk5OEB1KSvL8eK69STP4aqtKwCSvbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502980; c=relaxed/simple;
	bh=2rASD+s8QFj1eS4oF5z2j1I3AkxBGsqd2eCLiUasoB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cxl1YdsGDDzOeimlAFMnFyh2YP261bYUQl6m1+IF7sL3/jZ46asd9+VtTqcjxypaugS8sG4zdMVT1cUZc4+ss4SnhLp/WItxYd1QK+IMI+korNogbsdAkSyc8YAeIkE75eTRZ2ex4MVNKLaIHHoi5gPWoNaT7SnAxbZ3jxvC264=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQ5PQ1l/; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso6054255a12.1;
        Wed, 10 Sep 2025 04:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757502978; x=1758107778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MZbusY2YZDJHUgvIqP5aq8nFaPzc4Ije89rvbFvkmb4=;
        b=UQ5PQ1l/iUadLMXI3f99zhGMgEzVVCq4bl1lzsRKSrsADYZ8hrc9PlTqNDdBPOpMP3
         NZouYJGke5QN/uNvkV94v8KGV0rhe0GpZqdc7ajOh67GFo+BARP8KMc/Vf2BPxJ7lSLp
         by6guwdiYfQHH4ACLhYV8BPXzoWZ+V3ygz6a725i7TQGCxAELdufYcK76hFZGp2zoEKW
         44KEf7+3+QouM9aXPfjrjaDVvxQBWXCJivwhzh6vqoKeDDMDfnF7X4znq1gjwFSSZb4x
         hjR3w8nYrbsDiTURqhmAKU2MAESOpvgtk2QZsIQSSRdGL3G+crTr/yAo8gU3OLtHbsLm
         lfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757502978; x=1758107778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZbusY2YZDJHUgvIqP5aq8nFaPzc4Ije89rvbFvkmb4=;
        b=abQcBXMnGvgRy84rE7srwkvOVi4ypmDYPk8+MjaWzOUT1fQYPiHz7zELcG+AYN9tiV
         muxDuijyjVAuptsdXk0wWW+POsLh/4I6rw2YUqGfuH9TFtG0tjgX4zm6Z+etz9dHXPIh
         d+HKYaUzFwTuL7qZZH97Q8Bh4qsu+LqD7orWpyGtTVo9m868C2Hqg7wwUqVNWxghseOX
         PkO0tux2knOMGM9fysp0NTHqBEMES1hCgXuKmp7NPrdZwKpY6N123ODkLQv0jSVCNdih
         EBZBPDqBIEtyCE7F1j5dJ6vH140AHYjmFMSMkC2ejwjA0B6pRtEC1g0GVZCzmaqEd74m
         kA0w==
X-Forwarded-Encrypted: i=1; AJvYcCUcEsjqnheP+7ZqxILVK/uZP2OI9A2/1LBPCzEypPaTpA3ExIolRy5aTWcBxMyKwM7wzG2sihQtwCZdzFo=@vger.kernel.org, AJvYcCUuKF/4ad2iBDxdZGuE+2IndJ09W/wFRDfz7HD6I8BvQDPk36ftYjvzsNTojdt4f1FM5+ZKnzUkKIkTj5TEX8Re@vger.kernel.org, AJvYcCXiI6Qf2/HXZXaZPXEs0sQllJg4lQ2W95Y3TYdw/ATIr07VdT/cQzqBnbcM6dgpfYwA3dl25B5D@vger.kernel.org
X-Gm-Message-State: AOJu0YyfbEAFQC/09ZOGLba0YFVEDeFdh7fo7zjbYG3lPrItR7EFWxz3
	BiLPU6ijkk4PG/z5XxLPoiVCdV/GIJiRTYvv++aMtfdzBFE3cjFZ+Cie
X-Gm-Gg: ASbGnctv9g6mUq6tpxzj1JzdneQiZmT0W0+z1rRMDVQS/yPYT9QS79hnWkVrzXA0jks
	WpNkiucV5jOYjicz7fo6T1CW9TL+2jqnDlgu5IGw2hfeNjE5sXk6uGXFDO3lIJNhqjHyzrG/f8p
	TsiaTskpGToxpTXilqR2KltVOmgkGA5FseWFpSoEN3+c7bEuORs4yoHznnkwOcOI7wVj3U0QYT5
	dXST3x3vkTaUOfSB+61fByzKkk4A11EciqhwNzr3id1zSeals8j6bn+PW1k0FK1uI19MwxYD92n
	8tvnCtb5wpBraf8IOGpq+1hgfunMByG9wjNfZ5sloKtGdnVF4y7fizCYa9lXoUh8jRHjM++rJhM
	tVseULboUXIF0Zm6pvV//EZ4SmNXr6f4Tcf7kcHWbjEiQ1kMBnsUkMbkM+2sJOARn3K230OL7NX
	056V5B6JdDf7ueQ+Z2RggvfilupGmNn5OupOee94FCF7XL9XKpw2Kq+YVkucHcnNid
X-Google-Smtp-Source: AGHT+IHYJUR0byJaWrm8+KNFqANo8zElvFbaG5ym9raoJ7ygPAvqG0hpZXLy2KjyUuPvUxUS73wvMQ==
X-Received: by 2002:a17:902:fc45:b0:246:464d:1194 with SMTP id d9443c01a7336-2516d81836dmr194708695ad.2.1757502978484;
        Wed, 10 Sep 2025 04:16:18 -0700 (PDT)
Received: from ?IPV6:2001:b400:e28d:ed7:4d5a:39b4:7c51:4c71? (2001-b400-e28d-0ed7-4d5a-39b4-7c51-4c71.emome-ip6.hinet.net. [2001:b400:e28d:ed7:4d5a:39b4:7c51:4c71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2ac085f9sm23656115ad.117.2025.09.10.04.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 04:16:18 -0700 (PDT)
Message-ID: <270488a6-ec6b-4b38-aa30-b5c9e08cdd18@gmail.com>
Date: Wed, 10 Sep 2025 19:16:13 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/net: fix unused return value warnings in ksft.h
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
References: <20250906-selftests-net-ksft-v1-1-f1577cea3f68@gmail.com>
 <20250908182018.28d9ff10@kernel.org>
 <a3d1c5ca-cdce-428d-8c1c-6a1f59e2dd76@gmail.com>
 <20250909162551.5224a3dc@kernel.org>
Content-Language: en-US
From: "Nai-Chen(Simone) Cheng" <bleach1827@gmail.com>
In-Reply-To: <20250909162551.5224a3dc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi Jakub,

On 2025-09-10 07:25, Jakub Kicinski wrote:
> Sounds good!

I tried the direct void casting approach, but it still generates 
warnings with GCC 14.2.0:
     (void)write(fd, msg, sizeof(msg));
     still shows: warning: ignoring return value of 'write'...

After further researching, I found this appears to be a known GCC/glibc 
issue dating back to 2015 where direct void casting doesn't work for 
functions with __warn_unused_result__. [1] Since this is a long-standing 
toolchain issue and direct void casting won't suppress warning, I think 
you can skip this patch. Thank you!

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=66425

Best Regards,
Nai-Chen Cheng

