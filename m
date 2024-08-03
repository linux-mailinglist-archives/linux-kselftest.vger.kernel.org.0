Return-Path: <linux-kselftest+bounces-14769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E4B946AD4
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 20:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1223A281A7F
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 18:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE6817BD2;
	Sat,  3 Aug 2024 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="kZXu81dV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF28A182C9;
	Sat,  3 Aug 2024 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722709593; cv=none; b=Z9XX0ZyQw1FYO0fmTvFHL4GcnqKSDuzKxON0f8w9ek63IOIhyYVbhnjX1yL6d1C1AhUnYfDPrj/9OPm8O9InnaxALwAMpbih3P6okOB/rlRC73PbBSnU2cCy2FgEV+NwO8K5Q8W/UTs9rfg/K0akSEMcTne6BFSd9FJFzDLzNyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722709593; c=relaxed/simple;
	bh=hbt2D6pyk4Lz3NftQfJRmv+WdxnpUpaq6TfJiRcZOsM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=l+q9vQ5bfnuRu7MpO+PXAQKQohTkK8QBzxH1aXgmbKyhOJrWwhjckF7Gji1mpJ+Uj6G0+UGDbS4FEiL8BGKN4pBf7DorJrQ9fJ0OcgCT55IcEHDPeqcq8nHGPesafcMWxZuHZf7bpzOIJ47pVWGHnW0WqWR/1A91nuoTEBuuG74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=kZXu81dV; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1722709589; bh=hbt2D6pyk4Lz3NftQfJRmv+WdxnpUpaq6TfJiRcZOsM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=kZXu81dVcab5c7tUPZcmRHJUNSYD2q1ZU04eCbG2tFhxJspN6uZDBUY+l5amLlJlm
	 ewWhQBb0Rx/9DdDMPo7f5Vk8GAYdEVb6TQuRuK8qV+n2pyltg2cfxdl8RBXLQGcZVh
	 j22AXT+mM79KjTiNVaMxQBTqn23Z8dsd2IUiwBRI=
Date: Sat, 3 Aug 2024 20:26:28 +0200 (GMT+02:00)
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To: Willy Tarreau <w@1wt.eu>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Message-ID: <73cb80fb-7807-49f2-bcd0-d7b1110bda2a@t-8ch.de>
In-Reply-To: <20240803092204.GA29127@1wt.eu>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net> <20240728-nolibc-llvm-v1-3-bc384269bc35@weissschuh.net> <20240803092204.GA29127@1wt.eu>
Subject: Re: [PATCH 03/12] tools/nolibc: move entrypoint specifics to
 compiler.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <73cb80fb-7807-49f2-bcd0-d7b1110bda2a@t-8ch.de>

Aug 3, 2024 11:22:23 Willy Tarreau <w@1wt.eu>:

> Hi Thomas,
>
> On Sun, Jul 28, 2024 at 12:09:57PM +0200, Thomas Wei=C3=9Fschuh wrote:
>> The specific attributes for the _start entrypoint are duplicated for
>> each architecture.
>> Deduplicate it into a dedicated #define into compiler.h.
>> This make the code shorter and will make it easier to adapt for clang
>> compatibility.
>>
>> For clang compatibility, the epilogue will also need to be adapted, so
>> move that one, too.
>
> I'm fine with the general approach, however I think that if we start to
> add specific attributes and macros like this, we should prefix them with
> "nolibc" to make sure they won't collide with userland.

Ack.

FYI for v2 I intend to rename the macros to
__nolibc_naked, as I have a followup series that needs
them also for the non-entrypoint asm functions in
arch-x86_64.

> Thanks,
> willy


