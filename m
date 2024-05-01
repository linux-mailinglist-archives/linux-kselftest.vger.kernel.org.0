Return-Path: <linux-kselftest+bounces-9235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C318B8FA0
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 20:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776E91C214BE
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 18:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769AB16079A;
	Wed,  1 May 2024 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SU9geB7W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5DF160785
	for <linux-kselftest@vger.kernel.org>; Wed,  1 May 2024 18:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714588661; cv=none; b=BTXZju0dz5W2EeyTAqXkkIX93MQ3LSEjLEcpizCPGWggvijjIkk5qnTX3dsDH5jHB9YFjwdT2ekZd1kTgPj8IDzyb8ZAkbQSCcrmfUHsBNP5Cmc/n+z5gk+5+jDagwMeBCg3T456Kcm+zxk8gEKpFeS1+c9zrqdgBYb/CuviF7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714588661; c=relaxed/simple;
	bh=JuEww4VdQj0DUkQJJy7CdW/ah+PwXXtcE+4baSBSWmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9ZjHrX+mOBQGfCJeGGW3e0obXswAZz52wK+uVbN6kScBKLJg7uIk6mrOhUmu753Co4qrBnDEhXKsXiqb2jHppbK6IebRmBozrwgz3/ukdF8ZSN92qCByi2i16UXvVyTumSKV5vrfDHUsnXCq3QAH+sq1GipxWWNcpBWccLdY78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SU9geB7W; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ed627829e6so8378455b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 01 May 2024 11:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714588659; x=1715193459; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UPPZ5LFjy8shqZnGR3m66PAl3+HNQfmLTm+BXjtgDiI=;
        b=SU9geB7WtsRPik19lbwiTnZkq4+Ugy3cwxvvTohX8CwkOWxS4p3goKGUICi9jfPssK
         7g5/wiAocpqguorU9SNgQ1nx/XfxmKxwoFUbPr2HKeW25SxpPTXLnAHSBlQqWsY7lCZs
         0AOdHXAyUQmjEfhBvOi/3/yi1vaQJhLHnqJklizccrsiu0CAkvAyVhoZaLbvZwjuBtrg
         As07tNkCkn56pecg8Y5kBlmfjH9TLr4gXZtilMp1vuEfUKpc6QJ2CTtvkQlhLp9V66tH
         s1HdQWPF9RNpMyCAU2Ps3R42M4kQo9BpeqqTSDs+ImWlSIWHVriCowOSOzmpdQ3zxvaJ
         exyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714588659; x=1715193459;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UPPZ5LFjy8shqZnGR3m66PAl3+HNQfmLTm+BXjtgDiI=;
        b=lyobBykDeTeaHJ2b1vAZB++TScinDtg581zVWvlIheLCglndmYH5dJeozrf4KtGRKN
         Vy4OPny2C5GgwQBXB+jTbCj4aGgJhfX0+vx/QxKtew0TfgyUpi1il0L7L2Ryjs0kAc+D
         T2wKSGrnmwyO92tzFIUsnVlB9AEx2x4nS0bt/Lfli23+Tu5fVw9EeixMhWyHN5ELqg6x
         R+kiFNGv41tbctRkQPsOQ6wKU+bzULMCPwKQNoJsf0NiJ2SRnnr1FZnwnkpq4d8e5vgD
         yCCmIpukSbMYMXgPc4iNVs662ArX44pXJdYPxkuAUAFhNsp/59fk6x8t4qboWBAFZ5Wb
         yZAw==
X-Forwarded-Encrypted: i=1; AJvYcCUucrYyAqDr2w4OcWHbGABdTKpMo9NiKtuk0GQShk73G8/MVuTiuy7POwTVtgMBNN9HTBBXhy0UkseuoPpHwz8owE0nYxsAUE7S5E/mB3MO
X-Gm-Message-State: AOJu0Yxe9ee5K17WzIZ+15ACbXI18/CMh7XoLr5R7QPMboS1EUm74D7J
	K/kTlQREEoll1pphZL6rL4PYNvlmWupBLdxVcDBMWm54dBN79dwUMGoF+mrOl9A=
X-Google-Smtp-Source: AGHT+IFvmfcgG9gsaJ1/osT3hsX+JLkHUCdFQSUoli8OLgDET6zbJ2GqgYGb+4vjIsoV+zp3JnL2Pg==
X-Received: by 2002:a05:6a20:8425:b0:1a7:3b4a:3e8 with SMTP id c37-20020a056a20842500b001a73b4a03e8mr4113035pzd.7.1714588659240;
        Wed, 01 May 2024 11:37:39 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:1dcc:e03e:dc61:895d])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090ab78800b002b15e6ec4efsm1672349pjr.15.2024.05.01.11.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 11:37:38 -0700 (PDT)
Date: Wed, 1 May 2024 11:37:35 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Evan Green <evan@rivosinc.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 05/16] riscv: Extend cpufeature.c to detect vendor
 extensions
Message-ID: <ZjKL7x+s5AYzdCGE@ghost>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
 <20240426-dev-charlie-support_thead_vector_6_9-v4-5-b692f3c516ec@rivosinc.com>
 <CALs-HstM64Hy_=XVz=0sWQt=8j1u+bq6RhthUuD3P0E4=HyvcA@mail.gmail.com>
 <ZjKBKg5zzikR5ngl@ghost>
 <20240501-banner-sniff-4c5958eb15ef@spud>
 <20240501-moneyless-shifter-a54bbaecc4e7@spud>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240501-moneyless-shifter-a54bbaecc4e7@spud>

On Wed, May 01, 2024 at 07:09:28PM +0100, Conor Dooley wrote:
> On Wed, May 01, 2024 at 07:03:46PM +0100, Conor Dooley wrote:
> > On Wed, May 01, 2024 at 10:51:38AM -0700, Charlie Jenkins wrote:
> > > On Wed, May 01, 2024 at 09:44:15AM -0700, Evan Green wrote:
> > > > On Fri, Apr 26, 2024 at 2:29 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > > > +       for (int i = 0; i < riscv_isa_vendor_ext_list_size; i++) {
> > > > > +               const struct riscv_isa_vendor_ext_data_list *ext_list = riscv_isa_vendor_ext_list[i];
> > > > > +
> > > > > +               if (bitmap_empty(ext_list->vendor_bitmap, ext_list->bitmap_size))
> > > > > +                       bitmap_copy(ext_list->vendor_bitmap,
> > > > > +                                   ext_list->per_hart_vendor_bitmap[cpu].isa,
> > > > > +                                   ext_list->bitmap_size);
> > > > 
> > > > Could you get into trouble here if the set of vendor extensions
> > > > reduces to zero, and then becomes non-zero? To illustrate, consider
> > > > these masks:
> > > > cpu 0: 0x0000C000
> > > > cpu 1: 0x00000003 <<< vendor_bitmap ANDs out to 0
> > > > cpu 2: 0x00000010 <<< oops, we end up copying this into vendor_bitmap
> > > > 
> > > 
> > > Huh that's a good point. The standard extensions have that same bug too?
> > > 
> > > 	if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
> > > 		bitmap_copy(riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
> > > 	else
> > > 		bitmap_and(riscv_isa, riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
> > 
> > I suppose it could in theory, but the boot hart needs ima to even get
> > this far. I think you'd only end up with this happening if there were
> > enabled harts that supported rvXXe, but I don't think we even add those
> > to the possible set of CPUs. I'll have to check.
> 
> Ye, you don't get marked possible if you don't have ima, so I don't
> think this is possible to have happen. Maybe a comment here is
> sufficient, explaining why this cannot reduce to zeros?

Okay cool. A comment is sufficient then.

- Charlie

> 
> 



