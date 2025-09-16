Return-Path: <linux-kselftest+bounces-41627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F333B7E5E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04138586257
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 22:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17592BDC0F;
	Tue, 16 Sep 2025 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BkAA8D/1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02B329C327
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758062382; cv=none; b=dGsdDXc8conDeyY+ei38bHBOpkDCtli3bi6jUeHkCahIopxngMAMsWdTZr9Xl04oLAUKa2r4serMFuVnWd+L48lb3uy+Sk+qLtJlqm4UVjqWClrY9+tSID0zVctutLKon+7UVuFh0ulwSNQcM1aDk4Zr+olALDue9EYuB1IrCrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758062382; c=relaxed/simple;
	bh=k0SOfZoXTL+6XpT7LDFJn/Tq3Mu6JeeevxzxgIaMsmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JMffyFqZkbghOPZCRsKHCXNtG1QOL85jt9sXYXadDpPWhHVZutypmTlcAIYUxVny7Gamc4ebX+c+l/1gsl9Kw/veAI+Fgh6uNbfKYI/zMTQicbKpDE1gXhLNCtK2stvsgtdxE92qtE9mqMnhaWD9x2oKEEONvem/d5QxiruqJSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BkAA8D/1; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-827923a97e9so342093985a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 15:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758062379; x=1758667179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywdaVb62eCR3TvAc/4+sZpZzoYKTPBN8q6oGAifJQEA=;
        b=BkAA8D/1/6NCcFJlQD8q6QQQHj1raguXwPyrIhw4GIJc0ZO1z+tfSWboWr2QU0rGLE
         NxgxmMth1RzQF9hnJP5SxRc8XH1VcPypk9OTPa81T3CU/HdKfAytIe1/xgFT9XgqQx2U
         DStqeNofIvkJqE/Y5KjU5n3gz683riqFw3Q4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758062379; x=1758667179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywdaVb62eCR3TvAc/4+sZpZzoYKTPBN8q6oGAifJQEA=;
        b=KJRnMCi05x2Nv4U1gjLSy4KZd0yUUihRmliLFtMzP7rAPNziDFMZs+C6FUH3nl5t7p
         WhDK22IeAyOS1TTzHLboikH6ATBa3hoIoakp3hsRPH/4M7d8g6B7uoKylhdvEkWv+GDd
         xd6WehjPZgki771Z47wH+S/ZuLBFU+7Dy8pZRE6+5zqZWi0/VeMXnYskG75Kfw1P6PAl
         0nohBiPulMXKw3N0qCU7kEYMLqGTSi5+5UOa3IgkYzpIZR/CBJjYsg4O8UCu/P3j+nHJ
         u/d6yWKstBgQij8QIjPZAoVLhxRGkyPp46uW220vskgvqcpYND5s3HlQKfvEEfQZ1ytP
         glFw==
X-Forwarded-Encrypted: i=1; AJvYcCW3iXYaro/IAKf0qwLHXiv9z9nJP5R0+spzCOL9NMQRzsPkMfHmAis1BAJstS64sFApZ4tsaH2+Kn6Pm+c18ko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0NVB5lSYNWkwCUEcbA2MYgoW4CP0KHHXFEa2n+Nm1udAK6Yaf
	byY+obAFiiD92Wa5OPezpU6ar/8ozGzpijbxRVN8ICdLN1w7GDB7ICraYwVWTnqMpvoxXWN5+NL
	vdFLO
X-Gm-Gg: ASbGncs7W75g34YfC8HXQTQxD3lHQkUVMfohzvlAm6SynrJAp9h85P4FkIrNvb3j1rR
	WJjVNOHE1lfb9oCdYOsNuo9OLeZh1BrxSaJduvOkoXCh2g5YdPp65rsrMEpRcEubrWJ0tsKx/Q6
	Uu96LPKjxpUSWgLGeTuIvs1+macoa4Mt7txGh73Ip+9/KC0TXlQWY/n5uIqyelRMfbU/YmW/VlH
	jR1FR7dQhp3Nx+pkQOScKdSGsX9ITeYEez8zOpEitGSsDjKvknvQCR+bJuz4nMfSfQbLe26CWii
	9ue+0QA8P5guuHjWlwZt8npD80X9BmvRrKOXwH0QKOFLtL/GqW1D5zkKOZjxKXYJGQarCmQiy+b
	DNy0uVhYzI62IXpdw7zbwKttMk8jnDorwALTbO/sODEezlP0JbJ3aOYZYw+kxWbo4uAStoKSLSg
	o8CMXMdGZX65jL700YCpOo+rVTWeg25UwoYBsORkWycR0=
X-Google-Smtp-Source: AGHT+IESNgABLBfvwr4hM4tLIKI9UIhpBPnDVjoN9Ta2vfOV0RzKOw0gmHxxKYKx1UMzPUGBzABwLQ==
X-Received: by 2002:a05:620a:450e:b0:811:1212:1b6e with SMTP id af79cd13be357-8311390c126mr173485a.50.1758062378651;
        Tue, 16 Sep 2025 15:39:38 -0700 (PDT)
Received: from [192.168.226.35] (207-181-222-53.s5939.c3-0.hnc-cbr1.chi-hnc.il.cable.rcncustomer.com. [207.181.222.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639cb2562sm87328371cf.13.2025.09.16.15.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 15:39:38 -0700 (PDT)
Message-ID: <f18854b2-f9c8-44a3-a09d-3b2ddbcb971a@linuxfoundation.org>
Date: Tue, 16 Sep 2025 16:39:37 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kselftest and cargo
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
Cc: linux-integrity@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <aMlqouOSU8XN7V5H@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <aMlqouOSU8XN7V5H@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/25 07:48, Jarkko Sakkinen wrote:
> Hi,
> 
> The pre-existing kselftest for TPM2 is derived works of my earlier Python
> based rudimentary TPM2 stack called 'tpm2-scripts'.
> 
> In order to get more coverage and more mainintainable and extensible test
> suite I'd like to eventually rewrite the tests with bash and tpm2sh, which
> is a TPM2 cli written with Rust and based on my new TPM2 stack [1] [2].
> 
> Given linux-rust work, would it be acceptable to require cargo to install
> a runner for kselftest? I'm finishing off now 0.11 version of the tool,
> which will take some time (versions before that are honestly quite bad,
> don't try them) but after that this would be something I'd like to
> put together.

Probably fine - how does this impact kselftest default run?

> 
> NOTE: while tpm2-protocol itself is Apache/MIT, tpm2sh is GPL3 licensed
> command-line program (for what it is worth).
> 
> [1] https://github.com/puavo-org/tpm2sh
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/tpm2-protocol.git/about/
> 
> BR, Jarkko
> 
> 

thanks,
-- Shuah

