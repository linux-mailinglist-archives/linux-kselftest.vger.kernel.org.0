Return-Path: <linux-kselftest+bounces-8237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23DF8A7B5B
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 06:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93CB428356C
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 04:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93BA43144;
	Wed, 17 Apr 2024 04:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IkgCYkNP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1B041C7C
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Apr 2024 04:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713327925; cv=none; b=Vte5CYsiRI5PxNudeMKtsHykRREx80si+XK0xE4tBW4LTe2zcJWVEWjGMJtw7jlASD4dmGO3z53vSGCrNpwzo7bXrRTNawhJ6RxTJ5HGZ/1ZP0RSMg+eR7w6NJ0QmHAgPg45JchWgH7MNube5vN4JhFh02o8pCHwEKC9GqF4AGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713327925; c=relaxed/simple;
	bh=rFwkC511KvsC0YP2FZrFpvy2jy7jJpi7upeWgfMoueg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXzzHcxTCX3Z5mOvB8wFU/fGK9BuiviIDmlSXlIV+TQvEDyuTVZ2mLXQMKEfeG6ZKct6LZtrK0PzNxxgpcv7BaYpkGmWWHtb0kp1KES+NqXWmbRlxpy647FPdQDhOJ0wf2v2EltNKaqDO6/FjGFHAM8rmjyDVGk0h0G45ymM0ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IkgCYkNP; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c70ef25e19so1542021b6e.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 21:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713327922; x=1713932722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e2tZ+yG9t3/35QrGeru3QI9bqAmKuIVqOJ+PisGAvLA=;
        b=IkgCYkNPxxMVBd4CKylSE3fOvUc5M5HuGcZodYPZBhtTY2Vhih+fJBHSqJEXd9AFoR
         PdxfgKpx8vlQvzhHAeGpYEhyjYPKXjfm9UYFdcCJU1XpIV8oAZN+n2NaURbnmHjcwKwn
         DrFZDi9q7+leX0QWj/RkS6VbJH3ZN0+rTQbQ/vR8roK64NoD0gNVE9oPHhsQszWrIZjc
         Mu6V8xFlo1dZu2TXou71wuL44dXQXQP4ErRrA2vdv3c9pd+VYy0MH20HYzre69Y/5MFA
         pQHucHlvDmUzenjtzYTr01sz49eMrHwj1xt8ES5OVMxX9r2uAh29cq5LV0IvjzG/BsiA
         mFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713327922; x=1713932722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2tZ+yG9t3/35QrGeru3QI9bqAmKuIVqOJ+PisGAvLA=;
        b=C4/F4BuuqOwQbD2MKQLv2YmDc9VOAl6MaFgBQ04PCHjZk/AwxMT9wjjScqRiT8YPLB
         SLDe5X3saqb6+LWAm74NgzBtRKKGcGcfDlMOmqNWe+JjCMdDB5riJ0U8h39nDB1WGKvo
         dsVotH232oMSIfG8WeSNETyn+PHn0ojVt0k4cn1nNACT8GZ/heLt5S8zbSmKkSov58x+
         jGZBLWl7QDyQMlSmsoiXl06KJS6A4DUnz+w/mghnTVZhj9pRgnCOGF4WJttr0mEaPE0g
         g6P6U8OI5ca9HvoBtjlwi6dS+RqG9Ge8JrHdEF1AH5rFneHZLy47bOWa54foJQlVqCM5
         E/8g==
X-Forwarded-Encrypted: i=1; AJvYcCV6TuGaQbhAgozmurzWVLHiwR7hYARHZENu8+anIs2vCRhfHXXx+TgQ471ORr7+iWeqx23sraWciBmvG4bQkO51/aVNAofDRdDs4V7OMu7L
X-Gm-Message-State: AOJu0YxKY7Gm8b1XJbLAUpj30y3oFw746maV37jZB64/4TA08OHgku9F
	LIINhJ6xbbisRuCeiUhiph1pzHgdDkqYua8vQ3j9f1VQzEFmtjHRk+BFp910XZk=
X-Google-Smtp-Source: AGHT+IGWLA0NcQXbZEfFdR3YsDPfVHr118QZ4WjhomG+9rzHNhvOanaWIT94NHLW+jEwwRIrKftHvw==
X-Received: by 2002:a05:6808:298b:b0:3c5:f473:f35e with SMTP id ex11-20020a056808298b00b003c5f473f35emr16376428oib.12.1713327922458;
        Tue, 16 Apr 2024 21:25:22 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:6b78:3121:f067:eafa])
        by smtp.gmail.com with ESMTPSA id v29-20020aa799dd000000b006ea6f189976sm9733237pfi.163.2024.04.16.21.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 21:25:21 -0700 (PDT)
Date: Tue, 16 Apr 2024 21:25:18 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 02/19] riscv: cpufeature: Fix thead vector hwcap removal
Message-ID: <Zh9PLhUZmCF5mLXc@ghost>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-2-4af9815ec746@rivosinc.com>
 <20240412-tuesday-resident-d9d07e75463c@wendy>
 <ZhlrdGXfSushUNTp@ghost>
 <20240412-eastcoast-disparity-9c9e7d178df5@spud>
 <ZhmeLoPS+tsfqv1T@ghost>
 <20240412-chemist-haunt-0a30a8f280ca@spud>
 <ZhmoPuoR00aS6qZp@ghost>
 <20240413-sharper-unlivable-5a65660b19e2@spud>
 <Zh3xrTfjjk3b4GHb@ghost>
 <20240416-husband-flavored-96c1dad58b6e@wendy>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-husband-flavored-96c1dad58b6e@wendy>

On Tue, Apr 16, 2024 at 08:36:33AM +0100, Conor Dooley wrote:
> On Mon, Apr 15, 2024 at 08:34:05PM -0700, Charlie Jenkins wrote:
> > On Sat, Apr 13, 2024 at 12:40:26AM +0100, Conor Dooley wrote:
> > > On Fri, Apr 12, 2024 at 02:31:42PM -0700, Charlie Jenkins wrote:
> > > > On Fri, Apr 12, 2024 at 10:27:47PM +0100, Conor Dooley wrote:
> > > > > On Fri, Apr 12, 2024 at 01:48:46PM -0700, Charlie Jenkins wrote:
> > > > > > On Fri, Apr 12, 2024 at 07:47:48PM +0100, Conor Dooley wrote:
> > > > > > > On Fri, Apr 12, 2024 at 10:12:20AM -0700, Charlie Jenkins wrote:
> > > 
> > > > > > > > This is already falling back on the boot CPU, but that is not a solution
> > > > > > > > that scales. Even though all systems currently have homogenous
> > > > > > > > marchid/mvendorid I am hesitant to assert that all systems are
> > > > > > > > homogenous without providing an option to override this.
> > > > > > > 
> > > > > > > There are already is an option. Use the non-deprecated property in your
> > > > > > > new system for describing what extesions you support. We don't need to
> > > > > > > add any more properties (for now at least).
> > > > > > 
> > > > > > The issue is that it is not possible to know which vendor extensions are
> > > > > > associated with a vendor. That requires a global namespace where each
> > > > > > extension can be looked up in a table. I have opted to have a
> > > > > > vendor-specific namespace so that vendors don't have to worry about
> > > > > > stepping on other vendor's toes (or the other way around). In order to
> > > > > > support that, the vendorid of the hart needs to be known prior.
> > > > > 
> > > > > Nah, I think you're mixing up something like hwprobe and having
> > > > > namespaces there with needing namespacing on the devicetree probing side
> > > > > too. You don't need any vendor namespacing, it's perfectly fine (IMO)
> > > > > for a vendor to implement someone else's extension and I think we should
> > > > > allow probing any vendors extension on any CPU.
> > > > 
> > > > I am not mixing it up. Sure a vendor can implement somebody else's
> > > > extension, they just need to add it to their namespace too.
> > > 
> > > I didn't mean that you were mixing up how your implementation worked, my
> > > point was that you're mixing up the hwprobe stuff which may need
> > > namespacing for $a{b,p}i_reason and probing from DT which does not.
> > > I don't think that the kernel should need to be changed at all if
> > > someone shows up and implements another vendor's extension - we already
> > > have far too many kernel changes required to display support for
> > > extensions and I don't welcome potential for more.
> > 
> > Yes I understand where you are coming from. We do not want it to require
> > very many changes to add an extension. With this framework, there are
> > the same number of changes to add a vendor extension as there is to add
> > a standard extension. 
> 
> No, it is actually subtly different. Even if the kernel already supports
> the extension, it needs to be patched for each vendor
> 
> > There is the upfront cost of creating the struct
> > for the first vendor extension from a vendor, but after that the
> > extension only needs to be added to the associated vendor's file (I am
> > extracting this out to a vendor file in the next version). This is also
> > a very easy task since the fields from a different vendor can be copied
> > and adapted.
> > 
> > > Another thing I just thought of was systems where the SoC vendor
> > > implements some extension that gets communicated in the ISA string but
> > > is not the vendor in mvendorid in their various CPUs. I wouldn't want to
> > > see several different entries in structs (or several different hwprobe
> > > keys, but that's another story) for this situation because you're only
> > > allowing probing what's in the struct matching the vendorid.
> > 
> > Since the isa string is a per-hart field, the vendor associated with the
> > hart will be used.
> 
> I don't know if you just didn't really read what I said or didn't
> understand it, but this response doesn't address my comment.

I read what you said! This question seemed to me as another variant of
"what happens when one vendor implements an extension from a different
vendor", and since we already discussed that I was trying to figure out
what you were actually asking.

> Consider SoC vendor S buys CPUs from vendors A & B and asks both of them
> to implement Xsjam. The CPUs are have the vendorid of either A or B,
> depending on who made it. This scenario should not result in two
> different hwprobe keys nor two different in-kernel riscv_has_vendor_ext()
> checks to see if the extension is supported. *If* the extension is vendor
> namespaced, it should be to the SoC vendor whose extension it is, not
> the individual CPU vendors that implemented it.
> 
> Additionally, consider that CPUs from both vendors are in the same SoC
> and all CPUs support Xsjam. Linux only supports homogeneous extensions
> so we should be able to detect that all CPUs support the extension and
> use it in a driver etc, but that's either not going to work (or be
> difficult to orchestrate) with different mappings per CPU vendor. I saw
> your v2 cover letter, in which you said:
>   Only patch vendor extension if all harts are associated with the same
>   vendor. This is the best chance the kernel has for working properly if
>   there are multiple vendors.
> I don't think that level of paranoia is required: if firmware tells us
> that an extension is supported, then we can trust that those extensions
> have been implemented correctly. If the fear of implementation bugs is
> what is driving the namespacing that you've gone for, I don't think that
> it is required and we can simplify things, with the per-vendor structs
> being the vendor of the extension (so SoC vendor S in my example), not
> A and B who are the vendors of the CPU IP.
> 
> Thanks,
> Conor.
> 

Thank you for expanding upon this idea further. This solution of
indexing the extensions based on the vendor who proposed them does make
a lot of sense. There are some key differences here of note. When
vendors are able to mix vendor extensions, defining a bitmask that
contains all of the vendor extensions gets a bit messier. I see two
possible solutions.

1. Vendor keys cannot overlap between vendors. A set bit in the bitmask
is associated with exactly one extension.

2. Vendor keys can overlap between vendors. There is a vendor bitmask
per vendor. When setting/checking a vendor extension, first index into
the vendor extension bitmask with the vendor associated with the
extension and then with the key of the vendor extension.

A third option would be to use the standard extension framework. This
causes the standard extension list to become populated with extensions
that most harts will never implement so I am opposed to that.

This problem carries over into hwprobe since the schemes proposed by
Evan and I both rely on the mvendorid of harts associated with the
cpumask. To have this level of support in hwprobe for SoCs with a mix of
vendors but the same extensions I again see two options:

1. Vendor keys cannot overlap between vendors. A set bit in the bitmask
is associated with exactly one extension. This bitmask would be returned
by the vendor extension hwprobe key.

2. Vendor keys can overlap between vendors. There is an hwprobe key per
vendor. Automatic resolution of the vendor doesn't work because the
vendor-specific feature being requested (extensions in the case) may be
of a vendor that is different than the hart's vendor, in otherwords
there are two variables necessary: the vendor and a way to ask hwprobe
for a list of the vendor extensions. With hwprobe there is only the
"key" that can be used to encode these variables simultaneously. We
could have something like a HWPROBE_THEAD_EXT_0 key that would return
all thead vendor extensions supported by the harts corresponding to the
cpumask.

I didn't list the option that we shove all of the vendor extensions into
the same fields that are used for standard extensions because that will
fill up the standard extension probing with all of the vendor extensions
that most SoCs will not care about.

The second option for hwprobe is nice because there are "only" 64 values
supported in the returned bitmask so if there ends up being a lot of
vendor extensions that need to be exposed, then we would end up with a
lot of unused bits on most systems.

For the internal kernel structures it matters less (or doesn't matter at
all) since it's not exposed to userspace and it can always change.
Having consistency is nice for developers though so it would be my
preference to have schemes that reflect each other for the in-kernel
structures and hwprobe.

Thank you for working this problem out with me. I know there is a lot of
text I am pushing here, hopefully we can design something that doesn't
need to be re-written in the future.

- Charlie


