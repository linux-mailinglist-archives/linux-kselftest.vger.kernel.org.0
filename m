Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9312749C9C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 13:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241343AbiAZMe0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 07:34:26 -0500
Received: from foss.arm.com ([217.140.110.172]:36820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241330AbiAZMe0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 07:34:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 008D8D6E;
        Wed, 26 Jan 2022 04:34:26 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41B1A3F793;
        Wed, 26 Jan 2022 04:34:25 -0800 (PST)
Date:   Wed, 26 Jan 2022 12:34:18 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH 2/5] kselftest: Fix vdso_test_time to pass on skips
Message-ID: <20220126123418.GH6113@e120937-lin>
References: <20220126102723.23300-1-cristian.marussi@arm.com>
 <20220126102723.23300-3-cristian.marussi@arm.com>
 <8d513be7-a99d-2b7f-6767-a378742ef3fa@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d513be7-a99d-2b7f-6767-a378742ef3fa@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 26, 2022 at 12:22:45PM +0000, Vincenzo Frascino wrote:
> Hi Cristian,
> 

Hi Vincenzo,

thanks for the feedback.

> On 1/26/22 10:27 AM, Cristian Marussi wrote:
> > When a vDSO symbol is not found, all the testcases in vdso_test_abi usually
> > report a SKIP, which, in turn, is reported back to Kselftest as a PASS.
> > 
> > Testcase vdso_test_time, instead, reporting a SKIP, causes the whole set of
> > tests within vdso_test_abi to be considered FAIL when symbol is not found.
> > 
> > Fix it reporting a PASS when vdso_test_time cannot find the vdso symbol.
> > 
> > Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > Seen as a failure on both a JUNO and a Dragonboard on both recent and old
> > kernels/testruns:
> > 
> > root@deb-buster-arm64:~# /opt/ksft/vDSO/vdso_test_abi
> > [vDSO kselftest] VDSO_VERSION: LINUX_2.6.39
> > The time is 1637922136.675304
> > The time is 1637922136.675361000
> > The resolution is 0 1
> > clock_id: CLOCK_REALTIME [PASS]
> > The time is 1927.760604900
> > The resolution is 0 1
> > clock_id: CLOCK_BOOTTIME [PASS]
> > The time is 1637922136.675649700
> > The resolution is 0 1
> > clock_id: CLOCK_TAI [PASS]
> > The time is 1637922136.672000000
> > The resolution is 0 4000000
> > clock_id: CLOCK_REALTIME_COARSE [PASS]
> > The time is 1927.761005600
> > The resolution is 0 1
> > clock_id: CLOCK_MONOTONIC [PASS]
> > The time is 1927.761132780
> > The resolution is 0 1
> > clock_id: CLOCK_MONOTONIC_RAW [PASS]
> > The time is 1927.757093740
> > The resolution is 0 4000000
> > clock_id: CLOCK_MONOTONIC_COARSE [PASS]
> > Could not find __kernel_time              <<< This caused a FAIL as a whole
> > root@deb-buster-arm64:~# echo $?
> > 1
> > 
> > e.g.: https://lkft.validation.linaro.org/scheduler/job/2192570#L27778
> > ---
> >  tools/testing/selftests/vDSO/vdso_test_abi.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
> > index 3d603f1394af..7dcc66d1cecf 100644
> > --- a/tools/testing/selftests/vDSO/vdso_test_abi.c
> > +++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
> > @@ -90,8 +90,9 @@ static int vdso_test_time(void)
> >  		(vdso_time_t)vdso_sym(version, name[2]);
> >  
> >  	if (!vdso_time) {
> > +		/* Skip if symbol not found: consider skipped tests as passed */
> >  		printf("Could not find %s\n", name[2]);
> > -		return KSFT_SKIP;
> > +		return KSFT_PASS;
> 
> My preference would be to keep "KSFT_SKIP" here and verify separately the return
> status of each test. This would maintain compliance with the kselftest API.
> Could you please test the patch in-reply-to this one (will be sent shortly) and
> let me know if it works for you?
> 
Sure, I was indeed not sure my solution was what you wanted.

> If it does feel free to fold it in the next version of your series with your
> "Tested-by:" otherwise let me know.

Sure, I'll do and keep you on CC.

Thanks,
Cristian

