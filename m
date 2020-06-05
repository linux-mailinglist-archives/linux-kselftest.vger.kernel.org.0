Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613B01EF8FC
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jun 2020 15:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgFEN0t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Jun 2020 09:26:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37233 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726844AbgFEN0s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Jun 2020 09:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591363607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ma5m4eBugzAUFyTBU0r9XwTfnQoHVYy4LZfMChs09d4=;
        b=MOEsRsXuyiE8Oa+hk0Mi7/AR+9P2dTVHNgRgDwaJDtrL7iLWd7PkS0XN5RN0TF1uVIf2s/
        BOtS7Na2A/os0957A/CKCKMrISNlUr48MA2YNq0Kyv4IMBVb0LU5suuBGC455NYYL9sLPV
        gfqIKVo/Qq41fr3IDpuzQBUKHUFhGWM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-WDkPupM9M5yk2llxWyTxNg-1; Fri, 05 Jun 2020 09:26:43 -0400
X-MC-Unique: WDkPupM9M5yk2llxWyTxNg-1
Received: by mail-wm1-f70.google.com with SMTP id v23so3028436wmj.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Jun 2020 06:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ma5m4eBugzAUFyTBU0r9XwTfnQoHVYy4LZfMChs09d4=;
        b=DnGfytGcB537bBPqg9szWdrG3o2pzNQQuxSwJXPwiR4kVW+n0aliz55Mh/aMTv26sA
         GocogKPx4SYzjMfoOwpqN82ejqt1AicXWnSAB1IjpDxJyaFG7T78YS1leaDG0cfgRkuZ
         MR40HKPuNjR6A0n7aAqKsx1DTH0q3lr6aYu9ewJpRvSRKyJAeCM8PGzgFQY1aCwym+VS
         wlQgKM/uii3y4zNnklz6JETFHAJj7tKS7tz26qj61JMT8rd/OKZzyOuS55yrgeoHi7VS
         fT9D2znBc5EDdfttIikI4BqZcAtMi+yfeA8NHPlwbMNHiGHgdWH4G+QYhPNDSMmcRzPh
         jAsw==
X-Gm-Message-State: AOAM5338lyYWxhCxEVXTBI6uyrezLxvDPdDyWCoY/V92w5+DQODT4uwz
        0xBMKyBFCqK2akm+r94Ni3B6/n3ulRTvuqefRdTVRln8FZa+uupRSSyEIwOScGg8xJAicCTrmZO
        8wpjINJMVjf9ZDTKDM3HglzA4+ze+
X-Received: by 2002:adf:e68a:: with SMTP id r10mr9488539wrm.384.1591363601934;
        Fri, 05 Jun 2020 06:26:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQv5AllPZVkRCl0tV0eLTawsBo4pIGSnRkC36iEv0AyEIWBrY46UyZcIOzVe74SuM/91keTQ==
X-Received: by 2002:adf:e68a:: with SMTP id r10mr9488504wrm.384.1591363601629;
        Fri, 05 Jun 2020 06:26:41 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.243.176])
        by smtp.gmail.com with ESMTPSA id z2sm11769932wrs.87.2020.06.05.06.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 06:26:40 -0700 (PDT)
Subject: Re: [PATCH] KVM: selftests: delete some dead code
To:     Peter Xu <peterx@redhat.com>, Andrew Jones <drjones@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Ben Gardon <bgardon@google.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200605110048.GB978434@mwanda>
 <9f20e25d-599d-c203-e3d4-905b122ef5a3@redhat.com>
 <20200605115316.z5tavmf5rjobypve@kamzik.brq.redhat.com>
 <20200605124816.GB55548@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <891e89c8-8467-eeb4-1b23-337b88a299dd@redhat.com>
Date:   Fri, 5 Jun 2020 15:26:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200605124816.GB55548@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 05/06/20 14:48, Peter Xu wrote:
>>> The bug is that strtoul is "impossible" to use correctly.
> Could I ask why?

To see see how annoying the situation is, check out utils/cutils.c in
QEMU; basically, it is very hard to do error handling.  From the man page:

       Since  strtoul() can legitimately return 0 or ULONG_MAX
       (ULLONG_MAX for strtoull()) on both success and failure, the
       calling program should set errno to 0 before the call, and then
       determine if an error occurred by checking whether errno has
       a nonzero value after the call.

and of course no one wants to write code for that every time they have
to parse a number.

In addition, if the string is empty it returns 0, and of endptr is NULL
it will accept something like "123abc" and return 123.

So it is not literally impossible, but it is a poorly-designed interface
which is a major source of bugs.  On Rusty's API design levels[1][2], I
would put it at 3 if I'm feeling generous ("Read the documentation and
you'll get it right"), and at -4 to -7 ("The obvious use is wrong") if
it's been a bad day.

Therefore it's quite common to have a wrapper like

    int my_strtoul(char *p, char **endptr, unsigned long *result);

The wrapper will:

- check that the string is not empty

- always return 0 or -1 because of the by-reference output argument "result"

- take care of checking that the entire input string was parsed, for
example by rejecting partial parsing of the string if endptr == NULL.

This version gets a solid 7 ("The obvious use is probably the correct
one"); possibly even 8 ("The compiler will warn if you get it wrong")
because the output argument gives you better protection against overflow.

Regarding overflow, there is a strtol but not a strtoi, so you need to
have a temporary long and do range checking manually.  Again, you will
most likely make mistakes if you use strtol, while my_strtol will merely
make it annoying but it should be obvious that you're getting it wrong.

Paolo

[1] https://ozlabs.org/~rusty/index.cgi/tech/2008-03-30.html
[2] https://ozlabs.org/~rusty/index.cgi/tech/2008-04-01.html

