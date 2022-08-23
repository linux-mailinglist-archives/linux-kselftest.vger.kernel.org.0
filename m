Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD0D59D2F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 10:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241504AbiHWIB2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Aug 2022 04:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241676AbiHWIBK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Aug 2022 04:01:10 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA366583F;
        Tue, 23 Aug 2022 01:01:05 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 12so11609176pga.1;
        Tue, 23 Aug 2022 01:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=HRrhm1OCNU6Rzc/6RElpNPDfHW8dOdiCLMY7G0msAVs=;
        b=ZSh5LlmpzYLzRJD1ZPCLTefJqXByy4iVoGCBZUJINS+96KTDE6lqkwJUJp4jcJxeBu
         vz7gnhr4Gppzi5sTcR9GfAUwKKVIQRjn9lDqRg+kgT2O48Hn2o1dxxctH5fxK0YsMAT6
         jY28uALlLtR/mHVz4nSCq2xP24XhXv/myZgFZlgcKvYL+SRTOKGyfN8AISTfdQfvwWuO
         Ab7IpmyBusnraHPjycVaMvddrXXT7d7uvvnKE1cvpxkis7Q83HZA05MswILjsZRLROqE
         +dUOtItweJNIPj+RLIO+JAm8NUEsIwdPy4YUgtVpRqr71AUXZL4pYN1kcUpksV9F8FlD
         2RkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=HRrhm1OCNU6Rzc/6RElpNPDfHW8dOdiCLMY7G0msAVs=;
        b=c3VnYHgepVzNF+aUVML7nZ3mmRNsLppoWxoXnfVgN8OUR0dmj5OxvdFZcS3urkJybK
         GZRdEzX5ngQma6sxwrbwm0juj6krUo1xUYPkUx653+LAXVRkadeWVZP0L5QUebpff2Bh
         1BMx5BTNcOPXZBGPCwQx6THLNDG/Efc9fcqHVZGzRdY+/X+Eb+jMYNIn80wA6S23IXIc
         X5tM/4VkweO8dzKh/z2dyt1IONsr4eDowXtzu/Etig37h9cCMog/ScdjX0zs0QE7ismb
         ttDrlNQkrwSCljzVyGsE6Ln/+1OV1m1cnNLmqmwvcXUKYN1ZyBCE4ckd64J29mrFDiqU
         uf/Q==
X-Gm-Message-State: ACgBeo3vBMLeCyOungtdbbYeu9EIqODsh19/qi5aqAOH7Tk6DaWOrrPO
        l2i3YjlAx/jZxsB9SbYpOQ0=
X-Google-Smtp-Source: AA6agR75Dmauw0vow8pbc98O1+rJA6RcI+MuCA9MuUn9EtMqwEbLJJnLOVvTxRHtPT7PcrrwTZdMpw==
X-Received: by 2002:a63:125c:0:b0:427:a637:3414 with SMTP id 28-20020a63125c000000b00427a6373414mr19708574pgs.80.1661241665299;
        Tue, 23 Aug 2022 01:01:05 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-14.three.co.id. [180.214.232.14])
        by smtp.gmail.com with ESMTPSA id o16-20020aa79790000000b00535dc0a14d1sm9710471pfp.130.2022.08.23.01.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 01:01:02 -0700 (PDT)
Message-ID: <55ba0c48-d735-07ba-9121-5accec6e31e3@gmail.com>
Date:   Tue, 23 Aug 2022 15:00:55 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] Documentation: KUnit: Reword kunit_tool guide
Content-Language: en-US
To:     Sadiya Kazi <sadiyakazi@google.com>, brendanhiggins@google.com,
        davidgow@google.com, skhan@linuxfoundation.org, corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220822180956.4013497-1-sadiyakazi@google.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220822180956.4013497-1-sadiyakazi@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/23/22 01:09, Sadiya Kazi wrote:
> Updated the kunit_tool.rst guide to streamline it. The following changes
> were made:
> 1. Updated headings
> 2. Reworded content across sections
> 3. Added a cross reference to full list of command-line args
> 

What about this description:?

"Rework kunit_tool How-To, which includes:
- grammatical fixes
- change title to 'Understanding kunit_tool', and
- add a reference link to command line arguments list."

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
