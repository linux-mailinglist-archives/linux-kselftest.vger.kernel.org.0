Return-Path: <linux-kselftest+bounces-20297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D15C19A72BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 20:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0A2280C90
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 18:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D5F1FB3F8;
	Mon, 21 Oct 2024 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OTM2z5W6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188291FB3D6
	for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 18:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537043; cv=none; b=A5YUD9wn3C7SV2BbVBEvHa+aYPJ/r9F5I/KOWTVV3i1QQuEz4J59TM0jItpZi8htt8zEYnL1SpzP72MdqDCupx09BFQo3ncpTY5a7HLdTSzvI7NJ6OeauSok8YFVyRIafrCeBn9N8yK9Ug6BD+xAUUIDGNfT10Uge9wDhKl34uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537043; c=relaxed/simple;
	bh=Poj40m4XWjZmZW67V/R29Zyaoz6g/1vZbJUcwa8dRBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UzMriC095e6TUpE0RhsG6DG0yIMt7LTG/z7E0cRcL/tm9SeoHIZD3XuQRC+TJaO0WDnvHJhOPL1gzGui/puadiBeV6oGIqxBqCLJwJyPgFeuWK82kLNbxWMFsuM/StiR3xpwpZhvw9Nzl6CKx28YhLSYzz2qEEzxi6x/zm6ZJHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OTM2z5W6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729537035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7JVcG4b9DpqHn6ILLTpsyd6A8EriJ9ALphdfVTy5yis=;
	b=OTM2z5W6QQj4XOshxepF1NL1Z/Lvlgg8OCmwXgmCc9NGRmGlJTldOhu4YBZBvK1pr+FBf2
	8XExTkSPrcX6UcBf/XGZoug1T8+CCjDPXpSMy5vI2nCHkYMGuAC3R1nQPQDgCdfUkDM+M+
	6i/rWyzDn3TEcC3m/kBQ+9gNnx4JUII=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-HzEINszkN5eioZvgDxxj0Q-1; Mon, 21 Oct 2024 14:57:14 -0400
X-MC-Unique: HzEINszkN5eioZvgDxxj0Q-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6cbeb6075d9so96371376d6.1
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 11:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729537034; x=1730141834;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7JVcG4b9DpqHn6ILLTpsyd6A8EriJ9ALphdfVTy5yis=;
        b=BE7Tmz9Z1ovZj20Ej4DAiBPvumRYDPoWMi/FOSSq977rqquHDcWWJhfOT8QdvUN5Qq
         oQrgFkSQNY6LuSU1wjCMqllA/ckMjlRN9+0uRDgfTV9Mmjkfxtg+tZMcwmyUrUCd8QTv
         UG+q+xIa64SA45Sq7iuI8mf6HHwyj3OywBJbKi2amfZIL67QMW368X3sOtARN1cahAYB
         OBnpCboiJ4mXdoUyPFqq+mlquR7DcjgCBlynGAUPLpZkL85+bQPQ9vLOZ2PRibdi0Yjo
         l1djh11mJyf5jEjKj+9Rhzw0ayv45+zt821LwA8lFQaeClhOt8ZqgjnmAmd9plYLdPTi
         oCzg==
X-Forwarded-Encrypted: i=1; AJvYcCWGH/tSje5Xh9YZHCMwtLT9fR0odqbOd6ZghObTvzzp815PQNVxqfbxm/6XriH8nar0I8WqqJB3IKTvvFiz39E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2BLwEQrE0x3H6wdBd7jz4W9awf23P4poUzJajDOMD3h5k7V/U
	IMr1VfPUFrZOBF3gAT4nWVTVHqJPuHQ4SLjJNrFVbAyDbr1OMan/NNnk1+FMi4sttI0TF75xTU8
	3L2R3BPeUxaQvxAMYqpFgWWR+k3Z5+j6NcFzg8Yhcp3sq0G6g19ciIsmO6m3uYSQsvg==
X-Received: by 2002:a05:6214:2dc7:b0:6cb:81ba:8ac1 with SMTP id 6a1803df08f44-6ce211dd0b9mr13770836d6.0.1729537033899;
        Mon, 21 Oct 2024 11:57:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhRNbKYg3FJuhV3JjrTQoeIMJwfDsagQ1cKT7l7Ble51qnCXFHBL3v35PoAgmawwvbY02KeA==
X-Received: by 2002:a05:6214:2dc7:b0:6cb:81ba:8ac1 with SMTP id 6a1803df08f44-6ce211dd0b9mr13770476d6.0.1729537033558;
        Mon, 21 Oct 2024 11:57:13 -0700 (PDT)
Received: from [192.168.1.18] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce008fb90dsm20433686d6.43.2024.10.21.11.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 11:57:13 -0700 (PDT)
Message-ID: <94cddfbb-bbef-73cc-2bb6-ad7474df08bf@redhat.com>
Date: Mon, 21 Oct 2024 14:57:12 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 0/3] selftests: livepatch: test livepatching a kprobed
 function
Content-Language: en-US
To: Michael Vetter <mvetter@suse.com>, linux-kselftest@vger.kernel.org,
 live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241017200132.21946-1-mvetter@suse.com>
From: Joe Lawrence <joe.lawrence@redhat.com>
In-Reply-To: <20241017200132.21946-1-mvetter@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/24 16:01, Michael Vetter wrote:
> Thanks for all the reviews.
> 
> V5:
> Replace /sys/kernel/livepatch also in other/already existing tests.
> Improve commit message of 3rd patch.
> 
> V4:
> Use variable for /sys/kernel/debug.
> Be consistent with "" around variables.
> Fix path in commit message to /sys/kernel/debug/kprobes/enabled.
> 
> V3:
> Save and restore kprobe state also when test fails, by integrating it
> into setup_config() and cleanup().
> Rename SYSFS variables in a more logical way.
> Sort test modules in alphabetical order.
> Rename module description.
> 
> V2:
> Save and restore kprobe state.
> 
> Michael Vetter (3):
>   selftests: livepatch: rename KLP_SYSFS_DIR to SYSFS_KLP_DIR
>   selftests: livepatch: save and restore kprobe state
>   selftests: livepatch: test livepatching a kprobed function
> 
>  tools/testing/selftests/livepatch/Makefile    |  3 +-
>  .../testing/selftests/livepatch/functions.sh  | 29 +++++----
>  .../selftests/livepatch/test-callbacks.sh     | 24 +++----
>  .../selftests/livepatch/test-ftrace.sh        |  2 +-
>  .../selftests/livepatch/test-kprobe.sh        | 62 +++++++++++++++++++
>  .../selftests/livepatch/test-livepatch.sh     | 12 ++--
>  .../testing/selftests/livepatch/test-state.sh |  8 +--
>  .../selftests/livepatch/test-syscall.sh       |  2 +-
>  .../testing/selftests/livepatch/test-sysfs.sh |  8 +--
>  .../selftests/livepatch/test_modules/Makefile |  3 +-
>  .../livepatch/test_modules/test_klp_kprobe.c  | 38 ++++++++++++
>  11 files changed, 150 insertions(+), 41 deletions(-)
>  create mode 100755 tools/testing/selftests/livepatch/test-kprobe.sh
>  create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c
> 

With the small syntax error fixed in unload_lp(),

Reviewed-by: Joe Lawrence <joe.lawrence@redhat.com>

Thanks, Michael, this is a good test to add to the suite.

-- 
Joe


