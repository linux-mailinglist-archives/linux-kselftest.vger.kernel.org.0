Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13D9C9ECA4
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2019 17:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfH0P3S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Aug 2019 11:29:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35542 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfH0P3S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Aug 2019 11:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qAXQhWkIiOIHiym/Pv00dHz+qBqrUFQGcxlQUeJH8No=; b=T36oGIpM70lcyuh0ueD9ppmQi
        cMdTaJf+VCVCSC6XIiHE5A/ShnNKbKCjDdjt9R0pkXYse3jRh8yO2NjcRUKV4TfeDOgPwHmCU2NvZ
        P6IaJBs8MSHplMhpAKSmrbLGM9iWdH7ZrFQfhWnrR/uAMyVYVMbQni9mUY+AchKnhCqXwA7qtTLv1
        2AeolXEinIE3ObHL/58kcZmJdPZJtRAcBo+WuYylZN9KMcgn2vWqt2uWdILSe4ro/iFX0bDHDjjE7
        bQ8pTozhtFssPCp8cRceQpxyGjE6MA3Y0S3em0NVscNiNl7hWp4LsPrcv0fkTecWcOOwMBPvysu2V
        2vL1TUFuA==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2dPJ-0003PV-Jn; Tue, 27 Aug 2019 15:29:17 +0000
Subject: Re: linux-next: Tree for Aug 27 (kunit)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
References: <20190827190526.6f27e763@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c7229254-0d90-d90e-f3df-5b6d6fc0b51f@infradead.org>
Date:   Tue, 27 Aug 2019 08:29:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827190526.6f27e763@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/27/19 2:05 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190826:
> 

on i386:
# CONFIG_PRINTK is not set


../kunit/test.c: In function ‘kunit_vprintk_emit’:
../kunit/test.c:21:9: error: implicit declaration of function ‘vprintk_emit’; did you mean ‘vprintk’? [-Werror=implicit-function-declaration]
  return vprintk_emit(0, level, NULL, 0, fmt, args);
         ^~~~~~~~~~~~
         vprintk


-- 
~Randy
