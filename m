Return-Path: <linux-kselftest+bounces-27398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB37A4310C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 00:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC98A188C469
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 23:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA8A20C479;
	Mon, 24 Feb 2025 23:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bU8SkymR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D8620C008
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Feb 2025 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440345; cv=none; b=VDZDEnbiONN/uviUUBnago0em1R6eenT/YjgKN5wCQq5gRpg9A3Wd4Ik2agU+VsxQ2dFMCcL3o6PA0FRqzTng9IECS5IDGBlb3rc78P4jPUuEoNHGqR8Hp8QY6KkP4lIttgV1LfV5ieB2MUyItz1Q+EHZlc/73FXdcghKw5bB1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440345; c=relaxed/simple;
	bh=3lVc+5dTZiFq6wniYAuvLFwKTWVN+4997r/543iUdgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n5Zu2Kbtl5pZ697+1/SUi//W3KVt1ZJmUn+6jtPWWxeLlMgXs+tcJjP9CK4TUG9OLL3S0pix18mczZZIlpsJ7dW5WeCP1UUrQgoYw5e7kdTE7q6Uze8VN1DccpE6HtUP36ZSv1iVZ7GV0LeMnCsZp/Z9tF3aDRTTEqt0NMUoCr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bU8SkymR; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d191bfeafbso17084925ab.0
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Feb 2025 15:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740440343; x=1741045143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7OigUoZkxEnMYhFf3bc5EZSymLsAcud3EtHTg6CnR24=;
        b=bU8SkymRymsfb6ksl/WHIyuMkwt42yfFMreECVeOnwCf2uHf1SQ+wPm2lVglPhVVzV
         udz1P0Bsfyi4LhL71XaH8rhAQmrkMd65KveffVoXNGYBAHRMlHS2wQgNk0fVkBoV1xPc
         baCihYSsJQ7nnjIarqVUZ5JYZGK8rRZ0E4vY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740440343; x=1741045143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OigUoZkxEnMYhFf3bc5EZSymLsAcud3EtHTg6CnR24=;
        b=tYHsEm/Xkv0dIPFRY3MXfJkS+yVy2jFudBb8JbUFyLMteXS3EdZ5xRzBZ5qlfCG9pm
         eTlXHwvLQ7RYh88arMtyYyZyqdCO6kchcCl43RncdcDeIKqOGye0WYgjNa9T3QTovKML
         2UVnIjfpo0J/+zlA2F9/7Qf3eAJFuswBC08Fcl9YlJT0SqPElWkagyWbCxAuXtxmRfgr
         X2dSUFkv8vRQJ79ZWne4JQoahFO6dbDOspuChwVrjgsDdsqUy0p5b8gJqJY4T/fMyzgH
         xpP3QWzBraNwqHC/SJ/t2mqO2qm6qDwpH7p82PqLWhVPP2snRcoulnPOCBljwMa82Lmk
         fQbA==
X-Forwarded-Encrypted: i=1; AJvYcCWZvkDr2hPf4NmlIusfkuJtLReL3/nwoN56Z3cdeg7CW4gwivJGMBySVB79CrEC9/LUepgsaE96ohu0v/FtMRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKrv0iTrLOnE9nRVqTdmhFUc+oy7nfXTsaK0GNkc+JgJ1I26+H
	g10wp90wwMQm4fVg8/zpmqvdrXX6CNBwKhc0oCFwY5AYEuEeaDHfipyouqE9MsU=
X-Gm-Gg: ASbGncv5HdykxMR7H5cZ/Zmi9SMb/0Nncu11zI7NkMRsvMevxEprug1b3hMgD+Xu0MZ
	TQDFz1kh3QJjpc84Mgrvj73749sfQWZjls/JTsYyL3MM41zlHSoabd2qo14sA1gg2Lz/7JeGWBd
	ZD4nAG5Dx+vqtKqendDTSeNZbom8rMflnLPoQOeJzTRyhqzI8gqlfucaWyHH28AI2QsEcO9tY++
	u7vao+hUa5YmvVvuQlke+LGaGIayhdb2pz78AMPg8TXQUTRVb+ZOgm9zdb4N5m1wwgiUMdXCPy3
	QrHkygAwhcAeJ04gPHgLACcFJPszkzCLlDUz
X-Google-Smtp-Source: AGHT+IHwgh0Tkg2+nCDdsaRpCpyME0bSd2DyoWo9EL78dGtAoeJm0IkIF6S9zRdlQR3TVricsokBug==
X-Received: by 2002:a05:6e02:144d:b0:3d2:b34d:a25b with SMTP id e9e14a558f8ab-3d3048a664cmr11647415ab.16.1740440342885;
        Mon, 24 Feb 2025 15:39:02 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f04744b536sm134991173.17.2025.02.24.15.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 15:39:02 -0800 (PST)
Message-ID: <2bac45a3-bc90-4740-a7ae-051de52eac60@linuxfoundation.org>
Date: Mon, 24 Feb 2025 16:39:01 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests/user_events: Fix failures caused by test
 code
To: Steven Rostedt <rostedt@goodmis.org>,
 Beau Belgrave <beaub@linux.microsoft.com>
Cc: realxxyq@163.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yiqian Xun <xunyiqian@kylinos.cn>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250221033555.326716-1-realxxyq@163.com>
 <b62b6dbf-eeb1-495d-a86b-38f05a17d60e@linuxfoundation.org>
 <20250221122842.379198f9@gandalf.local.home>
 <20250224192105.GA48-beaub@linux.microsoft.com>
 <20250224142624.47733377@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250224142624.47733377@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/25 12:26, Steven Rostedt wrote:
> On Mon, 24 Feb 2025 19:21:26 +0000
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
>>> Beau?
>>>    
>>
>> I applied it locally and ensured it passed (seems timing related).
>>
>> Acked-by: Beau Belgrave <beaub@linux.microsoft.com>
> 
> Thanks Beau,
> 
> Shuah,
> 
> Please apply this patch:
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve

Thanks. Applied to linux-kselftest next for Linux 6.15-rc1.

thanks,
-- Shuah

