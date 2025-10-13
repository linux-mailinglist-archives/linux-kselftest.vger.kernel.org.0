Return-Path: <linux-kselftest+bounces-43023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78510BD58D6
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 19:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1FD1893C87
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 17:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B664F304BDD;
	Mon, 13 Oct 2025 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="SqHb8g6I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3220C238176
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377274; cv=none; b=L7F8fBTCTIAPC+adVVdDUZ6kaTyoD/VBaUE2BAiLEbNL+BuT0xT9vYnf+XjMNR2sJgTaBL0N3/ytwjfd+AqeF9YhoRbcS1+PHgoqrBvG7YGcaelg9bUFxBxXU5Si+PD3oDQMdK6rAqAMCeWaFLDvUZXwA0DmG/YwL4ERwyzPyHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377274; c=relaxed/simple;
	bh=94egnTRdgLc30wdtlVSvU7tat0yXpqCx45KEvuUD7wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhrHPC8Qs1Hvl5NtUWtpYhXvhV7lH93YPmJyqbf/ZmNYsnBjV6j4g2BAN9d2Wu1oudTtL9IXVTDLJw4aIXtHBSSKNO8QZrdXPhUfBN+bpcqXGu8wgySaPXjCYpe7o0yCuwVt6XvuOkDli0bgEf9mTzd1Lldu2j4vq0UJO7rYq0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=SqHb8g6I; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-930a6c601b3so443249139f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 10:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760377272; x=1760982072; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UltuTfLMWFwExhawJAiiHDqM2t3dFAy15foosSKHKoI=;
        b=SqHb8g6IHYPewx+ScxjYTRkkxkp1SalWwNZ0S6e6udUNu6W0gP5aZBf6VF7jO13oRv
         7Zy0cMbIwdZTWL/g3oGM4nJLmGqbzWZAUCbkp1uZuxbPJPtslYlNRXxNTcYSMIwCC95l
         NiN/og5jaRCrhe7R4LmlzP+qqwCEXBynCkbmU2QJLHqQ9CQXxoKRaVRimNSweUaKiG26
         lMv/H8q+Zhvynu0RN+0rpQQQFFY/7zKd9lPoROfJ5fHwm2OhYt9Ez/dYQxdsRRswJuh3
         vtFTS999VfW5VbXwmKRjEPPttLBZZkF4VU6dF/dsC2N23hY1ro7MLrsUWTS3AvqiaGIH
         0SIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760377272; x=1760982072;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UltuTfLMWFwExhawJAiiHDqM2t3dFAy15foosSKHKoI=;
        b=SdDFAwH+CGQeO7RNhVBB5kljmmZeIV6OU9L8VCqaYLB6jdHl4ULj0GnuWvjlA2zLvv
         T2DbiKIJL53rgE5g/eulyicFZ2L8oGSt8chdhdCpRI7pweLAETi9JLe8qAvxpgM2XDOV
         Wd8KZW5dbPAQXYBM8eMoa7ITgsXXdl5hztSQmexbu4VMua24WzSmEssTctou/zODZA3n
         s2q0u4oJAKI4iCI+9GnLaKZ9FhKV0EtuEb1OYTFP6NkxOpswFw0wUmJH0q2toPWxSTCU
         QA8sPtAapjCank2LCK+5Ng1nRFzRnKUYKXHR8PyQ+Lpx070j0529zYgEBeiv2i6iiRMg
         Xomg==
X-Forwarded-Encrypted: i=1; AJvYcCU3vksbJa7nlQO5UJXtqn/Uh+Q4nSljWWf8fs3n0uasqpMi2jtgVRwzs1uYlMf0wogQIBPoRSOF3hA20I0Rau4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMHXMD8D8+wBpbXdj2345HTix3gmjUIo7vF4CXgF8UEqkan3KM
	r9Mmo9a+tF9SLxsN+zEbDlOdzS9QmRsfF1bEXzLgkWwnTkfX2JTJvNVMxMgepRqJnjg=
X-Gm-Gg: ASbGncsKk4xsoxnhe5XiMLaNk8zoqFsfdwgoJJ3r0W2JPGt9Sf05v4yIkqodkMW4/rD
	G6QvTXVGDyJLMMMGbZYur61cR39OU+ClXSBrrt9f+2uqjlusk/A9leOpwjCod6Sd2rCXSnZqkSK
	wQ65h3uJzk4BONMf+xfbllE2/F5Ku0NxadfrbVZljvyDgnstLMxPy3I9X3stio+Dp/FeBrteXhG
	etGDR+Np6hJFq3rLHnG3dHk06lWihrFu6RbeqzKvp1+1xa4cBRN0md290OEX7TofL9+6ODkubU9
	juJI6IbchWY/r1l+TVSkr6+OoRo2KkNQ3ry/LAQz0FAJcJrC5Mkdkl9gCDdqkxG6CNRXilMvbDx
	3ERNJl75xGilC/IXxhCOutUxn435KqsNa30dQh69PcMM=
X-Google-Smtp-Source: AGHT+IGksZJATtR9dICb9YFDLoYCnIOn9SbEaI89/f+xN2pNKg219Slp1yc0ndJtssXs/Ex7tkdSVw==
X-Received: by 2002:a05:6602:740e:b0:887:638a:29b5 with SMTP id ca18e2360f4ac-93bd1975876mr2285945239f.9.1760377272238;
        Mon, 13 Oct 2025 10:41:12 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f729ce111sm3807015173.58.2025.10.13.10.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 10:41:11 -0700 (PDT)
Date: Mon, 13 Oct 2025 12:41:11 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
Cc: alex@ghiti.fr, alexghiti@rivosinc.com, aou@eecs.berkeley.edu, 
	cleger@rivosinc.com, evan@rivosinc.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, palmer@dabbelt.com, 
	pjw@kernel.org, samuel.holland@sifive.com, shuah@kernel.org, 
	zhangyin2018@iscas.ac.cn, zihongyao@outlook.com
Subject: Re: [PATCH v2 4/4] selftests/riscv: Add Zicbop prefetch test
Message-ID: <20251013-b0cf6d4c5952c56cd489eca9@orel>
References: <20251009-49032bae395a1c26cbe80928@orel>
 <20251013161645.29357-1-zihong.plct@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251013161645.29357-1-zihong.plct@isrc.iscas.ac.cn>

On Tue, Oct 14, 2025 at 12:16:41AM +0800, Yao Zihong wrote:
> Thanks for the review, I’ll fix those issues in the next revision.
> 
> Also, do you think it’s worth renaming cbo.c to something more generic
> (like zicbo.c), or should I keep the current name for consistency?

The cbo (cache-block operations) name represents all the cbo.*
instructions and all the prefetch.* instructions, just as section 2.2
"Cache-Block Operations" of the CMO spec introduces all of them under
the same heading.

Thanks,
drew

