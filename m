Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE81640C59
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 18:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiLBRn5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 12:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiLBRn4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 12:43:56 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C90DEA47;
        Fri,  2 Dec 2022 09:43:55 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n16-20020a05600c3b9000b003d08febff59so284421wms.3;
        Fri, 02 Dec 2022 09:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I7gcmDY2i8H8nOgJd+/7YR9Wml+Y6wMDjwIDDCDK+EA=;
        b=CK9HVBzPcVTyLBqrwqnixOSWS3Ky91StRIaYIBXIlZ8xZIHIKCn9fB++l4/aJ0jhE7
         dzMEgmAD063h7+lGJNGgJ886wVblLnRQDs4AXDu2f59D8fUIeJ1oWRiS4sUDIuIM+I5U
         Reo79LfldT8ZEILK2dn7dyU60mvPXwyBdT7f+F0QN+2EEnqyt70HVvea53RMEMLpeM2k
         NwVU+0TiuDnaxsclFIbYfg2wGfkoykA8RTIYXtG/BQZFL6mqx9sVqM/tpAsSthGl6jfn
         wXL3Hs7fU8KvsL8DUXlaBvSGEp2j3TkU2LQFbfUSUGQuGBcAiFcM4ORFOIAdr1ebyTp3
         2LYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7gcmDY2i8H8nOgJd+/7YR9Wml+Y6wMDjwIDDCDK+EA=;
        b=uojCxsZvMbrckC2atm795/HV5S8mIyGa0VCkNyxKWj4yT2bw1lo2eeB973m6598clo
         HpZij/ok31GkIWMhjOzUaUNRxmo1ICuuwWF4htNexw3Z5LzH+4MpGQJ2QhESjCG2a9lG
         6HcbsLWCjf/XkFLeUH/IJUVjJiArl0a/eP/Kwx6W013864SWRoAo7GZrP/P7VmaTALmS
         l0EtmjxIHtZiKfUl94y9YqmI6JDaFJz9krLDV8QTmfnjQmoTVk03Z5OIn2oaL1NVnxI9
         omrhHNX+lZJKIxdo3LY/jofXoyfsG4x4Kz9wIZT6BLsWqB49PTeRpEeVdLvlsQwzsoAY
         mhAA==
X-Gm-Message-State: ANoB5pnXIKCklbqLvYHOJvEe1Jtz/WD7TJFMDReEvmd28sIzZIaHhPUw
        cfCsLjIp9pg591a6F1fW5o4=
X-Google-Smtp-Source: AA0mqf5sVVP51gLMwRzFGWqSIDNnlCH4OFmV1E1eFgIYtbaDPna6XrofuDwAexiQyFJPpcx+4gkG+Q==
X-Received: by 2002:a05:600c:5385:b0:3d0:8644:19fe with SMTP id hg5-20020a05600c538500b003d0864419femr2904719wmb.132.1670003034537;
        Fri, 02 Dec 2022 09:43:54 -0800 (PST)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id fn9-20020a05600c688900b003cf75213bb9sm12467768wmb.8.2022.12.02.09.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 09:43:53 -0800 (PST)
Message-ID: <10445a4d-0175-3e5e-aa74-9d232737a7c2@gmail.com>
Date:   Fri, 2 Dec 2022 17:43:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH][next] KVM: selftests: Fix spelling mistake
 "probabalistic" -> "probabilistic"
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221201091354.1613652-1-colin.i.king@gmail.com>
 <Y4o0Nq4SKGZgDOxi@google.com>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <Y4o0Nq4SKGZgDOxi@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02/12/2022 17:21, Sean Christopherson wrote:
> On Thu, Dec 01, 2022, Colin Ian King wrote:
>> There is a spelling mistake in some help text. Fix it.
> 
> I assume you have a script/tool of some form to do spell checking?  If so, can
> you point me at it?  I'd love to incorporate something like that into my workflow.

https://github.com/ColinIanKing/kernelscan

It needs an appropriate dictionary to be installed. It's very fast (but 
sometimes makes mistakes, I need to fix those!).

./kernelscan -k src_directory > mistakes.txt

I normally run this across the entire kernel git repo on a daily basis, 
and diff the new results with the previous results using meld and figure 
out what needs to be fixed.

You may be better off with using codespell

Colin

> 
> Thanks!
> 
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>> ---
> 
> Reviewed-by: Sean Christopherson <seanjc@google.com>

