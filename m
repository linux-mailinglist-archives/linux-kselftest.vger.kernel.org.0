Return-Path: <linux-kselftest+bounces-10686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED078CEDD7
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 06:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4EA1F216BC
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 04:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689FA2566;
	Sat, 25 May 2024 04:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FL8udP8G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ACBAD35;
	Sat, 25 May 2024 04:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716611279; cv=none; b=Yfv1kyXQJ+FHgYArRsUhrgd0B266GGnq8lG5HdoZ7jbpXgw0xVKrCtMnLNWfuYRkguEpuHttWduz9jEWaDf0VB/AX+qawhZBsTl875AiOpfoI6YQaeFs55GApBRJk4WFQORfDbZQNUS+h/A+d22ZqbZtwwY6RtHEoLhYgAnAAkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716611279; c=relaxed/simple;
	bh=Sso5+EVsv+hPWxjM1D8Ovn3MztR5D8itoCgIaIV+AM8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iW5Uk4YzkbXV1reKzhQqtl0bRH8EpQbBa29EqoMFCEa7UOez0/FpR/W5eXuevkoSbtRbx1iiaRUuBPlVLbOTcmWxjlimLrmuSDz+TK01OQSnq0WWpTJZkY436/HsLLKlGsAgJQxW6YTLC+M1WYkdh++6URuvAMdR7ZhchlPrfx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FL8udP8G; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716611275;
	bh=Sso5+EVsv+hPWxjM1D8Ovn3MztR5D8itoCgIaIV+AM8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=FL8udP8GDOgXacy55MPksoLFcmYi/BY3Bc+fEWsgkju0xXi/hjPNQvQmV6tyzmooS
	 tu6QYzigbNbCvVt3phjTJmcZMob6yu42Ae+O42lidvx7RanXoXEzhfp2RkLNrxJ40E
	 OTnOf3/1tTfiguOrNWg8u+2Xap9zUerKsw6r1BMeV28ZgkjBjix9Cyezug2sa7cbV6
	 hinxAEoDNtUevIWezDPXNuPqveOi9D1h19A8dpi++hHT6/i6AoRIRvmBjcwL8278eX
	 AIY+KpexdtFI3TgvImfoFd8DyI5ZuNzP9BakRgKJd8KAYXdWQ1pSJ6wfZJWGl6Yp3T
	 IGUbovcNe/0Mw==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 20BE63782085;
	Sat, 25 May 2024 04:27:53 +0000 (UTC)
Message-ID: <8057764f-064a-4d55-8224-a887f62ce539@collabora.com>
Date: Fri, 24 May 2024 21:27:39 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/ftrace: Fix to check required event file
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
References: <171624961322.252417.15852003285637286674.stgit@devnote2>
 <171624962273.252417.2474046620369030292.stgit@devnote2>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <171624962273.252417.2474046620369030292.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/24 5:00 PM, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> The dynevent/test_duplicates.tc test case uses `syscalls/sys_enter_openat`
> event for defining eprobe on it. Since this `syscalls` events depend on
> CONFIG_FTRACE_SYSCALLS=y, if it is not set, the test will fail.
> 
> Add the event file to `required` line so that the test will return
> `unsupported` result.
> 
> Fixes: 297e1dcdca3d ("selftests/ftrace: Add selftest for testing duplicate eprobes and kprobes")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
LGTM
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  .../ftrace/test.d/dynevent/test_duplicates.tc      |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
> index d3a79da215c8..5f72abe6fa79 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  # description: Generic dynamic event - check if duplicate events are caught
> -# requires: dynamic_events "e[:[<group>/][<event>]] <attached-group>.<attached-event> [<args>]":README
> +# requires: dynamic_events "e[:[<group>/][<event>]] <attached-group>.<attached-event> [<args>]":README events/syscalls/sys_enter_openat
>  
>  echo 0 > events/enable
>  
> 
> 

-- 
BR,
Muhammad Usama Anjum

