Return-Path: <linux-kselftest+bounces-14681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4DB9453ED
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 23:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10DEA2828CB
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 21:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AB414A619;
	Thu,  1 Aug 2024 21:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XVAXJ8FE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5EE1EB4AF;
	Thu,  1 Aug 2024 21:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722546209; cv=none; b=Wonq9ZSFrEUg2lLv7nFR8iHxAN4gPED0UBjqProaewYwHVuBd+3UGRtv4r3//oGakgJ/lQPuHIC31jpSe6ilVo94WrdpirSWK6sPuFWUOTCHDq7osTswD+tTTN9bRDSLWx1oI0KJas41zwXc/cdx7dOZvbEAShxsYBEZrSin+JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722546209; c=relaxed/simple;
	bh=Oi0oRy/Osdft1qqB/pxrGodOVcD2DFW3S8FrDyVyAIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftZ9m+VumBdjvFtYK7AAdMHjSbnQk00X1C0yBYhEawBVlZi/FTrR8bxEKlQKoNUcgqkM7fitVDXMU2+uZgN2fR04y3FEKcNacT1baNtgG97c359JSueZuV9ewGMC4OPyMxJXmQcVjneJsarHnwT7fKyXt9LUq9S3Spz0fncdIVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XVAXJ8FE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722546206;
	bh=Oi0oRy/Osdft1qqB/pxrGodOVcD2DFW3S8FrDyVyAIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XVAXJ8FEhMKxDPGKQjKxnkI2p2lwkAlLZHkXJ/8S6ruJxKFsDlpeDlneAZs0Sgqzq
	 CKEPxmLJzS5j1O8uhHB7RXTRafNHLaoKt7FtMlERlbJOkfGOZfYQXFSoPqTxEMcd3y
	 ccIqXFvLWodE5jQHulYMYvj/Mw8ueZxnjKYs4onnvW5sBWjjj2JRLRhdPxYw5cEOSp
	 5+Zg5HBd5RsxLN0aqAyGUDdAqw9NN1eLIE0pd4Y1RREztMrncZiZC1ntOl7covVX5S
	 3eCCLtxsa5vHMJ6K6QqnNHsyV0SONtzxR0guFxmxa2PVN4asnUZYqAjaVf6/pdzISD
	 +IqQYTcUpy5gA==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 70342378220C;
	Thu,  1 Aug 2024 21:03:23 +0000 (UTC)
Date: Thu, 1 Aug 2024 17:03:21 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Bird, Tim" <Tim.Bird@sony.com>,
	Laura Nao <laura.nao@collabora.com>,
	Saravana Kannan <saravanak@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com, kernelci@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC] kselftest: devices: Add test to detect missing
 devices
Message-ID: <22688e55-b611-41b3-9bf0-06691454e3b1@notapiano>
References: <20240724-kselftest-dev-exist-v1-1-9bc21aa761b5@collabora.com>
 <9d0b73ce-704c-4633-bb11-06ca4cb7a9a1@linuxfoundation.org>
 <f9a457c8-f558-4c45-96e0-baa97d143c7b@notapiano>
 <41a912af-4f59-4d54-a072-3de9ee912dee@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41a912af-4f59-4d54-a072-3de9ee912dee@linuxfoundation.org>

On Thu, Aug 01, 2024 at 02:13:05PM -0600, Shuah Khan wrote:
> On 8/1/24 13:15, Nícolas F. R. A. Prado wrote:
> > On Wed, Jul 31, 2024 at 05:19:45PM -0600, Shuah Khan wrote:
> > > On 7/24/24 15:40, Nícolas F. R. A. Prado wrote:
> > > > Introduce a new test to identify regressions causing devices to go
> > > > missing on the system.
> > > > 
> > > > For each bus and class on the system the test checks the number of
> > > > devices present against a reference file, which needs to have been
> > > > generated by the program at a previous point on a known-good kernel, and
> > > > if there are missing devices they are reported.
> > > 
> > > Can you elaborate on how to generate reference file? It isn't clear.
> > 
> > Indeed, I'll make that information clearer in future versions.
> > 
> > The reference file is generated by passing the --generate-reference flag to the
> > test:
> > 
> > ./exist.py --generate-reference
> > 
> > It will be printed as standard output.
> 
> How about adding an option to generate file taking filename?
> Makes it easier to use.

Sure, we can do that. Another option would be to write it to the filename that
would be looked for by default. So for your machine just calling

  ./exist.py --generate-reference

could write the reference to ./LENOVO,20XH005JUS.yaml.

> 
> > 
> > > 
> > > > 
> > > > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > > > ---
> > > > Hi,
> > > > 
> > > > Key points about this test:
> > > > * Goal: Identify regressions causing devices to go missing on the system
> > > > * Focus:
> > > >     * Ease of maintenance: the reference file is generated programatically
> > > >     * Minimum of false-positives: the script makes as few assumptions as possible
> > > >       about the stability of device identifiers to ensure renames/refactors don't
> > > >       trigger false-positives
> > > > * How it works: For each bus and class on the system the test checks the number
> > > >     of devices present against a reference file, which needs to have been
> > > >     generated by the program at a previous point on a known-good kernel, and if
> > > >     there are missing devices they are reported.
> > > > * Comparison to other tests: It might be possible(*) to replace the discoverable
> > > >     devices test [1] with this. The benefits of this test is that it's easier
> > > >     to setup and maintain and has wider coverage of devices.
> > > > 
> > > > Additional detail:
> > > > * Having more devices on the running system than the reference does not cause a
> > > >     failure, but a warning is printed in that case to suggest that the reference
> > > >     be updated.
> > > > * Missing devices are detected per bus/class based on the number of devices.
> > > >     When the test fails, the known metadata for each of the expected and detected
> > > >     devices is printed and some simple similitarity comparison is done to suggest
> > > >     the devices that are the most likely to be missing.
> > > > * The proposed place to store the generated reference files is the
> > > >     'platform-test-parameters' repository in KernelCI [2].
> > > 
> > > How would a user run this on their systems - do they need to access
> > > this repository in KernelCI?
> > 
> > No, that repository would just be a place where people could find pre-generated
> > reference files (which we'll be using when running this test in KernelCI), but
> > anyone can always generate their own reference files and store them wherever
> > they want.
> > 
> 
> Thanks for the clarification. This might be good addition to the document.
> I think this test could benefit from a README or howto

Sure, I can add a README in the next revision.

> 
> > > 
> > > This is what I see when I run the test on my system:
> > > 
> > > make -C tools/testing/selftests/devices/exist/ run_tests
> > > make: Entering directory '/linux/linux_6.11/tools/testing/selftests/devices/exist'
> > > TAP version 13
> > > 1..1
> > > # timeout set to 45
> > > # selftests: devices/exist: exist.py
> > > # TAP version 13
> > > # # No matching reference file found (tried './LENOVO,20XH005JUS.yaml')
> > 
> > First generate the reference file for your system like so:
> > 
> > tools/testing/selftests/devices/exist/exist.py --generate-reference > tools/testing/selftests/devices/exist/LENOVO,20XH005JUS.yaml
> > 
> 
> Worked - I see
> 
> TAP version 13
> # Using reference file: ./LENOVO,20XH005JUS.yaml
> 1..76
> 
> ---
> # Totals: pass:76 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> 
> Things to improve:
> 
> - Have the script take a file instead of assuming that the reference file
>   is in the current directory.
>   e.g: exist.py -f reference_file

The script also has another parameter to specify a different directory to look
for the reference file: --reference-dir

But the file name is currently fixed and determined from the system's ID (DMI or
Devicetree compatible).

We can definitely have another flag to force a different file name if that's
useful. In theory it shouldn't be needed given the machine name is used as
filename, but might come in handy if there are machine name clashes or if you
want to have references for different kernel stable versions for the same
machine in the same directory.

Thanks,
Nícolas

