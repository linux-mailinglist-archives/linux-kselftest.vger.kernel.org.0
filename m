Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77ED667130B
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 06:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjARFQI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Jan 2023 00:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjARFQH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Jan 2023 00:16:07 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973B94FCC4;
        Tue, 17 Jan 2023 21:16:05 -0800 (PST)
Date:   Wed, 18 Jan 2023 05:15:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1674018963;
        bh=+iveqw/qm0yQjEUnNI9i+RiUzh20sBeTW2alB5X1ZB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S9IcC1X0aouk3ixY2js450i4XROwis/FmJH/wbHHsiKQb6y1Od1adQA2i3sMv3caV
         glOTjW0N7p7Pe2ktwDX2s2bxBJYQLSBRBkfe/FomBC38VhqetDqSNG6CY1OAozfZED
         4xwnnKTWHuID98FkFIOHFzbzrKzqAUGTAghyHfxk=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Yonghong Song <yhs@meta.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests/bpf: align kbuild messages to standard
Message-ID: <20230118051555.2ud7mrt4tk6q6322@t-8ch.de>
References: <20230118-kbuild-alignment-v1-0-eb5e9fd55c92@weissschuh.net>
 <20230118-kbuild-alignment-v1-1-eb5e9fd55c92@weissschuh.net>
 <bc5beea9-0613-640b-b0dd-e54221c2fc06@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc5beea9-0613-640b-b0dd-e54221c2fc06@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 17, 2023 at 09:02:20PM -0800, Yonghong Song wrote:
> 
> 
> On 1/17/23 7:52 PM, Thomas Weiﬂschuh wrote:
> > The common layout for kbuild messages is as follows:
> > 
> > - 2 spaces
> > - 7 or more characters for the action
> > - 1 space
> > - name of the file being built/generated
> > 
> > The custom message formatting included an additional space in the action
> > part, which leads to misalignments with the rest of kbuild.
> 
> Could you give an example to show the output before/after the patch, and
> how it leads to mis-alignment and why it is a problem?

Before:

  LD      .../linux/tools/bpf/resolve_btfids/resolve_btfids-in.o
  LINK     resolve_btfids
  CHK     kernel/kheaders_data.tar.xz

After:

  LD      .../linux/tools/bpf/resolve_btfids/resolve_btfids-in.o
  LINK    resolve_btfids
  CHK     kernel/kheaders_data.tar.xz

The line starting with "LINK" has the filename "resolve_btfids" one
space character more to the right than the other lines.

It's slightly confusing when scanning the build logs.

> > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > ---
> >   tools/testing/selftests/bpf/Makefile | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index c22c43bbee19..5190c19295d4 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -98,7 +98,7 @@ Q =
> >   msg =
> >   else
> >   Q = @
> > -msg = @printf '  %-8s%s %s%s\n' "$(1)" "$(if $(2), [$(2)])" "$(notdir $(3))" "$(if $(4), $(4))";
> > +msg = @printf '  %-7s%s %s%s\n' "$(1)" "$(if $(2), [$(2)])" "$(notdir $(3))" "$(if $(4), $(4))";
> >   MAKEFLAGS += --no-print-directory
> >   submake_extras := feature_display=0
> >   endif
> > 
