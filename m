Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F54F6AAA86
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Mar 2023 15:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjCDOs7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 Mar 2023 09:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjCDOs6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 Mar 2023 09:48:58 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF22C6A68;
        Sat,  4 Mar 2023 06:48:56 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id ev13so3689564qvb.10;
        Sat, 04 Mar 2023 06:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677941336;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TsKKHJ0/GD+1zuzNsuCdWtAJjvxya3Twz8P8LNYqCwY=;
        b=o0XqqF9KH2cTPnL75tHljXD8nVLW6wpV2NwV7X4XXX+8CRd/3AiCnKdEDZYSwR76vS
         z8DZ8fDxhR9+Ldwet6gfGkh2EsHwkG4Dy7dIJF9dPCMa6YH7fOTsxGPuSPTCkAS8XnXz
         OfwYYEu30tPOkw33e6UktE/vuadPB2J8SBzRq91ZzIsoBzpFT+a/OEoRYN3MxofBSzE3
         n2D3eHQaHuIWSse1usU0WLHDT0VedC2vd3YjKYqeoWc8J/YzpCrNaTcZorTn2ZaYobKj
         vcDaPFP2HtRgLwcyZQk40ii3Uxz5WJNVJ4F+7fU5RfFO0z0TzUrHE3mMAIJLs5FvwND4
         pCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677941336;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TsKKHJ0/GD+1zuzNsuCdWtAJjvxya3Twz8P8LNYqCwY=;
        b=GV6rS7aCTFOg3Ji/DZkg9IQEpqkCrC/fJ8qy/+JMzJr6052Pn4ywdEvOgb7g6GCsIL
         CZ4pnSJHDxscBXlKM+Isu3D02NmCb63VW7o8RuJVIy7GjKNQhKXa2mm0t6l+x+LtbBn/
         vWx3cRoi7FhHF+1Fs1zm2QUAezoU+kszn+9Ah9yFUab58wpRZAbnT1a4QUX6nU6hmohM
         U/dYtzjvRyI5+OAWgVMIC5uhHY7EjPI7HIG3GXnsDcKK6uS95pMAwwdJDyw+mrIVm3D9
         SBKv/jiWnIhOFZWofVw9U8aqwnXU56F2CO24Q8TqCEVGMrLznxK5Hl4mqVkHt/FljpNv
         L70Q==
X-Gm-Message-State: AO0yUKVY9Ke2HkOTc/tNCNtOAhXWV5p3SsZU8qJ3kzyLdlE75ER+4PIp
        uhEd7cxPndSTiqOVIOCz+eg=
X-Google-Smtp-Source: AK7set/lpTeE6jSzoh7eLRmNQ2aPTpe64xLeLcMiiEyIor3lA8OcSo+NeLshc41rysf1tZHsq/I8fQ==
X-Received: by 2002:a05:6214:23c8:b0:583:a07b:554c with SMTP id hr8-20020a05621423c800b00583a07b554cmr2306311qvb.40.1677941335935;
        Sat, 04 Mar 2023 06:48:55 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:99e6:eec3:1daa:f163? ([2600:1700:2442:6db0:99e6:eec3:1daa:f163])
        by smtp.gmail.com with ESMTPSA id d82-20020a376855000000b007419eb86df0sm3835899qkc.127.2023.03.04.06.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 06:48:55 -0800 (PST)
Message-ID: <6668e83c-eb2c-7ac9-7b6f-2c8146c2175d@gmail.com>
Date:   Sat, 4 Mar 2023 08:48:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>, David Gow <davidgow@google.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
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
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAL_JsqJMd3Fi0ZBObdyE1VDKTH1_+smuGDymHnKOkVH2HB3jJQ@mail.gmail.com>
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

On 3/2/23 11:32, Rob Herring wrote:
> On Thu, Mar 2, 2023 at 2:14 AM David Gow <davidgow@google.com> wrote:
>>
>> On Thu, 2 Mar 2023 at 09:38, Stephen Boyd <sboyd@kernel.org> wrote:
>>>
>>> This patch series adds unit tests for the clk fixed rate basic type and
>>> the clk registration functions that use struct clk_parent_data. To get
>>> there, we add support for loading a DTB into the UML kernel that's
>>> running the unit tests along with probing platform drivers to bind to
>>> device nodes specified in DT.
>>>
>>> With this series, we're able to exercise some of the code in the common
>>> clk framework that uses devicetree lookups to find parents and the fixed
>>> rate clk code that scans devicetree directly and creates clks. Please
>>> review.
>>>
>>
>> Thanks Stephen -- this is really neat!
>>
>> This works well here, and I love all of the tests for the
>> KUnit/device-tree integration as well.
>>
>> I'm still looking through the details of it (alas, I've mostly lived
>> in x86-land, so my device-tree knowledge is, uh, spotty to say the
>> least), but apart from possibly renaming some things or similarly
>> minor tweaks, I've not got any real suggestions thus far.
>>
>> I do wonder whether we'll want, on the KUnit side, to have some way of
>> supporting KUnit device trees on non-UML architecctures (e.g., if we
>> need to test something architecture-specific, or on a big-endian
>> platform, etc), but I think that's a question for the future, rather
>> than something that affects this series.
> 
> I'll say that's a requirement. We should be able to structure the
> tests to not interfere with the running system's DT. The DT unittest
> does that.
> 
> As a side topic, Is anyone looking at getting UML to work on arm64?
> It's surprising how much x86 stuff there is which is I guess one
> reason it hasn't happened.
> 
>> Similarly, I wonder if there's something we could do with device tree
>> overlays, in order to make it possible for tests to swap nodes in and
>> out for testing.
> 
> Yes, that's how the DT unittest works. But it is pretty much one big
> overlay (ignoring the overlay tests). It could probably be more
> modular where it is apply overlay, test, remove overlay, repeat.

Actually, no, the bulk of the DT unittest devicetree data is _not_ an
overlay.  It is an FDT that is loaded via of_fdt_unflatten_tree() instead
of the overlay load API.  Note that the base DT unittest runs with
  CONFIG_OF_DYNAMIC=n
  CONFIG_OF_OVERLAY=n
so the overlay support code is not even present in the built kernel.

One can then enable CONFIG_OF_DYNAMIC to test the dynamic code.

One can further enable CONFIG_OF_OVERLAY to test the overlay code
(this will in turn select CONFIG_OF_DYNAMIC if not already enabled).

I would strongly discourage use of the overlay APIs for kunit tests,
unless the point of the kunit test is to test the overlay API.  Basic
tests should always be performed with devicetree data that has been
populated by the normal processing of an FDT during early boot.  If
one want to test proper overlay infrastructure functionality, then
those (essentially) same basic tests could/should be repeated with
devicetree data that has been populated by loading an overlay.

> 
> Rob

