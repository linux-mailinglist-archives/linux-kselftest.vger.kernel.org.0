Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 129BAE3AD2
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2019 20:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504045AbfJXSTn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Oct 2019 14:19:43 -0400
Received: from ms.lwn.net ([45.79.88.28]:42668 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504042AbfJXSTn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Oct 2019 14:19:43 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B4C682F5;
        Thu, 24 Oct 2019 18:19:41 +0000 (UTC)
Date:   Thu, 24 Oct 2019 12:19:40 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Matthew Wilcox <willy@infradead.org>,
        jani.nikula@linux.intel.com,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2] kernel-doc: rename the kernel-doc directive
 'functions' to 'identifiers'
Message-ID: <20191024121940.1d6a64df@lwn.net>
In-Reply-To: <20191020131717.28990-1-changbin.du@gmail.com>
References: <20191020131717.28990-1-changbin.du@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, 20 Oct 2019 21:17:17 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> The 'functions' directive is not only for functions, but also works for
> structs/unions. So the name is misleading. This patch renames it to
> 'identifiers', which specific the functions/types to be included in
> documentation. We keep the old name as an alias of the new one before
> all documentation are updated.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

So I think this is basically OK, but I have one more request...

[...]

> diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
> index 1159405cb920..0689f9c37f1e 100644
> --- a/Documentation/sphinx/kerneldoc.py
> +++ b/Documentation/sphinx/kerneldoc.py
> @@ -59,9 +59,10 @@ class KernelDocDirective(Directive):
>      optional_arguments = 4
>      option_spec = {
>          'doc': directives.unchanged_required,
> -        'functions': directives.unchanged,
>          'export': directives.unchanged,
>          'internal': directives.unchanged,
> +        'identifiers': directives.unchanged,
> +        'functions': directives.unchanged,  # alias of 'identifiers'
>      }
>      has_content = False
>  
> @@ -71,6 +72,7 @@ class KernelDocDirective(Directive):
>  
>          filename = env.config.kerneldoc_srctree + '/' + self.arguments[0]
>          export_file_patterns = []
> +        identifiers = None
>  
>          # Tell sphinx of the dependency
>          env.note_dependency(os.path.abspath(filename))
> @@ -86,19 +88,22 @@ class KernelDocDirective(Directive):
>              export_file_patterns = str(self.options.get('internal')).split()
>          elif 'doc' in self.options:
>              cmd += ['-function', str(self.options.get('doc'))]
> +        elif 'identifiers' in self.options:
> +            identifiers = self.options.get('identifiers').split()
>          elif 'functions' in self.options:
> -            functions = self.options.get('functions').split()
> -            if functions:
> -                for f in functions:
> -                    cmd += ['-function', f]
> -            else:
> -                cmd += ['-no-doc-sections']
> +            identifiers = self.options.get('functions').split()

Rather than do this, can you just change the elif line to read:

    elif ('identifiers' in self.options) or ('functions' in self.options):

...then leave the rest of the code intact?  It keeps the logic together,
and avoids the confusing distinction between identifiers=='' and
identifiers==None .

Thanks,

jon

>          for pattern in export_file_patterns:
>              for f in glob.glob(env.config.kerneldoc_srctree + '/' + pattern):
>                  env.note_dependency(os.path.abspath(f))
>                  cmd += ['-export-file', f]
>  
> +        if identifiers:
> +            for i in identifiers:
> +                cmd += ['-function', i]
> +        elif identifiers is not None:
> +            cmd += ['-no-doc-sections']
> +
>          cmd += [filename]
>  
>          try:
