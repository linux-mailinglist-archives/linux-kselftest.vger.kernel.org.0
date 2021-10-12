Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7ED542A4EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Oct 2021 14:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbhJLMyO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Oct 2021 08:54:14 -0400
Received: from mx1.riseup.net ([198.252.153.129]:53064 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236480AbhJLMyN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Oct 2021 08:54:13 -0400
X-Greylist: delayed 543 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Oct 2021 08:54:12 EDT
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4HTFgs2pYHzF5dl;
        Tue, 12 Oct 2021 05:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1634042585; bh=4w6t5fBBfKE9+SDNGm5cejSYucdNYt5oljmtArLdZnE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iXI/1wYwXruF9xaJkGlL0KGZ5ns7WrBDxHKX/rl4WADVYEEX3uk8yS0LkaZBzBZkp
         LKX/fDtnitFT3BJAvQz0nJ4sjmopFuE0yAbSBLyR2G/jFVR4feMwjLn2LYEep9qidX
         1jgcvAATcD4sjg7GRIP9sjqLGnb5jWlw0CsLQPcQ=
X-Riseup-User-ID: 0BC07B29D6927D1FBB6E95CCA9804A5792989B25CA201C700A167EBA105A55C6
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4HTFgn4rf1z1yWH;
        Tue, 12 Oct 2021 05:43:01 -0700 (PDT)
Message-ID: <98332725-14eb-a268-8086-d4ffd14b7c67@riseup.net>
Date:   Tue, 12 Oct 2021 09:42:58 -0300
MIME-Version: 1.0
Subject: Re: [PATCH v6 0/1] lib: Convert UUID runtime test to KUnit
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <shuah@kernel.org>, ~lkcamp/patches@lists.sr.ht,
        nfraprado@collabora.com, leandro.ribeiro@collabora.com,
        lucmaga@gmail.com, David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>
References: <20211006001345.73898-1-andrealmeid@collabora.com>
 <20211012111806.GA2537@lst.de>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeida@riseup.net>
In-Reply-To: <20211012111806.GA2537@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Christoph,

Às 08:18 de 12/10/21, Christoph Hellwig escreveu:
> It seems I only received the 0/1 but never the actual patch?
> 

According to lore, the patch was sent in your way:
https://lore.kernel.org/lkml/20211006001345.73898-2-andrealmeid@collabora.com/

But I can do a resend anyways if you want.
