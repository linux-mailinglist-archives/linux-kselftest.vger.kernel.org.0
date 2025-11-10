Return-Path: <linux-kselftest+bounces-45211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5E9C45894
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 10:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CEB16347616
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 09:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFFC2FE59A;
	Mon, 10 Nov 2025 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cptu4PoA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C7B2FE58F;
	Mon, 10 Nov 2025 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765835; cv=none; b=lm/v4vud/ZtXSDzjmsFkCoY1AQG1egZwxGurmcrGh2oY4tG4+aehTjJLjzFIwg607CSeomrta2GawlleGRjTjce+LTrgZ5MQFW0jKJnmI8nM/3fD4z90JqbXoGH0d1CAEY7VKXSI2Fu2cAlAlUvo9sI2U2ETkUxC69k5szWi47E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765835; c=relaxed/simple;
	bh=JaMbg32qNbhqE9b3hup1M5vDrFPhQ1dnIjspZzUhRNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6eeI3dJ/NRDLME29Q6w4Kgr+iC/b+39quTq9H5cb+eURcb5IZqWEXinwK78DYGkbyXhoO2t1jlKkQbvWSCoDVTSgbhOS05AiR639WaQIDf7jAJA5s6PnAbU55fdjZRwTz3erbd5IYNLeMD4O5/P3u1jvwfBVV5cDJkB5gJ6jWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cptu4PoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0ECC16AAE;
	Mon, 10 Nov 2025 09:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762765835;
	bh=JaMbg32qNbhqE9b3hup1M5vDrFPhQ1dnIjspZzUhRNI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cptu4PoAElCXw/Zsn0aH/kXbacdIMrfama9GATWjRk3szHMgRzqgqYav4DVAcYKAO
	 +Ai7kcqViE9GRpWGNvC77I7Cgu1Pxn97HPad9JS61bhTd0lVHmXzhRPxACQFybqExe
	 WBylyMYyK5QGkuXYpgVk3DxUUIPPNVZ1P8ZOegkgEJ1iS7yLmg3mGO4cc7iy9v2ONh
	 wROi4fErM1J3Uu//Eq81YktEHuLCdKMTkj9H/K8ZdGWsf02UBmP+lUFCLqIK6J41w/
	 Z75xh9pDdLCX79oDp0JuFkooPrJQ977rIFInPleKWGmRCChskTWEL/XWL/5pF1zggT
	 GK6F4Im+EGcqg==
Message-ID: <de1fcdb7-3597-4d4f-ae77-79f79f9d2268@kernel.org>
Date: Mon, 10 Nov 2025 10:10:30 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftest/mm: fix pointer comparison in mremap_test
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20251108161829.25105-1-ankitkhushwaha.linux@gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251108161829.25105-1-ankitkhushwaha.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.11.25 17:18, Ankit Khushwaha wrote:
> Pointer arthemitic with 'void * addr' and 'ulong dest_alignment'
> triggers following warning:
> 
> mremap_test.c:1035:31: warning: pointer comparison always evaluates to
> false [-Wtautological-compare]
>   1035 |                 if (addr + c.dest_alignment < addr) {
>        |                                             ^
> 
> this warning is raised from clang version 20.1.8 (Fedora 20.1.8-4.fc42).
> 
> use 'void *tmp_addr' to do the pointer arthemitic.
> 
> Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
> ---

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

