Return-Path: <linux-kselftest+bounces-16116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AF395BD17
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 19:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1BF1F23C57
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 17:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F1E1CEACC;
	Thu, 22 Aug 2024 17:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dP9k/wU2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081FD1CE716
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Aug 2024 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347506; cv=none; b=BP04+ePLV+juvlexacm8qX4a+mGqTQaCDKkmf43dkuzCahk6iRxXfrm/QQhh4RydawTryQKg8mux2aJ+aUmpzQ6e3HDKlZLOMMBGDUnUuJDrm5XNX3O1cCwEcCyt4CaCNyZWOpv+ZvCwTYV/7KpaqKmT/ioy9uwqZFbuVFWsFFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347506; c=relaxed/simple;
	bh=96nSAerh6X2V4FpypOy6E5j6+AHv5vX7RJ+JzdUuYZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqVGSSn6ZuMeV+r/2BE+BAley6HJSwH1VLC/SzxyIxB6MCF0PNzN7qjrpwrigw9/eKMFBy/G66thWqZvMEpZ1BDSbMCA3AxjgD1pKPxjqkOdSc2TkGszE1L5ync6qB2hYM7xHDFV11xnzYZCXtfdSR6/5vUmBKCRYpcosL7Rxp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dP9k/wU2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724347504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d3xzI8Z49dbNRaboDk3FVrW8VSVdcJeyT4KaTegTimQ=;
	b=dP9k/wU2nXJk6KZpJv9Cjpo6K6NFO7gUgp6PgxVXaMhxgrDYIaBE2f6pC8u+98HfhnI2IS
	AYEzWykm5skDm8GMs0l7vBzYT1dRy/mqmyMSJgpRMrNEuhMsLYXvOQvfInPb+pXZigEKJd
	jV2Y7QOsl68cRGDfrq+vl6hqdqs2Ke0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-CrDEju2ONveKrzbPad-zzQ-1; Thu, 22 Aug 2024 13:25:02 -0400
X-MC-Unique: CrDEju2ONveKrzbPad-zzQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a20ce27a6fso137308485a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Aug 2024 10:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724347502; x=1724952302;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d3xzI8Z49dbNRaboDk3FVrW8VSVdcJeyT4KaTegTimQ=;
        b=ngDSFpo3Y8lI+4/BALsgLcI1RjuE7AaC2MKEsVtqXZnQ0WU8bZ1THsxhRqdkvEJuLm
         I4Iefa/d10eH1RUF365Rsms+exB18Xq38Re3ynd5/GdYwB36E8c1TjVQy6RulYri6RpY
         5kx5mQ0AlKV10JmKBmRLqjD7XKalbl8Indcj4aAgGXoejdtfKytIUzag0q1ce8GPvABR
         F7nS5zizuo26za+xKIrYoEg+IB+aorNQlR/G+nFsPv16qIyoLVvgsFRApDw9lEwl9WJl
         yiBPfh57SRS2y2z03EWSRAJUMqZaSnmkEIt7rUWud0h+MtdQJwr8RfzBmO1OZww0r+Ve
         kkMA==
X-Forwarded-Encrypted: i=1; AJvYcCViO8o620DhCJieogANHIvLLzW6M2vFNqp4b6qy6ZlXh74j+07kVdFxs6nvWQ4a9U60P8a60CCsAArWSlbXAO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Xloc1Juglm9ZTaCWTE+5iK9BkOtiuEIaZVnOc0vlEBunYrph
	OivL+JFTvYI+PvFxOdGt5yeoK32MoUe+jSCvPEA/9bR8qCuL/ljMvETHUpCSh5ojTsdAC6BO49Q
	uU7KY0mjh1xUlcwQo3b6sa2UKr8VB2eae7xwZXB8rhcEh+ZMyF/CM9YZ4O+lw397uPw==
X-Received: by 2002:a05:620a:1a1d:b0:79d:5f82:a404 with SMTP id af79cd13be357-7a680b223famr316027085a.64.1724347501881;
        Thu, 22 Aug 2024 10:25:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiVZLnwMjRH6QJCF0rkI5pAHMrm7yzrb/gyVCV7b3SHnoFL/3+AI7zTBVhdN8BbXo7qHzyWQ==
X-Received: by 2002:a05:620a:1a1d:b0:79d:5f82:a404 with SMTP id af79cd13be357-7a680b223famr316024085a.64.1724347501514;
        Thu, 22 Aug 2024 10:25:01 -0700 (PDT)
Received: from [192.168.1.9] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f347b15sm91442485a.44.2024.08.22.10.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 10:25:00 -0700 (PDT)
Message-ID: <182e7c5a-b8cc-6ac1-7edf-81c092be72f5@redhat.com>
Date: Thu, 22 Aug 2024 13:24:59 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] selftests/livepatch: wait for atomic replace to occur
Content-Language: en-US
To: Ryan Sullivan <rysulliv@redhat.com>, live-patching@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com,
 shuah@kernel.org
References: <20240822163439.13092-1-rysulliv@redhat.com>
From: Joe Lawrence <joe.lawrence@redhat.com>
In-Reply-To: <20240822163439.13092-1-rysulliv@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/22/24 12:34, Ryan Sullivan wrote:
> Uses 'loop_until' to wait for the atomic replace to unload all previous
> livepatches, as on some machines with a large number of CPUs there is a
> sizable delay between the atomic replace ocurring and when sysfs
> updates accordingly.
> 

Small nit: flip this around so it describes the problem first, then the
'loop_util' solution.  Also spell check "occurring" if you keep it 😄

> Signed-off-by: Ryan Sullivan <rysulliv@redhat.com>

Let's give the CKI credit for finding this:
Reported-by: CKI Project <cki-project@redhat.com>

If anyone is interested, here is the test/log link:
https://datawarehouse.cki-project.org/kcidb/tests/redhat:1413102084-x86_64-kernel_upt_28

By the way, was it easy to repro on a similar machine as the one
reported by CKI and then how did it fare with this patch in place?

> ---
>  tools/testing/selftests/livepatch/test-livepatch.sh | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
> index 65c9c058458d..bd13257bfdfe 100755
> --- a/tools/testing/selftests/livepatch/test-livepatch.sh
> +++ b/tools/testing/selftests/livepatch/test-livepatch.sh
> @@ -139,11 +139,8 @@ load_lp $MOD_REPLACE replace=1
>  grep 'live patched' /proc/cmdline > /dev/kmsg
>  grep 'live patched' /proc/meminfo > /dev/kmsg
>  
> -mods=(/sys/kernel/livepatch/*)
> -nmods=${#mods[@]}
> -if [ "$nmods" -ne 1 ]; then
> -	die "Expecting only one moduled listed, found $nmods"
> -fi
> +loop_until 'mods=(/sys/kernel/livepatch/*); nmods=${#mods[@]}; [[ "$nmods" -eq 1 ]]' ||
> +        die "Expecting only one moduled listed, found $nmods"
>  
>  # These modules were disabled by the atomic replace
>  for mod in $MOD_LIVEPATCH3 $MOD_LIVEPATCH2 $MOD_LIVEPATCH1; do

With commit msg additions above:

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

Thanks,

-- 
Joe


