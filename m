Return-Path: <linux-kselftest+bounces-30981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B790A90BAB
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 20:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70704448458
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 18:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0131A2248A1;
	Wed, 16 Apr 2025 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GohNG6cH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446C522425E
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Apr 2025 18:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744829547; cv=none; b=f504MeS3uKvL3D7LU2WF4Qzb25oVj5bjJtr6PI7mRMecEJywuPqZbnWZad+A8O5r9Y973oRyRz+DeDL9rNoDSAXxPpjNIc4S0yLbY34uajmmzPyjTXynkZEKulxHdWdMArQosVqvDfwZ+gcc0pJCvfa23hTc0Q7QERvEvGl/nSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744829547; c=relaxed/simple;
	bh=MP3MEPXxiW0y+zqENt1iZmdSIe99ISiyPFjriypvPQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=McLc1uy3RpeGQsSw6f2/HQdFvIlvIHpF5fdhY9mbgYV6AJ8TtdOckRICza5zNnQ+M8++stTt1CkGFe2wTQ53YTdOVy43nZCtEQCeUoBBu5gzBkY0eCthjgdhMk1wUnxz6/dgAlTQ1eD1KzKd+wgQuws29oqFptpQYF20IMhCpBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GohNG6cH; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-86135ae2a29so624108939f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Apr 2025 11:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1744829544; x=1745434344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p7MoVykQROxUe2maoaPkdBQ7x8hTpGUg8xmb62S+DQ8=;
        b=GohNG6cHFcpOKsh9M0P/tMzijNuEpfgFkxsjeynZuSnwKEj/RR4y8lr4afR2aTX0F4
         Ae1EfrNLOOYinNvCrqh4LL97clCiMs1p7KszoeO8m1NV7yMTXpw7fRxWM044PUux/H00
         sTpater66STZmD1BUni9+LQxE9bUX34Qk9KZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744829544; x=1745434344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p7MoVykQROxUe2maoaPkdBQ7x8hTpGUg8xmb62S+DQ8=;
        b=ltmRf5jWRJXF+g+nnUubk6zB5vtjdfe4Whsgpuaephc49cQeQh3ORC1pIXUkMU3W+2
         3DXEp1e1FrCX9POQKt/O9cg9+LtoL959aANHB5My3Ef2WCvWtqehCJuDdg9jWIOzigwS
         VyHiTR28TeZIqJeOTYJ6DYqh4P/XgysN32LS1A5PTcc72agHDyaPeD9cXCx088kg0zxN
         /uyUIhO2KqyzqyINkDYRV004omYT67SqRW9N9jlI/QlToq0yOaPTmyRNOIKaES+IwvRb
         S8bvQXmexdM+H38+ATt5mAkbwhhL95v0bPC5NdiReFMfhquETlqKiO0OIP5V7d5jlU1H
         qlRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYTYawaS7z0e95iEhmAtjMAzuy3/I7cMogfVJIj7CiSToGFLprtRQSHVddwsN1hwTKEx3TPXhA7gllPBGU4wc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ppks5778ZtjAorfVwCSZCvDbuR8XcC7jstvu4Fm3bnz2woaf
	MCOf/jiF+z14JIYx0ui2Th2CzPAksxy5mWE9TKUYJcn+R8nANWcrW0C/Pdp77dw=
X-Gm-Gg: ASbGncu91+uQOEGWbEb6D1vcAZwnU3MWx3wVt2eKSaONt8BEO02W6ApY1LYTfSC9dSO
	XUx4NQ2GLuU0AX0lfX+xqGHCws/OGP1GdQwu+7agj2o4jDWbteJBSTJPIW3GDJIlBf4eDASRS5D
	V3+R/mIAZNrsQNoqFB7uUrN0aF9CCeU0d3vRO2kZcjNQqBObRtj+Z7x+LNUgMwXeZ4SJkAIerQQ
	BgUhsgmWy73dFqWMs7cQgy6cwCLpujxYA1KoSRlnGYnL2tYibsrJTbQ8FWDcDknrMuBc+8AT1NO
	+vMJuRyIM5QHbJTwGzn2kYX90enIILiy9zbbao+jzJiwXXaSQx8=
X-Google-Smtp-Source: AGHT+IGIdvCjfpOGUqUnUYJh8CVNLblQA7dCofVWf09VAklKBR/jcQuZcH92lgy+WOSL6Lk0pA4EKQ==
X-Received: by 2002:a05:6e02:1fe4:b0:3d4:3d63:e076 with SMTP id e9e14a558f8ab-3d815b5e781mr30114755ab.18.1744829544363;
        Wed, 16 Apr 2025 11:52:24 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505d16a79sm3773037173.50.2025.04.16.11.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 11:52:23 -0700 (PDT)
Message-ID: <55ab926b-26a5-4497-a6f5-8ea18ba8e454@linuxfoundation.org>
Date: Wed, 16 Apr 2025 12:52:23 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: Differentiate bash and dash in
 dynevent_limitations.tc
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250414210900.4de5e8b9@gandalf.local.home>
 <20250416075832.cd27bcb52b7e31d0f5717273@kernel.org>
 <658670d0-086b-49e9-85ac-3e002fa8322b@linuxfoundation.org>
 <20250415205442.2437cea3@batman.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250415205442.2437cea3@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/25 18:54, Steven Rostedt wrote:
> On Tue, 15 Apr 2025 17:03:44 -0600
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>>> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>>    
>>
>> Steve, do you want me to pick this up for rc3?
> 
> Hi Shuah,
> 
> Yes, can you please. But can you change the Closes tag to:
> 
> Closes: https://lore.kernel.org/all/350786cc-9e40-4396-ab95-4f10d69122fb@sirena.org.uk/
> 
> Because the one I had was the top of the thread which is about a
> different bug. Mark mentioned this bug in the middle of the thread and
> the above link is where Mark mentioned it.
> 

Done. Applied to linux-kselftest fixes branch for next rc.
https://web.git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=fixes

thanks,
-- Shuah


