Return-Path: <linux-kselftest+bounces-13629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E8492F148
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 23:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABBF1B217A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 21:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4C119FA96;
	Thu, 11 Jul 2024 21:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YBsNl+zK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35BB42042;
	Thu, 11 Jul 2024 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720734266; cv=none; b=ViOysgV7PCZmc5e80XPhcwEhYcuexLATb5HiFjhYyy/Ej4NcQ+QM53CJCiJSNZ4n/lpdJdyQ/OOgHkw+wAtYsfGVoH1GRWhfs+naQIgIEmueKl3Ghz1DLH5sImU0NiG1EmwxKNIRZSvgZ3vPy/ZrwkDdnjC4fqDA/nVshlgTbeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720734266; c=relaxed/simple;
	bh=der/eetOhoSXCm/h5jMDIUGHsFbHn807aMRuYndxSG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaNBVV4QpPLX1Du+OEDc76ZucIS1lXImub+G5A/syW3Eb0jjGsZFQThEemjou8x1Hz6i32uh2fGFKqDgRROTpbfC1L9xXIrSu3xUvwr51Z3dErF0K8+SXd57pcuQxFT4NeFPXIjiS0hVsOzra/bhBeyIMPnfAMU/SNbwSKEXw2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YBsNl+zK; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720734255;
	bh=der/eetOhoSXCm/h5jMDIUGHsFbHn807aMRuYndxSG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YBsNl+zK4JS6w+FbgkNHx1hD3GS1wTaTl/CKMUvqTcGPPBksjqGAe2nu1lNCL7XAR
	 pvBzMKmRNgjGLr7oGcylW0NDMuz3sZG7zVQ+qM9x3X1Jd3P/UeI1p9PRQhVVKnkHW9
	 d0aHDyJ36lW9BC5IHChnUTDo9MelK3tnxp326VgnDzcunl0nE6XncTHmZfTBpf9Qv4
	 sONVSLXPPmItpalyWqqrCPyvGvEEztVbIdxh/GPRm4jkFwf0GzK1lrdCXN7d8Cyw8k
	 iSio2Pj/ZjtY9Tmke+s7NxA7V9SwD3ir92YQQ3Y+wBCqAF52y1KvDUlKtF6cKBPOBv
	 z9GXauStGrSHQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7B92E3782209;
	Thu, 11 Jul 2024 21:44:14 +0000 (UTC)
Date: Thu, 11 Jul 2024 17:44:12 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernelci@lists.linux.dev
Subject: Re: [PATCH v2 0/3] kselftest: Add test to report device log errors
Message-ID: <1417b57a-ac0b-4e8c-b157-bbe9ebb14e57@notapiano>
References: <20240705-dev-err-log-selftest-v2-0-163b9cd7b3c1@collabora.com>
 <2024071003-islamist-expediter-a22c@gregkh>
 <71c479fb-cd25-45ec-8dd3-0521ef951f58@linuxfoundation.org>
 <e1e32c72-6bd3-4c15-b301-c5670690ba99@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1e32c72-6bd3-4c15-b301-c5670690ba99@linuxfoundation.org>

On Thu, Jul 11, 2024 at 01:53:37PM -0600, Shuah Khan wrote:
> On 7/10/24 15:49, Shuah Khan wrote:
> > On 7/10/24 07:11, Greg Kroah-Hartman wrote:
> > > On Fri, Jul 05, 2024 at 07:29:53PM -0400, Nícolas F. R. A. Prado wrote:
> > > > Log errors are the most widely used mechanism for reporting issues in
> > > > the kernel. When an error is logged using the device helpers, eg
> > > > dev_err(), it gets metadata attached that identifies the subsystem and
> > > > device where the message is coming from. This series makes use of that
> > > > metadata in a new test to report which devices logged errors.
> > > > 
> > > > The first two patches move a test and a helper script to keep things
> > > > organized before this new test is added in the third patch.
> > > > 
> > > > It is expected that there might be many false-positive error messages
> > > > throughout the drivers code which will be reported by this test. By
> > > > having this test in the first place and working through the results we
> > > > can address those occurrences by adjusting the loglevel of the messages
> > > > that turn out to not be real errors that require the user's attention.
> > > > It will also motivate additional error messages to be introduced in the
> > > > code to detect real errors where they turn out to be missing, since
> > > > it will be possible to detect said issues automatically.
> > > > 
> > > > As an example, below you can see the test result for
> > > > mt8192-asurada-spherion. The single standing issue has been investigated
> > > > and will be addressed in an EC firmware update [1]:
> > > > 
> > > > TAP version 13
> > > > 1..1
> > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > >   power_supply sbs-8-000b: driver failed to report `model_name' property: -6
> > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > >   power_supply sbs-8-000b: driver failed to report `energy_full_design' property: -6
> > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > >   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> > > > not ok 1 +power_supply:sbs-8-000b
> > > >   Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
> > > > 
> > > > [1] https://lore.kernel.org/all/cf4d8131-4b63-4c7a-9f27-5a0847c656c4@notapiano
> > > > 
> > > > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > > 
> > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > Is this dependent on a linux-next?
> > 
> > Didn't apply to linux-kselftest next.
> > 
> 
> I tried applying these on top of linux-kselftest next which is at
> Linux 6.10-rc7 + other patches.
> 
> I am not sure what is wrong - first patch applies and the second
> and third don't.
> 
> git am fails and manual patch application worked for 2/3, same thing
> with 3.3 - these should apply cleanly since they don't have obvious
> conflicts.
> 
> Please clean this up and send me updated series adding Greg's ack.

Oh, now I see what happened. I recently sent another series that touches the
same file (tools/testing/selftests/devices/test_discoverable_devices.py):
"kselftest: devices: Allow running test on more platforms"
https://lore.kernel.org/all/20240613-kselftest-discoverable-probe-mt8195-kci-v1-1-7b396a9b032d@collabora.com/

That was already merged through the usb tree, and is present on next (on which I
based this series).

In this case I imagine it's best if this series gets picked through the usb
tree, right? Even if I rebase on kselftest's next, there will be conflicts.

Thanks,
Nícolas

