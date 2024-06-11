Return-Path: <linux-kselftest+bounces-11706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B571B90460B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 23:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31301284A98
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 21:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E961534EC;
	Tue, 11 Jun 2024 21:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H8G+Cvvc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A58A386
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 21:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718139712; cv=none; b=J4fEghwls9/yX7+uKRq+IFVAwEPqoEbEUWEAf9aqbmhfgm2nOvSROHFkaqrkpwiHZKKPnpbeqHSW3609XGZGuzi9CLu+A5XzmbdmMlNKSd2Vb/nf+20vGHp7/KIgDnAxY3+tM32fg1ouDSxJSh3OARYWU6dA4XTckKzVly+fh9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718139712; c=relaxed/simple;
	bh=khCJ8E7bxMFxUPTxBFiKAS1pgz9jQ6ioSS5uproRVZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbxRKNL53BvKPdi6aGel/bBbVakbo0YZeoqUCp1bJc2EKOrWLu7hYtIkKVFC/jsVt1oLfMzUiR6lP7CpDycvtBOkJRDMaAZfyoPTxsn6zB4VUqKw0nxwQ8ivifLDIIQb/mG78vn+amMVSo9dbYgpVuQpbpgE/LLFazdLG21MM6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H8G+Cvvc; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d218bbba30so435746b6e.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 14:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718139709; x=1718744509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k6zEkzkTuZ7txFA7Ps53axhuBCU7AlYnO5Uonpaq+8Q=;
        b=H8G+CvvcHiPua9zmOnjmdhyt7RnPNu3CLX0n2bCmc6Z1sdar2TJcy9+Q0WNTLCimzt
         AayRtEXo6xRFxJb4riMiz8vtNUixey1wIjyTiCHaMugYw1R1UFCDY9NVthrrYEduzH5D
         0doPglp19iSp+v6V8tjJkmIm8YQNN+C6ggCgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718139709; x=1718744509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k6zEkzkTuZ7txFA7Ps53axhuBCU7AlYnO5Uonpaq+8Q=;
        b=Vm7tYnA91i0TNl6W6rjvniRJo/eSWxoEsuEIEQ3hh7zYjD2g40QXR8zJ8SBOx+qMsS
         0/hQnENWgH/96JWINe4+dvT+UzRmcMKDZRlNofrn+qCHNoi6Ds2KhcaNjSxXOpNrpMQ8
         F+wJjSbUzO2k2BqZY5ake2sZ7kSgPmY0tfWw0QK1GEmoyBP/dvGl/FqaF9zXP0NdKwWa
         wNOYFcXu0f4JXLNU6Im85dS0aSn70zq33gNS3KL+D4xcslmbr8nwHP6/gQnH7PX+6U+K
         Q5k+1ZZA1baO5J0NhQOSXcJDQ2Nim+3Etmk7jV97+GhXqencbOjMYEvdlr11Cz4pPK+f
         IzCw==
X-Forwarded-Encrypted: i=1; AJvYcCVyHmksuoJscaWTMiWAK6Hvba3o7Gru22dre6J1K+wJ377M/xbXaOgEhcl1VepxQACNB8FwMn5rt1OT3eZHDZGru0Hu4n9B8nINZbZtsagc
X-Gm-Message-State: AOJu0YzZaWzDm5U7guKSSjDT9EElbO5wUR9zZVoay6edFw7JTA2r5eUh
	Mw7tFfQbiGsGlX994MC+mcpWxD85v42vBKOPQcRBVPV+AXy9K9pLUcONTr9wWj0=
X-Google-Smtp-Source: AGHT+IG9GKImwKVUIgK2UrbzevVw6BqUCUpdNFpFowG/8v7VP6WnRqXnqwAjOpC+EOiwOZYSy6EfiQ==
X-Received: by 2002:a05:6870:7812:b0:254:7dbe:1b89 with SMTP id 586e51a60fabf-25514be2464mr2489fac.1.1718139709359;
        Tue, 11 Jun 2024 14:01:49 -0700 (PDT)
Received: from [172.20.14.19] (ool-6c3a3e1d.static.optonline.net. [108.58.62.29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795332e1bd0sm540525185a.134.2024.06.11.14.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 14:01:48 -0700 (PDT)
Message-ID: <bdd4d8ff-9399-44c8-8e14-311c0a7a8838@linuxfoundation.org>
Date: Tue, 11 Jun 2024 15:01:47 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] selftests/openat2, fchmodat2: fix clang build
 failures
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Christian Brauner <brauner@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Alexey Gladkov <legion@kernel.org>, Valentin Obst <kernel@valentinobst.de>,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 llvm@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20240601014534.268360-1-jhubbard@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240601014534.268360-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/31/24 19:45, John Hubbard wrote:
> These two subsystems require very similar fixes, so I'm sending them
> out together.
> 
> Changes since the first version:
> 
> 1) Rebased onto Linux 6.10-rc1.
> 
> 2) Added a Reviewed-by tag from Ryan Roberts. See [1] for that.
> 
> Related work: I've sent a separate fix that allows "make CC=clang" to
> work in addition to "make LLVM=1" [2].
> 
> [1] https://lore.kernel.org/518dd1e3-e31a-41c3-b488-9b75a64b6c8a@arm.com
> [2] https://lore.kernel.org/20240531183751.100541-2-jhubbard@nvidia.com
> 
> John Hubbard (2):
>    selftests/openat2: fix clang build failures: -static-libasan,
>      LOCAL_HDRS
>    selftests/fchmodat2: fix clang build failure due to -static-libasan
> 
>   tools/testing/selftests/fchmodat2/Makefile | 11 ++++++++++-
>   tools/testing/selftests/openat2/Makefile   | 14 ++++++++++++--
>   2 files changed, 22 insertions(+), 3 deletions(-)
> 
> 
> base-commit: cc8ed4d0a8486c7472cd72ec3c19957e509dc68c

Applied to linux-kselftest fixes for Linux 6.10 next rc

thanks,
-- Shuah

