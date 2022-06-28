Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86FE55C126
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jun 2022 14:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245336AbiF1CeZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jun 2022 22:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245595AbiF1Ccw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jun 2022 22:32:52 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2FA26119;
        Mon, 27 Jun 2022 19:31:59 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id n16-20020a17090ade9000b001ed15b37424so11217794pjv.3;
        Mon, 27 Jun 2022 19:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1D6098QXfD4lxJsJt5htd+5+E2f/T5MbElTqQLF2bHQ=;
        b=Xdvj4ubmXrXXW04630PMNgjvs2MFg8GcDnLu/vN71vyNDvboUZKTjNJ+ZX4R5eqA8/
         jGQHmVaYsxppLnc5jon6+XPPUAQMlD7dbQ6DORV+3FDL9LDZ6HmONcP4YCWFgQ9OPRpW
         C8hqMJVWTmJPp7UdWhzpEegNGpEsJav8DbyO2o3UuXmat8bhJDQ4LtZ8sFO3vG8FDC1i
         i7zj0CzqLOsVhTHGVT9fiBKfKkMWYXfaGoQHZze+7UY+FKOucuoCZ+oz/+SavgP+6+wX
         xrEQJs6n5lCFqWpZWcxxBAOn+ZLAC60p//wK++OipoHZjVIM7MjcX6BqTMfOuM6rq7IR
         ThYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1D6098QXfD4lxJsJt5htd+5+E2f/T5MbElTqQLF2bHQ=;
        b=MPS94N1vgqFn1CJz5GBbJIOFJSvspzoPeupzrYcnDCoL/nrjSCU0eWJQixZ6petN+w
         Bc/cjEPSsj7DUNP7cjr/lmevewRAA0ov+VccAL4P59nSnnZ9HahPZvKdCiLSVfVjB9X8
         m33VtZmY9jZbDXkSgALofZmMukf59fzeKr6Od6KBfZ6k3MT3HZJPhX3CubTkRA/bAUOF
         +RjFDf2hR0idBJNDA8qk9qSGOmPpGQNK76hxyUmk9YA3g8OBlmhJePxJVpVz9NF4wrEa
         n9S0ZWyXMwYYf6lV3jfuiIHShPon7O6AcXCuuBLKWVfyNmMg9VZ9b+E0qbDA5+BtQmTp
         3yTQ==
X-Gm-Message-State: AJIora+7X2EF64q7nfJysOLH0dQih1sjeR5ydTcdCWsdFk0w4xfRrbZY
        gb6LfnYs/4cd5FTPlRUTpIA=
X-Google-Smtp-Source: AGRyM1ttxJ2pGSBRzNEiyuxlBlgOzbglHMzIZx6uOVYQ3UBEFzkDSnxDfhszDF01+uQiiE1gnJuH+w==
X-Received: by 2002:a17:90a:aa10:b0:1ec:b5a7:9e23 with SMTP id k16-20020a17090aaa1000b001ecb5a79e23mr24418846pjq.191.1656383518950;
        Mon, 27 Jun 2022 19:31:58 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-91.three.co.id. [180.214.232.91])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090a55c700b001cd4989feebsm10235005pjm.55.2022.06.27.19.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 19:31:58 -0700 (PDT)
Message-ID: <add4c89c-f774-f241-6108-2051e9d69a0e@gmail.com>
Date:   Tue, 28 Jun 2022 09:31:53 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v13 4/4] Documentation: trace/objtrace: Add documentation
 for objtrace
Content-Language: en-US
To:     Jeff Xie <xiehuan09@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Song Chen <chensong_2000@189.cn>
References: <20220626025604.277413-1-xiehuan09@gmail.com>
 <20220626025604.277413-5-xiehuan09@gmail.com> <YrkSkuluNhGcMyOu@debian.me>
 <CAEr6+EAesikgaZGCfgB4LQLkD=7rQ-LckRpNoXYq31QZ4pL9sA@mail.gmail.com>
 <CAEr6+ECTFauRPzVAH+znERX=K4fxOyB23E=6yX6avCt8LS9MoA@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAEr6+ECTFauRPzVAH+znERX=K4fxOyB23E=6yX6avCt8LS9MoA@mail.gmail.com>
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

On 6/28/22 08:37, Jeff Xie wrote:
> Hi Masami,
> 
> I would like to ask if I change the document like "Bagas Sanjaya"
> rewording in the next version.
> I don't know if I can add your Reviewed-by again, I don't know the
> rules very well ;-)
> 

In the next version roll, just mention the feedback in the patch
changelog (but not in the patch message as would appear on git log).

-- 
An old man doll... just what I always wanted! - Clara
