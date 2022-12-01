Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FD763F94E
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 21:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiLAUnD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 15:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiLAUnD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 15:43:03 -0500
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2CEBC5A9
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 12:42:59 -0800 (PST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 78974A003F;
        Thu,  1 Dec 2022 21:42:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 78974A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1669927377; bh=DEwP8nMLHnDBOZ3c8IS79m9bPpNTDwSbomxfT0giryY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=5l8K3rxlYqo7uWuBTMHOUCKXSg5iCAFy3Vz4WlOPpfpSbxhRDe1YnrWRLcLidQ2np
         R3G6wm6mFAFGyMpb8gJWB05ucFYq3PUL7CfRl6KfVgj9WeMD8QF0cuW8CDt3owOxhy
         tC9lik1vNAQ9KZg3HxwtL3b2+3/BtuNyLVqiYLBk=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Thu,  1 Dec 2022 21:42:52 +0100 (CET)
Message-ID: <92abef25-2cbc-eb10-bb4d-e9cae06d7383@perex.cz>
Date:   Thu, 1 Dec 2022 21:42:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] kselftests/alsa: pcm - move more configuration to
 configuration files
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     ALSA development <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.de>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
References: <20221201173333.2494019-1-perex@perex.cz>
 <Y4kF7fG70EySxDQn@sirena.org.uk>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <Y4kF7fG70EySxDQn@sirena.org.uk>
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

On 01. 12. 22 20:52, Mark Brown wrote:
> On Thu, Dec 01, 2022 at 06:33:33PM +0100, Jaroslav Kysela wrote:
> 
>> Obtain all test parameters from the configuration files. The defaults
>> are defined in the pcm-test.conf file. The test count and parameters
>> may be variable per specific hardware.
> 
>> Also, handle alt_formats field now (with the fixes in the format loop).
>> It replaces the original "automatic" logic which is not so universal.
> 
>> The code may be further extended to skip various tests based
>> on the configuration hints, if the exact PCM hardware parameters
>> are not available for the given hardware.
> 
>> --- a/tools/testing/selftests/alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf
>> +++ b/tools/testing/selftests/alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf
>> @@ -55,6 +55,14 @@ card.hda {
>>   				period_size 24000
>>   				buffer_size 192000
>>   			}
>> +			test.time3 {
>> +				access RW_INTERLEAVED
>> +				format S16_LE
>> +				rate 44100
>> +				channels 2
>> +				period_size 24000
>> +				buffer_size 192000
>> +			}
> 
> I really do think we should be giving these names which help people
> understand what the tests are intending to cover, it'll make it easier
> to both understand the results and maintian the configurations going
> forward.  Or at least commenting things, but names is probably better.
> Since the timeN is also used to figure out what type of test we're doing
> that'd mean either adding an explicit test_type field

I'm fine with the new / more descriptive / names. I just concentrated to the 
functionality.

>>   	for (pcm = pcm_list; pcm != NULL; pcm = pcm->next) {
>> -		test_pcm_time1(pcm, "test.time1", "S16_LE", 48000, 2, 512, 4096);
>> -		test_pcm_time1(pcm, "test.time2", "S16_LE", 48000, 2, 24000, 192000);
>> +		cfg = pcm->pcm_config;
>> +		if (cfg == NULL)
>> +			cfg = default_pcm_config;
>> +		cfg = conf_get_subtree(cfg, "test", NULL);
>> +		if (cfg == NULL)
>> +			continue;
>> +		snd_config_for_each(i, next, cfg) {
> 
> I can see the benefit in moving the defaults to a configuration file
> instead of code but rather than having it be an either/or it seems much
> better to have the board specific configuration file extend the
> defaults, resulting in us looping over both files if we've got both.
> We'd need to have something that avoided collisions, perhaps the
> simplest thing would be to just add an element into the printed test
> name for the source of the config so we get output like:
> 
> 	ok 1 test.default.time1.0.0.0.PLAYBACK
> 	ok 2 test.system.time1.0.0.0.PLAYBACK
> 
> That does mean that the system test list can't replace the generic test
> list but like I said elsewhere I think that would be a good thing for
> clarity anyway ("X works on system A but not the very similar system B,
> what's broken about system B...").

As for the generic tool, I would like to have an option to control all mechanisms:

1) only default config
2) only hw specific config
3) default + hw specific configs (merged)

A new field in the pcm configuration may be added for this to build the 
per-device-stream configuration. If we merge those two configs, I think that 
only a field which will skip the default config is sufficient to cover all 
possibilities. The test names are a good identification, what was executed.

>> --- /dev/null
>> +++ b/tools/testing/selftests/alsa/pcm-test.conf
>> @@ -0,0 +1,16 @@
>> +pcm.test.time1 {
>> +	format S16_LE
>> +	alt_formats [ S32_LE ]
>> +	rate 48000
>> +	channels 2
>> +	period_size 512
>> +	buffer_size 4096
>> +}
>> +pcm.test.time2 {
>> +	format S16_LE
>> +	alt_formats [ S32_LE ]
>> +	rate 48000
>> +	channels 2
>> +	period_size 24000
>> +	buffer_size 192000
>> +}
> 
> It's probably especially important that anything in a default
> configuration should skip on the constraints not being satisfied since
> we've no idea what the hardware we're running on is.  Rather than
> requiring skipping to be explicitly configured perhaps we could just set
> a flag based on if we're reading the default tests or a system specific
> file, I'm not sure I see a sensible use case for system specific tests
> specifying a configuration that can't be satisfied.  Doing things that
> way the flag could either mean we add skipping or that we report two
> results for each configured test:
> 
> 	not ok 1 test.system.time1.0.0.0.PLAYBACK.constraints
> 	ok 2 test.system.time1.0.0.0.PLAYBACK # SKIP
> 
> which is perhaps marginally simpler to implement and makes it clearer in
> the results if it was a straight up logic failure rather than a timing
> failure.
> 
> I would also like to see 44.1kHz, 96kHz and at least one mono and one 6
> channel configuration adding (in my patches I added 8kHz mono since it's
> the most common practical mono format and 8kHz stereo so if 8kHz mono
> doesn't work it's a bit more obvious if it's mono or 8kHz that's broken).
> That could definitely be done incrementally though.

I've not really have any objections about this.

As Takashi already applied your set, I'll try to merge my code with yours and 
keep the added functionality.

				Thanks,
					Jaroslav
-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
