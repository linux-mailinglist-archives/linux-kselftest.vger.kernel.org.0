Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 347DB148F55
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2020 21:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404309AbgAXU1V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jan 2020 15:27:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25124 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388985AbgAXU1V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jan 2020 15:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579897638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pn41gsoJ7Prz9D2Chq8+4st2brwhG+QxzipNPoNENGo=;
        b=EBV9p5LEBRNMMKcf7LDLxKN7MXpWjZxV9EOFETtbiYgJdI1KOSza/TCgSF7tuQEHcYy1jn
        6ORjurgJ4RN5afvkOGlRDvDucCyT8TRErXO/TvwqfiBjZIDOgq6doKfLr6iPSr9a+4St4O
        USTdUocQ4sYPVlgwJkMlRYl2CIENpV4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-gyT0W_oWOWW46Z-nAigjCg-1; Fri, 24 Jan 2020 15:27:16 -0500
X-MC-Unique: gyT0W_oWOWW46Z-nAigjCg-1
Received: by mail-lf1-f72.google.com with SMTP id x5so609592lfe.6
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2020 12:27:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Pn41gsoJ7Prz9D2Chq8+4st2brwhG+QxzipNPoNENGo=;
        b=g5roEdQMgHOeqzpr0dMPuMqxXeFqBgX1I0w/Y7rdRK/S3kqXF52xGqRs8rRY3stBTu
         NhMxWXrqw1gT3bhdfqvf4mj8qJJx863RTFGc+Ve8ZkkDbiXSZEbG64CNM5UXfJPRt6CZ
         jN3slZZCfoLdFwPdmWFtxQhwcVKzkfGeVs7PygOz8OT/kaqRvJMwCYTma8QDPrDFaN6p
         lRW9esmxVR59jVIPWBe6RAeuQSRcQQYu2GwAuRd4p7VOOjJ6EVSgIr5P99TjkGb1eVnM
         0ypWwuGCtcwCoXVQRPjTKhzSKV1zVQ5dbAFbJc2+4G5UVmTByGlDpLVzHJatCjjVVi+W
         v/ag==
X-Gm-Message-State: APjAAAXElKdAOc7UmSnEj7G4jx0Am9FPqNqSvwOuUgEft+TFS19qgapq
        cK4wQG2gXFpTYIjX0ob1l+W/SEBpfDduwjrYbbr831a23TiiuF5rJQn2RWbTxyh+SaQmwGp3jgZ
        cPaMO4KWiwbYuPVcC2bsmt2mkwCEl
X-Received: by 2002:ac2:515b:: with SMTP id q27mr2115395lfd.119.1579897633632;
        Fri, 24 Jan 2020 12:27:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqx9hrO0z4pTMXfCFGI/ExgfB5vQ/R1c2J8bnz5equSvHLWgIR8YUpPBbv8gpOUT2OWeI+Wb0Q==
X-Received: by 2002:ac2:515b:: with SMTP id q27mr2115388lfd.119.1579897633361;
        Fri, 24 Jan 2020 12:27:13 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([85.204.121.218])
        by smtp.gmail.com with ESMTPSA id q26sm3308753lfp.85.2020.01.24.12.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 12:27:12 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 476A5180073; Fri, 24 Jan 2020 21:27:11 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kernel-team@android.com, Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH] selftests/bpf: Elide a check for LLVM versions that can't compile it
In-Reply-To: <20200124180839.185837-1-palmerdabbelt@google.com>
References: <20200124180839.185837-1-palmerdabbelt@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 24 Jan 2020 21:27:11 +0100
Message-ID: <87ftg4fvmo.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Palmer Dabbelt <palmerdabbelt@google.com> writes:

> The current stable LLVM BPF backend fails to compile the BPF selftests
> due to a compiler bug.  The bug has been fixed in trunk, but that fix
> hasn't landed in the binary packages I'm using yet (Fedora arm64).
> Without this workaround the tests don't compile for me.
>
> This patch triggers a preprocessor warning on LLVM versions that
> definitely have the bug.  The test may be conservative (ie, I'm not sure
> if 9.1 will have the fix), but it should at least make the current set
> of stable releases work together.
>
> See https://reviews.llvm.org/D69438 for more information on the fix.  I
> obtained the workaround from
> https://lore.kernel.org/linux-kselftest/aed8eda7-df20-069b-ea14-f06628984566@gmail.com/T/
>
> Fixes: 20a9ad2e7136 ("selftests/bpf: add CO-RE relocs array tests")
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>

Having to depend on the latest trunk llvm to compile the selftests is
definitely unfortunate. I believe there are some tests that won't work
at all without trunk llvm (the fentry/fexit stuff comes to mind;
although I'm not sure if they'll fail to compile, just fail to run?).
Could we extend this type of checking to any such case?

-Toke

