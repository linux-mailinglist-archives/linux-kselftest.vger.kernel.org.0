Return-Path: <linux-kselftest+bounces-11693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED059042CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 19:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BE8EB22A5E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 17:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3A6605BA;
	Tue, 11 Jun 2024 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zCuxTome"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACBF2570
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 17:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128325; cv=none; b=qzugpfRXg6tf9IQDb+FKoh7iKiEPmmtQKQk0ZxroJa5B/TmHxlH3bAEDHaLw8md17DOYJTsgo7sCk5ejayF0K+7i6IYltWnpNfzfXk+VwOmapCiHfsWfbk+5q2WknZJKf9UkmOeJ5uiTBTxyW4cZOqor3hQ4+G/lUFgTdDaN5cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128325; c=relaxed/simple;
	bh=j6Mw7Dc/Rmamgq8D0n3FKdWISB6Vssoz9/RfITAP4S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H56Adgjra8zkZNp7k+yvaFnaxmLl8T3JRWADaZdzhu2raotj7O2aVP8QYF1KRGmI1BZdV7t7PNeVvj2i+h011X29HG1MFy5qC+JlcwSP9CL2fqShhGQAy1NoVn1xZTIhJOOKvbloI3enVkr8OZ3JQHx6er4ixqvC+hK1dEPHhPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zCuxTome; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f692d6e990so55874295ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 10:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718128322; x=1718733122; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v+kzQ+TESmWH2rodDnJAJg+m005wAbuCyRq3fRyc+L4=;
        b=zCuxTomerusXHn49OFrZiVcC8OlR/i02QrewLcCCtHLlKXSItsPoMxTuce7pUN1ZAW
         I2BdcObaOaHiBFE7UGp4q+iEkREwhCAnA/ivrTXNxpuDl2tE5empr6hRpASREryjq9Fx
         Zd7oNX/71MO02C7qQz1CcMCb+Jp0+TVo+56WmXaW7FrDwhGuhTaaRjl+njM+dA+itvNd
         6uvmU7kxZ2cWr7eDsv4Wpz9In3bEDADlRBGJ+xos0tNzB7GQLWvReJry1M9lxjPaHR1k
         XYVLB/Uq8Pmebhl5N8kuYnWGKQ+8cJKUNzV8uSk7J5LcWeVqMwcqgoSaQxrepF8rkk93
         t2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718128322; x=1718733122;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v+kzQ+TESmWH2rodDnJAJg+m005wAbuCyRq3fRyc+L4=;
        b=uM3f6c5XLIk5oCZnn4Nktdprf32/GfLhNvnTrGgm8WeI/b1M0XZlIeCPdyVoTST8F9
         2UHeXKE+Wnua2H80/fehOS3OOtyCkEFjYTQzIu8/86qEoBm6hZJ7ZJVp6YGI9RYiBiLx
         eSKLtZ0hZlyuDvxhRnK7uTqRdX9+ifh9mz+e73JQMItm21Cd8LRQjJgD54V359l5x3zS
         xQD0CHfFHrvloDAj4Hnb04Re6PrJCka+9TbFRuXzVVRZTu3BZRa+lv6rJzUI60+lwQoz
         QCfllBr6gc2hqNrR7pehr2+aNVHwqX0Y9TtDDXk4ry/+lPaqueZjLudBm5nz5t/djvA/
         xZeg==
X-Forwarded-Encrypted: i=1; AJvYcCWqzkya8ANlecMbxKob7EbShb1+Pxb6WsOelnwE7rX9yCMD7aL0FmXN89EUxNX/Nz2vuOPy9JNr1MNK0I0fgSWSpRgRkHZEwbWeW+1LhsiE
X-Gm-Message-State: AOJu0Yw9srxdiI/eWSxR2eSojw2VMI8Uiq5SLn+JFbaXAVl+bwWk9dj8
	5SqZqz+8hLItcYRaPTaTUt1DitGzYsByLwz5udzY+ONronZaiDra5Xdg1WgPg+Q=
X-Google-Smtp-Source: AGHT+IG0CXcMZTGrM4/Ht2qa5w3o4qJ6+EtsZ/LkU7bUGzv5nEqEbQ4X3YEnvEJE/XsG2nOTE7o+Wg==
X-Received: by 2002:a17:902:e80a:b0:1f7:2490:cb69 with SMTP id d9443c01a7336-1f72490d4d6mr50156005ad.60.1718128321885;
        Tue, 11 Jun 2024 10:52:01 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6fadca2b0sm59819315ad.206.2024.06.11.10.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 10:52:00 -0700 (PDT)
Date: Tue, 11 Jun 2024 10:51:58 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Guo Ren <guoren@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Evan Green <evan@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH 01/13] dt-bindings: riscv: Add xtheadvector ISA extension
 description
Message-ID: <ZmiOvgabh3Rd5Vad@ghost>
References: <20240609-xtheadvector-v1-0-3fe591d7f109@rivosinc.com>
 <20240609-xtheadvector-v1-1-3fe591d7f109@rivosinc.com>
 <CAJF2gTTVu4ZQt+gK7pVYEDVG23Sic=jswkVvX4To=VAD0TMzxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTTVu4ZQt+gK7pVYEDVG23Sic=jswkVvX4To=VAD0TMzxw@mail.gmail.com>

On Tue, Jun 11, 2024 at 08:06:34PM +0800, Guo Ren wrote:
> On Mon, Jun 10, 2024 at 12:45 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > The xtheadvector ISA extension is described on the T-Head extension spec
> > Github page [1] at commit 95358cb2cca9.
> >
> > Link: https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cca9489361c61d335e03d3134b14133f/xtheadvector.adoc [1]
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
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
> URL changed
> https://github.com/XUANTIE-RV/thead-extension-spec/blob/95358cb2cca9489361c61d335e03d3134b14133f/xtheadvector.adoc

Oh okay I will change.

Do you know the answer to the issue I raised? https://github.com/XUANTIE-RV/thead-extension-spec/issues/52

- Charlie

> 
> Others, LGTM.
> 
> > +
> >  additionalProperties: true
> >  ...
> >
> > --
> > 2.44.0
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren

