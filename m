Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADB1213D661
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 10:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbgAPJF1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jan 2020 04:05:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22179 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730479AbgAPJF0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jan 2020 04:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579165525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y2sHZjFM/LF4FSRl9k3ji7wAimUlmv4VENghwEoHHns=;
        b=gLjc4dSSBSChSzyhSVVEEPe0NDlIrnGAntClMr31LNz68cbkHU0Qq13Sbg2sXsTpZ9ohYc
        bYfgnrdTk9k+rJyagOoX/6NrabMcrmrxQ3ebaVMUCC28D1aQFbKqw1LKrSlWdXI9PufmtC
        UEbFZHaf4psDN4FHI1P2nwTUMrg8kh0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-iYzXD-0PMbeZC77l96IoWQ-1; Thu, 16 Jan 2020 04:05:24 -0500
X-MC-Unique: iYzXD-0PMbeZC77l96IoWQ-1
Received: by mail-lf1-f71.google.com with SMTP id t74so3734017lff.8
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2020 01:05:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Y2sHZjFM/LF4FSRl9k3ji7wAimUlmv4VENghwEoHHns=;
        b=ROspG3o2vfZD99NaPmXSb3nAdOu7ym1OP3hmEaNkW27C4qezZRxGOiAg+6nUErn9dZ
         LTvRUuWlp4ab3PNb/GnJozyiJgpnoNf13nbUI31vMqhADwHe2LT82Cwq0QrhhNgiZ2YN
         VyVfF3XPG3E+9U1vqVnR46hrSDr0h7pY+re4fPNmgxaWqmh0l8pMdPOFaPQFDPOCm64E
         1HJjg36pcvFSv/HJPBN7AIPFWPMbNJs46XH9oqpSQx+XosojnCSPHLzaOUNdRdVe71O4
         yDGoLa6cFkhXZRdtUoHbzR3WtlfZAnVlWm4vFqrJBsJ9hIQhCvbdWkSq5AasXOBZwR3G
         v8RQ==
X-Gm-Message-State: APjAAAWIUfhKCa13l/djUOebZHVhWM5dfn9M818rtz1wRnDBTu9qPudT
        QQkAsIvCeBLYc8CbumX1Hp076N+L6bNqU4pk5+yGcpg8W2LlJeyzszompQd5Dr2qLo5sIZaCgeQ
        DXzcUm8kflhEwFUwgoqqGF5LT/79E
X-Received: by 2002:a19:84d:: with SMTP id 74mr1827740lfi.122.1579165522793;
        Thu, 16 Jan 2020 01:05:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqxtYKtFhKWeWSmtkAXlwptUVTHXo0/PpHdSJDlJjU/1gqMfUwxDd/orLS0cMSYGbPmKFM/PCA==
X-Received: by 2002:a19:84d:: with SMTP id 74mr1827704lfi.122.1579165522538;
        Thu, 16 Jan 2020 01:05:22 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a14sm9871321lfh.50.2020.01.16.01.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 01:05:20 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 579641804D6; Thu, 16 Jan 2020 10:05:19 +0100 (CET)
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
In-Reply-To: <CAEf4BzZpGe-1S5_iwS8GBw9iiyFJmDUkOaO+2qaftRn_iy5cNA@mail.gmail.com>
References: <157909756858.1192265.6657542187065456112.stgit@toke.dk> <157909757089.1192265.9038866294345740126.stgit@toke.dk> <CAEf4BzbqY8zivZy637Xy=iTECzBAYQ7vo=M7TvsLM2Yp12bJpg@mail.gmail.com> <87v9pctlvn.fsf@toke.dk> <CAEf4BzZpGe-1S5_iwS8GBw9iiyFJmDUkOaO+2qaftRn_iy5cNA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 16 Jan 2020 10:05:19 +0100
Message-ID: <87a76nu5yo.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Wed, Jan 15, 2020 at 2:06 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> > On Wed, Jan 15, 2020 at 6:13 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke=
@redhat.com> wrote:
>> >>
>> >> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> >>
>> >> The runqslower tool refuses to build without a file to read vmlinux B=
TF
>> >> from. The build fails with an error message to override the location =
by
>> >> setting the VMLINUX_BTF variable if autodetection fails. However, the
>> >> Makefile doesn't actually work with that override - the error message=
 is
>> >> still emitted.
>> >
>> > Do you have example command with VMLINUX_BTF override that didn't work
>> > (and what error message was emitted)?
>>
>> Before this patch:
>>
>> $ cd ~/build/linux/tools/bpf/runqslower
>> $ make
>> Makefile:18: *** "Can't detect kernel BTF, use VMLINUX_BTF to specify it=
 explicitly".  Stop.
>>
>> $ make VMLINUX_BTF=3D~/build/linux/vmlinux
>> Makefile:18: *** "Can't detect kernel BTF, use VMLINUX_BTF to specify it=
 explicitly".  Stop.
>
> Ok, so this is strange. Try make clean and run with V=3D1, it might help
> to debug this. This could happen if ~/build/linux/vmlinux doesn't
> exist, but I assume you double-checked that. It works for me just fine
> (Makefile won't do VMLINUX_BTF :=3D assignment, if it's defined through
> make invocation, so your change should be a no-op in that regard):
>
> $ make clean
> $ make VMLINUX_BTF=3D~/linux-build/default/vmlinux V=3D1
> ...
> .output/sbin/bpftool btf dump file ~/linux-build/default/vmlinux
> format c > .output/vmlinux.h
> ...
>
> Wonder what your output looks like?

$ make clean
Makefile:18: *** "Can't detect kernel BTF, use VMLINUX_BTF to specify it ex=
plicitly".  Stop.
$ make VMLINUX_BTF=3D~/build/linux/vmlinux V=3D1
Makefile:18: *** "Can't detect kernel BTF, use VMLINUX_BTF to specify it ex=
plicitly".  Stop.

Take another look at the relevant part of the makefile:

  ifneq ("$(wildcard /sys/kernel/btf/vmlinux)","")
  VMLINUX_BTF :=3D /sys/kernel/btf/vmlinux
  else ifneq ("$(wildcard /boot/vmlinux-$(KERNEL_REL))","")
  VMLINUX_BTF :=3D /boot/vmlinux-$(KERNEL_REL)
  else
  $(error "Can't detect kernel BTF, use VMLINUX_BTF to specify it explicitl=
y")
  endif

That if/else doesn't actually consider the value of VMLINUX_BTF; so the
override only works if one of the files being considered by the
auto-detection actually exists... :)

-Toke

