Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5834071FDF2
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 11:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbjFBJdx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 05:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbjFBJdt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 05:33:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EF4C0
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 02:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685698364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zGO5HytmLACgK9GKNF+3cgvVOya1l1UlgEMwgI/rmuY=;
        b=E6Xv5+wUcQbk+xtHAsSPyIUd2cX0xxhCrW6NDVMGFUcBgE15zvSyjSWCTiJkENMuVHQIih
        Ruem2Kbw5QAWznUNuxm5X2RLHJTZ2OJ1wb6Ww2cw7FnvMmsQ318KYd9gWUwUlhIU71Ywgo
        bODJLq3uVu3JaMVwGdGX1rBr6TrszyE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-2q2ZKQySPviUOUxBiEw9Dw-1; Fri, 02 Jun 2023 05:32:42 -0400
X-MC-Unique: 2q2ZKQySPviUOUxBiEw9Dw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30aeef6f601so1010115f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 02:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685698361; x=1688290361;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGO5HytmLACgK9GKNF+3cgvVOya1l1UlgEMwgI/rmuY=;
        b=C5hx1mCbW0SyTITWHfWhOhFDctLfmQYxjVxDcVujGmHgWX7uqvCGgIzgSi42dokyaL
         Il/xAfVJAM3T9EHsCeVSQAip27qvk1f3V2sfbLcwOkk5vuY0xIPIesLnKaLArQSqKRGj
         sD+a+mL5YymvO94kcEZ0ihy6l60Yz25QfuuXYhlirf88ETntncKDjbzJkA85OVD0QEbi
         p8VcxWwWMA6pRHNVRf5n4/Lnb6ru7+GxBRAGkqbYidj1Juw9ko4EzGiLbSaRLU2Eljv2
         YUnA12q0c18t8oR4W+GJuNZIaHr42Iv2UWoy0om2xFYMgAjnehSSURXawJJyPyhJr/AD
         Ertg==
X-Gm-Message-State: AC+VfDzo5EDsXYlixAf8wMzxqQYSEEsBN+RHVrzAQbiCH9nxQAkfVKc2
        UywQICe1fiw6d5FAZuouwaImZtza3cKN6F/oyG8EW7K9eoHkeK6ZRhLSG/fqPaJvw7CcG7A2BWi
        n6/Qe71F6POS5sk0VS2xokx0aL2wx
X-Received: by 2002:a7b:ce0a:0:b0:3f4:fc5e:fbf2 with SMTP id m10-20020a7bce0a000000b003f4fc5efbf2mr1343873wmc.8.1685698361249;
        Fri, 02 Jun 2023 02:32:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5qXLoMOUyOwyxB8QJi5/lh8XWNUX/jSwFh9mmS99bJj5kctxTuQ4RoxvaIPaaRHATi9LX5Ug==
X-Received: by 2002:a7b:ce0a:0:b0:3f4:fc5e:fbf2 with SMTP id m10-20020a7bce0a000000b003f4fc5efbf2mr1343855wmc.8.1685698360862;
        Fri, 02 Jun 2023 02:32:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451? (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de. [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
        by smtp.gmail.com with ESMTPSA id m16-20020a7bcb90000000b003f6028a4c85sm4897350wmi.16.2023.06.02.02.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 02:32:40 -0700 (PDT)
Message-ID: <78c0b444-8a95-396e-5f5e-8175f94a49cc@redhat.com>
Date:   Fri, 2 Jun 2023 11:32:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 00/12] A minor flurry of selftest/mm fixes
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230602013358.900637-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02.06.23 03:33, John Hubbard wrote:
> It turned out that an even dozen patches were required in order to get the
> selftests building cleanly, and all running, once again. I made it worse on
> myself by insisting on using clang, which seems to uncover a few more warnings
> than gcc these days.
> 
> So I still haven't gotten to my original goal of running a new HMM test that
> Alistair handed me (it's not here yet), but at least this fixes everything I ran
> into just now.

Thanks, now I can stop commenting out some (IIRC primarily uffd-related) 
tests when just wanting to run some specific tests on some of odd 
installations :D

I assume this round you only consideres 64bit builds, right? My last 
attempts with 32bit revealed a lot of issues, and I only fixed what I 
really wanted to test (COW).

-- 
Thanks,

David / dhildenb

