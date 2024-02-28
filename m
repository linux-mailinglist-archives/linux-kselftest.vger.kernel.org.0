Return-Path: <linux-kselftest+bounces-5509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15BB86A448
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 01:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730991F28BD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 00:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590AA184;
	Wed, 28 Feb 2024 00:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D2Gb4ltS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87BF364
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709079021; cv=none; b=lxToaNiWaiYxEODtX/EsyF+TrQ9S1wpHhInOYoEwTajeSqqNNfJ5qr390xQ5vISTt/qpBOF6BtruV9b6SOXp2tqFY4k6RvMrgxEG+q2Bl1APhGg48znvfxuC0FSIx6NxqWXosKj+4yijE7cuaH03/ACaVpczKcmA0E3w7Vu6G5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709079021; c=relaxed/simple;
	bh=7Bibe+mApP2qw+Bwb89kIz1Vorq4HcJl2XyOfxCc+rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQBm3hg+4Hiqlh18IEsBzZAfgZYUK4MVt67/aVEOgYu2LFnbS0liTAr/MUsFirjb/Kz473XDLTZ3XW+hbTyddEURMZH55R6pS7Q2xCEaYXQnbbR7HdsRhekOB58ND+8MDd4uOrxe+fUAOkghZhj16eVvbc0bqXlnwjaQX2j0mQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D2Gb4ltS; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso99271939f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Feb 2024 16:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709079019; x=1709683819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3uNCkE/Y4bucRwr/vs7c1ruuOADEG13u7lr08BZ4VNA=;
        b=D2Gb4ltSZBbw7GNcjBZZWXuvkDuJasDEjNQU6jiVVhbDbapAbLVi1ryZZx7vIM+Zhw
         DBaNdui24vVhN05VovPFFOC3VWlaiuW37K4tgOhoAFGc/2tHOoiisBmZk6rGFd2AYnrY
         7NlS96wYAGJd51AiEkVGeOB1wGejgP6BoGtfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709079019; x=1709683819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3uNCkE/Y4bucRwr/vs7c1ruuOADEG13u7lr08BZ4VNA=;
        b=s3Y+vKxi+zPWjqmAv4lemuZ+N/pvMtWV6hCr3LabjcZGJlv0t4aYFIaQuho26SE3MH
         vIT733urYtEGCg87UHgw9LccLSsoPtwdpgkXmwLEY8nKT+jwy1A9YYFB4UZhZLhNh5AY
         TrWHILC8wrE3YtyW9QARJU8hjTAe+4M5mnRqWcaLPHNh4tCCEx5PUaKFAvvs0dnLVWf1
         sfGyciPUk8thEOp/w6BS+ysVsf5uxWgNb7uacY1obui8Ys7URA6IJ0zqVb565WIGFRO4
         WikcQlgC0yB+oZm53/bOSUEcsoFm4glRuvNUjmDvijI7XxOmYlmnEcZRwdc+yZHDg0bB
         mmxw==
X-Gm-Message-State: AOJu0YyGDHYQ4rHROvWYBkAWTBpo62XJtsY5oWZDlGsCK70oneYnFMU7
	pXsWXP97dbbq6NztyK94aJLacff8/q/Q7GkrHTVDvgyFQ590/wFDtOlWUAFtbKs=
X-Google-Smtp-Source: AGHT+IGrxhuv2/vozEcMAJsAG2BL6qpv5diYWB6ZxOntrxwP6jDQRasA2qEhpJhFBGgL0WngloEcfg==
X-Received: by 2002:a05:6e02:20e4:b0:365:1967:e665 with SMTP id q4-20020a056e0220e400b003651967e665mr11415974ilv.2.1709079018924;
        Tue, 27 Feb 2024 16:10:18 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id x14-20020a056e020f0e00b00364b66eb5e3sm2427560ilj.24.2024.02.27.16.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 16:10:18 -0800 (PST)
Message-ID: <76d006e1-aeb1-4622-aa9e-6bf4101a4e15@linuxfoundation.org>
Date: Tue, 27 Feb 2024 17:10:18 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Improvements to livepatch kselftests on top of
 kselftest-next
Content-Language: en-US
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Shuah Khan
 <shuah@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org, kernel test robot <lkp@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240221-lp-selftests-fixes-v2-0-a19be1e029a7@suse.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240221-lp-selftests-fixes-v2-0-a19be1e029a7@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 10:17, Marcos Paulo de Souza wrote:
> The changes on lib.mk are both for simplification and also
> clarification, like in the case of not handling TEST_GEN_MODS_DIR
> directly. There is a new patch to solve one issue reported by build bot.
> 
> These changes apply on top of the current kselftest-next branch. Please
> review!
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
> Changes in v2:
> - Added a new patch to avoid building the modules/running the tests if
>    kernel-devel is not installed. Resolving an issue reported by the
>    build bot.
> - Reordered the patches, showing the more simple ones first. Besides
>    patch 0002, all the other three didn't changed since v1.
> - Link to v1: https://lore.kernel.org/r/20240215-lp-selftests-fixes-v1-0-89f4a6f5cddc@suse.com
> 
> ---
> Marcos Paulo de Souza (4):
>        selftests: livepatch: Add initial .gitignore
>        selftests: livepatch: Avoid running the tests if kernel-devel is missing
>        selftests: lib.mk: Do not process TEST_GEN_MODS_DIR
>        selftests: lib.mk: Simplify TEST_GEN_MODS_DIR handling
> 
>   tools/testing/selftests/lib.mk                        | 19 +++++++------------
>   tools/testing/selftests/livepatch/.gitignore          |  1 +
>   tools/testing/selftests/livepatch/functions.sh        | 13 +++++++++++++
>   .../testing/selftests/livepatch/test_modules/Makefile |  6 ++++++
>   4 files changed, 27 insertions(+), 12 deletions(-)
> ---
> base-commit: 6f1a214d446b2f2f9c8c4b96755a8f0316ba4436
> change-id: 20240215-lp-selftests-fixes-7d4bab3c0712
> 
> Best regards,

Applied all except the last patch to linux-kelftest next for Linux 6.9-rc1

thanks,
-- Shuah


