Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10561348506
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Mar 2021 00:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhCXXF4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Mar 2021 19:05:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234027AbhCXXFY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Mar 2021 19:05:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7369D61A10;
        Wed, 24 Mar 2021 23:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1616627123;
        bh=AEG7RhhDiP5fEemBnHg4pSVA89+Z5jifRafT/rWlPe0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MU587X1Yb8CzT0OgOco57QTCJqgtX01hd/LAxYo1HRHPWhRzmUADN2KMW+HqPejs9
         +5mCIZNQr7APldHHO4wOzFRy6IKAYF+Q6WUfDZcp95Jg0HiEw4Blf6sLRQccCd6Oyq
         LWgIbsmvkb274hjTru759T9dTDVTcCGyx7mmTi/c=
Date:   Wed, 24 Mar 2021 16:05:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Ricardo =?ISO-8859-1?Q?Ca=F1uelo?= 
        <ricardo.canuelo@collabora.com>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] tools: testing: Remove duplicate include of string.h
Message-Id: <20210324160522.7b06ee1479b15ee65b9deea6@linux-foundation.org>
In-Reply-To: <20210323033007.283521-1-wanjiabing@vivo.com>
References: <20210323033007.283521-1-wanjiabing@vivo.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 23 Mar 2021 11:29:56 +0800 Wan Jiabing <wanjiabing@vivo.com> wrote:

> string.h has been included at line 15.So we remove the 
> duplicate one at line 17.

Thanks.  But we already have
https://lkml.kernel.org/r/20210316073336.426255-1-zhang.yunkai@zte.com.cn.
