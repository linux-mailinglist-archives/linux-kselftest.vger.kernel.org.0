Return-Path: <linux-kselftest+bounces-19060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C3E990F5D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 21:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0F91C228FE
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 19:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBAF1F4FB3;
	Fri,  4 Oct 2024 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fVZLaCzY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3A71B4F21
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Oct 2024 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067962; cv=none; b=NvGZHLI7LPOLwmtfNTxiuOPuM53YgOrQNnkxOf8yFWaMmLLgI3uwUZuuW69Z4t2y9poOYNJvPCJ3EGw1haiARdN3pJ7jVP2kgWoTZ4XDpAyGudzP3Cs52RGqECqSI9D/WWPDBC1NwfzUCkbGxNWWuf4i5LmzL8iqbAOg3MQP6n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067962; c=relaxed/simple;
	bh=H1liXl6WCRf3d4p+fcBF0FY77yXoXZmEbZj3EeAnJ5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iyiEx3zRaabxGHoAEvTFQTfixkk8NM9WwSuJ8dzEU+vBMhhyO66ximiCbFMW7AuReqgjGVEh3ANm2+HWB1tC2UyInZNUr+a33oVZ1uN5Ji284A042vW+SEXHz8aOOBOZB5dp7T/wjgJUuermTVa0TIaSow8eM6baVtXfQSPJGIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fVZLaCzY; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-82aa6be8457so76146539f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Oct 2024 11:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728067959; x=1728672759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l/Rv0sqGHNVWqlijFNhSwA2zn4yItvy6FMRE0t4wpkI=;
        b=fVZLaCzYI+dr80W43/77o3oMuD7jfPWinOchrAhBBbe6dIAe0GDjouHH7YUeUZj3C4
         EZWfmyGC5svPeeysS4rqpIzKTnBb5UwLTavzW57HL4dJazle42YKE0YDUIugXLbfrvDA
         QrcT7GMJgjXbhysdPgvMnrKMshAVZjaGQeKS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728067959; x=1728672759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l/Rv0sqGHNVWqlijFNhSwA2zn4yItvy6FMRE0t4wpkI=;
        b=Wlp50grrecEiDYqCn5uG9smngnkLs7pGCI4JW1HdnBN0ilhCdLAi5pg0i5qEHZO49Z
         sGujwp/9sNv/HKpuWPp78i0dW4eWi+r2xCYOYzyl5vCr1R76mw1LTO3JYS0D84x5l2x4
         TD8G7tGquatC4jyQJOIpsiVt0i91Co1PuzSDUh2PGL8zkJUyr0v8Zt3DeAL0oGSjTT6l
         8NqTd8k8GsvOIaeON4gxGyko9AaE8U+wBt6YIFxXKiS741aCnhV4XMJVF8rAc7zoa8Wi
         KtVamjlm851rfubQRXisyKSe3WIuZQ8p6cbVZbWA5vCPpuBv+Z2ymAa+1N4NVAWfnevZ
         Egog==
X-Forwarded-Encrypted: i=1; AJvYcCV2fE3ioPfXZ5ZEl4J7E0YWWN0dp1BpUSiFNuHIck5xiL3UnfDOfcX/Ys0CQ2cHVbUwAQOZJ4Erumtz7ZFH8P4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzJnDXolVVqPFILfc2oyVltUiNAoJlP4kJXInFlibiNysroNtG
	+xcVKej2EkgRl6npsCaa4AnuxpsfMtmwPi9pRhoJak+cN7SzSIM9WdM2Uv3tPMo=
X-Google-Smtp-Source: AGHT+IEXjDH5NQ6LBrFWdalYdLYXSsRTT0eo0VO5eqEv564M8JzXzPttDhozW5v38kXoIzRDxfoLQQ==
X-Received: by 2002:a6b:6818:0:b0:831:e9eb:dea7 with SMTP id ca18e2360f4ac-834e77687c7mr574002039f.8.1728067959455;
        Fri, 04 Oct 2024 11:52:39 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83503a756b2sm7310139f.4.2024.10.04.11.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 11:52:38 -0700 (PDT)
Message-ID: <fd9fb256-11ac-45f6-b584-c2e9c1b04c58@linuxfoundation.org>
Date: Fri, 4 Oct 2024 12:52:37 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: Do not skip BPF selftests by default
To: Mark Brown <broonie@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241004095348.797020-1-bjorn@kernel.org>
 <96023ef4-fa0b-4fc2-a6a7-ac32bc777c44@sirena.org.uk>
 <875xq82dqe.fsf@all.your.base.are.belong.to.us>
 <bb579569-1451-414f-aac4-12757024d9a5@sirena.org.uk>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <bb579569-1451-414f-aac4-12757024d9a5@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/4/24 08:46, Mark Brown wrote:
> On Fri, Oct 04, 2024 at 03:34:49PM +0200, Björn Töpel wrote:
>> Mark Brown <broonie@kernel.org> writes:
>>> On Fri, Oct 04, 2024 at 11:53:47AM +0200, Björn Töpel wrote:
> 
>>>> This effectively is a revert of commit 7a6eb7c34a78 ("selftests: Skip
>>>> BPF seftests by default"). At the time when this was added, BPF had
>>>> "build time dependencies on cutting edge versions". Since then a
>>>> number of BPF capable tests has been included in net, hid, sched_ext.
> 
>>> The issue was always requiring a bleeding edge version of clang, not
>>> sure if that's been relaxed yet, IIRC sometimes it required git
>>> versions.  I have clang 20 installed here so that's not an issue for me
>>> but given that that's not released yet it wouldn't be reasonable to
>>> expect CI systems to install it.
> 
>> Yeah, but I'd say that is not the case anymore. LLVM 18 and 19 works.
> 
> Hrm, that's definitely a lot better then though still a little cutting
> edge - the 24.10 Ubuntu release has clang 17, never mind any of the
> stables or LTSs (Debian is very popular for build containers).  Not
> quite at the "you can just install your distro package" level yet though
> it's definitely substantial progress.  Is this requirement documented
> somewhere someone could reasonably be expected to discover it?
> 
> It's a bit unfortunate having to pull clang into GCC build containers,
> and needing a newer version than the minimum clang for the kernel itself
> too :/
> 
>>> We also get a bunch of:
> 
>>> die__process_unit: DW_TAG_label (0xa) @ <0x58eb7> not handled!
>>> die__process_unit: tag not supported 0xa (label)!
> 
>>> if we do turn enable CONFIG_DEBUG_INFO_BTF for arm64.
> 
>> This is pahole version related.
> 
> Which version is needed?  I've got 1.24 (from Debian) here...
> 
>>> The whole thing is also broken for cross compilation with clang since
>>> everything is assuming that CROSS_COMPILE will be set for cross builds
>>> but that's not the case for LLVM=1 builds - net gives:
> 
>> A lot can be said about kselftest, and cross-building. It's a bit of a
>> mess. Maybe we should move to meson or something for kselftest (that
>> requires less work for lazy developers like me). ;-)
> 
> AFAICT it pretty much works fine?  It's certainly widely used.
> 
>> I'm simply arguing that the *default* should be: BPF (and
>> hid/net/sched_ext) turned on. Default on would surface these kind of
>> problems, rather than hiding them. (And let the CI exclude tests it
>> cannot handle).
> 
> The original motivation behind that patch was that there were a bunch of
> CI systems all trying to run as many of the selftests as they can,
> running into BPF and getting frustrated at the amount of time it was
> consuming (or not managing to get it working at all).  Everyone was
> assuming they were missing something or somehow doing the wrong thing to
> satisfy the dependencies and it was burning a bunch of time and
> discouraging people from using the selftests at all since it doesn't
> create a good impression if stuff just doesn't build.  People did often
> end up skipping BPF, but only after banging their heads against it for a
> while, and then went and compared notes with other CI systems and found
> everyone else had the same problem.
> 
> I think we before defaulting BPF stuff on we should at the very least
> fix the builds for commonly covered architectures, it looks like as well
> as arm64 we're also seeing BTF not generated on 32 bit arm:
> 
>     https://storage.kernelci.org/next/master/next-20241004/arm/multi_v7_defconfig%2Bkselftest/gcc-12/config/kernel.config
> 
> but everything else I spot checked looks fine.  It'd be much better to
> skip gracefully if the kernel doesn't have BPF too.

+1 on this. I would rather have tests check for their dependencies
and skip them. Let's fix the tests to fail gracefully before adding
bpf and bpf dependent tests to default run.

I saw your patch to add sched_ext which shouldn't be added until
we get these resolved. Maybe you could include the checks to the
following patch to fail gracefully if kernel doesn't have BPF
and the environment doesn't have the dependencies installed.

Makefile could handle some of these and skip build instead of
failing the build. Individual test build failures shouldn't stop
kselftest-all build.

https://patchwork.kernel.org/project/linux-kselftest/patch/20241004094247.795385-1-bjorn@kernel.org/

> 
> We should probably also have explicit clang presence and feature/version
> checks in the builds since clang is now fairly widely available in
> distros but many of them have older versions than are needed so I
> imagine a common failure pattern might be that people see clang is
> needed, install their distro clang package and then run into errors from
> clang.  That'd mean people would get a graceful skip with a clear
> description of what's needed rather than build errors.
> 
> This is all a particular issue for the net tests where the addition of BPF
> is a regression, not only can't you run the BPF based tests without
> getting BPF working we've now lost the entire net testsuite if BPF isn't
> working since it breaks the build.  TBH I didn't notice this getting
> broken because I forgot that I was expecting to see net tests on
> kernelci.org and the build break means they just disappear entirely from
> the runtime results.  That really does need a graceful skip.

This is unfortunate. We have to fix the bpf dependent tests to do build
and run-time checks.

We can add the tests to default once they can work properly without their
dependencies.

thanks,
-- Shuah

