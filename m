Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A13638DC2
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Nov 2022 16:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiKYPvj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Nov 2022 10:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiKYPvb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Nov 2022 10:51:31 -0500
X-Greylist: delayed 611 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Nov 2022 07:51:29 PST
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11DD4A590
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 07:51:29 -0800 (PST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id B0582A003F;
        Fri, 25 Nov 2022 16:41:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz B0582A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1669390875; bh=Vr+slmbJDu/gySeRjOckDYc8ItlXrV4V89WNVv09bjs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=F5IqYe0VmL2Pg+f+GdhesoYTXi0TVOfCpIMeFQA0edEK+XxuDkzrGVAZkmBpRJypF
         8e6Fl2XibL6jtddwrsUducBLe8NUHcM+lpRVBHXBa7T8myc6Q6cbfrUeFdd/YxPMvn
         xsUmddY1W7/Zk1IoCQHEsWDK6JpWZ3+kjSP9Ld2o=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Fri, 25 Nov 2022 16:41:10 +0100 (CET)
Message-ID: <77485fea-8aa9-9c95-8d6a-7a35994d0a84@perex.cz>
Date:   Fri, 25 Nov 2022 16:41:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] kselftest/alsa: Add a .gitignore for the newly added PCM
 test
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org
References: <20221125153654.1037868-1-broonie@kernel.org>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20221125153654.1037868-1-broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 25. 11. 22 16:36, Mark Brown wrote:
> The newly added PCM test produces a binary which is not ignored by git
> when built in tree, fix that.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Thanks,

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

> ---
>   tools/testing/selftests/alsa/.gitignore | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/alsa/.gitignore b/tools/testing/selftests/alsa/.gitignore
> index 3bb7c41266a8..2b0d11797f25 100644
> --- a/tools/testing/selftests/alsa/.gitignore
> +++ b/tools/testing/selftests/alsa/.gitignore
> @@ -1 +1,2 @@
>   mixer-test
> +pcm-test


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
