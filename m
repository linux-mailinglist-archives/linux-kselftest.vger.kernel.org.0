Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25E8713CFD1
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2020 23:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbgAOWJz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Jan 2020 17:09:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27048 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728925AbgAOWJw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Jan 2020 17:09:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579126191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gHyBZ8+XeG4963OEjkw03c1ZgmrL31FuTlHZYv52rM=;
        b=eZHf9F70t9cZP5veLlilA3bFRm4BbKHIT37j/5vchYyIJRZ2KA60BnVcmNU3lVievLY87G
        9pnw4CAXjUaAR2rWtxHakuObiD5ciqRwD0WJmYvv2/0i243RKUv0qq+Q5yVJqhe2dPFY19
        fsAoO8odmsyvXDUeVxtVpdTa1c5PFeE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-NV9IZUCjNN2IKZ1E4uo5Ug-1; Wed, 15 Jan 2020 17:09:48 -0500
X-MC-Unique: NV9IZUCjNN2IKZ1E4uo5Ug-1
Received: by mail-lj1-f197.google.com with SMTP id 126so4468754ljj.10
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2020 14:09:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6gHyBZ8+XeG4963OEjkw03c1ZgmrL31FuTlHZYv52rM=;
        b=WUtQ87ffTcO/+4DA6cJ7Lbd4ViLL2qjptgbUz8S2Oq3W+JTFexMuChzzEEI/+NrzLI
         L4DvqSa9g199oclPFSAFN9fCKyZ+v0dAa/n0j3JKZsGLx+cpaBUq9lh58Bbi7Q2t3Hnn
         Obvn/1FRfANPSyy5Ziu+SjKyl7Dg7pHY8h6jl29XrUPme46Wcm1gpbC5Aj4BSxNrn8Tb
         i1YA/EGsit+xlp9Zpmb4Z761/qNv3Sl6j18WXklhseUCEdFqI+c9s/C9aJ5ycM1MxJBI
         OmBRhf+ANB72u80Dk8oKIRKJqvI0ldQBOZsyeLPzuHrRjjf24FLgII2/XlQRWPjifm0e
         laAQ==
X-Gm-Message-State: APjAAAWPl9kOt/3Z0AHEBlby62BRl/UoIW3YDIozdi3UT/+0zFaEGAFI
        k7CfDg7P8oXYZzoBA8p9/OTohNcTOhrDs/jqspf8Xzg+AyF8FLUrgqTWqsU0rAhPq5krhJp2I40
        JJi0sX0M4I3lwPVzzCQo3H6Wa8hjg
X-Received: by 2002:a2e:8804:: with SMTP id x4mr309066ljh.187.1579126186245;
        Wed, 15 Jan 2020 14:09:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqyl9usYNPHfWl85TIz6drR9BBM82kZH5HkqsoxTXL5G4+0RjNxZ3iAMQC2ii0NABa1NGrcMXg==
X-Received: by 2002:a2e:8804:: with SMTP id x4mr309055ljh.187.1579126186024;
        Wed, 15 Jan 2020 14:09:46 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id r20sm9450459lfi.91.2020.01.15.14.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 14:09:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 970D01804D6; Wed, 15 Jan 2020 23:09:44 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH bpf-next v2 00/10] tools: Use consistent libbpf include paths everywhere
In-Reply-To: <20200115211900.h44pvhe57szzzymc@ast-mbp.dhcp.thefacebook.com>
References: <157909756858.1192265.6657542187065456112.stgit@toke.dk> <20200115211900.h44pvhe57szzzymc@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 15 Jan 2020 23:09:44 +0100
Message-ID: <87r200tlqv.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Jan 15, 2020 at 03:12:48PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> The recent commit 6910d7d3867a ("selftests/bpf: Ensure bpf_helper_defs.h=
 are
>> taken from selftests dir") broke compilation against libbpf if it is ins=
talled
>> on the system, and $INCLUDEDIR/bpf is not in the include path.
>>=20
>> Since having the bpf/ subdir of $INCLUDEDIR in the include path has neve=
r been a
>> requirement for building against libbpf before, this needs to be fixed. =
One
>> option is to just revert the offending commit and figure out a different=
 way to
>> achieve what it aims for. However, this series takes a different approac=
h:
>> Changing all in-tree users of libbpf to consistently use a bpf/ prefix in
>> #include directives for header files from libbpf.
>
> I don't think such approach will work in all cases.
> Consider the user installing libbpf headers into /home/somebody/include/b=
pf/,
> passing that path to -I and trying to build bpf progs
> that do #include "bpf_helpers.h"...
> In the current shape of libbpf everything will compile fine,
> but after patch 8 of this series the compiler will not find bpf/bpf_helpe=
r_defs.h.
> So I think we have no choice, but to revert that part of Andrii's patch.
> Note that doing #include "" for additional library headers is a common pr=
actice.
> There was nothing wrong about #include "bpf_helper_defs.h" in bpf_helpers=
.h.

OK, I'll take another look at that bit and see if I can get it to work
with #include "bpf_helper_defs.h" and still function with the read-only
tree (and avoid stale headers).

-Toke

