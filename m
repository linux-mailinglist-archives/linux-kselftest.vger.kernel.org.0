Return-Path: <linux-kselftest+bounces-20893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D7A9B40F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 04:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC57FB21D93
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 03:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCD31F709E;
	Tue, 29 Oct 2024 03:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FXJjDsay"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B65217B421
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 03:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730172139; cv=none; b=kHtPWt24JDV6tetZpGK5xnpT3LcQqJZTc6+vRfO7LIFQoV1+9CL3ybFEIFMgJ47NALi4qBYfpQKKrOKwcuvj9fEtCrKsnQ4Glj3jG9Ao9Tx2rSSxULaUDc9xfInx+GqpeUdhQ65ToAzIHX17RM3rECc/ujLqtE0B4DYHnco5NFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730172139; c=relaxed/simple;
	bh=vDaqNIx014rOd3WGYP3FU8767BW0UayQOiIqJPsF8Ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+UrOS5PCa6aVwiLAzHpA4pH7lboxVrD3ATJUc4uZtjvZkwljHkdlpklTBSC39mddRsVRHBNzNjXe7roh93xtNjsCgbTm7S6sTjyfvrJV2nF5wkeeYg/G4lqdixg0mWfiZEqdcFCHwCZcKblhfRYVirXM23om9Uixmx9fdczGCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FXJjDsay; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7205646f9ebso2878362b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 20:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730172136; x=1730776936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ago6CCUz4KeIAm6BunmfmSUFaWYM1LlpUdAhiuiu0fM=;
        b=FXJjDsayDrgr+nIObNHoJgctKgpCtliDjQ52IyGreV1BtW0nw2KlfEO8hIiYdwXsDg
         1cAzcSXfd0Ex39sSI7Xaer1am4R9NSroFUWNgU+rVq/7wsirJqX1QbRv/Nj4J0HAf/70
         2HOAf1JkeJ2N6a4a6/yYXyqgUZ1gSecikwcSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730172136; x=1730776936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ago6CCUz4KeIAm6BunmfmSUFaWYM1LlpUdAhiuiu0fM=;
        b=J0DbYfb23gzrogPv6QdslJQ4moK6iKMVNXpQA92/Gei/erXiR33S7cWVHZ9FxAdRUR
         nhS8PR6+C2SbYbm2hq4cJEMkqbAvc2jdhLOaewkk6uns5Gr74ZlGZt1lfERu9UQ9KFX5
         zzEB0mWkPsHH3OhQlftu5V0nnCf/8QW/g0J1Pt5GuohbOgHeu52R1loCdP2/dYzbtsH/
         TAWKs3dzA7LdAHPQX4Q+JZiejn/of6dIWyYVFjIIxpjoMPu74jVzmXZCDeXYB0exYcje
         zLMRJHvDl2BBchpR4+sKV2qgdMw+1ATKMYHedpDvdj9T0Ovqd5IScF5mL7bX48d8eNCt
         Ok8A==
X-Gm-Message-State: AOJu0Yw3fVMKrEgplCx0aEFiMa7lmuC+L1CpedLD2oGUKfZvYze+GU3/
	YSWQ2SoJnC0QwIZE45Q+RfLmeQneVdL0xQMT3gn7GEvwkfr9wbK6xjM3BDQiunQ=
X-Google-Smtp-Source: AGHT+IEhOXh4vbQjaBSmOMb2IfMnms9z1xgawCts+x85ZseWyhXJSBcPSK69ypBBm9QEhhqMfKNwog==
X-Received: by 2002:a05:6a21:6b86:b0:1cf:2d52:415e with SMTP id adf61e73a8af0-1d9a84da03cmr13844312637.36.1730172135973;
        Mon, 28 Oct 2024 20:22:15 -0700 (PDT)
Received: from [10.200.3.216] (p99249-ipoefx.ipoe.ocn.ne.jp. [153.246.134.248])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc89f2a2fsm6562114a12.73.2024.10.28.20.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 20:22:15 -0700 (PDT)
Message-ID: <2bd7b521-0351-46e1-9480-2223d79e6dbb@linuxfoundation.org>
Date: Mon, 28 Oct 2024 21:22:10 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] selftests/intel_pstate: fix arithmetic expression and
 cpupower
To: Alessandro Zanni <alessandro.zanni87@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 anupnewsmail@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1730141362.git.alessandro.zanni87@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <cover.1730141362.git.alessandro.zanni87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/24 13:08, Alessandro Zanni wrote:
> Address issues related to arithmetic expression compatibility and
> cpupower operand expected.
> 
> Command to test:
> 	make kselftest TARGETS=intel_pstate
> 
> Alessandro Zanni (2):
>    selftests/intel_pstate: fix operand expected
>    selftests/intel_pstate: cpupower command not found
> 
>   tools/testing/selftests/intel_pstate/run.sh | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 

Thank you. Applied fixing the short logs for next rc.

thanks,
-- Shuah


