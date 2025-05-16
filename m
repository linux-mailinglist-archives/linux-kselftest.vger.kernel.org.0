Return-Path: <linux-kselftest+bounces-33199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA393AB9FF3
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 17:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C05502561
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 15:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7691C6FE7;
	Fri, 16 May 2025 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="aNHk+Il8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D751B6CE5
	for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747409672; cv=none; b=AvQygpRF95Qh9+YnibjZLlMC2nnqwN/F3WWSN+Q0/S5xG3za8ukgFZ22/UnOW+Ip2l6ZQiP8Pcy5Aovbd3uKR2Zriye+zRGrfPexiCU4uot+WT39uQOF4Hoc72sKExVEjUzqdS6vmHVdTZLOA8ZBENbjqGAvj6uL7AWcNkV6Bic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747409672; c=relaxed/simple;
	bh=s7M35uwjD+aYg6o9dTgcW1bTJu8deexw+cwFb2Q66d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIR52hyzPXRxVs05gf/Ym36uB6ckcxIWcF0xsnhOKAmt5HA5B6OYkTvn/c5CV93n3x9aG0myzBeWW25NG1ZajxOmcuG9CC5qJulqRO2LUHFpvw2OjAIq95tDQyfjH/ZS6yPmu7AT3zkZvseKFxf83/w73nCnH45O79wocJSlZAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=aNHk+Il8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-231f5a7baa2so3765105ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 08:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747409669; x=1748014469; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VTPOMqT5C2feU2knCk6fA/APYFa11AZmawpB2cqaoDc=;
        b=aNHk+Il8tY3wKlYMt8MKNZwFti/luK9M6uD2PQ9xQyLCJ7vcDjw+Wm7wBS2XdpfWpx
         KoKTdTtSvvxRzxBne9UFxCgPm/Iy49WKNu5yLRr0R3MJKgV75/6SmCD6a6E1AMcwpswu
         etbcgE59S7n6ZSjhDUCiZbdLQOYRPse4bgKHsAfDLRrmOzlLTSlgtzsS7/ckO2yiYzB5
         g2adbQQxOrSxb9ZFDXSNYbYeKjMQGP3ta60NYFjtxLTRW3qg/fVMeFT7nfEv8JJn0hUQ
         coACE1nXsn/3uSg1AtNGtRpja+tGJeajxJ0IApyD2tUvF6kZ7h7BRTqBWIKs704bpsI7
         HhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747409669; x=1748014469;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTPOMqT5C2feU2knCk6fA/APYFa11AZmawpB2cqaoDc=;
        b=QH1GP+gVaBkdijdmaRB/qlutGCjfPX49sR+D+0lf2J1TSqxpW5PktpyPcoV24psaG2
         QFYfa+WSX81JicfH7R0LbsQhhpDqUnpZUmkjWgMAG49E1GwaW22YyQ8g34m2vkUn6sts
         93+489+kqu3o/ei2UwOUowXdxcJyJpN664wr+8Sj1KskhUxb+YRMOqCNbSNGEcWn3uv4
         Ut/OR0h1KANTBikGz2TfFimMaxixjyi+nqG1EjrXQzDLsdQEPdTUpT6RQ2LerkIkSpnF
         x7i5zi9tgFYUmyo6sVCd+kYHZ5qcKN7801YmRETHG2WujIqJh+c8eILZRhZaAsMtdpWu
         RYhA==
X-Forwarded-Encrypted: i=1; AJvYcCWtm41p6OhjPzL0+fU+BXsDyC6Px3zgZU+OPZxjb5lGYzGWr1aPl+Wc1y3oJ6hYuuwRi4sh0slpQar98culbrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfTb6I433ZFKX6FKY4Jm5ZIYtxCjJLhuQ1c79SHfJFpSZl5y3r
	9X6HlwjU3vos0JWFbQ1ZA0DRlVU4/2LZ7GbWkmWvXiOnAig5bttAuHDfKXGZosC4A2Y=
X-Gm-Gg: ASbGnctF/2Sa8LziuWykUEGRmCZUj9m1bL+cLKYfjUfB4TNXzRuE9S6g9eVTbKqoah0
	gE6vHXKilLAnVf25lZVH+9Ckmp40YoRifU2IUgOTa4Nvw1kXkeVY6yi8FZEpZYJOGGjJBH3npYI
	oABEi1ICzUSVpl/jeKbO6qsIK3iWaO6PvGG1No5fYxVeP7OAE0UMzJgeiieS3VPaiDaJVjhyASq
	/tAe3H++Gz04tWRVVBdgOcHl9jszeOPDPuPnxa2Qxyl+TBUlHXb7J9hUBjmEoHCUh3XDlt5jATX
	nVGIzSVp1HiQwmt3Fxx39IJfMnozFcFp0FEUalx5+5QVBraUjcqwad4t4/z/VA==
X-Google-Smtp-Source: AGHT+IFZckSqO5+1mOJ5q3W7tqhvvuTMvoIraIWCKDFfhzREKyJxJcIAzKyffAUquxEcLFZdJvL5nQ==
X-Received: by 2002:a17:902:f60a:b0:22e:17ee:aa69 with SMTP id d9443c01a7336-231d45740d0mr41158275ad.50.1747409669319;
        Fri, 16 May 2025 08:34:29 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac944esm15870145ad.49.2025.05.16.08.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 08:34:28 -0700 (PDT)
Date: Fri, 16 May 2025 08:34:25 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org,
	Zong Li <zong.li@sifive.com>,
	linux-riscv <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [PATCH v15 05/27] riscv: usercfi state for task and save/restore
 of CSR_SSP on trap entry/exit
Message-ID: <aCdbASlCyqhid82c@debug.ba.rivosinc.com>
References: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
 <20250502-v5_user_cfi_series-v15-5-914966471885@rivosinc.com>
 <D9OZVNOGLU4T.2XOUPX27HN0W8@ventanamicro.com>
 <122fc6cd-2e21-4fca-979d-bcf558107b81@ghiti.fr>
 <D9WLRSAB63M5.3DZD4ND3WVZ6F@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D9WLRSAB63M5.3DZD4ND3WVZ6F@ventanamicro.com>

On Thu, May 15, 2025 at 10:48:35AM +0200, Radim Krčmář wrote:
>2025-05-15T09:28:25+02:00, Alexandre Ghiti <alex@ghiti.fr>:
>> On 06/05/2025 12:10, Radim Krčmář wrote:
>>> 2025-05-02T16:30:36-07:00, Deepak Gupta <debug@rivosinc.com>:
>>>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>>>> @@ -91,6 +91,32 @@
>>>> +.macro restore_userssp tmp
>>>> +	ALTERNATIVE("nops(2)",
>>>> +		__stringify(				\
>>>> +		REG_L \tmp, TASK_TI_USER_SSP(tp);	\
>>>> +		csrw CSR_SSP, \tmp),
>>>> +		0,
>>>> +		RISCV_ISA_EXT_ZICFISS,
>>>> +		CONFIG_RISCV_USER_CFI)
>>>> +.endm
>>> Do we need to emit the nops when CONFIG_RISCV_USER_CFI isn't selected?
>>>
>>> (Why not put #ifdef CONFIG_RISCV_USER_CFI around the ALTERNATIVES?)
>>
>> The alternatives are used to create a generic kernel that contains the
>> code for a large number of extensions and only enable it at runtime
>> depending on the platform capabilities. This way distros can ship a
>> single kernel that works on all platforms.
>
>Yup, and if a kernel is compiled without CONFIG_RISCV_USER_CFI, the nops
>will only enlarge the binary and potentially slow down execution.
>In other words, why we don't do something like this
>
> (!CONFIG_RISCV_USER_CFI ? "" :
>   (RISCV_ISA_EXT_ZICFISS ? __stringify(...) : "nops(x)"))
>
>instead of the current
>
> (CONFIG_RISCV_USER_CFI &&
>    RISCV_ISA_EXT_ZICFISS ? __stringify(...) : "nops(x)")
>
>It could be a new preprocessor macro in case we wanted to make it nice,
>but it's probably not a common case, so an ifdef could work as well.
>
>Do we just generally not care about such minor optimizations?

On its own just for this series, I am not sure if I would call it even a
minor optimization.

But sure, it may (or may not) have noticeable effect if someone were
to go around and muck with ALTERNATIVES macro and emit `old_c` only
if config were selected. That should be a patch set on its own with
data providing benefits from it.

>
>(If we wanted to go an extra mile, we could also keep the nops when both
> CONFIG_RISCV_USER_CFI and RISCV_ISA_EXT_ZICFISS are present, but
> command line riscv_nousercfi disabled backward cfi.)
>
>Thanks.

