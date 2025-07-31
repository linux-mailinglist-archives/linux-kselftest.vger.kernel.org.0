Return-Path: <linux-kselftest+bounces-38101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DDBB1746C
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 17:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC5A188A5DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 15:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DBE221DA8;
	Thu, 31 Jul 2025 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MiZ1DpWc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA5721CFF6
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977515; cv=none; b=SdmOCFOgCsB5uM0rlXhmRkIwzER/Htju5cKqbWve6TYvgB9kOsO4vq+ZZ0KfdouDPEZU0jsdHWN3Wh45dspLmmCjpUPOD0Ixz74aeIwQvO4u2Dwlj8ubRaxfduU3QKVSczy1by9OssuJjQ0LeLhuxuDRceQysrt3QP/5JLzzww0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977515; c=relaxed/simple;
	bh=gmzrttWeWDT3PGDpJ2II7NY3KHDvCISiDvnyW1TVYP8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=K2agpuuG0dL+7m3eddcy5JGa7T1KdQS8As1lxgUOzyS8iXncPH8BlCwczY89BWQg1gnRp6o5lsssL5YEMvQ5pPQKjLFmEvkEqTij091suYLmHIUYT719/dZ09hREjihDj1L96QhwEml2bM2glJ2ItmTu22LncBB3wsT+asehhfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MiZ1DpWc; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4fbf1326dfeso783686137.3
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 08:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753977513; x=1754582313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jKKboCZbQOuMPhW93A7UzwoZX1h4N/abO1uaKk6KKOQ=;
        b=MiZ1DpWcnlQphGiqsN6vVD56SYrHaGYJqvLS5bZ/19Z8pAgVFylNUH5duiEEZf64A+
         GRUcFp0IPzttfViNGNB0Sk8ed12VAOBhR4Ujyyqdfz9TqpGAe8iB52eUzORV6cyNXgZQ
         2Ctju5zMO78qKuzacXrEnpsAhYWZunpBC5WgbKdmSBn93r4Ibqd7PlYQSeIczLLQ0yD8
         Bjm7rkuLEv3T6ebm8nAT4w4oPDfqv6KnYjTj37aLRekmohMctDqb50Wg2tefCkJH3pXI
         YGEvb0xPsjxObCSTKGVcEkqqPGcy4bb/9P24YmkITNSxli5w6OLOgDdM3J+oJP0EnyaC
         JsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753977513; x=1754582313;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jKKboCZbQOuMPhW93A7UzwoZX1h4N/abO1uaKk6KKOQ=;
        b=ZSti6AFyqUM74eTRIqhkt6golVO5cgc0QtxHd2nARkhd4OY1RUxlzwOO5N12kNJsSI
         O6Er5Mu1yKktf89Up/Zd/W/Az8AgF1YaCdyYmIPbQS/E5/mNhNz2isTZUko/KjGFhmA6
         EYOZ3enhw0+TBqnbQs3pU4c56IAYeUVKlYhsm4lVqqQ/2JpxG78eNEtRXKaqxUoq50d2
         T4J/sUKznAr8n2ouCgvZDnDPLj5SF3reCq3ceqv+aXrhFVEcRgY74n6eO1+dqpx8xk1U
         IrOkrygzNjftEBXhOkJ6HFE/HeFjAenni52jKeAYuPjikfWv3HvazACTgtle4fQWJAcm
         F0bA==
X-Forwarded-Encrypted: i=1; AJvYcCVuopUuXP7sBESliGitknxsx0p7wQkFaVD2fidkLTcloffRaxSVgcyHrCdJvCGjUNfYK8v0fD8GHMwq1PkTnVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YziEDQVmms2lTzsY/qEjFF+Ta4lvmcIwCIwKtnE2JAogX9AjEKU
	0G43bhRHHW3bbRCUJuOVLJvjt4hU+vhPC1GoK/hvdAI2MnNMdo2M3k6oeyYmx6UNj3g=
X-Gm-Gg: ASbGnctDQ6RgRBVEGmI7AgyCmENixWPOWkQGcgXjCicSF4h9yrEA39nytDsXRKJZUTZ
	gKGMn4xL7ejfnCFeQaHtzX3czMsl2ev0ix6vAO6mCBkRbVsR+uN9/COdUeymX7JD0v2pNIgv/x/
	VZTRy1ThK+iMyWIZL1D4H8RUQQtJ7yQTSPRxi/Qvy7HoJVeN7LTybLgcgvSm7WCvmimmDkELK3B
	f9Ja5VwrtGEIW2TjAu/QZopgH54x16bUokLV9IpW16OacyIhYkbbEkEGicpIcLpnELgaY6g3PzJ
	ipVPf0FlVDLnHeET9NkHOey52++de+AcHnUJvE3Uuhm/R/nCyH7TjA7O1SK83l//gxlmG8td4cR
	jIAgd8JEDX89mbXI/efKX1UKNXDY=
X-Google-Smtp-Source: AGHT+IFlKXeAtHhTk1SLO+CqePwO/w0WEyRur6i2wT7kumlydhvgPfkl/quSflZO/twV73QrziIhPg==
X-Received: by 2002:a05:6102:5686:b0:4e7:3e76:cd21 with SMTP id ada2fe7eead31-4fbe7f376f5mr4909961137.9.1753977512820;
        Thu, 31 Jul 2025 08:58:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88d8f422459sm431284241.21.2025.07.31.08.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 08:58:32 -0700 (PDT)
Date: Thu, 31 Jul 2025 18:58:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Marie Zhussupova <marievic@google.com>,
	rmoar@google.com, davidgow@google.com, shuah@kernel.org,
	brendan.higgins@linux.dev
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, elver@google.com,
	dvyukov@google.com, lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	kasan-dev@googlegroups.com, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Marie Zhussupova <marievic@google.com>
Subject: Re: [PATCH 6/9] kunit: Enable direct registration of parameter
 arrays to a KUnit test
Message-ID: <5683507a-dacc-4e46-893f-d1e775d2ef22@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729193647.3410634-7-marievic@google.com>

Hi Marie,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Marie-Zhussupova/kunit-Add-parent-kunit-for-parameterized-test-context/20250730-033818
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git kunit
patch link:    https://lore.kernel.org/r/20250729193647.3410634-7-marievic%40google.com
patch subject: [PATCH 6/9] kunit: Enable direct registration of parameter arrays to a KUnit test
config: nios2-randconfig-r072-20250731 (https://download.01.org/0day-ci/archive/20250731/202507310854.pZvIcswn-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 8.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202507310854.pZvIcswn-lkp@intel.com/

New smatch warnings:
lib/kunit/test.c:723 kunit_run_tests() error: we previously assumed 'test_case->generate_params' could be null (see line 714)

vim +723 lib/kunit/test.c

914cc63eea6fbe Brendan Higgins     2019-09-23  681  int kunit_run_tests(struct kunit_suite *suite)
914cc63eea6fbe Brendan Higgins     2019-09-23  682  {
fadb08e7c7501e Arpitha Raghunandan 2020-11-16  683  	char param_desc[KUNIT_PARAM_DESC_SIZE];
914cc63eea6fbe Brendan Higgins     2019-09-23  684  	struct kunit_case *test_case;
acd8e8407b8fcc David Gow           2021-08-03  685  	struct kunit_result_stats suite_stats = { 0 };
acd8e8407b8fcc David Gow           2021-08-03  686  	struct kunit_result_stats total_stats = { 0 };
8631cd2cf5fbf2 Marie Zhussupova    2025-07-29  687  	const void *curr_param;
914cc63eea6fbe Brendan Higgins     2019-09-23  688  
c272612cb4a2f7 David Gow           2022-07-01  689  	/* Taint the kernel so we know we've run tests. */
c272612cb4a2f7 David Gow           2022-07-01  690  	add_taint(TAINT_TEST, LOCKDEP_STILL_OK);
c272612cb4a2f7 David Gow           2022-07-01  691  
1cdba21db2ca31 Daniel Latypov      2022-04-29  692  	if (suite->suite_init) {
1cdba21db2ca31 Daniel Latypov      2022-04-29  693  		suite->suite_init_err = suite->suite_init(suite);
1cdba21db2ca31 Daniel Latypov      2022-04-29  694  		if (suite->suite_init_err) {
1cdba21db2ca31 Daniel Latypov      2022-04-29  695  			kunit_err(suite, KUNIT_SUBTEST_INDENT
1cdba21db2ca31 Daniel Latypov      2022-04-29  696  				  "# failed to initialize (%d)", suite->suite_init_err);
1cdba21db2ca31 Daniel Latypov      2022-04-29  697  			goto suite_end;
1cdba21db2ca31 Daniel Latypov      2022-04-29  698  		}
1cdba21db2ca31 Daniel Latypov      2022-04-29  699  	}
1cdba21db2ca31 Daniel Latypov      2022-04-29  700  
cae56e1740f559 Daniel Latypov      2022-04-29  701  	kunit_print_suite_start(suite);
914cc63eea6fbe Brendan Higgins     2019-09-23  702  
fadb08e7c7501e Arpitha Raghunandan 2020-11-16  703  	kunit_suite_for_each_test_case(suite, test_case) {
fadb08e7c7501e Arpitha Raghunandan 2020-11-16  704  		struct kunit test = { .param_value = NULL, .param_index = 0 };
acd8e8407b8fcc David Gow           2021-08-03  705  		struct kunit_result_stats param_stats = { 0 };
fadb08e7c7501e Arpitha Raghunandan 2020-11-16  706  
887d85a0736ff3 Rae Moar            2023-03-08  707  		kunit_init_test(&test, test_case->name, test_case->log);
03806177fa4cbb Marie Zhussupova    2025-07-29  708  		__kunit_init_parent_test(test_case, &test);
03806177fa4cbb Marie Zhussupova    2025-07-29  709  
529534e8cba3e6 Rae Moar            2023-07-25  710  		if (test_case->status == KUNIT_SKIPPED) {
529534e8cba3e6 Rae Moar            2023-07-25  711  			/* Test marked as skip */
529534e8cba3e6 Rae Moar            2023-07-25  712  			test.status = KUNIT_SKIPPED;
529534e8cba3e6 Rae Moar            2023-07-25  713  			kunit_update_stats(&param_stats, test.status);
44c50ed8e59936 Marie Zhussupova    2025-07-29 @714  		} else if (!test_case->generate_params && !test.params_data.params) {
                                                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^
Imagine ->generate_parms is NULL but test.params_data.params is
non-NULL.

37dbb4c7c7442d David Gow           2021-11-02  715  			/* Non-parameterised test. */
529534e8cba3e6 Rae Moar            2023-07-25  716  			test_case->status = KUNIT_SKIPPED;
37dbb4c7c7442d David Gow           2021-11-02  717  			kunit_run_case_catch_errors(suite, test_case, &test);
37dbb4c7c7442d David Gow           2021-11-02  718  			kunit_update_stats(&param_stats, test.status);
03806177fa4cbb Marie Zhussupova    2025-07-29  719  		} else if (test_case->status != KUNIT_FAILURE) {
fadb08e7c7501e Arpitha Raghunandan 2020-11-16  720  			/* Get initial param. */
fadb08e7c7501e Arpitha Raghunandan 2020-11-16  721  			param_desc[0] = '\0';
8631cd2cf5fbf2 Marie Zhussupova    2025-07-29  722  			/* TODO: Make generate_params try-catch */
13ee0c64bd88a3 Marie Zhussupova    2025-07-29 @723  			curr_param = test_case->generate_params(&test, NULL, param_desc);
                                                                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^
Then this could crash.

I suspect that this is fine, but I bet that in the previous
condition, just testing one would probably have been sufficient
or maybe we could have change && to ||.

529534e8cba3e6 Rae Moar            2023-07-25  724  			test_case->status = KUNIT_SKIPPED;
6c738b52316c58 Rae Moar            2022-11-23  725  			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
6c738b52316c58 Rae Moar            2022-11-23  726  				  "KTAP version 1\n");
44b7da5fcd4c99 David Gow           2021-11-02  727  			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
44b7da5fcd4c99 David Gow           2021-11-02  728  				  "# Subtest: %s", test_case->name);
fadb08e7c7501e Arpitha Raghunandan 2020-11-16  729  
8631cd2cf5fbf2 Marie Zhussupova    2025-07-29  730  			while (curr_param) {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


