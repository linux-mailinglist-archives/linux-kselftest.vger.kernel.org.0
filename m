Return-Path: <linux-kselftest+bounces-10590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3FE8CC677
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 20:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D843FB2171A
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 18:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0D714600C;
	Wed, 22 May 2024 18:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZiAfGJ8/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD6145FF0
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716403240; cv=none; b=jykWx032er/zp4vAlDZI7VvcHdNLFuzOiiEIN2oE76XN1KOWl9i2INWaUHBQMdq+ITjDwyXpwaT+gkuev38P4Sq439kAmFILxYx9eDsB5xhaqhs+GUekuMLxlhtpApDMriw5qUXFdwHS6itog7yByGvcSgwjHcCAuxovqt8h0Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716403240; c=relaxed/simple;
	bh=pvfNI1321JVtef7N+59lYxiObUuoIkn6QTtflB1MBjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jmgk/8BFp0Ry6MWTPK3F3geDfpjPq8uLNCfRC4QDpDExZRj6LJOyjaxBamgFhCw7/bZj4VEJiOvrXVTCjYCQc4S/nD91KEni6ZoQR7HgRlcEW7ylBTT68swhOyFCYcfxTBtxNty8ZQ4lSbt7CXB8a1r90dtLOj/7vu+TlooZ8oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZiAfGJ8/; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7e1b8718926so44520439f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 11:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716403238; x=1717008038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2CkJWPtWzq2cjcP7a09if5B9kWWmXWyc6FlwIT3mHR0=;
        b=ZiAfGJ8/7Tp3Wp5CYTquG8GZV24qMCLf0ceknIzVUcWQ/8PEFow+ystDmKwo3No7nx
         Gs0VPJw/OIHVC7sIc/TknKQExOnL7DRsjptWGKUDfxLt4Hpfmkob/lyeltGGr/tH1dpJ
         g8lwbAoUPdmzQL8TWpUmDt1wjZrxz0Fp1sbNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716403238; x=1717008038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2CkJWPtWzq2cjcP7a09if5B9kWWmXWyc6FlwIT3mHR0=;
        b=ryAtlcd2EC13HPtvRTp6zFxk1SdH3io76ziqJEfpNepm0NcGF3gZd5/COJ6DayfBqX
         MD/4hWd6raRC/rFx5TDx59lXdJPuVhkyiD3Hs862wZu7EqtjlXo2cO3uy0eapRSaIegM
         VeMr9NAAKlnMX+lbz3+l3YqLKX/JhikigBLlGYX1+nmmXDybDLFb4HHm+QDQr91uLhD+
         3ZyzxID1JErIDeyqa5j3BMMuor15ktA3geSDo4FX56yeqgwYaJY437tgcOEX+THJYdIC
         DX+TQMrkwVzdOneP2Vzw91AZaigR0P2PKQxuhxd9+OvorPpgbLNzDPyWB4JbiRp35fDx
         RGzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx2MQzWOW+hlPhqPu8PkM3viJ/1aK+C3xSU/1HFWFPxa/xHsMovhTABSdk4chNepy+4+TOZ9jxSzL7lzHDjOp3YApHG2dM0RxYyFyWGpEv
X-Gm-Message-State: AOJu0YxeYtLKkDCvwpp5l+VDkw4V6c+14JbPCsqh9DdUoY54G2fUfaGQ
	OOL9uN4XsZR+GNJjcNL4hezxygdIwVFA5e47CH3iBfNoRD1JM094RkFbQsYIsWA=
X-Google-Smtp-Source: AGHT+IHfJbSzf9eR6h+5NiCKdgJYC/D5h2NHJ2n/qeMndC5IVVrtGPtwRsxEDeIFRtYop2k9g8p2Vw==
X-Received: by 2002:a05:6602:420a:b0:7de:b279:fb3e with SMTP id ca18e2360f4ac-7e37db353b9mr293535939f.1.1716403238250;
        Wed, 22 May 2024 11:40:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-48a42b0e43dsm4496318173.101.2024.05.22.11.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 11:40:37 -0700 (PDT)
Message-ID: <7a7d6b6c-0f28-4ffe-9bf2-a25c088636db@linuxfoundation.org>
Date: Wed, 22 May 2024 12:40:36 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/68] Define _GNU_SOURCE for sources using
To: Edward Liaw <edliaw@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, shuah@kernel.org,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Christian Brauner <brauner@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@android.com,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240522005913.3540131-1-edliaw@google.com>
 <6caf3332-9ed9-4257-9532-4fd71c465c0d@linuxfoundation.org>
 <20240522101349.565a745e@kernel.org>
 <CAG4es9VZ3r34sUkp31+GCrA_XOq6WqwUUitPMQFViLL83mezYg@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAG4es9VZ3r34sUkp31+GCrA_XOq6WqwUUitPMQFViLL83mezYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/22/24 11:44, Edward Liaw wrote:
> On Wed, May 22, 2024 at 10:13 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Wed, 22 May 2024 10:19:33 -0600 Shuah Khan wrote:
>>> On 5/21/24 18:56, Edward Liaw wrote:
>>>> Centralizes the definition of _GNU_SOURCE into KHDR_INCLUDES and removes
>>>> redefinitions of _GNU_SOURCE from source code.
>>>>
>>>> 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
>>>> asprintf into kselftest_harness.h, which is a GNU extension and needs
>>>
>>> Easier solution to define LINE_MAX locally. In gerenal it is advisable
>>> to not add local defines, but it is desirable in some cases to avoid
>>> churn like this one.
>>
>> Will the patch that Andrew applied:
>> https://lore.kernel.org/all/20240519213733.2AE81C32781@smtp.kernel.org/
>> make its way to Linus? As you say that's a much simpler fix.
> 

Thank you Jakub. Yes. This is a simpler fix.

> Right, this patch series may be unnecessary after all, since the
> problem is fixed by that patch.
> 
> It might be better to drop the series unless it is desirable to
> centralize the declaration of _GNU_SOURCE to the root Makefile /
> lib.mk.  If that is still wanted, maybe a more palatable approach
> would be to surround every instance of #define _GNU_SOURCE with
> #ifndef _GNU_SOURCE first, then induce the change to CFLAGS in lib.mk.
> That would prevent a partial merge from triggering build warnings.

Please drop this series.

thanks,
-- Shuah


