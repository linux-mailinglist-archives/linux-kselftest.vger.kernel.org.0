Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1509946DBB3
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 19:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239477AbhLHTCx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 14:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhLHTCw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 14:02:52 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ABBC061746
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Dec 2021 10:59:19 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id z26so3874403iod.10
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Dec 2021 10:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R2GgLJCPFe6bG/Ww1U3d3+U9ugmUPZHTlFwdNjfcLnU=;
        b=IvAcBlxqxCjoi10qfrfFMvChQVgExyIQ5rL7YfDbw60PIiZTug9MT0fZIG0qTQXIYi
         ZYFKWEMMu4zlA0IHfETv3Z87ZUg7VGs+aMwricz+vimMSTWsZIrixozpwWXaPiJsIsYu
         28VOdzhqIYNBdhe8MFEpcxKZx3aQzg1v5DMr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R2GgLJCPFe6bG/Ww1U3d3+U9ugmUPZHTlFwdNjfcLnU=;
        b=NRgeDeOVL9tqWKXvw3Y6uVEEqQ6+0tcHsxPL/rppkhYAfHUCgIbXa4lnlM7vNthZtu
         AYF7ud+YujY/MLiRgjFJ5T69aKgGjkaFqviTgcuY1Ddz7Kb1XDPyBylKIJI490dDqd6X
         RkwLehwAMpbK/SXAimwuRiAllEDND3wDhHPV045wD+oBd1UoaGqQO/caWViENdVdAe9M
         Y1rDRoF/T/Mc5IYJGeDAFziSa0uP+HONkx2eHRUyvqMdCiBQU41CYRcfcdQwPTz2LLto
         nWApcnF0qbxIyp4jsh9NJJRrX1LuRXgxWbR0OAv3JktDUmAsxQBRBYjFKNO/xccSvVq9
         VlFA==
X-Gm-Message-State: AOAM530eckBlNVtr4c8eHgj3fJTDplerxFUa4GDPN8vGgcvNGQHj9JXr
        h1kAGyj5iGnsx+5Sh16C8+Hjetu5YQY9+A==
X-Google-Smtp-Source: ABdhPJyBSwL6g8/udxMy8+1IFMWT8tKmU+PAl+WCWN4trWQzTCYfIUoHy5NdGHulLHsCXMELvRCQ2Q==
X-Received: by 2002:a6b:2ccf:: with SMTP id s198mr8308321ios.101.1638989959294;
        Wed, 08 Dec 2021 10:59:19 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y11sm2166162ioy.19.2021.12.08.10.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 10:59:18 -0800 (PST)
Subject: Re: [PATCH v2] kselftest: alsa: Add simplistic test for ALSA mixer
 controls kselftest
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.de>, Shuah Khan <shuah@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        linux-kselftest@vger.kernel.org, alsa-devel@alsa-project.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211206160305.194011-1-broonie@kernel.org>
 <de0c5677-c2cf-d1ab-68c5-2f410d17b66c@linuxfoundation.org>
 <YbD7+C74DFlZEokt@sirena.org.uk>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <37f87d39-b5a9-46f6-2667-c0b7aafb731a@linuxfoundation.org>
Date:   Wed, 8 Dec 2021 11:59:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YbD7+C74DFlZEokt@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/8/21 11:39 AM, Mark Brown wrote:
> On Wed, Dec 08, 2021 at 10:42:35AM -0700, Shuah Khan wrote:
>> On 12/6/21 9:03 AM, Mark Brown wrote:
> 
>>> +SOUND - ALSA SELFTESTS
>>> +M:	Mark Brown <broonie@kernel.org>
>>> +L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> 
>> Please add linux-kselftest list as well here.
> 
> get_maintainers pulls it in from the wider entry (the mention of
> alsa-devel is reudnant too).
> 
>>> +int num_cards = 0;
>>> +int num_controls = 0;
>>> +struct card_data *card_list = NULL;
>>> +struct ctl_data *ctl_list = NULL;
> 
>> No need to initailize the above globals.
> 
> They're not declared static so the initial value is undefined.
> 
>>> +void find_controls(void)
>>> +{
>>> +	char name[32];
> 
>> Use SYSFS_PATH_MAX = 255 like other tools do?
> 
> This isn't a path, it's an ALSA limit for a name that is embedded in a
> struct (snd_ctl_card_info->name).  There's no magic define for these
> lengths.
> 
>>> +
>>> +			ctl_data->next = ctl_list;
>>> +			ctl_list = ctl_data;
>>> +		}
>>> +
>>> +	next_card:
> 
>> No need to indent the label
> 
> No need but it looks wrong otherwise - it's certainly what I'd expect
> for normal kernel code.
> 
>>> +	if (snd_ctl_elem_info_is_inactive(ctl->info)) {
>>> +		ksft_print_msg("%s is inactive\n", ctl->name);
>>> +		ksft_test_result_skip("get_value.%d.%d\n",
>>> +				      ctl->card->card, ctl->elem);
>>
>> The two messages could be combined?
> 
> The user facing control names almost always have spaces in them so while
> it's useful to have them for diagnostic purposes I don't think it's a
> good idea to put them in the KTAP test names, that's likely to confuse
> things trying to work with the KTAP output.  The general pattern I'm
> following for these tests is to print one or more diagnostic lines
> explaining why a tests was skipped or failed with the human readable
> control name so people can hopefully figure out what's going on and have
> the KTAP facing name that tooling will deal with be a consistent
> test.card.control format for parsers and databases dealing with test
> results en masse.
> 

Fine with me.

>>> +bool test_ctl_write_valid_boolean(struct ctl_data *ctl)
>>> +{
>>> +	int err, i, j;
>>> +	bool fail = false;
>>> +	snd_ctl_elem_value_t *val;
>>
>> Add blank line after declarations.
>>
>>> +	snd_ctl_elem_value_alloca(&val);
> 
> This is idiomatic for alsa-lib code.

This is kernel code that is going into kernel sources. Why follow
alsa-lib convention?

> 
>>> +int main(void)
>>> +{
>>> +	struct ctl_data *ctl;
>>> +
>>> +	ksft_print_header();
> 
>> Add a check for root and skil the test.
> 
> There is no need for this test to run as root in most configurations,
> it is common to provide direct access to the sound cards to some or all
> users - for example with desktop distros the entire userspace audio
> subsystem normally runs as the logged in user by default.  alsa-lib's
> card enumeration should deal with any permissions problems accessing
> cards in the system cleanly.  If the user running the test can't access
> any cards or the cards that can be accessed don't have any controls to
> test then we will find no controls during enumeration, report a plan to
> do zero tests and then exit cleanly which seems reasonable to me.  If we
> do need to explicitly bomb out rather than report zero tests we should
> be doing it based on the number of controls we find rather than the user
> we're running as.
> 

On my system, I don't see any output if run as root. Are there some tests
that work as non-root?

thanks,
-- Shuah
