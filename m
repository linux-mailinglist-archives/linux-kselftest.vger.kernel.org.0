Return-Path: <linux-kselftest+bounces-16666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AEC963EAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 10:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2052865B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 08:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801DD18FC74;
	Thu, 29 Aug 2024 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DmObrtII"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A1C18F2F7
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 08:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920262; cv=none; b=Rv51nSsrgd7uTBQPTBiCivh8tfZNNCp7ljei4FVyHHt0LfGXMp5+JN3Yi+wjOne7+W5S0JHSNwFH9wG0jp4BVCVPiubO9ypWdE2aHDu8c3gdW8pEWm+IxKioAAhsP/UHHmblvP50G3KuJChGuAQwluA7pV3HatIuJ/bUwqs87QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920262; c=relaxed/simple;
	bh=Ga5XTB33oVuVAsb+XJ/AOaHLIiGbefqAQCifoS2rQFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpcsutcOsll25kgtzRX2+cx5CVHk5b4juWKhY5L1K1UAroJJWu4EL7je8jKEx+DWT2T07kfni6QHFqzwkNBkl6EgaSsfwS8PhiQYhPrRMr8G4V2QRKNzziatRQlZita3G+1FVXeE8beRB2QLC6AZzMkMqJ7cFSTMInIH1oRHKy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DmObrtII; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-371a6fcd863so262158f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 01:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724920258; x=1725525058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mhnlNgvuSYKooCUA3K3P7Rvv1F/ipLIuFC4LArX03WU=;
        b=DmObrtIIa+JA+/TmFBGnFhEdaNkDj2b6d9lVqBEEOv4eMqze6ZtF+YQFfsakr9Q0K5
         rJWh0MWisLShoQOWAtSxLS9q9fgmFgi3mR/KsmvVd2mPYHasZFyP1TR6dA2PPN2lfz1y
         xPOwC4RRgsd47YG4AylP7Dgdyuk/0XN4UdDOl39sK9N11mBacTkyk9aeQeuLmkPhxBtp
         dyZCok1u9sWSLMmz6jEKLDhyLjSEYkjGUy4FOpRco1wbADk4evSJ3md9AHnVdcDVwRn4
         o240asg9iMAitTeFEcWcm9AhT3hDMVcVXMJfLuDKmyF2nLgoKm0GJyWkYE9OKY94atG/
         4UxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724920258; x=1725525058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhnlNgvuSYKooCUA3K3P7Rvv1F/ipLIuFC4LArX03WU=;
        b=Ob7hnlpOlIjOyf0Kg8O+KiTfMXUYzSmT/+pF3yfnGha0aS5On7NAKuo/HVz2yLBeCM
         y4DHGBdsaPxWlBgmb2RUrefbZXigZ8gy09/1/SssclU9ifcvTU3z62iVL6lhkp2APmoc
         DT/N8cqbWpBMzSrCATP4x4lOGvFNg4HYk8C6Z/fQ+89kUI9jRQs6ZIC6x9dhd3SpuWsu
         vM0PAHAqVGYqJMBgJ+6baMc8W6k5Y8h3lKrlg5GPlTWVUU+OxwojkPwY9KCuU01SVMeW
         qog4zdSVWXQEJ2nmYogXaF8HPrlZsgOWXiX6JJW/u+ZUfbeZukN+XsqhbBF6gjLonE1W
         Bxwg==
X-Forwarded-Encrypted: i=1; AJvYcCVOw+0U6ia2xG57spMkQheh7Lw2kAz9m4pl4XOKzrRWAp6o58wx/B4AYc44AubBDZX661+ckEA3DjOHvklZsTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxIr0J+y8qwNHGBuBBPivIZ/WD2zEA27r10fulFo1c8PqRSKyy
	ai7wlZmtYovLHJSzmaktOC9GVKlk7IsjJmPA0hXd1jOqalN4PGfiHECsGX98q/0=
X-Google-Smtp-Source: AGHT+IH7DF9ylXdsuqLih7sACGDNUKmPe9OYfvQtJgi5uGMLK6sqxI9YIz1ijmJ7+1Xtw2Y0sxRMNg==
X-Received: by 2002:adf:ecd0:0:b0:371:8a49:f206 with SMTP id ffacd0b85a97d-3749b54ece3mr1331552f8f.30.1724920258302;
        Thu, 29 Aug 2024 01:30:58 -0700 (PDT)
Received: from localhost (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749eeabbc1sm802650f8f.63.2024.08.29.01.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:30:57 -0700 (PDT)
Date: Thu, 29 Aug 2024 10:30:56 +0200
From: Michal Hocko <mhocko@suse.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shuah Khan <shuah@kernel.org>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 0/4] mm: Introduce MAP_BELOW_HINT
Message-ID: <ZtAxwJFH_hAh1BPG@tiehlicka>
References: <20240829-patches-below_hint_mmap-v2-0-638a28d9eae0@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-patches-below_hint_mmap-v2-0-638a28d9eae0@rivosinc.com>

On Thu 29-08-24 00:15:57, Charlie Jenkins wrote:
> Some applications rely on placing data in free bits addresses allocated
> by mmap. Various architectures (eg. x86, arm64, powerpc) restrict the
> address returned by mmap to be less than the 48-bit address space,
> unless the hint address uses more than 47 bits (the 48th bit is reserved
> for the kernel address space).
> 
> The riscv architecture needs a way to similarly restrict the virtual
> address space. On the riscv port of OpenJDK an error is thrown if
> attempted to run on the 57-bit address space, called sv57 [1].  golang
> has a comment that sv57 support is not complete, but there are some
> workarounds to get it to mostly work [2].
> 
> These applications work on x86 because x86 does an implicit 47-bit
> restriction of mmap() address that contain a hint address that is less
> than 48 bits.
> 
> Instead of implicitly restricting the address space on riscv (or any
> current/future architecture), a flag would allow users to opt-in to this
> behavior rather than opt-out as is done on other architectures. This is
> desirable because it is a small class of applications that do pointer
> masking.

IIRC this has been discussed at length when 5-level page tables support
has been proposed for x86. Sorry I do not have a link handy but lore
should help you. Linus was not really convinced and in the end vetoed it
and prefer that those few applications that benefit from greater address
space would do that explicitly than other way around.

-- 
Michal Hocko
SUSE Labs

