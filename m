Return-Path: <linux-kselftest+bounces-8223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2A18A75E2
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 22:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606771C21296
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 20:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB813C064;
	Tue, 16 Apr 2024 20:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="d/gZKGmn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDF03C467
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 20:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713300193; cv=none; b=eGJZUdj1kd+KVBPSN/07/Ot3fF7bJs1nz0Is9RR61eeOlTGI88njsz2YOtCv1mdAK46LbvPmeBUb+MJSzWCQKFcF0NXxCUzGIMR6LHF0HdctiQ2dWvTBCRjM9mG03KmX+Wm80es9FQHtc/AUQaGd7DQ6hQM0TPW88bcP9yifmv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713300193; c=relaxed/simple;
	bh=QZKpJHO+aihnmfUC+QgGjO4FBuSK+x9rFDZi5traRCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjagTlLT8k0oOdtEz22wqLAa+kl+J7/pN+GSU+vQfspSX5lWyD9Na25P2uvAYEKjcSe8NRNhwjiXak3swfWpFAFMgkDIu+GqqWvxF91fejQWsQsRaBxVUXF9TYnQhbR4T7YwBFdOnLUvQRnd3bqyNufuOXiL/iBRrxSLUko+YLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=d/gZKGmn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e3ca4fe4cfso31693985ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 13:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713300190; x=1713904990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s6DlS4/ZFHRtR1n8rjuKFrNyH2RJ3e1I9x+YwBEN4QA=;
        b=d/gZKGmnJWx5+6sDeem1zlJ5ZOI1iv+LaavI+iZ+Q0MQrrhp0RPG9eHJS0wvKFpg6X
         pRj4Dm7elK8fv2iwAGSxqQomyEfzugsQvGauj1Ae13vf36aZGK3UM+pvIMViLDdlFS8z
         r4jg/xVdOoDvMgiuyWEutHhfxVFanZYg0uFEXR44ZTJYwx0qI7Onq+QdnVxJK2ZDz8KQ
         r6yNIg1sV575dKRYoV4OdliojD5qJG73Kluwk/HsXA5nu4nWzPRaTtcU8k1DRPdB3rUQ
         Qo+MZryhWsIWbV+D1VbzY/gYdOVH18Tc2fTApKd77zys4EUBjMMBGWQDnHdBTxIw0Kv3
         fXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713300190; x=1713904990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6DlS4/ZFHRtR1n8rjuKFrNyH2RJ3e1I9x+YwBEN4QA=;
        b=iEUqNHf6Aljzb29UxIpd22p9mCUZFg/aw8X6SjHZA4VzuiI6zVe0lcTDtNtQJ30aNj
         GeD3mErcWGlzvjybji8wgkpAmRTTZCc8u85IxXnsYXA2M7TxaF5RmkdZUsZimjWWsk1p
         iChO7QzvtOGUU2iSPnY9gJE2dzG45kXYM9BbU6bMQyN8ftNyuqptUuU0qsKnZFd3YJxW
         xsd3pnXCUSRL7bLxVNf6Z376dmRV44zDRIE0n+9SIvXoe3q2dVMYGrTpvcHRZbQ8yWAp
         GPo2wsRQMk41g/6CJupO9NZB/uEIDwG3CMh3IVfaxQLSLmGcpdQ2pd2mOu2y4+8JLzYA
         93Ww==
X-Forwarded-Encrypted: i=1; AJvYcCX7ErWOePAD3uxvV7ftS/xmNjMaLaXHZoNvUKZKVN3hE7UL6G7TZw3i2KWOXUA4dZ4FI4g2gGMiBiPTPFvjJ38GO15OCCATl0qkUWSAFhRs
X-Gm-Message-State: AOJu0YxA3DsGfnqZO70z09J0F8vtFJuTdH5Cfm8w/KO9Y513cFWrYkI7
	dd4lHQI4umzE+3BkbvwUcDMbH8qirUYhxnQBwLbE24WTj9R7hdfXpE64pStsV1Y=
X-Google-Smtp-Source: AGHT+IFyoZj5HEINi8NXkextzYF7UARPdxsaF/H0cx3mKUCsmkMsWC93P8slgpGTD9NT7JEfzLALAg==
X-Received: by 2002:a17:902:eccc:b0:1e2:c1fd:7bc9 with SMTP id a12-20020a170902eccc00b001e2c1fd7bc9mr18892761plh.8.1713300190182;
        Tue, 16 Apr 2024 13:43:10 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id lg7-20020a170902fb8700b001e259719a5fsm10208534plb.103.2024.04.16.13.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 13:43:09 -0700 (PDT)
Date: Tue, 16 Apr 2024 13:43:06 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 02/17] dt-bindings: riscv: Add xtheadvector ISA
 extension description
Message-ID: <Zh7i2pir0j6tXfPD@ghost>
References: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>
 <20240415-dev-charlie-support_thead_vector_6_9-v2-2-c7d68c603268@rivosinc.com>
 <20240416-underwire-bright-b2ab0fa991ec@spud>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-underwire-bright-b2ab0fa991ec@spud>

On Tue, Apr 16, 2024 at 04:16:30PM +0100, Conor Dooley wrote:
> On Mon, Apr 15, 2024 at 09:11:59PM -0700, Charlie Jenkins wrote:
> > The xtheadvector ISA extension is described on the T-Head extension spec
> > Github page [1] at commit 95358cb2cca9.
> > 
> > Link: https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cca9489361c61d3
> > 35e03d3134b14133f/xtheadvector.adoc [1]
> 
> This should not be wrapped btw.
> Otherwise,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

I don't believe it is wrapped? It appears wrapped in your response but
it appears on lore correctly:

https://lore.kernel.org/lkml/20240415-dev-charlie-support_thead_vector_6_9-v2-2-c7d68c603268@rivosinc.com/

- Charlie

> 
> Thanks,
> Conor.
> 
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  Documentation/devicetree/bindings/riscv/extensions.yaml | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > index 468c646247aa..99d2a9e8c52d 100644
> > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > @@ -477,6 +477,10 @@ properties:
> >              latency, as ratified in commit 56ed795 ("Update
> >              riscv-crypto-spec-vector.adoc") of riscv-crypto.
> >  
> > +        # vendor extensions, each extension sorted alphanumerically under the
> > +        # vendor they belong to. Vendors are sorted alphanumerically as well.
> > +
> > +        # Andes
> >          - const: xandespmu
> >            description:
> >              The Andes Technology performance monitor extension for counter overflow
> > @@ -484,5 +488,11 @@ properties:
> >              Registers in the AX45MP datasheet.
> >              https://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
> >  
> > +        # T-HEAD
> > +        - const: xtheadvector
> > +          description:
> > +            The T-HEAD specific 0.7.1 vector implementation as written in
> > +            https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cca9489361c61d335e03d3134b14133f/xtheadvector.adoc.
> > +
> >  additionalProperties: true
> >  ...
> > 
> > -- 
> > 2.44.0
> > 



