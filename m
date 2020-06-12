Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5FA1F776D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jun 2020 13:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgFLLrK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Jun 2020 07:47:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:51900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbgFLLrJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Jun 2020 07:47:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 674D4AE18;
        Fri, 12 Jun 2020 11:47:11 +0000 (UTC)
Date:   Fri, 12 Jun 2020 13:47:06 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Miroslav Benes <mbenes@suse.cz>, live-patching@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests/livepatch: filter 'taints' from dmesg
 comparison
Message-ID: <20200612114706.GH4311@linux-b0ei>
References: <20200610172101.21910-1-joe.lawrence@redhat.com>
 <20200610172101.21910-4-joe.lawrence@redhat.com>
 <alpine.LSU.2.21.2006110938090.32091@pobox.suse.cz>
 <047eba61-b0b9-4e91-395f-13bafbf43af6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <047eba61-b0b9-4e91-395f-13bafbf43af6@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu 2020-06-11 09:10:38, Joe Lawrence wrote:
> On 6/11/20 3:39 AM, Miroslav Benes wrote:
> > On Wed, 10 Jun 2020, Joe Lawrence wrote:
> > 
> > > The livepatch selftests currently filter out "tainting kernel with
> > > TAINT_LIVEPATCH" messages which may be logged when loading livepatch
> > > modules.
> > > 
> > > Further filter the log to drop "loading out-of-tree module taints
> > > kernel" in the rare case the klp_test modules have been built
> > > out-of-tree.
> > > 
> > > Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> > > ---
> > >   tools/testing/selftests/livepatch/functions.sh | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> > > index 83560c3df2ee..f5d4ef12f1cb 100644
> > > --- a/tools/testing/selftests/livepatch/functions.sh
> > > +++ b/tools/testing/selftests/livepatch/functions.sh
> > > @@ -260,7 +260,8 @@ function check_result {
> > >   	local result
> > >   	result=$(dmesg --notime | diff --changed-group-format='%>' --unchanged-group-format='' "$SAVED_DMESG" - | \
> > > -		 grep -v 'tainting' | grep -e '^livepatch:' -e 'test_klp')
> > > +		 grep -e '^livepatch:' -e 'test_klp' | \
> > > +		 grep -ve '\<taints\>' -ve '\<tainting\>')
> > 
> > or make it just 'grep -v 'taint' ? It does not matter much though.
> > 
> 
> I don't know of any larger words* that may hit a partial match on "taint",
> but I figured the two word bounded regexes would be more specific.

I do not have strong opinion. I am fine with both current and Mirek's proposal.

I am just curious where \< and \> regexp substitutions are documented.
I see the following at the very end of "man re_syntax":

   \< and \> are synonyms for  “[[:<:]]” and “[[:>:]]” respectively

But I am not able to find documentation for “[[:<:]]” and “[[:>:]].
Even google looks helpless ;-)

Best Regards,
Petr
