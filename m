Return-Path: <linux-kselftest+bounces-5079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C63E85CA11
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 22:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D88D9283789
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 21:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B560152DE8;
	Tue, 20 Feb 2024 21:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eM4rQqMx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D849151CCD
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 21:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708465308; cv=none; b=NsEIZwg0g86dyQy+XaMm8jt5WB2J4jQms5IGcOqp4rF3nmVLFVz8pw/nN/ycFddB6QNHc86VaHumNKgxTHa8qSkiMrREZ8TesH6MqkDAg1GlNKTfCPcxtP/D+NsFm6hLjz6Htwi+iC9QQtGOsDWlPOx8pLCStA1nRcncvv35wm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708465308; c=relaxed/simple;
	bh=8bsrRQott2AAO2XTms6OJqVRQ6zu+Yw6P1VbD+KUbfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eXd73Ic558FXHOLh3SG60nbEqmQuGyyFSAM1w7U9tIDN5UxGdnlpiG4JmuLWc7cPSKCEpBI9rXZQnH3LQzP+oywYcvFhnLlPsShP+kcbeDUaMIH0fTeEPjmf/MRM4e3kA/eKl2J2YnpZ1U0hP7kF/als4F1rv6cLmPIzF9RgWJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eM4rQqMx; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-363acc3bbd8so5514185ab.1
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 13:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708465304; x=1709070104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SpaIw2fjwUqR+/df90gYdTgydOk/VBRkOcyZe3oxMgk=;
        b=eM4rQqMxtvaEC77napcjSs1KAf16jjvfolwA1xEerjUoXttAXcMdNkzRoAYnxWZZ1h
         gu6oM+ooy3hVaTdCuNK9MwDB7TkOkWLBIU2tcCXqkau8LUIo9gCg2B2BOVu9TQyTKlrJ
         pVTlnwQmKSAZZekAoxm80YKv7d7eICmOGHV5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708465304; x=1709070104;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SpaIw2fjwUqR+/df90gYdTgydOk/VBRkOcyZe3oxMgk=;
        b=mpN9OjXvoT4Q/oJuyUpQzbwxs15n9iM28ORm6JL9+Qfx/cQ69yAhn5vVe5B+58Mh2Q
         tUGzyD/zbscezCBD2dhWVFTCOef5WJ5+pOWNwe/mWEJyIBUXmQmjweZfNwNq+WC6wfdF
         jMMSuP/AC1mxeGKRQfnWdBB7mVlL4035kNwOuXSElX3bUlORqANOVR02f1buVqu1xY8f
         0RcMrw1cZ+MXXN75pBjTQgS2l6N5Yt0u/uNAcaO4I9bs7iNYd6MUbhxSUbTZXGtliua2
         txZDfxWPxfIsHQcuubaQNnsSnDmLx5wDY7o9Z+0SCe58CX9cKRM3gHIGiM4/mrLgVlD8
         R8YA==
X-Forwarded-Encrypted: i=1; AJvYcCXk6VcvRgctx+fKphvekiIKs8wD/O7Cbaax46x9kHUctz/Ej/THHnPYqv50TE4gZisasUJxwS7c66Xmu04iHm12yKf890vtzES8OrPXKy40
X-Gm-Message-State: AOJu0YxUlfvoN14Wuuv4RVI4OT3yf2Wn+lM0+cMM+druUtoHygDYFoTO
	Vb9DYPZUdlZ/jz1rQow4P7vfsGI+JuIuwXAZ5AM3VTn2pC45gyFF8bq0j9aG4cU=
X-Google-Smtp-Source: AGHT+IHnc22DIp5TX5eD2xKuhbupC8r+DyPT6CPAZ7gXqMeOVrzQneSYbNs53WdHZjevbLUwpq3wrg==
X-Received: by 2002:a5d:8948:0:b0:7c7:28dc:da21 with SMTP id b8-20020a5d8948000000b007c728dcda21mr11515603iot.1.1708465304445;
        Tue, 20 Feb 2024 13:41:44 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id k24-20020a023358000000b004743a0b8b8csm486095jak.153.2024.02.20.13.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 13:41:44 -0800 (PST)
Message-ID: <5c173f2c-5c5e-4fdb-898a-1eb8531e336d@linuxfoundation.org>
Date: Tue, 20 Feb 2024 14:41:43 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest/ftrace: fix typo in ftracetest script
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Kousik Sanagavarapu <five231003@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240129162841.57979-1-five231003@gmail.com>
 <20240131235236.749931e31721c892b7591118@kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240131235236.749931e31721c892b7591118@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/31/24 07:52, Masami Hiramatsu (Google) wrote:
> Hi,
> 
> On Mon, 29 Jan 2024 21:58:07 +0530
> Kousik Sanagavarapu <five231003@gmail.com> wrote:
> 
>> Fix a typo in ftracetest script which is run when running the kselftests
>> for ftrace.
>>
>> s/faii/fail
>>
> 
> Thanks, this looks obvious typo.
> 
>> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Fixes: dbcf76390eb9 ("selftests/ftrace: Improve integration with kselftest runner")
> 
> 
> Shuah, can you pick this to your branch?
> 

Applied to linux-kselftest next for Linux 6.9

thanks,
-- Shuah


