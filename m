Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E5D9F2C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2019 20:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbfH0S6H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Aug 2019 14:58:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44874 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfH0S6H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Aug 2019 14:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EQjg51adNnDA/iZNYxsUOMq78yabrwHpMoUrVJwbjDc=; b=ksl3tp70BdNMR4YfBgTqaxPHe
        O2lalZ8s6pDlRJX6Ypxs4HtxQr0cKggeN8Ja0jtFaC0EZ3BusxOHxv687EqXfwEWVWb5fRDUqz0s5
        UDg1yMMD6XET5CUoaVog/9bpMZL5IAoZXalyTCwqnkszVcR4Zx/uYIyUfb8FPqydGq4fRC0ZItBsq
        GVbV37yEeFMhtA8chk5M07HvmDm9i8BH5aAdHVhB+tiuz6Ee/wfPuygQ8oITpp21QT6psDVTAR1nu
        NuS5h10+skjt/UhNWmsR+gVDBLx6zH4uc069o3Uj0zf+Dlr54VlFlBEkkVPIVHUmn0HSEttv/IEQo
        kUGw9+r9g==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2gfN-0002sQ-N5; Tue, 27 Aug 2019 18:58:05 +0000
Subject: Re: [PATCH v1] kunit: fix failure to build without printk
To:     Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, frowand.list@gmail.com,
        sboyd@kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20190827174932.44177-1-brendanhiggins@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0ad0a0da-d8f5-4aaa-edac-28bb2463492a@infradead.org>
Date:   Tue, 27 Aug 2019 11:58:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827174932.44177-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/27/19 10:49 AM, Brendan Higgins wrote:
> Previously KUnit assumed that printk would always be present, which is
> not a valid assumption to make. Fix that by ifdefing out functions which
> directly depend on printk core functions similar to what dev_printk
> does.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a97-715a-fabe016259df@kernel.org/T/#t
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  include/kunit/test.h |  7 +++++++
>  kunit/test.c         | 41 ++++++++++++++++++++++++-----------------
>  2 files changed, 31 insertions(+), 17 deletions(-)



-- 
~Randy
