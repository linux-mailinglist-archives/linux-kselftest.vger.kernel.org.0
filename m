Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7353D6AAA9E
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Mar 2023 16:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjCDPEz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 Mar 2023 10:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjCDPEw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 Mar 2023 10:04:52 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BDCFF1C;
        Sat,  4 Mar 2023 07:04:50 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id l18so6093022qtp.1;
        Sat, 04 Mar 2023 07:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677942290;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pu+adi69s8qFQuNWXMk5FXEup8uqRErroiF1b4Qu8ZQ=;
        b=jjwwn3Maiet7+ZIgdUXkyoKDgvraa1RGIHpDVqs6VgyIS8V+UhsVnKubicV++yqKT6
         eVgMRaJhxPnmHmjaz/o6oOemO0EU9u7TEKLv4kI20d8vvr2irc1PZ31aYaL3yjunZTnC
         juNCsy/uThYMHtVemSG3dKB62LPEhdTNvWjaHkyBQld2VCgWx9EpBVBc6pQpCuwz3u+K
         oUDDAAsk1bxkDiZFBzATsv6kDJBxFmHg9Qs0JRTQl8e9jqlqMyOWjFyiMGfFCqU6Lpyx
         UuCQhGxd/o5gBXxhHwYltHoOeLSOmFwcZcT9DjWvMd82HPvsUiWbVw0vSacphmZyzijZ
         uz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677942290;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pu+adi69s8qFQuNWXMk5FXEup8uqRErroiF1b4Qu8ZQ=;
        b=nDrXw8Oi6TgU0LLzLYZlZiszisZNgbj8hC4uZbzoK6hHudhwSIkWwYcBlO3IhgQHZa
         t4m7xxacE7FN8Ie/vF34aFPG2fcFXkCp6qWJcueVd5goZnXIGT0hTHjZER4B2tk2m0qd
         29ql1GWNFmbuLgAnjlwb3C9BnLkArL0gqBlRY8BxBV+PsT+RU/X8R8S6qN3dxbnm03uI
         pCLFVvHD8aEXh656+8AfSwrNoIGOnH50vUnlmyWS7ASkNyENaMDJ8U35aQSE1/u0HiiE
         ACLq1apqgtxcyviMWGCxlTTN3O7T8FFcG54xifewlc3tgtIpLzwlmi5KtgYoBhXzPyER
         THlA==
X-Gm-Message-State: AO0yUKXdsvWKubgwCYhXXyK+W+mxwphg0q2T5uT7ASuAWMqs4kBhLQGu
        IsdXaaBNCXHWIFGGaAu7xHo=
X-Google-Smtp-Source: AK7set9m7wI62m3NP2RoiyavT6E9DhvS2HzzjCtYnoNK7sgFFZNyQRKVCnuzrK3aiBHpkdifiKe4Uw==
X-Received: by 2002:a05:622a:1aa4:b0:3bf:c69c:e31c with SMTP id s36-20020a05622a1aa400b003bfc69ce31cmr9175282qtc.13.1677942290016;
        Sat, 04 Mar 2023 07:04:50 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:99e6:eec3:1daa:f163? ([2600:1700:2442:6db0:99e6:eec3:1daa:f163])
        by smtp.gmail.com with ESMTPSA id q1-20020ac87341000000b003bfa2c512e6sm3873388qtp.20.2023.03.04.07.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 07:04:49 -0800 (PST)
Message-ID: <5e26a786-400a-cd6c-8771-d94a8020839d@gmail.com>
Date:   Sat, 4 Mar 2023 09:04:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, David Gow <davidgow@google.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J.Wysocki" <rafael@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20230302013822.1808711-1-sboyd@kernel.org>
 <CABVgOSnpMNCtEEsJV28OzUoxdDuiT4a2T0avP0AYf9xFW1jxrw@mail.gmail.com>
 <CAL_JsqJMd3Fi0ZBObdyE1VDKTH1_+smuGDymHnKOkVH2HB3jJQ@mail.gmail.com>
 <3759b28cca7ab751296d4dd83f2dcc51.sboyd@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <3759b28cca7ab751296d4dd83f2dcc51.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/2/23 13:27, Stephen Boyd wrote:
> Quoting Rob Herring (2023-03-02 09:32:09)
>> On Thu, Mar 2, 2023 at 2:14 AM David Gow <davidgow@google.com> wrote:
>>>
>>> On Thu, 2 Mar 2023 at 09:38, Stephen Boyd <sboyd@kernel.org> wrote:
>>>>
>>>> This patch series adds unit tests for the clk fixed rate basic type and
>>>> the clk registration functions that use struct clk_parent_data. To get
>>>> there, we add support for loading a DTB into the UML kernel that's
>>>> running the unit tests along with probing platform drivers to bind to
>>>> device nodes specified in DT.
>>>>
>>>> With this series, we're able to exercise some of the code in the common
>>>> clk framework that uses devicetree lookups to find parents and the fixed
>>>> rate clk code that scans devicetree directly and creates clks. Please
>>>> review.
>>>>
>>>
>>> Thanks Stephen -- this is really neat!
>>>
>>> This works well here, and I love all of the tests for the
>>> KUnit/device-tree integration as well.
>>>
>>> I'm still looking through the details of it (alas, I've mostly lived
>>> in x86-land, so my device-tree knowledge is, uh, spotty to say the
>>> least), but apart from possibly renaming some things or similarly
>>> minor tweaks, I've not got any real suggestions thus far.
>>>
>>> I do wonder whether we'll want, on the KUnit side, to have some way of
>>> supporting KUnit device trees on non-UML architecctures (e.g., if we
>>> need to test something architecture-specific, or on a big-endian
>>> platform, etc), but I think that's a question for the future, rather
>>> than something that affects this series.
>>
>> I'll say that's a requirement. We should be able to structure the
>> tests to not interfere with the running system's DT. The DT unittest
>> does that.
> 
> That could be another choice in the unit test choice menu.
> CONFIG_OF_KUNIT_NOT_UML that injects some built-in DTB overlay on an
> architecture that wants to run tests.
> 
>>
>> As a side topic, Is anyone looking at getting UML to work on arm64?
>> It's surprising how much x86 stuff there is which is I guess one
>> reason it hasn't happened.
> 
> I've no idea but it would be nice indeed.
> 
>>
>>> Similarly, I wonder if there's something we could do with device tree
>>> overlays, in order to make it possible for tests to swap nodes in and
>>> out for testing.
>>
>> Yes, that's how the DT unittest works. But it is pretty much one big
>> overlay (ignoring the overlay tests). It could probably be more
>> modular where it is apply overlay, test, remove overlay, repeat.
>>
> 
> I didn't want to rely on the overlay code to inject DT nodes. Having
> tests written for the fake KUnit machine is simple. It closely matches
> how clk code probes the DTB and how nodes are created and populated on
> the platform bus as devices. CLK_OF_DECLARE() would need the overlay to
> be applied early too, which doesn't happen otherwise as far as I know.
> 
> But perhaps this design is too much of an end-to-end test and not a unit
> test? In the spirit of unit testing we shouldn't care about how the node
> is added to the live devicetree, just that there is a devicetree at all.
> 
> Supporting overlays to more easily test combinations sounds like a good
> idea. Probably some kunit_*() prefixed functions could be used to

In an imaginary world where overlay support was completed, then _maybe_.

To me, the most important  environment to test is where the devictree
data is populated in early boot from an FDT.  This is the environment
that drivers currently exist in.

Populating devicetree data via an overlay adds in the functioning of the
overlay apply code (and how the rules behind that functioning may differ
from devicetree data populated in early boot from an FDT).

In an ideal world where overlay support was completed, most or all of the
devicetree tests that were performed against the devicetree data populated
in early boot from an FDT would be repeated, but against comparable
devicetree data populated via an overlay load.  The tests with the overlay
data may have to be aware of some differences in how an overlay load
processes an FDT vs how the early boot processing of an FDT behaves.
This extra testing would verify that the overlay environment behaves
the same as the non-overlay environment (with some known exceptions
due to overlay policies).

Overlay support is not complete:

   https://elinux.org/Device_Tree_Reference#Mainline_Linux_Support

   https://elinux.org/Frank%27s_Evolving_Overlay_Thoughts

-Frank

> apply a test managed overlay and automatically remove it when the test
> is over would work. The clk registration tests could use this API to
> inject an overlay and then manually call the of_platform_populate()
> function to create the platform device(s). The overlay could be built in
> drivers/clk/ too and then probably some macroish function can find the
> blob and apply it.
> 
> Is there some way to delete the platform devices that we populate from
> the overlay? I'd like the tests to be hermetic.

