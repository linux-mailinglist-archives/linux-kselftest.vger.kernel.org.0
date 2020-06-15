Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D6D1F9324
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jun 2020 11:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgFOJTL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Jun 2020 05:19:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:41904 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbgFOJTK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Jun 2020 05:19:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 07743AECE;
        Mon, 15 Jun 2020 09:19:12 +0000 (UTC)
Date:   Mon, 15 Jun 2020 11:19:08 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests/livepatch: filter 'taints' from dmesg
 comparison
Message-ID: <20200615091908.GD31238@alley>
References: <20200610172101.21910-1-joe.lawrence@redhat.com>
 <20200610172101.21910-4-joe.lawrence@redhat.com>
 <alpine.LSU.2.21.2006110938090.32091@pobox.suse.cz>
 <047eba61-b0b9-4e91-395f-13bafbf43af6@redhat.com>
 <20200612114706.GH4311@linux-b0ei>
 <ba0202cf-beea-ddde-4941-053718c77257@linux.vnet.ibm.com>
 <b1db9ae1-781c-6ea5-c748-0928bed145f1@redhat.com>
 <alpine.LSU.2.21.2006150953520.5945@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LSU.2.21.2006150953520.5945@pobox.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon 2020-06-15 09:55:27, Miroslav Benes wrote:
> > From
> > https://www.gnu.org/software/grep/manual/grep.html#The-Backslash-Character-and-Special-Expressions
> > :
> > 
> > The ‘\’ character, when followed by certain ordinary characters, takes a
> > special meaning:
> > 
> > ...
> > 
> > ‘\<’
> > 
> >     Match the empty string at the beginning of word.
> > ‘\>’
> > 
> >     Match the empty string at the end of word.

The description is a bit confusing. I wonder how it handles dot,
comma, or colon. They are neither empty or word characters.

> > 
> > I'd be happy to use any other (more readable!) whole-word matching grep trick,
> > this \<one\> just happens to be committed to my cmdline muscle memory.
> 
> There is 'grep -w' which I use for this.

'grep -w' looks good promissing.

Best Regards,
Petr
