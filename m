Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFADE7A0D90
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 20:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239146AbjINSy7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 14:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjINSy7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 14:54:59 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58826CEB
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 11:54:54 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-59bbdb435bfso15030107b3.3
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 11:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694717693; x=1695322493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xk68pDIYGaQdkXvAFGGLllJihcyDuXFD/cYt4QPp8FY=;
        b=iCd6p+4PUGIrDkLVKfY+45AtHn9KSRJfLXqYjWyryyyMrk1n2KxEX64ZnT7165mB7Q
         1g3D1C27utN9JIin1iTbBNXFmt1AmHldVFNw9ALmAVlnn4Igx3DsO21kl2DrYTc8CIn3
         TWcRbUdlIiCkigq9tRKzIRdHF8sgkjqaUArzPl6C1B2rM7YtnJZishe3o9K6xgyjy5Ei
         cBcgvCYuPnYRRRT9koRppwnNV/4KAdI3Fo0Sk46xxw21s4BFVj36fa+ya5n3Z/2Y1HMi
         NddvGD7CF7QsfoGW1CpeU+Ny1KLDDVIkGj4Y2FuAlV+AkSjHF0t0TCJvrFx5U6mN/Pg9
         MvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694717693; x=1695322493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xk68pDIYGaQdkXvAFGGLllJihcyDuXFD/cYt4QPp8FY=;
        b=ciIzjSw3kpf43k6O31XqHQjp+X5c6GwzvVgyuv3qItocC5nExcevYILv4kNfQx0r5f
         9aKGcovQjTLQMamwOit7IYlUlxaVCrn1Jqbn391qPB+ddzjiyiVnRJIvM9bqmTZw3gjq
         XZMkisFVx0vTdLVQMZhU/Yb4sn7jKRSt23beTGXCsefshhSsqZuxiRgRUEV2RiZcFhSp
         ta/Zy85RGTaW7EwMXXOwjqMloXc0q21jCLeo800BdN1KcfU4OAIqdqiJa4RuR4YsDGz3
         HjL7cykezkRM09xJeA7tBJUwAlwadgSUbbenwiqzHeNqrRjJ6YrmzHnLGxNWS6//F4ft
         Hi3A==
X-Gm-Message-State: AOJu0Yx5b7hbwfhzC0ao9jYLnc38AZy+z9S8VY+FhJ1Nk4PCVNUEk34D
        dMBsAxnN1uAAxHW5QIUlquzuhsM+FnmQMGz54cpKrQ==
X-Google-Smtp-Source: AGHT+IFDSlM9UKN9NkhsgECpx2pe7a3wkf2X3yhc6Mo4knngCi6hulry2K96aodnp7ogl7xysjTEerrZmm/bc4LuwBI=
X-Received: by 2002:a25:4293:0:b0:d7e:8175:4fa9 with SMTP id
 p141-20020a254293000000b00d7e81754fa9mr6102142yba.4.1694717693268; Thu, 14
 Sep 2023 11:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230914152620.2743033-1-surenb@google.com> <20230914152620.2743033-3-surenb@google.com>
 <b7f44bff-644b-8aa6-4d0e-8f1dfd6d03d2@redhat.com>
In-Reply-To: <b7f44bff-644b-8aa6-4d0e-8f1dfd6d03d2@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 14 Sep 2023 11:54:42 -0700
Message-ID: <CAJuCfpEbJMqLDXgiDfrH1tn+DS2Wsfb17-UAoUR1e=S+ktTzPA@mail.gmail.com>
Subject: Re: [PATCH 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, peterx@redhat.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 14, 2023 at 11:47=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 14.09.23 17:26, Suren Baghdasaryan wrote:
> > From: Andrea Arcangeli <aarcange@redhat.com>
> >
> > This implements the uABI of UFFDIO_REMAP.
> >
> > Notably one mode bitflag is also forwarded (and in turn known) by the
> > lowlevel remap_pages method.
>
> Sorry to say, but these functions are unacceptably long. Please find
> ways to structure the code in a better way.

Thanks for the comments, guys! I'll address them and will try to break
the functions into smaller pieces.

>
> --
> Cheers,
>
> David / dhildenb
>
