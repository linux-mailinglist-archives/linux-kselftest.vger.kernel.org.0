Return-Path: <linux-kselftest+bounces-13697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67331930158
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 22:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28040282F0B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 20:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201C340BE5;
	Fri, 12 Jul 2024 20:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YNn+gBiS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAAA3BBF2;
	Fri, 12 Jul 2024 20:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720817481; cv=none; b=plfaqUqebTszMDH+5kzjYdqMl1MCL4qvkjwyREqzTuYmIKoTQ4Cffw7RcsDOuh3iepTeO9hbc7KYeEMtpHAuj8CoO/SexhlaQgoM450Uus/Ki1wOPfHuCGykDaV7snsB1Kwe7tdNBheYBFZ/1XtOsVNZKMmQUeNSYV4O76z0bec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720817481; c=relaxed/simple;
	bh=p8z5BlaNA9refMxAcIY2cWmcKroHykJZu52ehAbtwTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uocyy0dFAC9AVbbnVB/UQDiPdJEREduoIFXNO2n5Ct6bsUyzEtXqONnAjzXQ8KwhWwPrllZj0dOh3R3i5WOocAtRvh2lQdrySVQoQ/PAl0nbhkFrd7/O5yinQWl8op7zI197vWZPZ0XxQN+mOCj9YKLdlui/jNJ8Ag3Gyh533RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YNn+gBiS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720817476;
	bh=p8z5BlaNA9refMxAcIY2cWmcKroHykJZu52ehAbtwTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YNn+gBiS7Jx6FieUsCTFbXNhcz1e4Lq7FE0HnqD3kxJ1deF1Ljf0fAu6erHDq37WG
	 u/SHxNaw9DcB8LvcGgBsnqJ+tXYrO80eP9Zh1aQE+lo7wslOphQNTEpITqOq2QDLUz
	 WwWD5Iw6Lj49UFw30QC4EdsPwmckq1PcMLLMOyp5I7HfDDEluuOBYx+1BpsTWe1Rqr
	 WRdwDWtMSgstuV5xxs0l5UDfW0VZ0lmq2wrMNZBf2Mk70IMT56+Y4K8PgfO29SygoJ
	 A3fL1ggX5kbuqNZ8Kfo5PRQwaC9rQTnhAh4Kg8rOkb4dIAWjU69wzeYApBF11R4VtT
	 wEbWZnaUmrrMQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B8BCC3782016;
	Fri, 12 Jul 2024 20:51:14 +0000 (UTC)
Date: Fri, 12 Jul 2024 16:51:12 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: "Bird, Tim" <Tim.Bird@sony.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	"kernel@collabora.com" <kernel@collabora.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernelci@lists.linux.dev" <kernelci@lists.linux.dev>
Subject: Re: [PATCH v2 0/3] kselftest: Add test to report device log errors
Message-ID: <6ff3e81b-09e7-48a1-a674-ca2816c3eb85@notapiano>
References: <20240705-dev-err-log-selftest-v2-0-163b9cd7b3c1@collabora.com>
 <2024071003-islamist-expediter-a22c@gregkh>
 <71c479fb-cd25-45ec-8dd3-0521ef951f58@linuxfoundation.org>
 <e1e32c72-6bd3-4c15-b301-c5670690ba99@linuxfoundation.org>
 <1417b57a-ac0b-4e8c-b157-bbe9ebb14e57@notapiano>
 <BN6PR13MB30412D89F6389C30BD1DEFDBFDA62@BN6PR13MB3041.namprd13.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN6PR13MB30412D89F6389C30BD1DEFDBFDA62@BN6PR13MB3041.namprd13.prod.outlook.com>

On Fri, Jul 12, 2024 at 05:48:14PM +0000, Bird, Tim wrote:
> 
> 
> > -----Original Message-----
> > From: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > On Thu, Jul 11, 2024 at 01:53:37PM -0600, Shuah Khan wrote:
> > > On 7/10/24 15:49, Shuah Khan wrote:
> > > > On 7/10/24 07:11, Greg Kroah-Hartman wrote:
> > > > > On Fri, Jul 05, 2024 at 07:29:53PM -0400, Nícolas F. R. A. Prado wrote:
> > > > > > Log errors are the most widely used mechanism for reporting issues in
> > > > > > the kernel. When an error is logged using the device helpers, eg
> > > > > > dev_err(), it gets metadata attached that identifies the subsystem and
> > > > > > device where the message is coming from. This series makes use of that
> > > > > > metadata in a new test to report which devices logged errors.
> > > > > >
> > > > > > The first two patches move a test and a helper script to keep things
> > > > > > organized before this new test is added in the third patch.
> > > > > >
> > > > > > It is expected that there might be many false-positive error messages
> > > > > > throughout the drivers code which will be reported by this test. By
> > > > > > having this test in the first place and working through the results we
> > > > > > can address those occurrences by adjusting the loglevel of the messages
> > > > > > that turn out to not be real errors that require the user's attention.
> > > > > > It will also motivate additional error messages to be introduced in the
> > > > > > code to detect real errors where they turn out to be missing, since
> > > > > > it will be possible to detect said issues automatically.
> > > > > >
> > > > > > As an example, below you can see the test result for
> > > > > > mt8192-asurada-spherion. The single standing issue has been investigated
> > > > > > and will be addressed in an EC firmware update [1]:
> > > > > >
> > > > > > TAP version 13
> > > > > > 1..1
> > > > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >   power_supply sbs-8-000b: driver failed to report `model_name' property: -6
> > > > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >   power_supply sbs-8-000b: driver failed to report `energy_full_design' property: -6
> > > > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > > not ok 1 +power_supply:sbs-8-000b
> 
> Sorry this feedback is coming late. 
> 
> The test description only includes the device identifier, and not a description of the testcase.
> (See below for why this might be the case).
> 
> Maybe a better testcase description might be: "check that power_supply:sbs-8-000b device has no error messages"

Indeed that would make it more descriptive, but it would also add a lot of
redundant information. Since all the test does is check whether each device has
error messages, the only unique information for each test case is the device
identifier. In other words I considered the "check that ... device has no error
messages" implied by the test suite.

> 
> I note that there are 3 different error messages, but only one testcase report generated.
> It would be a lot of work (probably too much), for this test to interpret the error messages
> and convert them into testcase language.  But it might be worthwhile to report a test result
> for each type of error message generated.

I don't know how much value that would bring, but it might be an interesting
idea to try.

Interpreting the messages seems too much, but if we just compare the messages
for uniqueness and use them as is in the test identifiers it would be easy to
do, eg:

not ok 1 +power_supply:sbs-8-000b.power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
not ok 2 +power_supply:sbs-8-000b.power_supply sbs-8-000b: driver failed to report `energy_full_design' property: -6
not ok 3 +power_supply:sbs-8-000b.power_supply sbs-8-000b: driver failed to report `model_name' property: -6

My concern is that I don't know if this is actually doing a good job of
portraying the issues: in this case it's actually really just one issue that
triggers those different messages, but this makes it look like there are 3
independent issues and the order of the errors is completely lost.

> 
> > > > > >   Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
> > > > > >
> 
> There are a few interesting issues that this 'test' raises.
> 
> It is not so much a test itself, as a way to convert an error log report into KTAP output.
> 
> The 'test' has no knowledge of what the testcases are, that are being reported.
> That is, the actual test has occurred at runtime, inside the driver or device manager
> code, which produced the error string.  This 'test' just reports that the device reported
> an error. 

Right. I would argue that the test suite as a whole does test something: "Did
any devices on this platform report errors?". And if the answer is yes, then the
test cases will detail this information by simply converting the error log into
KTAP.

But indeed the bulk of the testing is done by the drivers and frameworks and
this 'test' is mostly about structuring and reporting that data in a way that
is easier to identify the problematic devices on the system.

> 
> As currently structured, there is no way for this to report an 'ok' testcase.
> I talked with Nicolas on a KernelCI conference call, it is apparently possible to try to find
> all possible devices on a system, and report them as 'ok'.  But this would produce
> a LOT of noise, as all the devices that did not have errors would be reported as 'ok'.
> This level of verbosity is probably not desirable.  (It's similar to how a compiler does
> not report the success of every test it conducts on the source code, as it is being compiled.
> Rather a compiler only outputs errors and warnings for test failures.)
> 
> In terms of tracking regressions, it would be useful to identify the different things that could
> cause an error message to appear or disappear.  For example, some errors related to hardware
> might change due to flakiness of the hardware.  Some errors might be introduced or go away
> based on a change in the kernel configuration.  This is one case, where have a long list of "ok"
> lines would be useful - to disambiguate drivers that were present, but didn't have an error, from
> drivers that were not present at all.

Yes, to this I currently don't see another option... However, if we keep the
"ok" cases hidden/implicit, I think the concern about drivers not being present
at all can be mostly addressed by also running a probe test, like the DT
kselftest [1] or the ACPI kselftest [2]. That way, you would rely on the probe
test to verify whether all the devices expected on the system are there, and on
the error log test to verify whether any of the devices on the system have
issues.

> 
> I think this test is useful, and am not NAK-ing it.  I'm just giving some feedback on the general
> approach, and hopefully raising some issues to consider, to make the test more useful.

I think more important than merging or not merging the test is getting feedback
from the community on how to improve testing on the kernel, so I definitely
welcome your feedback. Thank you for taking the time to write this.

Thanks,
Nícolas

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/dt/test_unprobed_devices.sh
[2] https://lore.kernel.org/all/20240308144933.337107-1-laura.nao@collabora.com

