Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EA77381CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 13:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjFUJwy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 05:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjFUJwx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 05:52:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C3210A;
        Wed, 21 Jun 2023 02:52:52 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1FB486606F73;
        Wed, 21 Jun 2023 10:52:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687341170;
        bh=HjDAudkKipQLczGA3Z+Xcf4LUnUH5z5iQaIO41AWYto=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=e4nqUfiWPdOPILSnlwY/fnUauQ1CgUSbBk904O3wxRq8jufIdx8Se0MUH8zg2LTa6
         F07saruQacith8Q7T55AI+b2nspXoX4g5eiOtdk4qrDdC74qOcbephNt7p/2ryX5ci
         Cfu5P9NI2QgrEEyVHqPZzrz85w5mjlqirx3nGX3iv1QWwizOKwo6LV08oTaWT6+JfS
         3jwuzOq7ILskZxpSV6FUQ7JgX7lPuOdjkAQck2+rRDKqhjHH3e2xAdWRVb2IcdY+NN
         PhbzBizMVGXgFDHl+evY1+z4mECWBOFGqWcr+qyAW74O7oHu+3yxRxc7G2kvZTEM6R
         gQZSyraCMBQfQ==
Message-ID: <d26ea42b-5749-bf08-997b-4a3b6062aed4@collabora.com>
Date:   Wed, 21 Jun 2023 11:52:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] kselftest/alsa: pcm-test: Move stream duration and
 margin to variables
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20230620220839.2215057-1-nfraprado@collabora.com>
 <20230620220839.2215057-2-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230620220839.2215057-2-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Il 21/06/23 00:08, Nícolas F. R. A. Prado ha scritto:
> The duration to stream for and time margin to consider the stream failed
> are currently hardcoded values. Move them to variables so they can be
> reused and more easily changed.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

