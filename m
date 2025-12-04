Return-Path: <linux-kselftest+bounces-46965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B48CA21F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 02:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D32C3024888
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 01:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FBC1C862E;
	Thu,  4 Dec 2025 01:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="m+qSPOz5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF4939FD9;
	Thu,  4 Dec 2025 01:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764812766; cv=none; b=G4dWorzuHjxF3Mz9hgJ8NK6Q5PBFIl8CaEvtC2fADE+rj+5gJUwe7QXGd8RjhdBCQyuU3Y2ojpHj2tJQ1ee6SGONMFIOkHo8qztvcuHf9/TeUtoXed/b1odG4gRV/Yh3a0sLTh8RQSrjMKtkhyz0CSeRwYiBe+JQUcDpL6dgM8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764812766; c=relaxed/simple;
	bh=Me/o6vXITmrakcjffEt+XLSkDwLMgGl2xAHdPx0o8lQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XwJOhT3WmaBLlsEz9DAukhLR/IU+0uMGPMzf7LASZtOeS0dOnxqL/6TMlG0Xwj1IYrhk3NYRkK+pQzyjy7ahRz6mUzaePXzmQsHoJR2c3aAdT8YNPwj/IERFLVzmf+Cs4c+xY3wYJ9QEN8fPI6C0SUaBiC4Snl5V7Rs/U1manx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=m+qSPOz5; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764812760; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=Me/o6vXITmrakcjffEt+XLSkDwLMgGl2xAHdPx0o8lQ=;
	b=m+qSPOz5Hg7K0pi2d3543nEUJyKM6Z60luHwgsNK/yPejEsBNmo9z0GTJNbDmD8orFOjMkr+i+GIW+0R9kSsvpaRYO35j6nykdlVNl8gJfCOXe3bqHLgNcpoP4TpwPJiNxGSo/2SgNAbhO/ODBIV/2hAAyQ5HgLj/rQSv/kQvZ4=
Received: from 30.178.67.88(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0Wu2E4EX_1764812759 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Dec 2025 09:46:00 +0800
Message-ID: <58c3a2ee-e805-4cf5-98a4-272573b770da@linux.alibaba.com>
Date: Thu, 4 Dec 2025 09:45:59 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] selftests: gpio: correctly check the type of
 /dev/gpiochipX
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bamvor Jian Zhang <bamv2005@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251127085540.21142-1-kanie@linux.alibaba.com>
In-Reply-To: <20251127085540.21142-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Friendly ping...

Best Regards,
Guixin Liu



