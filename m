Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857C83C9408
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jul 2021 00:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbhGNWyH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jul 2021 18:54:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230495AbhGNWyF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jul 2021 18:54:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5B73613C9;
        Wed, 14 Jul 2021 22:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1626303073;
        bh=xWDg8B305uVBjzOHgwnuqFiBf1NA/Vfbcq/Ijt0uu/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wg8Db4yOUBQ4ryGHB8E76Z1SCeA/e8Ueiydo+Ew+I7I4Q23UodHNgL/fjOp5MOL2q
         NDsigFzG6pOYw344JSnqqrTm/+lPKWr4J8zLmRKE3Ti+vwIOiIz4xroeoSgDk/nHwV
         842YkBAGsDGMEo7x8D/pcZHov65WyuAAu8Kouiks=
Date:   Wed, 14 Jul 2021 15:51:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
Cc:     shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        tyhicks@linux.microsoft.com, pasha.tatashin@soleen.com
Subject: Re: [PATCH v2 0/4] add KSM selftests
Message-Id: <20210714155112.b9688ba741a0e87245e6335c@linux-foundation.org>
In-Reply-To: <cover.1626252248.git.zhansayabagdaulet@gmail.com>
References: <cover.1626252248.git.zhansayabagdaulet@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 14 Jul 2021 14:56:01 +0600 Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com> wrote:

> Introduce selftests to validate the functionality of KSM.

ooh, nice, thanks!  Now I'm wondering why I didn't ask for this when
KSM was initially merged...

