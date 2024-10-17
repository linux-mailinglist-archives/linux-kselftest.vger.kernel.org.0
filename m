Return-Path: <linux-kselftest+bounces-19951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4489A20AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 13:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0675A1F2780C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 11:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5AB1DB37B;
	Thu, 17 Oct 2024 11:09:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDF7259C;
	Thu, 17 Oct 2024 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729163348; cv=none; b=O2oGGXWmdFfeq2NO2RgCKdkNPiFa4eHFhKvplJmJWynrQTuKT5s5rTS25+aSW7q9denDaUNW5ZNvLZRmBfgjpAB+zTGg5SI81luP3eJ2dQ4ST7iMhRAsm9IMwkwW4st9ayIXBYrC+04pO2+Uml+lXVb2fCCP8aGn8cwrFDuFQ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729163348; c=relaxed/simple;
	bh=es5VI+t01hTn1NxUuVB7/G5rBeJKoKX3s/hZxFeB5Ic=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUucOTIISiwmzdS5gEleJ7WRtxpQF2M8myt2ydkH8W8njaDmQ5s7QEAnVB8lFbcQUrjiUQbL3ZXRfwoG49YmHrAIdJSupkPQAnHf3SfRZcIGOsFRaH7re7oWwqMBPgtysauU+XMjk+XtOqN/vLjyJ+eedvfOFfq2I/Oafg9OevY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTlSR1yC5z6K9DG;
	Thu, 17 Oct 2024 19:08:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5538C1400C9;
	Thu, 17 Oct 2024 19:09:03 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 13:09:02 +0200
Date: Thu, 17 Oct 2024 12:08:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Lorenzo
 Pieralisi" <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, "Maciej W. Rozycki"
	<macro@orcam.me.uk>, Lukas Wunner <lukas@wunner.de>, Alexandru Gagniuc
	<mr.nuke.me@gmail.com>, Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "Daniel
 Lezcano" <daniel.lezcano@linaro.org>, Amit Kucheria <amitk@kernel.org>, Zhang
 Rui <rui.zhang@intel.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v8 8/8] selftests/pcie_bwctrl: Create selftests
Message-ID: <20241017120859.00004713@Huawei.com>
In-Reply-To: <20241009095223.7093-9-ilpo.jarvinen@linux.intel.com>
References: <20241009095223.7093-1-ilpo.jarvinen@linux.intel.com>
	<20241009095223.7093-9-ilpo.jarvinen@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed,  9 Oct 2024 12:52:23 +0300
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Create selftests for PCIe BW control through the PCIe cooling device
> sysfs interface.
>=20
> First, the BW control selftest finds the PCIe Port to test with. By
> default, the PCIe Port with the highest Link Speed is selected but
> another PCIe Port can be provided with -d parameter.
>=20
> The actual test steps the cur_state of the cooling device one-by-one
> from max_state to what the cur_state was initially. The speed change
> is confirmed by observing the current_link_speed for the corresponding
> PCIe Port.
>=20
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

My bash is terrible, but as far as I can tell this looks reasonable.
So with that in mind take this with a pinch of salt.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


