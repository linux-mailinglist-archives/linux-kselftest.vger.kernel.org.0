Return-Path: <linux-kselftest+bounces-10417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5438C98C8
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 07:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81FC4B215F9
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 05:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26C9134D1;
	Mon, 20 May 2024 05:28:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EA4101C4;
	Mon, 20 May 2024 05:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716182899; cv=none; b=ag8xasmn9IrChwfECFyqd4SrtrVyxkB752H9VzV93FM95MJRiV+mtul5TVwR8nBTE4/1ks889Zq0Dtg7L5yKWX2UiXNPgBDAMC9R+47bo8k6YquvyjNK8T5OgxeixVrb8r4qkZ/cpyZ/YYRO1CRJRTLQ6kMpu8+AK9c5IGqrKls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716182899; c=relaxed/simple;
	bh=6gM/vwsTnExUAhnt7VJkvcI5yziT0rLqYSZpv5r7v4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJJkV6EQIJeMI9FZAyqY/GwieqYyuSCiePDLXWe9GarOnVCW/sfiUbeaJPkSo+5zhd/iuvfc2liGtkK5WVjNdSqbEyIPpmf50wuKLHEBlMB+1PppHCgRUnOnBz3TnsUjuwwXQL0Kox9XQAd2fdn+HdOUm/n/44dzoj6rJaBHil0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEF64FEC;
	Sun, 19 May 2024 22:28:39 -0700 (PDT)
Received: from [10.162.40.20] (e116581.arm.com [10.162.40.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBE7B3F641;
	Sun, 19 May 2024 22:28:12 -0700 (PDT)
Message-ID: <93c1392e-47c3-41e2-b6cf-c41166bdab78@arm.com>
Date: Mon, 20 May 2024 10:58:05 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/mm: compaction_test: Fix incorrect write of
 zero to nr_hugepages
To: Andrew Morton <akpm@linux-foundation.org>
Cc: shuah@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Anshuman.Khandual@arm.com,
 sjayaram@akamai.com, stable@vger.kernel.org
References: <20240515093633.54814-1-dev.jain@arm.com>
 <20240515093633.54814-2-dev.jain@arm.com>
 <20240519170024.c2e62a7b69b00bb30e86a157@linux-foundation.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20240519170024.c2e62a7b69b00bb30e86a157@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/20/24 05:30, Andrew Morton wrote:
> On Wed, 15 May 2024 15:06:32 +0530 Dev Jain <dev.jain@arm.com> wrote:
>
>> nr_hugepages is not set to zero because the file offset has not been reset
>> after read(). Fix that using lseek().
>>
> Please fully describe the runtime effects of this bug.


This is not a "bug", but a discrepancy; the following comment

by the author says "Start with the initial condition of 0 huge

pages", I am just ensuring that that is actually done. Although,

I am not sure about the utility of doing this in the first place,

since we are anyways trying to increase hugepages after that.

In the second patch, I have moved away this entire logic of

setting nr_hugepages to zero, to the place before we start

filling up memory; if you feel that this patch is unnecessary,

we may squash it.


