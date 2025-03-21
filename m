Return-Path: <linux-kselftest+bounces-29575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 030C0A6C0B0
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 17:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65702173985
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 16:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A8822D7BA;
	Fri, 21 Mar 2025 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOBvVxl6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0410522D7A3;
	Fri, 21 Mar 2025 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742576056; cv=none; b=Tav6eigutfMppbmedTwKpVi9S0jNOHUrECWBNWvPYAj8AyCrH9/crDo4kLuSI2XSo/CX5s4DxpK1eo32WPZ4JI4KDMCenAB5ghN/Y1P1113gd8Djdm+riHqBvO/gv+MzRdzprOunmANCEq8y4N2CxER25/vmPdcwAesyVRXOZWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742576056; c=relaxed/simple;
	bh=UOuUAOdU6fzwILEwoTUwQrZ3IxBywdm7PqAVnZyzNrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jrgj8FyaS1jnSyBPGdoXMGFqk4Jvos1TJP7YvvxSp1e0tWIG2qFwWlufhunVed36qUE9b9ahJ+CU0V1QLRXQaTc79fo5aSvltx/cnJldLJGBoNjzOfs1lUO/2JxDbvQb2V2BWoFIB7g6iKWJKM736uHE3WA2UVzPnWBqW7KPk6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOBvVxl6; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30613802a04so23839261fa.2;
        Fri, 21 Mar 2025 09:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742576053; x=1743180853; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UOuUAOdU6fzwILEwoTUwQrZ3IxBywdm7PqAVnZyzNrk=;
        b=JOBvVxl6Vde0N4Bm2kv6VGe/Xk+jPiCbd1TAvk0jtQy+FufC706GIjMSgYf9FRPMsp
         JjW2Ce7FWtr36shqr+Do1faBLRJX1CCUO37qXQ4YXFqfNmoor1Tc60OWuZitXODCQP/r
         t/azjwCZrznsBgCGBIFt5YVhhGuJnES0hz80mPvkvhr0i8Z8iYxPI5bwHu95czw2Sb9C
         DhZoC3n6/1XeG/R7yGV1i12HteQ45v1tQcuAVp1AvN2oXRvNFVHn+Ldp/jrzUC2WupsB
         vmo7OHHfcjjtwQomaGUf6NzA6nggiINNjJATlU7y1/GkkEDag/k86Wodt0S98Dx4433d
         hRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742576053; x=1743180853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UOuUAOdU6fzwILEwoTUwQrZ3IxBywdm7PqAVnZyzNrk=;
        b=MQ7HYHz+WQvtUe2g12RRHmujzot4iRF6t3e8mo3Diuey3z1YSHwiQYz7+l4sqgz2Qb
         5W5slYwykM0QmgHTW7KK4kSvKvebDmx06CwBSa31q2GolkhhUr/GgeuXZXF+VRPP0VN0
         gUPERUOK/em/yUuRGoNDP1tXUDbhHyhGiuL8/0Amb7hiT8vvosxleiF+mR5sWddlDiFT
         ctJQ8jq/D+zM3SvpphdbvmkIgdOOiFG2SPSO2vTShcIJAHDEVwJA6W2r/1Tx+bKbyqlX
         GQslty6P5fKrVJD3WVqwcF0qYhWFV37xV98FgM2C7YWrf1XMrXHyvsZxP0FZgKH6qDEq
         yy1w==
X-Forwarded-Encrypted: i=1; AJvYcCUCtszRXmBpmUem8C3aBGC23JnWh/DC2RGUWCafACiGuIPYtjjM7avhlnsD++xNGemfe9WjXr/Jb1eVjDk=@vger.kernel.org, AJvYcCUEqyaHypGHOIAJgkhjKnpEyKzQbGhB9IvzHd6oszyZpB6RxDF5YS+eTUhsLWBrK57gGLHvA7lYmBzEBm6d/40t@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+1NKyFQzVJ2FHvKuYX4LyLl2eMZj4bILvKwFhFF6OYEJBIlFe
	Jc3qJ6HMuDbpFBPozMg04Eh97bsz/lbqhGcaIH0HyCJWyuR68B9Hvjrm2HWWkAsnUJBGRIvBFma
	gZn2Kp1r4i+1xtyC09FVx/AYkBEs=
X-Gm-Gg: ASbGncurLdftT1XxI2ZCsQNMbm0vQcC8NVOmmgkpo6YxddUe5tz9akY/CyXdfPxYAXy
	h7vtfIi9vy1E7ywPxjvRl56FQTn5kbTifrGyL/Z9Ra3mEFKDl3gRPqFq2KQhF+WOCTbOv9okUP5
	ulq1caLe9Cz6QBD5bF6qn1fkmUalKGVx332Wa0RmqMGw==
X-Google-Smtp-Source: AGHT+IG4olNJH+a7c6RlZFJF8zMksT58/wvmA/7TP25sQDIbCAdnPDYZgYQ8vKGk1x10x0tRVyTKoEGU45fo+N4bqok=
X-Received: by 2002:a2e:8e73:0:b0:30b:b7c3:949a with SMTP id
 38308e7fff4ca-30d7e2383b9mr16939331fa.18.1742576052901; Fri, 21 Mar 2025
 09:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-bitmap-kunit-convert-v1-0-c520675343b6@gmail.com>
 <Z6eaDuXnT_rjVSNS@thinkpad> <CAMuHMdUsq_39kgBa8oanXeTzv44HuhS1e5MK7K2jxkVXQ7uWdw@mail.gmail.com>
 <bd71c705-5f57-4067-b200-fd80b98ddbc9@nvidia.com> <Z6pfomw-3LuWoQQo@thinkpad> <CABVgOS=KZrM2dWyp1HzVS0zh7vquLxmTY2T2Ti53DQADrW+sJg@mail.gmail.com>
In-Reply-To: <CABVgOS=KZrM2dWyp1HzVS0zh7vquLxmTY2T2Ti53DQADrW+sJg@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 21 Mar 2025 12:53:36 -0400
X-Gm-Features: AQ5f1JocXlnKOaYntHf6DffQI-TKvt-QvytM7DCEc6s7gdq0Tj17rR69Ljw6v-g
Message-ID: <CAJ-ks9mevv68v1Mh0GdGd9Y2EEp3_kdV6FygOiAenYG0=e4=Tw@mail.gmail.com>
Subject: Re: distro support for CONFIG_KUNIT: [PATCH 0/3] bitmap: convert
 self-test to KUnit
To: David Gow <davidgow@google.com>
Cc: Yury Norov <yury.norov@gmail.com>, John Hubbard <jhubbard@nvidia.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org, Brad Figg <bfigg@nvidia.com>, 
	David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Hi all, now that the printf and scanf series have been taken via kees'
tree[0] and sent in for v6.15-rc1[1], I wonder if we'd like to revisit
this discussion.

As I understand it, the primary objections to moving bitmap to KUnit were:
- Unclear benefits.
- Source churn.
- Extra dependencies for benchmarks.

Hopefully David's enumeration of the benefits of KUnit was compelling.
Regarding source churn: it is inevitable, but I did pay attention to
this and minimized the diff where possible.

The last point is trickiest, because KUnit doesn't have first-class
benchmark support, but nor is there a blessed benchmark facility in
the kernel generally. I'd prefer not to tie this series to distros
enabling KUNIT_CONFIG by default, which will take $time.

I think the most sensible thing we can do - if we accept that KUnit
has benefits to offer - is to split test_bitmap.c into
benchmark_bitmap.c and bitmap_kunit.c.

Please let me know your thoughts.
Tamir

[0] https://web.git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=move-lib-kunit-v6.15-rc1
[1] https://lore.kernel.org/all/202503170842.FFEE75351@keescook/

