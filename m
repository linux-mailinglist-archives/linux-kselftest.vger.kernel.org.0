Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0A76F315B
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 May 2023 15:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjEANBH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 May 2023 09:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjEANBF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 May 2023 09:01:05 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD3DFD;
        Mon,  1 May 2023 06:01:03 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4edcdfa8638so3061125e87.2;
        Mon, 01 May 2023 06:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682946061; x=1685538061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kHw8Wqykebv4v2wIJmrv/QbMhmd2RawI/W+0ecfUZyA=;
        b=ZDR5KhHKcNql2+upLP8v811c7IXfgDiaXT+/CJHGwmKIbEp7FVq5ewfrfoM3eJiDBf
         EG2iLc0ipVTLFwdoau2fjsfJPhZF4gSXu26VycvAalTZFG5/E61ZVNlvzJFsEP0KPl+j
         5LrWZLfdjVaSD/GF9HAxrBDd2qv9oBUdyGyN+yZbMJS+eKNMBiVzYqkN8cD0VqPB6If6
         qcmNPG9rVOoU7R7WxDCbDW9htTE5awJp8CH5GCfObQkf8b7gmt0iKsfDaUN/A6y1axAX
         Vojs+/p2kEB0Nllr5vahn8MvI0qaypzGMMmGcqfUFAQSBRXRC8eFMlS+2UKsoujDrIZp
         Vbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682946061; x=1685538061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHw8Wqykebv4v2wIJmrv/QbMhmd2RawI/W+0ecfUZyA=;
        b=U3Azcqyr9UV2NgUtVHOb2SA71s+R7A1FdXEbQ5KSQJ1IC/PdbGpVDLTQ1eME4ajpSV
         EVTtkbRSlkCoZA47zL8oc9PYh05d87YNGretHvUZx9CD2v4wBVmJXJvgRSEdEfqLP42b
         djImgZSsQAH4x8dcj0J3VuTMdaDHa0MAuO8julN2vvM0ngTB0qLJRGusLYl4u3+rc+Fy
         VBFiwuxoSLzRt5GyobkR7AMTJ0oXw41hlSwIJ7eaRI3QY9WKyyRjfRGqPshiwcH/GINj
         4Di/b/AqUNYz//kRs3N9kV9SO48RIkhiZJ069ZiSGikTGBkyNgkCInEKAEdCnV8r5c+L
         L9ig==
X-Gm-Message-State: AC+VfDwHd25CO2pXxYhRYHElsScwmmTUJpuP1+weZxQfU0U2V+m10J3z
        VNOvwKsjblDaeemzLpBKvrc=
X-Google-Smtp-Source: ACHHUZ58BxYKLqZvjNkIO0jwcFJOaOslwzj1axDy37xkUsYuE9Pa4ODVzU+v/w3vB9YvEotscbxvnA==
X-Received: by 2002:ac2:51b7:0:b0:4f1:1d32:6d67 with SMTP id f23-20020ac251b7000000b004f11d326d67mr969608lfk.39.1682946061177;
        Mon, 01 May 2023 06:01:01 -0700 (PDT)
Received: from eg ([2a01:799:1727:1d00:7e7d:d8bc:5837:ddb2])
        by smtp.gmail.com with ESMTPSA id l2-20020a05651c10c200b002a8afccf545sm4695307ljn.127.2023.05.01.06.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 06:01:00 -0700 (PDT)
Date:   Mon, 1 May 2023 15:00:58 +0200
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
Message-ID: <ZE+4Ct7ZMecFy7YV@eg>
References: <ZEV/EzOM+TJomP66@eg>
 <07e05c57-feb7-5482-9c07-eb41f976f9fd@meta.com>
 <ZErK0M/qAi/VS8U8@eg>
 <0e7b884a-05c3-83c7-0de1-9bfe14ff77b3@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e7b884a-05c3-83c7-0de1-9bfe14ff77b3@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 27, 2023 at 06:19:29PM -0700, Yonghong Song wrote:
>
>
> On 4/27/23 12:19 PM, Espen Grindhaug wrote:
> > On Wed, Apr 26, 2023 at 02:47:27PM -0700, Yonghong Song wrote:
> > >
> > >
> > > On 4/23/23 11:55 AM, Espen Grindhaug wrote:
> > > > This change fixes the handling of versions in elf_find_func_offset.
> > > > In the previous implementation, we incorrectly assumed that the
> > >
> > > Could you give more explanation/example in the commit message
> > > what does 'incorrectly' mean here? In which situations the
> > > current libbpf implementation will not be correct?
> > >
> >
> > How about something like this?
> >
> >
> > libbpf: Improve version handling when attaching uprobe
> >
> > This change fixes the handling of versions in elf_find_func_offset.
> >
> > For example, let's assume we are trying to attach an uprobe to pthread_create in
> > glibc. Prior to this commit, it would fail with an error message saying 'elf:
> > ambiguous match [...]', this is because there are two entries in the symbol
> > table with that name.
> >
> > $ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep pthread_create
> > 0000000000094cc0 T pthread_create@GLIBC_2.2.5
> > 0000000000094cc0 T pthread_create@@GLIBC_2.34
> >
> > So we go ahead and modify our code to attach to 'pthread_create@@GLIBC_2.34',
> > and this also fails, but this time with the error 'elf: failed to find symbol
> > [...]'. This fails because we incorrectly assumed that the version information
> > would be present in the string found in the string table, but there is only the
> > string 'pthread_create'.
>
> I tried one example with my centos8 libpthread library.
>
> $ llvm-readelf -s /lib64/libc-2.28.so | grep pthread_cond_signal
>     39: 0000000000095f70    43 FUNC    GLOBAL DEFAULT    14
> pthread_cond_signal@@GLIBC_2.3.2
>     40: 0000000000096250    43 FUNC    GLOBAL DEFAULT    14
> pthread_cond_signal@GLIBC_2.2.5
>   3160: 0000000000096250    43 FUNC    LOCAL  DEFAULT    14
> __pthread_cond_signal_2_0
>   3589: 0000000000095f70    43 FUNC    LOCAL  DEFAULT    14
> __pthread_cond_signal
>   5522: 0000000000095f70    43 FUNC    GLOBAL DEFAULT    14
> pthread_cond_signal@@GLIBC_2.3.2
>   5545: 0000000000096250    43 FUNC    GLOBAL DEFAULT    14
> pthread_cond_signal@GLIBC_2.2.5
> $ nm -D /lib64/libc-2.28.so | grep pthread_cond_signal
> 0000000000095f70 T pthread_cond_signal@@GLIBC_2.3.2
> 0000000000096250 T pthread_cond_signal@GLIBC_2.2.5
> $
>
> Note that two pthread_cond_signal functions have different addresses,
> which is expected as they implemented for different versions.
>
> But in your case,
> > $ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep pthread_create
> > 0000000000094cc0 T pthread_create@GLIBC_2.2.5
> > 0000000000094cc0 T pthread_create@@GLIBC_2.34
>
> Two functions have the same address which is very weird and I suspect
> some issues here at least needs some investigation.
>

I am no expert on this, but as far as I can tell, this is normal,
although much more common on my Ubuntu machine than my Fedora machine.

Script to find duplicates:

nm -D /usr/lib64/libc-2.33.so | awk '
{
    addr = $1;
    symbol = $3;
    sub(/[@].*$/, "", symbol);

    if (addr == prev_addr && symbol == prev_symbol) {
        if (prev_symbol_printed == 0) {
            print prev_line;
            prev_symbol_printed = 1;
        }
        print;
    } else {
        prev_symbol_printed = 0;
    }
    prev_addr = addr;
    prev_symbol = symbol;
    prev_line = $0;
}'


> Second, for the symbol table, the following is ELF encoding,
>
> typedef struct {
>         Elf64_Word      st_name;
>         unsigned char   st_info;
>         unsigned char   st_other;
>         Elf64_Half      st_shndx;
>         Elf64_Addr      st_value;
>         Elf64_Xword     st_size;
> } Elf64_Sym;
>
> where
> st_name
>
>     An index into the object file's symbol string table, which holds the
> character representations of the symbol names. If the value is nonzero, the
> value represents a string table index that gives the symbol name. Otherwise,
> the symbol table entry has no name.
>
> So, the function name (including @..., @@...) should be in string table
> which is the same for the above two pthread_cond_signal symbols.
>
> I think it is worthwhile to debug why in your situation
> pthread_create@GLIBC_2.2.5 and pthread_create@@GLIBC_2.34 do not
> have them in the string table.
>

I think you are mistaken here; the strings in the strings table don't contain
the version. Take a look at this partial dump of the strings table.

	$ readelf -W -p .dynstr /usr/lib64/libc-2.33.so

	String dump of section '.dynstr':
		[     1]  xdrmem_create
		[     f]  __wctomb_chk
		[    1c]  getmntent
		[    26]  __freelocale
		[    33]  __rawmemchr
		[    3f]  _IO_vsprintf
		[    4c]  getutent
		[    55]  __file_change_detection_for_path
	(...)
		[  350e]  memrchr
		[  3516]  pthread_cond_signal
		[  352a]  __close
	(...)
		[  61b6]  GLIBC_2.2.5
		[  61c2]  GLIBC_2.2.6
		[  61ce]  GLIBC_2.3
		[  61d8]  GLIBC_2.3.2
		[  61e4]  GLIBC_2.3.3

As you can see, the strings have no versions, and the version strings
themselves are also in this table as entries at the end of the table.

> >
> > This patch reworks how we compare the symbol name provided by the user if it is
> > qualified with a version (using @ or @@). We now look up the correct version
> > string in the version symbol table before constructing the full name, as also
> > done above by nm, before comparing.
> >
> > > > version information would be present in the string found in the
> > > > string table.
> > > >
> > > > We now look up the correct version string in the version symbol
> > > > table before constructing the full name and then comparing.
> > > >
> > > > This patch adds support for both name@version and name@@version to
> > > > match output of the various elf parsers.
> > > >
> > > > Signed-off-by: Espen Grindhaug <espen.grindhaug@gmail.com>
> > >
> > > [...]
