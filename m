Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94A831428D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2020 12:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgATLGx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Jan 2020 06:06:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30971 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726148AbgATLGw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Jan 2020 06:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579518411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GBr/Vebb3VXffLj0Is78F4eUTgwO3xgPG3+P62qQsx8=;
        b=i20Ka0c4AsBFvFOvz/S1g52CSj4yyOSq04XbJqRTit68W12zZ+escxoRMuTEjACV6bpKFm
        V0SdY4qlrg7rrryr58kSXovMLkXZBlmiMB129aPFpdkO9iIar2iBeUZv/rp3aBJA6Ttike
        WNnceN32jEQsZCqKQCq1eSkmJcprNxY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-dV-XKU_uOmiAFiNY4wM7rg-1; Mon, 20 Jan 2020 06:06:48 -0500
X-MC-Unique: dV-XKU_uOmiAFiNY4wM7rg-1
Received: by mail-lj1-f197.google.com with SMTP id v1so7423139lja.21
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2020 03:06:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=GBr/Vebb3VXffLj0Is78F4eUTgwO3xgPG3+P62qQsx8=;
        b=QiZOPOmegmRCWNpFQKxK03T6GxHBz4jEq+xfDfTfUDg2DyJhnoUsoCmKlCGouXfFnA
         vr3dB4oC455W8tmhfelCarCeYW1/xUY3tKf2noUU4jKDVAqnwDIYftcaOMRoynNJJQsm
         lpdZNI+JQrIQVpru1aPFBpjxO525YzviHB1MTf4s2d0s8e0RU2nJUCgqsV7dgX7VyWOl
         bIJ4IYwrr4miXyRJA6Ouc4b8hxHK6BdpnTuT7U9VqhCgp7jUdYHGsKM+Xb7zciEwayA4
         eu5NfjL47kiTgAhvos39iZIxJLLJcy8VgF77CcvDzj0HdVVeMgGjoIwL/nKhx4Gd1Fhq
         cUwQ==
X-Gm-Message-State: APjAAAX6Q6gOcci6RYCsEQO2EuD3wzlMOHp25cxSIeaApcyQ28sI2s1K
        VZl9SJOVLgbUSmwoHSeKo6Scu2cCOQfdf2IGHt2jvv7spoMgIS5lbDWD5SvjZu43zGi6A9sLeJs
        EL/iUQW0Of3vQ20Mku4V48SdxNl55
X-Received: by 2002:a2e:8e22:: with SMTP id r2mr12213808ljk.51.1579518406711;
        Mon, 20 Jan 2020 03:06:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqwRHGGNFbd5H0/cF1REV/7+jcnpPn0KrgS8p2w5aL+jlmOCDTBslDcW/9arMdp3KMXCx8EM9A==
X-Received: by 2002:a2e:8e22:: with SMTP id r2mr12213786ljk.51.1579518406456;
        Mon, 20 Jan 2020 03:06:46 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([85.204.121.218])
        by smtp.gmail.com with ESMTPSA id p136sm16758946lfa.8.2020.01.20.03.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 03:06:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C1D8A1804D6; Mon, 20 Jan 2020 12:06:44 +0100 (CET)
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
Subject: Re: [PATCH bpf-next v4 09/10] selftests: Remove tools/lib/bpf from include path
In-Reply-To: <CAEf4Bzb9zUmhxTyYahJqySJzgfyB-zMEd+o4ybv=a8-t+iZS4w@mail.gmail.com>
References: <157926819690.1555735.10756593211671752826.stgit@toke.dk> <157926820677.1555735.5437255599683298212.stgit@toke.dk> <CAEf4Bzb9zUmhxTyYahJqySJzgfyB-zMEd+o4ybv=a8-t+iZS4w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 20 Jan 2020 12:06:44 +0100
Message-ID: <878sm2pet7.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[...]
> I really-really didn't like this alternating dependency on directory
> or a set of file, depending on current state of those temporary
> directories. Then also this ugly check to avoid circular dependency.
> All that seemed wrong. So I played a bit with how to achieve the same
> differently, and here's what I came up with, which I like a bit
> better. What do you think?
>
> $(BPFOBJ): $(wildcard $(BPFDIR)/*.c $(BPFDIR)/*.h $(BPFDIR)/Makefile)          \
>            ../../../include/uapi/linux/bpf.h                                   \
>            | $(INCLUDE_DIR) $(BUILD_DIR)/libbpf
>         $(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/ \
>                     DESTDIR=$(SCRATCH_DIR) prefix= all install_headers
>
> So, essentially, just make sure that we install local copies of
> headers whenever libbpf.a needs to be re-built.
> ../../../include/uapi/linux/bpf.h ensures we don't miss uapi header
> changes as well. Now anything that uses libbpf headers will need to
> depend on $(BPFOBJ) and will automatically get up-to-date local copies
> of headers.
>
> This seems much simpler. Please give it a try, thanks!

Yes, this is a good idea! It did actually occur to me that the $(BPFOBJ)
rule could just include the install_headers make arg, but only after I
sent out this latest version. Thank you for taking the time to work out
the details, I'll fold this in :)

-Toke

