Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05D53BC373
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jul 2021 22:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhGEUoC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jul 2021 16:44:02 -0400
Received: from mx1.riseup.net ([198.252.153.129]:41036 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbhGEUoC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jul 2021 16:44:02 -0400
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4GJczS3zWxzF4R3;
        Mon,  5 Jul 2021 13:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1625517684; bh=mcP7GTpYcz8gmBbWbpvz4LK4ISwqUY32oQ05EIYlUTE=;
        h=From:To:Cc:Subject:Date:From;
        b=FcmBYEUFmYm1CfJn9KOawK/oIT++e3Gz/fJPg88bIFUD6NAB+9lE1JF7J3RAs9pt8
         nTdbHjUz9zrBkzv/O/0APCRUjXZb3ctftZGnK7KnrvVWoaJqKOfl8XntTiCTz1/06i
         nUNrgyMCKSx3P/xkZEdoH3urkifZot+iUg27ltkA=
X-Riseup-User-ID: 414D7E3800BEA5DF5307659E7A87786B63EA8D06309EF7B01B0F89D74CDBD157
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4GJczP5rZkz5vY5;
        Mon,  5 Jul 2021 13:41:21 -0700 (PDT)
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@riseup.net>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Cc:     kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, ~lkcamp/discussion@lists.sr.ht,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <n@nfraprado.net>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Leandro Ribeiro <leandrohr@riseup.net>,
        kernel-usp@googlegroups.com
Subject: KUnit Hackathon
Message-ID: <83ff3ed3-e004-29b2-b23c-a2ba4d5a3f7f@riseup.net>
Date:   Mon, 5 Jul 2021 17:41:19 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

We belong to two student groups, FLUSP [1] and LKCAMP [2], both of which
are focused on sharing kernel and free software development knowledge
and experience with fellow free software developers and newcomers.

As part of our efforts, we'll be organizing a KUnit hackathon in the
next Saturday (July 10), where we intend to help newcomers convert
existing runtime tests (the ones found at lib/) to KUnit and maybe
create new ones. Depending on the number of attendees, a high volume of
patches may be sent throughout the day. We will do our best to review
all patches before they go to the kernel mailing lists hoping to avoid
wasting your time with minor patching issues.

So we wanted to let you know of all this beforehand and give you the
time to send any suggestions or comments on all this. For instance, we
may ask people to add a special tag to their patches so you may batch
review them all at a later time if you wish.

Anyhow, we'd really appreciate having your opinion on this.
Thanks!

[1] - https://flusp.ime.usp.br/
[2] - https://lkcamp.dev/
