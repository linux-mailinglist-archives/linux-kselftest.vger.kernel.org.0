Return-Path: <linux-kselftest+bounces-29544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9414FA6B50E
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 08:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287F93B036D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 07:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A591EE7B6;
	Fri, 21 Mar 2025 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="QQmtMvYU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EF91EE008
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Mar 2025 07:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742542308; cv=none; b=UCYjAhYBoHfgXbuRjZEGMZXnfNZnLN+QvUwFI+oB2dQYmPv4VhVRZMby3wrVN81kL+bmWKhJEVESkqddZgXLFof2kHugaR9SrHVKAb4zPB5o21qOKUwkzA9WX/VSfvY9Idg+hdu6CQD4VQ6F/uXY8hKCOkdEw3O8eenRI7WIjwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742542308; c=relaxed/simple;
	bh=GdD46RXzLITLcyofqDJ2zWxNrp2LOOXutJPFHpVGBHo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=TJz8iQDwztAvaa9XTVUCAAEiPXLli+Xeq9bFzdT5dXUUoG2P0H5oWr2ugDI8zgiXNyGPxUv183OgJWVXOoEzLsPBSL307bEyIHxiXyZdi1rp0Fu6btfUpWG3MqWQOZEm1Fo7b+ux+g+CnkAYPYn3cHH7oUYXnCuuqE1qf9kypsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=QQmtMvYU; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3912b75c0f2so96392f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Mar 2025 00:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742542305; x=1743147105; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EA53ZruOOQL6IYeAD91OZdQ4lvT8qFBPlQC4O1CwTT0=;
        b=QQmtMvYU6Q53j6hUeBMHzB4neX/xdvVL0pbT2TDe/5ndgYuMG1xp9WZ2C94YnnB4yO
         pCL9UvOSe10UK3WdwdpwD15BYKaYijADRw//75nfLGm0rtB8amloFZXBoUcVQ/ZMWDKr
         5o5LbeE24PyKNltBklqhUm0aj45cVDdrtbFxYzqU43K5HeMbM0eCD2Lqkf4ZJi82QqmO
         vUrlonj1ubUhaKNdmuk6WclJdvRffA7sN6ABfu3fyqMzJvwnEXKR9Q6/YwgdcENc6hbs
         QTz2K9PW2i0Lwsc2yFHBBL+RyISsYkPzpMV9U4aSHY39+iC85zugSnxTfQmAdYLPzcJq
         CYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542305; x=1743147105;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EA53ZruOOQL6IYeAD91OZdQ4lvT8qFBPlQC4O1CwTT0=;
        b=luQ2XBTfIqPXO7Tvpedcg9IOiU/VEJT8Ywa8bZPJUS9OcdG1EZyLwO7GcDwQbQj4ag
         ZoUVO5fxjdbfjcpdafE0aoD5Ok/zU6wCkcqQh+Ok5hAg50exBEs9vdEQVQsz9usHTLRT
         gfZCcYa5J87bXapyc3BsZLqmmiMACzd3VjeF5/kX/CUY5CjqB5krq/Kaan1mQRvKi525
         QHdVF4JgE+58ro1U2NAyxH0huTrJG1bVwp7GLUVF0IJTV/mIOTIR6F2ez2xEO9l/qlTN
         TkTYnAH6yuMqsMKbsiUHtlGWs/5c88eB8F1nnERgpCvi9m0ym0oqVC5KEp6kEabuufAM
         axhA==
X-Forwarded-Encrypted: i=1; AJvYcCU9vg8Z0qwp+196p4KvuwnRpsjGJbFn/eWtnMt4hBX5/U4RpPkQxH101akSQnrDvbuhZYT4U6d9IHqtbOCXJwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrlTyhrDvimGl6YXQB8j1SZgyjrHtOwtVOILYFND33ngKpr7zR
	6HQ/KACJrUdu3Qucbd+u1P3gVeh031cFbuydYg0bLsvD3WirEpuOWAPATOjL6bk=
X-Gm-Gg: ASbGncvKBU6JTrxCul7+xQRJY3/3LZrHFjE/vO/RAiIsHwmOT7NMm4Eu6ZRQQXmeykq
	x66/X3l5YnRy0gMZ8qOoEEqmSWrGoC5mvZgE9M1LlcZhSSSccLZsC5GD9WcrEyn8a6LZVIqlRUT
	ENQq3RqF0lfQHFDQ8cX/b9NgC1I4effRYA9KYKjWSfKz0Zie7snEq+g1rablJYhB2q++8QIzq+Q
	J5Ul4Lf2AEkDjfsAak9y1PWlF+O/1tHRYRmoT/ljlLe2rBjldkx3nzM0Ls7CHsF1haLIFwsbaS7
	ZoCNpK+1fPEq9yf5AZMbeYOGo3WPbSPksVh1w3IWExzGMRgwiDuMz/StXRVOAJfC1cmKSI6I40R
	b6UvO
X-Google-Smtp-Source: AGHT+IGUPJ1yScRfM5ZckM0YOEUPSKKsLT1uHikzcP6azc7wS+CuSOBN2Ombs1xBV9GpD69REV2V/A==
X-Received: by 2002:a5d:64c7:0:b0:386:3a50:8c52 with SMTP id ffacd0b85a97d-3997f917397mr932780f8f.7.1742542304656;
        Fri, 21 Mar 2025 00:31:44 -0700 (PDT)
Received: from localhost (ip-89-103-73-235.bb.vodafone.cz. [89.103.73.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b260fsm1585165f8f.43.2025.03.21.00.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:31:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Mar 2025 08:31:43 +0100
Message-Id: <D8LROZ1Y2LLF.20T6DQS0A39QN@ventanamicro.com>
Subject: Re: [PATCH v12 23/28] riscv: kernel command line option to opt out
 of user cfi
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar"
 <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Conor Dooley" <conor@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Arnd Bergmann" <arnd@arndb.de>, "Christian Brauner" <brauner@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Oleg Nesterov" <oleg@redhat.com>,
 "Eric Biederman" <ebiederm@xmission.com>, "Kees Cook" <kees@kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <shuah@kernel.org>, "Jann
 Horn" <jannh@google.com>, "Conor Dooley" <conor+dt@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <alistair.francis@wdc.com>, <richard.henderson@linaro.org>,
 <jim.shu@sifive.com>, <andybnac@gmail.com>, <kito.cheng@sifive.com>,
 <charlie@rivosinc.com>, <atishp@rivosinc.com>, <evan@rivosinc.com>,
 <cleger@rivosinc.com>, <alexghiti@rivosinc.com>, <samitolvanen@google.com>,
 <broonie@kernel.org>, <rick.p.edgecombe@intel.com>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
To: "Deepak Gupta" <debug@rivosinc.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-23-e51202b53138@rivosinc.com>
 <D8LF0RDZ6809.1I3MCCVSHRSQ2@ventanamicro.com>
 <CAKC1njQR9yARvWffjznjpeZK5zLFpg0-qCUo25_8niH29YL6uA@mail.gmail.com>
In-Reply-To: <CAKC1njQR9yARvWffjznjpeZK5zLFpg0-qCUo25_8niH29YL6uA@mail.gmail.com>

2025-03-20T15:31:09-07:00, Deepak Gupta <debug@rivosinc.com>:
> On Thu, Mar 20, 2025 at 2:35=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrc=
mar@ventanamicro.com> wrote:
>> 2025-03-14T14:39:42-07:00, Deepak Gupta <debug@rivosinc.com>:
>> > +__setup("disable_riscv_usercfi=3D", setup_global_riscv_enable);
>>
>> I'd prefer two command line options instead.
>
> One for zicfilp and one for zicfiss ?

Yes.  I don't want to suggest the naming, because I would have used
"nousercfi" without an argument for the current one.

