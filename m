Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31007244FF
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 15:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjFFN4k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 09:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjFFN4j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 09:56:39 -0400
X-Greylist: delayed 284 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Jun 2023 06:56:37 PDT
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC878F;
        Tue,  6 Jun 2023 06:56:37 -0700 (PDT)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 00E4011D5;
        Tue,  6 Jun 2023 15:50:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 00E4011D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1686059445; bh=inf9czf+Fxft+0nBooxISAuEFReZinVPBtqDt/EIdoQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mUZRpAjzEIWL/Y6XLYQjIKsPJfvecZuVjnU7H5955AKOjs5pvEu3XBlIEOuxX/PGF
         05934txPHJYUIfplC71NAXLaHSGjDM7GI3aZIpGGVneL5K4nHYjutVhLlgINMvzLze
         NeWQq6BD6/njYHApvWVsDPmWICBfN4Ybj2918PO0=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Tue,  6 Jun 2023 15:50:32 +0200 (CEST)
Message-ID: <d0be2139-0dae-158b-2760-ab62080b73ba@perex.cz>
Date:   Tue, 6 Jun 2023 15:50:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 1/3] docs: sound: add 'pcmtest' driver documentation
Content-Language: en-US
To:     Ivan Orlov <ivan.orlov0322@gmail.com>, tiwai@suse.com,
        corbet@lwn.net, broonie@kernel.org, skhan@linuxfoundation.org
Cc:     alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        gregkh@linuxfoundation.org, himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20230606133807.14089-1-ivan.orlov0322@gmail.com>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20230606133807.14089-1-ivan.orlov0322@gmail.com>
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
> Add documentation for the new Virtual PCM Test Driver. It covers all
> possible usage cases: errors and delay injections, random and
> pattern-based data generation, playback and ioctl redefinition
> functionalities testing.

Acked-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

