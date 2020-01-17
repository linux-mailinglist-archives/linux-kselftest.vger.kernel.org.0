Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F54E1406B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2020 10:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgAQJpE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jan 2020 04:45:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44670 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726899AbgAQJpC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jan 2020 04:45:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579254301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5e60O70yf6Qomf9+YnDTvYmEipGiMR/O0K5ZenifWPA=;
        b=Nkc8dPEb7FyU5oGI/Rr0g2doxY4zoze8Z4nbfaAoQR7DiaV5OQh6a3PbiFHfYYtvlIHB1X
        AGJ70FElcPW3tJlATGAXOqjjiLGmPgxjarFcToCECMVeCa+Sa71o4tHgRPrvtmTnSnNvpc
        1P+K2LlnO8z7v7uraXLOfe40ZYQvRyA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-hi2OiDb3OS6QRiljHMCgIA-1; Fri, 17 Jan 2020 04:44:55 -0500
X-MC-Unique: hi2OiDb3OS6QRiljHMCgIA-1
Received: by mail-lj1-f198.google.com with SMTP id w6so6046160ljo.20
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2020 01:44:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=5e60O70yf6Qomf9+YnDTvYmEipGiMR/O0K5ZenifWPA=;
        b=l3N/YQRIALq2FABMVIFYZWXUspI8zkQli9hmBADMreyq5QSW7yobVuXIJ74xkSAitv
         5RWBHj9DmzKIO7F4fDT6W/9Sd6++b8H3l3xHTB4flts8Zagwlstn5NGHoOe7kCtpyXIR
         mNMCOeoDKLlpq6JejlXhT+gdtLh41oAr5/XDMLrCjJeDkb7BkJ1P1kOF1nITuSlY81OU
         ShDy34fwppr6KEArEDqORUNVnd7t39W2VofNzUHdp+kkJD42N2UOXU3RtoBzpLFsDCGs
         PtewYCGX+dfpjU9G123p9+/FnigMLfSESyBgtlKM7DSBgnsYlLeiZeZUUPSjUl1BKC0w
         Mgqg==
X-Gm-Message-State: APjAAAVdMRKWqdmlXaAoVrNK1N/wOP8Z7EGJ0Ehq5oaRq2W9HOxIKDWU
        ks9Af65ngUf84Ct08dfTsvT8/6RoG7d6K9my+Kc1RvVGD0F+cS+SjuuHvxhSPT+ad5jPQz0pYuT
        tAthfzJTyynV86HmckamkssuqcWhr
X-Received: by 2002:a2e:87ca:: with SMTP id v10mr5158803ljj.253.1579254294376;
        Fri, 17 Jan 2020 01:44:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqzvJCbTokiDeykif3nZ+JYIt3dpb4/7pPi4mp5CGEDLhLfyUkqDcuLiiQDfc6OvVTnHL7h8pg==
X-Received: by 2002:a2e:87ca:: with SMTP id v10mr5158794ljj.253.1579254294206;
        Fri, 17 Jan 2020 01:44:54 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id z13sm12089623ljh.21.2020.01.17.01.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 01:44:53 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E29BD1804D6; Fri, 17 Jan 2020 10:44:52 +0100 (CET)
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
Subject: Re: [PATCH bpf-next v3 02/11] tools/bpf/runqslower: Fix override option for VMLINUX_BTF
In-Reply-To: <CAEf4Bzbz47nFh4tPBn2PTi3+YiYpMDxymgf36P=ZjbuBPoCrZg@mail.gmail.com>
References: <157918093154.1357254.7616059374996162336.stgit@toke.dk> <157918093389.1357254.10041649215380772130.stgit@toke.dk> <CAEf4Bzbz47nFh4tPBn2PTi3+YiYpMDxymgf36P=ZjbuBPoCrZg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 17 Jan 2020 10:44:52 +0100
Message-ID: <87wo9qquwb.fsf@toke.dk>
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
>> The runqslower tool refuses to build without a file to read vmlinux BTF
>> from. The build fails with an error message to override the location by
>> setting the VMLINUX_BTF variable if autodetection fails. However, the
>> Makefile doesn't actually work with that override - the error message is
>> still emitted.
>>
>> Fix this by including the value of VMLINUX_BTF in the expansion, and only
>> emitting the error message if the *result* is empty. Also permit running
>> 'make clean' even though no VMLINUX_BTF is set.
>>
>> Fixes: 9c01546d26d2 ("tools/bpf: Add runqslower tool to tools/bpf")
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  tools/bpf/runqslower/Makefile |   18 ++++++++++--------
>>  1 file changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefi=
le
>> index cff2fbcd29a8..89fb7cd30f1a 100644
>> --- a/tools/bpf/runqslower/Makefile
>> +++ b/tools/bpf/runqslower/Makefile
>> @@ -10,12 +10,14 @@ CFLAGS :=3D -g -Wall
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
>> +VMLINUX_BTF_PATHS :=3D $(VMLINUX_BTF) /sys/kernel/btf/vmlinux /boot/vml=
inux-$(KERNEL_REL)
>> +VMLINUX_BTF_PATH :=3D $(firstword $(wildcard $(VMLINUX_BTF_PATHS)))
>
> If user specifies VMLINUX_BTF pointing to non-existing file, but the
> system has /sys/kernel/btf/vmlinux, the latter will still be used,
> which is a very surprising behavior.

Hmm, yeah, good point.

> Also MAKECMDGOALS feels like a fragile hack to me. How about we move
> this VMLINUX_BTF guessing (without $(error)) into vmlinux.h rule
> itself and use shell if conditional after it to check for file
> existance and print nice error. That way we'll be checking VMLINUX_BTF
> only when it's really needed.

OK, sure, can do.

-Toke

