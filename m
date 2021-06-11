Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5E43A4052
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jun 2021 12:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhFKKm1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Jun 2021 06:42:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhFKKm0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Jun 2021 06:42:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF156613EE;
        Fri, 11 Jun 2021 10:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623408028;
        bh=5nr68klWqgjElrSS6HYp/LiY303ovOtI62UKpdqwVlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hLHUzW73XJzND/VjCP/o0brXh9vd8wxEB8w8g0T3oy0HitGcgZKjANbGAER60Uyxy
         TkCWkkSXnxqRdsfQ09UTe9fm1jMbxtP1G7GkOFnGUepZ99ke6IJZPyxNeSyEHCSwz0
         2KlkX1YzHAuCr3FIrGI/bwIN/LMAGEKjUDCRDlOY=
Date:   Fri, 11 Jun 2021 12:40:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/x86/syscall: use ARRAY_SIZE for msbs
Message-ID: <YMM9mu7ITxWJvA1W@kroah.com>
References: <1623406714-52873-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623406714-52873-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 11, 2021 at 06:18:34PM +0800, Jiapeng Chong wrote:
> Use ARRAY_SIZE instead of dividing sizeof array with sizeof an
> element.
> 
> Clean up the following coccicheck warning:
> 
> ./tools/testing/selftests/x86/syscall_numbering.c:316:35-36: WARNING:
> Use ARRAY_SIZE.

Same comments apply here as on your usbip tool patch :(

