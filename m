Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D53CA06A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2019 17:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfH1PxV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Aug 2019 11:53:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55870 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfH1PxU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Aug 2019 11:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gQZskAU+8k336EC6UmUC7ikUT5tx26F1fzK9gaSbLLs=; b=EWma0uMu9kw+jEO+hZ+1+Tyw1
        wIMr90xNPIQTuwomkBqe4oh4/4hoMaV+W7N3hLa6GYx3WRLvMJUSfwfAPR2r/K/9wROl9EpNL+/+A
        prWlsPA7sjxqjUisFU42ap0eHmRf2WPAiwJtg4KdjTasczha8bCIb/9m4ni1W5fikZVQHBef3Hs3M
        irW7e2qwgx9hhV7k0AFtRq0pGSgtn0KRwua7wPgztbYmdds+Dl0rRIn2rdfenDH9dpdXqmO55ASPs
        VGkobLGAcWFmdfgJ+8DqM8Lm7XTMq8xgqIh7WM5C+tPSr3Nnu2Apb26WpeLU8o580KQMrGhVzp+Oc
        4NS/JhWLQ==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i30Fe-0005vm-Pb; Wed, 28 Aug 2019 15:52:50 +0000
Subject: Re: [PATCH v2] kunit: fix failure to build without printk
To:     Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, frowand.list@gmail.com,
        sboyd@kernel.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
References: <20190828093143.163302-1-brendanhiggins@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4856aac6-1760-8ba5-dee0-aecfedbbe266@infradead.org>
Date:   Wed, 28 Aug 2019 08:52:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828093143.163302-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/28/19 2:31 AM, Brendan Higgins wrote:
> Previously KUnit assumed that printk would always be present, which is
> not a valid assumption to make. Fix that by removing call to
> vprintk_emit, and calling printk directly.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a97-715a-fabe016259df@kernel.org/T/#t
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  include/kunit/test.h | 11 ++++-----
>  kunit/test.c         | 57 +++++---------------------------------------
>  2 files changed, 11 insertions(+), 57 deletions(-)

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

thanks.

-- 
~Randy
