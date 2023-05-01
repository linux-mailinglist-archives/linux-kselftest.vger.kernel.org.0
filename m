Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8516F338C
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 May 2023 18:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjEAQab (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 May 2023 12:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEAQaa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 May 2023 12:30:30 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC69118;
        Mon,  1 May 2023 09:30:28 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4edb26f762dso3322868e87.3;
        Mon, 01 May 2023 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682958626; x=1685550626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dhyY7qHBH6sqFDpLFZPOfJAsbZ/jh+LoAySlLW5v564=;
        b=Me/CK+eKkmHcSCfwKpOjXd4tUjZF5/VDgkPHJuAsRU9uwx2iltUZW9V/6Aawql5tij
         LZkSM4/o1kwDNzBu42ImCSbv1mHZ3yRkQcx1Otv//k1xPBluguCEHQBDqZADbSBlbE1N
         fTemcboLPfOvYqcPELmHxh6ykoU56XyJW3tCERgrvU/68XxI9NwlJamarm7h2864lSoN
         rYsR/BzZxO1Po1Vvyp6wGlq4pGrPBB7AOCZgqw2gwo86beakGmupQYM073muOfbooOcu
         SJGqQKmlXAq9mae/V2FQyOEBxfVyXpm3pCdoBwLOEHwam9zLaf29mo6UgmLOKRHfs5wZ
         jAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682958626; x=1685550626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhyY7qHBH6sqFDpLFZPOfJAsbZ/jh+LoAySlLW5v564=;
        b=hyhDUhYgoR+DeGsL/a2H3U4RtCVc91/cf5hZNmbzsrm+bUtw3EMOupkWPWL9WaEK9O
         9tp3pR/gDcY1sw9FtGkqvkMzHWbAKbJpnmetLkwa1/o/o0b/pRP0bmxNwjJN8hKCFSxy
         Fr345iONUWJsu3v50JQZ1v4fD4xtOi9ynArIgANRXVGLs8nYZIpCjRX7SkegnJJknDfc
         a4qRydJOlX4GfmXrCa5Lt8SeCRcf0LWa/TRBm8URoTKhXnm1I+PXHlZ8hgM5Axw9lMlW
         /ViJGjWvpsg3TpW6LnhT95uIA7Dmx7hV8AhPh9j4GWAnguaBrNRhgPF/5a3urMlPpfUj
         oL3w==
X-Gm-Message-State: AC+VfDz5ohYptDSJC/m2oOBsOX/LXiZVbznVy9U2ydLstB3K2+gq4PRj
        mlxRql3VwlLZeQHXZf1YNSs=
X-Google-Smtp-Source: ACHHUZ4/2ceDc4pC1aiCJnTvLMRBf39++inShkCIxU+nSVgxHEh5RUZLR3y7ywLuIZVVxCn7yCoR5w==
X-Received: by 2002:a05:6512:24a:b0:4db:3e56:55c8 with SMTP id b10-20020a056512024a00b004db3e5655c8mr4000247lfo.59.1682958626370;
        Mon, 01 May 2023 09:30:26 -0700 (PDT)
Received: from eg ([2a01:799:1727:1d00:bf75:af6:260e:41be])
        by smtp.gmail.com with ESMTPSA id m19-20020ac24293000000b004edc585d6besm4799556lfh.285.2023.05.01.09.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 09:30:25 -0700 (PDT)
Date:   Mon, 1 May 2023 18:30:24 +0200
From:   Espen Grindhaug <espen.grindhaug@gmail.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] libbpf: Improve version handling when attaching uprobe
Message-ID: <ZE/pIM/z7x+35KQo@eg>
References: <ZEV/EzOM+TJomP66@eg>
 <07e05c57-feb7-5482-9c07-eb41f976f9fd@meta.com>
 <ZErK0M/qAi/VS8U8@eg>
 <0e7b884a-05c3-83c7-0de1-9bfe14ff77b3@meta.com>
 <ZE+4Ct7ZMecFy7YV@eg>
 <533437a4-a76d-96e0-b04a-ab8eb7b5fb7f@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <533437a4-a76d-96e0-b04a-ab8eb7b5fb7f@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 01, 2023 at 08:23:35AM -0700, Yonghong Song wrote:
>
>
> On 5/1/23 6:00 AM, Espen Grindhaug wrote:
> > On Thu, Apr 27, 2023 at 06:19:29PM -0700, Yonghong Song wrote:
> > >
> > >
> > > On 4/27/23 12:19 PM, Espen Grindhaug wrote:
> > > > On Wed, Apr 26, 2023 at 02:47:27PM -0700, Yonghong Song wrote:
> > > > >
> > > > >
> > > > > On 4/23/23 11:55 AM, Espen Grindhaug wrote:
> > > > > > This change fixes the handling of versions in elf_find_func_offset.
> > > > > > In the previous implementation, we incorrectly assumed that the
> > > > >
> > > > > Could you give more explanation/example in the commit message
> > > > > what does 'incorrectly' mean here? In which situations the
> > > > > current libbpf implementation will not be correct?
> > > > >
> > > >
> > > > How about something like this?
> > > >
> > > >
> > > > libbpf: Improve version handling when attaching uprobe
> > > >
> > > > This change fixes the handling of versions in elf_find_func_offset.
> > > >
> > > > For example, let's assume we are trying to attach an uprobe to pthread_create in
> > > > glibc. Prior to this commit, it would fail with an error message saying 'elf:
> > > > ambiguous match [...]', this is because there are two entries in the symbol
> > > > table with that name.
> > > >
> > > > $ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep pthread_create
> > > > 0000000000094cc0 T pthread_create@GLIBC_2.2.5
> > > > 0000000000094cc0 T pthread_create@@GLIBC_2.34
> > > >
> > > > So we go ahead and modify our code to attach to 'pthread_create@@GLIBC_2.34',
> > > > and this also fails, but this time with the error 'elf: failed to find symbol
> > > > [...]'. This fails because we incorrectly assumed that the version information
> > > > would be present in the string found in the string table, but there is only the
> > > > string 'pthread_create'.
> > >
> > > I tried one example with my centos8 libpthread library.
> > >
> > > $ llvm-readelf -s /lib64/libc-2.28.so | grep pthread_cond_signal
> > >      39: 0000000000095f70    43 FUNC    GLOBAL DEFAULT    14
> > > pthread_cond_signal@@GLIBC_2.3.2
> > >      40: 0000000000096250    43 FUNC    GLOBAL DEFAULT    14
> > > pthread_cond_signal@GLIBC_2.2.5
> > >    3160: 0000000000096250    43 FUNC    LOCAL  DEFAULT    14
> > > __pthread_cond_signal_2_0
> > >    3589: 0000000000095f70    43 FUNC    LOCAL  DEFAULT    14
> > > __pthread_cond_signal
> > >    5522: 0000000000095f70    43 FUNC    GLOBAL DEFAULT    14
> > > pthread_cond_signal@@GLIBC_2.3.2
> > >    5545: 0000000000096250    43 FUNC    GLOBAL DEFAULT    14
> > > pthread_cond_signal@GLIBC_2.2.5
> > > $ nm -D /lib64/libc-2.28.so | grep pthread_cond_signal
> > > 0000000000095f70 T pthread_cond_signal@@GLIBC_2.3.2
> > > 0000000000096250 T pthread_cond_signal@GLIBC_2.2.5
> > > $
> > >
> > > Note that two pthread_cond_signal functions have different addresses,
> > > which is expected as they implemented for different versions.
> > >
> > > But in your case,
> > > > $ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep pthread_create
> > > > 0000000000094cc0 T pthread_create@GLIBC_2.2.5
> > > > 0000000000094cc0 T pthread_create@@GLIBC_2.34
> > >
> > > Two functions have the same address which is very weird and I suspect
> > > some issues here at least needs some investigation.
> > >
> >
> > I am no expert on this, but as far as I can tell, this is normal,
> > although much more common on my Ubuntu machine than my Fedora machine.
> >
> > Script to find duplicates:
> >
> > nm -D /usr/lib64/libc-2.33.so | awk '
> > {
> >      addr = $1;
> >      symbol = $3;
> >      sub(/[@].*$/, "", symbol);
> >
> >      if (addr == prev_addr && symbol == prev_symbol) {
> >          if (prev_symbol_printed == 0) {
> >              print prev_line;
> >              prev_symbol_printed = 1;
> >          }
> >          print;
> >      } else {
> >          prev_symbol_printed = 0;
> >      }
> >      prev_addr = addr;
> >      prev_symbol = symbol;
> >      prev_line = $0;
> > }'
> >
> >
> > > Second, for the symbol table, the following is ELF encoding,
> > >
> > > typedef struct {
> > >          Elf64_Word      st_name;
> > >          unsigned char   st_info;
> > >          unsigned char   st_other;
> > >          Elf64_Half      st_shndx;
> > >          Elf64_Addr      st_value;
> > >          Elf64_Xword     st_size;
> > > } Elf64_Sym;
> > >
> > > where
> > > st_name
> > >
> > >      An index into the object file's symbol string table, which holds the
> > > character representations of the symbol names. If the value is nonzero, the
> > > value represents a string table index that gives the symbol name. Otherwise,
> > > the symbol table entry has no name.
> > >
> > > So, the function name (including @..., @@...) should be in string table
> > > which is the same for the above two pthread_cond_signal symbols.
> > >
> > > I think it is worthwhile to debug why in your situation
> > > pthread_create@GLIBC_2.2.5 and pthread_create@@GLIBC_2.34 do not
> > > have them in the string table.
> > >
> >
> > I think you are mistaken here; the strings in the strings table don't contain
> > the version. Take a look at this partial dump of the strings table.
> >
> > 	$ readelf -W -p .dynstr /usr/lib64/libc-2.33.so
> >
> > 	String dump of section '.dynstr':
> > 		[     1]  xdrmem_create
> > 		[     f]  __wctomb_chk
> > 		[    1c]  getmntent
> > 		[    26]  __freelocale
> > 		[    33]  __rawmemchr
> > 		[    3f]  _IO_vsprintf
> > 		[    4c]  getutent
> > 		[    55]  __file_change_detection_for_path
> > 	(...)
> > 		[  350e]  memrchr
> > 		[  3516]  pthread_cond_signal
> > 		[  352a]  __close
> > 	(...)
> > 		[  61b6]  GLIBC_2.2.5
> > 		[  61c2]  GLIBC_2.2.6
> > 		[  61ce]  GLIBC_2.3
> > 		[  61d8]  GLIBC_2.3.2
> > 		[  61e4]  GLIBC_2.3.3
> >
> > As you can see, the strings have no versions, and the version strings
> > themselves are also in this table as entries at the end of the table.
>
> I see you search .dynstr section. Do you think whether we should
> search .strtab instead since it contains versioned symbols?
>

I searched .dynstr since my libc files only have that section, but I do see
your point. If const char *binary_path points to an executable and not an
.so file, then we would find some versioned symbols in the .strtab section.
However, since libbpf supports using the .so as binary_path, would we not
need the functionality to build the complete name regardless?

Adding a check to not build the full name if it already contains an '@' is
probably a good idea, though.

> >
> > > >
> > > > This patch reworks how we compare the symbol name provided by the user if it is
> > > > qualified with a version (using @ or @@). We now look up the correct version
> > > > string in the version symbol table before constructing the full name, as also
> > > > done above by nm, before comparing.
> > > >
> > > > > > version information would be present in the string found in the
> > > > > > string table.
> > > > > >
> > > > > > We now look up the correct version string in the version symbol
> > > > > > table before constructing the full name and then comparing.
> > > > > >
> > > > > > This patch adds support for both name@version and name@@version to
> > > > > > match output of the various elf parsers.
> > > > > >
> > > > > > Signed-off-by: Espen Grindhaug <espen.grindhaug@gmail.com>
> > > > >
> > > > > [...]
