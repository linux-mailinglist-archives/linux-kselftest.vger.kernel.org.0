Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BA61E3B37
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 May 2020 10:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgE0IFm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 May 2020 04:05:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31540 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729292AbgE0IFl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 May 2020 04:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590566740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iv61hiKMRdE+binuenpMGOmIDwOOgnaGDNF59OZgFNw=;
        b=NHrh6dpz40bAkUrQG1thQhWXSWeGyGyk7SLEORNTL+VnEOBGxWSNa/CpMnRgg0+Gvquci9
        fo76oBU3ZJnQ3rcUVapYOwIdlUCujel+lWSQ33hJ6Ak4xCP7a0iLRPZd48HWA7+Tu8xQPG
        vCawv3CZm/lQvWHAaJltIKfxKuUZRQg=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-HLfDTEuXPOWv1mKdZOcztg-1; Wed, 27 May 2020 04:05:37 -0400
X-MC-Unique: HLfDTEuXPOWv1mKdZOcztg-1
Received: by mail-oi1-f200.google.com with SMTP id w196so12679979oia.12
        for <linux-kselftest@vger.kernel.org>; Wed, 27 May 2020 01:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iv61hiKMRdE+binuenpMGOmIDwOOgnaGDNF59OZgFNw=;
        b=l++UcqrzzL/LVPrVJvuZHy90sDt0UT956a1PJpy0KAQ5wf+lnApsWaWb7DTFE5v9ME
         WCNCJzblTFDZkktJ6xue8sT3mpEX1LilvITlUfL2gy21d+MmdaAxWiqXtwecvVVNX2ps
         wqxJsL+cjPrj+eouARYI/j0KyeTQjmWTPPOKIgQm76y+GCYx+SA0nSmWqD9Qn8WaikiR
         oGoG0emiiHxuBKCKswwQgXqmhJPXlCs8HJheScFUzJbB6LCztdZjkFQ3qtxX2GRDfIW6
         pXnrXNMVHGcM1pRpw+rCqzuXB7W0bw0NPLpl6hG0qVXGaKGrBbj0iY/3x81GuUmNJ8jH
         4Auw==
X-Gm-Message-State: AOAM5337fHOEFwYeG5I0QjxUZLXHKHXw6W3UM+tzuf2y41qwN97WR0QW
        hs0eHdPLZnI4obi65KqL/UfCXWoIv5O1rTbjq+r28t0rc96Q8FbozI0XoZysCgWgxFuLc00UtHR
        6lkrmEgF8UsKWx6Gq2ao0O+XAgjLb8cs3Pad3zUepZgVZ
X-Received: by 2002:a4a:3790:: with SMTP id r138mr2175324oor.81.1590566736951;
        Wed, 27 May 2020 01:05:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9cK1fII07jm9d1oAGLySP1vgu/XtruBGCfr+FfHNisYPVjdJRz45yDq/CDrOf06VCe/xxR8yWdn75OjyUWoM=
X-Received: by 2002:a4a:3790:: with SMTP id r138mr2175298oor.81.1590566736701;
 Wed, 27 May 2020 01:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
 <xuny367so4k3.fsf@redhat.com> <CAEf4BzZd507Hyfu8GYxZfJ-Rc0GAs1UNCN0uBqX3kYS9sz-yDA@mail.gmail.com>
 <xunyv9kiou7w.fsf@redhat.com> <CAEf4Bzau5MWYqP1XfZzYVj6tf7Y9fmJRgjbO00DzOmJ_iGschg@mail.gmail.com>
 <xunyy2pdon4g.fsf@redhat.com>
In-Reply-To: <xunyy2pdon4g.fsf@redhat.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Wed, 27 May 2020 11:05:20 +0300
Message-ID: <CANoWsw=5gypPiHYHLr+iKCY3CUwAHoEN1MsFuZEMbgOB8uRSyQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] selftests/bpf: installation and out of tree build fixes
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 27, 2020 at 10:25 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:

[...]

>  > My point is that by building in tree and then just copying
>  > everything under selftests/bpf directory to wherever you want
>  > to "install" it would just work. And won't require
>  > complicating already complicated Makefile. Any problem with
>  > such approach?
>
> I understand. I see only wasting of space as a problem, but
> should check.
>

Well, it messes up with the lib.mk functionality. There must be
explicit was for customization, like it's done with OVERRIDE_TARGETS.

