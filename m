Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52A0724502
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 15:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbjFFN4k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 09:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjFFN4j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 09:56:39 -0400
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DB8E7E;
        Tue,  6 Jun 2023 06:56:37 -0700 (PDT)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 67D641E3B;
        Tue,  6 Jun 2023 15:51:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 67D641E3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1686059470; bh=wWUWQnIiVZhKbLrsMF55qIviZYfhGpceAE51ipVy0/4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZOjLuWHR0ChI3MIpbVhOO6CbiHGFNcAVuV4kJqHruHdHOzg/t5oI5PjjPknFTgFi7
         gCqZi3fMqeGpdIxLg0GiudqP/O+x58qF1GnjDf3bbEg4wujgJctJLeVha4aJVtR+Rc
         9Vnw3bbrmi1xUpjft725CNHuZN57A30P0By2UFlA=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Tue,  6 Jun 2023 15:50:58 +0200 (CEST)
Message-ID: <afd4bdef-7511-66dd-e021-6eaafabdbba2@perex.cz>
Date:   Tue, 6 Jun 2023 15:50:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 2/3] ALSA: Implement the new Virtual PCM Test Driver
Content-Language: en-US
To:     Ivan Orlov <ivan.orlov0322@gmail.com>, tiwai@suse.com,
        corbet@lwn.net, broonie@kernel.org, skhan@linuxfoundation.org
Cc:     alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        gregkh@linuxfoundation.org, himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20230606133807.14089-1-ivan.orlov0322@gmail.com>
 <20230606133807.14089-2-ivan.orlov0322@gmail.com>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20230606133807.14089-2-ivan.orlov0322@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 06. 06. 23 15:38, Ivan Orlov wrote:
> We have a lot of different virtual media drivers, which can be used for
> testing of the userspace applications and media subsystem middle layer.
> However, all of them are aimed at testing the video functionality and
> simulating the video devices. For audio devices we have only snd-dummy
> module, which is good in simulating the correct behavior of an ALSA device.
> I decided to write a tool, which would help to test the userspace ALSA
> programs (and the PCM middle layer as well) under unusual circumstances
> to figure out how they would behave. So I came up with this Virtual PCM
> Test Driver.

Acked-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

