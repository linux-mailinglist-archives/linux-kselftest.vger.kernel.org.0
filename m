Return-Path: <linux-kselftest+bounces-6938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CBE8939C4
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 11:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656FA28247F
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 09:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A95C10A09;
	Mon,  1 Apr 2024 09:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FpSh5jv+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0003F10965;
	Mon,  1 Apr 2024 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711965017; cv=none; b=abBr/9lOtXstroMEP52oMK26YUwZEszYjDQz8YWfVojYi3SLBwdrhVhnLPhD5CfwDgBsptfDkTnY4u2uGh+jN1WXm4dGULeeZDgOcfUIiIR3gVBbmkg3djTZCHyBv0q3jgPMj/FxW1+AlxovYmyf04JQJd2MwS0e+CfjnSKLGs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711965017; c=relaxed/simple;
	bh=7ysw4ufqTXNT3dIoSjrzTxCpKtjVoVAcMuNW6UXWP+M=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q+7nmIYMDckyBTNNAvBNkaoHivvwN+gYwTk76TR9KXmN4oN1PxDn2LPizl6ywY4ymf4ZlInUVbKeXswxP6Fw4XzX4J1VOz6fDWcaN1x0Ao2ybn6y78IIcstbqfq7vZEuge1VrDJCUJONZwNcj3ld+Fk0x6yVICiY20X3kM5MtLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FpSh5jv+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711965014;
	bh=7ysw4ufqTXNT3dIoSjrzTxCpKtjVoVAcMuNW6UXWP+M=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=FpSh5jv+L0Z9PLapdkN4Gx01Y2IlfRjhwCxGvkepetDwug8NV39krbt1CuU3Pgjbq
	 bGjSURTa8wmqPbxCscLDQ6gQiNqjeQ5/OOqZKCSdk7qHwhnZH/i1LsyT3zmCCueRhh
	 fpxCGkcSK2n5Mx9FUD9w4MAOeMIkETFMZ04vKDD2RATvpio3GPP9Mj/BrQSdBq+TmY
	 Aw+Celgabdcjs09bVOiKwIjYNc/bxv12AeMmAJIZ5Qp+rY7C91gb3ly9ktX2BX2zvf
	 rc4F6qfVCI/5kIADtlPc9FTxJATOP56ZvrKO7QfEDY2ju9esvWPWBPta9JfON9fMOf
	 Nr5OYy+UcMATg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A6BAD378148F;
	Mon,  1 Apr 2024 09:50:08 +0000 (UTC)
Message-ID: <30e88cb0-e31d-4cdb-bfd8-4559854937d1@collabora.com>
Date: Mon, 1 Apr 2024 14:50:29 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, linux-mm@kvack.org, llvm@lists.linux.dev
Subject: Re: [PATCH] selftests/mm: import strings.h for ffsl
To: Edward Liaw <edliaw@google.com>
References: <20240329174236.2278217-1-edliaw@google.com>
 <909806c1-a9c4-4f51-a807-46075efb8ab9@collabora.com>
 <CAG4es9UYvT5tRPFtsRUqJnz9obLuAz03b0+61aAagmGjGTMnsA@mail.gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CAG4es9UYvT5tRPFtsRUqJnz9obLuAz03b0+61aAagmGjGTMnsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/30/24 1:33 AM, Edward Liaw wrote:
> On Fri, Mar 29, 2024 at 12:32 PM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> On 3/29/24 10:42 PM, Edward Liaw wrote:
>>> Got a compilation error for ffsl after 91b80cc5b39f ("selftests: mm: fix
>>> map_hugetlb failure on 64K page size systems") imported vm_util.h.
>>>
>>> Fixes: af605d26a8f2 ("selftests/mm: merge util.h into vm_util.h")
>> Why do you think this Fixes tag is needed? This refers to a patch which is
>> just moving code. It doesn't seem to have any thing related to strings.h.
> Oops, I guess it should be:
> 
> Fixes: 6f6a841fb77d ("selftest/vm: add helpers to detect PAGE_SIZE and
> PAGE_SHIFT")
LGTM

> 

-- 
BR,
Muhammad Usama Anjum

