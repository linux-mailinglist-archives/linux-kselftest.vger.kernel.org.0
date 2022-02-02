Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117B04A7369
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Feb 2022 15:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiBBOn7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Feb 2022 09:43:59 -0500
Received: from mail1.perex.cz ([77.48.224.245]:46560 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241386AbiBBOn6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Feb 2022 09:43:58 -0500
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 61E59A0046;
        Wed,  2 Feb 2022 15:43:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 61E59A0046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1643813037; bh=27XjbhSUP+dSBwJS6fXJV2xLD1T7F/n1/8/FE8UhM7U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KDjjR185WHRWm4HQQnv50xMvi8Vt2/KOVSUId4veeQCy9PD5cr85K0E4SwI1BePcW
         WdFnkM0l4YqOzKAtO/UM1+hMwZgNKAdD65/KlSQ/FLajJd33xfPuP7V7v91nBUdu1Q
         zGnI+8iphxuiKcZSaLVA2yjOJ9jJ/Uq91ayQ0pKc=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Wed,  2 Feb 2022 15:43:50 +0100 (CET)
Message-ID: <910978c1-e94f-dcea-7cc1-479d8080c627@perex.cz>
Date:   Wed, 2 Feb 2022 15:43:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 2/2] kselftest: alsa: Declare most functions static
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220202141011.14924-1-broonie@kernel.org>
 <20220202141011.14924-2-broonie@kernel.org>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20220202141011.14924-2-broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02. 02. 22 15:10, Mark Brown wrote:
> This program has only one file so most functions can be static.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
