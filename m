Return-Path: <linux-kselftest+bounces-10058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A878C2C15
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 23:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45D01F21619
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 21:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DF613CFA8;
	Fri, 10 May 2024 21:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VVr3Cjty"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2FC13B7BD
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 21:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715377649; cv=none; b=KpyJN1q+n2c9U7FJWev+U7xPrnH7q8Tpw5RAaxOCmKiYfXJie6UyUgJ3yqkt1MObLJ2dYjVEJ/hPtyqLlGzHodTHMfjpo9pLuYvtRCxXkGv/QVfxkPYWGPKyeB/1oL6/yurC02wcrmjgJJ/c5In3rBv1dqOVdlTHL43fUhM0J5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715377649; c=relaxed/simple;
	bh=5PYGqPb7LxaoIJQZEfb1VXfIqZRIfuMWFVa30lwrHLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQiaU+Kof287iT1nPUFnhLSuCKUU5G8zuldgewwwAxGJv+yCBRB2Z35B29Q0U1WbcfIVUhQcXRK7P/4plbF0wf/OAAMQ9jK+E/Jgr4aLlk31s5jILDn+XoZbvbRA4FSxWchLDHLIKGLW82lwH8Viw5nLYucUKqQuc+IGW4pv0T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VVr3Cjty; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so15718805ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 14:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715377647; x=1715982447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/hdC9JzZ0lCEDEfdvCSKJ054LE730kwHqEMbc1syn4Y=;
        b=VVr3CjtyftxFz2H8JrzjP40ruQbp2vWE5vWgrcPOmlKbcTTsiTpzwUPUPw9doQxO5d
         aJZND96hUf8FfhLID379wb/mheLiqCrWVkJvZ6x0ZpJg2sypTBbO069OVDUg8T9W5v4V
         CEs00/AM3rrgj+2DoJr8HCAuiB6yDpeacVGhdCQC75xTsFAhsI1eaaH8hE1v7zOEbPSJ
         S9jcq6CvBq597R6AXjz00bRqonpAgeJvS5iNvQYwNWRKfAtXXfwe0FKgzPe6J9dH1NS8
         YPoj8RhGFQDPbrmXqM68Ty284g0CW1Azt2wY68Q1METBy6Sx6LyMDx8VQCO2luLNX12B
         WN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715377647; x=1715982447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hdC9JzZ0lCEDEfdvCSKJ054LE730kwHqEMbc1syn4Y=;
        b=O1hKLPuROIwDqe95nnR28ToiC6WW4P12qDg7iqKRSeQUfhmOGWpLTdz1d3RQfRXQkO
         IIq6zyusdNHulRy88AfnxPLzDQDmFK7n6aU848I92fM++IDefJJrMi8xPDDXdEy0qd+a
         SImm+jn7Tj4NzahiE9VlWIEST905JwWlzIV98dwksMKZ0pan9Ex3ahW2N9j5z7pK2NNz
         effGYf00wwWs962kIBmW+uRM4rs00Jj5Ekv4kUtwUkTr5cFxmhbq2/MyUN3narNNy5gH
         uCUqITwLIbJsAdnTOkidAK+/lpVukEgcYbdt87OUM/tlzidmOvX0N74twnqj7kg+KpSL
         ICcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbyl8+t+A43Qme+rCrOSOE10v40XkWd8R9UFZo/H0N96Gsw1nm9Xt85JyT8/jf6UfD5LL+1ekW8dhSXwXsaTSzvEcrK29OKmMl3UKDdIos
X-Gm-Message-State: AOJu0YwjUewRz+3jOu7XVnn8IR1/33QbW5aZXuHKS0jZHlxMyL5lbsut
	aWeCs6gjEsy0b29oWRM3zUuplvQKRIhYRUDeHvYAr9p4ozGX/HHslPk0RLbbb1U=
X-Google-Smtp-Source: AGHT+IEl8b0mhum+JV+b5DTSd1d3OjZ5PkTdYwtDqzJoyrI4CLabnHCiu4RAY/rQcDa9u2oMv/FfGA==
X-Received: by 2002:a17:903:234c:b0:1e8:682b:7f67 with SMTP id d9443c01a7336-1ef432a0c85mr53371555ad.29.1715377647449;
        Fri, 10 May 2024 14:47:27 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:629e:3f2:f321:6c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c038ce5sm36930875ad.195.2024.05.10.14.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 14:47:27 -0700 (PDT)
Date: Fri, 10 May 2024 14:47:24 -0700
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
Subject: Re: [PATCH v6 06/17] riscv: Add vendor extensions to /proc/cpuinfo
Message-ID: <Zj6V7N96odmFk4ni@ghost>
References: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
 <20240503-dev-charlie-support_thead_vector_6_9-v6-6-cb7624e65d82@rivosinc.com>
 <20240507-divisive-swoop-c2737a2d9a9f@spud>
 <20240510-childcare-outlook-d18e3cc5ccb3@spud>
 <Zj6QxisrBZSWq7ax@ghost>
 <20240510-unexposed-desecrate-e30674d4530b@spud>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510-unexposed-desecrate-e30674d4530b@spud>

On Fri, May 10, 2024 at 10:32:19PM +0100, Conor Dooley wrote:
> On Fri, May 10, 2024 at 02:25:26PM -0700, Charlie Jenkins wrote:
> > On Fri, May 10, 2024 at 09:50:32PM +0100, Conor Dooley wrote:
> > > On Tue, May 07, 2024 at 06:03:19PM +0100, Conor Dooley wrote:
> > > > On Fri, May 03, 2024 at 11:18:21AM -0700, Charlie Jenkins wrote:
> > > > > All of the supported vendor extensions that have been listed in
> > > > > riscv_isa_vendor_ext_list can be exported through /proc/cpuinfo.
> > > > > 
> > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > 
> > > > This seems fine, thanks for updating this interface :)
> > > > 
> > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > 
> > > Hmm, actually the automation on patchwork is complaining a bunch about
> > > the series, but I think that's mostly false positives except for this
> > > patch. The nommu defconfigs are prob the easiest way to reproduce this:
> > >   /build/tmp.QPMRM3oUNu/arch/riscv/kernel/vendor_extensions.c:41:55: error: 'struct riscv_isa_vendor_ext_data_list' has no member named 'vendor_bitmap'
> > >   /build/tmp.QPMRM3oUNu/arch/riscv/kernel/vendor_extensions.c:42:60: error: 'struct riscv_isa_vendor_ext_data_list' has no member named 'per_hart_vendor_bitmap'; did you mean 'per_hart_isa_bitmap'?
> > >   /build/tmp.QPMRM3oUNu/arch/riscv/kernel/vendor_extensions.c:43:60: error: 'struct riscv_isa_vendor_ext_data_list' has no member named 'bitmap_size'
> > > 
> > > Cheers,
> > > Conor.
> > 
> > The false negatives always throw me off.
> 
> Aye, it's pretty frustrating for me trying to report anything. Any time
> a bunch of headers change produces a bunch of file rebuilds and
> therefore warnings. That should in theory be caught by the fact that we
> apply the patch & build, jump back to HEAD~1, build that & grab the
> "before" warning state and then jump forward, rebuild the patch and
> gather the "after" state. The idea is that that is an apples:apples
> comparison as the same files will need to be rebuilt for both but it is
> falling over somewhere. Maybe I'll have time to look into that soonTM.
> 
> > The errors are also offset by
> > one patch.
> 
> Ye, that's my bad I think. In a rush off to another patch before the
> thought I had on it left my brain and just pressed reply on the wrong
> email. Sorry bout that :)
> 

The error message in full is:

Patch 7/17: Test 2/12: .github/scripts/patches/tests/build_rv64_clang_allmodconfig.sh
  Redirect to /build/tmp.OCcmyhkGEw and /build/tmp.TsjyVLqMfy
  Tree base:
  fefb1e9ecc34 ("riscv: Add vendor extensions to /proc/cpuinfo")
  Building the whole tree with the patch
  ../arch/riscv/kernel/vendor_extensions.c:41:42: error: no member named 'vendor_bitmap' in 'struct riscv_isa_vendor_ext_data_list'
  ../arch/riscv/kernel/vendor_extensions.c:42:46: error: no member named 'per_hart_vendor_bitmap' in 'struct riscv_isa_vendor_ext_data_list'; did you mean 'per_hart_isa_bitmap'?
  ../arch/riscv/kernel/vendor_extensions.c:43:47: error: no member named 'bitmap_size' in 'struct riscv_isa_vendor_ext_data_list'


It knows it's on patch 7 but then it prints the title of patch 6.

- Charlie

> > This was actually introduced in the following patch "riscv:
> > Introduce vendor variants of extension helpers" because I accidentally
> > fixed this issue in the patch "riscv: cpufeature: Extract common
> > elements from extension checking" instead of the one it was introduced
> > in.
> 



