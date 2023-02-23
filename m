Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA01E6A12B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Feb 2023 23:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjBWWRc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 17:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBWWRb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 17:17:31 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2125014239;
        Thu, 23 Feb 2023 14:17:31 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id pt11so15196425pjb.1;
        Thu, 23 Feb 2023 14:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ja6bwsbBgKbtI7vlqB2IDNzFjfg8afhxdND/pliSXOQ=;
        b=lyYCffrF7Uws9PpIM406nmk26TXxEk4SXJltBAPXgZmk0f8s8wuDHDx7973kHFbfss
         1u/eXC6WXJv1ifth+4+NS+Mj7gsgIQykvergPg7A4ImewQOH2Ed0xrz4hiTqQqjIPtnD
         s14lfgNOTnb7Oogsh8PtHQKesA1GWyzPhwKbGX00lraNHBQ+1PLJEOkiJaJfP2bC25cT
         d2YI8gXb5eKn1MzpTMw4aFS6brnyGLfQr6a9hH7cJhZBJ72Up0xNX5MI4b/xlbyPs73e
         jwEvUx6Im7caAcXjwuK/h+Bvm6/DrUGQfKMblvu1Ixn+aG1ZD5R2rHoa16ostnpqWzfx
         J8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ja6bwsbBgKbtI7vlqB2IDNzFjfg8afhxdND/pliSXOQ=;
        b=0lWnT2EvQuBF0dFxaft45gckTntxMBk/ybqf3RxEQxUOykFxwKSIsQ07Ff8wNAKw10
         NAzPvhhmOy79cv489Yu5XCFEFW+HDwPNvgnn6vaztYp+4xkldSsOzjEIAP/g/DPkE7oT
         p5kp+lbxi9jvSCF94g1Cd8S7OmXyIKPa8Kfk/j2NMI2AEDf2uNVNV9Tek/tmIyn3AYPr
         ye7Pt8YxaXvqUXw3Owe32US7B8Vvz2VfZDkYItswe7G3+zorfTkrEroRjDRd7yRSG8yM
         kikvB0+xYvqgdVXGuFs8MsrC+n7klTBNMEVkoaUb+d3KXiYpBLvWl3bGp/xnp1NJeaoj
         EzZA==
X-Gm-Message-State: AO0yUKUIGEYW4TziFHCn9pa85qIOF7hh668pfnaUeagzRiUDXdNhL2bN
        Ar+z2n3/l4zS+2n12SAbrYI=
X-Google-Smtp-Source: AK7set8vjVJGC9vpvHJKpESrO3RwjyD31nlnCbUhzjRzLJxkOj44LW9ApKlEiv26/S7KmWAjpCm7Fg==
X-Received: by 2002:a17:903:228d:b0:19b:33c0:4097 with SMTP id b13-20020a170903228d00b0019b33c04097mr14081775plh.27.1677190650595;
        Thu, 23 Feb 2023 14:17:30 -0800 (PST)
Received: from ?IPV6:2001:df0:0:200c:5169:eed6:c2d0:93c3? ([2001:df0:0:200c:5169:eed6:c2d0:93c3])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902a3cd00b0019cc88bee09sm943353plb.58.2023.02.23.14.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 14:17:30 -0800 (PST)
Message-ID: <61e478c7-6685-4702-71ac-a4fa2643d3d8@gmail.com>
Date:   Fri, 24 Feb 2023 11:17:24 +1300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 00/41] RPCSEC GSS krb5 enhancements
Content-Language: en-US
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "simo@redhat.com" <simo@redhat.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>
References: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
 <b3e0b5e6-1d0-cdb2-186c-6b4f50e0a3aa@linux-m68k.org>
 <D5221DC2-2A9C-43DC-AC21-FA96E7F76E5B@oracle.com>
 <CAMuHMdVtsZ-jU5foR7V_4XeXT_0f3Nx5vfoJo5pH2jMga0SpWA@mail.gmail.com>
 <58CCF033-58C3-4AF0-B958-BE1AAF1695F3@oracle.com> <87mt54e02i.fsf@igel.home>
 <4697cebe-5399-17f6-4580-99f3f3c86db6@gmail.com> <87cz60dphr.fsf@igel.home>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <87cz60dphr.fsf@igel.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Andreas,

On 24/02/23 10:46, Andreas Schwab wrote:
> On Feb 24 2023, Michael Schmitz wrote:
>
>> Hi Andreas,
>>
>> On 24/02/23 06:57, Andreas Schwab wrote:
>>> On Feb 23 2023, Chuck Lever III wrote:
>>>
>>>> Assuming that "PC:" on m68k is the same as "RIP:" on x86...
>>>> this does not make sense. rfc6803_suite is not a function.
>>> That can mean that something has overwritten the return PC.
>>>
>> Wouldn't you expect a format error in that case?
> What format error do you mean?  There was a chk exception, presumably
> because the first word of rfc6803_suite happens to match the encoding of
> the chk insn.

I got confused by 'return PC' and thought the exception had happened on 
a return instruction (but even that would be unlikely - only rte can 
generate a format error ...).

Your explanation is more likely to be correct. Would that Geert had 
copied the code snipped from the log.

Cheers,

     Michael


