Return-Path: <linux-kselftest+bounces-2518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BE181FF70
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Dec 2023 13:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4C51C22214
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Dec 2023 12:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A117C10A24;
	Fri, 29 Dec 2023 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="uoYinAw/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF57111A2;
	Fri, 29 Dec 2023 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703853276;
	bh=QwXYveaBC0ig2U8Y++IbF9SuqXAv85RwXyV1v2MqwYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uoYinAw/k9tO5Pzh9Q+ZvHcynf8ItzRqwE+/5fg+cDwTrDQCGqXX0COasXbkLau0l
	 SCFWZ0neUFGhBjrSTUg+6Gsv9lKfs3fGrO7ZIgOzuWL4skZ27vthnxVZb+IYgxyk+N
	 3XSNJWtusID5FirWwYQVjpo2FelXQ0TVkmicry6BbWZOg3xwa6ZS6/b4BJB00ZZeZf
	 JkodFGfrVfuhWEPetUT0Iwsi5nj/ndnsI6+5EOzh0xaOz+lU+0Z6HD9FN7srgr39vr
	 h9uJ0m0AnVmQPk3925HAf2D2tuZzzAVTCRG0K/RDt1SS4Jr/J4GU6EAxjnrz+ZnvTO
	 8pjBFHHYhk5Qg==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BE3BB3781472;
	Fri, 29 Dec 2023 12:34:30 +0000 (UTC)
Date: Fri, 29 Dec 2023 09:33:57 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, kernelci@lists.linux.dev,
	kernel@collabora.com, Tim Bird <Tim.Bird@sony.com>,
	linux-pci@vger.kernel.org, David Gow <davidgow@google.com>,
	linux-kselftest@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Doug Anderson <dianders@chromium.org>, linux-usb@vger.kernel.org,
	Saravana Kannan <saravanak@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Guenter Roeck <groeck@chromium.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/3] Add test to verify probe of devices from
 discoverable busses
Message-ID: <1d0ecab9-73a3-44e5-8d5b-f4d4cc5a3baf@notapiano>
References: <20231227123643.52348-1-nfraprado@collabora.com>
 <20231228235348.GA1559485@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231228235348.GA1559485@bhelgaas>

On Thu, Dec 28, 2023 at 05:53:48PM -0600, Bjorn Helgaas wrote:
> I have no opinion about the patches themselves, but just a heads-up
> that "busses" may be regarded as a misspelling of "buses", e.g.,
> https://lore.kernel.org/r/20231223184720.25645-1-tintinm2017@gmail.com,
> I'm guessing because codespell complains about it.
> 
> Git grep says there are almost as many instances of "busses" as
> "buses" in the kernel, so I don't go out of my way to change them.
> Just FYI, doesn't matter to me either way.

Thanks for the heads up. The online dictionaries seem to agree on "buses", so
I'll use that on the next version.

Thanks,
Nícolas

