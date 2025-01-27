Return-Path: <linux-kselftest+bounces-25225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 229ABA1D562
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 12:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5551887585
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 11:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7F31FE47C;
	Mon, 27 Jan 2025 11:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LHX4Pa2z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AFA1FDE18
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Jan 2025 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737977756; cv=none; b=tf43DdelUsbiq/JyUn2sOkhvIZPUXKnI5lZvhBco6bV4kSpEF0a9eKmQKIHRYGvCGuvWxMbFkuvU3FY0s9VixfvAN//gp8CPLaailD19vAvYO6ywj69W1K3GGWS06as05/BuZ7BBjQ1zIke+LLGNItAJDPFDHRwLECM55Gq9oPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737977756; c=relaxed/simple;
	bh=T8lXwYoK0x8G1t2lmU/P5kGh81LSYe5bQFAp3RP4o80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adgf55uCO0htaOQVr0plVvYgxW+ASpu1a2IfXgYEJYZg4PrAer9+p10ZfDHQgbGd3spEDF+1vKYBrDHh89NM0zMQTGGmfnF4oYmmT3e3RFMUmNPzieHOFwX5nS+Xka9cgW5YpbxFrsSGFuU1AOFBlsn+uQTZmv//yb4LBTzCsrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LHX4Pa2z; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so7430486a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jan 2025 03:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737977753; x=1738582553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8zb5dDSWfAPbQtfcZhMyII0+GP9Q7wdaQN5r+kGdVO8=;
        b=LHX4Pa2zARDIKSi8hn+/q6AhFQ/zEEjz0glbxYfLCjw0+rkoz82V0RQDN9MdoiU4vX
         kC+O6XoarnhG2wTIsRYQ/viy8m2gtVNQGeeAFwsulxB7u8VbMEZwia2uzdfdXeK3pVjc
         Yn7tEu+pUCZtnHHvZSE6sjkYQkPChgxtNmVBbeHa8csM+ZwM+Ruk5ObgMj9JqeTePrkv
         LNz5j06PTbWqRJ5mLRGcOG9DSgdrqMkFgdTH4e+FpA5Hq303V2RlDuM4Sp4GO5JggeSM
         38T/Q0XNsfcqWgioj7BdMRYJs2+Uh4d7OJyrj6PcT0P5WdqwtwsHe3lt554SNX/AAKqu
         NeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737977753; x=1738582553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zb5dDSWfAPbQtfcZhMyII0+GP9Q7wdaQN5r+kGdVO8=;
        b=wN+gFODHayNC/5Vi+AHF4ae9qB0liZK1xWiSuODELSCT82PCKXYHB9ADyHa1kOSWA9
         z8vh3NGhPrv15ep30HaF0R+nN/EPea4AndUakS3QD8fugdbdnQ9vFHBsHoNRBC0UXkk8
         COH1hSXg+9qyNoKDVi5RKGMWa7TgNk100PHYr019+zEi3WMgvxvei9sdAyMotVoq/P/x
         8YDce4GsHh73APbZMW1BWAXZiLoMCSDGE4MMPuXKgXOMxU9fhogNWvEuEMJtLZ46lO+Z
         VgsF5/Sl/G12InLlJa7ZdWofYOfNfYqhBwdorHiBsKOzKr0SWVzffKNQiJdQd0aJQhmb
         ZS7w==
X-Forwarded-Encrypted: i=1; AJvYcCXmooPOlCceJUyWt8znpe7MtGcE+C+0ulaX19kWgdyZf9/49tEP+MyIKhs+S26u2/xiEMfHp4BVLCtz8dpOVM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9R7e72gQGCCmXLHicPzmDZsxf9rOcaL0cG3iDXpE4rsp3Q1Tt
	1x2wjahHXwJX3wmz+ERDJyn6Q+nmenNmkE1+583Ouv5ZGXQWeyvO4nXpGBV+omk=
X-Gm-Gg: ASbGncsK4Y6OZtpGMR10Qv/y9xaLNcSe/BicGl3Ht4DFfsO02wsKgZjl/hWzZSRAjbc
	6OWyxHuJ0kMuHMQ9/erhywjDY8ANVhmvpynNQZPJFfdM3nwjlB/7uZnUJEYsgROMvWiAkeN5zXw
	W9o9c/BlVU7K9wNnKC+XGsfNLa5Jb/ZKihz/zoy/37zEpH1TV/yhO0A3fGllRNq3xLIUp9fw69j
	g7y4BY2j0slwcV3zfcAZbAXoYoru/YtTMs9Az7TzNNczcocdHl/Bodsd0wQwzwG9AMMn+6/HLYf
	vVLQJnA=
X-Google-Smtp-Source: AGHT+IES/sxEF+BZSWJQAk5rNdbZSsrSF6vi3KXJQiYSQuO9FLRRC5atvuAKwpmQ4GGZa33a2aw0kQ==
X-Received: by 2002:a17:907:60cc:b0:aab:c35e:509b with SMTP id a640c23a62f3a-ab38b4bb44bmr3667711566b.55.1737977752859;
        Mon, 27 Jan 2025 03:35:52 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fbd46sm574262766b.135.2025.01.27.03.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 03:35:52 -0800 (PST)
Date: Mon, 27 Jan 2025 12:35:50 +0100
From: Petr Mladek <pmladek@suse.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: jikos@kernel.org, mbenes@suse.cz, joe.lawrence@redhat.com,
	shuah@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, naveen@kernel.org,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] selftests: livepatch: handle PRINTK_CALLER in
 check_result()
Message-ID: <Z5dvluAy6miSNyw4@pathway.suse.cz>
References: <20250119163238.749847-1-maddy@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250119163238.749847-1-maddy@linux.ibm.com>

On Sun 2025-01-19 22:02:38, Madhavan Srinivasan wrote:
> Some arch configs (like ppc64) enable CONFIG_PRINTK_CALLER,
> which adds the caller id as part of the dmesg. With recent
> util-linux's update 467a5b3192f16 ('dmesg: add caller_id support')
> the standard "dmesg" has been enhanced to print PRINTK_CALLER fields.
> 
> Due to this, even though the expected vs observed are same,
> end testcase results are failed.
> 
>  -% insmod test_modules/test_klp_livepatch.ko
>  -livepatch: enabling patch 'test_klp_livepatch'
>  -livepatch: 'test_klp_livepatch': initializing patching transition
>  -livepatch: 'test_klp_livepatch': starting patching transition
>  -livepatch: 'test_klp_livepatch': completing patching transition
>  -livepatch: 'test_klp_livepatch': patching complete
>  -% echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
>  -livepatch: 'test_klp_livepatch': initializing unpatching transition
>  -livepatch: 'test_klp_livepatch': starting unpatching transition
>  -livepatch: 'test_klp_livepatch': completing unpatching transition
>  -livepatch: 'test_klp_livepatch': unpatching complete
>  -% rmmod test_klp_livepatch
>  +[   T3659] % insmod test_modules/test_klp_livepatch.ko
>  +[   T3682] livepatch: enabling patch 'test_klp_livepatch'
>  +[   T3682] livepatch: 'test_klp_livepatch': initializing patching transition
>  +[   T3682] livepatch: 'test_klp_livepatch': starting patching transition
>  +[    T826] livepatch: 'test_klp_livepatch': completing patching transition
>  +[    T826] livepatch: 'test_klp_livepatch': patching complete
>  +[   T3659] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
>  +[   T3659] livepatch: 'test_klp_livepatch': initializing unpatching transition
>  +[   T3659] livepatch: 'test_klp_livepatch': starting unpatching transition
>  +[    T789] livepatch: 'test_klp_livepatch': completing unpatching transition
>  +[    T789] livepatch: 'test_klp_livepatch': unpatching complete
>  +[   T3659] % rmmod test_klp_livepatch
> 
>   ERROR: livepatch kselftest(s) failed
>  not ok 1 selftests: livepatch: test-livepatch.sh # exit=1
> 
> Currently the check_result() handles the "[time]" removal from
> the dmesg. Enhance the check to also handle removal of "[Thread Id]"
> or "[CPU Id]".
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>

JFYI, the patch has been committed into livepatch.git,
branch for-6.14/selftests-dmesg.

I am going to create a pull request for Linus' master by
the end of the week or next week.

Best Regards,
Petr

