Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444D22B831C
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Nov 2020 18:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgKRRWM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Nov 2020 12:22:12 -0500
Received: from albireo.enyo.de ([37.24.231.21]:41980 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbgKRRWM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Nov 2020 12:22:12 -0500
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kfR9d-0002tV-P6; Wed, 18 Nov 2020 17:22:01 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1kfR9d-0004L9-MI; Wed, 18 Nov 2020 18:22:01 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        willy@infradead.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org, gofmanp@gmail.com,
        kernel@collabora.com
Subject: Re: [PATCH v7 0/7] Syscall User Dispatch
References: <20201118032840.3429268-1-krisman@collabora.com>
        <87a6vfyrts.fsf@mid.deneb.enyo.de> <87blfuvbtb.fsf@collabora.com>
Date:   Wed, 18 Nov 2020 18:22:01 +0100
In-Reply-To: <87blfuvbtb.fsf@collabora.com> (Gabriel Krisman Bertazi's message
        of "Wed, 18 Nov 2020 12:01:36 -0500")
Message-ID: <87blfuvava.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

* Gabriel Krisman Bertazi:

> The main use case is to intercept Windows system calls of an application
> running over Wine. While Wine is using an unmodified glibc to execute
> its own native Linux syscalls, the Windows libraries might be directly
> issuing syscalls that we need to capture. So there is a mix. While this
> mechanism is compatible with existing libc, we might have other
> libraries executing a syscall instruction directly.

Please raise this on libc-alpha, it's an unexpected compatibility
constraint on glibc.  Thanks.
