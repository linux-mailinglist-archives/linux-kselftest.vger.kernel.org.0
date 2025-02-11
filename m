Return-Path: <linux-kselftest+bounces-26332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D678A30338
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 07:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA55163119
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 06:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4721E7C16;
	Tue, 11 Feb 2025 06:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fqFSAtw1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837D12C9A
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 06:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739253952; cv=none; b=kMqZ3WJ0K2tBMJ/skqMe27dznXulLQeM4EMNlP4Ec4DFMeoDyPAXF4fu4H+JQmmkgS57cL3EhPKQoh8dc3B6R8tPx8sFk6cIMA8anxZW9sgMYhNNQ+vif4bb0N4/o8JbLhLDkI9aOKVEGXgPPhsZYGQrpMD2cuZHDW6tnOhDM5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739253952; c=relaxed/simple;
	bh=etI1X9YYise9QDMvacxx/FUON9SjznTzXVvKpdWkWyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ju7dsGEeXSRlIr51B+Mj1mN8vzvPigEr3RccjIpycD1T98JpIg5gdl6SVn7kk4yaQ7NkR8UaiAbZEfpQ639nxzAyMguvJGhCcUyTNNHu3pqPQLCv/sdUWN0tYiyTh2OHOpwVt9lJtURQqK/zSnK1s+Y6TwHlSMk3zXRfqBPbLBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fqFSAtw1; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f6022c2c3so48401555ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 22:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739253949; x=1739858749; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0MBqIRdwxcxCwshRcxNA0crppewQ5oTYfihHZZAluN0=;
        b=fqFSAtw1ais+++FtIWx5Ockf9NzVWgV41LWrtowuNjFu0OfZA6DQRtoYipKUvfK6x+
         m5ikmfseZwYpKJ5Y1GQ0C5HOiOKX5R8SED5ksq6lJVvBF4rDC68UTA9iyV2PqOPz0Xwt
         ayxfHmksQcR1srsrlKVW4GHsJYAeisrQOEf2AJeSdygvWXfrQQ35zcXZ/5UqJLrx/vqr
         6Xezfs1SMLP8jo2BhlbtzY75T3cDHBgI24C9sfkBHsoMNaoTZYEFgF3qzUYcPhE/4byo
         H8qodEZcnanpfz882r3xYPvX1nCHBlvacLxTUjox7QbPgXDI91ox2A6zaTb0xzWL5yNk
         HUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739253949; x=1739858749;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0MBqIRdwxcxCwshRcxNA0crppewQ5oTYfihHZZAluN0=;
        b=Sx5RR+Au5wEtaQ1k2M0AnDConJAcpcS2PNDOtPqei4Q4KSRNYUA5SJdNJLdbE5f08W
         RnmorCWCJVrLPgZFD8+ysr21Rtm++sfwEcCDt3loMM/TBHsYomopDm1kRO8sKMcXyIul
         nszHx1ZGRpVK325MVhkCQfG2SYjNkzBnQyM8iMF8pCtq9WSySA82CJWgf0mBau1cwtC+
         zH2YQY1WJMR6VZ57ca1CPOtqjZaOcVCNdvSI6IpSALm3h3xWythVvxsAnTgiuBW/Vjos
         ZQAFp6usHQQ6GS8ESF8ZSarGhNgQ5uKyr6x+702kn5JqafvmLHWaXjgEwbXcFnFKGkOB
         Zt0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWj4aUqNRoFoO7MN+oOgHHsGieZ4wceiWBkkFRYll2f71fKHgGOJtVmvMXcd8XxiI8GWFLJTdgyaSx5zq0B55k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB+19RZjKTwShWiEuFTkMgJwE+21oMfGHiCBrWy8C0PUZ7Ubbx
	JQuis7tc91eTYF2ST6eDDaKK6O99l2sgaRXnOZlk61zm8bVrhViWz3F2u71Kst4=
X-Gm-Gg: ASbGncsCcWxAD7z5WVJ3Qo5ACdO6kNtjO66/3v2oB2TsrOiX5JTko0LRU6x1SMOAJRl
	IqYSK1L4NStn6UTU4pQei1KkhzJRmU+muLcbi1sUEcglUtLzXGZsrupqD+IrbSo9E0/Hw5WKMMt
	3NmP10XJBeHCWM2hWJQX4hEUMLQJa3+AOWB0EMDicW3Dn9vkgNFLZw9Rp2v1JrLNIQ5N50d5Rks
	2+tK7GmW3gPVjOa5FIXZn6FaX4j7ZJrwWi4YUDlgEcgkJCRg+QQHtZebcK2ASAJykGfP9zuJMt+
	Le6CkdGH0qYUoYShyRk/T3oVyQ==
X-Google-Smtp-Source: AGHT+IH/1R26NlLJZyOyqaoXeZYqCyF01+N1vBhKDh4u7o7gbIXbZU50VOk7nAyf7jdBnJTufNHygg==
X-Received: by 2002:a05:6a20:244f:b0:1e1:a920:225d with SMTP id adf61e73a8af0-1ee4b77355fmr3102269637.19.1739253948792;
        Mon, 10 Feb 2025 22:05:48 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7308aa3a1cfsm3437000b3a.137.2025.02.10.22.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 22:05:48 -0800 (PST)
Date: Mon, 10 Feb 2025 22:05:46 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v2 15/15] RISC-V: KVM: add support for
 SBI_FWFT_MISALIGNED_DELEG
Message-ID: <Z6roumtGyFOfoOiw@debug.ba.rivosinc.com>
References: <20250210213549.1867704-1-cleger@rivosinc.com>
 <20250210213549.1867704-16-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250210213549.1867704-16-cleger@rivosinc.com>

On Mon, Feb 10, 2025 at 10:35:48PM +0100, Clément Léger wrote:
>SBI_FWFT_MISALIGNED_DELEG needs hedeleg to be modified to delegate
>misaligned load/store exceptions. Save and restore it during CPU
>load/put.
>
>Signed-off-by: Clément Léger <cleger@rivosinc.com>

Reviewed-by: Deepak Gupta <debug@rivosinc.com>

>---
> arch/riscv/kvm/vcpu.c          |  3 +++
> arch/riscv/kvm/vcpu_sbi_fwft.c | 39 ++++++++++++++++++++++++++++++++++
> 2 files changed, 42 insertions(+)
>
>diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c

