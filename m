Return-Path: <linux-kselftest+bounces-19954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425D49A2245
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 14:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5934A1C21671
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 12:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CC11DCB2C;
	Thu, 17 Oct 2024 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yhEl1Jkz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36DD1D45F2;
	Thu, 17 Oct 2024 12:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729168323; cv=none; b=sEKMflGn+0OIPwI9fnrzBvKasWpTvkHCXbzAbrIF4i2fyjNC//+kFWDRVYJ3JCjKfStLTaGet6ennOcsBAAs6d74JUVFHzEa5ME11ajF+AW7INgWBlijceTgaqqd2fNgHTcdTt5HudJiXXEVlfX99JIuf14diycmdHL5XNDkUjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729168323; c=relaxed/simple;
	bh=pyv973UZ3xzegnLyzwZvScQ3I1W3XFX01CqLo7sMXkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lFqyPTaqdqJLIy4c/YIw6D+AlzRzBKXDp+Ymc7Oc4AtSVnTVTJC+Tf31fcMDg60cJ4shxfaEAy+r1XQpPhLJxgU7uf8C5PYTvFI4XHjmGLcfJ3tzhz/faE/uaQdFZs2kTH70Ze6AVaMwCi3+eUQsPxLfCykOycd0Q9UKWRjshH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yhEl1Jkz; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49HCVip3012524;
	Thu, 17 Oct 2024 07:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729168304;
	bh=aWWv4FkoudrEgZFR46LHW8u/ldBpL6xyV6QvYWrbXpg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=yhEl1JkzA6Tv/hFIvOBtrZHPRph0iSeQ0jkAgz89OWVQqp88rgRVAWhqdzcQ0G2zv
	 LcVOCqdD/CkbIEo6XKeTHUU+i3CtcbOb1aQDOTitf9L5pjZcmA8aavsoaEykrNjokX
	 EcsTkxqFV2tdJzHYU168RB/MbXNBfF6wVZOnH3EU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49HCVi0Y043490;
	Thu, 17 Oct 2024 07:31:44 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Oct 2024 07:31:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Oct 2024 07:31:44 -0500
Received: from [128.247.81.151] (uda0271612.dhcp.ti.com [128.247.81.151])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49HCViG2097740;
	Thu, 17 Oct 2024 07:31:44 -0500
Message-ID: <6366eab3-4318-7b8b-686e-f9d5d320badb@ti.com>
Date: Thu, 17 Oct 2024 07:31:44 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC] Test catalog template
To: Donald Zickus <dzickus@redhat.com>, <workflows@vger.kernel.org>,
        <automated-testing@lists.yoctoproject.org>,
        <linux-kselftest@vger.kernel.org>, kernelci <kernelci@lists.linux.dev>
CC: Nikolai Kondrashov <nkondras@redhat.com>,
        Gustavo Padovan
	<gustavo.padovan@collabora.com>,
        kernelci-members
	<kernelci-members@groups.io>,
        <laura.nao@collabora.com>
References: <CAK18DXYitS7hL1mA3QsPLmW9-R0q6Kin0C5Uv9fj=uS90WSnxA@mail.gmail.com>
Content-Language: en-US
From: Minas Hambardzumyan <minas@ti.com>
In-Reply-To: <CAK18DXYitS7hL1mA3QsPLmW9-R0q6Kin0C5Uv9fj=uS90WSnxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 10/14/24 15:32, Donald Zickus wrote:
> Hi,
> 
> At Linux Plumbers, a few dozen of us gathered together to discuss how
> to expose what tests subsystem maintainers would like to run for every
> patch submitted or when CI runs tests.  We agreed on a mock up of a
> yaml template to start gathering info.  The yaml file could be
> temporarily stored on kernelci.org until a more permanent home could
> be found.  Attached is a template to start the conversation.
> 
> Longer story.
> 
> The current problem is CI systems are not unanimous about what tests
> they run on submitted patches or git branches.  This makes it
> difficult to figure out why a test failed or how to reproduce.
> Further, it isn't always clear what tests a normal contributor should
> run before posting patches.
> 
> It has been long communicated that the tests LTP, xfstest and/or
> kselftests should be the tests  to run.  However, not all maintainers
> use those tests for their subsystems.  I am hoping to either capture
> those tests or find ways to convince them to add their tests to the
> preferred locations.
> 
> The goal is for a given subsystem (defined in MAINTAINERS), define a
> set of tests that should be run for any contributions to that
> subsystem.  The hope is the collective CI results can be triaged
> collectively (because they are related) and even have the numerous
> flakes waived collectively  (same reason) improving the ability to
> find and debug new test failures.  Because the tests and process are
> known, having a human help debug any failures becomes easier.
> 
> The plan is to put together a minimal yaml template that gets us going
> (even if it is not optimized yet) and aim for about a dozen or so
> subsystems.  At that point we should have enough feedback to promote
> this more seriously and talk optimizations.
> 
> Feedback encouraged.
> 
> Cheers,
> Don
> 
> ---
> # List of tests by subsystem
> #
> # Tests should adhere to KTAP definitions for results
> #
> # Description of section entries
> #
> #  maintainer:    test maintainer - name <email>
> #  list:                mailing list for discussion
> #  version:         stable version of the test
> #  dependency: necessary distro package for testing
> #  test:
> #    path:            internal git path or url to fetch from
> #    cmd:            command to run; ability to run locally
> #    param:         additional param necessary to run test
> #  hardware:      hardware necessary for validation
> #
> # Subsystems (alphabetical)
> 
> KUNIT TEST:
>    maintainer:
>      - name: name1
>        email: email1
>      - name: name2
>        email: email2
>    list:
>    version:
>    dependency:
>      - dep1
>      - dep2
>    test:
>      - path: tools/testing/kunit
>        cmd:
>        param:
>      - path:
>        cmd:
>        param:
>    hardware: none
> 
> 

Don,

thanks for initiating this! I have a few questions/suggestions:

I think the root element in a section (`KUNIT TEST` in your example) is 
expected to be a container of multiple test definitions ( so there will 
be one for LTP, KSelfTest, etc) -- can you confirm?

Assuming above is correct and `test` is a container of multiple test 
definitions, can we add more properties to each:
   * name -- would be a unique name id for each test
   * description -- short description of the test.
   * arch -- applicable platform architectures
   * runtime -- This is subjective as it can be different for different 
systems. but maybe we can have some generic names, like 'SHORT', 
'MEDIUM', 'LONG', etc and each system may scale the timeout locally?

I see you have a `Subsystems` entry in comments section, but not in the 
example. Do you expect it to be part of this file, or will there be a 
file per each subsystem?

Can we define what we mean by a `test`? For me this is a group of one or 
more individual testcases that can be initiated with a single 
command-line, and is expected to run in a 'reasonable' time. Any other 
thoughts?

Thanks!
Minas



