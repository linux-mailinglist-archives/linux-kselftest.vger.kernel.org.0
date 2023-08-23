Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B4A785984
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Aug 2023 15:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbjHWNkC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Aug 2023 09:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbjHWNkC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Aug 2023 09:40:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F35DFB
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Aug 2023 06:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692797952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dbGvwoooWMW8Hm2UYm2d1lmRjEO7Wbgc4RxYmtWXSMQ=;
        b=DG/lUAa15gbCEnRuYW1w5T6bWiVgEW6LgTET8pC9gjWgsk2rUok+NQ/WUwZNNYdztzxcNo
        iOaKRntxaSRy4tuBlBVxYKz89DvyVAN8lSR0r2gsBaFWmSbjUiY7V9FRjMLQ7OlVNF3as9
        avhfV8apJdAq9BbFkBSwZ+aXW7DxyCo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-lLWUzft3PpOFz_ZeCGR0Yg-1; Wed, 23 Aug 2023 09:39:11 -0400
X-MC-Unique: lLWUzft3PpOFz_ZeCGR0Yg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76e26652e6fso72785985a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Aug 2023 06:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797950; x=1693402750;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dbGvwoooWMW8Hm2UYm2d1lmRjEO7Wbgc4RxYmtWXSMQ=;
        b=iqUASdlFy+H9C68eSeInBOZrX7xLpvlDc1TyMqFW8VTbCpuXRdXyVR3iIZdd/oeGRu
         xkl69zWBN7nUg/A8g2YkhEforsxNKKSQCOUddP1o0aTkJfqDahLsOJ09UqgXGLyd6glH
         7l4RlA8BXVMzadMOddignHHCZco4v7et9N8/w8hrCQtiBAZaX330VWhacaWkKxQGFQmu
         GH/l2dRQzvsUH8wZ3F3fQ3pGenAG+4YGfuVOS0HM8G8eI+moeMIXwB3C7vPr+UJaqFCA
         EF8bVGVnVQ/qLVtPAZwNvoR/gNT9w2SlucliFWgqEjOJhSs2Lt8wyDK/gVzsVvsHVcat
         kikA==
X-Gm-Message-State: AOJu0YzE2RFoq9ny4WOagGMXHWu/gw0edMcNpDHYKux/jk7ryQBBtCjh
        IpdC05tkFQzohSEQ+aE996gxNJBH9RJI06r6vSv7yvOeJoMHrri/jfjRYkl+oRf4erdnvWqzI9S
        BXx1tLxG+7pv0dsKghRfqAWmO9h4ydHvEyFCv
X-Received: by 2002:a05:620a:1407:b0:767:fbe:f4b with SMTP id d7-20020a05620a140700b007670fbe0f4bmr11771521qkj.72.1692797950593;
        Wed, 23 Aug 2023 06:39:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ0qFYwYZRO7SakLLWrT1LGHWj5Zv6dI4OGBgp76Vnx9zRvSzO8PzQo4WhCGh2+GkSL6UIDQ==
X-Received: by 2002:a05:620a:1407:b0:767:fbe:f4b with SMTP id d7-20020a05620a140700b007670fbe0f4bmr11771508qkj.72.1692797950334;
        Wed, 23 Aug 2023 06:39:10 -0700 (PDT)
Received: from [192.168.1.12] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id j22-20020a05620a147600b00767b24f68edsm120241qkl.62.2023.08.23.06.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 06:39:09 -0700 (PDT)
Message-ID: <b60da0cb-6606-ef37-8fd3-6a222cda736f@redhat.com>
Date:   Wed, 23 Aug 2023 09:39:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Wolfram Sang <wsa@kernel.org>, linux-kselftest@vger.kernel.org
References: <ZOXxSA1UKBkU/ou4@ninjato>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: Repo for tests which fail currently?
In-Reply-To: <ZOXxSA1UKBkU/ou4@ninjato>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/23/23 07:45, Wolfram Sang wrote:
> Hi all,
> 
> for my talk at EOSS23 about object life-time issues[1], I created a
> loose set of tests checking some longstanding problems in the Linux
> Kernel. I would like to improve these tests. Now, I wonder where I could
> contribute them to because their scope seems different to me. They are
> not for regression testing because I don't have a fix for most of them.
> Some fixes mean rewriting private data allocations for a whole subsystem
> and drivers. The tests are rather meant for documenting known problems
> and checking if someone started working on it. But it seems that
> kselftest (and LTP also?) only accept tests which do not fail by
> default. The question is now, is there another test collection project I
> could contribute these tests to? I'd be very happy for pointers, I
> started looking around but to no avail...
> 

I don't have any good answers, but I did have a similar question a few
years ago about expected build failures.  At the time, I was working on
a build script where I wanted to detect some unsupported situations and
bail out.  I had written tests to verify that the script was performing
as expected, but from I gathered, kselftests were always expected to
succeed (and build).

Anyway maybe your question is less about mechanics (could you invert the
result, i.e. failure is success?) and more about where to collect such
tests?

-- 
Joe

