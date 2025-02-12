Return-Path: <linux-kselftest+bounces-26461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B08A3256E
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 12:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58703A6DB3
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 11:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D42720B1FD;
	Wed, 12 Feb 2025 11:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtScDzWX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7711320AF94
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Feb 2025 11:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739361217; cv=none; b=XbQGV0+kl7RZbpPYKAwv7ZaYZz1fGvrTnGx0VIu8ndFVhlstN9XJOPFV/6C6ZuR7G0DTkX4hCyD+yjMVt/jGWgpe71IJUjaqOaBw/x6tYnzNw29KvfXcw9PvuiIQ7NUmkj7AxcJwbDZkzpFMlJAHJNXMMIl3UVKd2lfgnoH1Dcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739361217; c=relaxed/simple;
	bh=F/Y6oZFsQtTxUrr9YYdhPnGY9CZOnlMoNkfED6ENZxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GSlOtTasiGVBayPJXdtB12TXx1L3xLisIwkUp6RRJGPFL1q2RpQVsk5rDZu1jIinO8cwemvhK1fP9U38mzVQrWrbOSnntkUWLc2Y0lbafW/aG2j+X62nDVq/yYvli1TTXuP6KElfGwsslJm10DKaTN722gGcgojoaXHmvw11s1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gtScDzWX; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5de6e26db8eso7054729a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Feb 2025 03:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739361214; x=1739966014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ve4GUfiMGd+JubWtGmw2gMxfkFox9RovPabXzAhTLMg=;
        b=gtScDzWXT/xz8AMgZ2gUYup6p92FeeSmLTsHJswlGBRhztU1xS35hr2ggHNgDH60If
         fCmSyoOqxnkh2GY9sqNK8IjUXtHK+pYHBxSY84v+nETr19VqB9Yc8cRrxrxQzyIysOSE
         4Ivd60YwHsrcOxI+nGVfcXE1wJULUUInyQreL1diuAeAnHRlGQo2/OMlAIAt4VbONzay
         FWpU/RMZId67TC8U/B8wNAUfNIHu55C7nOqsyzytkx77Sr1g1A6QLbPq+J+4ikUkMxwh
         4bZNas/SuqBJn6Lju/0CDsIdRw2oK6saP55NYDMSKzX5FwkM1Gra9BC7e0C7ixVv+c2S
         C3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739361214; x=1739966014;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ve4GUfiMGd+JubWtGmw2gMxfkFox9RovPabXzAhTLMg=;
        b=ZsdGxoKfGIi/NjM9Rttr7O+vNsOvyXPVMAg0dlo6V2P4LNbT8FyUo8xwClEXbBp1P3
         IjrfOTFOZZjJIbS4UQlVhAPY+CqIb91vz3q+0l9niXSP/nUQVOvMmzU9gXT6iMX7ZKCt
         HuNz4rFJng7A1xtncdeS8u/rlI5AxCsadpuk/Rm0aHiVLCiFueaYHJwlMDs7vDFD/F5S
         Usm8OY/Q/gBy7HZWXCmXfZ8Z1Pc6vQHlbFrCUDwWl1EgSjOUfRklb1k980+mHpkw5Zin
         EeHmA5ccMlkB7TD7/Q+GyWFaHbJfM5JM00tsYmd3yubi+s2AqQabk7dbt6gR+Qa/xU44
         bYQA==
X-Forwarded-Encrypted: i=1; AJvYcCU2VsWHGAv5DucIi/qfXJfm6A13G0yoq3KpyBYJva8bh4SLxUlIMJpPVjQVLovdXIlob+7jZZUbkQ0dRZgl8sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX26fs6oC8hE54PEYH21eCFibcdx28u73AkgP8HgUbJcdrRpqk
	LOEnrDRllVIX7/bqGSIkb+MuN/up+Be299OAOJmu7YwYqUJQ3b4w/BEH/fxMXYU=
X-Gm-Gg: ASbGncsmMOKzAy1U8H2j5odYZYO7A/NjjPeaKrW/ZIVx8+dVojkx3ALhkxXZfLI8d5e
	ksjV4t0z6sZ60lBo11T6DYuUtEuCyiZP4kzFevVrO7MoE47wVH3P18u2p40/9XcW3R4JYKpO89k
	JBQcPsH/HD4mE3BbU2I48aWKCE3zSvLZ1fjndW68I7VBIjxjs2xwwTx697+AEEQB+uRmMsQmf4F
	e+Ri7Tb8aaRa1NCF2eACeCkIJkvfnWTZkEQOySTMN/8cQOpJmUtxh7vzH2WolZhfNuLG6y8AvHy
	Ix7Cu/gXYY9kjRLti3b3
X-Google-Smtp-Source: AGHT+IEW37Ln8Rw9wZCx5hEW7SwbEBmh4Q/tDMUHGy/4+ny+FLprR4PjEwKabrQy3taBn4EwI9h/ug==
X-Received: by 2002:a05:6402:4605:b0:5dc:8f03:bb5c with SMTP id 4fb4d7f45d1cf-5deadd9217bmr2454917a12.11.1739361213657;
        Wed, 12 Feb 2025 03:53:33 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5de46b7b480sm10008537a12.36.2025.02.12.03.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:53:33 -0800 (PST)
Date: Wed, 12 Feb 2025 14:53:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Tamir Duberstein <tamird@gmail.com>,
	David Gow <davidgow@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev, Tamir Duberstein <tamird@gmail.com>
Subject: Re: [PATCH] ww_mutex: convert self-test to KUnit
Message-ID: <3dabe058-2308-4990-8e5d-0af1efd27431@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210-ww_mutex-kunit-convert-v1-1-972f0201f71e@gmail.com>

Hi Tamir,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Tamir-Duberstein/ww_mutex-convert-self-test-to-KUnit/20250211-000245
base:   a64dcfb451e254085a7daee5fe51bf22959d52d3
patch link:    https://lore.kernel.org/r/20250210-ww_mutex-kunit-convert-v1-1-972f0201f71e%40gmail.com
patch subject: [PATCH] ww_mutex: convert self-test to KUnit
config: i386-randconfig-141-20250212 (https://download.01.org/0day-ci/archive/20250212/202502121806.CS6r741y-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202502121806.CS6r741y-lkp@intel.com/

smatch warnings:
kernel/locking/ww_mutex_kunit.c:238 test_abba_gen_params() warn: shift has higher precedence than mask
kernel/locking/ww_mutex_kunit.c:249 test_abba() warn: shift has higher precedence than mask

vim +238 kernel/locking/ww_mutex_kunit.c

70207686e492fb kernel/locking/test-ww_mutex.c  Chris Wilson      2016-12-01  231  
daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-10  232  static const void *test_abba_gen_params(const void *prev, char *desc)
daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-10  233  {
daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-10  234  	static unsigned int storage;
daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-10  235  	const unsigned int *next = gen_range(&storage, 0b00, 0b11, prev);
daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-10  236  
daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-10  237  	if (next != NULL) {
daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-10 @238  		const bool trylock = *next & 0b01 >> 0;
daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-10  239  		const bool resolve = *next & 0b10 >> 1;

The shifts here are weird...  A zero shift is strange but even the 1 shift
is odd.  The current code is equivalent to:

	const bool resolve = *next & (0b10 >> 1);

But changing it to:

	const bool resolve = (*next & 0b10) >> 1;

Doesn't make sense either...  Probably that makes less sense actually.
What are you trying to communicate with this code?

daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-10  240  
daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-10  241  		snprintf(desc, KUNIT_PARAM_DESC_SIZE, "trylock=%d,resolve=%d", trylock, resolve);
daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-10  242  	}
daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-10  243  	return next;
daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-10  244  }
daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-10  245  
daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-10  246  static void test_abba(struct kunit *test)
70207686e492fb kernel/locking/test-ww_mutex.c  Chris Wilson      2016-12-01  247  {
daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-10  248  	const unsigned int *param = test->param_value;
daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-10 @249  	const bool trylock = *param & 0b01 >> 0;
daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-10  250  	const bool resolve = *param & 0b10 >> 1;

Same.

70207686e492fb kernel/locking/test-ww_mutex.c  Chris Wilson      2016-12-01  251  	struct test_abba abba;
70207686e492fb kernel/locking/test-ww_mutex.c  Chris Wilson      2016-12-01  252  	struct ww_acquire_ctx ctx;
daf92a37bd1117 kernel/locking/ww_mutex_kunit.c Tamir Duberstein  2025-02-10  253  	int err;
70207686e492fb kernel/locking/test-ww_mutex.c  Chris Wilson      2016-12-01  254  
70207686e492fb kernel/locking/test-ww_mutex.c  Chris Wilson      2016-12-01  255  	ww_mutex_init(&abba.a_mutex, &ww_class);
70207686e492fb kernel/locking/test-ww_mutex.c  Chris Wilson      2016-12-01  256  	ww_mutex_init(&abba.b_mutex, &ww_class);
70207686e492fb kernel/locking/test-ww_mutex.c  Chris Wilson      2016-12-01  257  	INIT_WORK_ONSTACK(&abba.work, test_abba_work);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


