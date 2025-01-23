Return-Path: <linux-kselftest+bounces-25055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDB6A1ADAD
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 00:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BFD73A3D7F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 23:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881CD1D5CFB;
	Thu, 23 Jan 2025 23:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QhZ2uiD0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3691D5AAE
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 23:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737676484; cv=none; b=qmbsdtEMWVJTBV6d/fIxtYty8Lt3LktKXUD6CzyiLCjGh91JzYxssyuzw3RZzAkoVxszzXpKaWv3nO3/N5f+4vE0VDnvLsLoF7soCp6dONOg32dntAyRNH3lDCWo6H5V5+pFLOtOlpHuefY4CeNpllmVI2v+auoOKKBLLeovLr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737676484; c=relaxed/simple;
	bh=aIjcLrJGlFasL3xI+iSRoak6ztwXJDst3i/cX4ji66A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pi9rkTb5HJPNsz80ZqZ4xfgj4KukigipB03Ni6esbm5I5bQfIpyY0LQKvedjoKsnkrOSLY5400CrCfXwQ3jC/SijayZb0NMug2DDaJ/29GrBHZPchajGPE2zgCz3FE4Cw1rQuELFtGIcBn2lDkPn5E/lrGH8T7lJ4oeKyomOHIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QhZ2uiD0; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a8146a8ddaso4028735ab.1
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 15:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1737676482; x=1738281282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sWwhFSgKs1C9G6QeDd/12wgSwtiz/3rmZd3mhm86C7g=;
        b=QhZ2uiD0xxP/uAD+5/R7Vc3dGhtpB9Ao+OHngkR03uhBDRG2e//ZGPVv095EHk1ib6
         tu+9KPZCKNY5kjwnGNxxk3rLyurXGJjbgVSyrk5EokcxNUiuR0MKEird8kq+muH6M7Wv
         cmQOzj0C2VoRh2tVGCR9l1K6J1cGLZMLtvhcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737676482; x=1738281282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sWwhFSgKs1C9G6QeDd/12wgSwtiz/3rmZd3mhm86C7g=;
        b=CKZE7cThze9llYJwGtyh52Zy+bins1Ol/ptWm8/GvlHkKbqGXT6r5KEHSWZKssqt6V
         u8/Qo2N2CINMikNm7qDob3sNGFqtgZfnFYzQ5mJA/kq6nv0MI1AL2XHj8iwGsH/KoJU+
         upmJTFUdmroaylMnKaDc7yEeg08QsmCNwzx9SsinMkiYZM2d2Nh14e/3ICK3zV673LrO
         Ach36z8+GBl5ST8N0tJn8Zj46Zm7iQl3QGkf33LV7H1QWaXGAkePQ0ECtcL5DFS7WFwl
         AdqBURbidxm8wZ52gIIZw7fI7Xdci2tFJZLqcsEYyi95O/XiDAHD6vYbsa7iYiFy1yBE
         EKgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtu3AjPA18hIUdXzqfeaoV4H3jSpIT42as1DAxd/D0fgIsoeFUfjZQ/i18VUXGx+ec9ebUDqCe8q+qMk8Dynk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfSPNhDAPK8idCDsUT8a/iO5qaqVMNNkcEfGN5tj3GtfMp/vun
	OoHaPbkveKJAeUZkpt0wN3eKZiflLkkT76r60SPRwtzTJKl7KFN7J7jqH25qa1U=
X-Gm-Gg: ASbGncvyREXwlIZaRYXyZqHHVK0hmmqr1xKJsrSVPOF2C44p78CglEhGfRnL0qazy+f
	xhjy/MeSACAwEJal91FxVrINoDdGuAdPrpWUbyoQbmX5NhBBO5IKypWMVM6HnyWzsBG2Jtkria2
	0cgJBA3x1m0+6NvMXyf5ZOHTl5D1o7LpHFAIJtKV4kmbNetymPoOnC6dHJkao/uAw0X2MIOflEm
	U9aVOuqEVAHvl5V7BEtYyYvCDyvv/WuD7sq1E2MBKNxtPP7nyZKWW7XslK0pyKRkWNU0F1iL4Zc
	23pSieJW0S/mktw=
X-Google-Smtp-Source: AGHT+IFwbYB9CgFYSkoho5dmcikikH3LPzPdWoZFU+D7+LOCxiV5nLqk0Wewub3OPu2i8idsAytp3Q==
X-Received: by 2002:a05:6e02:1a67:b0:3a7:87f2:b010 with SMTP id e9e14a558f8ab-3cf743ab4fcmr202063935ab.5.1737676481970;
        Thu, 23 Jan 2025 15:54:41 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec1db6c3e3sm206904173.87.2025.01.23.15.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 15:54:41 -0800 (PST)
Message-ID: <d39de60f-c87f-4c59-9226-9080f9008f3e@linuxfoundation.org>
Date: Thu, 23 Jan 2025 16:54:40 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/tracing: Test only toplevel README file not the
 instances
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250115191758.35b62738@gandalf.local.home>
 <20250115202607.00c6d353@gandalf.local.home>
 <571133ce-b4ae-4a9f-8601-443774804d1e@linuxfoundation.org>
 <20250123172530.474e873f@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250123172530.474e873f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/25 15:25, Steven Rostedt wrote:
> On Thu, 23 Jan 2025 14:56:55 -0700
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>>>
>>> Damn, I forgot to add Shuah and kselftests mailing list to that one though :-p
>>>    
>>
>> Do I need to do anything or is this taken care of?
> 
> I think you can take that series. If you want I can resend with you and the
> mailing list Cc'd.
> 

Yes please resend.

thanks,
-- Shuah

