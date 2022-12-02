Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE866402BF
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 09:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiLBI7Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 03:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbiLBI65 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 03:58:57 -0500
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0499C7D2E
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 00:56:46 -0800 (PST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 9B05FA0040;
        Fri,  2 Dec 2022 09:56:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 9B05FA0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1669971404; bh=Szcg+AUOhSUn375yy3z3M665b76gaws9om5cfurJA/M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eR7xUP0fMvc645RJl6zmSOo+x0e83wj58nQz+qalhuYHRhiaBi8iVWbvFl+xBW9MB
         bmFaDn8eKzG3s7G83NM4z32Xt/+LquD4uHf8CMTE4DTQMrgwcVtCpu9M45aILfs+a4
         3U3U0hasrRCtMD6XyMRlC7tHYEfiePK5fuOCKD0A=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Fri,  2 Dec 2022 09:56:39 +0100 (CET)
Message-ID: <66bef382-e38f-85d5-0e07-3cf672a89882@perex.cz>
Date:   Fri, 2 Dec 2022 09:56:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 0/6] kselftest/alsa: pcm-test improvements
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, alsa-devel@alsa-project.org,
        linux-kselftest@vger.kernel.org
References: <20221130000608.519574-1-broonie@kernel.org>
 <a55212fc-a676-2335-b861-94ba8d10f207@perex.cz> <87359zlz9t.wl-tiwai@suse.de>
 <Y4kOvNi5I8/GK1yU@sirena.org.uk> <87y1rqkzto.wl-tiwai@suse.de>
 <87wn7akzp7.wl-tiwai@suse.de>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <87wn7akzp7.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02. 12. 22 8:54, Takashi Iwai wrote:
> On Fri, 02 Dec 2022 08:52:03 +0100,
> Takashi Iwai wrote:
>>
>> On Thu, 01 Dec 2022 21:29:48 +0100,
>> Mark Brown wrote:
>>>
>>> On Thu, Dec 01, 2022 at 08:06:22PM +0100, Takashi Iwai wrote:
>>>> On Thu, 01 Dec 2022 18:42:22 +0100,
>>>> Jaroslav Kysela wrote:
>>>>>
>>>>> Let me know, if I can stack your changes on top, or perhaps, you may
>>>>> be willing to adapt them.
>>>>
>>>> As Mark has already sent a v2 series, I applied his v2 at first.
>>>> Could you rebase and resubmit on top of my for-next branch?
>>>
>>> Oh, this is getting a little confusing - I'd just picked Jaroslav's
>>> patch into my tree and was in the middle redoing my ideas on top of his
>>> code!  I might have something more later this evening...  I think we can
>>> converge here, let me continue taking a look.
>>
>> Ah then it was my misunderstanding, and everything should be fine now
>> ;)  Thanks!
> 
> Erm, you meant sent as *v3*.  I've seen now.
> 
> As the v2 patches were already merged, could you rather rebase and
> resubmit?  I'd like to avoid rebase the full series that are already
> included in linux-next.

It's rebased. The first patch from the set drops the previous Mark's changes.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
