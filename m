Return-Path: <linux-kselftest+bounces-42945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F24BCC5B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 11:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E06CF4EEA63
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 09:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684FF261B9D;
	Fri, 10 Oct 2025 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bt82sF3+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9673423AB9F
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Oct 2025 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760088736; cv=none; b=c2BZXegOrTWjTDjZlGPF87zy10Z4FWl6ggF1pxEMqaUjwbmGCjtdhoWB5qdPLh3W7MoiA3RR/063wW1ROjo6wIa5tsBpmwM3H21j/L3TZyraCM62Pb21pxgaLzV4uXT3jw7xLg4WCDQ5SlZA+mBsxGd/wb6Oq353LeyXyTeHTog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760088736; c=relaxed/simple;
	bh=3n+/PuX4xKfzOn3Pk3YuBv65d8E2XKe0ZY0j62zMu5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NKb+nttwfrIwL90McpPZkQeh0PzMXo7Nlvdh2sWFKsl3dEh9IhFNpizWJfc4X2x2fIPcABxYPV+ww0x6v0izcjWnGAkQp92jsNelQXhQ/cSbB9cIzut6OlUB6AUyf1NbSzfrkB02lG+UdaNa6jFJDwX9KO4fCRfhjWMOsk3b1zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bt82sF3+; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3ee13baf21dso1615567f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Oct 2025 02:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760088733; x=1760693533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TEpMCsNexUqXFV3HphEqSGQQa1/8ZtyBl4COb7naegU=;
        b=bt82sF3+lV1DTMfLEJPwDiLzazza2AdpkByuMXMmc8kiJ7EZicJs+7QHXsSvz+SpQ8
         LnjrLv+xzAKU7GnycbxAsb6wT8p9+8pKaBBNlWMsuDkDa3oxeF7h/GE0LoWjuUNV4Kkv
         Jshg0mT6c1Y/K9EZuy+BLOlOVYe0H1Ne78vTFUv6tg64/aY+QhJEpW7LtTtL1lyDBPUK
         pxmPxFMSU6XgmD3L9MH81PE7+WD1gvG1wIJaECjIY6KCiWR1Br6QVXPEAVw+b48iLtJ9
         pF0sCVuoRD2g3qkL8xIPbor9AZOFEjIi6ZZqaqBlJjocB/222vtVzm6MnE6qu00Vpihy
         wWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760088733; x=1760693533;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TEpMCsNexUqXFV3HphEqSGQQa1/8ZtyBl4COb7naegU=;
        b=HF4bD0A9xvPCSTR74Jx25lpuUwdC826+kLIXUkah4cm6i78LriCxQIrUV2Kr0/JuNd
         OSn7l0ZjJyUNoic2GxiuNHfnsgbvyYr4UvpCFkVCFj6R3tQl6u+WC9Jpqp8kmHQK/6yl
         aNXPb9xSkvhY2MXk2ZhH+hlDA6tmfJM5So+4fYiKwKGnVRHWWNziaoK4/y+80Webk6rD
         ySDZnBpe2LL3j7IIB3+GY+DhsEhe2e3qqIaRjwtRHnAHMqhvc6uFPnRgrrtsIGqR/eOW
         EiaIUx+agjVu9wzblixrx309ZZkoTe1EI4czSnE/wXKklymufNbRdhRr+tUYnlqQXOyn
         jhXA==
X-Forwarded-Encrypted: i=1; AJvYcCWgVLygMlq96ghITavne/akLtba7rhMuT3LlSSO+Z9qoFjRyKoeSSb5JDC+CSSdVMCiuwf+W9HXXJF25UICYT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBULeFEHpWUHMrJE5OHFiisXR/pLZAfhaG4UTm4GG3nWlTN++S
	0NoArgVfUOzJrSxUHCm65a6qcheJdiMkC0n5PydDDQ/KggEe+2/9cWY4Sq+WlnX3qqj9j1lS/Nv
	FR5jflQkaoT8XFw==
X-Google-Smtp-Source: AGHT+IGMIeEfpOAUAWc049vIU3CiOvZxV3DyvsEN7g3HfwV+UjKQInLrwgOHvMdE62gWE3zcOIw/MK4QdR5oDA==
X-Received: from wrqw17.prod.google.com ([2002:a05:6000:18d1:b0:425:f04a:4d7d])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2283:b0:3ff:17ac:a34b with SMTP id ffacd0b85a97d-4266e8db451mr6680816f8f.42.1760088732819;
 Fri, 10 Oct 2025 02:32:12 -0700 (PDT)
Date: Fri, 10 Oct 2025 09:32:11 +0000
In-Reply-To: <20251010082310-b25e69f3-4568-4886-a0c9-3bd611bce073@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007-b4-ksft-error-on-fail-v1-1-71bf058f5662@google.com> <20251010082310-b25e69f3-4568-4886-a0c9-3bd611bce073@linutronix.de>
X-Mailer: aerc 0.21.0
Message-ID: <DDEJDSXMTE64.2LRRDLAWFPA0T@google.com>
Subject: Re: [PATCH] selftests/run_kselftest.sh: Add --error-on-fail flag
From: Brendan Jackman <jackmanb@google.com>
To: "=?utf-8?q?Thomas_Wei=C3=9Fschuh?=" <thomas.weissschuh@linutronix.de>, 
	Brendan Jackman <jackmanb@google.com>
Cc: Shuah Khan <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri Oct 10, 2025 at 6:34 AM UTC, Thomas Wei=C3=9Fschuh wrote:
> On Tue, Oct 07, 2025 at 11:06:46AM +0000, Brendan Jackman wrote:
>> +report_failure()
>> +{
>> +	echo "not ok $*" >> "$kselftest_failures_file"
>> +	echo "$*" >> "$kselftest_failures_file"
>
> Both of these go into the failures file. The first should go to stdout, n=
o?

Oops, thanks.

>> --- a/tools/testing/selftests/run_kselftest.sh
>> +++ b/tools/testing/selftests/run_kselftest.sh
>> @@ -36,6 +36,7 @@ Usage: $0 [OPTIONS]
>>    -n | --netns			Run each test in namespace
>>    -h | --help			Show this usage info
>>    -o | --override-timeout	Number of seconds after which we timeout
>> +  -e | --error-on-fail	After finishing all tests, exit with code 1 if a=
ny failed.
>
> To me it looks like the new behavior could be the default,
> removing the need for an additional option.

That sounds good to me, I will wait a day or two to see if anyone
objects to this before I send v2.

IMO it's important that your testing systems can tell you the difference
between "tests failed, your code is broken" and "I fell over, the
infrastructure is broken". My thinking was that if anyone's using this
in a proper CI loop, they won't actually want --error-on-fail because
then they sort of lose this distinction (nonzero exit code means "I fell
over" while "your tests failed" is communicated through KTAP). But, now
I think about it, this script is running on the kernel under test so
it's not capable of making this distinction anyway. So default SGTM.

>> +kselftest_failures_file=3D$(mktemp --tmpdir kselftest-failures-XXXXXX)
>
> Quoting?

Oh yep, thanks again.

> I'm not a fan of the implementation details, but also can't come up with
> something better.

Yeah, I feel the same. I think the next best thing is to rewrite this
whole thing in a proper programming language though.=20

Thanks for taking a look :)

