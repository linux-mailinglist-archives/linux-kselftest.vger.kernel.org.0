Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2741139D03
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2020 23:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgAMW76 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jan 2020 17:59:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54642 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgAMW75 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jan 2020 17:59:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Kl3mdOW+pV2EuXxURXn+DjKaj36+OFkFkk0SeKe0dM4=; b=s7H8oVHottBxnfbBuG5OfoJDW
        pX/4ljDMNctXAZERjuNa8riN5rjrt4zS64xrbg3EiQinHHzDrLNsdWahsLYHpgR0yC5LhiM2dj6n1
        fSkTYWl8uoIQv4VEc19Nyvx2DJkjxaLnmFm3cA0ptUinfKncxpHYz9LW/9linETrDDQwKKmwVxZgt
        f/KiVWwzAEHBbwdMxUCRITQu1PFP1c7o+SjZ54uyXABhx9jOlnDh29tCRkbVjbtiDtmMQV00GfVtT
        vcqH4T1lgSTEzs0chuyaUk/VgB/rtD2z9otLSz9VPkkvxaDKPfAJaAu0C5uq4M/vIW44Vt8zzPtQ5
        dFV/SiRjQ==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ir8ge-0002DL-Du; Mon, 13 Jan 2020 22:59:56 +0000
Subject: Re: linux-next: Tree for Jan 13
 (drivers/base/test/property-entry-test.o)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200113181457.209ab4a5@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <eddaa93c-3bde-a9ed-5ee7-766f3cd51a43@infradead.org>
Date:   Mon, 13 Jan 2020 14:59:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200113181457.209ab4a5@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/12/20 11:14 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20200110:
> 
> The kunit-next tree lost its failures.
> 

on i386:

WARNING: modpost: missing MODULE_LICENSE() in drivers/base/test/property-entry-test.o
see include/linux/module.h for more information

-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
