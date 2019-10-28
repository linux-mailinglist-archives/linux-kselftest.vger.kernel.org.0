Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1524E6F02
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2019 10:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfJ1JYc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Oct 2019 05:24:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:42059 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728194AbfJ1JYb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Oct 2019 05:24:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 02:24:30 -0700
X-IronPort-AV: E=Sophos;i="5.68,239,1569308400"; 
   d="scan'208";a="193204146"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 02:24:25 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Changbin Du <changbin.du@gmail.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-crypto@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2] kernel-doc: rename the kernel-doc directive 'functions' to 'identifiers'
In-Reply-To: <20191025144802.uixg2crhw6h7gghq@mail.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191020131717.28990-1-changbin.du@gmail.com> <20191024121940.1d6a64df@lwn.net> <87woctb9cj.fsf@intel.com> <20191025144802.uixg2crhw6h7gghq@mail.google.com>
Date:   Mon, 28 Oct 2019 11:24:22 +0200
Message-ID: <87v9s99q9l.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 25 Oct 2019, Changbin Du <changbin.du@gmail.com> wrote:
> On Fri, Oct 25, 2019 at 09:57:48AM +0300, Jani Nikula wrote:
>> On Thu, 24 Oct 2019, Jonathan Corbet <corbet@lwn.net> wrote:
>> > On Sun, 20 Oct 2019 21:17:17 +0800
>> > Changbin Du <changbin.du@gmail.com> wrote:
>> >
>> >> The 'functions' directive is not only for functions, but also works for
>> >> structs/unions. So the name is misleading. This patch renames it to
>> >> 'identifiers', which specific the functions/types to be included in
>> >> documentation. We keep the old name as an alias of the new one before
>> >> all documentation are updated.
>> >> 
>> >> Signed-off-by: Changbin Du <changbin.du@gmail.com>
>> >
>> > So I think this is basically OK, but I have one more request...
>> >
>> > [...]
>> >
>> >> diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
>> >> index 1159405cb920..0689f9c37f1e 100644
>> >> --- a/Documentation/sphinx/kerneldoc.py
>> >> +++ b/Documentation/sphinx/kerneldoc.py
>> >> @@ -59,9 +59,10 @@ class KernelDocDirective(Directive):
>> >>      optional_arguments = 4
>> >>      option_spec = {
>> >>          'doc': directives.unchanged_required,
>> >> -        'functions': directives.unchanged,
>> >>          'export': directives.unchanged,
>> >>          'internal': directives.unchanged,
>> >> +        'identifiers': directives.unchanged,
>> >> +        'functions': directives.unchanged,  # alias of 'identifiers'
>> >>      }
>> >>      has_content = False
>> >>  
>> >> @@ -71,6 +72,7 @@ class KernelDocDirective(Directive):
>> >>  
>> >>          filename = env.config.kerneldoc_srctree + '/' + self.arguments[0]
>> >>          export_file_patterns = []
>> >> +        identifiers = None
>> >>  
>> >>          # Tell sphinx of the dependency
>> >>          env.note_dependency(os.path.abspath(filename))
>> >> @@ -86,19 +88,22 @@ class KernelDocDirective(Directive):
>> >>              export_file_patterns = str(self.options.get('internal')).split()
>> >>          elif 'doc' in self.options:
>> >>              cmd += ['-function', str(self.options.get('doc'))]
>> >> +        elif 'identifiers' in self.options:
>> >> +            identifiers = self.options.get('identifiers').split()
>> >>          elif 'functions' in self.options:
>> >> -            functions = self.options.get('functions').split()
>> >> -            if functions:
>> >> -                for f in functions:
>> >> -                    cmd += ['-function', f]
>> >> -            else:
>> >> -                cmd += ['-no-doc-sections']
>> >> +            identifiers = self.options.get('functions').split()
>> >
>> > Rather than do this, can you just change the elif line to read:
>> >
>> >     elif ('identifiers' in self.options) or ('functions' in self.options):
>> >
>> > ...then leave the rest of the code intact?  It keeps the logic together,
>> > and avoids the confusing distinction between identifiers=='' and
>> > identifiers==None .
>> 
>> I think the problem is you still need to distinguish between the two for
>> the get('functions') part.
>> 
>> One option is to rename 'functions' to 'identifiers' in the above block,
>> and put something like this above the whole if ladder (untested):
>> 
>>         # backward compat
>>         if 'functions' in self.options:
>>             if 'identifiers' in self.options:
>>                 kernellog.warn(env.app, "fail")
> This will miss the content of 'functions' directive if both exist in
> same doc.

Did you not notice your patch does the same, except silently, while this
would produce a warning? Which one is less surprising?

>
>>             else:
>>                 self.options.set('identifiers', self.options.get('functions'))
>> 
>> BR,
>> Jani.
>>
> After comparing, I still perfer my original code which is simpler. :)

But is it, really? I agree with Jon about the distinction between None
and '' being confusing.


BR,
Jani.



>
>> 
>> -- 
>> Jani Nikula, Intel Open Source Graphics Center

-- 
Jani Nikula, Intel Open Source Graphics Center
