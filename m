Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0071E3A4D
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 May 2020 09:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgE0HZo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 May 2020 03:25:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45141 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728303AbgE0HZo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 May 2020 03:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590564343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Mrfm+NbtjXlj6SJup9PtU2NprE7561iMdsmIlmqSE4=;
        b=LnGhPbs0jCpOa9gj3/WpDJI/ocJkqJeB2uLiOtL85FVS4/rGGS7doCTp/BYwsR2pjGbf0P
        qETgXCZyLl4pn/uIHWCjTrANR5leSxalPbUPZaN7kKPLSgW6rUyUckbdXoval2mVWH2aan
        lPlhGJAcl1VO9idFrrujXx5mm5xdCh0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-Gp7QDcHHONSqCPWslrtuBw-1; Wed, 27 May 2020 03:25:41 -0400
X-MC-Unique: Gp7QDcHHONSqCPWslrtuBw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CB858014D7;
        Wed, 27 May 2020 07:25:40 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-49.ams2.redhat.com [10.36.114.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CBF0D5C1B0;
        Wed, 27 May 2020 07:25:37 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shuah Khan <shuah@kernel.org>,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 0/8] selftests/bpf: installation and out of tree build fixes
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
        <xuny367so4k3.fsf@redhat.com>
        <CAEf4BzZd507Hyfu8GYxZfJ-Rc0GAs1UNCN0uBqX3kYS9sz-yDA@mail.gmail.com>
        <xunyv9kiou7w.fsf@redhat.com>
        <CAEf4Bzau5MWYqP1XfZzYVj6tf7Y9fmJRgjbO00DzOmJ_iGschg@mail.gmail.com>
Date:   Wed, 27 May 2020 10:25:35 +0300
In-Reply-To: <CAEf4Bzau5MWYqP1XfZzYVj6tf7Y9fmJRgjbO00DzOmJ_iGschg@mail.gmail.com>
        (Andrii Nakryiko's message of "Tue, 26 May 2020 22:04:35 -0700")
Message-ID: <xunyy2pdon4g.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Andrii!

>>>>> On Tue, 26 May 2020 22:04:35 -0700, Andrii Nakryiko  wrote:

 > On Tue, May 26, 2020 at 9:52 PM Yauheni Kaliuta
 > <yauheni.kaliuta@redhat.com> wrote:
 >> 
 >> Hi, Andrii!
 >> 
 >> >>>>> On Tue, 26 May 2020 15:32:10 -0700, Andrii Nakryiko  wrote:
 >> 
 >> > On Thu, May 21, 2020 at 11:41 PM Yauheni Kaliuta
 >> > <yauheni.kaliuta@redhat.com> wrote:
 >> >>
 >> >>
 >> >> Actually, a bit more needed :)
 >> 
 >> > From the other kselftest thread, it seems like selftests are not
 >> > supporting builds out-of-tree. With that, wouldn't it be simpler to
 >> > build in tree and then just copy selftests/bpf directory to wherever
 >> > you need to run tests from? It would be simple and reliable. Given I
 >> > and probably everyone else never build and run tests out-of-tree, it's
 >> > just too easy to break this and you'll be constantly chasing some
 >> > non-obvious breakages...
 >> 
 >> > Is there some problem with such approach?
 >> 
 >> This is `make install` ;).

 > So patch #2, #5, and #7 is solving just `make install` problem?..

No, they are fixing OOT build problems. I should have probably
split the series, oot and install fixes.

 > My point is that by building in tree and then just copying
 > everything under selftests/bpf directory to wherever you want
 > to "install" it would just work. And won't require
 > complicating already complicated Makefile. Any problem with
 > such approach?

I understand. I see only wasting of space as a problem, but
should check.

 >> 
 >> I personally do not need OOT build, but since it's in the code,
 >> I'd prefer either fix it or remove it, otherwise it's
 >> misleading. But I have not got reply from kselftest.
 >> 
 >> >>
 >> >> >>>>> On Fri, 22 May 2020 07:13:02 +0300, Yauheni Kaliuta  wrote:
 >> >>
 >> >> > I had a look, here are some fixes.
 >> >> > Yauheni Kaliuta (8):
 >> >> >   selftests/bpf: remove test_align from Makefile
 >> >> >   selftests/bpf: build bench.o for any $(OUTPUT)
 >> >> >   selftests/bpf: install btf .c files
 >> >> >   selftests/bpf: fix object files installation
 >> >> >   selftests/bpf: add output dir to include list
 >> >> >   selftests/bpf: fix urandom_read installation
 >> >> >   selftests/bpf: fix test.h placing for out of tree build
 >> >> >   selftests/bpf: factor out MKDIR rule
 >> >>
 >> >> >  tools/testing/selftests/bpf/Makefile | 77 ++++++++++++++++++++--------
 >> >> >  1 file changed, 55 insertions(+), 22 deletions(-)
 >> >>
 >> >> > --
 >> >> > 2.26.2
 >> >>
 >> >>
 >> >> --
 >> >> WBR,
 >> >> Yauheni Kaliuta
 >> >>
 >> 
 >> 
 >> --
 >> WBR,
 >> Yauheni Kaliuta
 >> 


-- 
WBR,
Yauheni Kaliuta

