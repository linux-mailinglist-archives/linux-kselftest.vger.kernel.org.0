Return-Path: <linux-kselftest+bounces-8260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B2E8A8864
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 18:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DEE3B221A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 16:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3251487E4;
	Wed, 17 Apr 2024 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fgH0htXd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA42148301
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Apr 2024 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369765; cv=none; b=TTAu5Yv4Hbf1XJI2JCeFW4qh7xvXpfjXiUxx+9t41+6dXbscllGjmT3zdcBAcSD1db3E7neK99feKzPCOlWIwskjXanB2DF+pGTBkB5fJItWSOeJgAo73WQlmqcVIMfoSyCuZSWiU0/29DHzAAfVHoUM8frVPRgLtVImdfYJdlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369765; c=relaxed/simple;
	bh=9i5GLFu0+txx2oabKEnFrp3VW7oPnVCY8MLnNIpHG6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DIBgaj9wpx1E0Pku+jeOtuhyAHWF8u0rUXVV8v5atlOcQB1ZNY6pSX+A16ysaN0Ff6TNv6pzdWHABZ1fkx1ibaiMyeiOOQj2Av9IOA+ZO30H2Lkibs54MNFbyFit+tCsXo665xHoN7lCrqKKZ8/P6jRqGg1gZVXuxFUuaYxmclQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fgH0htXd; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-518a3e0d2ecso7616953e87.3
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Apr 2024 09:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713369762; x=1713974562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nq5XbwnS+WFQsMRXNS2/WLzQBLtULwJiFEsG0xNKfbk=;
        b=fgH0htXdSSmMkNY4k7dHlDgp2o3+1XlO+F9VYbFNb/a8jtysrIUYzJmEWrrFSZeUb/
         9T3ydVYP2tCiJECXf4t0k84xgJBUJD7Ymx5CPJA3Y6KLsPd2HUxl8KWtm2D4XkxFu7ca
         AvwMY8KRFCHPkkqT8+CcRjWm0sQAkdJfcmKRwABZhRzmHHK640gDwkdnebz5j6Wxv+9b
         RcnpoirM+nGWuYhkJw/QlA3yNPWavPwNNBjuYKi2C1ATmLLdAcGUsjtb3ptoxAMrxbg2
         /ZJYqxVg263o/zfrUofXA5crcV34dXne4hWqwYf6tbaY7UiI1wSU4fUBAl/c4QRs3vnw
         lvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713369762; x=1713974562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nq5XbwnS+WFQsMRXNS2/WLzQBLtULwJiFEsG0xNKfbk=;
        b=OrJ96EljnX7GU2vbFxOt8oc3U/OgUMEjqja75w6u7cwvnFPMPlUM/G4W7elPywh+hf
         CNkvaQWgVyYVLQsVrt4KZarJ8aHd5op6yAWZqpLPnaJ5Utd/sDEdEjM+E9wbIv7GomJn
         /p14I1XT/AG/ygR/VYPbbaZORlCJQhCb3f7mggHAC/WFF1fcOFJUG1l5Q6qqGAZ3P7Vw
         J//gxOd1GvvX1ZRqlVnhlIpEeQDm+SzBdbKniJtjKG92QacU+OHYIIVMrkbYcyF2R8ug
         YGVwQRvmdaOKK/s0owFrKvU/tpM08uiZm7BFlOmw+XsP8OTory0xVutrQ2oJFbMLDmub
         8+zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkj8CjjOyQ+99WUwL+ebkoYl9iXCGlN8E64RA9bE6MJhzspT3UG3zP3MDPg4IqHzKCxBfEis3b9hISAozRiPBtPi6RicUTSgxYuewIElAB
X-Gm-Message-State: AOJu0YzSBcezxpCgutc7xbfVv5Q/Z3r+lDTjNv483XYN6jnxKHzSBlLD
	W8/iFbZpuqRCsHN4GEpr/CAOcG3P0DVWsMQpB2QnIruR8mxT3rYAFnKMuBG4b2/vPFYE3u7A1PZ
	2C54YERILiA7GUPc6QRq90Br7xkd6pz6vZbN0ZA==
X-Google-Smtp-Source: AGHT+IF8BRyARCNzXyuNmvDkP/q1Tseio1Ma+qwRSuwJ80RZCervHmYYgcn37QyLe3LgnNKBKhZMr/6HOn2onwEGNlw=
X-Received: by 2002:ac2:538c:0:b0:515:9c73:e29a with SMTP id
 g12-20020ac2538c000000b005159c73e29amr12657720lfh.66.1713369761613; Wed, 17
 Apr 2024 09:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-2-4af9815ec746@rivosinc.com>
 <20240412-tuesday-resident-d9d07e75463c@wendy> <ZhlrdGXfSushUNTp@ghost>
 <20240412-eastcoast-disparity-9c9e7d178df5@spud> <ZhmeLoPS+tsfqv1T@ghost>
 <20240412-chemist-haunt-0a30a8f280ca@spud> <ZhmoPuoR00aS6qZp@ghost>
 <20240413-sharper-unlivable-5a65660b19e2@spud> <Zh3xrTfjjk3b4GHb@ghost>
 <20240416-husband-flavored-96c1dad58b6e@wendy> <Zh9PLhUZmCF5mLXc@ghost>
In-Reply-To: <Zh9PLhUZmCF5mLXc@ghost>
From: Evan Green <evan@rivosinc.com>
Date: Wed, 17 Apr 2024 09:02:05 -0700
Message-ID: <CALs-HssYAHrBy-uYKNT_zS02F_65qJZh80OD-W1RrmmYosFU=Q@mail.gmail.com>
Subject: Re: [PATCH 02/19] riscv: cpufeature: Fix thead vector hwcap removal
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Conor Dooley <conor@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 9:25=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> On Tue, Apr 16, 2024 at 08:36:33AM +0100, Conor Dooley wrote:
> > On Mon, Apr 15, 2024 at 08:34:05PM -0700, Charlie Jenkins wrote:
> > > On Sat, Apr 13, 2024 at 12:40:26AM +0100, Conor Dooley wrote:
> > > > On Fri, Apr 12, 2024 at 02:31:42PM -0700, Charlie Jenkins wrote:
> > > > > On Fri, Apr 12, 2024 at 10:27:47PM +0100, Conor Dooley wrote:
> > > > > > On Fri, Apr 12, 2024 at 01:48:46PM -0700, Charlie Jenkins wrote=
:
> > > > > > > On Fri, Apr 12, 2024 at 07:47:48PM +0100, Conor Dooley wrote:
> > > > > > > > On Fri, Apr 12, 2024 at 10:12:20AM -0700, Charlie Jenkins w=
rote:
> > > >
> > > > > > > > > This is already falling back on the boot CPU, but that is=
 not a solution
> > > > > > > > > that scales. Even though all systems currently have homog=
enous
> > > > > > > > > marchid/mvendorid I am hesitant to assert that all system=
s are
> > > > > > > > > homogenous without providing an option to override this.
> > > > > > > >
> > > > > > > > There are already is an option. Use the non-deprecated prop=
erty in your
> > > > > > > > new system for describing what extesions you support. We do=
n't need to
> > > > > > > > add any more properties (for now at least).
> > > > > > >
> > > > > > > The issue is that it is not possible to know which vendor ext=
ensions are
> > > > > > > associated with a vendor. That requires a global namespace wh=
ere each
> > > > > > > extension can be looked up in a table. I have opted to have a
> > > > > > > vendor-specific namespace so that vendors don't have to worry=
 about
> > > > > > > stepping on other vendor's toes (or the other way around). In=
 order to
> > > > > > > support that, the vendorid of the hart needs to be known prio=
r.
> > > > > >
> > > > > > Nah, I think you're mixing up something like hwprobe and having
> > > > > > namespaces there with needing namespacing on the devicetree pro=
bing side
> > > > > > too. You don't need any vendor namespacing, it's perfectly fine=
 (IMO)
> > > > > > for a vendor to implement someone else's extension and I think =
we should
> > > > > > allow probing any vendors extension on any CPU.
> > > > >
> > > > > I am not mixing it up. Sure a vendor can implement somebody else'=
s
> > > > > extension, they just need to add it to their namespace too.
> > > >
> > > > I didn't mean that you were mixing up how your implementation worke=
d, my
> > > > point was that you're mixing up the hwprobe stuff which may need
> > > > namespacing for $a{b,p}i_reason and probing from DT which does not.
> > > > I don't think that the kernel should need to be changed at all if
> > > > someone shows up and implements another vendor's extension - we alr=
eady
> > > > have far too many kernel changes required to display support for
> > > > extensions and I don't welcome potential for more.
> > >
> > > Yes I understand where you are coming from. We do not want it to requ=
ire
> > > very many changes to add an extension. With this framework, there are
> > > the same number of changes to add a vendor extension as there is to a=
dd
> > > a standard extension.
> >
> > No, it is actually subtly different. Even if the kernel already support=
s
> > the extension, it needs to be patched for each vendor
> >
> > > There is the upfront cost of creating the struct
> > > for the first vendor extension from a vendor, but after that the
> > > extension only needs to be added to the associated vendor's file (I a=
m
> > > extracting this out to a vendor file in the next version). This is al=
so
> > > a very easy task since the fields from a different vendor can be copi=
ed
> > > and adapted.
> > >
> > > > Another thing I just thought of was systems where the SoC vendor
> > > > implements some extension that gets communicated in the ISA string =
but
> > > > is not the vendor in mvendorid in their various CPUs. I wouldn't wa=
nt to
> > > > see several different entries in structs (or several different hwpr=
obe
> > > > keys, but that's another story) for this situation because you're o=
nly
> > > > allowing probing what's in the struct matching the vendorid.
> > >
> > > Since the isa string is a per-hart field, the vendor associated with =
the
> > > hart will be used.
> >
> > I don't know if you just didn't really read what I said or didn't
> > understand it, but this response doesn't address my comment.
>
> I read what you said! This question seemed to me as another variant of
> "what happens when one vendor implements an extension from a different
> vendor", and since we already discussed that I was trying to figure out
> what you were actually asking.
>
> > Consider SoC vendor S buys CPUs from vendors A & B and asks both of the=
m
> > to implement Xsjam. The CPUs are have the vendorid of either A or B,
> > depending on who made it. This scenario should not result in two
> > different hwprobe keys nor two different in-kernel riscv_has_vendor_ext=
()
> > checks to see if the extension is supported. *If* the extension is vend=
or
> > namespaced, it should be to the SoC vendor whose extension it is, not
> > the individual CPU vendors that implemented it.
> >
> > Additionally, consider that CPUs from both vendors are in the same SoC
> > and all CPUs support Xsjam. Linux only supports homogeneous extensions
> > so we should be able to detect that all CPUs support the extension and
> > use it in a driver etc, but that's either not going to work (or be
> > difficult to orchestrate) with different mappings per CPU vendor. I saw
> > your v2 cover letter, in which you said:
> >   Only patch vendor extension if all harts are associated with the same
> >   vendor. This is the best chance the kernel has for working properly i=
f
> >   there are multiple vendors.
> > I don't think that level of paranoia is required: if firmware tells us
> > that an extension is supported, then we can trust that those extensions
> > have been implemented correctly. If the fear of implementation bugs is
> > what is driving the namespacing that you've gone for, I don't think tha=
t
> > it is required and we can simplify things, with the per-vendor structs
> > being the vendor of the extension (so SoC vendor S in my example), not
> > A and B who are the vendors of the CPU IP.
> >
> > Thanks,
> > Conor.
> >
>
> Thank you for expanding upon this idea further. This solution of
> indexing the extensions based on the vendor who proposed them does make
> a lot of sense. There are some key differences here of note. When
> vendors are able to mix vendor extensions, defining a bitmask that
> contains all of the vendor extensions gets a bit messier. I see two
> possible solutions.
>
> 1. Vendor keys cannot overlap between vendors. A set bit in the bitmask
> is associated with exactly one extension.
>
> 2. Vendor keys can overlap between vendors. There is a vendor bitmask
> per vendor. When setting/checking a vendor extension, first index into
> the vendor extension bitmask with the vendor associated with the
> extension and then with the key of the vendor extension.
>
> A third option would be to use the standard extension framework. This
> causes the standard extension list to become populated with extensions
> that most harts will never implement so I am opposed to that.
>
> This problem carries over into hwprobe since the schemes proposed by
> Evan and I both rely on the mvendorid of harts associated with the
> cpumask. To have this level of support in hwprobe for SoCs with a mix of
> vendors but the same extensions I again see two options:
>
> 1. Vendor keys cannot overlap between vendors. A set bit in the bitmask
> is associated with exactly one extension. This bitmask would be returned
> by the vendor extension hwprobe key.
>
> 2. Vendor keys can overlap between vendors. There is an hwprobe key per
> vendor. Automatic resolution of the vendor doesn't work because the
> vendor-specific feature being requested (extensions in the case) may be
> of a vendor that is different than the hart's vendor, in otherwords
> there are two variables necessary: the vendor and a way to ask hwprobe
> for a list of the vendor extensions. With hwprobe there is only the
> "key" that can be used to encode these variables simultaneously. We
> could have something like a HWPROBE_THEAD_EXT_0 key that would return
> all thead vendor extensions supported by the harts corresponding to the
> cpumask.

I was a big proponent of the vendor namespacing in hwprobe, as I liked
the tidiness of it, and felt it could handle most cases (including
mix-n-matching multiple mvendorids in a single SoC). However my
balloon lost its air after chatting with Palmer, as there's one case
it really can't handle: white labeling. This is where I buy a THead
(for instance) CPU for my SoC, including all its vendor extensions,
and do nothing but change the mvendorid to my own. If this is a thing,
then the vendor extensions basically have to be a single global
namespace in hwprobe (sigh).

I do like Charlie's idea of at least letting vendors allocate a key at
a time, eg HWPROBE_THEAD_EXT_0, rather than racing to allocate a bit
at a time in a key like HWPROBE_VENDOR_EXT_0. That gives it some
semblance of organization, and still gives us a chance of a
cleanup/deprecation path for vendors that stop producing chips.
-Evan

