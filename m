Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7843F0CDB
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Aug 2021 22:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbhHRUg2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Aug 2021 16:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233909AbhHRUg1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Aug 2021 16:36:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 250AB610FE;
        Wed, 18 Aug 2021 20:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1629318952;
        bh=E2N2vkn8ZuMRsnKtrBJU26YTePJodaJsogEViSx6S9o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aK/JdHcFa4lxdYOnjBBMw+MCoMnSWQ6y9GnbUkETXTFBEDjERJK7Htrx18mE3/i6p
         kUCvZOnIc5rvYdPgZeiNg4ka57oE4uitbvig/0DepfvOKqzWGW9Zp/+T9ZwtXbOfCA
         MLQxizShN7BkvBRrtUa0+CMEZiR8gdyhDk96q72w=
Date:   Wed, 18 Aug 2021 13:35:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Jiri Kosina <jkosina@suse.cz>,
        Willy Tarreau <w@1wt.eu>
Subject: Re: [RFC PATCH 1/5] checkpatch: improve handling of revert commits
Message-Id: <20210818133551.3287f097f4c70742ab6b762f@linux-foundation.org>
In-Reply-To: <71535d629266751273c15cc05dd7c987cb9c43b6.camel@perches.com>
References: <20210818154646.925351-1-efremov@linux.com>
        <20210818154646.925351-2-efremov@linux.com>
        <cc5801790fea258e20fa6b7e26de7806ae8e0dda.camel@perches.com>
        <3d347d4b-1576-754f-8633-ba6084cc0661@linux.com>
        <71535d629266751273c15cc05dd7c987cb9c43b6.camel@perches.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 18 Aug 2021 13:21:16 -0700 Joe Perches <joe@perches.com> wrote:

> Andrew?  Do you still use perl 5.8?  It's almost 20 years old now.

5.26 is the oldest I appear to be using.
