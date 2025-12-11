Return-Path: <linux-kselftest+bounces-47408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9144DCB56B0
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 10:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B65A130084F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 09:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2170B2F6597;
	Thu, 11 Dec 2025 09:52:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4AA21423C;
	Thu, 11 Dec 2025 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765446747; cv=none; b=aky2UxSaEAHfqFN7S9X9SZnxnj1o1mKiactaAEI7U+oEg/bdhke4sacqzzpo49r9fwLUkNHF/RncXBGL3x3wOt/EtGB5D3Q3m8UTLQf0ajtUNuelFs7n9YKZONJlbGx+W9SWbAn+9yYqMiG7PGE0CBGhp6LRmblrWyaAT5qbXo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765446747; c=relaxed/simple;
	bh=ShyQdUrLPBAZ0jmMVP8BT9u1QAUAVpOqsZkPi86HuaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B8o7q6jSuWuRFhw3+FcVla3FvVgt4cSQIq6SH1XD2srvveO4GkNFzc7U6Gk9NWsW0fwDjsqbee/9bSYC65zudPqONWv/JdMXvA1KfMXqX21jDrdn+rFNRKWPQCbgDYGbqXSu5iOrAFKqwqr7dpCq6/w23QHX3K3XV9IWQloETuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49E78153B;
	Thu, 11 Dec 2025 01:52:17 -0800 (PST)
Received: from [10.57.46.84] (unknown [10.57.46.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA7A33F73B;
	Thu, 11 Dec 2025 01:52:17 -0800 (PST)
Message-ID: <e55e9aae-1d84-42a2-bf6a-edc73608733a@arm.com>
Date: Thu, 11 Dec 2025 10:52:11 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 15/16] entry: Inline syscall_exit_work()
To: Thomas Gleixner <tglx@linutronix.de>, Jinjie Ruan
 <ruanjinjie@huawei.com>, catalin.marinas@arm.com, will@kernel.org,
 oleg@redhat.com, peterz@infradead.org, luto@kernel.org, shuah@kernel.org,
 kees@kernel.org, wad@chromium.org, deller@gmx.de, macro@orcam.me.uk,
 charlie@rivosinc.com, ldv@strace.io, mark.rutland@arm.com, song@kernel.org,
 ryan.roberts@arm.com, ada.coupriediaz@arm.com, anshuman.khandual@arm.com,
 broonie@kernel.org, pengcan@kylinos.cn, dvyukov@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251204082123.2792067-1-ruanjinjie@huawei.com>
 <20251204082123.2792067-16-ruanjinjie@huawei.com>
 <b382cc8a-3ce9-4fb1-bc0a-a3d9796251d1@arm.com> <87345hfqyh.ffs@tglx>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <87345hfqyh.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/2025 07:55, Thomas Gleixner wrote:
> I have a suspicion that it is TIF_NOTIFY_RESUME. If that's the case
> you're seing the RSEQ overhead, which should be completely gone with the
> rewrite that got just merged into Linus tree.

I don't think this is related. This patch inlines syscall_exit_work(),
which is called if some flag in SYSCALL_WORK_EXIT is set. This includes
syscall-specific stuff like tracing and singlestep. TIF_NOTIFY_RESUME is
part of EXIT_TO_USER_MODE_WORK, handled in exit_to_user_mode_prepare(),
and isn't specific to syscall handling.

- Kevin

