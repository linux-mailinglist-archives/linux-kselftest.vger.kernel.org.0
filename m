Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6273D13CFC0
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2020 23:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbgAOWHB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Jan 2020 17:07:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41295 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729992AbgAOWG7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Jan 2020 17:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579126017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2oZ0/KEDQ6dTwiAcIr2E5jK3OjJKgPjKG2s+1U8IzDY=;
        b=F7CD6zPgqEcj45Vc3Y5yVQs1h8jAohsbwZat45fNNg8W5YBLs8phGcT6ceCgxiQ2IlQNuo
        D3Lj1pBPbhno8r1eEJ4A+4959bU9tatNcFHf1P4ajQ9tsMeGI+PG6haZY7XONT0fEZL8HZ
        R3EJy18qylTINOJcIa+5ctd5b/t+Tf4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-LMweYziXNYe0-tJYYYeEEg-1; Wed, 15 Jan 2020 17:06:56 -0500
X-MC-Unique: LMweYziXNYe0-tJYYYeEEg-1
Received: by mail-lj1-f198.google.com with SMTP id s25so4464690ljm.9
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2020 14:06:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=2oZ0/KEDQ6dTwiAcIr2E5jK3OjJKgPjKG2s+1U8IzDY=;
        b=HBxbRaDp2JP38ESNwZ00g9MawSO4P1fptxV4v4ZUQVeKVNB0hE4DEmsHFX1Qnjl2Pj
         c+JGor0HCBrVivikbVn4GAd8hVwu98tIKyGXzCAO/DlrLj9AN6VJKIpi6zoDSp5y2tAm
         bmwL0TNnrYsYss9zfwtbFv2yz2ILOSUV5W86StUzLLSutqjg3UkIIpKetLZJAlpJIKez
         fYwLvFHyYqkpmQggmaREo29ZF7Rr6DQfEMcsiVbVDlgYY5QNJIA57YjnVen6B6vchWBG
         rQAXrTBcNLOgy07euwPLPCjnJGBSY0kYa449gs+L0JCIWdEVywgJvdA9oG2c2gwOaw3u
         c4GA==
X-Gm-Message-State: APjAAAV8E+Wwq4VlB3uAet5RalyCD7ndscBxFLWqtgLJ7tENXwKyqI2z
        iNxvcYmACtAoBU/zqo/SrCHN+h/IOH+abNWbjffpYOik8+wLrOvX5UNWtNw19sncdxlIo6VOMH7
        aOOap58EJICTCJ6O6d2htN7tT+oJx
X-Received: by 2002:a2e:3e03:: with SMTP id l3mr298596lja.237.1579126015010;
        Wed, 15 Jan 2020 14:06:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqyICy0H3yi0QO3D1AnqbT83z5lYl+AEoYsdeygh7OdbhjgdnK2+SYcwTz5CjSsgq/x/PPJOpQ==
X-Received: by 2002:a2e:3e03:: with SMTP id l3mr298563lja.237.1579126014662;
        Wed, 15 Jan 2020 14:06:54 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id k5sm9561045lfd.86.2020.01.15.14.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 14:06:53 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BEFA11804D6; Wed, 15 Jan 2020 23:06:52 +0100 (CET)
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
        Jakub Kicinski <jakub.kicinski@netronome.com>,
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
Subject: Re: [PATCH bpf-next v2 02/10] tools/bpf/runqslower: Fix override option for VMLINUX_BTF
In-Reply-To: <CAEf4BzbqY8zivZy637Xy=iTECzBAYQ7vo=M7TvsLM2Yp12bJpg@mail.gmail.com>
References: <157909756858.1192265.6657542187065456112.stgit@toke.dk> <157909757089.1192265.9038866294345740126.stgit@toke.dk> <CAEf4BzbqY8zivZy637Xy=iTECzBAYQ7vo=M7TvsLM2Yp12bJpg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 15 Jan 2020 23:06:52 +0100
Message-ID: <87v9pctlvn.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Wed, Jan 15, 2020 at 6:13 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>
>> The runqslower tool refuses to build without a file to read vmlinux BTF
>> from. The build fails with an error message to override the location by
>> setting the VMLINUX_BTF variable if autodetection fails. However, the
>> Makefile doesn't actually work with that override - the error message is
>> still emitted.
>
> Do you have example command with VMLINUX_BTF override that didn't work
> (and what error message was emitted)?

Before this patch:

$ cd ~/build/linux/tools/bpf/runqslower
$ make
Makefile:18: *** "Can't detect kernel BTF, use VMLINUX_BTF to specify it ex=
plicitly".  Stop.

$ make VMLINUX_BTF=3D~/build/linux/vmlinux
Makefile:18: *** "Can't detect kernel BTF, use VMLINUX_BTF to specify it ex=
plicitly".  Stop.

>> Fix this by only doing auto-detection if no override is set. And while
>> we're at it, also look for a vmlinux file in the current kernel build dir
>> if none if found on the running kernel.
>>
>> Fixes: 9c01546d26d2 ("tools/bpf: Add runqslower tool to tools/bpf")
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  tools/bpf/runqslower/Makefile |   16 ++++++++++------
>>  1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefi=
le
>> index cff2fbcd29a8..fb93ce2bf2fe 100644
>> --- a/tools/bpf/runqslower/Makefile
>> +++ b/tools/bpf/runqslower/Makefile
>> @@ -10,12 +10,16 @@ CFLAGS :=3D -g -Wall
>>
>>  # Try to detect best kernel BTF source
>>  KERNEL_REL :=3D $(shell uname -r)
>> -ifneq ("$(wildcard /sys/kernel/btf/vmlinux)","")
>> -VMLINUX_BTF :=3D /sys/kernel/btf/vmlinux
>> -else ifneq ("$(wildcard /boot/vmlinux-$(KERNEL_REL))","")
>> -VMLINUX_BTF :=3D /boot/vmlinux-$(KERNEL_REL)
>> -else
>> -$(error "Can't detect kernel BTF, use VMLINUX_BTF to specify it explici=
tly")
>> +ifeq ("$(VMLINUX_BTF)","")
>> +  ifneq ("$(wildcard /sys/kernel/btf/vmlinux)","")
>> +  VMLINUX_BTF :=3D /sys/kernel/btf/vmlinux
>> +  else ifneq ("$(wildcard /boot/vmlinux-$(KERNEL_REL))","")
>> +  VMLINUX_BTF :=3D /boot/vmlinux-$(KERNEL_REL)
>> +  else ifneq ("$(wildcard $(abspath ../../../vmlinux))","")
>> +  VMLINUX_BTF :=3D $(abspath ../../../vmlinux)
>
> I'm planning to mirror runqslower into libbpf Github repo and this
> ../../../vmlinux piece will be completely out of place in that
> context. Also it only will help when building kernel in-tree. So I'd
> rather not add this.

Well building the kernel in-tree is something people sometimes want to do ;)

Specifically, the selftests depend on this, so we should at least fix
those; but I guess it could work to just pass in VMLINUX_BTF as part of
the make -C from the selftests dir? I'll try that...

-Toke

