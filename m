Return-Path: <linux-kselftest+bounces-26060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFFBA2D0E0
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 23:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD30188F440
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 22:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0461BFE10;
	Fri,  7 Feb 2025 22:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="T9skWw/B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FD7194091
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Feb 2025 22:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968294; cv=none; b=oYvQyVOttEudUMCq3Y5Nzgtc+ame/AKLIJ+UChb6GBbUnr799SVTFcp6Pgi8t6gFGj5swoMqbhjERcOPJRqwT4/V+xyNgE8t+RHs8QKeBZUWj8Bn3/f+Xfbos9ARdLZgoOBTShZpMQ1Lm9nVACmI1dW1YdZS1V262LEhWeAnc2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968294; c=relaxed/simple;
	bh=xER+J0rwCJQXKyznu3AhTqAUumvPqCAq0oO+l0T+4Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQxQS/lMLM3mrneypBEkgfcW2ZYLkggCX9uNVQmqHQPO2wWXr5StT5xwlLvrH9WmMhmnBlHg2g0fuparPSBPDqDztJ1ShFGMkoqFge8tefmsWUdrR1KKS3I7B29sMCEvNMqs9GRiV9rj0c1QBqZWYZZV9DkK1K+ZACZSfCz+s5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=T9skWw/B; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f48ebaadfso37055905ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Feb 2025 14:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738968293; x=1739573093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aaVupd8VUc45i80fdS121DnyNihJxKhlS0yfklFXjf8=;
        b=T9skWw/BHUD3R+5+I65TQivGBou0QmE6eOjbaLN2LwaV+XbO9nHMqw1XwZx0ogm/7g
         z66IDip4ZHtu8LWcUV4yz5g0ckTSjnWSkEUOqruohOhGvQdLiANyTB+GXw/bqfebFam2
         DPF+eimCFVdu3DmpyZ+UJdgM8D3yhLsjdU2l4Sy5ivVSF/pBxVBuMAZAh2pMLDp6diZ/
         tOIcFo5NWhrRVIR+Dtkg1kxWTlqt0rUpjRq2GKz1DkXRCCP6AcLbFC9veSsY570JPAgH
         AstRDKBKkECyIH4SB2YvZBYQBQ6Wt3h3JbKyqYFHf16icPstM91CtrN2Sk5bqeHEel43
         wSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738968293; x=1739573093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaVupd8VUc45i80fdS121DnyNihJxKhlS0yfklFXjf8=;
        b=gEcwTPYbOjiL4cdsKuUTZb3DP73+nzy4w3s5QT8LMD/yjEkVe6Ai8RgTvz93Nj0EBE
         +RTpt4GVZ3vcz8TKFZ4VQ5GaI9DtoUZzOWLGNLAfclvDWDDXjExqFVhRW+96BKKQ23wF
         Et3eF8k2o18Q2YX6I+Ku/UAQJXYbDBJfnkqDAgyg9r2weB88ILkCJ4+NyqkrqKFxUaAf
         t7PIKsoCuKyNScsW1hzsVGK3n322gnuFMCfKWlu7Y3/hFtJ5Jl4NEhB2zs6QREv5lIgR
         v/etppmDyFU6pHhO03yZJn/V/XZZIxDyWKTrW3CM8Iq7TF/4cWOAym+MjyPL7o9nggCz
         PY+w==
X-Forwarded-Encrypted: i=1; AJvYcCXfEYcidx+KzdhQ/TAspBZh6lRmK9C0/G0enShtG1pDTxkU4ebdtA1INtGa8h3Qm+db0czGLmNc0VI92PW6PGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySTCUK/mrW78nye1Epj8U5mHgsE4UPoTRe3u7KXJCdXT3tZZDe
	Zc5z/KmawoeeqA5tNaho4CNB+JutWpQ95au0IqewVNvBuuxAJuE5afWg2FUhvJg=
X-Gm-Gg: ASbGnculV6l58sPSgFizphXR020qz9l+M9J+RJUaGWkIuGiRCFRfGo42QCeyyv176lm
	uc1e+2IroUyIf2QB6ctuOZ2w4TbshQ2D/b3tDOs/Sph0swnEayq66GA3x8z08ztpNsicyt8IYWR
	EFwVZvOkjTndELUZ4GKUxlN+cgw3L0quHGDtFDAYkOlPCadKw+EaQ82zb8hsr6YU1x18FseWTfy
	4KbYXB2FoGHadqEos4lgohleeaEdUe7abthHjpv6HEstVa1ZGYvG4wV39unjX/EZdRJVD2h6CsR
	Gq3LKCK9v/D2SA/HICWdDr0uqw==
X-Google-Smtp-Source: AGHT+IGTbu0BMzwMN01MWsrhsIOFLeTlIMVdLcXc0KHhDWapExjSRgm5VmEl2B4ZBoi8LJRoMaWbIQ==
X-Received: by 2002:a05:6a21:7a4a:b0:1ed:a578:127a with SMTP id adf61e73a8af0-1ee03b70c91mr10868884637.40.1738968292668;
        Fri, 07 Feb 2025 14:44:52 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aeb8d9bsm3508358a12.12.2025.02.07.14.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 14:44:52 -0800 (PST)
Date: Fri, 7 Feb 2025 14:44:48 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Mark Brown <broonie@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, rick.p.edgecombe@intel.com
Subject: Re: [PATCH v9 01/26] mm: helper `is_shadow_stack_vma` to check
 shadow stack vma
Message-ID: <Z6aM4NZyJSGLwIPr@debug.ba.rivosinc.com>
References: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
 <20250204-v5_user_cfi_series-v9-1-b37a49c5205c@rivosinc.com>
 <6543c6b6-da86-4c10-9b8c-e5fe6f6f7da9@suse.cz>
 <5708c19d-240a-466a-b17a-d51b26ab95e6@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5708c19d-240a-466a-b17a-d51b26ab95e6@sirena.org.uk>

On Fri, Feb 07, 2025 at 08:06:59PM +0000, Mark Brown wrote:
>On Fri, Feb 07, 2025 at 10:27:10AM +0100, Vlastimil Babka wrote:
>> On 2/5/25 02:21, Deepak Gupta wrote:
>> > VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) is used to encode shadow stack
>
>> I see that arm GCS uses VM_HIGH_ARCH_6.
>
>That'll be bitrot in the changelog, it was originally VM_HIGH_ARCH_5 on
>arm64 as well but we had to renumber due to the addition of
>VM_MTE_ALLOWED while the GCS series was on the list.  The changelog just
>shouldn't mention VM_HIGH_ARCH_x, it's not particularly relevant here.

Yeah noted. Thanks.

