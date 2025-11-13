Return-Path: <linux-kselftest+bounces-45586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0F7C59F87
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 21:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A56234E03B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 20:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780783148C7;
	Thu, 13 Nov 2025 20:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q/k9OO3h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856F1313E29
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 20:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763065743; cv=none; b=bI1S2Ub92oubg0/oHixonsV4gRfBZmM5aIB/UZhwXchkKTY7+b3Uh6X8Tscq2Nrd7ydU/uDi76n3x7Hn3Qni0STN3PgnPXzLqxRpMXNOiZdSabsyuFQ3v2k10vrYurWQNhmBs2wP1QMnXgCqvD7JZPWaZWCDt7krgLOkR6zKU4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763065743; c=relaxed/simple;
	bh=SSS5iLLzHtKCpj66Sm0MuGrCLa7OzvoiLGm4IUcDPQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sMIRIRVZI+7R8S8opvWZyAmkzA7/SVXxCsXKF/g/Kj68J+sfK/BCx1D6VN8ftkPjsvZ5hOAdJBSOv42W3SdGx5/n86OZ6iLRabaiebwQLkVfxkS8xfpmgkcVLpCWSPP+rmFX7ytI7+y26VGGYWnFnKRJHYwUra9NWW/QzwaEXgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q/k9OO3h; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <90d5e140-b2a5-4e7e-addb-c4f75912526e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763065739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afgZLvoRPRdV/uLRfyJlQxQwB+pZpdtXmSYXDn8K350=;
	b=Q/k9OO3h2UzYaNYh9XPXo+5JV55ef6V28Qp/4OzYJUxeNlCMcvh/YfWaG6q0Q1eUWT67HO
	IXSnJ+qalmjNfrhf3lDEdD+uK9jCdBWesmteXEmVvDYkQ20UUdyFtcjOVfL6aGWg4O1Mxi
	LozeCODbc6HMeh2lP+4beKkZQu3jd4M=
Date: Thu, 13 Nov 2025 12:28:48 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v9 1/9] kho: make debugfs interface optional
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, akpm@linux-foundation.org,
 brauner@kernel.org, corbet@lwn.net, graf@amazon.com, jgg@ziepe.ca,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, masahiroy@kernel.org, ojeda@kernel.org,
 rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
 <20251101142325.1326536-2-pasha.tatashin@soleen.com>
 <d7651272-f979-4972-ae41-bab2faa8473a@linux.dev>
 <CA+CK2bDSvtuwrrXGOC07Rj42yGFHWR4Sse7Q5z1z8f1ZFHWQ2Q@mail.gmail.com>
 <CA+CK2bC_+repP-q183hjAuYYB2-Yx7fr_U3zr2cxysAWx5hzpg@mail.gmail.com>
 <029090cf-9a4d-4f79-b857-04c3ada83323@linux.dev>
 <CA+CK2bByYPJXSNOh6R3swqFrGsS02m3Dfh=ZU7YhNjNX6siyqg@mail.gmail.com>
 <442fa82e-16ef-4bde-84eb-743450222468@linux.dev>
 <mafs0qzu69gei.fsf@kernel.org>
 <CA+CK2bBEe16x0em1gRxQD3jhfV9t3QA2vx5ifk2pKb_WEoMTeg@mail.gmail.com>
 <0735e1ef-2b65-4a54-b4d5-964fb875cd09@linux.dev>
 <CA+CK2bBnnGyQ-N8-XS3W3tnSRwvFbstOdo0oDSdkF70KP1AVxw@mail.gmail.com>
 <9e144e21-a5e7-4c12-b8b0-07172787ab37@linux.dev>
 <CA+CK2bBQxB7ihmhBa76vJbdD988B+8PBrV4arDSNqjv_VB4DVw@mail.gmail.com>
 <CA+CK2bCUN6SH7x=DnTFvCgEYGKoyOrCMzwQjHCY0LK35Hd-_zA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <CA+CK2bCUN6SH7x=DnTFvCgEYGKoyOrCMzwQjHCY0LK35Hd-_zA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/13/25 12:13 PM, Pasha Tatashin wrote:
> On Thu, Nov 13, 2025 at 3:10 PM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
>>>    set -e
>>>
>>> -kexec -l -s --reuse-cmdline /boot/bzImage
>>> +kexec -l -s --reuse-cmdline /boot/bzImage --initrd
>>> /boot/initramfs-`uname -r`.img
>> Thank you for your suggestion, in the next version, I am going to add
>> initramfs optionally, I am thinking to update script to something like
> Optionally, because in some environments (like in mine), it is built
> into bzImage.

In my test hosts, the bzImage is vmlinuz-xxx. But with the help of "ln 
-sf ... ...",

this change can work well in my test environments, including x86_64 and 
arm64 hosts.

Br,

Yanjun.Zhu

>
>> this:
>>
>> #!/bin/sh
>> # SPDX-License-Identifier: GPL-2.0
>> set -e
>>
>> # Use $KERNEL and $INITRAMFS to pass custom Kernel and optional initramfs
>>
>> KERNEL="${KERNEL:-/boot/bzImage}"
>> set -- -l -s --reuse-cmdline "$KERNEL"
>>
>> INITRAMFS="${INITRAMFS:-/boot/initramfs}"
>> if [ -f "$INITRAMFS" ]; then
>>      set -- "$@" --initrd="$INITRAMFS"
>> fi
>>
>> kexec "$@"
>> kexec -e

