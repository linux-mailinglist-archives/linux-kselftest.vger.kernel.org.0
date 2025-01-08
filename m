Return-Path: <linux-kselftest+bounces-24087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DA5A0696F
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 00:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB57167645
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 23:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EAE2046AA;
	Wed,  8 Jan 2025 23:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DV0ISXL2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D1422611
	for <linux-kselftest@vger.kernel.org>; Wed,  8 Jan 2025 23:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736379074; cv=none; b=dyokLC0tlkhTqPLGwqoVwTQbRYjVFCQS2FDVY0uGHVZaxhBZBaa1oOW2Yoom2YOc4SxujfSCuMolQTSxo1X+22W1xl1dLgXv0x+iQwrqjQfL/eZKza4H6xKF7PXPe9iJGL94qEONsKjxlqhiBUZrSR8g8nlYb1kIQOvAJjuZpo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736379074; c=relaxed/simple;
	bh=2ygkSXS70QuPzvpaHAVjLZu4rxcDTMhKU7m/zEwr1vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJownjBegyGrKH/Oe/9pIVJfF1KWnr2ejMqxP3Rw7JmphItLvBSoRo404SjEYawhn6TEkN70GH69L7pKtrHubCCngkTOGWuHGFEyDjtschx74dQhIGddtnPpdhzAwJd896J9JH0XWISludBJCw2Ug4Yb+yYBigGC+6u96FzXBo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DV0ISXL2; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-84cb9c4aab6so10098939f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Jan 2025 15:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736379072; x=1736983872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jCtpVCUmQA+l8WUdxm1CXpY78fsi+035YRkx9duIouw=;
        b=DV0ISXL2Set8uev1KwpLSjjXVVFHf7RBMuiyV3QVwcFY0VBI4DhLpoEsxdFSEiiyaM
         H1uJqcJS/jlY++sPAb2v7G4tQEQglrRkao79sLLCoWkKtf9D1U/bwT2RnMA39GvNZP8u
         UHSHogsDTK8yurMhicHGe4NYUjBIHChisSx/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736379072; x=1736983872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCtpVCUmQA+l8WUdxm1CXpY78fsi+035YRkx9duIouw=;
        b=ppKcNCpwxj60JuEL+pI9bPlBCcks7Wvr7O7RzofoWnd2Ghg9ZOxXIopGMThIZSl5kA
         sylPv90xDA1odvZE4ETopIsYat82OWoonrhoKFlPGgxDKpy+r86zsfZ097SvKHreqUCC
         2rUCLTZr/kYsi5v2a9otlTrKylKTG6UsUiExkZ7fSpQfIFetLqkGFO/nlG85D8+V9c7j
         bvQE2SwUDCuEnSWMy20YL80wwoJpHtKtvXief+AUERIVwoCheI2RwJEnevYyECtO9XpL
         DA093Ig2bRqtTM3BsxhtGV1I0IHn3sIOK/fnWdJYIulNHjZHF+8GgmAa5C+yOwguJrSJ
         aRKw==
X-Gm-Message-State: AOJu0Yyzu/1sxZ8NO4eVaXuM+6wONdXteXYlABdie1iuqs66A3YVDBm1
	Jc9pGSnmZ35C4exKZFSr79CLEhl0N2PD7pXMZHdd8akkY6QMPHh1YDS6jec2j9Q=
X-Gm-Gg: ASbGncvnVqDuAFvzDKig2aKi2sulRvRT/DI5nS7Osk9q+DnJJnX+M72I15jFR/qSPUI
	pQB2GMo9nn+3rSaP+Zmzs8Xu+vJ8Ck4XyYuyy/tzMtTyjDjSGyW8beL0WXwgznKJudOdW8U44v0
	r4iiY0wjW/71OsX5nPrOzhiUzGSY89MUb7HgAeiIZyi2a+APjutEHF+R/EkD2OIUM5HbIsdPMis
	Cudt/eNDL6UDKYJ/SzPCRtislZPpIrV143r9ig9xccxc36lJ5uvScO2X0qRjZ6LVFJa
X-Google-Smtp-Source: AGHT+IGILbdn463ltPP8BYgHNoHsJk7Smn4QLB+naTMioeiAPRPo+7zv4skWX1o2Awpu7Oh7hevNWQ==
X-Received: by 2002:a05:6602:380e:b0:84a:5280:596f with SMTP id ca18e2360f4ac-84ce00d2dd9mr417190039f.9.1736379072112;
        Wed, 08 Jan 2025 15:31:12 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-84d61fe2bacsm3963839f.49.2025.01.08.15.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 15:31:11 -0800 (PST)
Message-ID: <f5102d94-2704-452c-8f5b-7ccaf2ea2a4b@linuxfoundation.org>
Date: Wed, 8 Jan 2025 16:31:10 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] selftests: tmpfs: Add kselftest support
To: Shivam Chaudhary <cvam0000@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250105085255.124929-1-cvam0000@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250105085255.124929-1-cvam0000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/5/25 01:52, Shivam Chaudhary wrote:
> This version 8 patch series replace direct error handling methods with ksft
> macros, which provide better reporting.Currently, when the tmpfs test runs,
> it does not display any output if it passes,and if it fails
> (particularly when not run as root),it simply exits without any warning or
> message.
> 
> This series of patch adds:
> 

Applied to linux-kselftest next for Linux 6.14-rc1.

thanks,
-- Shuah


