Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98FF1EFF37
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jun 2020 19:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgFERkN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Jun 2020 13:40:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49569 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726959AbgFERkL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Jun 2020 13:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591378810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/opGoEgIoDnDcLi9yZX38mmT0/AADXDWxmU4z3ixU+s=;
        b=bwlWiT9B7LgXzXCQ9jGswcY3Gc6v//xDDEQa38Q7PIZK3VSRWlDT7/G0Z2j/zFkfCHH+kh
        Smp+zakex/CVpxbCO7WxmxpyqXayb0n84qXIp9Cmyn0jzd7QN35jzGCvnM8Pkcb9r/iOqS
        uhS4EL0jg3lUFkp3FAsPw/l784Z0CQE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319--PYVTtPKPjyF2KUwAkK2pw-1; Fri, 05 Jun 2020 13:40:01 -0400
X-MC-Unique: -PYVTtPKPjyF2KUwAkK2pw-1
Received: by mail-qk1-f197.google.com with SMTP id m29so8262187qkm.17
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Jun 2020 10:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/opGoEgIoDnDcLi9yZX38mmT0/AADXDWxmU4z3ixU+s=;
        b=tYVuJv9q4ruaIg4EDQwFJfSQ/YcYK44TOP3/NlAKuAYjsBxzqsDs/QWH8GCRyh8NQn
         21p0WXA6Va1H3lh1x4ExgKmRDpnSH64C98G1VTcEKxXhhI4gD6v0EVhiYLf0y3b1rwPN
         gztrAw+Awa6gHZCo+DpBFb7E6GElLFQWoEy+e5vbpXfK/FVYEUP+mJ3J9V0vT8Id9FPp
         VjUBI/dpedNQAcly5RQ0oMw4C/e3375qqCreKW8dkldwUDlVSWQ4YzfmKSFZbz67Nu4n
         vecI4Mpw1i84Bdsr+SbR02a19kkaX9liCO9q/p+G4ablJEpvcal1++zNE3y3ilUvwKYN
         JXCQ==
X-Gm-Message-State: AOAM530adDws/7yVU1QnAHYeWsUH3wQe3Jfer8/7IkMhQWQ/WeA9goaB
        3UXhYNdnkEajKoXVSe+0b0MhA3Tkan9ll4pIa3jAsrSXDZzLjn3pXPGUNLRlPwoiYOjO6MJHFpg
        htlfC3U5kNRZz4MbZzAlrpFxZtX41
X-Received: by 2002:a0c:b516:: with SMTP id d22mr11035121qve.88.1591378801300;
        Fri, 05 Jun 2020 10:40:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyR45UIs5BGkXfLlHRAVY1bsHugsmO0ud2/c7cAJHdU9j6xjM6xDnoawCzMXujmNEXw/5BqWQ==
X-Received: by 2002:a0c:b516:: with SMTP id d22mr11035076qve.88.1591378800779;
        Fri, 05 Jun 2020 10:40:00 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id d13sm328302qkc.121.2020.06.05.10.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 10:39:59 -0700 (PDT)
Date:   Fri, 5 Jun 2020 13:39:58 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Andrew Jones <drjones@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ben Gardon <bgardon@google.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: delete some dead code
Message-ID: <20200605173958.GC71522@xz-x1>
References: <20200605110048.GB978434@mwanda>
 <9f20e25d-599d-c203-e3d4-905b122ef5a3@redhat.com>
 <20200605115316.z5tavmf5rjobypve@kamzik.brq.redhat.com>
 <20200605124816.GB55548@xz-x1>
 <891e89c8-8467-eeb4-1b23-337b88a299dd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <891e89c8-8467-eeb4-1b23-337b88a299dd@redhat.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 05, 2020 at 03:26:39PM +0200, Paolo Bonzini wrote:
> On 05/06/20 14:48, Peter Xu wrote:
> >>> The bug is that strtoul is "impossible" to use correctly.
> > Could I ask why?
> 
> To see see how annoying the situation is, check out utils/cutils.c in
> QEMU; basically, it is very hard to do error handling.  From the man page:
> 
>        Since  strtoul() can legitimately return 0 or ULONG_MAX
>        (ULLONG_MAX for strtoull()) on both success and failure, the
>        calling program should set errno to 0 before the call, and then
>        determine if an error occurred by checking whether errno has
>        a nonzero value after the call.
> 
> and of course no one wants to write code for that every time they have
> to parse a number.
> 
> In addition, if the string is empty it returns 0, and of endptr is NULL
> it will accept something like "123abc" and return 123.
> 
> So it is not literally impossible, but it is a poorly-designed interface
> which is a major source of bugs.  On Rusty's API design levels[1][2], I
> would put it at 3 if I'm feeling generous ("Read the documentation and
> you'll get it right"), and at -4 to -7 ("The obvious use is wrong") if
> it's been a bad day.
> 
> Therefore it's quite common to have a wrapper like
> 
>     int my_strtoul(char *p, char **endptr, unsigned long *result);
> 
> The wrapper will:
> 
> - check that the string is not empty
> 
> - always return 0 or -1 because of the by-reference output argument "result"
> 
> - take care of checking that the entire input string was parsed, for
> example by rejecting partial parsing of the string if endptr == NULL.
> 
> This version gets a solid 7 ("The obvious use is probably the correct
> one"); possibly even 8 ("The compiler will warn if you get it wrong")
> because the output argument gives you better protection against overflow.
> 
> Regarding overflow, there is a strtol but not a strtoi, so you need to
> have a temporary long and do range checking manually.  Again, you will
> most likely make mistakes if you use strtol, while my_strtol will merely
> make it annoying but it should be obvious that you're getting it wrong.
> 
> Paolo
> 
> [1] https://ozlabs.org/~rusty/index.cgi/tech/2008-03-30.html
> [2] https://ozlabs.org/~rusty/index.cgi/tech/2008-04-01.html

Fair enough, and a good reading material. :)

Thanks!

-- 
Peter Xu

