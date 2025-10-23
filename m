Return-Path: <linux-kselftest+bounces-43857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29668C00726
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 12:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC9D19C39FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 10:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6D530AD08;
	Thu, 23 Oct 2025 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZcV90xHW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D2130AD15
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215065; cv=none; b=m7zVKB5z0TNeoYp6lg5lhjjX4xd8CzpgDjETn5GDDDn/fS3aEu46RTV9VUkWYsoEl+QkIkf1EhiKi1DsAATYoHqO4wBGdNjq+F6B7IRKymenbWNmrpA/RSQsSy3MuXHB0a2jWEoSvh0QOFk6dGx85koBrK3YpUQpsaneDCsZ6/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215065; c=relaxed/simple;
	bh=JIzZvR0IM5/lqs80BT7Oz1VCJ8+Q0TiAdIgYrZiCFOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KPqoHDYYGid5otfezHZBJ2btMuumoI6Xkfq8Gh9Ha0uXhT3YKXg3MEUHvG4a5HBDQtf+gyaldhq9vnIB4VTtSFpIu5LHKT3WmR+RPJyvCfk6XBWOZgsZpHd5KvPDGIt/I4nqixDQVaR2igGebDLdrhQZVLcoh5rdEoFyrCxrAeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZcV90xHW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761215061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1/xMKYfvMu1YGz7qL96V/7BwEt8aejHjZ0on8OqbaxM=;
	b=ZcV90xHWwsyMdYWti3dJ3CrtqX1O/t4IEcHn8kXdtfKzEz3yiYx0OukgzKYhSqxpoWooq4
	WhnZvZ7D3v3RCBDbB/awN48sMAs3YJqzchRNfe3jvA5PgyZbrDygxhIEz5wCPRBAcLqUE4
	XmudgEnI/MAp8KGHCpdlzMz4qPSjKBk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-aOHbecqMNHyhEvGrswg6NQ-1; Thu, 23 Oct 2025 06:24:20 -0400
X-MC-Unique: aOHbecqMNHyhEvGrswg6NQ-1
X-Mimecast-MFC-AGG-ID: aOHbecqMNHyhEvGrswg6NQ_1761215060
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-471193dacffso3110295e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 03:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215059; x=1761819859;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1/xMKYfvMu1YGz7qL96V/7BwEt8aejHjZ0on8OqbaxM=;
        b=pC8iEAHaMBtR1OoQxe/LiYWxMckgQJaN5ZAJE32o13XbiboB+r1Ep49Wj6jmLb0lyt
         8XC7s6qlWDhqe/CNdi9gV0RIYBv4XrOq1cUIx+8SoFo6tkYWQ5uknrXyGDsNB9MjnDiA
         KZx13nPUYEBMV/rSrtvnHGAkxRsp9HY9HC5NnE1lcRRQyEc7ptgrq9735BOmLaXqW6z0
         8rUkfpzD24DNUk6Byp+XWi/gXuBSKgUVWeYcxR3T6itfPlmWjCoQH2J72NA3YKgYGWLe
         3po8mx0VAVVXXhHP8XbBwmryngV27ot34XOr82kLnf4ZKZF2nMGf3MQVPKcRB7QvjGgS
         Kefw==
X-Forwarded-Encrypted: i=1; AJvYcCWCyF0rrzpzyLC2Fy4UcI4pK1UT+1imIydsps5T0eFkn5A91/93lD3z2q6VR8lD+ZL28bc9mYAIiNA07pNIabY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY7l4yKurj9W6DrW/PxQW1j5Mm0WfYYV+SQa78gjdpqGH5EvrR
	CBb9AtVsB2MPFGbr0L4UefEzo72vxURjsdjDnZdDtFYACMq4g2oEMmORdPg2mqHfd8wpdL8lALt
	5MzCxdYnmx4MwTT2peNtsr8wVNdEctky+ELdbbkeh5HJHJ1SxxuIOCgrkNxrTnkeVC7xJrA==
X-Gm-Gg: ASbGncvsdUIHlOiPDu2tmDMz9jf56VKVPsykE1PgP1VY0ylOP+iK2abNL+NEcFGYIaB
	5LFFZK3tr1VYPM/iBRU1CLGVFsh4nV9R7NDOeSPLGpK5hzc0+1PvPaK4Zg8gNPNTOSZJ41JK9/L
	1I/U9R2qd99sE2x1rI26dFulRX+qCEDPRdfekzP8/eFnZXtpunyvul/gShw1dRcRPESfdK4WlN4
	x2Xp8r2hdtRgiogAd2DyxU17Xm9nGa5CXxJsEUlZjEo+Kaml5WgZN5CY2Y63B4yUvwTMjmGb53r
	kKGeSZSyDkbDoSK34BG+jdKAZ7JfMlHw2jiMH0V1+PMDhKZ3Zd2mhqm2W/PSh8s8DfjcBDbaQgY
	iro6VxCEQ3/PYWivN4Y9nlQG3Th3ys7yefviMjKLFDkm9uPWSAs/GcM5A97GbiZWeE9eRnMgZsb
	CcM/FIzfGNPGNaMjI8OwNo6d+LgF0=
X-Received: by 2002:a05:600c:870b:b0:471:9da:5252 with SMTP id 5b1f17b1804b1-47117919c1cmr189577875e9.29.1761215059432;
        Thu, 23 Oct 2025 03:24:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjH/mlHW++27nIjpsj7VgD+B0CKlZFUwUCNHGxzHcP9BXP5cXJRmKaKsGoIUZvaeLFPPT93g==
X-Received: by 2002:a05:600c:870b:b0:471:9da:5252 with SMTP id 5b1f17b1804b1-47117919c1cmr189577335e9.29.1761215058948;
        Thu, 23 Oct 2025 03:24:18 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428dafesm87035605e9.6.2025.10.23.03.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 03:24:18 -0700 (PDT)
Message-ID: <14f96ff9-9c96-43d3-8588-0730d26a0f87@redhat.com>
Date: Thu, 23 Oct 2025 12:24:15 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 00/28] riscv control-flow integrity for usermode
To: Deepak Gupta <debug@rivosinc.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Christian Brauner <brauner@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com,
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org,
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org,
 Zong Li <zong.li@sifive.com>, Charles Mirabile <cmirabil@redhat.com>
References: <20251022-v5_user_cfi_series-v22-0-fdaa7e4022aa@rivosinc.com>
 <aPl3vr-mYljA7Dse@debug.ba.rivosinc.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aPl3vr-mYljA7Dse@debug.ba.rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.10.25 02:33, Deepak Gupta wrote:
> I don't think I am sending that many patches. It's 28 patches.
> I did send v21 using same smtp settings on my end.
> 
> Although since this week whenever I am sending patch series, after 14th/15th
> patch, I start getting below error for all recipients.
> 
> """
> The user you are trying to contact is receiving mail at a rate that\n
> 4.2.1 prevents additional messages from being delivered. Please resend your\n
> 4.2.1 message at a later time. If the user is able to receive mail at that\n
> 4.2.1 time, your message will be delivered. For more information, go to\n
> 4.2.1  https://support.google.com/mail/?p=ReceivingRate 98e67ed59e1d1-33dfb7f8310sm153460a91.5 - gsmtp')
> """
> 
> I did try "git config --local sendmail.smtpReloginDelay 60", it doesn't seem to
> help. If anyone has faced this and knows how to get around that'll be helpful.
> In the meanwhile, I'll keep figuring it out on what really changed this week.

I got that as well a couple of days ago after patch #16, it's annoying 
and I did not figure out easily which gmail user to blame.

After git-send-email failed halfway through, I decided to just send the 
remaining emails with --in-reply-to="" giving it the message ID of the 
cover letter.

References: is in that case still messed up for the resends, but at 
least all emails show up properly in the same thread.

I had to take care of the CC list, which was annoying as well.

-- 
Cheers

David / dhildenb


