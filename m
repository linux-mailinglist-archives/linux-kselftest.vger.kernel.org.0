Return-Path: <linux-kselftest+bounces-46026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 475A6C7167D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 00:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0E764E5C8D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 22:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720D830AD10;
	Wed, 19 Nov 2025 22:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UupqrxhD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2DC2D3EDF
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 22:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763593004; cv=none; b=up9tfOu0z60Q0c69eFfghB162SOhP4/1amLbmdnJGkNePPjr21n4UvqPo+MtwxIxF4W9EMHrR2cWdImNXgl4XKQfwFS/fvRsWJc3jT3yEnuDJbXCZzH8ovH3UA12j90z1RocLOWFHrpAoCAd3CSuCgw+Nqz4sB9TYKkA8jJvdPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763593004; c=relaxed/simple;
	bh=8PxQRRGbRQ8tSgOLa+iJvnsNLzWFk5wnVUDy0F4fD7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSIEWQgmaFe5wgkMFErTMLC4Q9xYoT05MvkKLIJi2JHMGY5QXgbPd4hqA2AmSurQGgYdBcNV6YBoWbcVp/QhHYYdhfhMtsP+XOBEMDCCfq2W4mADR3ERr9nHTLryRjD0mSL7CrOTsIG9UP85oiz/tSrHzQsuXpHv36w8pgrFOXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UupqrxhD; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-9490a482b7bso10250839f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 14:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1763593000; x=1764197800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9wMUH8JcfJUm5VqcHHrATjM5Cu9rxqYCl3FUJ90RvcM=;
        b=UupqrxhDQk2sfQuQGCRVaVJymkBO0gK7LIqQo8ZQFZUtGTc1jG5j0J6NjZxPE/WwJ/
         c2DzKDhzFwuzWQ731eFgfs/WtgS3C3NiPb7vFaLlgbOc68UTjXYVpB5aDO0eS+PH3bOD
         b348yOsPIp0bN5QvIMLBylpRD/sydPrEz//Ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763593000; x=1764197800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wMUH8JcfJUm5VqcHHrATjM5Cu9rxqYCl3FUJ90RvcM=;
        b=F8Ds+d+1DD8iEkp8sno6yHJIqS9IKafYC1owWb33EjpzinY6NBDi+5LSYmElmXJPbF
         HaspWGaCLyQTpcRQcJ0MCiroAbE/5BFfa7z+UqkN0P0R5Rm2ii78Gjn4ormN2V1zvkVh
         kUYPT8KhK9dLPbPsajc2hQ4/4p7wgdIvKqXnFt4ZyAnhbra9cQNFyMhdz6449x/ckSCX
         If4cFHdSE5lqyJ/p3fvDSngZ/JsEymUhMqEOSbrvL+Vs4QPptXyBPgdFDu2yYZilNgaE
         HtRcNhxlhBUSJ2p7iaA/fs6FBrcKhlEzDi5jUHoDpWVAVK6WTD127hpPXbHabu4RjD9Z
         Wk5A==
X-Forwarded-Encrypted: i=1; AJvYcCVNmrK9q+zKRtNPX8utfyKEU2jnf2n/tEiyD5hbpUj7P7EjU+07t+5UlCceHzNTtFD3647Xz1gJM5SZ1YALvvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy308Xs0QuRLb8a6ZAy0o3qd72NSzwWLCLhS7jmlX3aOrMu+TcX
	tqNMbQHDP1D5DrlJjIhAySWSV4UM2/TROO8DJ9XLf5AGjdK0CkwMCUr33PEpfbpVlWA=
X-Gm-Gg: ASbGncu9g2+WQtfoHyHMl4Vgt4HcAVnfrz3sciLjVnAbVFCz3RQCbhhGp/s7G4Ro4Ti
	gBGilRJPY/lCFz7RUDBBoWDzQrWLsyxezQ6LkpoNUbY88JT8arhAdDEWxoanrDHxz/hB9wrI/0E
	eznPM90FMf26g2fBrubCLJixHCGcf3D0z/1sJjVEb/KtvjbpWeRXome+K3rldzQ9TKLJOpLHz6/
	ykknQUqIEVWDLRhb+3kJHD92WdPGPd+7aVvXAXSwxpjjS1zIe013N4I/3Og6xZTubHj9wXCH90N
	brxFcw/GnK2R+0RMTHey16CUbvsZ5CCyKl7OouDTmxQXVd+KsaRrc0sM4MxezV55RCzemW2z9Gt
	1cQkTrALU8vVRVtQCj21Fyn6i9RoIkpIVF9qXHp3SEzw5K4sR//4D0QIsYjxAU4UoYEXWlijp+d
	ZdEh5Fo3vn7osOeRmWKvPRcNDBCdU8KA/3wA==
X-Google-Smtp-Source: AGHT+IG4tDZ4F/fO1HiCiZs9PvKdwalM+q64M6x5lrXzcVzNi5nKpIozkdFoGwtK8Z0gwdmZmTuSaw==
X-Received: by 2002:a05:6602:8211:b0:948:a37f:6eb6 with SMTP id ca18e2360f4ac-94938a1bcdbmr58375239f.4.1763593000456;
        Wed, 19 Nov 2025 14:56:40 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-949386912a9sm27794539f.15.2025.11.19.14.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 14:56:39 -0800 (PST)
Message-ID: <9f6f5434-3650-465a-9f67-eeab11954c30@linuxfoundation.org>
Date: Wed, 19 Nov 2025 15:56:38 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: tracing: Update fprobe selftest for ftrace
 based fprobe
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <176295318112.431538.11780280333728368327.stgit@devnote2>
 <f6831d9a-4ea6-4100-9b1b-716ac93e1cdd@linuxfoundation.org>
 <20251119173441.3aa33415@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251119173441.3aa33415@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/25 15:34, Steven Rostedt wrote:
> On Wed, 19 Nov 2025 15:16:04 -0700
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>> On 11/12/25 06:13, Masami Hiramatsu (Google) wrote:
>>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>>
>>> Since the ftrace fprobe is both fgraph and ftrace based implemented,
>>> the selftest needs to be updated. This does not count the actual
>>> number of lines, but just check the differences.
>>>
>>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>> ---
>>>    .../ftrace/test.d/dynevent/add_remove_fprobe.tc    |   18 ++++--------------
>>>    1 file changed, 4 insertions(+), 14 deletions(-)
>>>   
>>
>> Steve, do you want me to take this through my tree?
> 
> Yes please, unless Masami thinks otherwise.
> 

Applied to linux-kselftest next for Linux 6.19-rc1.

thanks,
-- Shuah

