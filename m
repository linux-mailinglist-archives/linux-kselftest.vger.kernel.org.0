Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D98A1406DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2020 10:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgAQJuv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jan 2020 04:50:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41579 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726409AbgAQJuu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jan 2020 04:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579254649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oJRJOOtAJx4rABOIyWYmHnWYUrcoGrCqCdDRh2YY52I=;
        b=D+ypkinIM1fAZCo4PyGsuqY35pitftIJJkYKDcALtD800K5tHOcRlwrJ5AG8IeyxDPHJLD
        xyqNR0S44DJqTdpE5bTH3kMWLWom1/uQNVXAGL4RokS4jXyaCNgxP54NoUJvMTr8BCukmB
        //CKPgVmq7QSXeaUd8zUxEJ7oNRRAfg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-dkYIZLf9Mze-2myifc1PUA-1; Fri, 17 Jan 2020 04:50:47 -0500
X-MC-Unique: dkYIZLf9Mze-2myifc1PUA-1
Received: by mail-lj1-f200.google.com with SMTP id j23so6041535lji.23
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2020 01:50:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=oJRJOOtAJx4rABOIyWYmHnWYUrcoGrCqCdDRh2YY52I=;
        b=kG5iisAm+6TjIznaPQdd7hOK4nTHvZ8o+x11TiuviJIwEtSlmLM0kWEW4P0NGmPSWW
         4CbTEXzG+21GupV/19pyDQ1CRBhkv496qVWb8UHvVVCC4SsXWV3S42rnGkQtu8iCJZ3y
         1eEi9HNGCX+dsECo1gUHACypaZztUX225bOLco9Hxpc6myvGl77bZRs7Im9NAH1ooCPt
         qoDMvfVc5UC3ewo+c/bvYbkWQa0dHOr/c7kN6gzmpbPtd36Jv5SBE1AhGOzuztxOBsjv
         rNUrNpfO8e4bggJ65t52+CIWKAN7dwyUZD9zl09uLufXovGplVC9q1QFLyk/GgZ3ghq8
         jz5Q==
X-Gm-Message-State: APjAAAWtVDgf3wQM02sz4XxjdBsK4keOR2kovEqbLFuOCJI0zP/KRH3V
        IPX/Khx8Rj+2bULxvlWhLFuW+1ZKdbhwWnpeR8ds+1upFfK3x/SWDR2/zMwuvZ/Y1AMBaWJ7+kp
        gUBfeML4SxgJTTy4skdF24jDraU2V
X-Received: by 2002:a2e:3a0c:: with SMTP id h12mr5110080lja.200.1579254646260;
        Fri, 17 Jan 2020 01:50:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqxVH1mvGN7jFxhc1CGWH4ht8uwwpUWB8gY29//W0Sp2WPWefYaaYkajI0yi/HmyV1E0o/g6WQ==
X-Received: by 2002:a2e:3a0c:: with SMTP id h12mr5110047lja.200.1579254646128;
        Fri, 17 Jan 2020 01:50:46 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id s9sm14012128ljh.90.2020.01.17.01.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 01:50:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D7C9C1804D6; Fri, 17 Jan 2020 10:50:44 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-rdma@vger.kernel.org,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH bpf-next v3 09/11] selftests: Remove tools/lib/bpf from include path
In-Reply-To: <CAEf4BzYaLd25P7Uu=aFHW_=nHOCPdCpZCcoJobhRoSGQUA49HQ@mail.gmail.com>
References: <157918093154.1357254.7616059374996162336.stgit@toke.dk> <157918094179.1357254.14428494370073273452.stgit@toke.dk> <CAEf4Bzba5FHN_iN52qRiGisRcauur1FqDY545EwE+RVR-nFvQA@mail.gmail.com> <CAEf4BzYaLd25P7Uu=aFHW_=nHOCPdCpZCcoJobhRoSGQUA49HQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 17 Jan 2020 10:50:44 +0100
Message-ID: <87o8v2qumj.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Jan 16, 2020 at 2:41 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Thu, Jan 16, 2020 at 5:28 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
>> >
>> > From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> >
>> > To make sure no new files are introduced that doesn't include the bpf/
>> > prefix in its #include, remove tools/lib/bpf from the include path
>> > entirely.
>> >
>> > Instead, we introduce a new header files directory under the scratch t=
ools/
>> > dir, and add a rule to run the 'install_headers' rule from libbpf to h=
ave a
>> > full set of consistent libbpf headers in $(OUTPUT)/tools/include/bpf, =
and
>> > then use $(OUTPUT)/tools/include as the include path for selftests.
>> >
>> > For consistency we also make sure we put all the scratch build files f=
rom
>> > other bpftool and libbpf into tools/build/, so everything stays within
>> > selftests/.
>> >
>> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> > ---
>
> BTW, this change also now forces full rebuild regardless if anything
> changed or not :(

It does? Hmm, that was not intentional (I was mostly focused on making
sure a clean make worked, not the opposite). I'll see if I can't fix
that as well...

-Toke

