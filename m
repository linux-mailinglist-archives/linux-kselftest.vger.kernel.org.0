Return-Path: <linux-kselftest+bounces-46947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1252CA0452
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 18:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FE4230E0B5D
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 16:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D2136C0B3;
	Wed,  3 Dec 2025 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="kTxOzvQF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57E436BCF4
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Dec 2025 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779503; cv=none; b=XMZjELFJIqX2zXMD6Psok0i/JcYy8Uy95GZEXQulZIembla/sK2Vywxga++Heor4Jhp7NSIRHeWgv5k2uQ8yp94rK9elxZI9LpJzwORC241sXcQzhljB3syZiuj00/DhIA41hMv+2wWRWWXDJgr7C7yuxy1Jgds1Kj7gOpRVNLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779503; c=relaxed/simple;
	bh=l0gnY/UzSbFUAuDU1KntIMiLjASuWWo0nEVW8bui9Tk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=r+T3JtKz4JPZkvupMPQsP4Gpwzl81JZdEUb/HtiT/0sFTTe+FvnVvTGRsTzYlVsn6byv6VQR93gUKTIHuqBnOVFML1V2pA/aw0rlPgUe3mMnqBXZB+ju19CxYdQ8Qc8963OHDerajBi5kLds4lQTKhUSBPS6oSIVtpG5luDdrbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=kTxOzvQF; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CF28340401
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Dec 2025 16:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764779484;
	bh=l0gnY/UzSbFUAuDU1KntIMiLjASuWWo0nEVW8bui9Tk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type;
	b=kTxOzvQFwwFYahBIdvD+Q0qvBMRKooVbSEzIrDSyXsjQkiDbMfEgzbj+Rxi7qzl++
	 xF/Wwgk9KQee0ysVwVocI/GSM3WUsz49OKtsfE/lrt57IvQDjgLBNvnTGnpsYBEbIp
	 wOw3Hz3YdRNrLvNTnsrZv4SfeX7Iv845zLaRTRy9M32rN/AwmX63DwJVz3U/x/mH8Q
	 u32+jM7yWmESVEAErzupgYKp9rBPWKT021itDBARXMGaJvCHrNZfU2aTpRumLDYvCs
	 m1qEvW9eBCiECNJq6YiqjMmwqjPZt4qsjVpn7NVDopCvOkV0t0FwT2kQtzJzsAVtRX
	 Q5Fq6os9nM39CxdXxXL5W1QwrPwzn5CAp6d383j6ZJvNrhcuceCnTvh4LJmErcOnh1
	 6EGU7X6zBpYgPv9qkK0TaoeJCcnDnvXdrvF1XEacCVv0l+YmU4srBUDFvWYUghfd3J
	 Ukl71JUqpPq2aCcun0ujg9IGf9MHd0U0SDMARUs3gBBn4df87hSnd35X3D+7gq7VHf
	 Kp4ITOUFahfiCNSOTHivj/9twGRY9VYNv48hAKI7hely2r/Ql7TrjFn8mq1ADko22q
	 D1D4M7p5BNDOIspBJzOIhN1bGkrKfui59V8YZ8rv3feVbzdqVQf6nx0jzVwMiy4ouo
	 PPkiOJm+7TGV62FmfkacNBWI=
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4775e00b16fso45912725e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Dec 2025 08:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764779476; x=1765384276;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0gnY/UzSbFUAuDU1KntIMiLjASuWWo0nEVW8bui9Tk=;
        b=sAy/gKbNgtYe5De/8ZTxquB+pmorgjXOpzUw0RYAIixQ6y53MhMc4CEMiLm8YoFg8P
         9F4685Wx59dtvqusHnQSCMyz3gAW1L74yfU9HmEEqLumOjnBh/B1DMC7/SjBoPWBIgh2
         7HqMIl2NGGxAAUGU+V8xgDwFFKITegJ7EVsT4ELePOrVNALggjUuoylLHtM+un9VgpAf
         pkG6fTtXLNZGJDajiL5Gd+T3trIgaHF+NpmKPzPpmBsvnDO38tfY7BRUhQwWmKWbbBj9
         9vJ0zDwGiTCYDyiSdN1Ka5ESdtNrqKxGoLscf4WIP4IRE0M7u57s2VUHxkYIoaihwJKF
         klGA==
X-Forwarded-Encrypted: i=1; AJvYcCWnLv+OL+R2XHtfVIICISsoFDuTkApcBZXNZsXf5GV89TMqD52rsMXEhFak/J7u4j1KBjK8cS+GQiVHKnQt0lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPXFKza/tGz+1iFGscuJEr2KwF5Xld4b+XOe8B24pcOepLwJBO
	AZrfDW6HsPx4L0HqWeUS1ohRKrG97c/UzeCZd63kbAiUa5wGKa/rXaykR8J6f8YReiDEPE2N6Mg
	PuEgKBcGzOddeRmaemH3fsTvsH5NRm1CmLmZkOlbB47zxIHpTwAzuKrquXAQiEbUm42h5eCH0PE
	kdznD1kPnFLA==
X-Gm-Gg: ASbGnctfp7W70Nh4sWkqJaQ9kiJ4YbM0HMCBP1i2QXWVw7zi0a2SsrxHeCsWkS6dkwA
	6p58cJbgp/MvfQPhbAXU8V4qQqCQQYzwG+dl49ho6UhyElzJ+R8NJjn0/RJRdVoFx3SzoPgc5LT
	ymJDHIblpLJP6EewuRNYIfjzJyyZpgD7X7JxFCBpFw8ACcgqPuF2f7nQ9a2XMBU3EjaAph9+MvH
	4mE6ss1wKR6LLU3nWz8KMJkOBV0q42BREmC8qJw8ygwo2DeDKoSCGAx6Tu2DTDWu2vHXJEGDHE+
	hVP7iTJ9sE94kYV0Mzj9a9sOP7MnMErBoVI8uK7ElNUiGRQ2h0D2GfReYImzcG5b7TOmO7XhQ15
	AqIiudOY22gCv2bhI0jUr7VpY/1ORZOcLJB5KmHI7F5MDRth6hnOFS6+SS7Ef8iWxvKYnLzHBH2
	A=
X-Received: by 2002:a05:600c:a41:b0:46e:74cc:42b8 with SMTP id 5b1f17b1804b1-4792af327dfmr27911265e9.17.1764779476110;
        Wed, 03 Dec 2025 08:31:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCKejq/2U+1EN5UAB8CezRHOHJDvwMZzcFVGMZ1T1ZB5XD8pg1afh59Y/Z4iwxgxyD87hFlQ==
X-Received: by 2002:a05:600c:a41:b0:46e:74cc:42b8 with SMTP id 5b1f17b1804b1-4792af327dfmr27910815e9.17.1764779475621;
        Wed, 03 Dec 2025 08:31:15 -0800 (PST)
Received: from [10.1.1.222] (atoulon-257-1-167-49.w83-113.abo.wanadoo.fr. [83.113.30.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5c30c4sm40900310f8f.9.2025.12.03.08.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 08:31:15 -0800 (PST)
Message-ID: <6b25515b-c364-47f1-bd75-8b7dc16e3701@canonical.com>
Date: Wed, 3 Dec 2025 17:31:13 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: devnull+debug.rivosinc.com@kernel.org
Cc: Liam.Howlett@oracle.com, a.hindborg@kernel.org,
 akpm@linux-foundation.org, alex.gaynor@gmail.com, alexghiti@rivosinc.com,
 aliceryhl@google.com, alistair.francis@wdc.com, andybnac@gmail.com,
 aou@eecs.berkeley.edu, arnd@arndb.de, atishp@rivosinc.com,
 bjorn3_gh@protonmail.com, boqun.feng@gmail.com, bp@alien8.de,
 brauner@kernel.org, broonie@kernel.org, charlie@rivosinc.com,
 cleger@rivosinc.com, cmirabil@redhat.com, conor+dt@kernel.org,
 conor@kernel.org, corbet@lwn.net, dave.hansen@linux.intel.com,
 david@redhat.com, debug@rivosinc.com, devicetree@vger.kernel.org,
 ebiederm@xmission.com, evan@rivosinc.com, gary@garyguo.net, hpa@zytor.com,
 jannh@google.com, jim.shu@sifive.com, kees@kernel.org,
 kito.cheng@sifive.com, krzk+dt@kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 lorenzo.stoakes@oracle.com, lossin@kernel.org, mingo@redhat.com,
 ojeda@kernel.org, oleg@redhat.com, palmer@dabbelt.com,
 paul.walmsley@sifive.com, peterz@infradead.org,
 richard.henderson@linaro.org, rick.p.edgecombe@intel.com, robh@kernel.org,
 rust-for-linux@vger.kernel.org, samitolvanen@google.com, shuah@kernel.org,
 tglx@linutronix.de, tmgross@umich.edu, vbabka@suse.cz, x86@kernel.org,
 zong.li@sifive.com
References: <20251112-v5_user_cfi_series-v23-0-b55691eacf4f@rivosinc.com>
Subject: Re: [PATCH v23 00/28] riscv control-flow integrity for usermode
Content-Language: en-US
From: Valentin Haudiquet <valentin.haudiquet@canonical.com>
In-Reply-To: <20251112-v5_user_cfi_series-v23-0-b55691eacf4f@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>


