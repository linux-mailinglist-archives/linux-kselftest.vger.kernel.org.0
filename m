Return-Path: <linux-kselftest+bounces-24176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36016A0860C
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 04:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC68C188B573
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 03:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6196A205AD7;
	Fri, 10 Jan 2025 03:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="eBUZwVGD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E532A1BA
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 03:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736480071; cv=none; b=ACw/8BmWYRHLar8JIBsK7Zx+ETstMIBIsPdwkqWNV0e4dMxoKk/YcoUPkPo5lQh3IN7PXdGFN0Iobw9Eyaoo7jLfWMmD7TTuYAJIB3P27I6LwKg/BwgYfZvxthqJsGySkacVMTwA+qUDrScJSJrJsdnn50JYft9iGe4GujN4xw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736480071; c=relaxed/simple;
	bh=A9fX/VY2dYRWoEe0eb7yQncWibBrwOENzsi82qWwsEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjnO3S2sN5g1du9rTTOOmMQmNuL7pkWMifhtFBoi+kHmfuiK+QEdA2hLht42jVxW7Od3op5m39sVCJHoO6D/Ip7TbRTdd4KfR77e0vT9IdWWCLBvB8J8RhwTq3cXpZPxkO91rNxQYySf6lzpYG/3/pyzFYofqJ7524+mr89U2AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=eBUZwVGD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2166651f752so33354745ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Jan 2025 19:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736480068; x=1737084868; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Viayt1DprygJVfkBr8f2Q096yWM1X8ypOSSUQGDK3YM=;
        b=eBUZwVGDam67JwyMqc1Txd0LJvomzfvh4onYKPKcAEO03AuG+VZPPBiTkkS2l7rOYZ
         P6AtRpJl5w5GPdFvK3DyTiaKO/so5ARIyv0QLvhzi8R6X2SlVS4sksgjO8SYO8tWJmeS
         GsCpE8yK8p+f1RVtl0pgUPDPD+NJWZlXTvjDH+xcBE5joPQ97l4VPSTgY7Zm9MdTIrbz
         OjZVehjgZ5kaD3lDLIn76uRg71bht9HB+cdQcSCKRZUewQq+1t25aurZ2/yw5cc1H/U8
         EH+F80pKiYegpmxZgmijWCPpkjQp7H0MIo5fJpHrcJtgdiAAZS7Rd69Iwa0mlNNYDYdb
         Xo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736480068; x=1737084868;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Viayt1DprygJVfkBr8f2Q096yWM1X8ypOSSUQGDK3YM=;
        b=tRWh+N/+n2XxPeCsOCUo+g4pReIgj3fmnUOFTmCrT8cFAhpYKfl540yhC296h65kFQ
         WkHa+VrhwiBTp+nis42oJwnJh84x7Cn2txCXKOSUndJvRMDTvLiaAOWYajgYriVe9SXk
         F2VwlI/RrTOZcBABzXoHBhC2MsJykqMB8Kajfqr6jTb00jYmWkreAfx5E0n+Bl1c08OS
         zAWiqSdxRyDRk+8nbfO2CEAmfX65exImhl8Ev2BOfJFu9K/qoGTULSYaREwrtmGz5h+G
         KkpsWY+q7fRtVtXdif7f4zFyWWx58qNWAXlagtcscPla6hJh4auP7eLEvHyNkQ6oHc4z
         zUoA==
X-Forwarded-Encrypted: i=1; AJvYcCXWxMm+E+kThjEI7nHlPWZFgUkrSCfybVhrw8AXDMDs8oIzzxsdT9vM64Fyi7zr8/GCM1ppyuodLR3UAEy53Os=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5WQwhMx8E9wh76u4Y8ynkYuzMijQwBz9MSHrho0Uvo8d28kc2
	nrXySpM5/8N62TwaCsUIyekHwrOqxG+4Y/xSqJ79/Jmqw2M8NNDanG/gvgIpOa8=
X-Gm-Gg: ASbGncu7zI/Yl++lF2crWnhRvGNJsJUq3GxNRHkk6QGGNUJJ6jcpR31U5pKtqKzAqn0
	92D+GCVrg+N62KvPsu78UGEo/q4bOJDAGB9EZ8rAf/nlZJzMy/Pv/oQnRMHRR0ail4GMCMKQE1k
	m5JfL1quilIMHZ09vHD3n2gXH/5EJVJiCtPpk8NlgyV9H/XAObWHHjKyx5oT9ixIuvNbf36CUO1
	Owqvi7rQ2Zwkl5yR19/PMgEl4TJPVAblXfKG3xoFWZdxlwmdm6M
X-Google-Smtp-Source: AGHT+IG3bbMYbkS4jJPSzQ9p7FyUYg9x1B/aqRiSj2rt9ftAdecMCL/6FTOfSLcR8vnjUeA3BTKFRA==
X-Received: by 2002:a05:6a00:1c92:b0:725:e499:5b86 with SMTP id d2e1a72fcca58-72d21fdfc66mr14107164b3a.20.1736480067688;
        Thu, 09 Jan 2025 19:34:27 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:691c:638a:ff10:3765])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a4dddsm569643b3a.155.2025.01.09.19.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 19:34:27 -0800 (PST)
Date: Thu, 9 Jan 2025 19:34:24 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Celeste Liu <uwu@coelacanthus.name>
Cc: "Dmitry V. Levin" <ldv@strace.io>, Oleg Nesterov <oleg@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrea Bolognani <abologna@redhat.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ron Economos <re@w6rz.net>,
	Andrew Jones <ajones@ventanamicro.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	Felix Yan <felixonmars@archlinux.org>,
	Ruizhe Pan <c141028@gmail.com>, Guo Ren <guoren@kernel.org>,
	Yao Zi <ziyao@disroot.org>, Eugene Syromyatnikov <evgsyr@gmail.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Subject: Re: [PATCH v4 2/2] riscv: selftests: Add a ptrace test to verify
 syscall parameter modification
Message-ID: <Z4CVQKkViqJycnaq@ghost>
References: <20241226-riscv-new-regset-v4-0-4496a29d0436@coelacanthus.name>
 <20241226-riscv-new-regset-v4-2-4496a29d0436@coelacanthus.name>
 <20241226133459.GA30481@strace.io>
 <2e09aedc-44ba-40e3-ae93-1d6dc21b5eb1@coelacanthus.name>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e09aedc-44ba-40e3-ae93-1d6dc21b5eb1@coelacanthus.name>

On Thu, Dec 26, 2024 at 11:21:59PM +0800, Celeste Liu wrote:
> 
> On 2024-12-26 21:35, Dmitry V. Levin wrote:
> > On Thu, Dec 26, 2024 at 06:52:52PM +0800, Celeste Liu wrote:
> >> This test checks that orig_a0 allows a syscall argument to be modified,
> >> and that changing a0 does not change the syscall argument.
> >>
> >> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> >> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> >> Co-developed-by: Charlie Jenkins <charlie@rivosinc.com>
> >> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> >> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> >> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
> > [...]
> >> diff --git a/tools/testing/selftests/riscv/abi/ptrace.c b/tools/testing/selftests/riscv/abi/ptrace.c
> >> new file mode 100644
> >> index 0000000000000000000000000000000000000000..023695352215bb5de3f91c1a6f5ea3b4f9373ff9
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/riscv/abi/ptrace.c
> > [...]
> >> +	if (ptrace(PTRACE_GET_SYSCALL_INFO, pid, PTRACE_SYSCALL_INFO_ENTRY, &syscall_info_entry))
> >> +		perr_and_exit("failed to get syscall info of entry\n");
> >> +	result->orig_a0 = syscall_info_entry->entry.args[0];
> >> +	if (ptrace(PTRACE_GET_SYSCALL_INFO, pid, PTRACE_SYSCALL_INFO_EXIT, &syscall_info_exit))
> >> +		perr_and_exit("failed to get syscall info of exit\n");
> >> +	result->a0 = syscall_info_exit->exit.rval;
> > 
> > I'm sorry but this is not how PTRACE_GET_SYSCALL_INFO should be used.
> > 
> > PTRACE_GET_SYSCALL_INFO operation takes a pointer and a size,
> > and in this example instead of size you pass constants 1 and 2, which
> > essentially means that both syscall_info_entry->entry.args[0] and
> > syscall_info_exit->exit.rval are not going to be assigned
> > and would just contain some garbage from the stack.
> > 
> > Also, PTRACE_GET_SYSCALL_INFO operation returns the number of bytes
> > available to be written by the kernel, which is always nonzero on any
> > PTRACE_GET_SYSCALL_INFO-capable kernel.  In other words, this example
> > will always end up with perr_and_exit() call.
> > 
> > I wonder how this test was tested before the submission.
> 
> Oops... It seems I forget sync the code to test board so it runs with the old code...
> The code is completely not tested...
> I'm so sorry for my mistake.
> 
> I will correct it and test it carefully later...

It would be great to get this into 6.14. Let me know if you would like
any help!

- Charlie

> 
> > 
> > 
> 

