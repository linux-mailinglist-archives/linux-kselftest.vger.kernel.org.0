Return-Path: <linux-kselftest+bounces-13664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AD392F76F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 10:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74506281741
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 08:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5931428F0;
	Fri, 12 Jul 2024 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0uZRHqb8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF2D13D8A4;
	Fri, 12 Jul 2024 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774785; cv=none; b=sVsdxjc7sP0YfxNtP69w9dB3JD/7DHkR/BR2L6oi9wCtJpl3zhhp8enoOb9+KQdOQZtbuKQImLFTzCP3WZ60AYsZLljJaAQExa1WjXjxo7q0wdfnSmYY6i1SKQthp+INp7+tKh+m9BHqgvUsXnHDIPihjD4Va6YakpqdcuSILWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774785; c=relaxed/simple;
	bh=0V/UzY4npvWb0NaKofMtzEIjIcMV1S6JXCcxXoOhmAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxyEb+bfRk3lM0zWs7i+dyUm2duGmkodnfC7ZV0TnBAJeMo5hRtK9G7FOSKhKVXfcLHsLf2MFT7bgee5iTOZITpRMgAvhIjP2GC1MFVkhiDi6eiXVGyh3Tc8yZ552CpKaHug+fDT67If+8R4gvNOAqNw5/4XobzmOmgzHTDwOXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0uZRHqb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6C7C4AF09;
	Fri, 12 Jul 2024 08:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720774785;
	bh=0V/UzY4npvWb0NaKofMtzEIjIcMV1S6JXCcxXoOhmAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0uZRHqb8dHBx8mMiPKcNvtKUcyAm7Cy16eIBzT5By5WMu5eeZLy4g4qdQ0mhxReyV
	 cGziAOHNRlcp/CnP2wrGfkC5aOWUDFQwHuVMrBEwrleD1tiBRN2fdLZhXNPG8tl+W2
	 XS4IOOrGjFuLkiBnkLIAreFUdyQ5WGruOvpxWyog=
Date: Fri, 12 Jul 2024 10:59:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernelci@lists.linux.dev
Subject: Re: [PATCH v2 0/3] kselftest: Add test to report device log errors
Message-ID: <2024071229-mule-statistic-dc17@gregkh>
References: <20240705-dev-err-log-selftest-v2-0-163b9cd7b3c1@collabora.com>
 <2024071003-islamist-expediter-a22c@gregkh>
 <71c479fb-cd25-45ec-8dd3-0521ef951f58@linuxfoundation.org>
 <e1e32c72-6bd3-4c15-b301-c5670690ba99@linuxfoundation.org>
 <1417b57a-ac0b-4e8c-b157-bbe9ebb14e57@notapiano>
 <e73c745a-5e2f-46f3-806a-739cfde72e8d@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e73c745a-5e2f-46f3-806a-739cfde72e8d@linuxfoundation.org>

On Thu, Jul 11, 2024 at 03:56:25PM -0600, Shuah Khan wrote:
> On 7/11/24 15:44, Nícolas F. R. A. Prado wrote:
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
> > > > > >    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >    power_supply sbs-8-000b: driver failed to report `model_name' property: -6
> > > > > >    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >    power_supply sbs-8-000b: driver failed to report `energy_full_design' property: -6
> > > > > >    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > >    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > > > not ok 1 +power_supply:sbs-8-000b
> > > > > >    Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
> > > > > > 
> > > > > > [1] https://lore.kernel.org/all/cf4d8131-4b63-4c7a-9f27-5a0847c656c4@notapiano
> > > > > > 
> > > > > > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > > > > 
> > > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > 
> > > > Is this dependent on a linux-next?
> > > > 
> > > > Didn't apply to linux-kselftest next.
> > > > 
> > > 
> > > I tried applying these on top of linux-kselftest next which is at
> > > Linux 6.10-rc7 + other patches.
> > > 
> > > I am not sure what is wrong - first patch applies and the second
> > > and third don't.
> > > 
> > > git am fails and manual patch application worked for 2/3, same thing
> > > with 3.3 - these should apply cleanly since they don't have obvious
> > > conflicts.
> > > 
> > > Please clean this up and send me updated series adding Greg's ack.
> > 
> > Oh, now I see what happened. I recently sent another series that touches the
> > same file (tools/testing/selftests/devices/test_discoverable_devices.py):
> > "kselftest: devices: Allow running test on more platforms"
> > https://lore.kernel.org/all/20240613-kselftest-discoverable-probe-mt8195-kci-v1-1-7b396a9b032d@collabora.com/
> > 
> > That was already merged through the usb tree, and is present on next (on which I
> > based this series).
> > 
> > In this case I imagine it's best if this series gets picked through the usb
> > tree, right? Even if I rebase on kselftest's next, there will be conflicts.
> > 
> 
> I see. No problem. It can go through usb tree
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Ok, taken through the usb tree now, thanks.

greg k-h

