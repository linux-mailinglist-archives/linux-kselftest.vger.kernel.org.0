Return-Path: <linux-kselftest+bounces-37325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B09E9B05084
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 06:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167091AA6F86
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 04:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1955E2D3EDC;
	Tue, 15 Jul 2025 04:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0tNfTw63"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678E12D3EE0
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Jul 2025 04:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752555166; cv=none; b=k+W+3TV7cdHBnTP31eNEnF512cFWwUALAcwktoGulaXMW9VFcbypp4CN1OnKACZ+sw9SN5noWDWw9Bbq1/q/7KkAFhUQWzGvXXsqPFNLNSVbM/7HrvyyLrl1SnuX6vOxXul4C2LxkDrbPS8eE9ycyU6s+q+jcb9W4Mdnl9UOeyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752555166; c=relaxed/simple;
	bh=BxTI/XChBwRPVd/lpnjOnhO+7Id5XPqsDPrvgCog6pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPprpgc5VF5E7O+AFory7dz+uzUPOKNZxy9Moxths0vJhessYnXMMba7ssfTyqeUJBOqqyFpKdX/lvcTdqJJkBw51IGcd7y/IKabVLF9nELstxzrtKWC2HD+OO841bjLKBdOQd6JZzcnCO/rWeykIgIJ23wX5cPIX1NHBKeO8qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0tNfTw63; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso238001cf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 21:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752555163; x=1753159963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BxTI/XChBwRPVd/lpnjOnhO+7Id5XPqsDPrvgCog6pw=;
        b=0tNfTw63bk0gDsBcniPOUUaz3Pp2YV/7S3uEeA4HG1VU0qCi9XABynmKQc2q459Alo
         M/f9ga4bdI0m4Rv5NAjtjORCRmLZg6ueFZKqRFO0SmTufKQsVjd/F03gMlo/jLNN7OfU
         0ixbLRjFplgqAUEqIzd3CLAJgzoV093OrvhM0kOU7kIILRlP7m/fzmFVHL6cl5Z2//di
         JXm+gQhX9Me/FUwBWmfW80eNUmsCUvZ0V3aKy2lOCFdZXONvjhp7CjaGrk7v6cPT0xzW
         rfj93WdTpFfjgMriWNNcyD1pQ/4gup++X+o+3c/hFd7o2PJJtg175Hsjaw9JmoBodTr9
         7oBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752555163; x=1753159963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BxTI/XChBwRPVd/lpnjOnhO+7Id5XPqsDPrvgCog6pw=;
        b=fNXJ2gq8rSxt2eDTujNw6CDQTwb1Ghz5tkCHm1p0adlL1nICiS8WfY/iLM82lIuz+z
         YDsqU+JMxlK3yoweekjI5hpx/d586+oMj+m8gtNiy+4bjGubdPkF4lx9H6pGG5ruF1LI
         LLt/LbIZ6rtFfSXooHtdBDJOFoPxxbMRnXkpfqkDgzTxjX/qge8yYkiLzsh/yiHvtp41
         dw6qYcaz3b5qoaU0ChAx+a9Azm1XE0nrycRP3GQ0AOt0pU/lLUisPGfQWoE8Ah7a34Wg
         Tn4vkERbhmWCCx6nnS1pTce3rkUKHFAtYjPWIvKOP+d8MQ/CWUB005d8xt66RgiYo7ua
         K0Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUhEp2Tbd8ISpA+5QYONM2WcB/wpWzuZK3XUPNXy2ROPN1fwzxPxeIDXURrthQvb2Ly0+Zw1hOw/qp1f+ayA3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMb5fq2qm6dIKertUZm1SkGFu4+Q3xha3j26cIhDSr3d02fGcJ
	EuWVOa8SBOqEsPJnQZAoB3lwUJ6zNQ5xcyHPO8DwZryw/+/6LbbudXe+9g5zv0/SYYo6qr3tXTM
	8oGwgA8Kheo18M3Xf+S5Z69KW5gfdKewPHKYiOvqS
X-Gm-Gg: ASbGncvxzNoXLXoiVLXWXYq75Gq+/1zhpDddy2rlrHwbAJW63VspqPvJ8PRG025I+PE
	kquEfh+Lb7YVgCW0dsmbovd1gUX/d+IdPaHNPsjddDF7IK50ZU7nqZAOn+2qiDuy2R9TSLE+p+v
	5N0iWsUJcXngLUuv0BLV2vcIyU5Lxz362/n8QVPQXgsiN8gEQsovK7YbhWzi6r7Lc8RHvib8gqe
	E5arQ==
X-Google-Smtp-Source: AGHT+IFUhtmXQZiFx0HnrQznPC6IHTh4TbC7da33DxdEZqwkXlBLL3dZed+VclptZNoBrX9qvm4zJO2cyCsQb0zu0TQ=
X-Received: by 2002:ac8:7dc8:0:b0:4a9:a4ef:35c2 with SMTP id
 d75a77b69052e-4ab8293b386mr1488711cf.23.1752555163096; Mon, 14 Jul 2025
 21:52:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714185321.2417234-1-ynaffit@google.com> <20250714185321.2417234-7-ynaffit@google.com>
In-Reply-To: <20250714185321.2417234-7-ynaffit@google.com>
From: Carlos Llamas <cmllamas@google.com>
Date: Mon, 14 Jul 2025 21:52:30 -0700
X-Gm-Features: Ac12FXxjkWr-PhLv_CrnQtbWXbuLd4c2lXNM0HkAQBusanbPr2cAK6HGaGFz8Tc
Message-ID: <CAFuZdDJRuQOhQQN79cgNERJQnMuOkQx4W-eTGcotCCUMk5HULA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] binder: encapsulate individual alloc test cases
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, keescook@google.com, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, Jul 14, 2025 at 11:53:19AM -0700, Tiffany Yang wrote:
> Each case tested by the binder allocator test is defined by 3 parameters:
> the end alignment type of each requested buffer allocation, whether those
> buffers share the front or back pages of the allotted address space, and
> the order in which those buffers should be released. The alignment type
> represents how a binder buffer may be laid out within or across page
> boundaries and relative to other buffers, and it's used along with
> whether the buffers cover part (sharing the front pages) of or all
> (sharing the back pages) of the vma to calculate the sizes passed into
> each test.
>
> binder_alloc_test_alloc recursively generates each possible arrangement
> of alignment types and then tests that the binder_alloc code tracks pages
> correctly when those buffers are allocated and then freed in every
> possible order at both ends of the address space. While they provide
> comprehensive coverage, they are poor candidates to be represented as
> KUnit test cases, which must be statically enumerated. For 5 buffers and
> 5 end alignment types, the test case array would have 750,000 entries.
> This change structures the recursive calls into meaningful test cases so
> that failures are easier to interpret.
>
> Signed-off-by: Tiffany Yang <ynaffit@google.com>
> ---

Great job here. Thanks!

Acked-by: Carlos Llamas <cmllamas@google.com>

