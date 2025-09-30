Return-Path: <linux-kselftest+bounces-42646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 936D7BAECCA
	for <lists+linux-kselftest@lfdr.de>; Wed, 01 Oct 2025 01:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4958E4A00B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 23:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F062D0C82;
	Tue, 30 Sep 2025 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="NwodKnn3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A6C242D97
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 23:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759276127; cv=none; b=cfJtq/zech0ZexpZroph9+HuHgjS5hNmlc3uN06YEcuHi1oOoVp68PYgUtT/oOeISpngyemWY4iB46wh3eu1fqHNEwbY029FbGJ2nNVAI5HV1QbHvNRc3N0W8gezBGmx+6msJmNCLhdL4k1yMAmoZcutJx7VfD+SZnfheI3p32A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759276127; c=relaxed/simple;
	bh=4bm7dBKTe7VHUpax5O4A5sblWjBcLkrJbyIa/W7uP1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geDGUtLPuaCOo9Sy5UmUj9NX5B6U/ReZIU5VV2vs3RMWKDOsKs32nQ0R4EPsEmRwa4YJuWD2Y7LwPOIf1B13qby8RDoiV5aF+H8w3EY6Injj1i2YVPU5O3lepHjR1tCG99m5/o95uwVlHU8KbXoWojzJiblRvuo9cMkjo1PAAws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=NwodKnn3; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b57de3f63c8so3967211a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 16:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1759276125; x=1759880925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bm7dBKTe7VHUpax5O4A5sblWjBcLkrJbyIa/W7uP1A=;
        b=NwodKnn39OQecdVF6d8bOQQDGJ3Gwu3/er8rraGYUv3SuTXqM7jJoNUUTX1ncfQeNO
         aVL4BoTscyDkvFc/witRmX7H6DznBmneHqFSGq3Gw/pALqTtgcSRSchoeu47dGxoazx1
         vqzpdHAOZHplVP0PIE4cJJloFy+YxjIo6e6/dS1lqIhFdxN4cJggB67Lvl3YcPYVKqIO
         t9iibATEJDpJ6slDDzqH5n/R/L9p/WJP9toJHOK5HynjH+6rGAsd3nQ7A2Dn0wRPOdoJ
         ivtTlLJXlIqfICiwwgqY4RDnnVBPjUZkF97UFWMXLGl4JJCZRaYbJ1HTv2rAzyPZyCdN
         B3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759276125; x=1759880925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bm7dBKTe7VHUpax5O4A5sblWjBcLkrJbyIa/W7uP1A=;
        b=BF8i/e9Wnprkq0ukERTbPWmamT3KYtctUp3DRKHdQmF5lS2m1NWXW1HnvWOeDD1fXS
         Kv3tbdYvOvSuzH67/McQkxkgVKXbLziwCeGlWWffNFVDwtbI+FQFaYgp3Pj34k8F6Y1h
         bR9oms8uJEY/ZcCmL2rAP8g+LXVeo+EbnPM3X58DFe1z3U+o82JlXcTu7VH1E8EL9+s8
         djh1DgPH6qL/sr7KIzUkJzwaxB2/KHll9nRwKhY9njeC+IIp6/8BxEu0CqCAA0Pt+hDP
         1Aa0AF8aEbRDr+fGttX3XQJfuuz/VngnhPBiYSyU5rQODQq5a3OOVbjv6WvbGXQQEXMp
         yGvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn3N+T4OgXKOgsh5dCZle5VSGuCH6AjYW3So8d0RQoxK7KGqHraXTheg00fxarmjdZ4uXvAsZjb2QDWETeyPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeVviytVY6gXq+DgiqEvVBFI8w8k7A7AfmngkrJO2i0LWTzd/n
	lbpR6tY4KEb3RxYebGcNYWi9jinRj11MZ6TZAz08xaxr7ycPO94a1sg6yr7m63zP6n4=
X-Gm-Gg: ASbGnctaoMBT/wV20CP5Z9nY88fF/VkwTqk7M71UrYhB7sXKKSkD6A0ysPIoERhaCif
	ZBVohydoHN2+7QQm3I/otN9Ij7mdCk2XK4UCh51Vwz+vHilJAXr4cSKkPzIFeGuQavahioLJkUW
	gFoTRNvrzhu9qeCr0EeoOTQkjIunDCcWIspuJScgsY+AbD7dZNMurcWyIZH2odEoWXNsGfNUdMX
	f52ak5zMZpovdqQcm5dPZc6RQjPDf+7mkSAJGODXvJne39b4bWZBuJUCJDjTUhbes9ZLIQvMriu
	8pPDglKNsgwdl0phplgZdCxqlqfOlEtQ0pA7NJhQAHeMTNleSRed8X8t9PPvpmCJKOFnp01LMlj
	+cfMEyrpgBNJlvtewM2f4Nw9wXx4TPMbVYGJjN3w5khti9t6+WXyPvHux
X-Google-Smtp-Source: AGHT+IHuRRsekWNjgE7yCPLG9pq3eS/GOyyUhj/f2Q9rAEjbYAirvs/e72q2qhgNkEK8PrNvRevQ9g==
X-Received: by 2002:a17:903:3d06:b0:27e:ea82:5ce8 with SMTP id d9443c01a7336-28e7f291db3mr15309515ad.14.1759276125338;
        Tue, 30 Sep 2025 16:48:45 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6882133sm171972415ad.89.2025.09.30.16.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 16:48:44 -0700 (PDT)
Date: Tue, 30 Sep 2025 16:48:41 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Florian Weimer <fweimer@redhat.com>
Cc: Charles Mirabile <cmirabil@redhat.com>, pjw@kernel.org,
	Liam.Howlett@oracle.com, a.hindborg@kernel.org,
	akpm@linux-foundation.org, alex.gaynor@gmail.com,
	alexghiti@rivosinc.com, aliceryhl@google.com,
	alistair.francis@wdc.com, andybnac@gmail.com, aou@eecs.berkeley.edu,
	arnd@arndb.de, atishp@rivosinc.com, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, bp@alien8.de, brauner@kernel.org,
	broonie@kernel.org, charlie@rivosinc.com, cleger@rivosinc.com,
	conor+dt@kernel.org, conor@kernel.org, corbet@lwn.net,
	dave.hansen@linux.intel.com, david@redhat.com,
	devicetree@vger.kernel.org, ebiederm@xmission.com,
	evan@rivosinc.com, gary@garyguo.net, hpa@zytor.com,
	jannh@google.com, jim.shu@sifive.com, kees@kernel.org,
	kito.cheng@sifive.com, krzk+dt@kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, lorenzo.stoakes@oracle.com,
	lossin@kernel.org, mingo@redhat.com, ojeda@kernel.org,
	oleg@redhat.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
	peterz@infradead.org, richard.henderson@linaro.org,
	rick.p.edgecombe@intel.com, robh@kernel.org,
	rust-for-linux@vger.kernel.org, samitolvanen@google.com,
	shuah@kernel.org, tglx@linutronix.de, tmgross@umich.edu,
	vbabka@suse.cz, x86@kernel.org, zong.li@sifive.com
Subject: Re: [PATCH v19 00/27] riscv control-flow integrity for usermode
Message-ID: <aNxsWYYnj22G5xuX@debug.ba.rivosinc.com>
References: <f953ee7b-91b3-f6f5-6955-b4a138f16dbc@kernel.org>
 <20250926192919.349578-1-cmirabil@redhat.com>
 <aNbwNN_st4bxwdwx@debug.ba.rivosinc.com>
 <CABe3_aE4+06Um2x3e1D=M6Z1uX4wX8OjdcT48FueXRp+=KD=-w@mail.gmail.com>
 <aNcAela5tln5KTUI@debug.ba.rivosinc.com>
 <lhu3484i9en.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <lhu3484i9en.fsf@oldenburg.str.redhat.com>

On Tue, Sep 30, 2025 at 11:20:32AM +0200, Florian Weimer wrote:
>* Deepak Gupta:
>
>> In case of shadow stack, it similar situation. If enabled compiler
>> decides to insert sspush and sspopchk. They necessarily won't be
>> prologue or epilogue but somewhere in function body as deemed fit by
>> compiler, thus increasing the complexity of runtime patching.
>>
>> More so, here are wishing for kernel to do this patching for usermode
>> vDSO when there is no guarantee of such of rest of usermode (which if
>> was compiled with shadow stack would have faulted before vDSO's
>> sspush/sspopchk if ran on pre-zimop hardware)
>
>I think this capability is desirable so that you can use a distribution
>kernel during CFI userspace bringup.

I didn't get it, can you elaborate more.

Why having kernel carry two vDSO (one with shadow stack and one without) would
be required to for CFI userspace bringup?

If Distro is compiling for RVA23 CONFIG_RISCV_USERCFI has to be selected yes,
kernel can have vDSO with shadow stack. Distro can light this option only when
its compiling entire distro for RVA23.

If distro is not compiling for RVA23, then anyways CONFIG_RISCV_USERCFI is by
default "N". This would simply build vDSO without shadow stack.

>
>Thanks,
>Florian
>

