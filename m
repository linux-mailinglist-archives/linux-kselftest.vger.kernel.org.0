Return-Path: <linux-kselftest+bounces-36718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF3EAFB9AD
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 19:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687AD3A4AE4
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 17:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283E62882D4;
	Mon,  7 Jul 2025 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMwSnvLg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793212417C2;
	Mon,  7 Jul 2025 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751908197; cv=none; b=cFyGOwtuvnRTxJm0GBuT5Z2STZ6WQV1vOQ3wfV5EzPUWP2KZ1kFkKOLACZJjTsi91JKhCksHlBZEoK4SEElxBSw3GxQFnlDUBdbGtOOf3skjlohFb20WfZxijuApIttsp4OL85Br7bpQIgJmMLl7zRfdwGXsKYYIi4VOU1xIWzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751908197; c=relaxed/simple;
	bh=0HdMLmITIOrRNDoFBZd+CMGUd8SVnkRZvs65pQNjUpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cjO1Eyh8pMwX2sqE5Q1FZUXxWQi2tQDCps3INfJv+pfdqWOKUcsu+wr4dLSZqsvaunJyQJLEzFVlqeAqtc11FfpP5vzI5ii026bLTYduNPDc6cqLjplgcKH8zIjaYdjtkXkIJilPnDL2gcM8L/XL1biSQqp3hjknzJ4ausijIbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMwSnvLg; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553dceb342aso3016538e87.1;
        Mon, 07 Jul 2025 10:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751908194; x=1752512994; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RFm8eveawNsx96R40m6TGSfuSzG4In7syDIMdfZZEOQ=;
        b=aMwSnvLgq9oxfeOquJwXBOZUHe3/+ArSRGBy/6S/N8WuWletHjqmMWOce5qJnvATFJ
         S7Q5utq9Hx9HdR00io95BIMkQdG9ixsLdj2vE+lfoLQn1SBHD8ReQZCFUnwJMTMunBUI
         7Lxf4HN/qgty091UyayMPJ9nqU0LlSjHJJgEZAB4a2SuKlpp0kX73dceVUAqwcxx+ihc
         jScHZyTHfpzmpXINSdPwvNW72mlYn/jyJ7XVULScex8c+BBeJa4LufA3ndnbW4yeCS/s
         T5edDnpcFmLqxk6nMds3HQLGPEIGjBCFmnwx4j4T/bx6VxjYqWe/YmcxhTqnXPzI7an7
         5GGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751908194; x=1752512994;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RFm8eveawNsx96R40m6TGSfuSzG4In7syDIMdfZZEOQ=;
        b=OHU+TYZgk6H/s3ABEscXLv71f0ME5UwCGi1QuT6ThNlZCJ6gho4MAQC3tGLHpi9L14
         pt89+xiE8GOzXerLymw/1h+c9eiUgRY9dbwRT3e/FMgcXnjgxBUiuZ30bMIO4K9xPww0
         1nE81PMnhdtV6SDxNfNqrtAmJFUdYRjDcFEecRtQCeaExea0uL1s8CIB64gO71Qc9FMe
         QXCZyRMZEAZWN18jtStiMYZu16EhJ3RvC3fn/yFYds8fwBdKDFhaCLdoLSbBrFqEuZRt
         eE36m8l6OOo69ESD53q5Yf5fnyP4NIsbHtpdiYqbkA9TJAosuFpEqxxtPJaAi4c1dwLr
         km4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9MoR8ts8J96n/u2UAnUaOHVkLwenfsbfXjgMzvcvgtCRA0YbURQBiM2fG7tkT305fJz+PCttpxBaN5Jc=@vger.kernel.org, AJvYcCVPqww+yT7JfXgZdumqJisW7HPwq5xnGb5rNOOhi2IY74038+N4S792w6H4yQ05q7D5EmeSGuVNbGANaQCwzEtr@vger.kernel.org, AJvYcCXCZxwsWzazGTaTfNujMw6l3+5d1LLjiXbHhf77N75KFz2MfN7cF/0BAqYvqL+tPPRNBYaw3Li7lOEd541i0xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQAziC3Ozp7rkT/kWM05jG+NQRaW4SREGs9M7mUBFGnFpf2OX8
	OHhNXW8m1NVZAc22k9Dm29r1FfDubieBapKUyFCMkbl+1J6R9us5d61vfKvXK24KsmrlWLQ6rL5
	gP6lvnnA2C0kCKHNtjEUZ83tyc8YGVtk=
X-Gm-Gg: ASbGnctOMvOqpCNCn0Cff5tQaQJqiXHs/fyI6P8NlLilBqX05dsuM25NOurEf0I+ZjA
	FzKgn0U5dMhSvcI8Qru+uxwpsjx1R+9PXdcd9Dnq0FW9ooSJHbKxeJ97vShQ4jAYU0NosT+KSDK
	3S5G2iTrU0+XlAU/ZiW9dWv9lHT0Qg3IJpgXDpN2gWzTo=
X-Google-Smtp-Source: AGHT+IFgUI0RcckL84spjIXz0YFyQCOKX7+Yy/++IUVFouwWTkBCSMU9koQPZosfgDdQ2IOKdM0uG4yxdPGJIswyGLU=
X-Received: by 2002:a05:6512:2c90:b0:553:2c65:f1ca with SMTP id
 2adb3069b0e04-556e701d248mr5128771e87.19.1751908193283; Mon, 07 Jul 2025
 10:09:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250706201855.232451-1-sergio.collado@gmail.com> <20250707093836.GC1099709@noisy.programming.kicks-ass.net>
In-Reply-To: <20250707093836.GC1099709@noisy.programming.kicks-ass.net>
From: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date: Mon, 7 Jul 2025 19:09:16 +0200
X-Gm-Features: Ac12FXzmFrOduSMY2DKFPoPKqRTHecH9BEHt1cRsHjmGbm2JBEI1B1DVL3fyEQI
Message-ID: <CAA76j90WCAm0Zm5vcv5S3mBkZVzSUCC4S5N2F9G20G5WUsFirg@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] kunit: fix longest symbol length test
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Randy Dunlap <rdunlap@infradead.org>, rust-for-linux@vger.kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Nathan Chancellor <nathan@kernel.org>, David Laight <david.laight.linux@gmail.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, x86@kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

  The initial goal was to verify that a KSYM_NAME_LEN of 512 was
working as expected. It also fixed an issue in
/x86/tools/insn_decoder_test.c.

  This fix is indeed quite trivial, I just implemented the suggested
ideas. Amend the test using KSYM_NAME_LEN-8 doesn't really seem to me
to fix the underlying problem (I also don't know if there is any magic
value).

  Take into account that he actual warnings that have been reported in
the CI ("Please increase KSYM_NAME_LEN both in kernel and kallsyms.c")
 are not from this test, but from
https://elixir.bootlin.com/linux/v6.15/source/scripts/kallsyms.c#L146,
the test has just make that warning evident. Would removing that
comment be a better solution?

  Nevertheless, acknowledging that we don't have full control over the
symbols' names, is also an interesting insight.

  I will be happy to address the issue in one way or another, no problem there.

Regards,
 Sergio

