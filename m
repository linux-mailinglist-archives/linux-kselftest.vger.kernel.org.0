Return-Path: <linux-kselftest+bounces-35182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 195A3ADC39D
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 09:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA69016FCF3
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 07:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BB928D8EF;
	Tue, 17 Jun 2025 07:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AP9dpqG3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F62289829
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750146294; cv=none; b=NDpYjFt7vTCazfhGTv3AwZxjLbzQuRudw+wdAIlB42eulUdwooz/5lFmqiaeCUCrthhK9lBHAocsmnn5fDpc025khsgwXQgeVHiOdGsialpuONEcW7F6WqAB2unH+YzLHCfPTLHUt4Kr+JZApOy5fyxniQ+6lucMKMysIp96QTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750146294; c=relaxed/simple;
	bh=mrm9OvjabzG4ehnGWZbOBKsIPmkYF4NA6I7pS1JLPj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q5OnJCD8qaL7C23F7hdJiP3PrpgKEVavYd1ITIfslhxVJTN1988MsEsAlQM35ytqDZhmb6s3wKjd2+mQ3ajH3E9RPPy02mzqvxBNMomU/lhMQlZ0XXFGXwTNobipbXYowP0JUsAG9lZkuEnsohvQ2+yBSrl23bOcW5IObZB0DKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AP9dpqG3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4533a53a6efso1877665e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 00:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750146291; x=1750751091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m2PZPtZXiD/pv22zShXPiBng+Z7Vv94EbItbn+tfTVw=;
        b=AP9dpqG3rRuNzZLOlpQqsz3GBQuA+fBi0dAQJrTqN76W9Nnw2RMdTYfK9Q5cFI1buu
         N8ggVHG6gRYnRGw61EW/0LfKlON4oqytAv9je72mPqgs4iX5ri1VDACrSF4LRkJAVJYC
         7/PCqxz1DoNFi7gsxe2gB3KDWw0UnUe22vai/jvOMnGClOeJyV4tNAZOZ12ybtz2fZrM
         ibiWrCgcewz+DPaNbKzGhDPdjua7uk7gJo9+lin+0xr6RUWuZQhEvrusqbusbfdGUM0M
         g7AAEXOmkJrYNoMwSVBb/A8wytOFsnGAjkSigU0yC7Rm3BiY60S4WNilMKC/mWlCI4p0
         e3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750146291; x=1750751091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m2PZPtZXiD/pv22zShXPiBng+Z7Vv94EbItbn+tfTVw=;
        b=T1V/MhViq0BZP0TtMBDXlC0OXi0mwwcYCsjKkcA4ZikHFUkUDn9asiEZoZH7PCx/2c
         pt4s7ffHA2F6lojGZokvWGLmxD6Wo9Sq0XjXpCpJBHd+1xGtr1L4iAt8SbfiEwElusgu
         PX99nM9Xo0F0K9P/HIe7reN3KpY+PveRDvI3zRo3G+JsznG3w2T7r+ez1KWbOME9kopx
         yBPxOFHv4sYMZ3O65uAD/dIcHE/5aeSY9vLgvDKJ6Moyztq2ojBoe4m+K3B2+9wnq3dG
         n4j1RGXTUJM/JFdlpUfaeI13jOGF+cgQgExhHDWt4+XfxFYNHx/XR0AqrsII4U9m0x8A
         chPw==
X-Forwarded-Encrypted: i=1; AJvYcCXv5fCwwVEEljvAU3xGiqYToNOR+jIllUi0VWlURI73ahxUmM5pCITLUG208eaEisCIE/Z6YhD38LLLwvZ6SAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2gI95MgLKOHsjWmcxQxXKM9tL/Udp2tuq7DA7bIYfCW2mJCEy
	VKasLpTjAHDaVfGQvquwqsy4vC3YcpbVp4jMpmnPLtr2tJvdZ/zCGJUCBUCOB1VJM90=
X-Gm-Gg: ASbGncvDpsmAWUH60GpYd+vfAsY92j4uhYcGJYRmK4jDqD6LVGgvsKEuh2w3uxLsG9p
	LUt0erckSooLeCTJ9tjCUg8tXD2X/MqbNlabGXQ4r9CvtjnHpyniGUN1zoDPqG5IqUJu6WYGF12
	gYZMc+C1CwkP/fTndWHI6osnFdntUJTQZ2u0EWslo5cPJjtMm55hVMa1u2b1svsTugACaYuW1vY
	3boYOgUPUQoWEolSoOGi8bQROWI9aUkj+BVZQlpHu+m9zGKKstMJRdbciTk/Uxgziqmhc5ki+a1
	Rq4hwz6mabYOtqAqX3DJuuMLzmLLSN8evfaCoN1xrBH1msSA374WWWL0OH8nx65L55SNN19kmy6
	I
X-Google-Smtp-Source: AGHT+IGLrB0zawXGR//1I7qhDmE02rezk4o0VJxdGCMaX/Yej/wVeBEiSTFkvWU979RCy9khYyBucw==
X-Received: by 2002:a05:600c:1797:b0:43c:f3e1:a729 with SMTP id 5b1f17b1804b1-4533b27e8e6mr84371805e9.12.1750146290758;
        Tue, 17 Jun 2025 00:44:50 -0700 (PDT)
Received: from [10.100.51.209] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e195768sm167991085e9.0.2025.06.17.00.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 00:44:50 -0700 (PDT)
Message-ID: <fb2a41b2-a872-4fcd-8a97-df3a946c6a81@suse.com>
Date: Tue, 17 Jun 2025 09:44:49 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] kunit: test: Drop CONFIG_MODULE ifdeffery
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20250612-kunit-ifdef-modules-v1-0-fdccd42dcff8@linutronix.de>
 <20250612-kunit-ifdef-modules-v1-3-fdccd42dcff8@linutronix.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250612-kunit-ifdef-modules-v1-3-fdccd42dcff8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/25 4:53 PM, Thomas Weißschuh wrote:
> The function stubs exposed by module.h allow the code to compile properly
> without the ifdeffery. The generated object code stays the same, as the
> compiler can optimize away all the dead code.
> As the code is still typechecked developer errors can be detected faster.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

I'm worried that patches #2 and #3 make the code harder to understand
because they hide what is compiled and when.

Normally, '#ifdef CONFIG_XYZ' or IS_ENABLED(CONFIG_XYZ) directly
surrounds functionality that should be conditional. This makes it clear
what is used and when.

The patches obscure whether, for instance, kunit_module_notify() in
lib/kunit/test.c is actually used and present in the resulting binary
behind several steps. Understanding its usage requires tracing the code
from kunit_module_notify() to the definition of kunit_mod_nb, then to
the register_module_notifier() call, and finally depends on an ifdef in
another file, include/linux/module.h.

Is this really better? Are there places where this pattern is already
used? Does it actually help in practice, considering that CONFIG_MODULES
is enabled in most cases?

-- 
Thanks,
Petr

