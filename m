Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB59A201E70
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jun 2020 00:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbgFSW6w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Jun 2020 18:58:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38115 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730199AbgFSW6v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Jun 2020 18:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592607530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E2BNk2Ub7uBT0HBt8BMR2hg/5o8g14jlSam4dCx84bQ=;
        b=cPKE3WWVwDbAMxYSBshkPK1kjbrkYoyf6FT0wbGYl7mmRFb5l9QOAkIukDSUGcy35rpPTw
        nxHsrzqLRJ0a6DgWGj6VQy+ts4yreyQV70UF4fcXoZofoz723pfKUxEwKWTa+KaqZcASN5
        2CGcLSmfb+NtCPYMQmgYfyIdqAKnXAw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-FMT9QkzVOVyeb7vBuJRmjA-1; Fri, 19 Jun 2020 18:58:48 -0400
X-MC-Unique: FMT9QkzVOVyeb7vBuJRmjA-1
Received: by mail-wm1-f70.google.com with SMTP id t18so2752129wmj.5
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jun 2020 15:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E2BNk2Ub7uBT0HBt8BMR2hg/5o8g14jlSam4dCx84bQ=;
        b=OZwPtGMpX2NPwkTD+dOIJMTNSlIZwmNCy7HwQGTYwg/L7Jjlh5ueAhkpSpygH1zw5y
         GNsqQ1CZIWJcmSwsgLbyxapwqMMT4Mfuxstt9PMFk9+GIyrDrZoFWUKqIgvM0Rk7TxSG
         fgMaIYPF7WMYL9L3jtORbS4BYYKRRmb9i00E8HwkoYYUtb6bC2VuG1woy685+LCYSnqy
         m7s1TuQF+Gy6L0XNSR773Ji9h1pCm0rzspkzS7GzRb34vmSeouPYQv2G0j1iWnbkRelf
         FuBveUUhh7UgbhqMwnxZr/3M6/CRE5Gk/KozlrdM1LmSrEgffooOJyMaqO16uQkqcMy4
         E7jQ==
X-Gm-Message-State: AOAM532fW2Y2ROntgOtx3iP1rRGVPcWAdJ3F6NGzcT8EIM43kS64ARP9
        eL/Wld+xqodTltpFKw0GUvoZE4sdpeTeLlcOcueX0zuGT+941SCjLd8a2YDg9orXTP66+hfGIV5
        G80yLVu3lkALauYhfvHjSnaY+5f+r
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr5779793wma.148.1592607527324;
        Fri, 19 Jun 2020 15:58:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMKhY/RzPovyTwhCbOPKYFuzo5dk0SjaJP0wmIxsSDDxtGzS04gtLD/QEWjSSWySAcyxN+DQ==
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr5779776wma.148.1592607527023;
        Fri, 19 Jun 2020 15:58:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e1d2:138e:4eff:42cb? ([2001:b07:6468:f312:e1d2:138e:4eff:42cb])
        by smtp.gmail.com with ESMTPSA id r12sm8693338wrc.22.2020.06.19.15.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 15:58:46 -0700 (PDT)
Subject: Re: RFC - kernel selftest result documentation (KTAP)
To:     Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     "Bird, Tim" <Tim.Bird@sony.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006141120.96FF8C5@keescook>
 <CY4PR13MB11757D57CD441C5CAEC3F257FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <7161fadb-45ba-c4c0-8bbb-cb47d2dd0265@redhat.com>
 <CY4PR13MB11755F5A6879CA3FFD005426FD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <CAFd5g454n4ZPgCdWaAxezFueG47TztqBx4L7x4oYwgPAR3BZNA@mail.gmail.com>
 <202006161653.15C278A5@keescook>
 <398200b2-f8bc-894d-6d6f-366ff98a490e@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c60c25ab-6737-1cc9-4370-dae4ebb4b823@redhat.com>
Date:   Sat, 20 Jun 2020 00:58:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <398200b2-f8bc-894d-6d6f-366ff98a490e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 19/06/20 20:47, Frank Rowand wrote:
> Or if the entire test depends on the missing config then Bail out might
> be appropriate.

No, in that case you want

	1..0 # SKIP: unsupported configuration

The spec is not clear if "Bail out!" is an error condition or just a
warning that only part of the test was run, but prove(1) and Automake
both treat it as the former, for example.

For example, an ENOSPC error creating a temporary file could be turned
into a bail-out, while an ENOSYS would be a skip.

Paolo

