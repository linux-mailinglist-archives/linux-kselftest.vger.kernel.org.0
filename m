Return-Path: <linux-kselftest+bounces-705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A80F7FBD0B
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 15:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BCA11C20B20
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 14:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E655AB86;
	Tue, 28 Nov 2023 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YM44BhIk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775D88E;
	Tue, 28 Nov 2023 06:44:51 -0800 (PST)
Received: from notapiano (cola.collaboradmins.com [IPv6:2a01:4f8:1c1c:5717::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 8FC1F66072A7;
	Tue, 28 Nov 2023 14:44:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1701182690;
	bh=Og082W+PSa4+5mTtMkeABO/eaXozRb0GXaqspZ1T4tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YM44BhIk4AoBxZhrTRTnU7Agoo7aoXPbUC+kkVuglrVw1oxHaC3sN8xCREdcJsw06
	 nkr38YpWD1IqnnPUZg0U1xrL42f2YkAagOaXzZbmapAdkdOOKx72TS7W6/NKBrQdGi
	 pSdVYBGbsAOUQmzKiYu686WEzswrT9EmB4QGR734x0tqIM5IVwVMJkIlN9wWe8M1Zf
	 QUEA1zCVt8AMmHKT4XbcFIJlEqyaQI+ygZlTOWLpatmlemGPx8hz/ZtFkBWT4zx/FP
	 k+trbQUknlfB3LDKn9G2JLuIf7r5XxE8bJy3BSPLEmHviNzpgOMQZ1rYkKOJOV5FUA
	 SSysqpsfwHfrA==
Date: Tue, 28 Nov 2023 09:43:53 -0500
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: "Bird, Tim" <Tim.Bird@sony.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	"kernelci@lists.linux.dev" <kernelci@lists.linux.dev>,
	David Gow <davidgow@google.com>,
	Guenter Roeck <groeck@chromium.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"kernel@collabora.com" <kernel@collabora.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 2/2] kselftest: devices: Add sample board file for
 google,spherion
Message-ID: <ee913bc5-c752-4da7-a140-7492f429c2cb@notapiano>
References: <20231127233558.868365-1-nfraprado@collabora.com>
 <20231127233558.868365-3-nfraprado@collabora.com>
 <BN8PR13MB27384F089C7DAAF06DF9DDECFDBCA@BN8PR13MB2738.namprd13.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN8PR13MB27384F089C7DAAF06DF9DDECFDBCA@BN8PR13MB2738.namprd13.prod.outlook.com>

On Tue, Nov 28, 2023 at 12:10:46AM +0000, Bird, Tim wrote:
> > -----Original Message-----
> > From: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > Add a sample board file describing the file's format and with the list
> > of devices expected to be probed on the google,spherion machine as an
> > example.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> > 
> > (no changes since v1)
> > 
> >  .../testing/selftests/devices/boards/google,spherion | 12 ++++++++++++
> 
> Overall, while trying to maintain a comprehensive set of board definitions
> seems hard, I think having a few as examples is useful.
> 
> I'm not a big fan of naming these with a comma in the name.  Is there a reason
> you are not using dash or underscore?

I'm using the name that we get from the DT compatible, so the right file can be
automatically selected by the test.

> 
> Do you anticipate a convention of  <producer> <board-or-product-name> tuples for
> the filename?

I'd just stick to the DT compatible as it's the simplest option and should work
just the same, assuming I understood correctly what you mean.

Thanks,
Nícolas

