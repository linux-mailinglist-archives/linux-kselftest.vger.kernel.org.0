Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146EB20249C
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jun 2020 16:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgFTOvK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 Jun 2020 10:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbgFTOvJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 Jun 2020 10:51:09 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6145C06174E;
        Sat, 20 Jun 2020 07:51:09 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id j68so8413297qkb.10;
        Sat, 20 Jun 2020 07:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kDONBzp9FFkp/q48lxtlxAMQmnNRagWl3Cm1sX181Q4=;
        b=TxA9NJE1jRUP6PRN51aorACEWQWbEjtV9Txd9qn4Cnphb9lUzqTvYOZk0AoA6mdQVp
         goZIAQd5vhjhW17NWI+Jou2QQKyRQ3f40bSum75Tyfz8iALfyWGFNpcJT3m/468c1eAY
         IagcHGzqG+b6MOZoBETyB63ENeSVwCqT5f0RAgrWMp0afm2C7LHb14wEV/RE2xifKOVp
         3FY3Iaxpwl7WMned9E2UkFqMfddqF41yQ9oUuc5ah4c22vN5KxiNovKJ9NzeWVw1ONH5
         siJuqZGeoWur4G1oq/c4o8ctiQ+QMll8UkhljDAXSImtPB2BbKP1XUoBLnIFSaXsWwSb
         9oMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kDONBzp9FFkp/q48lxtlxAMQmnNRagWl3Cm1sX181Q4=;
        b=Ai7Leh9M+WiGm17vmCuvTkubPyOUgI7qrqxUcnCGdK9+BMGHRhctPTkj9LjWow4GUC
         MSkVjMc0EgqbZqv+r0vnEHLT0BsQAOCh97axEr92lRbdwJhVTkKM3KrZJ34Gd2a/yBWu
         nR6jT06+ceKBFOKPsNa5aKUfaLXQiPNrN0inP/AzwharjDRCBtQAPO7/iYYCmWjdePf1
         R92OVg7g9Zd/OVeuJ3Gn+LHjgq+j5sjtfED87G5eJmuitSCl3UxG+pJMf/vzdk3aqA5Q
         6Q7huqffoMGRCosSykdZ8L6WvvFRi/MCLLaGRYPTF8VK3cFu7IHbb+hYWHJJfF4DEuNp
         7scQ==
X-Gm-Message-State: AOAM531FLV3LbiTTc2hYo0s1YZye1BJNrtuuPDKEXg+mBMH2SF6ZhnvQ
        aDf9M/Fl0b0bWCp+RpGfKKY=
X-Google-Smtp-Source: ABdhPJzneFzXudsr+ymY3v9x3pN7MOuPuB62+BWDVkOJma2pyq6mtBby2LDR2ZLj1m/ilXE+2Kl6lA==
X-Received: by 2002:a37:9c8f:: with SMTP id f137mr519837qke.63.1592664668222;
        Sat, 20 Jun 2020 07:51:08 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id i13sm411750qtc.83.2020.06.20.07.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 07:51:07 -0700 (PDT)
Subject: Re: RFC - kernel selftest result documentation (KTAP)
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     "Bird, Tim" <Tim.Bird@sony.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006141120.96FF8C5@keescook>
 <CY4PR13MB11757D57CD441C5CAEC3F257FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <7161fadb-45ba-c4c0-8bbb-cb47d2dd0265@redhat.com>
 <CY4PR13MB11755F5A6879CA3FFD005426FD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <CAFd5g454n4ZPgCdWaAxezFueG47TztqBx4L7x4oYwgPAR3BZNA@mail.gmail.com>
 <202006161653.15C278A5@keescook>
 <398200b2-f8bc-894d-6d6f-366ff98a490e@gmail.com>
 <c60c25ab-6737-1cc9-4370-dae4ebb4b823@redhat.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <8b31b4b4-2b26-65f3-1026-cdc62cc710cd@gmail.com>
Date:   Sat, 20 Jun 2020 09:51:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <c60c25ab-6737-1cc9-4370-dae4ebb4b823@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2020-06-19 17:58, Paolo Bonzini wrote:
> On 19/06/20 20:47, Frank Rowand wrote:
>> Or if the entire test depends on the missing config then Bail out might
>> be appropriate.
> 
> No, in that case you want
> 
> 	1..0 # SKIP: unsupported configuration
> 
> The spec is not clear if "Bail out!" is an error condition or just a
> warning that only part of the test was run, but prove(1) and Automake
> both treat it as the former, for example.
> 
> For example, an ENOSPC error creating a temporary file could be turned
> into a bail-out, while an ENOSYS would be a skip.
> 
> Paolo
> 

I think that "Bail out!" needs to be more clearly defined by the spec,
and we should come up with an intent of what it is intended to mean.

The TAP 13 spec gives a "Bail out!" example of "MySQL is not running."
The spec gives this example after the general guidance of (among other
things) "missing dependencies".  A missing config _could_ be thought
of as a missing dependency.

To me, the key differentiator for "Bail out!" is "that further tests
are useless".  In other words, the detected problem means that
every subsequent part of the tests will fail for the same reason.

If _some_ subsequent parts of the tests will NOT fail for the same
reason then SKIP becomes more reasonable.  What percent of subsequent
parts of the tests is large enough to comprise "_some_" is probably
a value judgement.

For the case that I was commenting on, with the limited amount of
description provided, my preference is also SKIP, which is what I
was suggesting.
