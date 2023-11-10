Return-Path: <linux-kselftest+bounces-8-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BF97E82C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Nov 2023 20:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107AD2814F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Nov 2023 19:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D743B2B5;
	Fri, 10 Nov 2023 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QWIAULOH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0783B28F;
	Fri, 10 Nov 2023 19:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15FFC433CA;
	Fri, 10 Nov 2023 19:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1699644910;
	bh=a8twNFEKjGrKBxbdq191jaAma5+5cbZZWFE+Q6SHfO4=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=QWIAULOHfuC4ewTV3HG2pnrPYVTcQmHYctffbQR65o8lGEafhP0RAYM3fCRSz3VWw
	 j3ZPD3GePpQS36hL6HkQa1TKqTCL/mCNrYH3Lj3P6TSLxNDktFoc/fMvZzWXnn4RGa
	 MsHKSj90uf6JkRds+DIZYTZqnsoLyFU3BriaM6sE=
Date: Fri, 10 Nov 2023 14:35:09 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-embedded@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-fpga@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-gcc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-hotplug@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-ia64@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-m68k@vger.kernel.org, linux-man@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-msdos@vger.kernel.org
Subject: Re: PSA: This list is being migrated (no action required)
Message-ID: <3dfzeofvzxqk4yuyoancdanbxzpw5udmvbdz3b2mdwejwbnhk2@7y56nwlj3rgp>
References: <cfriwrxovqzcrptf74ccq52lcqj2nsergucufsz6wlh45fdnz3@z5e5y2lowbq2>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cfriwrxovqzcrptf74ccq52lcqj2nsergucufsz6wlh45fdnz3@z5e5y2lowbq2>

On Fri, Nov 10, 2023 at 01:51:44PM -0500, Konstantin Ryabitsev wrote:
> This list is being migrated to new vger infrastructure. No action is required
> on your part and there will be no change in how you interact with this list
> after the migration is completed.
> 
> There will be a short 30-minute delay to the list archives on lore.kernel.org.
> Once the backend work is done, I will follow up with another message.

This work is completed now. This message acts as a test to make sure archives
are working at their new place.

If anything is not working or looking right, please reach out to
helpdesk@kernel.org.

-K

