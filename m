Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B865D46B56F
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 09:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhLGIRU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 03:17:20 -0500
Received: from mail1.perex.cz ([77.48.224.245]:51482 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232277AbhLGIRU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 03:17:20 -0500
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Dec 2021 03:17:20 EST
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 26E37A0040;
        Tue,  7 Dec 2021 09:05:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 26E37A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1638864349; bh=1orcYpfi/OgeJ4wNPA5bcXbBCkkoQFBO4OLDelq5IzI=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=bxlAi9XA9DALDvGb6GMD6pgGDFtfNDa9MPWA6sAc3rroPYm6m3bowDSY4yzc/GbOY
         INuAxefzWFZWd0d2/jyc6z4gGyLTIJAl3rr/AeXakLZQ3blH0R7IaTOb1Vgn8c1pXL
         b621BVcIL38JyaMquawLuOF4ft7qDnFuT7HUGYkE=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Tue,  7 Dec 2021 09:05:44 +0100 (CET)
Message-ID: <77e39efd-e49d-cea1-1822-0e2262a766c9@perex.cz>
Date:   Tue, 7 Dec 2021 09:05:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] kselftest: alsa: Add simplistic test for ALSA mixer
 controls kselftest
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Shuah Khan <shuah@kernel.org>, alsa-devel@alsa-project.org,
        linux-kselftest@vger.kernel.org
References: <20211206160305.194011-1-broonie@kernel.org>
 <Ya7TAHdMe9i41bsC@workstation>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <Ya7TAHdMe9i41bsC@workstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 07. 12. 21 4:20, Takashi Sakamoto wrote:
> As another topic, the runtime of alsa-lib application largely differs
> between process user due to the result of parsing text files for
> configuration space. I can easily imagine that developers unfamiliar to
> alsa-lib carelessly adds invalid or inadequate configurations to files
> under target path of alsa-lib configuration space, and they are puzzled
> since they are unaware of the fact that the kselftest is affected by
> userspace stuffs for the runtime.
The alsa-lib configuration can be restricted. I would suggest to use 
snd_ctl_open_lconf() function with a simple configuration which defines only 
ctl.hw device. In this case, the global configuration is not used, so the user 
errors are eliminated. Another way is to use the environment variable for the 
global alsa-lib configuration - ALSA_CONFIG_DIR.

I will try prepare a patch for snd_ctl_open_lconf().

					Jaroslav

BTW: Thank you Mark for this test.

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
