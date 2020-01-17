Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8B361406C4
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2020 10:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgAQJrD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jan 2020 04:47:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56625 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726883AbgAQJrD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jan 2020 04:47:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579254422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MRdZZz9P8UIoKzsy8bUaagOkve384w9nZaJDimC4aAA=;
        b=RIeXKXaoWoahHcca3rf5aBFLFtIykftH+O4yYyp4+xclJ4xiBJ3UgM6UDmWRgLX//CtOiE
        mL6xb9CrTHkTlHJX+nB06PW+j6zuLL9MTmlpxx+kFkamUlDsdTqgiyI9WjPpOKnKbFzP4M
        Wu8f3xXPw6CtVZ4aCMyGdXXGFISILmE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-gZCisPJKP0K5Rlb4c2qtOA-1; Fri, 17 Jan 2020 04:47:01 -0500
X-MC-Unique: gZCisPJKP0K5Rlb4c2qtOA-1
Received: by mail-lf1-f70.google.com with SMTP id y4so4249793lfg.1
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2020 01:47:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=MRdZZz9P8UIoKzsy8bUaagOkve384w9nZaJDimC4aAA=;
        b=OXdG8p0u7SUBBaSWzYTEiRB8JHBFj2dEdsWh5t9urIJ+UHby2HcYq294yWgbChnE6/
         wKWuiFIpc6XxXouu5I6NG5WnhGDqjU7o4odN79QMkW7gEpSKs5ws7TtTMaYLbK/A1owp
         0DOcyVDEmcu5aVpz9AOsKptLf0l1oLhoCmgVZDg16Z3EI3ZpRtzBZ4tYgzbTJWqwBQq2
         U/vkNF4W7cQQbaQJJP5GJi2qy/uuhBdZUZTjZnhwVF5Dq1YA5FKqYM5iA8u0OUjP9TMH
         DqfWt8Py7zX57wLxFkfrjzcdX94Z/hGLsnKJf2/8o9PGsGcKqY8XBf2wDrQ7Q5BOYAct
         LiDw==
X-Gm-Message-State: APjAAAVUH7KO9uuK/QHmYhRegcKkZJZEIrJqnRm5qke79aPv9+Qfm/ft
        OM8TnC/OvWflwuFXl/d1tzBljIAquTN35+4tf4AtMEKhobu08wcX2eRF+m2alHeEHGalVKQ1UlS
        6AiHNNlNxOLQIBNe0L9/4eaMdrQ46
X-Received: by 2002:a19:7015:: with SMTP id h21mr4868737lfc.68.1579254419648;
        Fri, 17 Jan 2020 01:46:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqyjvTMUn7InwON8DwCpRgzC4ouRW99OTFzcLs217w1iCLWqujy5RCewHLMusTudpnVGBByZkg==
X-Received: by 2002:a19:7015:: with SMTP id h21mr4868705lfc.68.1579254419486;
        Fri, 17 Jan 2020 01:46:59 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id r15sm12041957ljh.11.2020.01.17.01.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 01:46:58 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3553E1804D6; Fri, 17 Jan 2020 10:46:58 +0100 (CET)
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
Subject: Re: [PATCH bpf-next v3 04/11] tools/runqslower: Use consistent include paths for libbpf
In-Reply-To: <CAEf4BzbJZ7JUyr8p3YKX-Rrth_B7OMbih50xxyt_YNBd--107w@mail.gmail.com>
References: <157918093154.1357254.7616059374996162336.stgit@toke.dk> <157918093613.1357254.10230277763921623892.stgit@toke.dk> <CAEf4BzbJZ7JUyr8p3YKX-Rrth_B7OMbih50xxyt_YNBd--107w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 17 Jan 2020 10:46:58 +0100
Message-ID: <87tv4uqust.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Jan 16, 2020 at 5:23 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>
>> Fix the runqslower tool to include libbpf header files with the bpf/
>> prefix, to be consistent with external users of the library. Also ensure
>> that all includes of exported libbpf header files (those that are export=
ed
>> on 'make install' of the library) use bracketed includes instead of quot=
ed.
>>
>> To not break the build, keep the old include path until everything has b=
een
>> changed to the new one; a subsequent patch will remove that.
>>
>> Fixes: 6910d7d3867a ("selftests/bpf: Ensure bpf_helper_defs.h are taken =
from selftests dir")
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  tools/bpf/runqslower/Makefile         |    5 +++--
>>  tools/bpf/runqslower/runqslower.bpf.c |    2 +-
>>  tools/bpf/runqslower/runqslower.c     |    4 ++--
>>  3 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefi=
le
>> index 89fb7cd30f1a..c0512b830805 100644
>> --- a/tools/bpf/runqslower/Makefile
>> +++ b/tools/bpf/runqslower/Makefile
>> @@ -5,6 +5,7 @@ LLC :=3D llc
>>  LLVM_STRIP :=3D llvm-strip
>>  DEFAULT_BPFTOOL :=3D $(OUTPUT)/sbin/bpftool
>>  BPFTOOL ?=3D $(DEFAULT_BPFTOOL)
>> +LIBBPF_INCLUDE :=3D -I$(abspath ../../lib) -I$(abspath ../../lib/bpf)
>
> I'd probably put all the -I's into single INCLUDES var and include
> that one instead of mixing -I$(OUTPUT) and $(LIBBPF_INCLUDE), but this
> works too.

Hmm, yeah, not a bad idea, actually. Since it seems I'm respinning
anyway, I'll fix that up as well.

-Toke

