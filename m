Return-Path: <linux-kselftest+bounces-2560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8CC821C4A
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 14:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1E51F2277E
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 13:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C945EF9E0;
	Tue,  2 Jan 2024 13:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SjMzrZ3X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D873F9DA;
	Tue,  2 Jan 2024 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704201160;
	bh=jURNCYzIQMWJUFkXTyaEOnK3LZ2MAWqvj/wPwq9Ok3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SjMzrZ3X9QwRg2hEYy796StNOVaXo5RbVzE4knGw2jEvBc3ksAZha66xtVpcWDMzQ
	 vMxVT6gNCZQ7Y5VG3KeZVu3BxS0ABul3frAqcdARUtr6rfuExuIl0GTVbOQobSM4o4
	 swXwOxcW7T1cIUrPGzFq0HBvcGX6Nd2i7azvH0caKFkwp3EnYb4f+4p+JSLH8sEb3X
	 JDWlZH3Mcz3s3FH1H7XqAMmtixFp8pDSPsFRsze/HDKa7NMZuaWIZMskiK8Yl55jW3
	 A/Z0OzH10h9swPRRkGS99rfx4APvzRS3gNe7n5pq0QeYOi6kR8j9dFyH2NLTbnJ8a/
	 HPcusGofkyZpQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7025C378047E;
	Tue,  2 Jan 2024 13:12:34 +0000 (UTC)
Date: Tue, 2 Jan 2024 10:12:01 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, kernelci@lists.linux.dev,
	kernel@collabora.com, Tim Bird <Tim.Bird@sony.com>,
	linux-pci@vger.kernel.org, David Gow <davidgow@google.com>,
	linux-kselftest@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Doug Anderson <dianders@chromium.org>, linux-usb@vger.kernel.org,
	Saravana Kannan <saravanak@google.com>,
	Guenter Roeck <groeck@chromium.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/3] Add test to verify probe of devices from
 discoverable busses
Message-ID: <fb89ae5c-f3ef-49de-b93c-da6c8b92b06c@notapiano>
References: <20231227123643.52348-1-nfraprado@collabora.com>
 <3271d300-74c9-4ef3-b993-a8ddeda6076c@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3271d300-74c9-4ef3-b993-a8ddeda6076c@suswa.mountain>

On Tue, Jan 02, 2024 at 10:45:59AM +0300, Dan Carpenter wrote:
> Life hack: Don't put RFC in the subject.  Especially if it's a v2 or
> higher.  No one reads RFC patches.

Thanks for the tip. I've had a mixed experience with RFC series in the past,
though this time around I did get some feedback on the previous versions so I
can't complain. And I wasn't expecting swift replies in the middle of the
holidays :). In any case, this should be the last RFC version as I feel like the
approach has consolidated by now.

> 
> This patchset seems like a low risk patch to apply.

That's an interesting take on the usage of RFC I hadn't considered.

Thanks,
Nícolas

