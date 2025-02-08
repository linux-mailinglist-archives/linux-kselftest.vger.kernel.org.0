Return-Path: <linux-kselftest+bounces-26065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76685A2D1CD
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 00:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72CEA188E994
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 23:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C841DB546;
	Fri,  7 Feb 2025 23:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RoNmWspQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B812418FDAE
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Feb 2025 23:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738972355; cv=none; b=GZqlFkzryeKsFoj2pjANZTyon92Kox4rDTHExoj2IxSr6UhdYcnRfRDe08RMyZLE/aZWTGUUAohRylX6huNPNPgwJjfAg8mbRkCOPw3GorWbxmcwAbHVwkE4hw7Vc2UM6gGcmiUJpXznKXSCmdVioY3w2LHjQWAaR3SIWSwd2zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738972355; c=relaxed/simple;
	bh=feHZLMYdw1GKKdpzxXYJZHObDJpwzN8+Y0Xx2Qps0Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Di8xks8LiL8xu5U4jaewHz1MfhE/nMufGOKNVEd8INHIS7onR4tf8bbXO8jljnXRSu9NTeMPUm5bOJEyA4qsJtc++vtjNOlKqO/K/EY1VZMcBm3D7kkBfJZ1D+/54bgs5k6IGGcCVlcoWLrksAH7xG3txBynDMCuIQ4cILC4Vm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RoNmWspQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f4af4f9ddso26207305ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Feb 2025 15:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738972353; x=1739577153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oQcVjQRwopmrHuG7wgsXbQFTOWJLCaxzXjS7jJ9aNqc=;
        b=RoNmWspQB8vNq6Ey74DOIuMh74vAkRoq85X9+moyA0z/rBNoXhmo9jFa3Sf/M5W6DI
         GBp2Q7gEJFvIf9el8ifnUWlfB8oLJ8CRmTJD+j7JDRz0LfGgy9n1o/FeDvJvBSO9VUTO
         7bcGlgSTc5315bdmrf8r2FqBlk/dbZHihABSupdMjwEN71guGwrWYAL0+vpfkbDE1pga
         WdVc0NNW5J5IP96coq3aNR/1NxrgX73rzjA2gha5b3t8rWb4VnqwfB+LR370OaHaLQb3
         +Qx2e66rRETtAe8WMynzj9fG38J46oKSTFFlukmQb3eB9hfr3tqDgKQPlSqr1gwyMXai
         Y1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738972353; x=1739577153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQcVjQRwopmrHuG7wgsXbQFTOWJLCaxzXjS7jJ9aNqc=;
        b=wn0eQsEeIWV6bD/VmUMkYZ8ZNGuBkn+nsscpIPlm7bSjBZmCRUvXjP5OvcE+N7H6Q1
         qybg8az+j4znCuTHGSIHXhN899+yA8U7Ngezdn2nzPTGksdNtp6MqEoWN7Aca9+CLIch
         wfXaXAEhR9ESGN1zilfvLlLxYzprC0DqpJme9BTyVg8bmMBX5tW7d3J810uDYXpauG7u
         MdtK+oB+zRkOrgmB1PPo5gqlioGYKp09QddkorM4Ol3kgmHY8R3YXO/Fs31Jlb5TjPJW
         GMa0JQiMEb+kvjG5wBQzgFGQo2x7MzOO4lNERk0a6WV4MvfhGWz/abgVhIssgBhdpcVX
         dM4g==
X-Forwarded-Encrypted: i=1; AJvYcCXxcOrXGedwJn9LIMBMc1mRWKiViMOhr9eyIov6/01oAY9Q58XIcb0u1rzDAgui3FkH8/zwVHXmapqA2Z/BH9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxecckO5sT0qdySECDGkPM9mC1dmUMNHRK9vMUtEsURRHNNRbVG
	B2Jg443OGX2+YMNGxCxKPZixJgR01s9gwnPpds2gZAoo1+wP8xx53uksn00qRBw=
X-Gm-Gg: ASbGnctrDNBvnUzDW+IdYplGdvM5wChi9edshDTm+ikrO4SwWnA14ZOsw7T3XALA1lZ
	EgotoKJqydx4t+1AXyZkSUyyJe8D5srAjYOnVL/vUeUsRaT2X5M7vYpjK828Yr7gJUy8x59qs7z
	Lp6awHquaZNg16c1LndV4Sm1ne/t/TvOGwzV0SmUGxZYYpVNr1ACKIrLmFh3kMbN5oYdfa9z1id
	nvUA8hXfh/y9y8qoFp2zUZ3Dcg37ND6ht0vkuh9Ww9vMNcjy3jdIDTSRT5dyopl8nMY2InfCKpx
	UFQRkeGAHxIvz6sZbBqkaETwkQ==
X-Google-Smtp-Source: AGHT+IH5jRZW/ovSUPH8eJRvmKh5nXw8ULDIWD5h4+evTSN5U5cvmcLVFvRfp+GmY1NLadqVCxbddQ==
X-Received: by 2002:a17:903:94e:b0:215:9470:7e82 with SMTP id d9443c01a7336-21f4e6a035bmr94058495ad.4.1738972353039;
        Fri, 07 Feb 2025 15:52:33 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368da60bsm36436795ad.258.2025.02.07.15.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 15:52:32 -0800 (PST)
Date: Fri, 7 Feb 2025 15:52:28 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
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
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com
Subject: Re: [PATCH v9 01/26] mm: helper `is_shadow_stack_vma` to check
 shadow stack vma
Message-ID: <Z6acvL9W4G9Y90WV@debug.ba.rivosinc.com>
References: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
 <20250204-v5_user_cfi_series-v9-1-b37a49c5205c@rivosinc.com>
 <6543c6b6-da86-4c10-9b8c-e5fe6f6f7da9@suse.cz>
 <Z6aa24/5M5Xdhe/A@debug.ba.rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z6aa24/5M5Xdhe/A@debug.ba.rivosinc.com>

On Fri, Feb 07, 2025 at 03:44:27PM -0800, Deepak Gupta wrote:
>On Fri, Feb 07, 2025 at 10:27:10AM +0100, Vlastimil Babka wrote:
>>On 2/5/25 02:21, Deepak Gupta wrote:
>>>VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) is used to encode shadow stack
>>
>>I see that arm GCS uses VM_HIGH_ARCH_6.
>>
>>>VMA on three architectures (x86 shadow stack, arm GCS and RISC-V shadow
>>
>>And RISC-V doesn't define it at all, not even in this patchset, or did I
>>miss it somewhere?
>>
>
>hmm...
>Something wrong in my workflow and rebasing.
>Thanks for catching this.

I think this is the miss on my part.

I had this patch in last series which introduces `ARCH_HAS_USER_SHADOW_STACK`
https://lore.kernel.org/all/20241111-v5_user_cfi_series-v8-1-dce14aa30207@rivosinc.com/

As part of above patch, `CONFIG_X86_USER_SHADOW_STACK` was replaced with
`CONFIG_ARCH_HAS_USER_SHADOW_STACK` in `mm.h` to define VM_SHADOW_STACK
as VM_HIGH_ARCH_5. It was all fine because all 3 arches were using VM_HIGH_ARCH_5. 

However as things progressed on, arm64 ended up using VM_HIGH_ARCH_6. But
arm64 gcs patches also landed the introduction of `ARCH_HAS_USER_SHADOW_STACK`.
So I dropped this patch from my v9 and didn't pay attention and actually missed
the definition.

>
>>>stack). In case architecture doesn't implement shadow stack, it's VM_NONE
>>>Introducing a helper `is_shadow_stack_vma` to determine shadow stack vma
>>>or not.

