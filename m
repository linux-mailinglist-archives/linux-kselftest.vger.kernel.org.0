Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9418B6A0F56
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Feb 2023 19:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjBWSTh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 13:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBWSTg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 13:19:36 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2872C665;
        Thu, 23 Feb 2023 10:19:35 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id u14so10119782ple.7;
        Thu, 23 Feb 2023 10:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V80W4jkZI8rAQF3tFsJQUmX5uvaFNWymIoc6/ZkKKMc=;
        b=ZxWSZkwLn3hQD0gwyf6W6fBMA5yc3kDk4MNjwqJDplU4ummDgFc2dfxzviOuh2KipX
         KeByUb6C5p1qsQQod50DUy02E6PT3cVCU7jG+DP7kARlZCsstKo2187Yt7sJUl/g4nya
         rCuOwCw+GQrvapkjJ4RAvRRD+lWw3SGwanhOYw9SyrC/N+hZBCrgDsewzjq7d+6d+AAo
         bHWTka3mXzRljMVNniuTSCV6/a3EJUFT8S5FejnEoxDFYixTklW/gePiG9zqpwT3gUtu
         HIlZ1FSvka28GwYJGHIAgtBPz6MGHQIW0hWtxG/iVJ0Gwp++0J6gTqgJnevKMTnDIZ1y
         wHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V80W4jkZI8rAQF3tFsJQUmX5uvaFNWymIoc6/ZkKKMc=;
        b=T36lbaGFkx7Q7ReZ5ULjVTNsDxlFg4kIIozks360CR6y9BILkBocEizMRkVOzwMweh
         1//GAaOxXEKw6fe3bbhQKgmkG+3uSTZP+iT3yJSxxIh0I6UKNbf0wjME43m7PAbs00kM
         hBnjiq89BRwZt9YOOH1miy5CEF7LcYOeuYu6Mr6lrpFUJGlrtniZk6HOt6ZseU7AdPaT
         s75ivEHEnXQ9P4T+mQe4s5pOlS23u7CDVqS/nJELhDyyCyXdQTamdyT37XVr2xll6cpt
         Qz826G1jDyMn19EOE57yZw9OiAjg7g+8in59edhaaIosZAN7wPultUaRqPYj1nc81ami
         DXmw==
X-Gm-Message-State: AO0yUKVJEPf6o0ZJGO0kZzemGY6EtbdaOiH3Js9thjckO5mvkQYLraQn
        D6KnDa5s8mL4RZhEwYfpduw=
X-Google-Smtp-Source: AK7set+/lTXbTMwxME0K5jZ0L1BhEsouOPyT8dI1DNczGutITrV1sc485wO76k+vqeb/V5z3LjQ/BQ==
X-Received: by 2002:a17:90b:1e02:b0:22c:afd6:e597 with SMTP id pg2-20020a17090b1e0200b0022cafd6e597mr13412531pjb.17.1677176374904;
        Thu, 23 Feb 2023 10:19:34 -0800 (PST)
Received: from ?IPV6:2001:df0:0:200c:5169:eed6:c2d0:93c3? ([2001:df0:0:200c:5169:eed6:c2d0:93c3])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c14c00b001949f21e1d2sm7097795plj.308.2023.02.23.10.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 10:19:34 -0800 (PST)
Message-ID: <4697cebe-5399-17f6-4580-99f3f3c86db6@gmail.com>
Date:   Fri, 24 Feb 2023 07:19:28 +1300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 00/41] RPCSEC GSS krb5 enhancements
Content-Language: en-US
To:     Andreas Schwab <schwab@linux-m68k.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
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
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <87mt54e02i.fsf@igel.home>
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

On 24/02/23 06:57, Andreas Schwab wrote:
> On Feb 23 2023, Chuck Lever III wrote:
>
>> Assuming that "PC:" on m68k is the same as "RIP:" on x86...
>> this does not make sense. rfc6803_suite is not a function.
> That can mean that something has overwritten the return PC.
>
Wouldn't you expect a format error in that case?

Cheers,

     Michael


