Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20686B10F9
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 19:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjCHSYz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 13:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjCHSYy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 13:24:54 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C084BAD2C
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Mar 2023 10:24:52 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id g3so69501145eda.1
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Mar 2023 10:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112; t=1678299891;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=weUKc1gFk3YK76PmJbUQm2uDC+7qg68lF0YoPIdM38U=;
        b=WC6qhziTG+HUxsT0RVO+qgUmADvjBEzJ1Fpg7NtZSe0zHetqM7+WrP/pLwzsNkdAId
         MXezDcnorfkScBOMwHKZ2cL0HLFo1QUGnx6g2xcyBTcIOiG4jzWGzsL8LsHvn/ihTOXl
         N5oRsi4aEZcWcA+7wjkztAofPpew1mXKzsJfL7g31bhDiwaIXLNazuSXkcSfvYkDGv46
         r4ezqi9NRWAN6VCgUdMO9/i9mkkQDvDgOj00I7EBG2bFxJFt7NkxtKN4kS//LqYS4XHO
         AwtOSuY574R8uaF9+aMfXG5mx6AfSEOlBB0PZY8p6k/5/4u2UjnATIr+qtX0YLg95pmD
         /b4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678299891;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=weUKc1gFk3YK76PmJbUQm2uDC+7qg68lF0YoPIdM38U=;
        b=di37oXcXLQbu41CvQe63DffGSRJd1ALXbZmrporWKvfJfzp1F2TtSJmSgZouj4M8bG
         +M3GyLzIUE+BoSp5RUuljrnWb+yvFObfrvmTo7eniXtm1jWiL/VJUmyo0usDc/OW6n3v
         la4XWbx+nb66UcX9hi36yRMoRjk0k/q2tRHWFa3eLsRVjV61oQv2HjBfqCGmUDcCrSQ1
         s7ZTkH6K6Y/AkXQu0pYVebXBEPkIqy7mF20j0LmIoyOLri5vmlESLyBDxsmTbXPyJGYi
         NqVOK6MfTMdKtLOmHECx4Aq8iU+LcFvcCIqHtHupwnzMub43nHpLw/nIvAnunNmExHiA
         +VkQ==
X-Gm-Message-State: AO0yUKUAdxPRGQzyk0Mqr5LTcNxZNX5uIyIqbeHKz4jWMpvsTIZnI34q
        RVDS767cX0iu800uQTWWX+/WchkLA8iH55SeIYE=
X-Google-Smtp-Source: AK7set9A1V50i8EcdZaJaGWkZIrp3PPjL/kaKhDvd7srdZZtoempWiehnOkDGgHadpOjyfOtqGmdig==
X-Received: by 2002:a17:906:d9c8:b0:8e1:cc38:6ab0 with SMTP id qk8-20020a170906d9c800b008e1cc386ab0mr17046218ejb.16.1678299890625;
        Wed, 08 Mar 2023 10:24:50 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id l3-20020a1709067d4300b008e54ac90de1sm7752698ejp.74.2023.03.08.10.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 10:24:49 -0800 (PST)
Date:   Wed, 8 Mar 2023 19:24:48 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, idosch@mellanox.com,
        danieller@mellanox.com, petrm@mellanox.com, shuah@kernel.org,
        pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net
Subject: Re: [PATCHv2] selftests: net: devlink_port_split.py: skip test if no
 suitable device available
Message-ID: <ZAjS8OAFd++ThaHV@nanopsycho>
References: <20230307150030.527726-1-po-hsu.lin@canonical.com>
 <ZAhV8nKuLVAQHQGl@nanopsycho>
 <CAMy_GT92sg4_JLPHvRpH542DPLbxOEYYoCMa2cnET1g8bz_R9Q@mail.gmail.com>
 <ZAh0fY4XoNcLTIOI@nanopsycho>
 <CAMy_GT_mLedbejcyTYkhEbuneuEvWycVi2orB82kC9ymXx0rng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMy_GT_mLedbejcyTYkhEbuneuEvWycVi2orB82kC9ymXx0rng@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Wed, Mar 08, 2023 at 03:37:41PM CET, po-hsu.lin@canonical.com wrote:
>On Wed, Mar 8, 2023 at 7:41 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Wed, Mar 08, 2023 at 11:21:57AM CET, po-hsu.lin@canonical.com wrote:
>> >On Wed, Mar 8, 2023 at 5:31 PM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> Tue, Mar 07, 2023 at 04:00:30PM CET, po-hsu.lin@canonical.com wrote:
>> >> >The `devlink -j port show` command output may not contain the "flavour"
>> >> >key, an example from s390x LPAR with Ubuntu 22.10 (5.19.0-37-generic),
>> >> >iproute2-5.15.0:
>> >> >  {"port":{"pci/0001:00:00.0/1":{"type":"eth","netdev":"ens301"},
>> >> >           "pci/0001:00:00.0/2":{"type":"eth","netdev":"ens301d1"},
>> >> >           "pci/0002:00:00.0/1":{"type":"eth","netdev":"ens317"},
>> >> >           "pci/0002:00:00.0/2":{"type":"eth","netdev":"ens317d1"}}}
>> >>
>> >> As Jakub wrote, this is odd. Could you debug if kernel sends the flavour
>> >> attr and if not why? Also, could you try with most recent kernel?
>> >
>> >I did a quick check on another s390x LPAR instance which is running
>> >with Ubuntu 23.04 (6.1.0-16-generic) iproute2-6.1.0, there is still no
>> >"flavour" attribute.
>> >$ devlink port show
>> >pci/0001:00:00.0/1: type eth netdev ens301
>> >pci/0001:00:00.0/2: type eth netdev ens301d1
>> >pci/0002:00:00.0/1: type eth netdev ens317
>> >pci/0002:00:00.0/2: type eth netdev ens317d1
>> >
>> >The behaviour didn't change with iproute2 built from source [1]
>>
>> Could you paste output of "devlink dev info"?
>> Looks like something might be wrong in the kernel devlink/driver code.
>>
>The `devlink dev info` output is empty. The following output is from
>that Ubuntu 23.04 s390x LPAR, run as root:
># devlink dev show
>pci/0001:00:00.0
>pci/0002:00:00.0
># devlink dev show pci/0001:00:00.0
>pci/0001:00:00.0
># devlink dev info
># devlink dev info pci/0001:00:00.0

Interesting, could you try ethtool -i to get the driver name?


>kernel answers: Operation not supported
>
>>
