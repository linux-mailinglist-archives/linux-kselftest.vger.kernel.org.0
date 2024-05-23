Return-Path: <linux-kselftest+bounces-10626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D677B8CD994
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 20:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1369E1C2107F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 18:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632F2537FF;
	Thu, 23 May 2024 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MLES0gKj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAD98249B
	for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2024 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716487323; cv=none; b=Kc/bdMfB+7uUyMyxUQHOcMScpMlGrOw2H1kVNqtFXOjb5ngrKCbb4f30G7pwtwPDAErsm6t6kZLack+NZdLFYf9B/Nz3WTiaMtUuPUzP9xEujz3s2plAbSLF89gEuq+6S9JLNUYkKdndORAASb5IyugQkn4tCRZOicMPDYANUMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716487323; c=relaxed/simple;
	bh=3k6WvpZBot26hna6+k0egsJmF3ju+afeCCSsoYxl4Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XtlO4mEk+iak13z45eP+2oqvhy7iN5kpkfg1I1YEqyHDFJlOUCgGCfIgTV0FgRRO8Azu4hzr0j9I8+SWsWypQmXZWdjP68HWDEy5Gmmq8lHhw0vSGOxOAHFEIqZOFgIznqKzpdO5wim1HtBZXEUr3ImFIAxe86aV5vpoc6+cDEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MLES0gKj; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36da87c973cso3239005ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2024 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716487321; x=1717092121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CcmoKrno51oIESzU6CRBDsbzTPCeYv0t1iR5nNF3XwI=;
        b=MLES0gKjNB1Q6Gv7e0DHXND23LLPEB++Jh+KAE8VPYFIcSh0+73GBKU00MsCF9pMfB
         OfsQ/nyVm4UDg8yDyjQArOR1PlSgYO84JyE65KnZrh3f7Dh2E36SBomicsALB4BxBbpo
         aJSP5LxrI+0MnwS28KbgVgWHcKecjadnLcXF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716487321; x=1717092121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CcmoKrno51oIESzU6CRBDsbzTPCeYv0t1iR5nNF3XwI=;
        b=t8WBrBNFVYQM3WDqLxr+zz06WAnd6vz6Ge2lmN98bVlFnHin3YmQbWarYDsx0f4eQv
         UqoV3qJEy1EkHqMclDvRFwBU5coeZ/s8DIFeSB9926FdeFjjbD3r2nWvi4yTOOOz+KBP
         dyEZjWNhfVe5dxBnQ8itwJXn2iy3dFUKzpNDzscKsyxm+p84txip3a+DQWwpXustsy7V
         g05gvk99ai0d+5xB+a68zuPbQCYYzSj6RRHc4zSfRrafkPQzoF+vTD9Irc5PAjey4LEh
         gajmSaNChjew2ju7twLtUjfPElYZiC6ucZ3AuaZ9T6OKVzxPepqgSOv0Wc/Xs24L/z+M
         hwXg==
X-Forwarded-Encrypted: i=1; AJvYcCXCOQ0paaRvpWCZeE1zGqe1j4g5t8BfTFbkD7d1cl6uF/Sa84LdyYbPV1RcXO7eUhngl/t8tZR6n6vyMCi+NaXdlDPdnVLYUHVESSdV0ZFr
X-Gm-Message-State: AOJu0YxBC11+7VlU25lgkYdEbjC/3rhpQJJp/8pfz1jlibm/Z77vXvYI
	HOyTqW0P+Ge/uHXzmynMyFLdsl0lk2fvH93g+7+lZDp2H6Pg9uRsRIwUGLV5axE=
X-Google-Smtp-Source: AGHT+IHFL67Z83I3o40zCsNMJ+ZoJnLtFsbE/QtO0U+1g9W23Ofor/d2rDbzaegpkLYOLJ/pxEIroQ==
X-Received: by 2002:a05:6e02:1fc1:b0:36c:3856:4386 with SMTP id e9e14a558f8ab-3737b3cad00mr209585ab.3.1716487320819;
        Thu, 23 May 2024 11:02:00 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3737a5e826bsm519205ab.73.2024.05.23.11.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 11:02:00 -0700 (PDT)
Message-ID: <d5471e30-227d-4e6d-9bbd-90a74bd9006b@linuxfoundation.org>
Date: Thu, 23 May 2024 12:01:59 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/68] kselftest: Desecalate reporting of missing
 _GNU_SOURCE
To: John Hubbard <jhubbard@nvidia.com>, Edward Liaw <edliaw@google.com>,
 Mark Brown <broonie@kernel.org>
Cc: shuah@kernel.org, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Christian Brauner <brauner@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Kees Cook
 <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@android.com,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240522005913.3540131-1-edliaw@google.com>
 <20240522005913.3540131-3-edliaw@google.com>
 <94b73291-5b8a-480d-942d-cfc72971c2f5@sirena.org.uk>
 <CAG4es9WAASaSG+Xgp31-kLT3G8wpeT5vAqbCA4r=Z8G_zAF73w@mail.gmail.com>
 <9e2677ec-1d54-4969-907b-112b71ef8dd3@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <9e2677ec-1d54-4969-907b-112b71ef8dd3@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/22/24 20:28, John Hubbard wrote:
> On 5/22/24 10:46 AM, Edward Liaw wrote:
>> On Wed, May 22, 2024 at 4:21 AM Mark Brown <broonie@kernel.org> wrote:
>>> On Wed, May 22, 2024 at 12:56:48AM +0000, Edward Liaw wrote:
> ...
>>> You've not provided a Signed-off-by for this so people can't do anything
>>> with it, please see Documentation/process/submitting-patches.rst for
>>> details on what this is and why it's important.
>>
>> Sorry, my mistake, I forgot to add it after cherry-picking.  If added
> 
> Adding this to your .gitconfig would cover you for cases like this, I think
> it's pretty common to do this:
> 
> [format]
>      signoff = true
> 
> 

Mark, Edward,

Is this patch still necessary of the series is dropped?

thanks,
-- Shuah


