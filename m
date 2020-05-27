Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2675F1E4B52
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 May 2020 19:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbgE0RCy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 May 2020 13:02:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40231 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728883AbgE0RCy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 May 2020 13:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590598973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0llQvuHUDajWbd807ZLZZoLe6sIkfmzt8DCvGnqKX3w=;
        b=MzGSm6ceIIbdFeCuNeL/6LoR+xbUNN5WALmpAPq+BIZOONyMPy+GqoOdtEgPYVsBM8oOvj
        6+b7sIcKgRZByGXb6zrSfXN3JcEK0bJM/V21eH/+PAI4L7BAs6gksX5VQfEKJbDAkfVmPu
        66diCkWf9cpJsGYa9t04N0zShwFyHP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-1Xhp6ZlVNRWCfah0MzcNvA-1; Wed, 27 May 2020 13:02:49 -0400
X-MC-Unique: 1Xhp6ZlVNRWCfah0MzcNvA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A786835B47;
        Wed, 27 May 2020 17:02:48 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-49.ams2.redhat.com [10.36.114.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B8401768A0;
        Wed, 27 May 2020 17:02:43 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/bpf: split -extras target to -static and -gen
References: <xuny367so4k3.fsf@redhat.com>
        <20200522081901.238516-1-yauheni.kaliuta@redhat.com>
        <CAEf4BzZaCTDT6DcLYvyFr4RUUm4fFbyb743e1JrEp2DS69cbug@mail.gmail.com>
        <xunya71uosvv.fsf@redhat.com>
        <CAADnVQJUL9=T576jo29F_zcEd=C6_OiExaGbEup6F-mA01EKZQ@mail.gmail.com>
        <xuny367lq1z1.fsf@redhat.com>
        <CAADnVQ+1o1JAm7w1twW0KgKMHbp-JvVjzET2N+VS1z=LajybzA@mail.gmail.com>
Date:   Wed, 27 May 2020 20:02:41 +0300
In-Reply-To: <CAADnVQ+1o1JAm7w1twW0KgKMHbp-JvVjzET2N+VS1z=LajybzA@mail.gmail.com>
        (Alexei Starovoitov's message of "Wed, 27 May 2020 09:48:04 -0700")
Message-ID: <xunyh7w1nwem.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Alexei!

>>>>> On Wed, 27 May 2020 09:48:04 -0700, Alexei Starovoitov  wrote:

 > On Wed, May 27, 2020 at 12:19 AM Yauheni Kaliuta
 > <yauheni.kaliuta@redhat.com> wrote:
 >> 
 >> Hi, Alexei!
 >> 
 >> >>>>> On Tue, 26 May 2020 22:37:39 -0700, Alexei Starovoitov  wrote:
 >> 
 >> > On Tue, May 26, 2020 at 10:31 PM Yauheni Kaliuta
 >> > <yauheni.kaliuta@redhat.com> wrote:
 >> >>
 >> >> Hi, Andrii!
 >> >>
 >> >> >>>>> On Tue, 26 May 2020 17:19:18 -0700, Andrii Nakryiko  wrote:
 >> >>
 >> >> > On Fri, May 22, 2020 at 1:19 AM Yauheni Kaliuta
 >> >> > <yauheni.kaliuta@redhat.com> wrote:
 >> >> >>
 >> >> >> There is difference in depoying static and generated extra resource
 >> >> >> files between in/out of tree build and flavors:
 >> >> >>
 >> >> >> - in case of unflavored out-of-tree build static files are not
 >> >> >> available and must be copied as well as both static and generated
 >> >> >> files for flavored build.
 >> >> >>
 >> >> >> So split the rules and variables. The name TRUNNER_EXTRA_GEN_FILES
 >> >> >> is chosen in analogy to TEST_GEN_* variants.
 >> >> >>
 >> >>
 >> >> > Can we keep them together but be smarter about what needs to
 >> >> > be copied based on source/target directories? I would really
 >> >> > like to not blow up all these rules.
 >> >>
 >> >> I can try, ok, I just find it a bit more clear. But it's good to
 >> >> get some input from kselftest about OOT build in general.
 >> 
 >> > I see no value in 'make install' of selftests/bpf
 >> > and since it's broken just remove that makefile target.
 >> 
 >> Some CI systems perform testing next stage after building were
 >> build tree is not available anymore. So it's in use at the
 >> moment.

 > such CI systems can do 'cp -r' then

It's a discussion for linux-kselftest@ (added).

At the moment `make install` is generic kselftest functionality
and since bpf is part of that infra it looks a bit strange to
break it intentionally.

-- 
WBR,
Yauheni Kaliuta

