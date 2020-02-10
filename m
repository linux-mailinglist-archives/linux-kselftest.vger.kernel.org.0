Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17B94158199
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2020 18:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgBJRqC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Feb 2020 12:46:02 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33588 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBJRqC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Feb 2020 12:46:02 -0500
Received: by mail-pg1-f193.google.com with SMTP id 6so4296945pgk.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2020 09:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Um+KObYsAAZ4zkjy8DfPk4gMVE/AcI+tTE3voE+GiRg=;
        b=njiKhj7QaIkkNSNQhUqILnlQOcBdfJGQikxxlQ1pEE0/84uh64gTFEhicom6s7pp4/
         89OE0A3tM4hYe5VaOCgP7upVl/TzXwLk6l6qyg3N9FosQbbK9sHHXLDKeiUNJJ5S082M
         GRWq7PpY65hGzS1jzrNMHEGb+6/6tx6KkKDR2itxR7qNft3ET66zfa6X1lNkaZ5I/baG
         hmGr9Wf1wcPm1rdTIe6COWJGIlBv5edgHE2XByqeAGpajoiW/BIihixLWvWh4EY8BA2y
         kYZ5z0Z7fGWUCnMO/js/UVGcNimazt1S5INz5Eei5FLlGCq0BPFsC+cPcWOH/f8KvdGc
         NfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Um+KObYsAAZ4zkjy8DfPk4gMVE/AcI+tTE3voE+GiRg=;
        b=Bda3TAtcQ0vK1FhXb+AJtA5tLD8RxAI1S5Xn2dsz8dRAyE+qRMTGlXI2YSrDlqABbv
         i6JbsIIQqiP+40W39qNpvXlXhs/PdGAkrw9AxiCLEWcf6bxgdAp4CaGX3YF4EF9x9wSN
         mw4WC+7KS3MUNK7cHB1/m/300np3TQ6axBMdR/kh7/rEmBTisee9GtEN+ClAPQImcLj6
         AaMERbaubRT2RMQDB6i76CYFYLeqL5X3LqL+PJfGkebD2LgPzUBaPhTiGMpG/RuFe3mA
         VbMaTUJBOoFKi3fxKazhKzMxzZQi0GLwJugai+7YgZiLpoLgT4yk7rpWd7y/mouwjSaw
         R6NQ==
X-Gm-Message-State: APjAAAUbuIBChcn4EzZTcxlZ/uTBAQkqf26OFBJLsrtb1D/n4o0jg4Ba
        QQxb5hNdcYdq6CR6Vu0ccJljikDIZiFAL2ejK2cniw==
X-Google-Smtp-Source: APXvYqxiIwOpnR4LFNHTjqhqakXmaLmWK3XOeYVT3jSb6tOBB2Wclr5JOuazRiMQs0/fmgICCXuPAx3cnyQ/c648+2A=
X-Received: by 2002:a63:3754:: with SMTP id g20mr2660474pgn.384.1581356761468;
 Mon, 10 Feb 2020 09:46:01 -0800 (PST)
MIME-Version: 1.0
References: <9e787393-703b-ce56-8258-8dcf0cd5ff11@infradead.org>
In-Reply-To: <9e787393-703b-ce56-8258-8dcf0cd5ff11@infradead.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 10 Feb 2020 09:45:51 -0800
Message-ID: <CAFd5g46b7KS34c3jzJp9wxpneuEOT8BSh+jaPfnYA8DAQpH8CQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: fix Sphinx directive warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Feb 9, 2020 at 7:31 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix Documentation warning due to missing a blank line after a directive:
>
> linux/Documentation/dev-tools/kunit/usage.rst:553: WARNING: Error in "code-block" directive:
> maximum 1 argument(s) allowed, 3 supplied.
> .. code-block:: bash
>         modprobe example-test

Uh oh, sorry for wasting your time, but it looks like I already sent
the exact same patch out already:

https://patchwork.kernel.org/patch/11360711/

Shuah, can you pick one of these up and send it out in the next rc?
