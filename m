Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C72E5E7D86
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2019 01:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfJ2Abj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Oct 2019 20:31:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50299 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfJ2Abj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Oct 2019 20:31:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id 11so797533wmk.0;
        Mon, 28 Oct 2019 17:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+D8dAg6wyuTSrA9lr5DiGJ+HgUlg76x4EWdaVB31KHg=;
        b=WnOJ3SqYw4EzB4LsY+VdHC/M5C2fdfATlBfV/U9GORaFAbMt0xRnkkYxgM55NA5EWM
         BFZjAoG6fIhPatBfQPD24sg3OspaMNPT4jec8U4Ndsz1KNPeF4vCoGgg1wY1RgBQPDMk
         n7CT/80tjNOvVtNSFzAQ2Atxa01teqDqh4f00F5vCjQZHeXTK4r6zL5b/geM8uassQFW
         heyCsLayoyBCEi5ZZbLqD7+0IBoV+wg1k7FBe/fuqBADy3vQ4li1Mb872dVSJmDPYlI0
         PMfgRv2RJG6/aoWc7FTKZ4q1ENUNLSc2qGNBYvODVNXrh0zxtgF+09suG812OJH0H0uW
         i5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+D8dAg6wyuTSrA9lr5DiGJ+HgUlg76x4EWdaVB31KHg=;
        b=euAF0TdbC5TjtRW2nV/JVcm/XS86HRLqQIijwEFprk4C1eI4rc2CpCXF+P+OBrefXw
         MmDV7G/BIr3SClXDhCgkdSrDklkM6X9DLHbnyUlJXN4tNAxQ3OazwsVsOeZ8fsTxhCJa
         qUepCwWy+H5JJK50mcNUyXxISadHaR1zKIBhcsxBouyuVlqLVpas//b8GgoHQkYr8uFd
         jE4exgYKxMLMdqUwSNU940WC7RHN+xsqFLNd8PB/NHFCyEo5s87s7lafu/A9ZjFaZInd
         hK5jcMiavlW6f1nmLRZIc9pysHZc//IpAG7N8u0RlL141SrA6uakA+lxVi3sru+jNJ59
         5jlg==
X-Gm-Message-State: APjAAAW3mSRpWAkBHgSA82sOHa5AQJR9IRXajbsSjdlA4nYLuYMWLU1K
        88rCUTzqP9Cl+KKeiIUDhME=
X-Google-Smtp-Source: APXvYqyynmRqmdd3kL5UW/yq8tfwkLVzOUvEW0e21C3/Pe9ufZJ43RT/NMWvApoj/D5Cryll4ll8xQ==
X-Received: by 2002:a1c:998f:: with SMTP id b137mr1687363wme.104.1572309095171;
        Mon, 28 Oct 2019 17:31:35 -0700 (PDT)
Received: from mail.google.com ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id s21sm17840387wrb.31.2019.10.28.17.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 17:31:34 -0700 (PDT)
Date:   Tue, 29 Oct 2019 08:31:22 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-crypto@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2] kernel-doc: rename the kernel-doc directive
 'functions' to 'identifiers'
Message-ID: <20191029003120.llve32crfw63ovpw@mail.google.com>
References: <20191020131717.28990-1-changbin.du@gmail.com>
 <20191024121940.1d6a64df@lwn.net>
 <87woctb9cj.fsf@intel.com>
 <20191025144802.uixg2crhw6h7gghq@mail.google.com>
 <87v9s99q9l.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9s99q9l.fsf@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 28, 2019 at 11:24:22AM +0200, Jani Nikula wrote:
> On Fri, 25 Oct 2019, Changbin Du <changbin.du@gmail.com> wrote:
> > On Fri, Oct 25, 2019 at 09:57:48AM +0300, Jani Nikula wrote:
> >> On Thu, 24 Oct 2019, Jonathan Corbet <corbet@lwn.net> wrote:
> >> > On Sun, 20 Oct 2019 21:17:17 +0800
> >> > Changbin Du <changbin.du@gmail.com> wrote:
> >> >
> >> >> The 'functions' directive is not only for functions, but also works for
> >> >> structs/unions. So the name is misleading. This patch renames it to
> >> >> 'identifiers', which specific the functions/types to be included in
> >> >> documentation. We keep the old name as an alias of the new one before
> >> >> all documentation are updated.
> >> >> 
> >> >> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> >> >
> >> > So I think this is basically OK, but I have one more request...
> >> >
> >> > [...]
> >> >
> >> >> diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
> >> >> index 1159405cb920..0689f9c37f1e 100644
> >> >> --- a/Documentation/sphinx/kerneldoc.py
> >> >> +++ b/Documentation/sphinx/kerneldoc.py
> >> >> @@ -59,9 +59,10 @@ class KernelDocDirective(Directive):
> >> >>      optional_arguments = 4
> >> >>      option_spec = {
> >> >>          'doc': directives.unchanged_required,
> >> >> -        'functions': directives.unchanged,
> >> >>          'export': directives.unchanged,
> >> >>          'internal': directives.unchanged,
> >> >> +        'identifiers': directives.unchanged,
> >> >> +        'functions': directives.unchanged,  # alias of 'identifiers'
> >> >>      }
> >> >>      has_content = False
> >> >>  
> >> >> @@ -71,6 +72,7 @@ class KernelDocDirective(Directive):
> >> >>  
> >> >>          filename = env.config.kerneldoc_srctree + '/' + self.arguments[0]
> >> >>          export_file_patterns = []
> >> >> +        identifiers = None
> >> >>  
> >> >>          # Tell sphinx of the dependency
> >> >>          env.note_dependency(os.path.abspath(filename))
> >> >> @@ -86,19 +88,22 @@ class KernelDocDirective(Directive):
> >> >>              export_file_patterns = str(self.options.get('internal')).split()
> >> >>          elif 'doc' in self.options:
> >> >>              cmd += ['-function', str(self.options.get('doc'))]
> >> >> +        elif 'identifiers' in self.options:
> >> >> +            identifiers = self.options.get('identifiers').split()
> >> >>          elif 'functions' in self.options:
> >> >> -            functions = self.options.get('functions').split()
> >> >> -            if functions:
> >> >> -                for f in functions:
> >> >> -                    cmd += ['-function', f]
> >> >> -            else:
> >> >> -                cmd += ['-no-doc-sections']
> >> >> +            identifiers = self.options.get('functions').split()
> >> >
> >> > Rather than do this, can you just change the elif line to read:
> >> >
> >> >     elif ('identifiers' in self.options) or ('functions' in self.options):
> >> >
> >> > ...then leave the rest of the code intact?  It keeps the logic together,
> >> > and avoids the confusing distinction between identifiers=='' and
> >> > identifiers==None .
> >> 
> >> I think the problem is you still need to distinguish between the two for
> >> the get('functions') part.
> >> 
> >> One option is to rename 'functions' to 'identifiers' in the above block,
> >> and put something like this above the whole if ladder (untested):
> >> 
> >>         # backward compat
> >>         if 'functions' in self.options:
> >>             if 'identifiers' in self.options:
> >>                 kernellog.warn(env.app, "fail")
> > This will miss the content of 'functions' directive if both exist in
> > same doc.
> 
> Did you not notice your patch does the same, except silently, while this
> would produce a warning? Which one is less surprising?
>
yes, my mistake. Mine does the same thing.

> >
> >>             else:
> >>                 self.options.set('identifiers', self.options.get('functions'))
> >> 
> >> BR,
> >> Jani.
> >>
> > After comparing, I still perfer my original code which is simpler. :)
> 
> But is it, really? I agree with Jon about the distinction between None
> and '' being confusing.
>
Here python is different from C. Both empty string and None are False in python.
Note such condition is common in python.

Again, I am ok with both.

> 
> BR,
> Jani.
> 
> 
> 
> >
> >> 
> >> -- 
> >> Jani Nikula, Intel Open Source Graphics Center
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center

-- 
Cheers,
Changbin Du
