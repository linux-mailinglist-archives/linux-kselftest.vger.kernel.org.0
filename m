Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73FAF14EED6
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2020 15:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbgAaO40 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Jan 2020 09:56:26 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36556 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgAaO40 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Jan 2020 09:56:26 -0500
Received: by mail-yw1-f68.google.com with SMTP id n184so4942060ywc.3
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Jan 2020 06:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f3RC/SQifpuY8VOrKnWaTREoPKqzmE43+PbrL0jAXis=;
        b=P54WA2PGuxfHKuFWwjrCbu/PdvMVuTnU6Dy7LvFOdRSFKsLV2oQuVF4ER8MQlrTzXG
         BXeSJzDcUOkjj1ktcmYJEd+ANaql3n7CK1hTX1lLL/noTkNXvixZOjO1xhQKB4i7oNX/
         Jz0RTVlQUZ6txzCjiRFNpCIY+moznMKuzZ/jwGn076BYfEQ457YobGxXeax8y9d7Sfk/
         B2HZTKv6CE2qMyFykdxTS3+qtSqlOe24FS78clS9dvGX9mg0/TAofXrBoUqJpS+fjcQf
         znE14zc4DrIFSnqC41wvvUaa13UJl7g0WxziSCWoLP/A7YDivoTpGwdYYNcAJzpmmvMb
         Ollg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f3RC/SQifpuY8VOrKnWaTREoPKqzmE43+PbrL0jAXis=;
        b=ZHqBRZ0bHWNFFyuVW9s0s82aTQxv7NnuoOqL9v5E1yR7Nk9VWs/LjLPtEWgVk0+Kvu
         By24QtzUong3uAJLGzC/0M83dM6z5gf2gOlmRYQ3qmI8igWZJ9EtGC8AZzvPrAGMnlU2
         Q6Fyty1lMlIChVQbMDaUhlEx3NQotHjzlOdqoLphj2SurZwBedcdIL9WQuIVzWJ/iJZk
         TeosZru+v7wOVgstpIGTALXUehPWE1Wu8y7xZgeY1Hi3jhb99MZkdGmtHL9Y2iXFNXHz
         kjIY+DBojSYp3PODo1ntG9JhSFubYrSYP/NjTHnuJOhOPjc+s/jD7ORiH33llEBgqAYy
         UyAQ==
X-Gm-Message-State: APjAAAW+GwonR0oTenja1B0xrJUzpeO5TXTsbYxnXCzo9CQfVdwHAUzA
        eFUGzXc6bNUnQbePS+cPW495LPbVeBVn6M9SSGZGIFzY
X-Google-Smtp-Source: APXvYqxA/y+W7hbdbObbPKgxxIFfPSwtpl3SGq3C/Avbu4JwPSIPL0Zm0sJFTvez7VjM7JtzbYh23B12TQvZ1QBQ0ck=
X-Received: by 2002:a0d:c701:: with SMTP id j1mr1163590ywd.52.1580482585227;
 Fri, 31 Jan 2020 06:56:25 -0800 (PST)
MIME-Version: 1.0
References: <20200131122421.23286-1-sjpark@amazon.com> <20200131122421.23286-4-sjpark@amazon.com>
In-Reply-To: <20200131122421.23286-4-sjpark@amazon.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 31 Jan 2020 06:56:13 -0800
Message-ID: <CANn89iJrwVuEUHFqH1iCJd3nwTWAuXCdEJozwz6gzDV5Snm3Ug@mail.gmail.com>
Subject: Re: [PATCH 3/3] selftests: net: Add FIN_ACK processing order related
 latency spike test
To:     sjpark@amazon.com
Cc:     David Miller <davem@davemloft.net>, Shuah Khan <shuah@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sj38.park@gmail.com,
        aams@amazon.com, SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 31, 2020 at 4:25 AM <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> This commit adds a test for FIN_ACK process races related reconnection
> latency spike issues.  The issue has described and solved by the
> previous commit ("tcp: Reduce SYN resend delay if a suspicous ACK is
> received").
>

I do not know for other tests, but using a hard coded port (4242) is
going to be flakky, since the port might be already used.

Please make sure to run tests on a separate namespace.
