Return-Path: <linux-kselftest+bounces-480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699197F5EC6
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 13:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21631281C3F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 12:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E6A24201;
	Thu, 23 Nov 2023 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PoaVghDc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F706B2;
	Thu, 23 Nov 2023 04:09:34 -0800 (PST)
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 1AB2866073A6;
	Thu, 23 Nov 2023 12:09:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1700741373;
	bh=YgxjoufhsvGqDqaZ2rAtBAbV9cjW8P3dw29HVw8u0y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PoaVghDckL+d+hpKi62Z+OmLgjKqyQ7uJoVeV20xyXVmZ227HQCKD/v1hZLefB+Ph
	 wlPy5eIiPjgkYXd/W2YZZzFTHf+c3ihGYQN3QYCmDqxqfwS69khvdVi0DdvAQMxnMi
	 6/PDtfY5K6zdHmwbi0BFbZctgpstIBjiue9CS5K7nPW+BQaw6NKcF48qiH/PHGsW1g
	 mIZWlqwllvH7+CEUoYAcCFzoHeW+qhEgQ4dGcsifaswB3hMx1NeUVkylgwCg1yqnxX
	 tdI1H6dqdJ4MiT6+fHY6HKkRbeSdlaAr6PMQ4RKAgkySaMTCZ4JnMZK61yTRt5F/nq
	 5YbJOssjrklhw==
From: Laura Nao <laura.nao@collabora.com>
To: dan.carpenter@linaro.org
Cc: broonie@kernel.org,
	groeck@chromium.org,
	kernel@collabora.com,
	kernelci@lists.linux.dev,
	laura.nao@collabora.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	rafael@kernel.org,
	robh+dt@kernel.org,
	shuah@kernel.org
Subject: Re: [RFC PATCH 0/2] Add a test to verify device probing on ACPI platforms
Date: Thu, 23 Nov 2023 13:09:42 +0100
Message-Id: <20231123120942.33222-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <4f1283d4-1c50-4aba-ba54-b9ea975bf61d@moroto.mountain>
References: <4f1283d4-1c50-4aba-ba54-b9ea975bf61d@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Your talk was interesting at Linux Plumbers.
> 
> https://www.youtube.com/watch?v=oE73eVSyFXQ [time +2:35]
> 
> This is probably a stupid question, but why not just add something to
> call_driver_probe() which creates a sysfs directory tree with all the
> driver information?
> 

Thanks for the feedback! 

Improving the device driver model to publish driver and devices info was indeed another option we considered. We could have a debugfs entry storing this kind of information, similar to what devices_deferred does and in a standardized format. This would provide an interface that is easier to query at runtime for getting a list of devices that were probed correctly.
This would cover devices with a driver that's built into the kernel or as a module; in view of catching also those cases where a device is not probed because the relevant config is not enabled, I think we'd still need another way of building a list of devices present on the platform to be used as reference.

The solution proposed in this RFC follows the same approach used for dt
based platforms for simplicity. But if adding a new sysfs entry storing devices and driver info proves to be a viable option for upstream, we can surely explore it and improve the probe test to leverage that.

Best,

Laura

