Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768B9491124
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jan 2022 21:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiAQUzI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jan 2022 15:55:08 -0500
Received: from mail.efficios.com ([167.114.26.124]:52280 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiAQUzH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jan 2022 15:55:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id EAA29304BC6;
        Mon, 17 Jan 2022 15:55:06 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id QluqGJmTO6uJ; Mon, 17 Jan 2022 15:55:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4619E304AEF;
        Mon, 17 Jan 2022 15:55:06 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4619E304AEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1642452906;
        bh=d49ncy0MXhPyV6I9UPtc4gs6gA7dVv8m6XtsJokPBKU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=d/79NZ52WwiKIxEapfaX+yLqxzvEKc6VhLDVj90p5e130fe2PVoqRV7IYGfk/uQED
         55pI8uGyxodadvKVkngAy+Eif/57C/4xK39CnuuZaVAT9L5ZT6jV/sDKJ9/r+b9F3w
         x/U2M9qSNicNSU+BVStFnxr6xPfQE7JE166pLzdtkqg5w1Fvrz/GnvUM1BZwDEYI7M
         f2Fd76Rz9y/kxcZbmTPikw1p2twlyRPpsg8cr7HR+FwZBNHEFwbqzhJcmW2DoCcK/U
         n60uRR7O/GSW5SxtFnk6Tye1EsaL9oCmcEPM6DS60J3q8CV2WC3zxOM7Xu5s1tIjot
         dpidoz/UiaFBw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xbVVbWiXWtg3; Mon, 17 Jan 2022 15:55:06 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 30BB1304E48;
        Mon, 17 Jan 2022 15:55:06 -0500 (EST)
Date:   Mon, 17 Jan 2022 15:55:06 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        David Laight <David.Laight@ACULAB.COM>,
        carlos <carlos@redhat.com>
Message-ID: <1701683017.40984.1642452906075.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220117203925.12164-1-mathieu.desnoyers@efficios.com>
References: <20220117203925.12164-1-mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH 0/5] RSEQ selftests uplift for glibc-2.35
 compatibility
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Topic: RSEQ selftests uplift for glibc-2.35 compatibility
Thread-Index: WM5Grb2V34t+nrcJuSFSG2JwO5Q8PA==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[ I should really have CC'd the selftests maintainer and mailing list.
  Adding them in Cc to patch 0/5 to bring this series to their attention. ]

----- On Jan 17, 2022, at 3:39 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> glibc-2.35 will be released on 2022-02-01. It introduces a user-space ABI
> based on the thread pointer to access a reserved area of the TCB.
> 
> The rseq selftests originally expected the rseq thread data to sit in a
> __rseq_abi TLS variable.
> 
> Considering that the rseq ABI only allows a single rseq registration per
> thread, both cannot actively coexist in a process.
> 
> Adapt the selftests librseq implementation to become compatible with
> glibc-2.35. Keep a fallback implementation based on TLS available when
> an older glibc is detected.
> 
> Feedback is welcome,
> 
> Thanks,
> 
> Mathieu
> 
> Mathieu Desnoyers (5):
>  selftests/rseq: Remove useless assignment to cpu variable
>  selftests/rseq: Remove volatile from __rseq_abi
>  selftests/rseq: Introduce rseq_get_abi() helper
>  selftests/rseq: Introduce thread pointer getters
>  selftests/rseq: Uplift rseq selftests for compatibility with
>    glibc-2.35
> 
> tools/testing/selftests/rseq/Makefile         |   2 +-
> tools/testing/selftests/rseq/param_test.c     |   4 +-
> tools/testing/selftests/rseq/rseq-arm.h       |  32 ++--
> tools/testing/selftests/rseq/rseq-arm64.h     |  32 ++--
> .../rseq/rseq-generic-thread-pointer.h        |  25 +++
> tools/testing/selftests/rseq/rseq-mips.h      |  32 ++--
> .../selftests/rseq/rseq-ppc-thread-pointer.h  |  30 ++++
> tools/testing/selftests/rseq/rseq-ppc.h       |  32 ++--
> tools/testing/selftests/rseq/rseq-s390.h      |  24 +--
> .../selftests/rseq/rseq-thread-pointer.h      |  19 +++
> .../selftests/rseq/rseq-x86-thread-pointer.h  |  40 +++++
> tools/testing/selftests/rseq/rseq-x86.h       |  30 ++--
> tools/testing/selftests/rseq/rseq.c           | 161 +++++++++---------
> tools/testing/selftests/rseq/rseq.h           |  24 ++-
> 14 files changed, 302 insertions(+), 185 deletions(-)
> create mode 100644 tools/testing/selftests/rseq/rseq-generic-thread-pointer.h
> create mode 100644 tools/testing/selftests/rseq/rseq-ppc-thread-pointer.h
> create mode 100644 tools/testing/selftests/rseq/rseq-thread-pointer.h
> create mode 100644 tools/testing/selftests/rseq/rseq-x86-thread-pointer.h
> 
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
