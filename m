Return-Path: <linux-kselftest+bounces-37779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2460B0CBE2
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 22:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63E816A9A0
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 20:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFCF23B60E;
	Mon, 21 Jul 2025 20:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAX746Cb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298BE22F164;
	Mon, 21 Jul 2025 20:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130043; cv=none; b=r36LqfXPUSmD+RTB2M94cRAR4sJTqqklM20d8uNAYTuVtWr5ekcx20Uwom42/4ddWlJbVLIZhrb3te5VFZmYWTvuuZp2+ZE7wUTD5Prx9+g07vexgBJRgxuy3bub1D2jJ7XHYqUqQZRaXLmGHDnwb7lzGry/2PZgeTxMY5qca/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130043; c=relaxed/simple;
	bh=4Ul1sa4tbosUa9ruhwhtdcqNwp0uQWDOf/7Qd/o2M7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0G5uGSAjDhJTNFHmB05qQz5TSzYfQdHedqzJTJQi3FErxkfUInkCw1gKouGYT3ExERce0piCeCk1KzdY17Fp28fpHqPyHW/CSIbcpYyZa/eoJKw4OtR0IWHu6Uezo83z+5HstmbeuSunEI8DRO0kOj47I8+hJfNI4skIuhRENo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAX746Cb; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-553b5165cf5so5623950e87.0;
        Mon, 21 Jul 2025 13:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753130040; x=1753734840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ul1sa4tbosUa9ruhwhtdcqNwp0uQWDOf/7Qd/o2M7Y=;
        b=TAX746Cb4oCaK0LqA9/MfgYLwK5fIvJj12IQDFyoV4dNK2EeKpTpKAQmvdt/iqGJpi
         0gQCae3lLLf1afL+0DSTMdKOgD/QNMyJ69zRWZl6DLkDScvr+BYPZyR+d7eq22IM2yoL
         bCvST8CA7EX59qwXcpi5Nvg6ouBLVjE9B1rOP7a6rkzNfGWZOXXFffQOrytC+UkfJxGP
         I5fz55CypA+mJ93MNXYRaXGDJtEa3EghZ5WCxkwMbdJbgC4LOHj9MhYNzcFy1KcWJmVF
         tIJM/fdNlUL8Qgyxqgl4kYy9JQXBtsCkhG7w4VX+6yeATpjCKh4Tcm3rXygoXhADks96
         tHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130040; x=1753734840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Ul1sa4tbosUa9ruhwhtdcqNwp0uQWDOf/7Qd/o2M7Y=;
        b=av1UfpjOOjvFTcSacG5qRFLHp0RcPyfbZZlWo8W12iGp1AOLvBzDx8iiFEOJWPTqPw
         xNzS47ZzPEz2SIfOHb4itU9CCP8DUxPjxhOak5mj3b1QEjqIb5hJXfbgmZwOqPEaK6rR
         3+gyhQWUXgFMGTrhv79t+8DQ7intbXRgSfv7ye3iyom/hAuyaHlbzCBZY6EdY7+4jcjb
         Vj5uK2SgMkfawiqMSjPwWDMzXdrp3cTsRR1zWkhSrVsY+I72LKG8dowDtPGRqL9eUXnA
         NGVidmLjeXazYAuurLs0WL7+Cydwh59Rz+ZQoPPrpLHTDoz7je4Hl0MWUyZ/0UBK+AIB
         NRZA==
X-Forwarded-Encrypted: i=1; AJvYcCVQQMrQySFEnzx5rV8RceTLEGoUX+f8QxT3rwZB4qHhI8FUPmn4ij3nMbO4RAM6ZD5VqEeYjCxEIQFXdYCa+PI=@vger.kernel.org, AJvYcCWVaoqEVhmILAKTVqQHZfBs0Am//bmPEdJHAeGng8OFPcnbxWrT8oSQn+yvh2t7iFwKVMzH7O1Jv5IKc3XZ@vger.kernel.org, AJvYcCXG05KfCoLRwpSDob17mm64p5jYJQbr//z01Uubh6oll2JStcWh9SqgIP5KiYgC9ZkWfOA1Rr9RYb1xRw==@vger.kernel.org, AJvYcCXv+e0qqgPQqHdIVoJkXBOh9fIR2uZpqNsqXxmtzZNILP+ohXqB2Gj0Szf5fTGKat/zzJCod2aRBrQTd5S9fvCn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+vlpPYrtUM8uaux2CDHHChC7n+w98s6gBNiXqJVceFGv/zZU3
	RRefDBwY5dmV0NQrIoziAPykggh0rnOivZUIRfR8W7lLWyeaBiXo/candqeZsd9h8wyeqaMIOkA
	r8FoHRCZzIuC9tuBybLt5rv5VSO2QXko=
X-Gm-Gg: ASbGncsABvKZbxK4xUre8ZIqpI6nmBsexNgXsBprgPHXRFe3MTarRUDu7m4OBcR573c
	94e/88ngeXDIDSevBLT66ENIrYf6MGNFwKwtjh1ZDiBOEm2Q8Xn65BnPZv0/EAEHVoL2aMWc7R/
	pCv831uj/HBadxhaBSeqkEEB5XHvq14Rv4bEqAA3KIDQ3/oNWFVv4D1Qv8ow1lrTRSbu+B4YbpZ
	JEpZz7Q
X-Google-Smtp-Source: AGHT+IH6A989z7ThsmWhcmnfnAuNOS7u4N0waP3LiQaOQAG3vGt/H7R2XFVf4RgsPjVfbzK8xHrD35QxEhunVNnKS14=
X-Received: by 2002:a05:6512:1313:b0:54a:cc76:1676 with SMTP id
 2adb3069b0e04-55a233d987cmr6580162e87.44.1753130040075; Mon, 21 Jul 2025
 13:34:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250719-core-cstr-fanout-1-v2-0-1ab5ba189c6e@gmail.com> <CANiq72nxL9RORJA-w=rtnkwMKcXcLva3dGbMDLc71o1bqAHUsw@mail.gmail.com>
In-Reply-To: <CANiq72nxL9RORJA-w=rtnkwMKcXcLva3dGbMDLc71o1bqAHUsw@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 21 Jul 2025 16:33:23 -0400
X-Gm-Features: Ac12FXwowT4js33aAd4KV3lt6ZaqxKq6jdaJgK1Y7dU7h4bgb1eTladvHGZwSF0
Message-ID: <CAJ-ks9kQNDK5iNNT_wA_jrupiPepWhpqjE=cBQR61tgVP+5UZw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] rust: use `kernel::{fmt,prelude::fmt!}`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 4:25=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sun, Jul 20, 2025 at 12:42=E2=80=AFAM Tamir Duberstein <tamird@gmail.c=
om> wrote:
> >
> > Subsystem maintainers: I would appreciate your `Acked-by`s so that this
> > can be taken through Miguel's tree (where the other series must go).
>
> Same here as in step 2b/5, i.e. Danilo's Acked-by was picked up for
> things he didn't Acked-by.

Yes, you are right.

>
> I imagine it was automatically done by `b4`, but that is why we need
> to be careful about automatically applying tags. I am mentioning this
> mainly to confirm I am not confused and to avoid forgetting about it,
> and also I hope it helps if you eventually apply patches yourself,
> e.g. if you eventually take care of a branch yourself.

You're not confused, and I appreciate you calling it out. I'll look
out for this kind of thing in the future.

Thanks Miguel.
Tamir

