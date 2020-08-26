Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE796253480
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Aug 2020 18:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgHZQOE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Aug 2020 12:14:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:50782 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727814AbgHZQNd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Aug 2020 12:13:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0CD5FB6FA;
        Wed, 26 Aug 2020 16:14:03 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.com>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 29/29] tools: Avoid comma separated statements
Date:   Wed, 26 Aug 2020 18:13:30 +0200
Message-ID: <1696974.unB1bf7olB@c100>
In-Reply-To: <7b78e43a01865ec0c296ad9acad0616a6c2c3b86.camel@perches.com>
References: <cover.1598331148.git.joe@perches.com> <6011591.XMClsHuqKX@c100> <7b78e43a01865ec0c296ad9acad0616a6c2c3b86.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Am Mittwoch, 26. August 2020, 16:45:24 CEST schrieb Joe Perches:
> On Wed, 2020-08-26 at 11:30 +0200, Thomas Renninger wrote:
> > Hi,
> > 

> Read the block immediately below that too:
> 
> "This does not apply if only one branch of a conditional statement is a
> single statement; in the latter case use braces in both branches:"

Then +1 from here.

> > Afaik there isn't a specific tag, but having:
> > cleanup only: No functional change
> > 
> > in the changelog would be nice for people looking for fixes to backport.
> 
> This is not a fix, so it's not for backporting.

Mentioning that in the changelog explicitly or even in the title - cleanup 
only
is nice imho, but should definitely not be the reason for re-posting.

Thanks for doing this,

   Thomas


