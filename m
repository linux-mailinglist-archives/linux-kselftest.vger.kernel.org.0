Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD7F5E4F79
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2019 16:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395098AbfJYOsK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Oct 2019 10:48:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47056 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394082AbfJYOsJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Oct 2019 10:48:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id n15so2619858wrw.13;
        Fri, 25 Oct 2019 07:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bIQBfe8sGIHTcc6sIk8ML0XGqqJRWtOG/huxYjSxgWs=;
        b=ReQEnplZs6d9r7FMszuAt1KQpVhgBAK8HrNTFjUqY3S/9APV1+HGvrsZ9waq7e63YU
         qE3MBI4hqWqVJcX+VWmtAW85YKN71otDbfGbheixnIP6tSrWow7JIdFnGpXtiV+mVJW2
         1p2ctbskyMZMfpkAuSXvh/NwSIRIncEVf4MMrb16d505nLujE9HTPHxu4LuAIaDSZ+Jc
         KyD8GrKirgOQpcezDEDjZuvpDgE4yTBKNJS+69u7yUoDohsPtX/u+wyEaGIbvTZHormM
         1LsppGHi80Arm2rQS0fl8o4nF9UjLZIsJPeKNNAtOJQk0Dc1AvH/QKIDvuZYoU6aXOrF
         VoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bIQBfe8sGIHTcc6sIk8ML0XGqqJRWtOG/huxYjSxgWs=;
        b=WhjmwmWapfeXRhBFDu8d/qB3iUL7FMy4Wmydi93rBjYhG76MuJzdhD1YBvnFpqn+FT
         dnX1SPbAXdowQVjjLZ+PqE9XjWUTj7cBZ2C9J0A893jqHyFjK92Qe13U96MLx1G1pOwG
         PBQSyMyHBmFHa2yDun/xTUbO+NGzQrr3GRrjcmsuSpz2sL25yvVbnZqYtNqwM7Be2yYH
         OCDASejiZWOiX9FKPv8Tiks7hJ01jRkXje/Q8dos2EmV2bmNZQNZ5/tG40AH/3rL9J2t
         u9erg18cDwkQEn4r8M0SikS0zulAneJ7JtYvOZ9qCwlNq4lcWi2VsKBEtXRAGqNNtYAG
         +6AQ==
X-Gm-Message-State: APjAAAWZNH4H1w0uNfv5R1aM2gEXSdL2eSET9aaMn/otQwKNyejaYNI8
        8TKPgpP8f+WA/IbQ274TcbI=
X-Google-Smtp-Source: APXvYqxsX3C8tseMrdTDPvXw+m20Jy/sW7m38w3vpts8ZabQ38lGcQ4VQLB8VI+iJPUaxLQS52CZqA==
X-Received: by 2002:a5d:4847:: with SMTP id n7mr3349140wrs.398.1572014885771;
        Fri, 25 Oct 2019 07:48:05 -0700 (PDT)
Received: from mail.google.com ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id 26sm2126489wmf.20.2019.10.25.07.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Oct 2019 07:48:05 -0700 (PDT)
Date:   Fri, 25 Oct 2019 14:48:03 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Changbin Du <changbin.du@gmail.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-crypto@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2] kernel-doc: rename the kernel-doc directive
 'functions' to 'identifiers'
Message-ID: <20191025144802.uixg2crhw6h7gghq@mail.google.com>
References: <20191020131717.28990-1-changbin.du@gmail.com>
 <20191024121940.1d6a64df@lwn.net>
 <87woctb9cj.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87woctb9cj.fsf@intel.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 25, 2019 at 09:57:48AM +0300, Jani Nikula wrote:
> On Thu, 24 Oct 2019, Jonathan Corbet <corbet@lwn.net> wrote:
> > On Sun, 20 Oct 2019 21:17:17 +0800
> > Changbin Du <changbin.du@gmail.com> wrote:
> >
> >> The 'functions' directive is not only for functions, but also works for
> >> structs/unions. So the name is misleading. This patch renames it to
> >> 'identifiers', which specific the functions/types to be included in
> >> documentation. We keep the old name as an alias of the new one before
> >> all documentation are updated.
> >> 
> >> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> >
> > So I think this is basically OK, but I have one more request...
> >
> > [...]
> >
> >> diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
> >> index 1159405cb920..0689f9c37f1e 100644
> >> --- a/Documentation/sphinx/kerneldoc.py
> >> +++ b/Documentation/sphinx/kerneldoc.py
> >> @@ -59,9 +59,10 @@ class KernelDocDirective(Directive):
> >>      optional_arguments = 4
> >>      option_spec = {
> >>          'doc': directives.unchanged_required,
> >> -        'functions': directives.unchanged,
> >>          'export': directives.unchanged,
> >>          'internal': directives.unchanged,
> >> +        'identifiers': directives.unchanged,
> >> +        'functions': directives.unchanged,  # alias of 'identifiers'
> >>      }
> >>      has_content = False
> >>  
> >> @@ -71,6 +72,7 @@ class KernelDocDirective(Directive):
> >>  
> >>          filename = env.config.kerneldoc_srctree + '/' + self.arguments[0]
> >>          export_file_patterns = []
> >> +        identifiers = None
> >>  
> >>          # Tell sphinx of the dependency
> >>          env.note_dependency(os.path.abspath(filename))
> >> @@ -86,19 +88,22 @@ class KernelDocDirective(Directive):
> >>              export_file_patterns = str(self.options.get('internal')).split()
> >>          elif 'doc' in self.options:
> >>              cmd += ['-function', str(self.options.get('doc'))]
> >> +        elif 'identifiers' in self.options:
> >> +            identifiers = self.options.get('identifiers').split()
> >>          elif 'functions' in self.options:
> >> -            functions = self.options.get('functions').split()
> >> -            if functions:
> >> -                for f in functions:
> >> -                    cmd += ['-function', f]
> >> -            else:
> >> -                cmd += ['-no-doc-sections']
> >> +            identifiers = self.options.get('functions').split()
> >
> > Rather than do this, can you just change the elif line to read:
> >
> >     elif ('identifiers' in self.options) or ('functions' in self.options):
> >
> > ...then leave the rest of the code intact?  It keeps the logic together,
> > and avoids the confusing distinction between identifiers=='' and
> > identifiers==None .
> 
> I think the problem is you still need to distinguish between the two for
> the get('functions') part.
> 
> One option is to rename 'functions' to 'identifiers' in the above block,
> and put something like this above the whole if ladder (untested):
> 
>         # backward compat
>         if 'functions' in self.options:
>             if 'identifiers' in self.options:
>                 kernellog.warn(env.app, "fail")
This will miss the content of 'functions' directive if both exist in
same doc.

>             else:
>                 self.options.set('identifiers', self.options.get('functions'))
> 
> BR,
> Jani.
>
After comparing, I still perfer my original code which is simpler. :)

> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center

-- 
Cheers,
Changbin Du
