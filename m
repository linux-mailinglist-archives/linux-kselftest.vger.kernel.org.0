Return-Path: <linux-kselftest+bounces-11690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B04B904208
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 18:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 259ED28DD94
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 16:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E36856B72;
	Tue, 11 Jun 2024 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brD3ms6z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B7654F8C;
	Tue, 11 Jun 2024 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718125042; cv=none; b=ZlvJJKdpti2kh7TGw30MwyYA7w93bSAaR3eCufIXfSzWEapsxQdeUDQhLyjgOr/2gL9juX+5KQpj8YaaMeUP4c8DNzz2RARcRHereBqpZTs7QrW+3sDH+WvElBer7HfIL/NUkitz5N33OU5PkFrwIseMOkbf4R4VTFTNXPcBKo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718125042; c=relaxed/simple;
	bh=tHF+I96GJM1DzMeNe73SXmMclgaDAk6heGWpVzWBfTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5vDwyonZ9qyHwYs3NFVB5tw4FtJivTcZU5lP4mfasMmTX6Shjkt/JGhJiQ5mWZIB83X5TYLhhvSHyucGQCjlJdNRb/gaf1Cay6iwN+E+OGLIJ7Ag7HbDqSiXNv5qdhlxZLnMMMbD4XFvsMYka51FxK8x4kbT8gipq90AR6TqW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brD3ms6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5479BC2BD10;
	Tue, 11 Jun 2024 16:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718125041;
	bh=tHF+I96GJM1DzMeNe73SXmMclgaDAk6heGWpVzWBfTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=brD3ms6zQ1YOwd+qZdO7hJFbRuL5RewFTcIduEDgHxJi+AszN70l5plDVBVOOeGYB
	 bPJTKc39Jll+ArjvI8Bd6q0h5ayJ22AK9QIiGO/AIFj+npQPi6g7aVEwM7wKQ5s8Et
	 xx3yE1vcjcPCCfOPMkbumaO/uPIEeL3T3mWYPlHYiDzFsnSPaiAHRMEgIMex9w/E/4
	 GoHGojEfMX65I+E0f+Z59Xn4OJuBuBbET0OjcYAVSR78et+FAnseJOoEXKD/qUi3Dl
	 s5lf6xNqdFoTjLXV1B3MjBymNHKHvdgQj/X16puDSz9K933USqNV6ts7vW1pL1DJoi
	 y3ubVi1cI0wvg==
Date: Tue, 11 Jun 2024 18:57:16 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH HID v3 15/16] HID: bpf: rework
 hid_bpf_ops_btf_struct_access
Message-ID: <lqyoauxovbelrzbnohxqc7tluibn72vqlps4lz4dxsxmgpyli3@qwzt4etxntyj>
References: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
 <20240608-hid_bpf_struct_ops-v3-15-6ac6ade58329@kernel.org>
 <CAADnVQLCyEZMyThCH6QNopBbWbNcpR+h2AaLhT0apEO7pOWrRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLCyEZMyThCH6QNopBbWbNcpR+h2AaLhT0apEO7pOWrRQ@mail.gmail.com>

On Jun 10 2024, Alexei Starovoitov wrote:
> On Sat, Jun 8, 2024 at 2:01 AM Benjamin Tissoires <bentiss@kernel.org> wrote:
> >
> > The idea is to provide a list of stucts and their editable fields.
> >
> > Currently no functional changes are introduced here, we will add some
> > more writeable fields in the next patch.
> >
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> >
> > ---
> >
> > changes in v3:
> > - rewrote WRITE_RANGE macro to not deal with offset from the caller side
> >
> > new in v2
> > ---
> >  drivers/hid/bpf/hid_bpf_struct_ops.c | 91 +++++++++++++++++++++++++++---------
> >  1 file changed, 69 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
> > index 056d05d96962..b14eccb121e0 100644
> > --- a/drivers/hid/bpf/hid_bpf_struct_ops.c
> > +++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/hid_bpf.h>
> >  #include <linux/init.h>
> >  #include <linux/module.h>
> > +#include <linux/stddef.h>
> >  #include <linux/workqueue.h>
> >  #include "hid_bpf_dispatch.h"
> >
> > @@ -52,40 +53,86 @@ static int hid_bpf_ops_check_member(const struct btf_type *t,
> >         return 0;
> >  }
> >
> > +struct hid_bpf_offset_write_range {
> > +       const char *struct_name;
> > +       u32 struct_length;
> > +       u32 start;
> > +       u32 end;
> > +};
> > +
> >  static int hid_bpf_ops_btf_struct_access(struct bpf_verifier_log *log,
> >                                            const struct bpf_reg_state *reg,
> >                                            int off, int size)
> >  {
> > -       const struct btf_type *state;
> > -       const struct btf_type *t;
> > -       s32 type_id;
> > +#define WRITE_RANGE(_name, _field, _is_string)                                 \
> > +       {                                                                       \
> > +               .struct_name = #_name,                                          \
> > +               .struct_length = sizeof(struct _name),                          \
> > +               .start = offsetof(struct _name, _field),                        \
> > +               .end = offsetofend(struct _name, _field) - !!(_is_string),
> 
> so it works because char name[128]; had last byte as zero
> before prog writes into it (in addition to potentially having
> earlier 0 bytes), so the string is guaranteed
> to be null-terminated regardless of what prog writes into it.
> Right?

Yeah, struct hid_device is created through hid_allocate_device(), which
does a kzalloc. Then all operations are supposedly safe in the current
transport layers, so the last byte should always be \0.

> 
> Overall:
> Acked-by: Alexei Starovoitov <ast@kernel.org>

Thanks a lot.

I might send a v4 or not depending if I get other reviews, but I'll make
sure to take your nitpick in 3/16 into account (cast kdata/udate in the
beginning of the function to make the lines shorter and less verbose).

Cheers,
Benjamin

