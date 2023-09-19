Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11F37A6956
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 19:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjISRCn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 13:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjISRCm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 13:02:42 -0400
X-Greylist: delayed 433 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Sep 2023 10:02:35 PDT
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BB3D6
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 10:02:35 -0700 (PDT)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 018B811D3;
        Tue, 19 Sep 2023 18:55:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 018B811D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1695142519; bh=5LNczy2+dyEHAXUylvE30St6GuD+e3uy+gkBfmJ4xzg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=g6Uew+A+HTxwJjlNBwqgEs/e8N6xOdlJQ5wxzPvcT2w/EAIp1/S8qEedhv+CiX3hr
         5KrkeKXQJCGE/CypLEbmyW6enidBBYsz7ofaXol8RrMV9cKv8XrpRNkDMCmDEqE4yp
         5Gzvu+qoYS7RpzD3yjUqVBnNRuUmE0UFfa3n4d4s=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Tue, 19 Sep 2023 18:55:10 +0200 (CEST)
Message-ID: <eeade51e-e293-ce94-1699-c9aefdc804f3@perex.cz>
Date:   Tue, 19 Sep 2023 18:55:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] kselftest/alsa: pcm-test: Report cards declared in config
 but missing
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Takashi Iwai <tiwai@suse.com>
Cc:     kernel@collabora.com, Mark Brown <broonie@kernel.org>,
        Shuah Khan <shuah@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230919152702.100617-1-nfraprado@collabora.com>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20230919152702.100617-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 19. 09. 23 17:26, Nícolas F. R. A. Prado wrote:
> When parsing the configs, keep track of card configurations that match
> the current system but haven't matched any card, and report those as
> test failures as they represent that a card which was expected to be
> present on the system is missing. This allows the configuration files to
> not only be used to detect missing PCM devices (which is currently
> possible) but also that the soundcard hasn't been registered at all.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

