Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF613F0C97
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Aug 2021 22:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhHRUV5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Aug 2021 16:21:57 -0400
Received: from smtprelay0011.hostedemail.com ([216.40.44.11]:49906 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232564AbhHRUVz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Aug 2021 16:21:55 -0400
Received: from omf11.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id C7C3D837F27B;
        Wed, 18 Aug 2021 20:21:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 755AE20A293;
        Wed, 18 Aug 2021 20:21:18 +0000 (UTC)
Message-ID: <71535d629266751273c15cc05dd7c987cb9c43b6.camel@perches.com>
Subject: Re: [RFC PATCH 1/5] checkpatch: improve handling of revert commits
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Jiri Kosina <jkosina@suse.cz>,
        Willy Tarreau <w@1wt.eu>
Date:   Wed, 18 Aug 2021 13:21:16 -0700
In-Reply-To: <3d347d4b-1576-754f-8633-ba6084cc0661@linux.com>
References: <20210818154646.925351-1-efremov@linux.com>
         <20210818154646.925351-2-efremov@linux.com>
         <cc5801790fea258e20fa6b7e26de7806ae8e0dda.camel@perches.com>
         <3d347d4b-1576-754f-8633-ba6084cc0661@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Stat-Signature: hhfmrgmbujahqjyp41s16enabxmyxkkm
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 755AE20A293
X-Spam-Status: No, score=5.20
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/Jl11ClCXS3+2aw80kHkkrPC9TM8JV7qY=
X-HE-Tag: 1629318078-364882
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2021-08-18 at 19:21 +0300, Denis Efremov wrote:
> 
> On 8/18/21 7:00 PM, Joe Perches wrote:
> > On Wed, 2021-08-18 at 18:46 +0300, Denis Efremov wrote:
> > > Properly handle commits like:
> > > commit f2791e7eadf4 ("Revert "floppy: refactor open() flags handling"")
> > 
> > Try this one:
> > 
> > https://lore.kernel.org/lkml/7f55d9d0369f1ea840fab83eeb77f9f3601fee41.camel@perches.com/
> > 
> 
> It works but why not to use .+? then?
> I'm not sure that non-greedy patterns will properly handle commits like:
> $ git log --oneline | fgrep '")'
> 
> e.g. 
> commit ece2619fe8ed ("extcon: arizona: Fix flags parameter to the gpiod_get("wlf,micd-pol") call")

The only way to handle that is to use the $balanced_parens test but
it wouldn't work on Andrew's perl version 5.8

Andrew?  Do you still use perl 5.8?  It's almost 20 years old now.
Does anyone still use perl versions 5.8 or lower?

From checkpatch:

# Using $balanced_parens, $LvalOrFunc, or $FuncArg
# requires at least perl version v5.10.0
# Any use must be runtime checked with $^V

our $balanced_parens = qr/(\((?:[^\(\)]++|(?-1))*\))/;
our $LvalOrFunc	= qr{((?:[\&\*]\s*)?$Lval)\s*($balanced_parens{0,1})\s*};
our $FuncArg = qr{$Typecast{0,1}($LvalOrFunc|$Constant|$String)};

So maybe:

> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> > > @@ -3200,20 +3200,20 @@ sub process {
> > >  			$long = 1 if ($line =~ /\bcommit\s+[0-9a-f]{41,}/i);
> > >  			$space = 0 if ($line =~ /\bcommit [0-9a-f]/i);
> > >  			$case = 0 if ($line =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
> > > -			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
> > > +			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("(.+)"\)/i) {

So that could be:
			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+($balanced_parens)/i

> > >  				$orig_desc = $1;
> > >  				$hasparens = 1;
> > >  			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
> > >  				 defined $rawlines[$linenr] &&
> > > -				 $rawlines[$linenr] =~ /^\s*\("([^"]+)"\)/) {
> > > +				 $rawlines[$linenr] =~ /^\s*\("(.+)"\)/) {

and

  			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
 				 defined $rawlines[$linenr] &&
				"$line $rawlines[$linenr]" =~ /\bcommit\s+[0-9a-f]{5,}\s+($balanced_parens)/i

> > >  				$orig_desc = $1;
> > >  				$hasparens = 1;
> > > -			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
> > > +			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\(".+$/i &&
> > >  				 defined $rawlines[$linenr] &&
> > > -				 $rawlines[$linenr] =~ /^\s*[^"]+"\)/) {
> > > -				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
> > > +				 $rawlines[$linenr] =~ /^\s*.+"\)/) {
> > > +				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("(.+)$/i;

etc...

> > >  				$orig_desc = $1;
> > > -				$rawlines[$linenr] =~ /^\s*([^"]+)"\)/;
> > > +				$rawlines[$linenr] =~ /^\s*(.+)"\)/;
> > >  				$orig_desc .= " " . $1;
> > >  				$hasparens = 1;
> > >  			}
> > 


