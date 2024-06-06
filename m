Return-Path: <linux-kselftest+bounces-11287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E2A8FE3A0
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 11:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D672C1C23EEF
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 09:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE1917F514;
	Thu,  6 Jun 2024 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rzjM93lY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4F2154420;
	Thu,  6 Jun 2024 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667810; cv=none; b=sgCidtnSjq3ZXktRbK2iY2w0cV2/jP2tA1pSAj0EtpBo2iqewaa/XrqGqW5ad5fG0dYZOzJy0yMVooM5j/TeA3zDv4dWI7g6EP6JuQEpfMPXSyxONzYmVtHfUr9tR9yurjnRHnb/uKZWCfXKl6+iHwbcQ11/LSTgYa0NZVtduTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667810; c=relaxed/simple;
	bh=IDz1L0PKfLqZNIcrhz2otONEHo3lozBdAQRX9CEcmhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MuAt6TsysSjZDA4dhS0+WejbZ/QnshhwyDwNyPFRMn89bRJ7JcN3fr+UsJaLqwV2eemRrzCHmcs+0R0bY0RIgbnFjHk8Ju7gw0/d7Fh4/pTDP9Qx2m/HGWgCM5zoPnSQhE8JrZhMK4BQKUALYjuyBf4HE4jT/WufjGz4JzDN+sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rzjM93lY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717667807;
	bh=IDz1L0PKfLqZNIcrhz2otONEHo3lozBdAQRX9CEcmhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rzjM93lYsG5EU+imnJ+kxDvsyS2JbHpYkO1uBxRiQ0QrwmEGugUMGFkodpfrFRMxw
	 uwMX1VVBn8al/FGV4OCyDDIk0BbvOBcUYvu7JaoQ2Fq87dZFQf1ZUyF4GmPFq5pfnJ
	 a2vMPPXypVMrr/W4q9diBFC/p8m1TAdkSU21BAYaR9okHcQMmToIVQJ11Io4bH+7FB
	 6EovL7LNN9FGGvjweITfZN8smn5Ua9Go2Rj+MisIeOJMhOx8EuOSabp4PE/PTh1UBz
	 17HWKmAJ1UX2ySO2muu52XoeAxRB5eG8syl8bHGrrVmxnn1S4IEUcoDqHk+WOYj2AU
	 TLYPxqdOOiSag==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E51673780C13;
	Thu,  6 Jun 2024 09:56:46 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: laura.nao@collabora.com
Cc: kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH 0/2] Modify the watchdog selftest for execution with
Date: Thu,  6 Jun 2024 11:57:14 +0200
Message-Id: <20240606095714.397658-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240506111359.224579-1-laura.nao@collabora.com>
References: <20240506111359.224579-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shuah,

On 5/6/24 13:13, Laura Nao wrote:
> The watchdog selftest script supports various parameters for testing
> different IOCTLs. The watchdog ping functionality is validated by
> starting
> a loop where the watchdog device is periodically pet, which can only
> be
> stopped by the user interrupting the script.
> 
> This results in a timeout when running this test using the kselftest
> runner
> with no non-oneshot parameters (or no parameters at all):
> 
>   TAP version 13
>   1..1
>   # timeout set to 45
>   # selftests: watchdog: watchdog-test
>   # Watchdog Ticking Away!
>   # .............................................#
>   not ok 1 selftests: watchdog: watchdog-test # TIMEOUT 45 seconds
> 
> To address this issue, the first patch in this series limits the loop
> to 5
> iterations by default and adds support for a new '-c' option to
> customize
> the number of pings as required.
> 
> The second patch conforms the test output to the KTAP format.
> 

Gentle ping - any thoughts on this series? It would simplify running the
watchdog kselftest in CI environments by leveraging the runner.

Thanks!

Laura

