Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7989739C9BA
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jun 2021 18:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhFEQIe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Jun 2021 12:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhFEQIe (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Jun 2021 12:08:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B71C6140B;
        Sat,  5 Jun 2021 16:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622909206;
        bh=16nOXmG0A75mh++Cnr2mQNH2BWxmrGJci/q8393J0ng=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LK6agVgfW6Qhhaok3/QYxQeDm6R58cHTjR2b+2WupbyIjNLutdiAi/+ao9tK9oRyS
         Id6Bp0AiN6GzUYIW3iyYNDY4hnR5Sl1MOyvdQkCz2Jc9yGEDlr3/D1Q/HXxPnYo++G
         qnxvY7WQ1gID49kKY5u/EYA5Rthl83Obs8Et4FLfz0oNAIQ6d8cTUGiUlH1P1BVLRm
         z2wUB5Fb98LPnHFF2kLbXIQXXuz7rdS6van5rA2HxOrgwIApN/XYL3+u3zmIhNhVIo
         Mytj/aJysUEd7AmjEKzIor8G9Z1mGaPLF+I0+Uev8/XysnOo4ARWjANsfwpGq3fKbt
         kf6FBlVqFwNWQ==
Date:   Sat, 5 Jun 2021 18:06:41 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 02/34] docs: dev-tools: kunit: don't use a table for
 docs name
Message-ID: <20210605180641.67ed6831@coco.lan>
In-Reply-To: <CABVgOSmheB_f5gNc_zyuDHrwdRs_x_osutorJbLUMGpRRU4nzA@mail.gmail.com>
References: <cover.1622898327.git.mchehab+huawei@kernel.org>
        <08ac283ac5bdc2664255a7ad34514e50d3ed85d8.1622898327.git.mchehab+huawei@kernel.org>
        <CABVgOSmheB_f5gNc_zyuDHrwdRs_x_osutorJbLUMGpRRU4nzA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Em Sat, 5 Jun 2021 23:43:22 +0800
David Gow <davidgow@google.com> escreveu:

> On Sat, Jun 5, 2021 at 9:18 PM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > We'll be replacing :doc:`foo` references to
> > Documentation/foo.rst. Yet, here it happens inside a table.
> > Doing a search-and-replace would break it.
> >
> > Yet, as there's no good reason to use a table there,
> > let's just convert it into a list.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---  
> 
> While I personally quite like the look of the table when rendered by
> Sphinx, I think the list is much more readable as plain-text, so this
> is okay by me.
> 
> That being said, a definition list[1] seems like it should be better
> still, though I can't get it to work with the kernel's Sphinx
> configuration, so let's stick with this for now. (Given we've only got
> one page of documentation here, the whole thing doesn't matter much
> anyway.)

This works:

	foo
		bar

But automarkup.py currently ignores definition list syntaxes like:

	Documentation/dev-tools/kunit/api/test.rst
	  documents all of the standard testing API excluding mocking
	  or mocking related features.

Not sure why, as the regex it uses should have caught it:

    RE_doc = re.compile(r'(\bDocumentation/)?((\.\./)*[\w\-/]+)\.(rst|txt)')

Which is parsed from this loop:

    #
    # This loop could eventually be improved on.  Someday maybe we
    # want a proper tree traversal with a lot of awareness of which
    # kinds of nodes to prune.  But this works well for now.
    #
    # The nodes.literal test catches ``literal text``, its purpose is to
    # avoid adding cross-references to functions that have been explicitly
    # marked with cc:func:.
    #
    for para in doctree.traverse(nodes.paragraph):
        for node in para.traverse(nodes.Text):
            if not isinstance(node.parent, nodes.literal):
                node.parent.replace(node, markup_refs(name, app, node))

Maybe definition list is outside "nodes.Text", but I'm not a Python
expert, nor I know how Sphinx/docutils internally represents a definition 
list. 

So, the next best thing seems to be as proposed on this patch:

	Documentation/dev-tools/kunit/api/test.rst

	- documents all of the standard testing API excluding mocking
	  or mocking related features.

> Reviewed-by: David Gow <davidgow@google.com>

Thanks!
Mauro

> 
> Cheers,
> -- David
> 
> [1] https://rest-sphinx-memo.readthedocs.io/en/latest/ReST.html#definition-list
> 
> 
> >  Documentation/dev-tools/kunit/api/index.rst | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
> > index 9b9bffe5d41a..b33ad72bcf0b 100644
> > --- a/Documentation/dev-tools/kunit/api/index.rst
> > +++ b/Documentation/dev-tools/kunit/api/index.rst
> > @@ -10,7 +10,7 @@ API Reference
> >  This section documents the KUnit kernel testing API. It is divided into the
> >  following sections:
> >
> > -================================= ==============================================
> > -:doc:`test`                       documents all of the standard testing API
> > -                                  excluding mocking or mocking related features.
> > -================================= ==============================================
> > +Documentation/dev-tools/kunit/api/test.rst
> > +
> > + - documents all of the standard testing API excluding mocking
> > +   or mocking related features.
> > --
> > 2.31.1
> >
> > --
> > You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/08ac283ac5bdc2664255a7ad34514e50d3ed85d8.1622898327.git.mchehab%2Bhuawei%40kernel.org.  



Thanks,
Mauro
