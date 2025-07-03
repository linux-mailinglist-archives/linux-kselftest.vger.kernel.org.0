Return-Path: <linux-kselftest+bounces-36415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09505AF6EA1
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 11:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A492C7B74DC
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 09:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCEF2D77F9;
	Thu,  3 Jul 2025 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+THJFDc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6D62D77F0;
	Thu,  3 Jul 2025 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751534866; cv=none; b=b/v+J72tQdfdxg7SSZJbGb1bm1qinokHQ5105wqvW0dseosVGwk7RQdtVGRl/zMBvmfmKcOt4xcYyNhA2gHEczl9TAjT7XPJVtiyfKV4kgRtQd3ST6eBA/bfN4HG8yNeEhzKDfzJSQE8zbAm09dDvw6mn26pQQ2YmbhEdPmZPpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751534866; c=relaxed/simple;
	bh=VzhiqByXgLMeSkkslWm+EtEK5qyexWArSelTCC/0AMg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JWGJW47CGiQurNYdOXP3EbpZ6TDYqPU/dZPhNr4XxQ6gd2sJ31JH1S0JCp3ovjaaD9tEMIE37Ed0p2lTcwlBGW1KJmyKgS818JqeOY9o58aFjd8U3mx2IAVUbhqjREmF2mFWU8AlIEowa9xh3fTuSFm5iWy20ljz516mDdLpErU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+THJFDc; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751534864; x=1783070864;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VzhiqByXgLMeSkkslWm+EtEK5qyexWArSelTCC/0AMg=;
  b=a+THJFDckHc3KT6E+JgqSK+DIsQhe52bCovv93kIo38x2cb/UY0hBbg+
   CUaebmEIB5qAMpWmg2T61yKhm7ZrCiG6N8KHW+EdI7vVi432Kzc3ouk8i
   dCUcDgbjRN+jvMaV/+66i6KK8OHg9qPLAJ0Vki/mV06Vr65duNlmuvCj5
   GUdyh9fAWlnZJVZsU+7frhXUdVDdfKQMPFrbmlRNb1iVz6/AbCXU0ldxQ
   JJjyuGDoC5J2SCoSCMSJXCgtMKPVZYovzZ/ecZG7grt15InU/eVnIKP4p
   I6QYS/BKH7IzY7RVF5MzLunA380TUM34gOL1ANnVwzqNJGQsC0cfuaZQQ
   A==;
X-CSE-ConnectionGUID: /03hNDkcTyOfRiNGLwNhsw==
X-CSE-MsgGUID: 0GRnrL5LQMW1N4/NUcS6/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="65308024"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; 
   d="scan'208";a="65308024"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 02:27:43 -0700
X-CSE-ConnectionGUID: oOykCtReR7W4UX17C+gjsg==
X-CSE-MsgGUID: BwbPXvI2Sr2Mys8YYQ4gdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; 
   d="scan'208";a="154396935"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 02:27:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 3 Jul 2025 12:27:37 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
    Tony Luck <tony.luck@intel.com>, Dave Martin <Dave.Martin@arm.com>, 
    James Morse <james.morse@arm.com>, 
    Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, 
    LKML <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghuay@nvidia.com>
Subject: Re: [RFC PATCH v1 0/2] kselftest/resctrl: CAT functional tests
In-Reply-To: <0e9137e0-ec21-42b9-98be-af90becc2318@intel.com>
Message-ID: <6e4aada6-005e-95ba-207d-f867c2405a1c@linux.intel.com>
References: <20250616082453.3725-1-ilpo.jarvinen@linux.intel.com> <0e9137e0-ec21-42b9-98be-af90becc2318@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1968015734-1751534857=:2373"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1968015734-1751534857=:2373
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 27 Jun 2025, Reinette Chatre wrote:
> On 6/16/25 1:24 AM, Ilpo J=C3=A4rvinen wrote:
> >=20
> > In the last Fall Reinette mentioned functional tests of resctrl would
> > be preferred over selftests that are based on performance measurement.
> > This series tries to address that shortcoming by adding some functional
> > tests for resctrl FS interface and another that checks MSRs match to
> > what is written through resctrl FS. The MSR test is only available for
> > Intel CPUs at the moment.
>=20
> Thank you very much for keeping this in mind and taking this on!
>=20
> >=20
> > Why RFC?
> >=20
> > The new functional selftest itself works, AFAIK. However, calling
> > ksft_test_result_skip() in cat.c if MSR reading is found to be
> > unavailable is problematic because of how kselftest harness is
> > architected. The kselftest.h header itself defines some variables, so
> > including it into different .c files results in duplicating the test
> > framework related variables (duplication of ksft_count matters in this
> > case).
> >=20
> > The duplication problem could be worked around by creating a resctrl
> > selftest specific wrapper for ksft_test_result_skip() into
> > resctrl_tests.c so the accounting would occur in the "correct" .c file,
> > but perhaps that is considered hacky and the selftest framework/build
> > systems should be reworked to avoid duplicating variables?
>=20
> I do not think resctrl selftest's design can demand such a change from=20
> kselftest. The way I understand this there is opportunity to improve
> (fix?) resctrl's side.

Perhaps resctrl can be improved as well but I think it's also a bad=20
practice to create variables in any header like that. I just don't know=20
what would be the preferred way to address that in the context of=20
kselftest because AFAIK, there's no .c file currently injected into all=20
selftests by the build system.

> Just for benefit of anybody following (as I am sure you are very familiar
> with this), on a high level the resctrl selftests are run via a wrapper t=
hat
> calls a test specific function:
> =09run_single_test() {
> =09=09...
> =09=09ret =3D test->run_test(test, uparams);
> =09=09ksft_test_result(!ret, "%s: test\n", test->name);
> =09=09...
> =09}
>=20
> I believe that you have stumbled onto a problem with this since
> the wrapper can only handle "pass" and "fail" (i.e. not "skip").
>=20
> This is highlighted by patch #2 that sets cat_ctrlgrp_msr_test()
> as the "test->run_test" and it does this:
>=20
> =09cat_ctrlgrp_msr_test() {
> =09=09...
> =09=09if (!msr_access_supported(uparams->cpu)) {
> =09=09=09ksft_test_result_skip("Cannot access MSRs\n");
> =09=09=09return 0;
> =09=09}
> =09}
>=20
> The problem with above is that run_single_test() will then set "ret" to
> 0, and run_single_test()->ksft_test_result() will consider the test a "pa=
ss".
>=20
> To address this I do not think the tests should call any of the
> ksft_test_result_*() wrappers but instead should return the actual
> kselftest exit code. For example, cat_ctrl_grp_msr_test() can be:
>=20
> =09cat_ctrlgrp_msr_test() {
> =09=09...
> =09=09if (!msr_access_supported(uparams->cpu))
> =09=09=09return KSFT_SKIP;
> =09=09...
> =09}
>=20
> To support that run_single_test() can be:
> =09run_single_test() {
> =09=09...
> =09=09ret =3D test->run_test(test, uparams);
> =09=09ksft_test_result_report(ret, "%s: test\n", test->name);
> =09=09...
> =09}
>=20
> I think making this explicit will make the tests also easier to read. For=
 example,
> cat_ctrlgrp_tasks_test() in patch #1 contains many instances of the below
> pattern:
> =09ksft_print_msg("some error message");
> =09ret =3D 1;
>=20
> A positive return can be interpreted many ways. Something like
> below seems much clearer to me:
>=20
> =09ksft_print_msg("some error message");
> =09ret =3D KSFT_FAIL;
>=20
> What do you think?

I hadn't notice there are already these defines for the status value=20
in kselftest.h. Yes, it definitely makes sense to use them in resctrl=20
selftests instead of literal return values.

That, however, addresses only half of the problem as=20
ksft_test_result_skip() takes string which would naturally come from=20
the test case because it knows better what went wrong.

IMO, most optimal solution would be to call ksft_test_result_skip() right=
=20
at the test case ifself and then return KSFT_SKIP from the test to=20
run_single_test(). run_single_test() would then skip doing=20
ksft_test_result() call. But that messes up the test result counts due to=
=20
the duplicated ksft_cnt in different .c files.

> On a different topic, the part of this series that *does* raise a questio=
n
> in my mind is the introduction of the read_msr() utility local to resctrl=
=2E
> Duplicating code always concerns me and I see that there are already a fe=
w
> places where user space tools and tests read MSRs by opening/closing the =
file
> while there is also one utility (tools/power/cpupower/utils/helpers/msr.c=
) that looks
> quite similar to what is created here.
>=20
> It is not obvious to me how to address this though. Looking around I see=
=20
> tools/lib may be a possible candidate and the changelog of
> commit 553873e1df63 ("tools/: Convert to new topic libraries") gave me im=
pression
> that the goal of this area is indeed to host code shared by things
> living in tools/ (that includes kselftest). While digging I could not fin=
d
> a clear pattern of how this is done in the kselftests though. This could
> perhaps be an opportunity to pave the way for more code sharing among
> selftests by creating such a pattern with this already duplicated code?

The duplication of MSR reading code was a bit annoying to me as well,=20
although I only thought it within inside kselftests. But I can look at=20
this considering tools/ too now that you pointed to that direction.

--=20
 i.

--8323328-1968015734-1751534857=:2373--

