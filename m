Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAB52B79A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Nov 2020 09:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgKRIzd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Nov 2020 03:55:33 -0500
Received: from albireo.enyo.de ([37.24.231.21]:60370 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgKRIzd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Nov 2020 03:55:33 -0500
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Nov 2020 03:55:32 EST
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kfJ7f-00005b-UM; Wed, 18 Nov 2020 08:47:27 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1kfJ7f-0001Fy-Ra; Wed, 18 Nov 2020 09:47:27 +0100
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
Date:   Wed, 18 Nov 2020 09:47:27 +0100
In-Reply-To: <20201118032840.3429268-1-krisman@collabora.com> (Gabriel Krisman
        Bertazi's message of "Tue, 17 Nov 2020 22:28:33 -0500")
Message-ID: <87a6vfyrts.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

* Gabriel Krisman Bertazi:

> This is the v7 of syscall user dispatch.  This version is a bit
> different from v6 on the following points, after the modifications
> requested on that submission.

Is this supposed to work with existing (Linux) libcs, or do you bring
your own low-level run-time libraries?
