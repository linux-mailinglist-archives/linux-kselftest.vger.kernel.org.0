Return-Path: <linux-kselftest+bounces-28298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F89A4FA93
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 10:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507221892B06
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 09:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC162054E3;
	Wed,  5 Mar 2025 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="epMLIdSe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECE320370C
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168044; cv=none; b=Q7MT000CbRGJiMNPCSGLTYXpJf2bcV2ak41e/tpvXgBo5VQ/eZSB3PVnjxLpPGCAq2bjexU/nhdXxCIHUqWaWWqPYK3+ErPIb2b+NtbVLW7rNdNhaXnuMl1sml+LzWDxJzcjfKQLtCHgedB9KG2q8A1tVo1wwQT7DHWtJ6tl2ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168044; c=relaxed/simple;
	bh=Z+VMDSOKrwtG6lviKJiCsWBEfYDhlcUqD9qS1eoXGw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLq42SvtFMOYAaK49C1TyMWfXUhFoFJwrDZnlsjdcDRL/+neK6R1hZUaIn4ClcegOqtF+E8YIXnXyrXWG/A5lBjbl2zKrWr4N+0GMekGbH9g9mfP6jePzIMSudXmJxt4AaTSpTpXrNJ+BkNArs7HwEdJsWlaYg3Tb0wrlWX3YbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=epMLIdSe; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3910e101d0fso2047944f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Mar 2025 01:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741168040; x=1741772840; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EMPfkT27lV8Ojg2DFZYdlrmMaeah6M4ccrm/4GlS09M=;
        b=epMLIdSeTSMn7obw5QuRDczC5fsK7bKRQQLbYNU+9nGOtoIo0ZRyhK/uk4T7A/SltK
         QsdQXKvkQKNZYqR8/cSsKU15Pma014EUYQEeEVe2LQ3V6wIu+2poI90gL+auiSW0fCOt
         Cqx/DJIlPFRUrFhTGMLoNzokeMxnc930S2ykHwMZUFUKEmSXul1tYOGjTeeEmdMWG+1L
         5BDXrKR/dZYc1kCRZBoAVJTEPNclxddEBhnQOu87oNtvdTsIs6QyNborgl/OI3X8lNxY
         u5yLEmTnIsLGmgKOY9lO8N8LpTkq6gqJRSNHUyPNqpjwqV0LD/OM3vSVNPEFGu9j0glH
         4q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741168040; x=1741772840;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMPfkT27lV8Ojg2DFZYdlrmMaeah6M4ccrm/4GlS09M=;
        b=Laz+nu5EnHmPhMY33x6a66Wut7w7zLrorawrD5+3AOb/LTppENdZyKXS+FGMkh9hJL
         Wzz6O9m/HDEjcdCbT/m0J3a02EeXctU5RgHBH39Dw92+pCIO2ITrHOlf/kiIB1baNsvo
         9HgfWrQREuEh3qARjtkQbaodg7wCraM0MjMSKgdQua9nfhZS3OPtmAVJaWRAnefZMX8V
         UavITwU3YYgNz10A9hvetM0kfq3aGzYlEFF7i9qL2hODie15zYtgsSuFPLE3e1oM1QLU
         ucLCD4pAVc0+H/iU5XvLCGQKZhrqNSo7SdpLM0hsFaUA5AEV4JLsdyUSN5aGgBkOgELi
         gqxA==
X-Forwarded-Encrypted: i=1; AJvYcCXsWC//s7zEId2dbS1qfggpT71yQvuD+RNKQ6TlylZiAP53bd2fjTwlNk3a2S5dfCrpV4YUji/K8ng2msVI4pE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVC0G+KMc+A4S4+S3CAB3oT+NxozzIXtnE5bEHA2dnSPRNgoOZ
	xYZkR9SMLA9TWFPKq4IXqOoLoWXYVKyiwEvNCfv76iu7khz8IdGj22MOykoNb/Q=
X-Gm-Gg: ASbGncskyDRrIzy4+p7irAFHqpb2brjiZT7onRMtqtEPNAzMsPA3s+xy1aspDWsiLmc
	RmEVv0ROs3Uw5bD66kjZa/jcs6tPlNbNE2caQAU6TRknLa6HmoW0SNDG8tYrqnokmWZoEHG5u+U
	KW4ZDzlZIo78lLKu4mtBCOTLyjUAhdPrQnVI/B39bL6sPqER1u61Fi2jkKWp+4ri+ZebRjk+yRE
	h6Xu+CA8yJqSKFwAa+2W2iPKvdWA20LIt/YU+q3pV2NybicBP0DbIdHIKbDXj+EgwnthK9geLY6
	h7IEvPOJjRTJv652AhSEyE6JmvBHm8ouulLKbMufmcTllkg=
X-Google-Smtp-Source: AGHT+IFcrWp+Eg2JeW3nr+EIF9j4IDp9lzyAN7AdFjhbyzx7Y+kawoeWfXaT79Mlsm2wvfce/91S1g==
X-Received: by 2002:a5d:6486:0:b0:391:a74:d7dc with SMTP id ffacd0b85a97d-3911f7ce121mr1800951f8f.50.1741168040117;
        Wed, 05 Mar 2025 01:47:20 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd429215asm12099625e9.11.2025.03.05.01.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:47:19 -0800 (PST)
Date: Wed, 5 Mar 2025 10:47:17 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: kernel test robot <lkp@intel.com>, David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 3/4] scanf: convert self-test to KUnit
Message-ID: <Z8gdpSErMCMCZZNP@pathway.suse.cz>
References: <20250214-scanf-kunit-convert-v8-3-5ea50f95f83c@gmail.com>
 <202502160245.KUrryBJR-lkp@intel.com>
 <CAJ-ks9kkigKG=Nf_mZrA5CA=SUV2sSyY51_rLef42T+ZxCmk1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9kkigKG=Nf_mZrA5CA=SUV2sSyY51_rLef42T+ZxCmk1Q@mail.gmail.com>

On Sat 2025-02-15 14:52:22, Tamir Duberstein wrote:
> On Sat, Feb 15, 2025 at 1:51 PM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Tamir,
> >
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on 7b7a883c7f4de1ee5040bd1c32aabaafde54d209]
> >
> > url:
> https://github.com/intel-lab-lkp/linux/commits/Tamir-Duberstein/scanf-implicate-test-line-in-failure-messages/20250215-002302
> > base:   7b7a883c7f4de1ee5040bd1c32aabaafde54d209
> > patch link:
> https://lore.kernel.org/r/20250214-scanf-kunit-convert-v8-3-5ea50f95f83c%40gmail.com
> > patch subject: [PATCH v8 3/4] scanf: convert self-test to KUnit
> > config: sh-randconfig-002-20250216 (
> https://download.01.org/0day-ci/archive/20250216/202502160245.KUrryBJR-lkp@intel.com/config
> )
> > compiler: sh4-linux-gcc (GCC) 14.2.0
> > reproduce (this is a W=1 build): (
> https://download.01.org/0day-ci/archive/20250216/202502160245.KUrryBJR-lkp@intel.com/reproduce
> )
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new
> version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes:
> https://lore.kernel.org/oe-kbuild-all/202502160245.KUrryBJR-lkp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> >    In file included from <command-line>:
> >    lib/tests/scanf_kunit.c: In function 'numbers_list_ll':
> > >> include/linux/compiler.h:197:61: warning: function 'numbers_list_ll'
> might be a candidate for 'gnu_scanf' format attribute
> [-Wsuggest-attribute=format]
> 
> I am not able to reproduce these warnings with clang 19.1.7. They also
> don't obviously make sense to me.

I have reproduced the problem with gcc:

$> gcc --version
gcc (SUSE Linux) 14.2.1 20250220 [revision 9ffecde121af883b60bbe60d00425036bc873048]

$> make W=1 lib/test_scanf.ko
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
  INSTALL libsubcmd_headers
  CC [M]  lib/test_scanf.o
In file included from <command-line>:
lib/test_scanf.c: In function ‘numbers_list_ll’:
./include/linux/compiler.h:197:61: warning: function ‘numbers_list_ll’ might be a candidate for ‘gnu_scanf’ format attribute [-Wsuggest-attribute=format]
  197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
      |                                                             ^
[...]

It seems that it is a regression introduced by the first
patch of this patch set. And the fix is:

diff --git a/lib/test_scanf.c b/lib/test_scanf.c
index d1664e0d0138..e65b10c3dc11 100644
--- a/lib/test_scanf.c
+++ b/lib/test_scanf.c
@@ -27,7 +27,7 @@ static struct rnd_state rnd_state __initdata;
 typedef int (*check_fn)(const char *file, const int line, const void *check_data,
 			const char *string, const char *fmt, int n_args, va_list ap);
 
-static void __scanf(6, 0) __init
+static void __scanf(6, 8) __init
 _test(const char *file, const int line, check_fn fn, const void *check_data, const char *string,
 	const char *fmt, int n_args, ...)
 {

Best Regards,
Petr

