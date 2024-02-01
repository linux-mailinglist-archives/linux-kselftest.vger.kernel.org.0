Return-Path: <linux-kselftest+bounces-3956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE87846385
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 23:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68111F2579B
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 22:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C7141202;
	Thu,  1 Feb 2024 22:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hCaxP0ny"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9181840C15
	for <linux-kselftest@vger.kernel.org>; Thu,  1 Feb 2024 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827072; cv=none; b=d00fDx5a9Fq+vsLqbhTKo+cL9QgzlvBZD6IVcpr7IBE4DH9RGiZL9cZOfzEuOlNgoZAeeWgreET+9VporhlqAZ7ZWYWxtTiWDLW9LYKEptFBr+4caCk77zQjU6y6qSWiMXDzGfXhgihXj6TnApYDvw6BwWR88kuBn87fYl7DhDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827072; c=relaxed/simple;
	bh=9yIwFf6/pa2yEKL8hInept++VhBkk1WGuFw22mE/WcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=TLNAybuWi++i8U1JjF/ewGAl/IZXbZzP06kV8nAjVqiiaT9iAAB6fCmgHVgi6j066kh0hjeZjCQCvWdiQw+1+VcXebPmIWlLxokJRBmg8Z3Dg0E3oyvkPP6kS77b+VUeEYM+zmKDXcCccn9F/4pizX6zPAmXi2lH7zYrpMPnTKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hCaxP0ny; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbbc6bcc78so1032626b6e.1
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Feb 2024 14:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706827067; x=1707431867; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmoKB9U9mw3t4FpnGtJps1mksky8tREvppcYUjjJHJs=;
        b=hCaxP0nyY9pgaZWKYE3aTnwHUpi0axiowGdpUByErW3qe1PkYpZAw4tYBA7yecZklw
         6JDM5OnklC6i+4MIj/heypc8b9uSaiO3oAVwao+O4Kl+055HzYBsqvtgO7kif21DOqTU
         G7mYtBMx+SVUtpDO4p9eIkHEkvNi9zk4k8GhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706827067; x=1707431867;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmoKB9U9mw3t4FpnGtJps1mksky8tREvppcYUjjJHJs=;
        b=HSwEPWa9xicazA8ThMVfLxjfzg1GbGUItlwPFOqJ6PGNjebYA5NkBhiAnxF1qwuYwN
         OVWrfqTxOoLXXYnLpXTiTzydpv5zaM9dsrQRtYK2cUpglttIG3iYIxkveb2ava8iOIyK
         O9hxjAv29bNgDErT2eR5Sw2rUesEZhrXBkXLsrJ4LAcrFC+4CXbI5WDGP/jG08eTqZml
         fTafw/DdsRf8c3ec6rzmArZT8bg4Q4PPKDZMjAYaDHvspVwXGb77z+8Id/mh3IoGM78E
         zYspT7h0s6xYRJOLju12WXu1Xd5N8/nFPezqdGpubt/bgaj3+qY01224xsDVCUxw9NT/
         c75A==
X-Gm-Message-State: AOJu0Yw8uiAChPCqrZ+LBo9UyzQcBRWCO5LgqhGn+tK6t+6TOyon9wgS
	A2XztnkMpyu7lRZ4XVNoC9kSSMtWfgmh3CPuBvYFTU9iNmOuOn36KFEHBEHeliSpP2rA3bo04G5
	hauLwHCpfufsi+jwmPj0e/2+FaJ77QsKGFcOp
X-Google-Smtp-Source: AGHT+IFXjJjh4U73XklHRwMqQKC6IUK8yT1QB2L/QSJgxVT2r+D8jpRmpXkJyI8e7UxCR3vkuM3rQ/1eDkoKFGaW8GA=
X-Received: by 2002:a05:6870:f228:b0:210:7f85:c208 with SMTP id
 t40-20020a056870f22800b002107f85c208mr7371815oao.46.1706827067224; Thu, 01
 Feb 2024 14:37:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com> <20240201204512.ht3e33yj77kkxi4q@revolver>
In-Reply-To: <20240201204512.ht3e33yj77kkxi4q@revolver>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 1 Feb 2024 14:37:35 -0800
Message-ID: <CABi2SkWB2eV24LBJtgJ73zEwaAWuFhAwrfqx3Rs=tqnpcJ0qRw@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org, 
	usama.anjum@collabora.com, rdunlap@infradead.org, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 12:45=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
> >
> > I would love to hear more from Linux developers on this.
>
> Linus said it was really important to get the semantics correct, but you
> took his (unfinished) list and kept going.  I think there are some
> unanswered questions and that's frustrating some people as you may not
> be valuing the experience they have in this area.
>
Perhaps you didn't follow the discussions closely during the RFCs, so
I like to clarify the timeline:

- Dec.12:
RFC V3 was  out for comments: [1]
This version added MAP_SEALABLE and sealing type in mmap()
The sealing type in mmap() was suggested by  Pedro Falcato during V1. [2]
And MAP_SEALABLE is new to V3 and I added an open discussion in the
cover letter.

- Dec.14
Linus made a set of recommendations based on V3 [3], this is where
Linus mentioned the semantics.

Quoted below:
"Particularly for new system calls with fairly specialized use, I think
it's very important that the semantics are sensible on a conceptual
level, and that we do not add system calls that are based on "random
implementation issue of the day".

- Jan.4:
I sent out V4 of that patch for comments [5]
This version implements all of Linus's recommendations made in V3.

In V3, I didn't receive comments about MAP_SEALABLE, so I kept that as
an open discussion item in V4 and specifically mentioned it in the
first sentence of the V4 cover letter.

"This is V4 of the patch, the patch has improved significantly since V1,
thanks to diverse inputs, a few discussions remain, please read those
in the open discussion section of v4 of change history."

- Jan.4:
Linus  gave a comment on V4: [6]

Quoted below:
"Other than that, this seems all reasonable to me now."

To me, this means Linus is OK with the general signatures of the APIs.

-Jan.9
During comments for V5.
[7]  Kees suggested dropping RFC from subsequent versions, given
Linus's general approval
on the v4.

[1] https://lore.kernel.org/all/80897.1705769947@cvs.openbsd.org/T/#mbf4749=
d465b80a575e1eda3c6f0c66d995abfc39

[2]
https://lore.kernel.org/lkml/CAKbZUD2A+=3Dbp_sd+Q0Yif7NJqMu8p__eb4yguq0agEc=
mLH8SDQ@mail.gmail.com/

[3]
https://lore.kernel.org/all/CAHk-=3DwiVhHmnXviy1xqStLRozC4ziSugTk=3D1JOc8OR=
Wd2_0h7g@mail.gmail.com/

[4]
https://lore.kernel.org/all/CABi2SkUTdF6PHrudHTZZ0oWK-oU+T-5+7Eqnei4yCj2fsW=
2jHg@mail.gmail.com/#t

[5]
https://lore.kernel.org/lkml/796b6877-0548-4d2a-a484-ba4156104a20@infradead=
.org/T/#mb5c8bfe234759589cadf0bcee10eaa7e07b2301a

[6]
https://lore.kernel.org/lkml/CAHk-=3Dwiy0nHG9+3rXzQa=3DW8gM8F6-MhsHrs_ZqWaH=
tjmPK4=3DFA@mail.gmail.com/

[7]
https://lore.kernel.org/lkml/20240109154547.1839886-1-jeffxu@chromium.org/T=
/#m657fffd96ffff91902da53dc9dbc1bb093fe367c

> You dropped the RFC from the topic and increment the version numbering
> on the patch set. I thought it was customary to restart counting after
> the RFC was complete?  Maybe I'm wrong, but it seemed a bit odd to see
> that happen.  The documentation also implies there are still questions
> to be answered, so it seems this is still an RFC in some ways?
>
The RFC has been dropped since V6.
That said, I'm open to feedback from Linux developers.
I will respond to the rest of your email in seperate emails.

Best Regards.
-Jeff

