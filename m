Return-Path: <linux-kselftest+bounces-11753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8FC905004
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 12:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E17282F16
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 10:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C46116E874;
	Wed, 12 Jun 2024 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OFvsLr87"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9633416E869;
	Wed, 12 Jun 2024 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718186827; cv=none; b=Lv3pTX00XV3rDblw505T8x6HCZHnpsRoIaSpXyFS2OyGVsDuKwALiLDGMrsRjhruFfLAzqtfjpiOoGdyhsybiN5vmgeHWY+9rJ6+LBcWH1LO5bInFfqAlBiPEFVk7s+Ax+aEyQVDWPtMAQX7HAuyIJh1KdR0R6atGy2LznWn03s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718186827; c=relaxed/simple;
	bh=X/C2WqCcPHscguVgaI/7U9QXjrr1tO8TEK9q3Vlnxgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tb+J4kztVkk4dQbMqNIwdansBIH29dX1vVSXYFL0sl/oaMx0qd0yraOmKapzEHB/CJmQwTK3Q/BMdWKFgedtS9ObwqX+oF75nl7zIzP8JOGGW3JUuDRppzW7XDp3nu4VXtv541yCJVV6HIjcxwvpFq2NZKMfcdQVQR5C91xYZvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OFvsLr87; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718186823;
	bh=X/C2WqCcPHscguVgaI/7U9QXjrr1tO8TEK9q3Vlnxgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OFvsLr874lYy7M8r62tSRG1Phh9L6X6TPJKovdXuTYTTftf9fwUfAl5xEHIDgh204
	 dthWmaxjrjAmvr+msJD45LdFRp4x3cZQgK864ZLtFvXBO/aeK70LXLBH2N0HVHTMQ9
	 s+lvkMqCW934EUS10Bpo5KQVkjixQh/qfKoFLMUUUxWrhUd//bxi32DMx2KPJS3v/v
	 uVKTpEDxjLP4FcUBtPRDesSnpakZ8zWNyPbWlcAHVocJLzTySDqs6/UwLPoWND6sZp
	 3lwvqCFJ0JrlGDMcyTZxJenxRflqEbis+ySEqpaFFDHbmBxQ1tHraMfARiw0XNTvX6
	 LOCNs9JQ/C+Uw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D5F8E3780EC6;
	Wed, 12 Jun 2024 10:07:02 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: laura.nao@collabora.com
Cc: Tim.Bird@sony.com,
	broonie@kernel.org,
	dan.carpenter@linaro.org,
	davidgow@google.com,
	dianders@chromium.org,
	groeck@chromium.org,
	kernel@collabora.com,
	kernelci@lists.linux.dev,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	rafael@kernel.org,
	robh+dt@kernel.org,
	saravanak@google.com,
	shuah@kernel.org
Subject: Re: [RFC PATCH v2 0/2] Add a test to verify device probing on ACPI platforms
Date: Wed, 12 Jun 2024 12:07:36 +0200
Message-Id: <20240612100736.149752-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240308144933.337107-1-laura.nao@collabora.com>
References: <20240308144933.337107-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shuah and Rafael,

On 3/8/24 15:49, Laura Nao wrote:
> Hello,
> 
> This v2 addresses some issues observed when running the ACPI probe
> kselftest proposed in v1[1] across various devices and improves the overall
> reliability of the test.
> 
> The acpi-extract-ids script has been improved to:
> - Parse both .c and .h files
> - Add an option to print only IDs matched by a driver (i.e. defined in an
> ACPI match tables or in lists of IDs provided by the drivers)
> 
> The test_unprobed_devices.sh script relies on sysfs information to
> determine if a device was successfully bound to a driver. Not all devices
> listed in /sys/devices are expected to have a driver folder, so the script
> has been adjusted to handle these cases and avoid generating false
> negatives.
> 
> The test_unprobed_devices.sh test script logic has been modified to:
> - Check the status attribute (when available) to exclusively test hardware
>    devices that are physically present, enabled and operational
> - Traverse only ACPI objects with a physical_node* link, to ensure testing
>    of correctly enumerated devices
> - Skip devices whose HID or CID are not matched by any driver, as
>    determined by the list generated through the acpi-extract-ids script
> - Skip devices with HID or CID listed in the ignored IDs list. This list
>    has been added to contain IDs of devices that don't require a driver or
>    cannot be represented as platform devices (e.g. ACPI container and module
>    devices).
> - Skip devices that are natively enumerated and don't need a driver, such
>    as certain PCI bridges
> - Skip devices unassigned to any subsystem, devices linked to other devices
>    and class devices
> 
> Some of the heuristics used by the script are suboptimal and might require
> adjustments over time. This kind of tests would greatly benefit from a
> dedicated interface that exposes information about devices expected to be
> matched by drivers and their probe status. Discussion regarding this matter
> was initiated in v1.
> 
> As of now, I have not identified a suitable method for exposing this
> information; I plan on submitting a separate RFC to propose some options
> and engage in discussion. Meanwhile, this v2 focuses on utilizing already
> available information to provide an ACPI equivalent of the existing DT
> kselftest [2].
> 
> Adding in CC the people involved in the discussion at Plumbers [3], feel
> free to add anyone that might be interested in this.
> 
> This series depends on:
> - https://lore.kernel.org/all/20240102141528.169947-1-laura.nao@collabora.com/T/#u
> - https://lore.kernel.org/all/20240131-ktap-sh-helpers-extend-v1-0-98ffb468712c@collabora.com/
> 
> Thanks,
> 
> Laura
> 
> [1] https://lore.kernel.org/all/20230925155806.1812249-2-laura.nao@collabora.com/T/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/dt
> [3] https://www.youtube.com/watch?v=oE73eVSyFXQ&t=9377s

Just wanted to gently check in on your thoughts regarding this series. 
We've conducted some initial testing with it in KernelCI and it's proven 
its worth by catching a driver probe regression [1] on some x86_64 
platforms.
Your feedback would be greatly appreciated.

Thanks!

Laura

[1] https://lore.kernel.org/all/20240530153727.843378-1-laura.nao@collabora.com/


